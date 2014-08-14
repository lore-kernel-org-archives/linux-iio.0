Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55018 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493AbaHNU4v (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 Aug 2014 16:56:51 -0400
Date: Thu, 14 Aug 2014 15:56:05 -0500
From: Felipe Balbi <balbi@ti.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: <balbi@ti.com>, <linux-iio@vger.kernel.org>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3] iio: ligth: add support for TI's opt3001 ligth sensor
Message-ID: <20140814205605.GF4929@saruman.home>
Reply-To: <balbi@ti.com>
References: <1407940605-12270-1-git-send-email-balbi@ti.com>
 <53ECE90A.8010609@kernel.org>
 <20140814170530.GB1445@saruman.home>
 <53ECF070.5040304@kernel.org>
 <20140814201744.GA4929@saruman.home>
 <53ED1CE7.3070606@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nYySOmuH/HDX6pKp"
In-Reply-To: <53ED1CE7.3070606@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

--nYySOmuH/HDX6pKp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 14, 2014 at 09:32:39PM +0100, Jonathan Cameron wrote:
> >>>>> TI's opt3001 light sensor is a simple and yet powerful
> >>>>> little device. The device provides 99% IR rejection,
> >>>>> Automatic full-scale, very low power consumption and
> >>>>> measurements from 0.01 to 83k lux.
> >>>>>
> >>>>> This patch adds support for that device using the IIO
> >>>>> framework.
> >>>>>
> >>>>> Signed-off-by: Felipe Balbi <balbi@ti.com>
> >>>> Please fix your patch title spelling of light!
> >>>
> >>> alright done and sent another version too.
> >>>
> >>>> I'm not keen on the ordering during remove and
> >>>> your use of hysteresis does not conform to the ABI so please
> >>>> take a look at that and the other drivers that make use of it.
> >>>
> >>> see below
> >>>
> >>>> Hystersis is documented in Documentation/ABI/testing/sysfs-bus-iio
> >>>>
> >>>> Specifies the hysteresis of threshold that the device is comparing
> >>>> 	against for the events enabled by
> >>>> 	<type>Y[_name]_thresh[_(rising|falling)]_hysteresis.
> >>>
> >>> this is exactly what the driver is doing, read again
> >> This is really hard without access to the datasheet.  It appeared you =
were
> >> simply enabling hystersis on an event if the threshold was written to =
that.
> >>
> >> The threshold would be the one written by using the value attribute.
> >>
> >> So right now if you set hystersis to 10 then value will also be set to=
 10.
> >>
> >> Hence, if the value reaches 10 once.  An event is triggered.  After th=
at
> >> for another event the value will have to hit 10 - 10 =3D 0 before again
> >> passing 10.
> >>
> >> Is this really what is happening?
> >=20
> > yes it is. It's confusing because the same value register is used for
> > hysteresis and non-hysteresis modes.
> Seems decidely odd given that will mean that the hysterisis effectively m=
eans you
> always have to return to 0 before you get another event...

it kinda depends on what you write the low and high limit registers. The
way I tested as setting high limit to 200 and low limit to 500. So
everytime it was brigther than 200lux, I'd get a rising edge irq and
everytime it was darker than 500 lux, I'd get a falling edge irq.

You can, of course, invert those values and even make them the same, but
the behavior will change accordingly

> >>>>> +static int opt3001_read_id(struct opt3001 *opt)
> >>>>> +{
> >>>>> +	char manufacturer[2];
> >>>>> +	u16 device_id;
> >>>>> +	int ret;
> >>>>> +
> >>>>> +	ret =3D i2c_smbus_read_word_swapped(opt->client, OPT3001_MANUFACT=
URER_ID);
> >>>>> +	if (ret < 0) {
> >>>>> +		dev_err(opt->dev, "failed to read register %02x\n",
> >>>>> +				OPT3001_MANUFACTURER_ID);
> >>>>> +		return ret;
> >>>>> +	}
> >>>>> +
> >>>>> +	manufacturer[0] =3D ret >> 8;
> >>>>> +	manufacturer[1] =3D ret & 0xff;
> >>>> I would be a little 'unusual' but you could use an endian conversion=
 here :)
> >>>> Perhaps better to have the clarity of the way you have done it!
> >>>
> >>> byte ordering is already handled by read_word_swapped, though.
> >> Fair point.  Not an endian conversion, but rather an evil bit of type
> >> casting that isn't worth bothering with.
> >=20
> > right, so what you wanna do with this ?
> nope.  Realised I was being silly ;)

oh, alright.

> >>> It's also unnecessary to check if we have a continuous
> >>> transfer running because shutting down something which is already
> >>> shutdown won't cause any problems with this device.
> >>>
> >>> Dropping devm_* would just add pointless complexity to the remove
> >>> function.
> >>
> >> But make it obviously correct, which it isn't right now.  For the
> >> cost of about 4 lines of code...
> >=20
> > it's more than that since we'll have to add more lines of code to handle
> > error inside the probe() function. Frankly, it's pretty pointless to go
> > down that route; if that's really what you want, I'll do it. Coudln't
> > care less, really.
> >=20
> I would prefer it or else I'll be wondering why it is like this when
> I next look at the driver a few years down the line!  Extensive commenting
> would work as well, but that's probably more complex that just making the
> code 'simple' from an is it right point of view!

alright, I'll change it.

> Thanks and sorry for being a bit of a pain on this!

don't worry ;-)

below you can find final version, if you're ok with it, you can apply
with git am --scissors

8<----------------------------------------------------------------------

=46rom 365b61c7880cdc94bf818dce3c04cf4c0cecad19 Mon Sep 17 00:00:00 2001
=46rom: Felipe Balbi <balbi@ti.com>
Date: Fri, 1 Aug 2014 14:48:25 -0500
Subject: [PATCH] iio: light: add support for TI's opt3001 light sensor

TI's opt3001 light sensor is a simple and yet powerful
little device. The device provides 99% IR rejection,
Automatic full-scale, very low power consumption and
measurements from 0.01 to 83k lux.

This patch adds support for that device using the IIO
framework.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/iio/light/Kconfig   |  10 +
 drivers/iio/light/Makefile  |   1 +
 drivers/iio/light/opt3001.c | 753 ++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 764 insertions(+)
 create mode 100644 drivers/iio/light/opt3001.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index bf05ca5..f196996 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -128,6 +128,16 @@ config LTR501
 	 This driver can also be built as a module.  If so, the module
          will be called ltr501.
=20
+config OPT3001
+	tristate "Texas Instruments OPT3001 Light Sensor"
+	depends on I2C
+	help
+	  If you say Y or M here, you get support for Texas Instruments
+	  OPT3001 Ambient Light Sensor.
+
+	  If built as a dynamically linked module, it will be called
+	  opt3001.
+
 config TCS3414
 	tristate "TAOS TCS3414 digital color sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index 8b8c09f..898ef13 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_HID_SENSOR_PROX)	+=3D hid-sensor-prox.o
 obj-$(CONFIG_ISL29125)		+=3D isl29125.o
 obj-$(CONFIG_SENSORS_LM3533)	+=3D lm3533-als.o
 obj-$(CONFIG_LTR501)		+=3D ltr501.o
+obj-$(CONFIG_OPT3001)		+=3D opt3001.o
 obj-$(CONFIG_SENSORS_TSL2563)	+=3D tsl2563.o
 obj-$(CONFIG_TCS3414)		+=3D tcs3414.o
 obj-$(CONFIG_TCS3472)		+=3D tcs3472.o
diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
new file mode 100644
index 0000000..99c5f09
--- /dev/null
+++ b/drivers/iio/light/opt3001.c
@@ -0,0 +1,753 @@
+/**
+ * opt3001.c - Texas Instruments OPT3001 Light Sensor
+ *
+ * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com
+ *
+ * Author: Felipe Balbi <balbi@ti.com>
+ *
+ * This program is free software: you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 of the Lice=
nse
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WIT=
HOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
+ * more details.
+ */
+
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#define OPT3001_RESULT		0x00
+#define OPT3001_CONFIGURATION	0x01
+#define OPT3001_LOW_LIMIT	0x02
+#define OPT3001_HIGH_LIMIT	0x03
+#define OPT3001_MANUFACTURER_ID	0x7e
+#define OPT3001_DEVICE_ID	0x7f
+
+#define OPT3001_CONFIGURATION_RN_MASK (0xf << 12)
+#define OPT3001_CONFIGURATION_RN_AUTO (0xc << 12)
+
+#define OPT3001_CONFIGURATION_CT	BIT(11)
+
+#define OPT3001_CONFIGURATION_M_MASK	(3 << 9)
+#define OPT3001_CONFIGURATION_M_SHUTDOWN (0 << 9)
+#define OPT3001_CONFIGURATION_M_SINGLE (1 << 9)
+#define OPT3001_CONFIGURATION_M_CONTINUOUS (2 << 9) /* also 3 << 9 */
+
+#define OPT3001_CONFIGURATION_OVF	BIT(8)
+#define OPT3001_CONFIGURATION_CRF	BIT(7)
+#define OPT3001_CONFIGURATION_FH	BIT(6)
+#define OPT3001_CONFIGURATION_FL	BIT(5)
+#define OPT3001_CONFIGURATION_L		BIT(4)
+#define OPT3001_CONFIGURATION_POL	BIT(3)
+#define OPT3001_CONFIGURATION_ME	BIT(2)
+
+#define OPT3001_CONFIGURATION_FC_MASK	(3 << 0)
+
+#define OPT3001_REG_EXPONENT(n)	((n) >> 12)
+#define OPT3001_REG_MANTISSA(n)	((n) & 0xfff)
+
+struct opt3001 {
+	struct i2c_client	*client;
+	struct device		*dev;
+
+	struct mutex		lock;
+
+	u32			int_time;
+	u32			mode;
+
+	u16			high_thresh_mantissa;
+	u16			low_thresh_mantissa;
+
+	u8			high_thresh_exp;
+	u8			low_thresh_exp;
+
+	unsigned int		hysteresis:1;
+};
+
+struct opt3001_scale {
+	int	val;
+	int	val2;
+};
+
+static const struct opt3001_scale opt3001_scales[] =3D {
+	{
+		.val =3D 40,
+		.val2 =3D 950000,
+	},
+	{
+		.val =3D 81,
+		.val2 =3D 900000,
+	},
+	{
+		.val =3D 81,
+		.val2 =3D 900000,
+	},
+	{
+		.val =3D 163,
+		.val2 =3D 800000,
+	},
+	{
+		.val =3D 327,
+		.val2 =3D 600000,
+	},
+	{
+		.val =3D 655,
+		.val2 =3D 200000,
+	},
+	{
+		.val =3D 1310,
+		.val2 =3D 400000,
+	},
+	{
+		.val =3D 2620,
+		.val2 =3D 800000,
+	},
+	{
+		.val =3D 5241,
+		.val2 =3D 600000,
+	},
+	{
+		.val =3D 10483,
+		.val2 =3D 200000,
+	},
+	{
+		.val =3D 20966,
+		.val2 =3D 400000,
+	},
+	{
+		.val =3D 83865,
+		.val2 =3D 600000,
+	},
+};
+
+static int opt3001_find_scale(const struct opt3001 *opt, int val,
+		int val2, u8 *exponent)
+{
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(opt3001_scales); i++) {
+		const struct opt3001_scale *scale =3D &opt3001_scales[i];
+
+		if (val <=3D scale->val && val2 <=3D scale->val2) {
+			*exponent =3D i;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static void opt3001_to_iio_ret(struct opt3001 *opt, u8 exponent,
+		u16 mantissa, int *val, int *val2)
+{
+	int lux;
+
+	lux =3D 10 * (mantissa << exponent);
+	*val =3D lux / 1000;
+	*val2 =3D (lux - (*val * 1000)) * 1000;
+}
+
+static void opt3001_set_mode(struct opt3001 *opt, u16 *reg, u16 mode)
+{
+	*reg &=3D ~OPT3001_CONFIGURATION_M_MASK;
+	*reg |=3D mode;
+	opt->mode =3D mode;
+}
+
+static IIO_CONST_ATTR_INT_TIME_AVAIL("0.1 0.8");
+
+static struct attribute *opt3001_attributes[] =3D {
+	&iio_const_attr_integration_time_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group opt3001_attribute_group =3D {
+	.attrs =3D opt3001_attributes,
+};
+
+static const struct iio_event_spec opt3001_event_spec[] =3D {
+	{
+		.type =3D IIO_EV_TYPE_THRESH,
+		.dir =3D IIO_EV_DIR_RISING,
+		.mask_separate =3D BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_HYSTERESIS) |
+			BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type =3D IIO_EV_TYPE_THRESH,
+		.dir =3D IIO_EV_DIR_FALLING,
+		.mask_separate =3D BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_HYSTERESIS) |
+			BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static const struct iio_chan_spec opt3001_channels[] =3D {
+	{
+		.type =3D IIO_LIGHT,
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED) |
+				BIT(IIO_CHAN_INFO_INT_TIME),
+		.event_spec =3D opt3001_event_spec,
+		.num_event_specs =3D ARRAY_SIZE(opt3001_event_spec),
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static int opt3001_get_lux(struct opt3001 *opt, int *val, int *val2)
+{
+	int ret;
+	u16 mantissa;
+	u16 reg;
+	u8 exponent;
+
+	ret =3D i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
+	if (ret < 0) {
+		dev_err(opt->dev, "failed to read register %02x\n",
+				OPT3001_CONFIGURATION);
+		return ret;
+	}
+
+	reg =3D ret;
+	opt3001_set_mode(opt, &reg, OPT3001_CONFIGURATION_M_SINGLE);
+
+	ret =3D i2c_smbus_write_word_swapped(opt->client, OPT3001_CONFIGURATION,
+			reg);
+	if (ret < 0) {
+		dev_err(opt->dev, "failed to write register %02x\n",
+				OPT3001_CONFIGURATION);
+		return ret;
+	}
+
+	/* wait for conversion and give it an extra 5ms */
+	usleep_range(opt->int_time + 5000, opt->int_time + 10000);
+
+	ret =3D i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
+	if (ret < 0) {
+		dev_err(opt->dev, "failed to read register %02x\n",
+				OPT3001_CONFIGURATION);
+		return ret;
+	}
+
+	reg =3D ret;
+	if (!(reg & OPT3001_CONFIGURATION_CRF))
+		return -EPIPE;
+
+	ret =3D i2c_smbus_read_word_swapped(opt->client, OPT3001_RESULT);
+	if (ret < 0) {
+		dev_err(opt->dev, "failed to read register %02x\n",
+				OPT3001_RESULT);
+		return ret;
+	}
+
+	exponent =3D OPT3001_REG_EXPONENT(ret);
+	mantissa =3D OPT3001_REG_MANTISSA(ret);
+
+	opt3001_to_iio_ret(opt, exponent, mantissa, val, val2);
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int opt3001_get_int_time(struct opt3001 *opt, int *val, int *val2)
+{
+	*val =3D 0;
+	*val2 =3D opt->int_time;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int opt3001_set_int_time(struct opt3001 *opt, int time)
+{
+	int ret;
+	u16 reg;
+
+	ret =3D i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
+	if (ret < 0) {
+		dev_err(opt->dev, "failed to read register %02x\n",
+				OPT3001_CONFIGURATION);
+		return ret;
+	}
+
+	reg =3D ret;
+
+	switch (time) {
+	case 100000:
+		reg &=3D ~OPT3001_CONFIGURATION_CT;
+		opt->int_time =3D 100000;
+		break;
+	case 800000:
+		reg |=3D OPT3001_CONFIGURATION_CT;
+		opt->int_time =3D 800000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return i2c_smbus_write_word_swapped(opt->client, OPT3001_CONFIGURATION,
+			reg);
+}
+
+static int opt3001_read_raw(struct iio_dev *iio,
+		struct iio_chan_spec const *chan, int *val, int *val2,
+		long mask)
+{
+	struct opt3001 *opt =3D iio_priv(iio);
+	int ret =3D 0;
+
+	if (opt->mode =3D=3D OPT3001_CONFIGURATION_M_CONTINUOUS)
+		return -EBUSY;
+
+	if (chan->type !=3D IIO_LIGHT)
+		return -EINVAL;
+
+	mutex_lock(&opt->lock);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+		ret =3D opt3001_get_lux(opt, val, val2);
+		break;
+	case IIO_CHAN_INFO_INT_TIME:
+		ret =3D opt3001_get_int_time(opt, val, val2);
+		break;
+	default:
+		ret =3D -EINVAL;
+	}
+
+	mutex_unlock(&opt->lock);
+
+	return ret;
+}
+
+static int opt3001_write_raw(struct iio_dev *iio,
+		struct iio_chan_spec const *chan, int val, int val2,
+		long mask)
+{
+	struct opt3001 *opt =3D iio_priv(iio);
+	int ret =3D 0;
+
+	if (opt->mode =3D=3D OPT3001_CONFIGURATION_M_CONTINUOUS)
+		return -EBUSY;
+
+	if (chan->type !=3D IIO_LIGHT)
+		return -EINVAL;
+
+	if (mask !=3D IIO_CHAN_INFO_INT_TIME)
+		return -EINVAL;
+
+	mutex_lock(&opt->lock);
+	ret =3D opt3001_set_int_time(opt, val);
+	mutex_unlock(&opt->lock);
+
+	return ret;
+}
+
+static int opt3001_read_event_value(struct iio_dev *iio,
+		const struct iio_chan_spec *chan, enum iio_event_type type,
+		enum iio_event_direction dir, enum iio_event_info info,
+		int *val, int *val2)
+{
+	struct opt3001 *opt =3D iio_priv(iio);
+	int ret =3D IIO_VAL_INT_PLUS_MICRO;
+
+	mutex_lock(&opt->lock);
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		opt3001_to_iio_ret(opt, opt->high_thresh_exp,
+				opt->high_thresh_mantissa, val, val2);
+		break;
+	case IIO_EV_DIR_FALLING:
+		opt3001_to_iio_ret(opt, opt->low_thresh_exp,
+				opt->low_thresh_mantissa, val, val2);
+		break;
+	default:
+		ret =3D -EINVAL;
+	}
+
+	mutex_unlock(&opt->lock);
+
+	return ret;
+}
+
+static int opt3001_write_event_value(struct iio_dev *iio,
+		const struct iio_chan_spec *chan, enum iio_event_type type,
+		enum iio_event_direction dir, enum iio_event_info info,
+		int val, int val2)
+{
+	struct opt3001 *opt =3D iio_priv(iio);
+	int ret =3D 0;
+
+	u16 mantissa;
+	u16 value;
+	u16 reg;
+
+	u8 exponent;
+
+	mutex_lock(&opt->lock);
+
+	ret =3D i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
+	if (ret < 0) {
+		dev_err(opt->dev, "failed to read register %02x\n",
+				OPT3001_CONFIGURATION);
+		goto err;
+	}
+
+	reg =3D ret;
+	if (info =3D=3D IIO_EV_INFO_HYSTERESIS)
+		opt->hysteresis =3D true;
+	else
+		opt->hysteresis =3D false;
+
+	ret =3D opt3001_find_scale(opt, val, val2, &exponent);
+	if (ret < 0) {
+		dev_err(opt->dev, "can't find scale for %d.%d\n", val, val2);
+		goto err;
+	}
+
+	mantissa =3D (((val * 1000) + (val2 / 1000)) / 10) >> exponent;
+	value =3D exponent << 12 | mantissa;
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		reg =3D OPT3001_HIGH_LIMIT;
+		opt->high_thresh_mantissa =3D mantissa;
+		opt->high_thresh_exp =3D exponent;
+		break;
+	case IIO_EV_DIR_FALLING:
+		reg =3D OPT3001_LOW_LIMIT;
+		opt->low_thresh_mantissa =3D mantissa;
+		opt->low_thresh_exp =3D exponent;
+		break;
+	default:
+		ret =3D -EINVAL;
+		goto err;
+	}
+
+	ret =3D i2c_smbus_write_word_swapped(opt->client, reg, value);
+	if (ret < 0) {
+		dev_err(opt->dev, "failed to write register %02x\n", reg);
+		goto err;
+	}
+
+err:
+	mutex_unlock(&opt->lock);
+
+	return ret;
+}
+
+static int opt3001_read_event_config(struct iio_dev *iio,
+		const struct iio_chan_spec *chan, enum iio_event_type type,
+		enum iio_event_direction dir)
+{
+	struct opt3001 *opt =3D iio_priv(iio);
+
+	return opt->mode =3D=3D OPT3001_CONFIGURATION_M_CONTINUOUS;
+}
+
+static int opt3001_write_event_config(struct iio_dev *iio,
+		const struct iio_chan_spec *chan, enum iio_event_type type,
+		enum iio_event_direction dir, int state)
+{
+	struct opt3001 *opt =3D iio_priv(iio);
+	int ret;
+	u16 mode;
+	u16 reg;
+
+	if (state && opt->mode =3D=3D OPT3001_CONFIGURATION_M_CONTINUOUS)
+		return 0;
+
+	if (!state && opt->mode =3D=3D OPT3001_CONFIGURATION_M_SHUTDOWN)
+		return 0;
+
+	mode =3D state ? OPT3001_CONFIGURATION_M_CONTINUOUS
+		: OPT3001_CONFIGURATION_M_SHUTDOWN;
+
+	ret =3D i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
+	if (ret < 0) {
+		dev_err(opt->dev, "failed to read register %02x\n",
+				OPT3001_CONFIGURATION);
+		return ret;
+	}
+
+	reg =3D ret;
+	opt3001_set_mode(opt, &reg, mode);
+
+	if (opt->hysteresis)
+		reg |=3D OPT3001_CONFIGURATION_L;
+	else
+		reg &=3D ~OPT3001_CONFIGURATION_L;
+
+	ret =3D i2c_smbus_write_word_swapped(opt->client, OPT3001_CONFIGURATION,
+			reg);
+	if (ret < 0) {
+		dev_err(opt->dev, "failed to write register %02x\n",
+				OPT3001_CONFIGURATION);
+		return ret;
+	}
+
+	/* wait for mode change to go through */
+	usleep_range(opt->int_time + 5000, opt->int_time + 10000);
+
+	return 0;
+}
+
+static const struct iio_info opt3001_info =3D {
+	.driver_module =3D THIS_MODULE,
+	.attrs =3D &opt3001_attribute_group,
+	.read_raw =3D opt3001_read_raw,
+	.write_raw =3D opt3001_write_raw,
+	.read_event_value =3D opt3001_read_event_value,
+	.write_event_value =3D opt3001_write_event_value,
+	.read_event_config =3D opt3001_read_event_config,
+	.write_event_config =3D opt3001_write_event_config,
+};
+
+static int opt3001_read_id(struct opt3001 *opt)
+{
+	char manufacturer[2];
+	u16 device_id;
+	int ret;
+
+	ret =3D i2c_smbus_read_word_swapped(opt->client, OPT3001_MANUFACTURER_ID);
+	if (ret < 0) {
+		dev_err(opt->dev, "failed to read register %02x\n",
+				OPT3001_MANUFACTURER_ID);
+		return ret;
+	}
+
+	manufacturer[0] =3D ret >> 8;
+	manufacturer[1] =3D ret & 0xff;
+
+	ret =3D i2c_smbus_read_word_swapped(opt->client, OPT3001_DEVICE_ID);
+	if (ret < 0) {
+		dev_err(opt->dev, "failed to read register %02x\n",
+				OPT3001_DEVICE_ID);
+		return ret;
+	}
+
+	device_id =3D ret;
+
+	dev_info(opt->dev, "Found %c%c OPT%04x\n", manufacturer[0],
+			manufacturer[1], device_id);
+
+	return 0;
+}
+
+static int opt3001_configure(struct opt3001 *opt)
+{
+	int ret;
+	u16 reg;
+
+	ret =3D i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
+	if (ret < 0) {
+		dev_err(opt->dev, "failed to read register %02x\n",
+				OPT3001_CONFIGURATION);
+		return ret;
+	}
+
+	reg =3D ret;
+
+	if (reg & OPT3001_CONFIGURATION_CT)
+		opt->int_time =3D 800000;
+	else
+		opt->int_time =3D 100000;
+
+	reg &=3D ~OPT3001_CONFIGURATION_L;
+	reg &=3D ~OPT3001_CONFIGURATION_RN_MASK;
+	reg |=3D OPT3001_CONFIGURATION_RN_AUTO;
+
+	ret =3D i2c_smbus_write_word_swapped(opt->client, OPT3001_CONFIGURATION,
+			reg);
+	if (ret < 0) {
+		dev_err(opt->dev, "failed to write register %02x\n",
+				OPT3001_CONFIGURATION);
+		return ret;
+	}
+
+	ret =3D i2c_smbus_read_word_swapped(opt->client, OPT3001_LOW_LIMIT);
+	if (ret < 0) {
+		dev_err(opt->dev, "failed to read register %02x\n",
+				OPT3001_LOW_LIMIT);
+		return ret;
+	}
+
+	opt->low_thresh_mantissa =3D OPT3001_REG_MANTISSA(ret);
+	opt->low_thresh_exp =3D OPT3001_REG_EXPONENT(ret);
+
+	ret =3D i2c_smbus_read_word_swapped(opt->client, OPT3001_HIGH_LIMIT);
+	if (ret < 0) {
+		dev_err(opt->dev, "failed to read register %02x\n",
+				OPT3001_HIGH_LIMIT);
+		return ret;
+	}
+
+	opt->high_thresh_mantissa =3D OPT3001_REG_MANTISSA(ret);
+	opt->high_thresh_exp =3D OPT3001_REG_EXPONENT(ret);
+
+	return 0;
+}
+
+static irqreturn_t opt3001_irq(int irq, void *_iio)
+{
+	struct iio_dev *iio =3D _iio;
+	struct opt3001 *opt =3D iio_priv(iio);
+	int ret;
+
+	mutex_lock(&opt->lock);
+
+	ret =3D i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
+	if (ret < 0) {
+		dev_err(opt->dev, "failed to read register %02x\n",
+				OPT3001_CONFIGURATION);
+		goto out;
+	}
+
+	if (!(ret & OPT3001_CONFIGURATION_CT))
+		goto out;
+
+	if (ret & OPT3001_CONFIGURATION_FH)
+		iio_push_event(iio, IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
+					IIO_EV_TYPE_THRESH,
+					IIO_EV_DIR_RISING), iio_get_time_ns());
+
+	if (ret & OPT3001_CONFIGURATION_FL)
+		iio_push_event(iio, IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
+					IIO_EV_TYPE_THRESH,
+					IIO_EV_DIR_FALLING), iio_get_time_ns());
+
+out:
+	mutex_unlock(&opt->lock);
+	return IRQ_HANDLED;
+}
+
+static int opt3001_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	struct device *dev =3D &client->dev;
+
+	struct iio_dev *iio;
+	struct opt3001 *opt;
+	int irq =3D client->irq;
+	int ret =3D -ENOMEM;
+
+	iio =3D iio_device_alloc(sizeof(*opt));
+	if (!iio)
+		goto err_iio_alloc;
+
+	opt =3D iio_priv(iio);
+	opt->client =3D client;
+	opt->dev =3D dev;
+
+	mutex_init(&opt->lock);
+	i2c_set_clientdata(client, iio);
+
+	ret =3D opt3001_read_id(opt);
+	if (ret)
+		goto err_read;
+
+	ret =3D opt3001_configure(opt);
+	if (ret)
+		goto err_read;
+
+	iio->name =3D client->name;
+	iio->channels =3D opt3001_channels;
+	iio->num_channels =3D ARRAY_SIZE(opt3001_channels);
+	iio->dev.parent =3D dev;
+	iio->modes =3D INDIO_DIRECT_MODE;
+	iio->info =3D &opt3001_info;
+
+	ret =3D iio_device_register(iio);
+	if (ret) {
+		dev_err(dev, "failed to register IIO device\n");
+		goto err_read;
+	}
+
+	ret =3D request_threaded_irq(irq, NULL, opt3001_irq,
+			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
+			| IRQF_ONESHOT, "opt3001", iio);
+	if (ret) {
+		dev_err(dev, "failed to request IRQ #%d\n", irq);
+		goto err_request_irq;
+	}
+
+	return 0;
+
+err_request_irq:
+	iio_device_unregister(iio);
+
+err_read:
+	iio_device_free(iio);
+
+err_iio_alloc:
+	return ret;
+}
+
+static int opt3001_remove(struct i2c_client *client)
+{
+	struct iio_dev *iio =3D i2c_get_clientdata(client);
+	struct opt3001 *opt =3D iio_priv(iio);
+	int ret;
+	u16 reg;
+
+	free_irq(client->irq, iio);
+	iio_device_unregister(iio);
+
+	ret =3D i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
+	if (ret < 0) {
+		dev_err(opt->dev, "failed to read register %02x\n",
+				OPT3001_CONFIGURATION);
+		return ret;
+	}
+
+	reg =3D ret;
+	opt3001_set_mode(opt, &reg, OPT3001_CONFIGURATION_M_SHUTDOWN);
+
+	ret =3D i2c_smbus_write_word_swapped(opt->client, OPT3001_CONFIGURATION,
+			reg);
+	if (ret < 0) {
+		dev_err(opt->dev, "failed to write register %02x\n",
+				OPT3001_CONFIGURATION);
+		return ret;
+	}
+
+	iio_device_free(iio);
+
+	return 0;
+}
+
+static const struct i2c_device_id opt3001_id[] =3D {
+	{ "opt3001", 0 },
+	{ } /* Terminating Entry */
+};
+MODULE_DEVICE_TABLE(i2c, opt3001_id);
+
+static struct i2c_driver opt3001_driver =3D {
+	.probe =3D opt3001_probe,
+	.remove =3D opt3001_remove,
+	.id_table =3D opt3001_id,
+
+	.driver =3D {
+		.name =3D "opt3001",
+		.owner =3D THIS_MODULE,
+	},
+};
+
+module_i2c_driver(opt3001_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
+MODULE_DESCRIPTION("Texas Instruments OPT3001 Light Sensor Driver");
--=20
2.0.1.563.g66f467c


--=20
balbi

--nYySOmuH/HDX6pKp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT7SJlAAoJEIaOsuA1yqRECo0P/2TwxJqBwHgs5cFPjfeCwgLy
8U7eknsMYyichA+5fx4ii0RtewsrqV3L+YzifqX1DzFx7GocXMvVOESRRSPYVNyU
sQFNHRF3/igYJFOLi0wPEQNku57GcXD7/MrbrTUU+5Fy9IXAx8BzMOm+l11MWYqz
0ShiiAW0K8v61/qcvxQQCI2uIGb7dCen8wQ5hzQxTuGOYzxvr2T0TpOlEzc5qEYP
SRUlkvFlEutbTaOdDO+B89bqHkt272RPHZfB5X9eTeTnRNr/io0jSHqz46G0gKPK
yIJKEQ0v2wP15L0ESiao67gK7Wi4uGh7ihZ4JJAz636EvyfIVVJRYhXgrSreKCrE
bYp4HdZOKT4wGYMCTO7FsYQp68fJbqnNLvNhMz+7NET8NLD8UPcMWt7nEDGA2NhF
XA6Q2X2ojmEcdvMb7FqdWaEY5oZKkckrA9FH+ja/rv4vciC5u80ssFUHcntX45vX
QaaZzejVyAKWd8zS7JUFfH9hRaoUyYVQsqg/HDpdSXpLPi/xP02NzdR+n/sI0D3N
E+fALP/JJqhHUhp+kf3ThVOJoT0Wk5SaY1AbM255ovmKReQvTxOEip6M1KwDL7r+
nhgfme/CDVkm5cvFMMp79t/rtJtJO3TDmvvWrsAXqzOqKhzpVZn5rpy40HDUrnAh
U0Td3OCkx410OEEyeGUn
=0E0s
-----END PGP SIGNATURE-----

--nYySOmuH/HDX6pKp--
