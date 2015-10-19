Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:34129 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbbJSM0l (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Oct 2015 08:26:41 -0400
Received: by igbni9 with SMTP id ni9so53089762igb.1
        for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2015 05:26:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1510191249580.9654@pmeerw.net>
References: <1445120719-29685-1-git-send-email-manabian@gmail.com>
	<alpine.DEB.2.02.1510191249580.9654@pmeerw.net>
Date: Mon, 19 Oct 2015 14:26:40 +0200
Message-ID: <CAGhQ9Vx4Qf9SHKoKvESQejrO3mKmmYVsbdmjPNk-TMAQroBnNw@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: add Freescale MMA7455L 3-axis accelerometer driver
From: Joachim Eastwood <manabian@gmail.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: jic23@kernel.org, knaack.h@gmx.de,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Peter,

On 19 October 2015 at 13:00, Peter Meerwald <pmeerw@pmeerw.net> wrote:
>
>> Add support for Freescale MMA7455L 3-axis in 10-bit mode with both
>> I2C and SPI bus support. This is a rather simple driver that
>> currently doesn't support all the hardware features of MMA7455L.
>
> please add a link to the datasheet

Sure.

>
> comments below
>
>> Tested on Embedded Artists' LPC4357 Dev Kit using I2C bus.
>>
>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>> ---
>>
>>  drivers/iio/accel/Kconfig   |  14 ++
>>  drivers/iio/accel/Makefile  |   1 +
>>  drivers/iio/accel/mma7455.c | 424 ++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 439 insertions(+)
>>  create mode 100644 drivers/iio/accel/mma7455.c
>>
>> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
>> index a59047d7657e..8ccb3de85484 100644
>> --- a/drivers/iio/accel/Kconfig
>> +++ b/drivers/iio/accel/Kconfig
>> @@ -99,6 +99,20 @@ config KXCJK1013
>>         To compile this driver as a module, choose M here: the module will
>>         be called kxcjk-1013.
>>
>> +config MMA7455
>> +     tristate "Freescale MMA7455L Accelerometer Driver"
>> +     depends on I2C || SPI_MASTER
>> +     select IIO_BUFFER
>> +     select IIO_TRIGGERED_BUFFER
>> +     select REGMAP_I2C if I2C
>> +     select REGMAP_SPI if SPI_MASTER
>> +     help
>> +       Say yes here to build support for the Freescale MMA7455L 3-axis
>> +       accelerometer.
>> +
>> +       To compile this driver as a module, choose M here: the module
>> +       will be called mma7455.
>> +
>>  config MMA8452
>>       tristate "Freescale MMA8452Q Accelerometer Driver"
>>       depends on I2C
>> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
>> index ebd2675b2a02..6ac9382761f8 100644
>> --- a/drivers/iio/accel/Makefile
>> +++ b/drivers/iio/accel/Makefile
>> @@ -8,6 +8,7 @@ obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel.o
>>  obj-$(CONFIG_HID_SENSOR_ACCEL_3D) += hid-sensor-accel-3d.o
>>  obj-$(CONFIG_KXCJK1013) += kxcjk-1013.o
>>  obj-$(CONFIG_KXSD9)  += kxsd9.o
>> +obj-$(CONFIG_MMA7455)        += mma7455.o
>>  obj-$(CONFIG_MMA8452)        += mma8452.o
>>
>>  obj-$(CONFIG_MMA9551_CORE)   += mma9551_core.o
>> diff --git a/drivers/iio/accel/mma7455.c b/drivers/iio/accel/mma7455.c
>> new file mode 100644
>> index 000000000000..fa62f2bcb54a
>> --- /dev/null
>> +++ b/drivers/iio/accel/mma7455.c
>> @@ -0,0 +1,424 @@
>> +/*
>> + * mma7455.c - Support for Freescale MMA7455L 3-axis 10-bit accelerometer
>> + * Copyright 2015 Joachim Eastwood <manabian@gmail.com>
>> + *
>> + * Based on MMA8452Q IIO driver
>> + * Copyright 2014 Peter Meerwald <pmeerw@pmeerw.net>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * UNSUPPORTED hardware features:
>> + *  - 8-bit mode with different scales
>> + *  - INT1/INT2 interrupts
>> + *  - Offset calibration
>> + *  - Events
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/i2c.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>> +#include <linux/iio/buffer.h>
>> +#include <linux/iio/trigger.h>
>> +#include <linux/iio/trigger_consumer.h>
>> +#include <linux/iio/triggered_buffer.h>
>> +#include <linux/module.h>
>> +#include <linux/regmap.h>
>> +#include <linux/spi/spi.h>
>> +
>> +#define MMA7455_REG_XOUTL            0x00
>> +#define MMA7455_REG_XOUTH            0x01
>> +#define MMA7455_REG_YOUTL            0x02
>> +#define MMA7455_REG_YOUTH            0x03
>> +#define MMA7455_REG_ZOUTL            0x04
>> +#define MMA7455_REG_ZOUTH            0x05
>> +#define MMA7455_REG_STATUS           0x09
>> +#define  MMA7455_STATUS_DRDY         BIT(0)
>
> whitespace inconsistencies

This is actually intentional and used to show that it is a field in a
register. If you don't like it I can remove it.

>> +#define MMA7455_REG_WHOAMI           0x0f
>> +#define  MMA7455_WHOAMI_ID           0x55
>> +#define MMA7455_REG_MCTL             0x16
>> +#define  MMA7455_MCTL_MODE_STANDBY   0x00
>> +#define  MMA7455_MCTL_MODE_MEASURE   0x01
>> +#define MMA7455_REG_CTL1             0x18
>> +#define  MMA7455_CTL1_DFBW_MASK              BIT(7)
>> +#define  MMA7455_CTL1_DFBW_125HZ     BIT(7)
>> +#define  MMA7455_CTL1_DFBW_62_5HZ    0
>> +#define MMA7455_REG_TW                       0x1e
>> +
>> +/*
>> + * When MMA7455 is used in 10-bit it has a fullscale of -8g
>> + * corresponding to raw value -512. The userspace interface
>> + * uses m/s^2 and we declare micro units.
>> + * So scale factor is given by:
>> + *       g * 8 * 1e6 / 512 = 153228.90625, with g = 9.80665
>> + */
>> +#define MMA7455_10BIT_SCALE  153229
>> +
>> +struct mma7455_data {
>> +     struct regmap *regmap;
>> +     struct device *dev;
>> +};
>> +
>> +static int mma7455_drdy(struct mma7455_data *mma7455)
>> +{
>> +     unsigned int reg;
>> +     int tries = 10;
>> +     int ret;
>> +
>> +     while (tries-- > 0) {
>> +             ret = regmap_read(mma7455->regmap, MMA7455_REG_STATUS, &reg);
>> +             if (ret)
>> +                     return ret;
>> +
>> +             if (reg & MMA7455_STATUS_DRDY)
>> +                     return 0;
>> +
>> +             msleep(20);
>> +     }
>> +
>> +     dev_warn(mma7455->dev, "data not ready\n");
>> +
>> +     return -EIO;
>> +}
>> +
>> +static irqreturn_t mma7455_trigger_handler(int irq, void *p)
>> +{
>> +     struct iio_poll_func *pf = p;
>> +     struct iio_dev *indio_dev = pf->indio_dev;
>> +     struct mma7455_data *mma7455 = iio_priv(indio_dev);
>> +     u8 buf[16]; /* 3 x 16-bit channels + padding + ts */
>> +     int ret;
>> +
>> +     ret = mma7455_drdy(mma7455);
>> +     if (ret)
>> +             goto done;
>> +
>> +     ret = regmap_bulk_read(mma7455->regmap, MMA7455_REG_XOUTL, buf,
>> +                            sizeof(s16) * 3);
>
> use le16 to hint which endianness the device registers have

OK.

>> +     if (ret)
>> +             goto done;
>> +
>> +     iio_push_to_buffers_with_timestamp(indio_dev, buf, iio_get_time_ns());
>> +
>> +done:
>> +     iio_trigger_notify_done(indio_dev->trig);
>> +
>> +     return IRQ_HANDLED;
>> +}
>> +
>> +static int mma7455_read_raw(struct iio_dev *indio_dev,
>> +                         struct iio_chan_spec const *chan,
>> +                         int *val, int *val2, long mask)
>> +{
>> +     struct mma7455_data *mma7455 = iio_priv(indio_dev);
>> +     unsigned int reg = 0;
>
> initialization not needed

I think it may complain when used in regmap_bulk_read() later. I'll check.


>> +     int ret;
>> +
>> +     switch (mask) {
>> +     case IIO_CHAN_INFO_RAW:
>> +             if (iio_buffer_enabled(indio_dev))
>> +                     return -EBUSY;
>> +
>> +             ret = mma7455_drdy(mma7455);
>> +             if (ret)
>> +                     return ret;
>> +
>> +             ret = regmap_bulk_read(mma7455->regmap, chan->scan_index * 2,
>
> it would be clearer to use chan->address instead of computing the register

ah, I didn't noticed the address field in chan_spec. I'll use that in
the next version.

>
> instead of s16 I suggest to use le16

OK.

> using regmap_bulk_read(), there is no endianness conversion; the driver
> will only work when chip endianness equals CPU endianness

I'll add conversion using the to_cpu-functions in the next version.

>
>> +                                    &reg, sizeof(s16));
>> +             if (ret)
>> +                     return ret;
>> +
>> +             *val = sign_extend32(reg, 9);
>> +
>> +             return IIO_VAL_INT;
>> +
>> +     case IIO_CHAN_INFO_SCALE:
>> +             *val = 0;
>> +             *val2 = MMA7455_10BIT_SCALE;
>> +
>> +             return IIO_VAL_INT_PLUS_MICRO;
>> +
>> +     case IIO_CHAN_INFO_SAMP_FREQ:
>> +             ret = regmap_read(mma7455->regmap, MMA7455_REG_CTL1, &reg);
>> +             if (ret)
>> +                     return ret;
>> +
>> +             if (reg & MMA7455_CTL1_DFBW_MASK)
>> +                     *val = 250;
>> +             else
>> +                     *val = 125;
>> +
>> +             return IIO_VAL_INT;
>> +     }
>> +
>> +     return -EINVAL;
>> +}
>> +
>> +static int mma7455_write_raw(struct iio_dev *indio_dev,
>> +                          struct iio_chan_spec const *chan,
>> +                          int val, int val2, long mask)
>> +{
>> +     struct mma7455_data *mma7455 = iio_priv(indio_dev);
>> +     int i;
>> +
>> +     if (iio_buffer_enabled(indio_dev))
>> +             return -EBUSY;
>> +
>> +     switch (mask) {
>> +     case IIO_CHAN_INFO_SAMP_FREQ:
>
> check val2 == 0

OK.

>> +             if (val == 250)
>> +                     i = MMA7455_CTL1_DFBW_125HZ;
>> +             else if (val == 125)
>> +                     i = MMA7455_CTL1_DFBW_62_5HZ;
>> +             else
>> +                     return -EINVAL;
>> +
>> +             return regmap_update_bits(mma7455->regmap, MMA7455_REG_CTL1,
>> +                                       MMA7455_CTL1_DFBW_MASK, i);
>> +
>> +     case IIO_CHAN_INFO_SCALE:
>> +             /* In 10-bit mode there is only one scale available */
>> +             if (val == 0 && val2 == MMA7455_10BIT_SCALE)
>> +                     return 0;
>> +             break;
>> +     }
>> +
>> +     return -EINVAL;
>> +}


Thanks for reviewing, I'll implement the changes in the next version.


regards,
Joachim Eastwood
