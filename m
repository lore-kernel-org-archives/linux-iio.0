Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38617 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbaHNQv1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 Aug 2014 12:51:27 -0400
Message-ID: <53ECE90A.8010609@kernel.org>
Date: Thu, 14 Aug 2014 17:51:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Felipe Balbi <balbi@ti.com>
CC: linux-iio@vger.kernel.org, pmeerw@pmeerw.net
Subject: Re: [PATCH v3] iio: ligth: add support for TI's opt3001 ligth sensor
References: <1407940605-12270-1-git-send-email-balbi@ti.com>
In-Reply-To: <1407940605-12270-1-git-send-email-balbi@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/08/14 15:36, Felipe Balbi wrote:
> TI's opt3001 light sensor is a simple and yet powerful
> little device. The device provides 99% IR rejection,
> Automatic full-scale, very low power consumption and
> measurements from 0.01 to 83k lux.
>
> This patch adds support for that device using the IIO
> framework.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
Please fix your patch title spelling of light!

I'm not keen on the ordering during remove and
your use of hysteresis does not conform to the ABI so please
take a look at that and the other drivers that make use of it.

Hystersis is documented in Documentation/ABI/testing/sysfs-bus-iio

Specifies the hysteresis of threshold that the device is comparing
	against for the events enabled by
	<type>Y[_name]_thresh[_(rising|falling)]_hysteresis.
	If separate attributes exist for the two directions, but
	direction is not specified for this attribute, then a single
	hysteresis value applies to both directions.
	For falling events the hysteresis is added to the _value attribute for
	this event to get the upper threshold for when the event goes back to
	normal, for rising events the hysteresis is subtracted from the _value
	attribute. E.g. if in_voltage0_raw_thresh_rising_value is set to 1200
	and in_voltage0_raw_thresh_rising_hysteresis is set to 50. The event
	will get activated once in_voltage0_raw goes above 1200 and will become
	deactived again once the value falls below 1150.

Also, I'll probably wait for Peter to take a look at any final version
(would like to credit him for his work reviewing the earlier versions!)
Not as though we are likely to be in a rush at this time in the cycle.

> ---
>
> I think this is ready to drop the RFC tag from the subject.
>
> After this patch is accepted, I'll work on adding triggered
> buffer.
>
>  drivers/iio/light/Kconfig   |  10 +
>  drivers/iio/light/Makefile  |   1 +
>  drivers/iio/light/opt3001.c | 739 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 750 insertions(+)
>  create mode 100644 drivers/iio/light/opt3001.c
>
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index bf05ca5..f196996 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -128,6 +128,16 @@ config LTR501
>  	 This driver can also be built as a module.  If so, the module
>           will be called ltr501.
>
> +config OPT3001
> +	tristate "Texas Instruments OPT3001 Light Sensor"
> +	depends on I2C
> +	help
> +	  If you say Y or M here, you get support for Texas Instruments
> +	  OPT3001 Ambient Light Sensor.
> +
> +	  If built as a dynamically linked module, it will be called
> +	  opt3001.
> +
>  config TCS3414
>  	tristate "TAOS TCS3414 digital color sensor"
>  	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index 8b8c09f..898ef13 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_HID_SENSOR_PROX)	+= hid-sensor-prox.o
>  obj-$(CONFIG_ISL29125)		+= isl29125.o
>  obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
>  obj-$(CONFIG_LTR501)		+= ltr501.o
> +obj-$(CONFIG_OPT3001)		+= opt3001.o
>  obj-$(CONFIG_SENSORS_TSL2563)	+= tsl2563.o
>  obj-$(CONFIG_TCS3414)		+= tcs3414.o
>  obj-$(CONFIG_TCS3472)		+= tcs3472.o
> diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> new file mode 100644
> index 0000000..36737ca
> --- /dev/null
> +++ b/drivers/iio/light/opt3001.c
> @@ -0,0 +1,739 @@
> +/**
> + * opt3001.c - Texas Instruments OPT3001 Light Sensor
> + *
> + * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com
> + *
> + * Author: Felipe Balbi <balbi@ti.com>
> + *
> + * This program is free software: you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 of the License
> + * as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define OPT3001_RESULT		0x00
> +#define OPT3001_CONFIGURATION	0x01
> +#define OPT3001_LOW_LIMIT	0x02
> +#define OPT3001_HIGH_LIMIT	0x03
> +#define OPT3001_MANUFACTURER_ID	0x7e
> +#define OPT3001_DEVICE_ID	0x7f
> +
> +#define OPT3001_CONFIGURATION_RN_MASK (0xf << 12)
> +#define OPT3001_CONFIGURATION_RN_AUTO (0xc << 12)
> +
> +#define OPT3001_CONFIGURATION_CT	BIT(11)
> +
> +#define OPT3001_CONFIGURATION_M_MASK	(3 << 9)
> +#define OPT3001_CONFIGURATION_M_SHUTDOWN (0 << 9)
> +#define OPT3001_CONFIGURATION_M_SINGLE (1 << 9)
> +#define OPT3001_CONFIGURATION_M_CONTINUOUS (2 << 9) /* also 3 << 9 */
> +
> +#define OPT3001_CONFIGURATION_OVF	BIT(8)
> +#define OPT3001_CONFIGURATION_CRF	BIT(7)
> +#define OPT3001_CONFIGURATION_FH	BIT(6)
> +#define OPT3001_CONFIGURATION_FL	BIT(5)
> +#define OPT3001_CONFIGURATION_L		BIT(4)
> +#define OPT3001_CONFIGURATION_POL	BIT(3)
> +#define OPT3001_CONFIGURATION_ME	BIT(2)
> +
> +#define OPT3001_CONFIGURATION_FC_MASK	(3 << 0)
> +
> +#define OPT3001_REG_EXPONENT(n)	((n) >> 12)
> +#define OPT3001_REG_MANTISSA(n)	((n) & 0xfff)
> +
> +struct opt3001 {
> +	struct i2c_client	*client;
> +	struct device		*dev;
> +
> +	struct mutex		lock;
> +
> +	u32			int_time;
> +	u32			mode;
> +
> +	u16			high_thresh_mantissa;
> +	u16			low_thresh_mantissa;
> +
> +	u8			high_thresh_exp;
> +	u8			low_thresh_exp;
> +
> +	unsigned int		hysteresis:1;
> +};
> +
> +struct opt3001_scale {
> +	int	val;
> +	int	val2;
> +};
> +
> +static const struct opt3001_scale opt3001_scales[] = {
> +	{
> +		.val = 40,
> +		.val2 = 950000,
> +	},
> +	{
> +		.val = 81,
> +		.val2 = 900000,
> +	},
> +	{
> +		.val = 81,
> +		.val2 = 900000,
> +	},
> +	{
> +		.val = 163,
> +		.val2 = 800000,
> +	},
> +	{
> +		.val = 327,
> +		.val2 = 600000,
> +	},
> +	{
> +		.val = 655,
> +		.val2 = 200000,
> +	},
> +	{
> +		.val = 1310,
> +		.val2 = 400000,
> +	},
> +	{
> +		.val = 2620,
> +		.val2 = 800000,
> +	},
> +	{
> +		.val = 5241,
> +		.val2 = 600000,
> +	},
> +	{
> +		.val = 10483,
> +		.val2 = 200000,
> +	},
> +	{
> +		.val = 20966,
> +		.val2 = 400000,
> +	},
> +	{
> +		.val = 83865,
> +		.val2 = 600000,
> +	},
> +};
> +
> +static int opt3001_find_scale(const struct opt3001 *opt, int val,
> +		int val2, u8 *exponent)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(opt3001_scales); i++) {
> +		const struct opt3001_scale *scale = &opt3001_scales[i];
> +
> +		if (val <= scale->val && val2 <= scale->val2) {
> +			*exponent = i;
> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static void opt3001_to_iio_ret(struct opt3001 *opt, u8 exponent,
> +		u16 mantissa, int *val, int *val2)
> +{
> +	int lux;
> +
> +	lux = 10 * (mantissa << exponent);
> +	*val = lux / 1000;
> +	*val2 = (lux - (*val * 1000)) * 1000;
> +}
> +
> +static void opt3001_set_mode(struct opt3001 *opt, u16 *reg, u16 mode)
> +{
> +	*reg &= ~OPT3001_CONFIGURATION_M_MASK;
> +	*reg |= mode;
> +	opt->mode = mode;
> +}
> +
> +static IIO_CONST_ATTR_INT_TIME_AVAIL("0.1 0.8");
> +
> +static struct attribute *opt3001_attributes[] = {
> +	&iio_const_attr_integration_time_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group opt3001_attribute_group = {
> +	.attrs = opt3001_attributes,
> +};
> +
> +static const struct iio_event_spec opt3001_event_spec[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +			BIT(IIO_EV_INFO_HYSTERESIS) |
> +			BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +			BIT(IIO_EV_INFO_HYSTERESIS) |
> +			BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
> +static const struct iio_chan_spec opt3001_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				BIT(IIO_CHAN_INFO_INT_TIME),
> +		.event_spec = opt3001_event_spec,
> +		.num_event_specs = ARRAY_SIZE(opt3001_event_spec),
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(1),
> +};
> +
> +static int opt3001_get_lux(struct opt3001 *opt, int *val, int *val2)
> +{
> +	int ret;
> +	u16 mantissa;
> +	u16 reg;
> +	u8 exponent;
> +
> +	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
> +	if (ret < 0) {
> +		dev_err(opt->dev, "failed to read register %02x\n",
> +				OPT3001_CONFIGURATION);
> +		return ret;
> +	}
> +
> +	reg = ret;
> +	opt3001_set_mode(opt, &reg, OPT3001_CONFIGURATION_M_SINGLE);
> +
> +	ret = i2c_smbus_write_word_swapped(opt->client, OPT3001_CONFIGURATION,
> +			reg);
> +	if (ret < 0) {
> +		dev_err(opt->dev, "failed to write register %02x\n",
> +				OPT3001_CONFIGURATION);
> +		return ret;
> +	}
> +
> +	/* wait for conversion and give it an extra 5ms */
> +	usleep_range(opt->int_time + 5000, opt->int_time + 10000);
> +
> +	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
> +	if (ret < 0) {
> +		dev_err(opt->dev, "failed to read register %02x\n",
> +				OPT3001_CONFIGURATION);
> +		return ret;
> +	}
> +
> +	reg = ret;
> +	if (!(reg & OPT3001_CONFIGURATION_CRF))
> +		return -EPIPE;
> +
> +	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_RESULT);
> +	if (ret < 0) {
> +		dev_err(opt->dev, "failed to read register %02x\n",
> +				OPT3001_RESULT);
> +		return ret;
> +	}
> +
> +	exponent = OPT3001_REG_EXPONENT(ret);
> +	mantissa = OPT3001_REG_MANTISSA(ret);
> +
> +	opt3001_to_iio_ret(opt, exponent, mantissa, val, val2);
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +static int opt3001_get_int_time(struct opt3001 *opt, int *val, int *val2)
> +{
> +	*val = 0;
> +	*val2 = opt->int_time;
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +static int opt3001_set_int_time(struct opt3001 *opt, int time)
> +{
> +	int ret;
> +	u16 reg;
> +
> +	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
> +	if (ret < 0) {
> +		dev_err(opt->dev, "failed to read register %02x\n",
> +				OPT3001_CONFIGURATION);
> +		return ret;
> +	}
> +
> +	reg = ret;
> +
> +	switch (time) {
> +	case 100000:
> +		reg &= ~OPT3001_CONFIGURATION_CT;
> +		opt->int_time = 100000;
> +		break;
> +	case 800000:
> +		reg |= OPT3001_CONFIGURATION_CT;
> +		opt->int_time = 800000;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return i2c_smbus_write_word_swapped(opt->client, OPT3001_CONFIGURATION,
> +			reg);
> +}
> +
> +static int opt3001_read_raw(struct iio_dev *iio,
> +		struct iio_chan_spec const *chan, int *val, int *val2,
> +		long mask)
> +{
> +	struct opt3001 *opt = iio_priv(iio);
> +	int ret = 0;
> +
> +	if (opt->mode == OPT3001_CONFIGURATION_M_CONTINUOUS)
> +		return -EBUSY;
> +
> +	if (chan->type != IIO_LIGHT)
> +		return -EINVAL;
> +
> +	mutex_lock(&opt->lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		ret = opt3001_get_lux(opt, val, val2);
> +		break;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		ret = opt3001_get_int_time(opt, val, val2);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	mutex_unlock(&opt->lock);
> +
> +	return ret;
> +}
> +
> +static int opt3001_write_raw(struct iio_dev *iio,
> +		struct iio_chan_spec const *chan, int val, int val2,
> +		long mask)
> +{
> +	struct opt3001 *opt = iio_priv(iio);
> +	int ret = 0;
> +
> +	if (opt->mode == OPT3001_CONFIGURATION_M_CONTINUOUS)
> +		return -EBUSY;
> +
> +	if (chan->type != IIO_LIGHT)
> +		return -EINVAL;
> +
> +	if (mask != IIO_CHAN_INFO_INT_TIME)
> +		return -EINVAL;
> +
> +	mutex_lock(&opt->lock);
> +	ret = opt3001_set_int_time(opt, val);
> +	mutex_unlock(&opt->lock);
> +
> +	return ret;
> +}
> +
> +static int opt3001_read_event_value(struct iio_dev *iio,
> +		const struct iio_chan_spec *chan, enum iio_event_type type,
> +		enum iio_event_direction dir, enum iio_event_info info,
> +		int *val, int *val2)
> +{
> +	struct opt3001 *opt = iio_priv(iio);
> +	int ret = IIO_VAL_INT_PLUS_MICRO;
> +
> +	mutex_lock(&opt->lock);
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
This should have separate handling for the hyseresis and value attributes
as they should return the relevant numeric values...
> +		opt3001_to_iio_ret(opt, opt->high_thresh_exp,
> +				opt->high_thresh_mantissa, val, val2);
> +		break;
> +	case IIO_EV_DIR_FALLING:
> +		opt3001_to_iio_ret(opt, opt->low_thresh_exp,
> +				opt->low_thresh_mantissa, val, val2);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	mutex_unlock(&opt->lock);
> +
> +	return ret;
> +}
> +
> +static int opt3001_write_event_value(struct iio_dev *iio,
> +		const struct iio_chan_spec *chan, enum iio_event_type type,
> +		enum iio_event_direction dir, enum iio_event_info info,
> +		int val, int val2)
> +{
> +	struct opt3001 *opt = iio_priv(iio);
> +	int ret = 0;
> +
> +	u16 mantissa;
> +	u16 value;
> +	u16 reg;
> +
> +	u8 exponent;
> +
> +	mutex_lock(&opt->lock);
> +
> +	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
> +	if (ret < 0) {
> +		dev_err(opt->dev, "failed to read register %02x\n",
> +				OPT3001_CONFIGURATION);
> +		goto err;
> +	}
> +
> +	reg = ret;
> +	if (info == IIO_EV_INFO_HYSTERESIS)
Hysteresis is typically a numeric value.  The options here should be either 0
(for none) or the value of hysteresis applied (how far we have to back off
from the thereshold to trigger the event).  It's not a boolean and even
if it were enabling it or not based on last write is not a good way of doing
things.

> +		opt->hysteresis = true;
> +	else
> +		opt->hysteresis = false;
> +
> +	ret = opt3001_find_scale(opt, val, val2, &exponent);
> +	if (ret < 0) {
> +		dev_err(opt->dev, "can't find scale for %d.%d\n", val, val2);
> +		goto err;
> +	}
> +
> +	mantissa = (((val * 1000) + (val2 / 1000)) / 10) >> exponent;
> +	value = exponent << 12 | mantissa;
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		reg = OPT3001_HIGH_LIMIT;
> +		opt->high_thresh_mantissa = mantissa;
> +		opt->high_thresh_exp = exponent;
> +		break;
> +	case IIO_EV_DIR_FALLING:
> +		reg = OPT3001_LOW_LIMIT;
> +		opt->low_thresh_mantissa = mantissa;
> +		opt->low_thresh_exp = exponent;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	ret = i2c_smbus_write_word_swapped(opt->client, reg, value);
> +	if (ret < 0) {
> +		dev_err(opt->dev, "failed to write register %02x\n", reg);
> +		goto err;
> +	}
> +
> +err:
> +	mutex_unlock(&opt->lock);
> +
> +	return ret;
> +}
> +
> +static int opt3001_read_event_config(struct iio_dev *iio,
> +		const struct iio_chan_spec *chan, enum iio_event_type type,
> +		enum iio_event_direction dir)
> +{
> +	struct opt3001 *opt = iio_priv(iio);
> +
> +	return opt->mode == OPT3001_CONFIGURATION_M_CONTINUOUS;
> +}
> +
> +static int opt3001_write_event_config(struct iio_dev *iio,
> +		const struct iio_chan_spec *chan, enum iio_event_type type,
> +		enum iio_event_direction dir, int state)
> +{
> +	struct opt3001 *opt = iio_priv(iio);
> +	int ret;
> +	u16 mode;
> +	u16 reg;
> +
> +	if (state && opt->mode == OPT3001_CONFIGURATION_M_CONTINUOUS)
> +		return 0;
> +
> +	if (!state && opt->mode == OPT3001_CONFIGURATION_M_SHUTDOWN)
> +		return 0;
> +
> +	mode = state ? OPT3001_CONFIGURATION_M_CONTINUOUS
> +		: OPT3001_CONFIGURATION_M_SHUTDOWN;
> +
> +	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
> +	if (ret < 0) {
> +		dev_err(opt->dev, "failed to read register %02x\n",
> +				OPT3001_CONFIGURATION);
> +		return ret;
> +	}
> +
> +	reg = ret;
> +	opt3001_set_mode(opt, &reg, mode);
> +
> +	if (opt->hysteresis)
> +		reg |= OPT3001_CONFIGURATION_L;
> +	else
> +		reg &= ~OPT3001_CONFIGURATION_L;
> +
> +	ret = i2c_smbus_write_word_swapped(opt->client, OPT3001_CONFIGURATION,
> +			reg);
> +	if (ret < 0) {
> +		dev_err(opt->dev, "failed to write register %02x\n",
> +				OPT3001_CONFIGURATION);
> +		return ret;
> +	}
> +
> +	/* wait for mode change to go through */
> +	usleep_range(opt->int_time + 5000, opt->int_time + 10000);
> +
> +	return 0;
> +}
> +
> +static const struct iio_info opt3001_info = {
> +	.driver_module = THIS_MODULE,
> +	.attrs = &opt3001_attribute_group,
> +	.read_raw = opt3001_read_raw,
> +	.write_raw = opt3001_write_raw,
> +	.read_event_value = opt3001_read_event_value,
> +	.write_event_value = opt3001_write_event_value,
> +	.read_event_config = opt3001_read_event_config,
> +	.write_event_config = opt3001_write_event_config,
> +};
> +
> +static int opt3001_read_id(struct opt3001 *opt)
> +{
> +	char manufacturer[2];
> +	u16 device_id;
> +	int ret;
> +
> +	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_MANUFACTURER_ID);
> +	if (ret < 0) {
> +		dev_err(opt->dev, "failed to read register %02x\n",
> +				OPT3001_MANUFACTURER_ID);
> +		return ret;
> +	}
> +
> +	manufacturer[0] = ret >> 8;
> +	manufacturer[1] = ret & 0xff;
I would be a little 'unusual' but you could use an endian conversion here :)
Perhaps better to have the clarity of the way you have done it!
> +
> +	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_DEVICE_ID);
> +	if (ret < 0) {
> +		dev_err(opt->dev, "failed to read register %02x\n",
> +				OPT3001_DEVICE_ID);
> +		return ret;
> +	}
> +
> +	device_id = ret;
> +
> +	dev_info(opt->dev, "Found %c%c OPT%04x\n", manufacturer[0],
> +			manufacturer[1], device_id);
> +
> +	return 0;
> +}
> +
> +static int opt3001_configure(struct opt3001 *opt)
> +{
> +	int ret;
> +	u16 reg;
> +
> +	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
> +	if (ret < 0) {
> +		dev_err(opt->dev, "failed to read register %02x\n",
> +				OPT3001_CONFIGURATION);
> +		return ret;
> +	}
> +
> +	reg = ret;
> +
> +	if (reg & OPT3001_CONFIGURATION_CT)
> +		opt->int_time = 800000;
> +	else
> +		opt->int_time = 100000;
> +
> +	reg &= ~OPT3001_CONFIGURATION_L;
> +	reg &= ~OPT3001_CONFIGURATION_RN_MASK;
> +	reg |= OPT3001_CONFIGURATION_RN_AUTO;
> +
> +	ret = i2c_smbus_write_word_swapped(opt->client, OPT3001_CONFIGURATION,
> +			reg);
> +	if (ret < 0) {
> +		dev_err(opt->dev, "failed to write register %02x\n",
> +				OPT3001_CONFIGURATION);
> +		return ret;
> +	}
> +
> +	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_LOW_LIMIT);
> +	if (ret < 0) {
> +		dev_err(opt->dev, "failed to read register %02x\n",
> +				OPT3001_LOW_LIMIT);
> +		return ret;
> +	}
> +
> +	opt->low_thresh_mantissa = OPT3001_REG_MANTISSA(ret);
> +	opt->low_thresh_exp = OPT3001_REG_EXPONENT(ret);
> +
> +	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_HIGH_LIMIT);
> +	if (ret < 0) {
> +		dev_err(opt->dev, "failed to read register %02x\n",
> +				OPT3001_HIGH_LIMIT);
> +		return ret;
> +	}
> +
> +	opt->high_thresh_mantissa = OPT3001_REG_MANTISSA(ret);
> +	opt->high_thresh_exp = OPT3001_REG_EXPONENT(ret);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t opt3001_irq(int irq, void *_iio)
> +{
> +	struct iio_dev *iio = _iio;
> +	struct opt3001 *opt = iio_priv(iio);
> +	int ret;
> +
> +	mutex_lock(&opt->lock);
> +
> +	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
> +	if (ret < 0) {
> +		dev_err(opt->dev, "failed to read register %02x\n",
> +				OPT3001_CONFIGURATION);
> +		goto out;
> +	}
> +
> +	if (!(ret & OPT3001_CONFIGURATION_CT))
> +		goto out;
> +
> +	if (ret & OPT3001_CONFIGURATION_FH)
> +		iio_push_event(iio, IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
> +					IIO_EV_TYPE_THRESH,
> +					IIO_EV_DIR_RISING), iio_get_time_ns());
> +
> +	if (ret & OPT3001_CONFIGURATION_FL)
> +		iio_push_event(iio, IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
> +					IIO_EV_TYPE_THRESH,
> +					IIO_EV_DIR_FALLING), iio_get_time_ns());
> +
> +out:
> +	mutex_unlock(&opt->lock);
> +	return IRQ_HANDLED;
> +}
> +
> +static int opt3001_probe(struct i2c_client *client,
> +		const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +
> +	struct iio_dev *iio;
> +	struct opt3001 *opt;
> +	int irq = client->irq;
> +	int ret;
> +
> +	iio = devm_iio_device_alloc(dev, sizeof(*opt));
> +	if (!iio)
> +		return -ENOMEM;
> +
> +	opt = iio_priv(iio);
> +	opt->client = client;
> +	opt->dev = dev;
> +
> +	mutex_init(&opt->lock);
> +	i2c_set_clientdata(client, opt);
> +
> +	ret = opt3001_read_id(opt);
> +	if (ret)
> +		return ret;
> +
> +	ret = opt3001_configure(opt);
> +	if (ret)
> +		return ret;
> +
> +	iio->name = client->name;
> +	iio->channels = opt3001_channels;
> +	iio->num_channels = ARRAY_SIZE(opt3001_channels);
> +	iio->dev.parent = dev;
> +	iio->modes = INDIO_DIRECT_MODE;
> +	iio->info = &opt3001_info;
> +
> +	ret = devm_iio_device_register(dev, iio);
> +	if (ret) {
> +		dev_err(dev, "failed to register IIO device\n");
> +		return ret;
> +	}
> +
> +	ret = devm_request_threaded_irq(dev, irq, NULL, opt3001_irq,
> +			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
> +			| IRQF_ONESHOT, "opt3001", iio);
> +	if (ret) {
> +		dev_err(dev, "failed to request IRQ #%d\n", irq);
> +		return ret;
> +	}
> +
> +	return 0;
> +
> +}
> +
> +static int opt3001_remove(struct i2c_client *client)
> +{
> +	struct opt3001 *opt = i2c_get_clientdata(client);
> +	int ret;
> +	u16 reg;
> +

So here you are shutting down the part before removing the userspace interfaces
(due to using the devm_iio_unregister).  I'm guessing this might create some
interesting race conditions.  Would prefer to see non devm versions of the
register and irq request to ensure the ordering is exactly what we would
expect.

> +	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
> +	if (ret < 0) {
> +		dev_err(opt->dev, "failed to read register %02x\n",
> +				OPT3001_CONFIGURATION);
> +		return ret;
> +	}
> +
> +	reg = ret;
> +	opt3001_set_mode(opt, &reg, OPT3001_CONFIGURATION_M_SHUTDOWN);
> +
> +	ret = i2c_smbus_write_word_swapped(opt->client, OPT3001_CONFIGURATION,
> +			reg);
> +	if (ret < 0) {
> +		dev_err(opt->dev, "failed to write register %02x\n",
> +				OPT3001_CONFIGURATION);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id opt3001_id[] = {
> +	{ "opt3001", 0 },
> +	{ } /* Terminating Entry */
> +};
> +MODULE_DEVICE_TABLE(i2c, opt3001_id);
> +
> +static struct i2c_driver opt3001_driver = {
> +	.probe = opt3001_probe,
> +	.remove = opt3001_remove,
> +	.id_table = opt3001_id,
> +
> +	.driver = {
> +		.name = "opt3001",
> +		.owner = THIS_MODULE,
> +	},
> +};
> +
> +module_i2c_driver(opt3001_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
> +MODULE_DESCRIPTION("Texas Instruments OPT3001 Light Sensor Driver");
>
