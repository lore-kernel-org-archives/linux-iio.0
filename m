Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54758 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbaJORha (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 15 Oct 2014 13:37:30 -0400
Message-ID: <543EB0D6.9060406@ti.com>
Date: Wed, 15 Oct 2014 12:37:26 -0500
From: Dan Murphy <dmurphy@ti.com>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>,
	<linux-iio@vger.kernel.org>
CC: <jic23@kernel.org>
Subject: Re: [RFC Patch 3/3] iio: heart_monitor: Add TI afe4403 heart monitor
References: <1413314032-923-1-git-send-email-dmurphy@ti.com> <1413314032-923-4-git-send-email-dmurphy@ti.com> <543E23B4.6080206@intel.com>
In-Reply-To: <543E23B4.6080206@intel.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Daniel

Thanks for the review

On 10/15/2014 02:35 AM, Daniel Baluta wrote:
>
>
> On 10/14/2014 10:13 PM, Dan Murphy wrote:
>> Add the TI afe4403 heart rate monitor.
>> This device detects reflected LED
>> wave length fluctuations and presents an ADC
>> value to the user space to be converted to a
>> heart rate.
>>
>> Data sheet located here:
>> http://www.ti.com/product/AFE4403/datasheet
>
> <snip>
>
>> +obj-y += heart_monitors/
> s/heart_monitors/heart_monitor

Yeah that aligns with the rest of the directories in iio.  Singular not plural

>
>>   obj-y += humidity/
>>   obj-y += imu/
>>   obj-y += light/
>> diff --git a/drivers/iio/heart_monitors/Kconfig b/drivers/iio/heart_monitors/Kconfig
>> new file mode 100644
>> index 0000000..7060694
>> --- /dev/null
>> +++ b/drivers/iio/heart_monitors/Kconfig
>> @@ -0,0 +1,16 @@
>> +#
>> +# Heart Rate Monitor drivers
>> +#
>> +# When adding new entries keep the list in alphabetical order
>> +
>> +menu "Heart Rate Monitors"
>> +
>> +config AFE4403
>> +    tristate "TI AFE4403 Heart Rate Monitor"
>> +    depends on SPI
>> +    select IIO_BUFFER
>> +    select IIO_TRIGGERED_BUFFER
>> +    select SYSFS
>> +    help
>
> Final version should contain a real help here.

It will this was just a place holder for RFC

>
>> +
>> +endmenu
>> diff --git a/drivers/iio/heart_monitors/Makefile b/drivers/iio/heart_monitors/Makefile
>> new file mode 100644
>> index 0000000..77cc5c5
>> --- /dev/null
>> +++ b/drivers/iio/heart_monitors/Makefile
>> @@ -0,0 +1,6 @@
>> +#
>> +# Makefile for IIO Heart Rate Monitor drivers
>> +#
>> +
>> +# When adding new entries keep the list in alphabetical order
>> +obj-$(CONFIG_AFE4403) += afe4403.o
>> diff --git a/drivers/iio/heart_monitors/afe4403.c b/drivers/iio/heart_monitors/afe4403.c
>> new file mode 100644
>> index 0000000..d285769
>> --- /dev/null
>> +++ b/drivers/iio/heart_monitors/afe4403.c
>> @@ -0,0 +1,610 @@
>> +/*
>> + * AFE4403 Heart Rate Monitors and Low-Cost Pulse Oximeters
>> + *
>> + * Author: Dan Murphy <dmurphy@ti.com>
>> + *
>> + * Copyright: (C) 2014 Texas Instruments, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * General Public License for more details.
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of_gpio.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/slab.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/regulator/consumer.h>
>> +
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/buffer.h>
>> +#include <linux/iio/driver.h>
>> +#include <linux/iio/machine.h>
>> +#include <linux/iio/events.h>
>> +#include <linux/iio/kfifo_buf.h>
>> +
>> +#define AFE4403_CONTROL0        0x00
>> +#define AFE4403_LED2STC            0x01
>> +#define AFE4403_LED2ENDC        0x02
>> +#define AFE4403_LED2LEDSTC        0x03
>> +#define AFE4403_LED2LEDENDC        0x04
>> +#define AFE4403_ALED2STC        0x05
>> +#define AFE4403_ALED2ENDC        0x06
>> +#define AFE4403_LED1STC            0x07
>> +#define AFE4403_LED1ENDC        0x08
>> +#define AFE4403_LED1LEDSTC        0x09
>> +#define AFE4403_LED1LEDENDC        0x0a
>> +#define AFE4403_ALED1STC        0x0b
>> +#define AFE4403_ALED1ENDC        0x0c
>> +#define AFE4403_LED2CONVST        0x0d
>> +#define AFE4403_LED2CONVEND        0x0e
>> +#define AFE4403_ALED2CONVST        0x0f
>> +#define AFE4403_ALED2CONVEND    0x10
>> +#define AFE4403_LED1CONVST        0x11
>> +#define AFE4403_LED1CONVEND        0x12
>> +#define AFE4403_ALED1CONVST        0x13
>> +#define AFE4403_ALED1CONVEND    0x14
>> +#define AFE4403_ADCRSTSTCT0        0x15
>> +#define AFE4403_ADCRSTENDCT0    0x16
>> +#define AFE4403_ADCRSTSTCT1        0x17
>> +#define AFE4403_ADCRSTENDCT1    0x18
>> +#define AFE4403_ADCRSTSTCT2        0x19
>> +#define AFE4403_ADCRSTENDCT2    0x1a
>> +#define AFE4403_ADCRSTSTCT3     0x1b
>> +#define AFE4403_ADCRSTENDCT3     0x1c
>> +#define AFE4403_PRPCOUNT         0x1d
>> +#define AFE4403_CONTROL1         0x1e
>> +#define AFE4403_SPARE1             0x1f
>> +#define AFE4403_TIAGAIN         0x20
>> +#define AFE4403_TIA_AMB_GAIN     0x21
>> +#define AFE4403_LEDCNTRL         0x22
>> +#define AFE4403_CONTROL2         0x23
>> +#define AFE4403_SPARE2             0x24
>> +#define AFE4403_SPARE3             0x25
>> +#define AFE4403_SPARE4             0x26
>> +#define AFE4403_ALARM             0x29
>> +#define AFE4403_LED2VAL         0x2A
>> +#define AFE4403_ALED2VAL         0x2B
>> +#define AFE4403_LED1VAL         0x2C
>> +#define AFE4403_ALED1VAL         0x2D
>> +#define AFE4403_LED2_ALED2VAL     0x2E
>> +#define AFE4403_LED1_ALED1VAL     0x2F
>> +#define AFE4403_DIAG             0x30
>> +#define AFE4403_CONTROL3         0x31
>> +#define AFE4403_PDNCYCLESTC     0x32
>> +#define AFE4403_PDNCYCLEENDC     0x33
>> +
>> +#define AFE4403_SPI_READ        (1 << 0)
>> +#define AFE4403_SW_RESET        (1 << 3)
>> +#define AFE4403_PWR_DWN            (1 << 0)
>
> Could use BIT(x) macro here.

OK

>
>> +
>> +/**
>> + * struct afe4403_data -
>> + * @work - Work item used to off load the enable/disable of the vibration
>> + * @indio_dev -
>> + * @map -
>> + * @spi -
>> + * @regulator - Pointer to the regulator for the IC
>> + * @ste_gpio -
>> + * @data_gpio -
>> + * @reset_gpio -
>> + * @data_buffer -
>> + * @irq - AFE4403 interrupt number
>> +**/
>
> :), i assume this will be documented in the final version.

Yes this is a little out of date.

>
>> +struct afe4403_data {
>> +    struct work_struct work;
>> +    struct iio_dev *indio_dev;
>> +    struct iio_map *map;
>> +    struct spi_device *spi;
>> +    struct regulator *regulator;
>> +    struct gpio_desc *ste_gpio;
>> +    struct gpio_desc *data_gpio;
>> +    struct gpio_desc *reset_gpio;
>> +    int data_buffer[5];
>> +    int irq;
>> +};
>> +
>
> <snip>
>
>> +static void afe4403_toggle_ste(struct afe4403_data *afe4403)
>> +{
>> +    gpiod_set_value(afe4403->ste_gpio, 1);
>> +    udelay(800);
>
> This hardcoded value should be documented.

I will have some documentation or at the very least an explanation.
This may change as well.

>
>> +    gpiod_set_value(afe4403->ste_gpio, 0);
>> +}
>> +
>
> <snip>
>
>> +static int afe4403_write_event(struct iio_dev *indio_dev,
>> +                     const struct iio_chan_spec *chan,
>> +                     enum iio_event_type type,
>> +                     enum iio_event_direction dir,
>> +                     int state)
>> +{
>> +    struct afe4403_data *afe4403 = iio_priv(indio_dev);
>> +    int ret;
>> +    int control_val;
>> +   
>> +    ret = afe4403_read(afe4403, AFE4403_CONTROL2, &control_val);
>> +    if (ret)
>> +        return ret;
>> +
>
> Use dev_dbg instead of printks.

Yeah accidentally left these in when debugging these will be removed with official submission

>
>> +    printk("***state 0x%X control 0x%X 0x%X\n", state, control_val, ~AFE4403_PWR_DWN);
>> +    if (state)
>> +        control_val &= ~AFE4403_PWR_DWN;
>> +    else
>> +        control_val |= AFE4403_PWR_DWN;
>> +
>> +    printk("***after control 0x%X\n", control_val);
>> +
>> +    ret = afe4403_write(afe4403, AFE4403_CONTROL2, control_val);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = afe4403_read(afe4403, AFE4403_CONTROL2, &control_val);
>> +    if (ret)
>> +        return ret;
>> +
>> +    printk("***control 0x%X\n", control_val);
>> +
>> +    return 0;
>> +}
>
> Also, run checkpatch.pl over your patches. There are small whitespace issues.

Sorry for the low quality patch I was not thinking when I submitted this low quality series
of patches

>
> thanks,
> Daniel.


-- 
------------------
Dan Murphy

