Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60045 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858AbbEQMuW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 May 2015 08:50:22 -0400
Message-ID: <55588E88.3060509@kernel.org>
Date: Sun, 17 May 2015 13:50:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Dan Murphy <dmurphy@ti.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: health: Add TI afe4403 heart monitor
References: <1431374726-23383-1-git-send-email-dmurphy@ti.com> <1431374726-23383-4-git-send-email-dmurphy@ti.com>
In-Reply-To: <1431374726-23383-4-git-send-email-dmurphy@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/05/15 21:05, Dan Murphy wrote:
> Add the TI afe4403 heart rate monitor.
> This device detects reflected LED
> wave length fluctuations and presents an ADC
> value to the user space to be converted to a
> heart rate.
> 
> Data sheet located here:
> http://www.ti.com/product/AFE4403/datasheet
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
Hi Dan,

There are a few code issues I've comment on inline.

The ABI is going to prove more challenging.  This is a complex beast
with a lot of 'special purpose' features that we don't support well.
I've made a few suggestions inline.  Would you mind pulling
all the ABI docs out into a separate patch?  That way I can try
and pull a few more reviewers into at least looking at that
even if they haven't got time to read through the whole driver.

Anyhow, it's improving but we aren't there yet!

Jonathan
> ---
>  .../ABI/testing/sysfs-bus-iio-health-afe4403       |  60 ++
>  .../devicetree/bindings/iio/health/ti_afe4403.txt  |   2 -
>  drivers/iio/Kconfig                                |   1 +
>  drivers/iio/Makefile                               |   1 +
>  drivers/iio/health/Kconfig                         |  21 +
>  drivers/iio/health/Makefile                        |   6 +
>  drivers/iio/health/afe4403.c                       | 855 +++++++++++++++++++++
>  drivers/iio/health/afe440x.h                       | 116 +++
>  8 files changed, 1060 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-health-afe4403
>  create mode 100644 drivers/iio/health/Kconfig
>  create mode 100644 drivers/iio/health/Makefile
>  create mode 100644 drivers/iio/health/afe4403.c
>  create mode 100644 drivers/iio/health/afe440x.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-health-afe4403 b/Documentation/ABI/testing/sysfs-bus-iio-health-afe4403
> new file mode 100644
> index 0000000..041b1ad
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-health-afe4403
> @@ -0,0 +1,60 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/out_tia_gain_cap
> +		/sys/bus/iio/devices/iio:deviceX/out_tia_gain_res
> +		/sys/bus/iio/devices/iio:deviceX/out_tia_amb_gain_res
> +		/sys/bus/iio/devices/iio:deviceX/out_tia_amb_gain_res
> +Date:		April 2015
> +KernelVersion:
> +Contact:	Dan Murphy <dmurphy@ti.com>
> +Description:
> +		Get and set the resistance and the capcitance settings for the
> +		Transimpedance Amplifier and Ambient Gain.
> +		Resistance setting is from 0 -> 7
> +		Capcitance setting is from 0 -> 15
More standard(ish) output channels?
out_capacitanceY_tia_raw (preferablly with a _scale if it can be established).
out_resistanceY_tia_raw (this one is new, but there are plenty of digital
pots out there so we'll need it sooner or later.  note the tia bit is done
via extended_name. I see there is an ambient equivalent.  you could use
modifers for this. We actually have IIO_MOD_TEMP_AMBIENT. I wonder if we should
make that more generic and drop the temp aspect.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_enable_tia_separate_gains
> +Date:		April 2015
> +KernelVersion:
> +Contact:	Dan Murphy <dmurphy@ti.com>
> +Description:
> +		Get and set the .
Dan, just a little more detail needed on this one ;)
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_enable_measurement
> +Date:		April 2015
> +KernelVersion:
> +Contact:	Dan Murphy <dmurphy@ti.com>
> +Description:
> +		Get and set the measurement to being enabled or disabled.
> +		This will power down the internals of the AFE and not
> +		generate any additional interrupts.
So this is a power saving mode?  Userspace only cares that the device
is powered down, not specifically what is powered down (in all cases
it can't produce data).  I don't think this needs an explicit control
as surely you want to be in the powered down state whenever nothing
is being read? Basically can this be done automatically?
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_led_cntrl_ledY
> +Date:		April 2015
> +KernelVersion:
> +Contact:	Dan Murphy <dmurphy@ti.com>
> +Description:
> +		Get and set the LED current for the specified LED.
> +		Y - Is the specific LED to set.
> +		Values range from 0 -> 63.  Current is calculated by
> +		current = value * 0.8
An output current?  Doesn't need new abi.
out_currentX_led_raw and out_currentX_led_scale should do the job nicely.
Technically we are just dealing with a current dac (or possibly even a
a regulator if we are getting fussy).
> +
> +What:		/sys/.../events/in_intensity0_led1val_mag_value
> +		/sys/.../events/in_intensity1_aled1val_mag_value
> +		/sys/.../events/in_intensity2_led2val_mag_value
> +		/sys/.../events/in_intensity3_aled2val_mag_value
> +Date:		April 2015
> +KernelVersion:
> +Contact:	Dan Murphy <dmurphy@ti.com>
> +Description:
> +		Event generated when the analog front end completed it's
> +		measurement and has led values available.  The values are
> +		expressed in 24-bit twos complement for the specified LEDs.
> +
> +What:		/sys/.../events/in_intensity4_led2_aled2_mag_value
> +		/sys/.../events/in_intensity5_led1_aled1_mag_value
> +Date:		April 2015
> +KernelVersion:
> +Contact:	Dan Murphy <dmurphy@ti.com>
> +Description:
> +		Event generated when the analog front end completed it's
> +		measurement and has led values available.  The values are
> +		expressed in 24-bit twos complement for the specified LEDs.
If you want to do data ready signals, implement the buffered output interface
and use that in conjunction with a trigger.  Events are for things like
thresholds, not for this purpose.
> diff --git a/Documentation/devicetree/bindings/iio/health/ti_afe4403.txt b/Documentation/devicetree/bindings/iio/health/ti_afe4403.txt
> index b196b17..e6cc14e 100644
> --- a/Documentation/devicetree/bindings/iio/health/ti_afe4403.txt
> +++ b/Documentation/devicetree/bindings/iio/health/ti_afe4403.txt
> @@ -6,7 +6,6 @@ an LED transmit section, and diagnostics for sensor and LED fault detection.
>  
>  Required properties:
>    - compatible: Must contain "ti,afe4403".
> -  - ste-gpio: GPIO for the spi control line
err, what is this doing in this patch?
>    - data-ready-gpio: GPIO interrupt when the afe4403 has data
>    - led-supply: Chip supply to the device
>  
> @@ -17,7 +16,6 @@ Example:
>  
>  &heart_rate {
>  	compatible = "ti,afe4403";
> -	ste-gpio = <&gpio1 29 GPIO_ACTIVE_HIGH>;
>  	data-ready-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
>  	led-supply = <&vbat>;
>  };
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index 4011eff..53e1892 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -65,6 +65,7 @@ source "drivers/iio/common/Kconfig"
>  source "drivers/iio/dac/Kconfig"
>  source "drivers/iio/frequency/Kconfig"
>  source "drivers/iio/gyro/Kconfig"
> +source "drivers/iio/health/Kconfig"
>  source "drivers/iio/humidity/Kconfig"
>  source "drivers/iio/imu/Kconfig"
>  source "drivers/iio/light/Kconfig"
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index 698afc2..d350cb3 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -18,6 +18,7 @@ obj-y += common/
>  obj-y += dac/
>  obj-y += gyro/
>  obj-y += frequency/
> +obj-y += health/
>  obj-y += humidity/
>  obj-y += imu/
>  obj-y += light/
> diff --git a/drivers/iio/health/Kconfig b/drivers/iio/health/Kconfig
> new file mode 100644
> index 0000000..24aae7c
> --- /dev/null
> +++ b/drivers/iio/health/Kconfig
> @@ -0,0 +1,21 @@
> +#
> +# Health drivers
> +#
> +# When adding new entries keep the list in alphabetical order
> +
> +menu "Health"
> +
> +menu "Heart Rate Monitors"
> +config AFE4403
> +	tristate "TI AFE4403 Heart Rate Monitor"
> +	depends on SPI_MASTER
> +	select IIO_BUFFER
> +	help
> +	  Say yes to choose the Texas Instruments AFE4403
> +	  heart rate monitor and low-cost pulse oximeter.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called afe4403 heart rate monitor and
> +	  low-cost pulse oximeter.
> +endmenu
> +endmenu
> diff --git a/drivers/iio/health/Makefile b/drivers/iio/health/Makefile
> new file mode 100644
> index 0000000..77cc5c5
> --- /dev/null
> +++ b/drivers/iio/health/Makefile
> @@ -0,0 +1,6 @@
> +#
> +# Makefile for IIO Heart Rate Monitor drivers
> +#
> +
> +# When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_AFE4403) += afe4403.o
> diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
> new file mode 100644
> index 0000000..8e5bb3d
> --- /dev/null
> +++ b/drivers/iio/health/afe4403.c
> @@ -0,0 +1,855 @@
> +/*
> + * AFE4403 Heart Rate Monitors and Low-Cost Pulse Oximeters
> + *
> + * Author: Dan Murphy <dmurphy@ti.com>
> + *
> + * Copyright: (C) 2015 Texas Instruments, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_gpio.h>
> +#include <linux/spi/spi.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/events.h>
> +
> +#include "afe440x.h"
> +
> +static DEFINE_MUTEX(afe4403_mutex);
So you've just limited yourself to one instance of this device?  Why?
Just embed the mutex in your private structure.
> +
> +/* AFE4403 LEDCNTRL specific bits */
> +#define AFE4403_LEDCNTRL_LED_RANGE_MASK		0x30000
> +#define AFE4403_LEDCNTRL_LED_RANGE_SHIFT	16
> +#define AFE4403_LEDCNTRL_RANGE_TX_OFF		0x30000
> +#define AFE4403_LEDCNTRL_RANGE_TX_FULL	(1 << AFE4403_LEDCNTRL_LED_RANGE_SHIFT)
> +#define AFE4403_LEDCNTRL_RANGE_TX_HALF	(2 << AFE4403_LEDCNTRL_LED_RANGE_SHIFT)
> +
> +/* AFE4403 CONTROL 2 specific bits */
> +#define AFE4403_CNTRL_2_PWR_DWN_TX	BIT(2)
> +#define AFE4403_CNTRL_2_EN_SLOW_DIAG	BIT(8)
> +#define AFE4403_CNTRL_2_DIAG_OUT_TRI	BIT(10)
> +#define AFE4403_CNTRL_2_TX_BRDG_MOD	BIT(11)
> +#define AFE4403_CNTRL_2_TX_REF0		BIT(17)
> +#define AFE4403_CNTRL_2_TX_REF1		BIT(18)
> +
> +/* AFE4403 CONTROL 3 specific bits */
> +#define AFE4403_CNTRL3_CLK_DIV_2	0x0
> +#define AFE4403_CNTRL3_CLK_DIV_4	0x2
> +#define AFE4403_CNTRL3_CLK_DIV_6	0x3
> +#define AFE4403_CNTRL3_CLK_DIV_8	0x4
> +#define AFE4403_CNTRL3_CLK_DIV_12	0x5
> +#define AFE4403_CNTRL3_CLK_DIV_1	0x7
> +
> +/* AFE4403 TIA_GAIN specific bits */
> +#define AFE4403_TIA_GAIN_CAP_5_P	0x0
> +#define AFE4403_TIA_GAIN_CAP_10_P	0x1
> +#define AFE4403_TIA_GAIN_CAP_20_P	0x2
> +#define AFE4403_TIA_GAIN_CAP_30_P	0x3
> +#define AFE4403_TIA_GAIN_CAP_55_P	0x8
> +#define AFE4403_TIA_GAIN_CAP_155_P	0x10
> +
> +/**
> + * struct afe4403_data
> + * @indio_dev - IIO device structure
> + * @spi - SPI device pointer the driver is attached to
> + * @mutex - Read/Write mutex
> + * @regulator - Pointer to the regulator for the IC
> + * @data_gpio - Interrupt GPIO when AFE data is ready
> + * @reset_gpio - Hard wire GPIO reset line
> + * @timestamp - Timestamp of the IRQ event
> + * @state - Current state of the IC.
> + * @irq - AFE4403 interrupt number
> +**/
> +struct afe4403_data {
> +	struct iio_dev *indio_dev;
Don't have a pointer to the indio_dev in here.  It almost always indicates
a design issue.  Curriously in this case, it's not even used.  Which is
better in someways than it it was being!
> +	struct spi_device *spi;
> +	struct mutex mutex;
> +	struct regmap *regmap;
> +	struct regulator *regulator;
> +	struct gpio_desc *data_gpio;
> +	struct gpio_desc *reset_gpio;
> +	int64_t timestamp;
> +	bool state;
> +	int irq;
As commented in various places below, much of this structure doesn't belong here.
> +};
> +
> +enum afe4403_reg_id {
> +	LED1VAL,
> +	ALED1VAL,
> +	LED2VAL,
> +	ALED2VAL,
> +	LED2_ALED2VAL,
> +	LED1_ALED1VAL,
> +};
> +
> +struct afe4403_reg_cntrl_attribute {
> +	struct device_attribute dev_attr;
> +	int val1;
> +};
> +
> +static inline struct afe4403_reg_cntrl_attribute *
> +to_afe4403_reg_cntrl_attr(struct device_attribute *attr)
> +{
> +	return container_of(attr, struct afe4403_reg_cntrl_attribute, dev_attr);
> +}
> +
> +static struct afe440x_chan_map afe4403_map[] = {
> +	{ LED1VAL, AFE440X_LED1VAL },
> +	{ ALED1VAL, AFE440X_ALED1VAL },
> +	{ LED2VAL, AFE440X_LED2VAL },
> +	{ ALED2VAL, AFE440X_ALED2VAL },
> +	{ LED2_ALED2VAL, AFE440X_LED2_ALED2VAL },
> +	{ LED1_ALED1VAL, AFE440X_LED1_ALED1VAL },
> +};
> +
> +static const struct iio_event_spec afe4403_event = {
> +	.type = IIO_EV_TYPE_MAG,
> +	.dir = IIO_EV_DIR_NONE,
> +	.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +};
> +
> +#define AFE4403_READ_CHAN(index, name) { \
> +	.type = IIO_INTENSITY,		\
> +	.indexed = 1,			\
> +	.channel = index,		\
> +	.extend_name = name, 		\

Right now you don't support 'buffered' access so scan_index and scan_type
shouldn't be here.
> +	.scan_index = index,		\
> +	.scan_type = {				\
> +		.sign = 'u',			\
> +		.realbits = 24,			\
> +		.storagebits = 32,		\
> +		.endianness = IIO_BE		\
> +	}, \
> +	.event_spec = &afe4403_event,		\
> +	.num_event_specs = 1,			\
> +}
> +
> +static const struct iio_chan_spec afe4403_channels[] = {
> +	/* Read only values from the IC */
> +	AFE4403_READ_CHAN(LED1VAL, "led1val"),
Hmm.
These are all non standard enough the resulting abi needs
documenting.

Does the val add anything to any of these?  If we were to
use modifiers for the ambient aspect then you could have
something like.

in_intensity0_ambient_raw
in_intensity0_transmission_raw (or something along those lines).
in_intensity1_ambient_raw
in_intensity1_transmission_raw

It's a bit uggly and non standard way of grouping channels but
it does indicate that they are in some sense measuring the same
channel.  The use of modifiers to indicate a forced state is
a bit uggly, but we already sort of do this with thermopiles where
we have a reference channel on a known target and an object measurement.
> +	AFE4403_READ_CHAN(ALED1VAL, "aled1val"),
> +	AFE4403_READ_CHAN(LED2VAL, "led2val"),
> +	AFE4403_READ_CHAN(ALED2VAL, "aled2val"),

The next two are differential channels. We have a well
definited interface for those.  I guess the
issue is that right now we only have one extended_name field.
I'd have no objection to allowing for two in the case
of differential channels.  right now we don't have any differential
channels with extended names anyway so we can change this
however we like.

Perhaps we could have
in_intensity0_aled2-intensity1_aled2_raw and similar by
placing the two extended names appropriately?

> +	AFE4403_READ_CHAN(LED2_ALED2VAL, "led2_aled2"),
> +	AFE4403_READ_CHAN(LED1_ALED1VAL, "led1_aled1"),
> +};
> +
> +

Hmm.  A fairly minimalist wrapper, is spi_write_then_read not guaranteed
to be atomic?.  I just divide down a fair way and concluded that it
depends on whether the spi controllers have atomic handling of transfers.

> +static int afe4403_read(struct afe4403_data *afe4403, u8 reg,
> +		unsigned int *data)
> +{
> +	int ret;
> +
> +	mutex_lock(&afe4403_mutex);
> +
> +	ret = spi_write_then_read(afe4403->spi, (u8 *)&reg, 1, (u8 *)data, 3);
> +
> +	mutex_unlock(&afe4403_mutex);
blank line here.
> +	return ret;
> +};
> +
> +static int afe4403_write(struct afe4403_data *afe4403, u8 reg,
> +		unsigned int data)
> +{
> +	int ret;
> +	u8 tx[4] = {0x0, 0x0, 0x0, 0x0};
> +
> +	mutex_lock(&afe4403_mutex);
> +
> +	/* Enable write to the device */
> +	tx[0] = AFE440X_CONTROL0;
> +	tx[3] = AFE440X_WRITE;
Just put these in above instead of 0s
> +	ret = spi_write(afe4403->spi, (u8 *)tx, 4);
Shouldn't need the type cast to u8 *.
> +	if (ret)
> +		goto out;
> +
> +	tx[0] = reg;
> +	tx[1] = (data & 0xff0000) >> 16;
> +	tx[2] = (data & 0x00ff00) >> 8;
> +	tx[3] = data & 0xff;
> +	ret = spi_write(afe4403->spi, (u8 *)tx, 4);
> +	if (ret)
> +		goto out;
> +
> +	/* Re-Enable reading from the device */
> +	tx[0] = AFE440X_CONTROL0;
> +	tx[1] = 0x0;
> +	tx[2] = 0x0;
> +	tx[3] = AFE440X_READ;
> +	ret = spi_write(afe4403->spi, (u8 *)tx, 4);
> +
> +out:
> +	mutex_unlock(&afe4403_mutex);
> +	return ret;
> +};
> +
> +static int afe4403_read_event_value(struct iio_dev *iio,
> +			const struct iio_chan_spec *chan,
> +			enum iio_event_type type,
> +			enum iio_event_direction dir,
> +			enum iio_event_info info,
> +			int *val, int *val2)
> +{
> +	struct afe4403_data *afe4403 = iio_priv(iio);
> +	int ret;
> +
> +	ret = afe4403_read(afe4403, afe4403_map[chan->channel].reg, val);
> +	if (ret)
> +		goto done;
> +
> +	*val2 = 0;
> +	ret = IIO_VAL_INT;
> +done:
> +	return ret;
> +}
> +
> +static ssize_t show_tia_separate_gains(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct afe4403_data *afe4403 = iio_priv(indio_dev);
> +	unsigned int gain_val;
> +	int ret;
> +
> +	ret = afe4403_read(afe4403, AFE440X_TIAGAIN, &gain_val);
> +	if (ret)
> +		return ret;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%u\n",
> +			((gain_val & AFE440X_TIA_GAIN_SEP_GAIN_MASK) >>
> +			AFE440X_TIA_GAIN_SEP_GAIN_SHIFT));
> +}
> +
> +static int store_tia_separate_gains(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct afe4403_data *afe4403 = iio_priv(indio_dev);
> +	unsigned state;
> +	unsigned int control_val;
> +	int ret;
> +
> +	if (kstrtoint(buf, 0, &state))
> +		return -EINVAL;
> +
> +	ret = afe4403_read(afe4403, AFE440X_TIAGAIN, &control_val);
> +	if (ret)
> +		return ret;
> +
> +	if (state)
> +		control_val |= 1 << AFE440X_TIA_GAIN_SEP_GAIN_SHIFT;
> +	else
> +		control_val &= ~AFE440X_TIA_GAIN_SEP_GAIN_MASK;
> +
> +	ret = afe4403_write(afe4403, AFE440X_TIAGAIN, control_val);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t show_measurement(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct afe4403_data *afe4403 = iio_priv(indio_dev);
> +	unsigned int control_val;
> +	int ret;
> +
> +	ret = afe4403_read(afe4403, AFE440X_CONTROL2, &control_val);
> +	if (ret)
> +		return ret;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%u\n",
> +			!(control_val & AFE440X_CNTRL_2_PWR_DWN));
> +}
> +
> +static int store_measurement(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct afe4403_data *afe4403 = iio_priv(indio_dev);
> +	unsigned int control_val;
> +	unsigned state;
> +	int ret;
> +
> +	if (kstrtoint(buf, 0, &state))
> +		return -EINVAL;
> +
> +	ret = afe4403_read(afe4403, AFE440X_CONTROL2, &control_val);
> +	if (ret)
> +		return ret;
> +
> +	if (state)
> +		control_val &= ~AFE440X_CNTRL_2_PWR_DWN;
> +	else
> +		control_val |= AFE440X_CNTRL_2_PWR_DWN;
> +
> +	ret = afe4403_write(afe4403, AFE440X_CONTROL2, control_val);
> +	if (ret)
> +		return ret;
> +
> +	afe4403->state = (control_val & AFE440X_CNTRL_2_PWR_DWN);
> +
> +	return len;
> +}
> +
> +static int set_tia_gain_cap(struct afe4403_data *afe4403, u8 reg,
> +		int data)
> +{
> +	int ret;
> +	int tia_gain;
> +
> +	ret = afe4403_read(afe4403, reg, &tia_gain);
> +	if (ret)
> +		return ret;
> +
> +	tia_gain &= ~AFE440X_TIA_GAIN_CAP_MASK;
> +	tia_gain |= (data << AFE440X_TIA_GAIN_CAP_SHIFT) & AFE440X_TIA_GAIN_CAP_MASK;
> +
> +	return afe4403_write(afe4403, reg, tia_gain);
> +}
> +
> +static int set_tia_gain_res(struct afe4403_data *afe4403, u8 reg,
> +		int data)
> +{
> +	int ret;
> +	int tia_gain;
> +
> +	ret = afe4403_read(afe4403, reg, &tia_gain);
> +	if (ret)
> +		return ret;
> +
> +	tia_gain &= ~AFE440X_TIA_GAIN_RES_MASK;
> +	tia_gain |= data;
> +
> +	return afe4403_write(afe4403, reg, tia_gain);
> +}
> +
> +static ssize_t store_tia_amb_gain_cap(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct afe4403_data *afe4403 = iio_priv(indio_dev);
> +	unsigned val;
> +	int ret;
> +
> +	if (kstrtoint(buf, 0, &val))
> +		return -EINVAL;
> +
> +	ret = set_tia_gain_cap(afe4403, AFE440X_TIA_AMB_GAIN, val);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t show_tia_amb_gain_cap(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct afe4403_data *afe4403 = iio_priv(indio_dev);
> +	int ret;
> +	int gain;
> +
> +	ret = afe4403_read(afe4403, AFE440X_TIA_AMB_GAIN, &gain);
> +	if (ret)
> +		return ret;
> +
> +
> +	return scnprintf(buf, PAGE_SIZE, "%u\n",
> +			(gain & AFE440X_TIA_GAIN_CAP_MASK) >> AFE440X_TIA_GAIN_CAP_SHIFT);
> +}
> +
> +static ssize_t store_tia_amb_gain_res(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct afe4403_data *afe4403 = iio_priv(indio_dev);
> +	unsigned val;
> +	int ret;
> +
> +	if (kstrtoint(buf, 0, &val))
> +		return -EINVAL;
> +
> +	ret = set_tia_gain_res(afe4403, AFE440X_TIA_AMB_GAIN, val);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t show_tia_amb_gain_res(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct afe4403_data *afe4403 = iio_priv(indio_dev);
> +	int ret;
> +	int gain;
> +
> +	ret = afe4403_read(afe4403, AFE440X_TIA_AMB_GAIN, &gain);
> +	if (ret)
> +		return ret;
> +
> +
> +	return scnprintf(buf, PAGE_SIZE, "%u\n",
> +		(gain & AFE440X_TIA_GAIN_RES_MASK));
> +}
> +
> +static ssize_t store_tia_gain_res(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct afe4403_data *afe4403 = iio_priv(indio_dev);
> +	unsigned val;
> +	int ret;
> +
> +	if (kstrtoint(buf, 0, &val))
> +		return -EINVAL;
> +
> +	ret = set_tia_gain_res(afe4403, AFE440X_TIAGAIN, val);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t show_tia_gain_res(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct afe4403_data *afe4403 = iio_priv(indio_dev);
> +	int ret;
> +	int gain;
> +
> +	ret = afe4403_read(afe4403, AFE440X_TIAGAIN, &gain);
> +	if (ret)
> +		return ret;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%u\n",
> +			(gain & AFE440X_TIA_GAIN_RES_MASK));
> +}
> +
> +static ssize_t store_tia_gain_cap(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct afe4403_data *afe4403 = iio_priv(indio_dev);
> +	unsigned val;
> +	int ret;
> +
> +	if (kstrtoint(buf, 0, &val))
> +		return -EINVAL;
> +
> +	ret = set_tia_gain_cap(afe4403, AFE440X_TIAGAIN, val);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t show_tia_gain_cap(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct afe4403_data *afe4403 = iio_priv(indio_dev);
> +	int ret;
> +	int gain;
> +
> +	ret = afe4403_read(afe4403, AFE440X_TIAGAIN, &gain);
> +	if (ret)
> +		return ret;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%u\n",
> +			(gain & AFE440X_TIA_GAIN_CAP_MASK) >> AFE440X_TIA_GAIN_CAP_SHIFT);
> +}
> +
> +static ssize_t show_led_cntrl(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct afe4403_data *afe4403 = iio_priv(indio_dev);
> +	struct afe4403_reg_cntrl_attribute *cntrl_attr = to_afe4403_reg_cntrl_attr(attr);
> +	int ret;
> +	int led_shift, led_reg_val, shifted_val;
> +
> +	ret = afe4403_read(afe4403, AFE440X_LEDCNTRL, &led_reg_val);
> +	if (ret)
> +		return ret;
> +
> +	/* Shift this a total of 6 bits for the LED number */
> +	led_shift = ((cntrl_attr->val1 - 1) * AFE440X_LED_CNTRL_LED_SHIFT);
> +	shifted_val = (AFE440X_LED_CNTRL_LED_MASK << led_shift);
> +	led_reg_val &= shifted_val;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%u\n", (led_reg_val >> led_shift));
> +}
> +
> +static ssize_t store_led_cntrl(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct afe4403_data *afe4403 = iio_priv(indio_dev);
> +	struct afe4403_reg_cntrl_attribute *cntrl_attr = to_afe4403_reg_cntrl_attr(attr);
> +	unsigned val;
> +	int ret;
> +	int led_shift, led_reg_val, shifted_val;
> +
> +	if (kstrtoint(buf, 0, &val))
> +		return -EINVAL;
> +
> +	ret = afe4403_read(afe4403, AFE440X_LEDCNTRL, &led_reg_val);
> +	if (ret)
> +		return ret;
> +
> +	/* Shift this a total of 6 bits for the LED number */
> +	led_shift = ((cntrl_attr->val1 - 1) * AFE440X_LED_CNTRL_LED_SHIFT);
> +	shifted_val = (AFE440X_LED_CNTRL_LED_MASK << led_shift);
> +	led_reg_val &= ~shifted_val;
> +	led_reg_val |= (val << led_shift);
> +
> +	ret = afe4403_write(afe4403, AFE440X_LEDCNTRL, val << led_shift);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +#define ENABLE_ATTR_RW(_name) \
> +	DEVICE_ATTR(out_enable_##_name, S_IRUGO | S_IWUSR, \
> +		show_##_name, store_##_name)
> +
> +static ENABLE_ATTR_RW(measurement);
> +
> +#define REGISTER_CNTRL_ATTR(_name, _mode, _show, _store, _val1)	\
> +	{ .dev_attr	= __ATTR(_name, _mode, _show, _store),	\
> +	  .val1	= _val1	}
> +
> +#define AFE4403_REG_ATTR(_name, _mode, _show, _store, _val1) \
> +	struct afe4403_reg_cntrl_attribute afe4403_attr_##_name =  \
> +		REGISTER_CNTRL_ATTR(_name, _mode, _show, _store, _val1)
> +
> +#define TIA_GAIN_RW(_name) \
> +	AFE4403_REG_ATTR(out_##_name, S_IRUGO | S_IWUSR, \
> +		show_##_name, store_##_name, 0)
> +
> +static ENABLE_ATTR_RW(tia_separate_gains);
> +static TIA_GAIN_RW(tia_gain_res);
> +static TIA_GAIN_RW(tia_gain_cap);
> +static TIA_GAIN_RW(tia_amb_gain_res);
> +static TIA_GAIN_RW(tia_amb_gain_cap);
> +
> +#define LED_ATTR_RW(_name, _lednum) \
> +	AFE4403_REG_ATTR(out_##_name##_led##_lednum, S_IRUGO | S_IWUSR, \
> +		show_##_name, store_##_name, _lednum)
> +
> +static LED_ATTR_RW(led_cntrl, 1);
> +static LED_ATTR_RW(led_cntrl, 2);
> +
> +static struct attribute *afe4403_attributes[] = {
> +	&dev_attr_out_enable_measurement.attr,
> +	&dev_attr_out_enable_tia_separate_gains.attr,
> +	&afe4403_attr_out_led_cntrl_led1.dev_attr.attr,
> +	&afe4403_attr_out_led_cntrl_led2.dev_attr.attr,
> +	&afe4403_attr_out_tia_gain_res.dev_attr.attr,
> +	&afe4403_attr_out_tia_gain_cap.dev_attr.attr,
> +	&afe4403_attr_out_tia_amb_gain_res.dev_attr.attr,
> +	&afe4403_attr_out_tia_amb_gain_cap.dev_attr.attr,
> +	NULL
> +};
> +
> +static struct attribute_group afe4403_attribute_group = {
> +	.attrs = afe4403_attributes
> +};
> +
> +static const struct iio_info afe4403_iio_info = {
> +	.attrs	= &afe4403_attribute_group,
> +	.read_event_value = &afe4403_read_event_value,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static irqreturn_t afe4403_event_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct afe4403_data *afe4403 = iio_priv(indio_dev);
> +
> +	afe4403->timestamp = iio_get_time_ns();
Why stash the timestamp in your private structure? It's only used in
the next call.
> +
> +	iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_HEARTRATE,
> +							0,
> +							IIO_EV_TYPE_CHANGE,
> +							IIO_EV_DIR_EITHER),
> +							afe4403->timestamp);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +struct afe4403_reg {
> +	uint8_t reg;
> +	u32 value;
> +} afe4403_init_regs[] = {
> +	{ AFE440X_LED2STC,  0x000820},
> +	{ AFE440X_LED2ENDC, 0x000f9e },
> +	{ AFE440X_LED2LEDSTC, 0x0007d0 },
> +	{ AFE440X_LED2LEDENDC, 0x000f9f },
> +	{ AFE440X_ALED2STC, 0x000050 },
> +	{ AFE440X_ALED2ENDC, 0x0007ce },
> +	{ AFE440X_LED1STC, 0x00c350 },
> +	{ AFE440X_LED1ENDC, 0x00c350 },
> +	{ AFE440X_LED1LEDSTC, 0x00c350 },
> +	{ AFE440X_LED1LEDENDC, 0x00c350 },
> +	{ AFE440X_ALED1STC, 0x000ff0 },
> +	{ AFE440X_ALED1ENDC, 0x00176e },
> +	{ AFE440X_LED2CONVST, 0x001775 },
> +	{ AFE440X_LED2CONVEND, 0x001f3f },
> +	{ AFE440X_ALED2CONVST, 0x001f45 },
> +	{ AFE440X_ALED2CONVEND, 0x00270f },
> +	{ AFE440X_LED1CONVST, 0x002715 },
> +	{ AFE440X_LED1CONVEND, 0x002edf },
> +	{ AFE440X_ALED1CONVST, 0x002ee5 },
> +	{ AFE440X_ALED1CONVEND, 0x0036af },
> +	{ AFE440X_ADCRSTSTCT0, 0x001770 },
> +	{ AFE440X_ADCRSTENDCT0, 0x001774 },
> +	{ AFE440X_ADCRSTSTCT1, 0x001f40 },
> +	{ AFE440X_ADCRSTENDCT1, 0x001f44 },
> +	{ AFE440X_ADCRSTSTCT2, 0x002710 },
> +	{ AFE440X_ADCRSTENDCT2, 0x002714 },
> +	{ AFE440X_ADCRSTSTCT3, 0x002ee0 },
> +	{ AFE440X_ADCRSTENDCT3, 0x002ee4 },
> +	{ AFE440X_PRPCOUNT, 0x0009c3f },
What is the 7?
> +	{ AFE440X_CONTROL1, (AFE440X_CNTRL_1_TIMER_EN | 0x000007) },
> +	{ AFE440X_TIAGAIN, (AFE440X_TIA_GAIN_SEP_GAIN_MASK |
> +			    AFE440X_TIA_GAIN_RES_1_M) },
> +	{ AFE440X_TIA_AMB_GAIN, AFE440X_TIA_GAIN_RES_1_M },
What about the 1414?
> +	{ AFE440X_LEDCNTRL, (AFE4403_LEDCNTRL_RANGE_TX_FULL | 0x0001414) },
> +	{ AFE440X_CONTROL2, AFE4403_CNTRL_2_TX_REF0 },
> +};
> +
> +static int afe4403_init(struct afe4403_data *afe4403)
> +{
> +	int ret, i, reg_count;
> +
> +	/* Hard reset the device needs to be held for 1ms per data sheet */
> +	if (afe4403->reset_gpio) {
> +		gpiod_set_value(afe4403->reset_gpio, 0);
> +		udelay(1000);
> +		gpiod_set_value(afe4403->reset_gpio, 1);
> +	} else {
> +		/* Soft reset the device */
> +		ret = afe4403_write(afe4403, AFE440X_CONTROL0,
> +				AFE440X_SW_RESET);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	reg_count = ARRAY_SIZE(afe4403_init_regs);
Why the local reg_count variable? Squash it into the next line.
> +	for (i = 0; i < reg_count; i++) {
> +		ret = afe4403_write(afe4403, afe4403_init_regs[i].reg,
> +					afe4403_init_regs[i].value);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return ret;
> +};
> +
> +static int afe4403_spi_probe(struct spi_device *spi)
> +{
> +	struct afe4403_data *afe4403;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*afe4403));
> +	if (indio_dev == NULL) {
> +		dev_err(&spi->dev, "Failed to allocate iio device\n");
> +		return -ENOMEM;
> +	}
> +
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	afe4403 = iio_priv(indio_dev);
> +	afe4403->spi = spi;
> +
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->name = "afe4403";
> +	indio_dev->info = &afe4403_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = afe4403_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(afe4403_channels);
> +
> +	afe4403->data_gpio = devm_gpiod_get(&spi->dev, "data-ready");
> +	if (IS_ERR(afe4403->data_gpio)) {
> +		ret = PTR_ERR(afe4403->data_gpio);
> +		if (ret != -ENOENT && ret != -ENOSYS) {
> +			dev_err(&spi->dev, "Failed to allocate data_ready\n");
> +			return ret;
> +		}
> +		afe4403->data_gpio = NULL;
> +	} else {
> +		gpiod_direction_input(afe4403->data_gpio);
> +		afe4403->irq = gpiod_to_irq(afe4403->data_gpio);
> +	}
There is no direct use of this one as a gpio.  Hence it should be treated
as just an irq througout.  For that matter, once set here data_gpio
is never used anywhere else so should be local.  Also, spi devices can
have an irq so use that.  Note that this stuff about setting direction etc
just means that either the bios/firmware is not setting it up as expected,
or the gpio chip driver isn't handling it.

> +
> +	afe4403->reset_gpio = devm_gpiod_get(&spi->dev, "reset");
> +	if (IS_ERR(afe4403->reset_gpio)) {
> +		ret = PTR_ERR(afe4403->reset_gpio);
Add a comment here to explain why these two error cases are fine.

> +		if (ret != -ENOENT && ret != -ENOSYS) {
> +			dev_err(&spi->dev, "Failed to allocate reset gpio\n");
> +			return ret;
> +		}
> +		afe4403->reset_gpio = NULL;
> +	} else {
> +		gpiod_direction_output(afe4403->reset_gpio, 1);
> +	}
> +
> +	afe4403->regulator = devm_regulator_get(&spi->dev, "led");
> +	if (IS_ERR(afe4403->regulator)) {
> +		ret = PTR_ERR(afe4403->regulator);
> +		dev_err(&spi->dev,
> +			"unable to get regulator, error: %d\n", ret);
> +		return ret;
> +	}

irq is not used outside this function, so make it a local variable.
> +	if (afe4403->irq > 0) {
> +		ret = devm_request_threaded_irq(&spi->dev, afe4403->irq,
> +					   NULL,
> +					   afe4403_event_handler,
> +					   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					   "afe4403 int",
> +					   indio_dev);
> +		if (ret) {
> +			dev_err(&spi->dev, "unable to request IRQ\n");
> +			goto probe_error;
> +		}
> +	}
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0)
> +		goto probe_error;
> +
> +	ret = afe4403_init(afe4403);
You are running init after you have exposed the user interface?  Would
expect this an the device_register to be in the oposite order.
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to init device\n");
> +		goto init_failure;
> +	}
> +
> +	return 0;
> +
> +init_failure:
> +	iio_device_unregister(indio_dev);
> +probe_error:
> +	return ret;
> +}
> +
> +static int afe4403_spi_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct afe4403_data *afe4403 = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	if (!IS_ERR(afe4403->regulator))
> +		regulator_disable(afe4403->regulator);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused afe4403_suspend(struct device *dev)
> +{
> +	struct afe4403_data *afe4403 = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	ret = afe4403_write(afe4403, AFE440X_CONTROL2, AFE440X_CNTRL_2_PWR_DWN);
> +	if (ret)
> +		goto out;
> +
> +	ret = regulator_disable(afe4403->regulator);
> +	if (ret)
> +		dev_err(dev, "Failed to disable regulator\n");
> +
> +out:
> +	return ret;
> +}
> +
> +static int __maybe_unused afe4403_resume(struct device *dev)
> +{
> +	struct afe4403_data *afe4403 = dev_get_drvdata(dev);
> +	int ret = 0;
> +
state is never set anywhere.
> +	if (afe4403->state) {
> +		ret = afe4403_write(afe4403, AFE440X_CONTROL2,
> +			~AFE440X_CNTRL_2_PWR_DWN);
> +		if (ret)
> +			goto out;
> +	}
> +	ret = regulator_enable(afe4403->regulator);
> +	if (ret)
> +		dev_err(dev, "Failed to disable regulator\n");
> +
> +out:
> +	return ret;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(afe4403_pm_ops, afe4403_suspend, afe4403_resume);
> +
> +#if IS_ENABLED(CONFIG_OF)
> +static const struct of_device_id afe4403_of_match[] = {
> +	{ .compatible = "ti,afe4403", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, afe4403_of_match);
> +#endif
> +
> +static const struct spi_device_id afe4403_id[] = {
> +	{"afe4403", 0},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(spi, afe4403_id);
> +
> +static struct spi_driver afe4403_spi_driver = {
> +	.driver = {
> +		.name = "afe4403",
> +		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(afe4403_of_match),
> +		.pm	= &afe4403_pm_ops,
> +	},
> +	.probe = afe4403_spi_probe,
> +	.remove = afe4403_spi_remove,
> +	.id_table = afe4403_id,
> +};
> +module_spi_driver(afe4403_spi_driver);
> +
> +MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
> +MODULE_DESCRIPTION("TI AFE4403 Heart Rate and Pulse Oximeter");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/health/afe440x.h b/drivers/iio/health/afe440x.h
> new file mode 100644
> index 0000000..c71a97a
> --- /dev/null
> +++ b/drivers/iio/health/afe440x.h
> @@ -0,0 +1,116 @@
> +/*
> + * AFE440X Heart Rate Monitors and Low-Cost Pulse Oximeters
> + * Common registers and bit definitions.
> + *
> + * Author: Dan Murphy <dmurphy@ti.com>
> + *
> + * Copyright: (C) 2015 Texas Instruments, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +
> +#ifndef _AFE440X_H
> +#define _AFE440X_H
> +
> +#define AFE440X_CONTROL0		0x00
> +#define AFE440X_LED2STC			0x01
> +#define AFE440X_LED2ENDC		0x02
> +#define AFE440X_LED1LEDSTC		0x03
> +#define AFE440X_LED1LEDENDC		0x04
> +#define AFE440X_ALED2STC		0x05
> +#define AFE440X_ALED2ENDC		0x06
> +#define AFE440X_LED1STC			0x07
> +#define AFE440X_LED1ENDC		0x08
> +#define AFE440X_LED2LEDSTC		0x09
> +#define AFE440X_LED2LEDENDC		0x0a
> +#define AFE440X_ALED1STC		0x0b
> +#define AFE440X_ALED1ENDC		0x0c
> +#define AFE440X_LED2CONVST		0x0d
> +#define AFE440X_LED2CONVEND		0x0e
> +#define AFE440X_ALED2CONVST		0x0f
> +#define AFE440X_ALED2CONVEND	0x10
> +#define AFE440X_LED1CONVST		0x11
> +#define AFE440X_LED1CONVEND		0x12
> +#define AFE440X_ALED1CONVST		0x13
> +#define AFE440X_ALED1CONVEND	0x14
> +#define AFE440X_ADCRSTSTCT0		0x15
> +#define AFE440X_ADCRSTENDCT0	0x16
> +#define AFE440X_ADCRSTSTCT1		0x17
> +#define AFE440X_ADCRSTENDCT1	0x18
> +#define AFE440X_ADCRSTSTCT2		0x19
> +#define AFE440X_ADCRSTENDCT2	0x1a
> +#define AFE440X_ADCRSTSTCT3		0x1b
> +#define AFE440X_ADCRSTENDCT3	0x1c
> +#define AFE440X_PRPCOUNT		0x1d
> +#define AFE440X_CONTROL1		0x1e
> +#define AFE440X_SPARE1			0x1f
> +#define AFE440X_TIAGAIN			0x20
> +#define AFE440X_TIA_AMB_GAIN	0x21
> +#define AFE440X_LEDCNTRL		0x22
> +#define AFE440X_CONTROL2		0x23
> +#define AFE440X_SPARE2			0x24
> +#define AFE440X_SPARE3			0x25
> +#define AFE440X_SPARE4			0x26
> +#define AFE440X_ALARM			0x29
> +#define AFE440X_LED2VAL			0x2A
> +#define AFE440X_ALED2VAL		0x2B
> +#define AFE440X_LED1VAL			0x2C
> +#define AFE440X_ALED1VAL		0x2D
> +#define AFE440X_LED2_ALED2VAL	0x2E
> +#define AFE440X_LED1_ALED1VAL	0x2F
> +#define AFE440X_DIAG			0x30
> +#define AFE440X_CONTROL3		0x31
> +#define AFE440X_PDNCYCLESTC		0x32
> +#define AFE440X_PDNCYCLEENDC	0x33
> +
> +/* CONTROL_0 register */
> +#define AFE440X_READ		BIT(0)
> +#define AFE440X_WRITE		0x0
> +#define AFE440X_SW_RESET	BIT(3)
> +
> +/* CONTROL_1 register */
> +#define AFE440X_CNTRL_1_TIMER_EN	BIT(8)
> +
> +/* CONTROL_2 register */
> +#define AFE440X_CNTRL_2_PWR_DWN		BIT(0)
> +#define AFE440X_CNTRL_2_PWR_DWN_RX	BIT(1)
> +#define AFE440X_CNTRL_2_DYNAMIC4	BIT(3)
> +#define AFE440X_CNTRL_2_DYNAMIC3	BIT(4)
> +#define AFE440X_CNTRL_2_OSC_EN		BIT(9)
> +#define AFE440X_CNTRL_2_DYNAMIC2	BIT(14)
> +#define AFE440X_CNTRL_2_DYNAMIC1	BIT(20)
> +
> +/* LED_CNTRL register */
> +#define AFE440X_LED_CNTRL_LED_MASK	0x3f
> +#define AFE440X_LED_CNTRL_LED_SHIFT	6
> +
> +/* TIA_GAIN and TIA_AMB_GAIN Register */
> +#define AFE440X_TIA_GAIN_RES_MASK	0x7
> +#define AFE440X_TIA_GAIN_CAP_MASK	0x38
> +#define AFE440X_TIA_GAIN_CAP_SHIFT	3
> +#define AFE440X_TIA_GAIN_SEP_GAIN_SHIFT	0xf
> +#define AFE440X_TIA_GAIN_SEP_GAIN_MASK	0x8000
> +
> +/* TIA_GAIN Register */
> +#define AFE440X_TIA_GAIN_RES_500_K	0x0
> +#define AFE440X_TIA_GAIN_RES_250_K	0x1
> +#define AFE440X_TIA_GAIN_RES_100_K	0x2
> +#define AFE440X_TIA_GAIN_RES_50_K	0x3
> +#define AFE440X_TIA_GAIN_RES_25_K	0x4
> +#define AFE440X_TIA_GAIN_RES_10_K	0x5
> +#define AFE440X_TIA_GAIN_RES_1_M	0x6
> +
> +
> +struct afe440x_chan_map {
> +	int channel;
> +	unsigned char reg;
> +};
> +
> +#endif
> 

