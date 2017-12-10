Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751999AbdLJRLm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Dec 2017 12:11:42 -0500
Date: Sun, 10 Dec 2017 17:11:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marius Tarcatu <marius.tarcatu@infineon.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/2] iio: magnetometer: Add Infineon TLV493D-A1B6
Message-ID: <20171210171137.729365fe@archlinux>
In-Reply-To: <alpine.DEB.2.20.1712100953090.28826@vps.pmeerw.net>
References: <20171209232507.18594-1-afaerber@suse.de>
        <20171209232507.18594-3-afaerber@suse.de>
        <alpine.DEB.2.20.1712100953090.28826@vps.pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 10 Dec 2017 10:08:04 +0100 (CET)
Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:

> > The Infineon TLV493D is a 3D magnetic sensor, A1B6 is I2C based.  
> 
> comments below
A few additions from me, but Peter got most stuff.

You could make the driver safe for i2c DMA but it's borderline
on whether any of the transfers are long enough to make it worth
bothering.

Jonathan

>  
> > It is found among others on the Infineon 3D Magnetic Sensor 2Go Kit,
> > which allows to detach the sensor as a breakout board.
> > 
> > Cc: Marius Tarcatu <marius.tarcatu@infineon.com>
> > Signed-off-by: Andreas Färber <afaerber@suse.de>
> > ---
> >  drivers/iio/magnetometer/Kconfig   |   9 +
> >  drivers/iio/magnetometer/Makefile  |   2 +
> >  drivers/iio/magnetometer/tlv493d.c | 328 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 339 insertions(+)
> >  create mode 100644 drivers/iio/magnetometer/tlv493d.c
> > 
> > diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> > index ed9d776d01af..5945d88a1595 100644
> > --- a/drivers/iio/magnetometer/Kconfig
> > +++ b/drivers/iio/magnetometer/Kconfig
> > @@ -175,4 +175,13 @@ config SENSORS_HMC5843_SPI
> >  	  - hmc5843_core (core functions)
> >  	  - hmc5843_spi (support for HMC5983)
> >  
> > +config TLV493D
> > +	tristate "Infineon TLV493D 3D Magnetic Sensor"
> > +	depends on I2C
> > +	help
> > +	  Say Y here to build support for Infineon TLV493D-A1B6 I2C-based
> > +	  3-axis magnetometer.
> > +
> > +	  This driver can also be built as a module and will be called tlv493d.
> > +
> >  endmenu
> > diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
> > index 664b2f866472..df6ad23fee65 100644
> > --- a/drivers/iio/magnetometer/Makefile
> > +++ b/drivers/iio/magnetometer/Makefile
> > @@ -24,3 +24,5 @@ obj-$(CONFIG_IIO_ST_MAGN_SPI_3AXIS) += st_magn_spi.o
> >  obj-$(CONFIG_SENSORS_HMC5843)		+= hmc5843_core.o
> >  obj-$(CONFIG_SENSORS_HMC5843_I2C)	+= hmc5843_i2c.o
> >  obj-$(CONFIG_SENSORS_HMC5843_SPI)	+= hmc5843_spi.o
> > +
> > +obj-$(CONFIG_TLV493D) += tlv493d.o
> > diff --git a/drivers/iio/magnetometer/tlv493d.c b/drivers/iio/magnetometer/tlv493d.c
> > new file mode 100644
> > index 000000000000..d2fe296b2c80
> > --- /dev/null
> > +++ b/drivers/iio/magnetometer/tlv493d.c
> > @@ -0,0 +1,328 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Infineon TLV493D-A1B6 3D magnetic sensor  
> 
> link to datasheet would be nice
> 
> > + *
> > + * Copyright (c) 2016-2017 Andreas Färber
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/i2c.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +
> > +#define MOD1_LOW	BIT(0)
> > +#define MOD1_FAST	BIT(1)
> > +#define MOD1_INT	BIT(2)
> > +#define MOD1_P		BIT(7)
> > +
> > +#define MOD2_PT		BIT(5)  
> 
> please use TLV493D_ prefix; more descriptive naming or comments would be 
> nice
> 
> > +struct tlv493d {
> > +	struct i2c_client *i2c;
> > +	struct iio_mount_matrix mount_matrix;
> > +	u8 factset1, factset2, factset3;
> > +};
> > +
> > +static int tlv493d_read_regs(struct tlv493d *s, u8 *buf, int len)
> > +{
> > +	int ret;
> > +
> > +	ret = i2c_master_recv(s->i2c, buf, len);
> > +	if (ret < len) {
> > +		dev_err(&s->i2c->dev, "failed to read registers (%d)", ret);
> > +		return ret;
> > +	}

This wrapper doesn't really add much to my mind. I would just put the
i2c_master_recv directly inline.

> > +
> > +	return 0;
> > +}
> > +
> > +static unsigned int tlv493d_parity(u32 v)
> > +{
> > +	v ^= v >> 16;
> > +	v ^= v >> 8;
> > +	v ^= v >> 4;
> > +	v &= 0xf;
> > +	return (0x6996 >> v) & 1;
> > +}
> > +
> > +#define MOD1_RES_MASK		(0x3 << 3)
> > +#define MOD1_IICADDR_MASK	(0x3 << 5)  
> 
> maybe move all these #defines on top of the file?
> 
> > +static int tlv493d_write_regs(struct tlv493d *s, const u8 *regs, int len)
> > +{
> > +	u8 buf[4];
> > +	int ret;
> > +
> > +	if (len != ARRAY_SIZE(buf))
> > +		return -EINVAL;  
> 
> why have this parameter if it is always 4?
> 
> > +	buf[0] = 0;
> > +	buf[1] = s->factset1 & (MOD1_IICADDR_MASK | MOD1_RES_MASK);
> > +	buf[1] |= regs[1] & ~(MOD1_P | MOD1_IICADDR_MASK | MOD1_RES_MASK);
> > +	buf[2] = s->factset2;
> > +	buf[3] = MOD2_PT | (s->factset3 & 0x1f);
> > +	buf[3] |= regs[3] & ~(MOD2_PT | 0x1f);
> > +
> > +	if ((buf[3] & MOD2_PT) &&
> > +	    !tlv493d_parity((buf[0] << 24) | (buf[1] << 16) | (buf[2] << 8) | buf[3]))
> > +		buf[1] |= MOD1_P;
> > +
> > +	ret = i2c_master_send(s->i2c, buf, 4);  
> 
> use sizeof(buf) instead of 4?
> 
> > +	if (ret < 4) {
> > +		dev_err(&s->i2c->dev, "failed to write registers (%d)", ret);
> > +		return ret;
If you hit the partial send condition then you should change the ret to
something to indicate this as an error.  -EIO perhaps.

> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int tlv493d_power_down(struct tlv493d *s)
> > +{
> > +	u8 buf[4];  
> 
> maybe
> u8 buf[4] = {0,};
> > +
> > +	buf[0] = 0;
> > +	buf[1] = 0;
> > +	buf[2] = 0;
> > +	buf[3] = 0;
> > +	return tlv493d_write_regs(s, buf, 4);
> > +}
> > +
> > +static const struct iio_mount_matrix *
> > +tlv493d_get_mount_matrix(const struct iio_dev *indio_dev,
> > +	const struct iio_chan_spec *chan)
> > +{
> > +	struct tlv493d *s = iio_priv(indio_dev);
> > +
> > +	return &s->mount_matrix;
> > +}
> > +
> > +static const struct iio_chan_spec_ext_info tlv493d_ext_info[] = {
> > +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, tlv493d_get_mount_matrix),
> > +	{}
> > +};
> > +
> > +#define TLV493D_AXIS_CHANNEL(axis, index)			\
> > +	{							\
> > +		.type = IIO_MAGN,				\
> > +		.channel2 = IIO_MOD_##axis,			\
> > +		.modified = 1,					\
> > +		.address = index,				\
> > +		.scan_index = index,				\
> > +		.scan_type = {					\  
> 
> IIO buffer reads are not supported by the driver, so no need for 
> .scan_type (here and for _TEMP)
> 
> > +			.sign = 's',				\
> > +			.realbits = 12,				\
> > +			.storagebits = 16,			\
> > +			.endianness = IIO_CPU,			\
> > +		},						\
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
> > +			BIT(IIO_CHAN_INFO_PROCESSED),		\  
> 
> either _RAW or _PROCESSED, not both
> 
> > +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> > +		.ext_info = tlv493d_ext_info,			\
> > +	}
> > +
> > +#define TLV493D_TEMP_CHANNEL(index)				\
> > +	{							\
> > +		.type = IIO_TEMP,				\
> > +		.channel2 = IIO_MOD_TEMP_OBJECT,		\
> > +		.modified = 1,					\
> > +		.address = index,				\
> > +		.scan_index = index,				\
> > +		.scan_type = {					\
> > +			.sign = 's',				\
> > +			.realbits = 12,				\
> > +			.storagebits = 16,			\
> > +			.endianness = IIO_CPU,			\
> > +		},						\
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
> > +			BIT(IIO_CHAN_INFO_OFFSET) |		\
> > +			BIT(IIO_CHAN_INFO_SCALE) |		\
> > +			BIT(IIO_CHAN_INFO_PROCESSED),		\
> > +	}
> > +
> > +static const struct iio_chan_spec tlv493d_channels[] = {
> > +	TLV493D_AXIS_CHANNEL(X, 0),
> > +	TLV493D_AXIS_CHANNEL(Y, 1),
> > +	TLV493D_AXIS_CHANNEL(Z, 2),
> > +	TLV493D_TEMP_CHANNEL(3),
> > +	IIO_CHAN_SOFT_TIMESTAMP(4),
> > +};
> > +
> > +static const unsigned long tlv493d_scan_masks[] = { 0xf, 0 };
> > +
> > +static int tlv493d_read_raw(struct iio_dev *indio_dev,
> > +	struct iio_chan_spec const *chan,
> > +	int *val, int *val2, long mask)
> > +{
> > +	struct tlv493d *s = iio_priv(indio_dev);
> > +	u8 buf[7];
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_PROCESSED:
> > +	case IIO_CHAN_INFO_RAW:  
> 
> this is ugly, why support _PROCESSED? 
> just _RAW is fine

And preferred.  Depending on what userspace is doing with
the values, it may be able to work in the _raw units directly
and avoid the cost of the conversions.

> 
> > +		do {
> > +			ret = tlv493d_read_regs(s, buf, 7);
> > +			if (ret)
> > +				return ret;
> > +		} while ((buf[3] & 0x3) || (buf[5] & BIT(4)));  
> 
> maybe add a timeout or limit the number of retries
> 
> > +
> > +		switch (chan->address) {
> > +		case 0:

Wow. That is novel data arranging.  You have my sympathies!

> > +			*val = (((int)(s8)buf[0]) << 4) | (buf[4] >> 4);
> > +			break;
> > +		case 1:
> > +			*val = (((int)(s8)buf[1]) << 4) | (buf[4] & 0xf);
> > +			break;
> > +		case 2:
> > +			*val = (((int)(s8)buf[2]) << 4) | (buf[5] & 0xf);
> > +			break;
> > +		case 3:
> > +			*val = (((int)(s8)(buf[3] & 0xf0)) << 4) | buf[6];
> > +			if (mask != IIO_CHAN_INFO_RAW)
> > +				*val -= 340;
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +		*val2 = 0;  
> 
> no need to set val2 if returning VAL_INT
> 
> > +		if (mask == IIO_CHAN_INFO_RAW)
> > +			return IIO_VAL_INT;
> > +
> > +		switch (chan->type) {
> > +		case IIO_MAGN:
> > +			*val2 = (*val * 1000000) * 98 / 1000;
> > +			*val = *val2 / 1000000;
> > +			*val2 %= 1000000;
> > +			break;
> > +		case IIO_TEMP:
> > +			*val2 = (*val * 1000000) * 11 / 10;
> > +			*val = *val2 / 1000000;
> > +			*val2 %= 1000000;
> > +			/* According to datasheet, LSB offset is for 25°C */
> > +			*val += 25;
> > +			break;
We shouldn't be exporting processed values to userspace unless we can't
well represent them using the _raw, _scale, _offset triplet.

It's up to userspace tools to do the conversion if they wish to.

> > +		default:
> > +			return -EINVAL;
> > +		}
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	case IIO_CHAN_INFO_OFFSET:
> > +		switch (chan->type) {
> > +		case IIO_TEMP:
> > +			*val = -340;
> > +			*val2 = 0;  
> 
> no need to set val2
> 
> > +			return IIO_VAL_INT;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_SCALE:
> > +		switch (chan->type) {
> > +		case IIO_MAGN:
> > +			/* 0.098 mT/LSB */

Units for magnetic field in IIO are Gauss. 
(see doc referenced below).

> > +			*val = 0;
> > +			*val2 = 98000;
> > +			return IIO_VAL_INT_PLUS_MICRO;
> > +		case IIO_TEMP:
> > +			/* 1.1 °C/LSB */
> > +			*val = 1;
> > +			*val2 = 100000;
> > +			return IIO_VAL_INT_PLUS_MICRO;
See Documentation/ABI/testing/sysfs-bus-iio.

For historical reasons (we copied hwmon) temperature units after
scaling need to be micro degrees Celsius.

It is something I wish we had differently (because it is inconsistent)
but we are stuck with it.

> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static const struct iio_info tlv493d_iio_info = {
> > +	.read_raw = tlv493d_read_raw,
> > +};
> > +
> > +static int tlv493d_probe(struct i2c_client *i2c)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct tlv493d *tlv493d;
> > +	u8 buf[10];
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(&i2c->dev, sizeof(*tlv493d));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	tlv493d = iio_priv(indio_dev);
> > +	i2c_set_clientdata(i2c, indio_dev);
> > +	tlv493d->i2c = i2c;
> > +
> > +	ret = of_iio_read_mount_matrix(&i2c->dev, "mount-matrix",
> > +		&tlv493d->mount_matrix);
> > +	if (ret)
> > +		return ret;
> > +
> > +	indio_dev->dev.parent = &i2c->dev;
> > +	indio_dev->channels = tlv493d_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(tlv493d_channels);
> > +	indio_dev->info = &tlv493d_iio_info;
> > +	indio_dev->available_scan_masks = tlv493d_scan_masks;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->name = "tlv493d";
> > +
> > +	ret = tlv493d_read_regs(tlv493d, buf, 10);
> > +	if (ret)
> > +		return ret;
> > +
> > +	tlv493d->factset1 = buf[7];
> > +	tlv493d->factset2 = buf[8];
> > +	tlv493d->factset3 = buf[9];
> > +
> > +	buf[0] = 0;
> > +	buf[1] = MOD1_FAST | MOD1_LOW;  
> 
> what does this mean? some comment explaining the default mode?
> 
> > +	buf[2] = 0;
> > +	buf[3] = 0;
> > +	ret = tlv493d_write_regs(tlv493d, buf, 4);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = iio_device_register(indio_dev);
> > +	if (ret) {
> > +		dev_err(&i2c->dev, "device registration failed");
> > +		tlv493d_power_down(tlv493d);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int tlv493d_remove(struct i2c_client *i2c)
> > +{
> > +	struct iio_dev *indio_dev = i2c_get_clientdata(i2c);
> > +	struct tlv493d *tlv493d = iio_priv(indio_dev);
> > +
> > +	iio_device_unregister(indio_dev);
> > +
> > +	tlv493d_power_down(tlv493d);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id tlv493d_dt_ids[] = {
> > +	{ .compatible = "infineon,tlv493d-a1b6" },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(of, tlv493d_dt_ids);
> > +
> > +static struct i2c_driver tlv493d_i2c_driver = {
> > +	.driver = {
> > +		.name = "tlv493d",
> > +		.of_match_table = tlv493d_dt_ids,
> > +	},
> > +	.probe_new = tlv493d_probe,
> > +	.remove = tlv493d_remove,
> > +};
> > +
> > +module_i2c_driver(tlv493d_i2c_driver);
> > +
> > +MODULE_DESCRIPTION("TLV493D I2C driver");
> > +MODULE_AUTHOR("Andreas Faerber");
> > +MODULE_LICENSE("GPL");
> >   
> 

