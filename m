Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.117]:33226 "EHLO ns.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031854AbeBNP6Y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 14 Feb 2018 10:58:24 -0500
Date: Wed, 14 Feb 2018 16:58:22 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jeff LaBundy <jeff@labundy.com>
cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: light: lv0104cs: Add support for LV0104CS light
 sensor
In-Reply-To: <1518620285-1893-1-git-send-email-jeff@labundy.com>
Message-ID: <alpine.DEB.2.21.1802141633300.9148@vps.pmeerw.net>
References: <1518620285-1893-1-git-send-email-jeff@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> This patch adds support for the On Semiconductor LV0104CS ambient
> light sensor.

nice little driver, some comments below

> Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> ---
>  drivers/iio/light/Kconfig    |  10 +
>  drivers/iio/light/Makefile   |   1 +
>  drivers/iio/light/lv0104cs.c | 559 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 570 insertions(+)
>  create mode 100644 drivers/iio/light/lv0104cs.c
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 2356ed9..ca8918e 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -275,6 +275,16 @@ config LTR501
>  	 This driver can also be built as a module.  If so, the module
>           will be called ltr501.
>  
> +config LV0104CS
> +	tristate "LV0104CS Ambient Light Sensor"
> +	depends on I2C
> +	help
> +	 Say Y here if you want to build support for the LV0104CS ambient
> +	 light sensor.

maybe mention On Semi somewhere?

> +
> +	 To compile this driver as a module, choose M here:
> +	 the module will be called lv0104cs.
> +
>  config MAX44000
>  	tristate "MAX44000 Ambient and Infrared Proximity Sensor"
>  	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index fa32fa4..77c8682 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_ISL29125)		+= isl29125.o
>  obj-$(CONFIG_JSA1212)		+= jsa1212.o
>  obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
>  obj-$(CONFIG_LTR501)		+= ltr501.o
> +obj-$(CONFIG_LV0104CS)		+= lv0104cs.o
>  obj-$(CONFIG_MAX44000)		+= max44000.o
>  obj-$(CONFIG_OPT3001)		+= opt3001.o
>  obj-$(CONFIG_PA12203001)	+= pa12203001.o
> diff --git a/drivers/iio/light/lv0104cs.c b/drivers/iio/light/lv0104cs.c
> new file mode 100644
> index 0000000..ecbba39
> --- /dev/null
> +++ b/drivers/iio/light/lv0104cs.c
> @@ -0,0 +1,559 @@
> +/*
> + * lv0104cs.c: LV0104CS Ambient Light Sensor Driver
> + *
> + * Copyright (C) 2018 Jeff LaBundy <jeff@labundy.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 of the License
> + * as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * 7-bit I2C slave address: 0x13
> + *
> + * This device has just one register and it is write-only. Read operations are
> + * limited to the 16-bit ADC output.

as simple as it gets :)

a link to the documentation would be nice

> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/mutex.h>
> +#include <linux/device.h>
> +#include <linux/delay.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define LV0104CS_REGVAL_MEASURE		0xE0
> +#define LV0104CS_REGVAL_SLEEP		0x00
> +
> +#define LV0104CS_HWGAIN_0x25		0
> +#define LV0104CS_HWGAIN_1x		1
> +#define LV0104CS_HWGAIN_2x		2
> +#define LV0104CS_HWGAIN_8x		3
> +
> +#define LV0104CS_INTEG_12m5		0
> +#define LV0104CS_INTEG_100m		1
> +#define LV0104CS_INTEG_200m		2

are these milliseconds? maybe annotate

> +
> +#define LV0104CS_CALIB_UNITY		31
> +
> +struct lv0104cs_private {
> +	struct i2c_client *client;
> +	struct mutex lock;
> +	unsigned char hardwaregain;
> +	unsigned char int_time;
> +	unsigned char calibscale;
> +};
> +
> +struct lv0104cs_mapping {
> +	int val;
> +	int val2;
> +	unsigned char regval;
> +};
> +
> +static const struct lv0104cs_mapping lv0104cs_calibscales[] = {
> +	{ 0, 666666, 0x81 },
> +	{ 0, 800000, 0x82 },
> +	{ 0, 857142, 0x83 },
> +	{ 0, 888888, 0x84 },
> +	{ 0, 909090, 0x85 },
> +	{ 0, 923076, 0x86 },
> +	{ 0, 933333, 0x87 },
> +	{ 0, 941176, 0x88 },
> +	{ 0, 947368, 0x89 },
> +	{ 0, 952380, 0x8A },
> +	{ 0, 956521, 0x8B },
> +	{ 0, 960000, 0x8C },
> +	{ 0, 962962, 0x8D },
> +	{ 0, 965517, 0x8E },
> +	{ 0, 967741, 0x8F },
> +	{ 0, 969696, 0x90 },
> +	{ 0, 971428, 0x91 },
> +	{ 0, 972972, 0x92 },
> +	{ 0, 974358, 0x93 },
> +	{ 0, 975609, 0x94 },
> +	{ 0, 976744, 0x95 },
> +	{ 0, 977777, 0x96 },
> +	{ 0, 978723, 0x97 },
> +	{ 0, 979591, 0x98 },
> +	{ 0, 980392, 0x99 },
> +	{ 0, 981132, 0x9A },
> +	{ 0, 981818, 0x9B },
> +	{ 0, 982456, 0x9C },
> +	{ 0, 983050, 0x9D },
> +	{ 0, 983606, 0x9E },
> +	{ 0, 984126, 0x9F },
> +	{ 1, 0, 0x80 },
> +	{ 1, 16129, 0xBF },
> +	{ 1, 16666, 0xBE },
> +	{ 1, 17241, 0xBD },
> +	{ 1, 17857, 0xBC },
> +	{ 1, 18518, 0xBB },
> +	{ 1, 19230, 0xBA },
> +	{ 1, 20000, 0xB9 },
> +	{ 1, 20833, 0xB8 },
> +	{ 1, 21739, 0xB7 },
> +	{ 1, 22727, 0xB6 },
> +	{ 1, 23809, 0xB5 },
> +	{ 1, 24999, 0xB4 },
> +	{ 1, 26315, 0xB3 },
> +	{ 1, 27777, 0xB2 },
> +	{ 1, 29411, 0xB1 },
> +	{ 1, 31250, 0xB0 },
> +	{ 1, 33333, 0xAF },
> +	{ 1, 35714, 0xAE },
> +	{ 1, 38461, 0xAD },
> +	{ 1, 41666, 0xAC },
> +	{ 1, 45454, 0xAB },
> +	{ 1, 50000, 0xAA },
> +	{ 1, 55555, 0xA9 },
> +	{ 1, 62500, 0xA8 },
> +	{ 1, 71428, 0xA7 },
> +	{ 1, 83333, 0xA6 },
> +	{ 1, 100000, 0xA5 },
> +	{ 1, 125000, 0xA4 },
> +	{ 1, 166666, 0xA3 },
> +	{ 1, 250000, 0xA2 },
> +	{ 1, 500000, 0xA1 },
> +};
> +
> +static const struct lv0104cs_mapping lv0104cs_hardwaregains[] = {
> +	{ 0, 250000, 0x00 },
> +	{ 1, 0, 0x08 },
> +	{ 2, 0, 0x10 },
> +	{ 8, 0, 0x18 },
> +};

it would be nice if the LV0104CS_HWGAIN_ #defines could be used here, 
aren't the values 0x00 .. 0x18 just LV0104CS_HWGAIN_xx << 3?

> +
> +static const struct lv0104cs_mapping lv0104cs_int_times[] = {
> +	{ 0, 12500, 0x00 },
> +	{ 0, 100000, 0x02 },
> +	{ 0, 200000, 0x04 },
> +};

maybe something similar here for LV0104CS_INTEG

> +
> +static int lv0104cs_write_reg(struct lv0104cs_private *lv0104cs,
> +				unsigned char regval)
> +{
> +	struct i2c_client *client = lv0104cs->client;
> +	int ret;
> +
> +	ret = i2c_master_send(client, &regval, 1);

maybe sizeof(regval) instead of 1

> +	if (ret != 1) {
> +		dev_err(&client->dev, "Failed to write to device: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int lv0104cs_read_adc(struct lv0104cs_private *lv0104cs,
> +				unsigned int *adc_output)
> +{
> +	struct i2c_client *client = lv0104cs->client;
> +	unsigned char regval[2];

use 
__be16 regval;

> +	int ret;
> +
> +	ret = i2c_master_recv(client, regval, 2);

sizeof(regval)

> +	if (ret != 2) {
> +		dev_err(&client->dev, "Failed to read from device: %d\n", ret);
> +		return ret;
> +	}
> +
> +	*adc_output = (regval[0] << 8) + regval[1];

use be16_to_cpu()

> +
> +	return 0;
> +}
> +
> +static int lv0104cs_get_lux(struct lv0104cs_private *lv0104cs,
> +				unsigned int *val, unsigned int *val2)
> +{
> +	unsigned char regval = LV0104CS_REGVAL_MEASURE;
> +	unsigned int adc_output;
> +	int ret;
> +
> +	/* this function expects to be called while mutex is locked */
> +	if (!mutex_is_locked(&lv0104cs->lock))
> +		return -EACCES;
> +
> +	regval |= lv0104cs_hardwaregains[lv0104cs->hardwaregain].regval;
> +	regval |= lv0104cs_int_times[lv0104cs->int_time].regval;
> +	ret = lv0104cs_write_reg(lv0104cs, regval);
> +	if (ret)
> +		return ret;
> +
> +	/* wait for integration time to pass (with margin) */
> +	switch (lv0104cs->int_time) {
> +	case LV0104CS_INTEG_12m5:
> +		msleep(50);
> +		break;
> +
> +	case LV0104CS_INTEG_100m:
> +		msleep(150);
> +		break;
> +
> +	case LV0104CS_INTEG_200m:
> +		msleep(250);
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = lv0104cs_read_adc(lv0104cs, &adc_output);
> +	if (ret)
> +		return ret;
> +
> +	ret = lv0104cs_write_reg(lv0104cs, LV0104CS_REGVAL_SLEEP);
> +	if (ret)
> +		return ret;
> +
> +	/* normalize to lux based on applied gain */
> +	switch (lv0104cs->hardwaregain) {
> +	case LV0104CS_HWGAIN_0x25:
> +		*val = adc_output * 4;
> +		*val2 = 0;
> +		break;
> +
> +	case LV0104CS_HWGAIN_1x:
> +		*val = adc_output;
> +		*val2 = 0;
> +		break;
> +
> +	case LV0104CS_HWGAIN_2x:
> +		*val = adc_output / 2;
> +		*val2 = (adc_output % 2) * 500000;
> +		break;
> +
> +	case LV0104CS_HWGAIN_8x:
> +		*val = adc_output / 8;
> +		*val2 = (adc_output % 8) * 125000;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int lv0104cs_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	struct lv0104cs_private *lv0104cs = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (chan->type != IIO_LIGHT)
> +		return -EINVAL;
> +
> +	mutex_lock(&lv0104cs->lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		ret = lv0104cs_get_lux(lv0104cs, val, val2);
> +		if (ret)
> +			goto err_mutex;
> +		ret = IIO_VAL_INT_PLUS_MICRO;
> +		break;
> +
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		*val = lv0104cs_calibscales[lv0104cs->calibscale].val;
> +		*val2 = lv0104cs_calibscales[lv0104cs->calibscale].val2;
> +		ret = IIO_VAL_INT_PLUS_MICRO;
> +		break;
> +
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		*val = lv0104cs_hardwaregains[lv0104cs->hardwaregain].val;
> +		*val2 = lv0104cs_hardwaregains[lv0104cs->hardwaregain].val2;
> +		ret = IIO_VAL_INT_PLUS_MICRO;
> +		break;
> +
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*val = lv0104cs_int_times[lv0104cs->int_time].val;
> +		*val2 = lv0104cs_int_times[lv0104cs->int_time].val2;
> +		ret = IIO_VAL_INT_PLUS_MICRO;
> +		break;
> +
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +err_mutex:
> +	mutex_unlock(&lv0104cs->lock);
> +
> +	return ret;
> +}
> +
> +static int lv0104cs_set_calibscale(struct lv0104cs_private *lv0104cs,
> +				int val, int val2)
> +{
> +	int calibscale = val * 1000000 + val2;
> +	int floor, ceil, mid;
> +	int ret, i, index;
> +
> +	/* round to nearest quantized sensitivity */
> +	for (i = 0; i < ARRAY_SIZE(lv0104cs_calibscales) - 1; i++) {
> +		floor = lv0104cs_calibscales[i].val * 1000000
> +				+ lv0104cs_calibscales[i].val2;
> +		ceil = lv0104cs_calibscales[i + 1].val * 1000000
> +				+ lv0104cs_calibscales[i + 1].val2;
> +		mid = (floor + ceil) / 2;
> +
> +		/* round down */
> +		if (calibscale >= floor && calibscale < mid) {
> +			index = i;
> +			break;
> +		}
> +
> +		/* round up */
> +		if (calibscale >= mid && calibscale <= ceil) {
> +			index = i + 1;
> +			break;
> +		}
> +	}
> +
> +	if (i == ARRAY_SIZE(lv0104cs_calibscales) - 1)
> +		return -EINVAL;
> +
> +	/* set sensitivity */
> +	ret = lv0104cs_write_reg(lv0104cs, lv0104cs_calibscales[index].regval);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&lv0104cs->lock);

shoudn't the lock region include the set sensitivity above?

> +	lv0104cs->calibscale = index;
> +	mutex_unlock(&lv0104cs->lock);
> +
> +	return 0;
> +}
> +
> +static int lv0104cs_set_hardwaregain(struct lv0104cs_private *lv0104cs,
> +				int val, int val2)
> +{
> +	int i;
> +
> +	/* hard matching */
> +	for (i = 0; i < ARRAY_SIZE(lv0104cs_hardwaregains); i++) {
> +		if (val != lv0104cs_hardwaregains[i].val)
> +			continue;
> +
> +		if (val2 == lv0104cs_hardwaregains[i].val2)
> +			break;
> +	}
> +
> +	if (i == ARRAY_SIZE(lv0104cs_hardwaregains))
> +		return -EINVAL;
> +
> +	mutex_lock(&lv0104cs->lock);
> +	lv0104cs->hardwaregain = i;
> +	mutex_unlock(&lv0104cs->lock);
> +
> +	return 0;
> +}
> +
> +static int lv0104cs_set_int_time(struct lv0104cs_private *lv0104cs,
> +				int val, int val2)
> +{
> +	int i;
> +
> +	/* hard matching */
> +	for (i = 0; i < ARRAY_SIZE(lv0104cs_int_times); i++) {
> +		if (val != lv0104cs_int_times[i].val)
> +			continue;
> +
> +		if (val2 == lv0104cs_int_times[i].val2)
> +			break;
> +	}
> +
> +	if (i == ARRAY_SIZE(lv0104cs_int_times))
> +		return -EINVAL;
> +
> +	mutex_lock(&lv0104cs->lock);
> +	lv0104cs->int_time = i;
> +	mutex_unlock(&lv0104cs->lock);
> +
> +	return 0;
> +}
> +
> +static int lv0104cs_write_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int val, int val2, long mask)
> +{
> +	struct lv0104cs_private *lv0104cs = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (chan->type != IIO_LIGHT)
> +		return -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		ret = lv0104cs_set_calibscale(lv0104cs, val, val2);
> +		break;
> +
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		ret = lv0104cs_set_hardwaregain(lv0104cs, val, val2);
> +		break;
> +
> +	case IIO_CHAN_INFO_INT_TIME:
> +		ret = lv0104cs_set_int_time(lv0104cs, val, val2);
> +		break;
> +
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static ssize_t lv0104cs_show_calibscale_avail(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	ssize_t len = 0;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(lv0104cs_calibscales); i++) {
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06d ",
> +				lv0104cs_calibscales[i].val,
> +				lv0104cs_calibscales[i].val2);
> +	}
> +
> +	buf[len - 1] = '\n';
> +
> +	return len;
> +}
> +
> +static ssize_t lv0104cs_show_hardwaregain_avail(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	ssize_t len = 0;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(lv0104cs_hardwaregains); i++) {
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06d ",
> +				lv0104cs_hardwaregains[i].val,
> +				lv0104cs_hardwaregains[i].val2);
> +	}
> +
> +	buf[len - 1] = '\n';
> +
> +	return len;
> +}
> +
> +static ssize_t lv0104cs_show_int_time_avail(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	ssize_t len = 0;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(lv0104cs_int_times); i++) {
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06d ",
> +				lv0104cs_int_times[i].val,
> +				lv0104cs_int_times[i].val2);
> +	}
> +
> +	buf[len - 1] = '\n';
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(calibscale_available, 0444,
> +				lv0104cs_show_calibscale_avail, NULL, 0);
> +static IIO_DEVICE_ATTR(hardwaregain_available, 0444,
> +				lv0104cs_show_hardwaregain_avail, NULL, 0);
> +static IIO_DEV_ATTR_INT_TIME_AVAIL(lv0104cs_show_int_time_avail);
> +
> +static struct attribute *lv0104cs_attributes[] = {
> +	&iio_dev_attr_calibscale_available.dev_attr.attr,
> +	&iio_dev_attr_hardwaregain_available.dev_attr.attr,
> +	&iio_dev_attr_integration_time_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group lv0104cs_attribute_group = {
> +	.attrs = lv0104cs_attributes,
> +};
> +
> +static const struct iio_info lv0104cs_info = {
> +	.attrs = &lv0104cs_attribute_group,
> +	.read_raw = &lv0104cs_read_raw,
> +	.write_raw = &lv0104cs_write_raw,
> +};
> +
> +static const struct iio_chan_spec lv0104cs_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_CALIBSCALE) |
> +				      BIT(IIO_CHAN_INFO_HARDWAREGAIN) |

I think this should be just _SCALE; this is not about calibration, but 
just sets a gain factor

I don't quite understand the need/difference between CALIBSCALE / 
HARDWAREGAIN

> +				      BIT(IIO_CHAN_INFO_INT_TIME),
> +	},
> +};
> +
> +static int lv0104cs_probe(struct i2c_client *client,
> +				const struct i2c_device_id *id)
> +{
> +	struct iio_dev *indio_dev;
> +	struct device *dev = &client->dev;
> +	struct lv0104cs_private *lv0104cs;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(struct lv0104cs_private));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	lv0104cs = iio_priv(indio_dev);
> +
> +	i2c_set_clientdata(client, lv0104cs);
> +	lv0104cs->client = client;
> +
> +	mutex_init(&lv0104cs->lock);
> +
> +	lv0104cs->hardwaregain = LV0104CS_HWGAIN_1x;
> +	lv0104cs->int_time = LV0104CS_INTEG_200m;
> +	lv0104cs->calibscale = LV0104CS_CALIB_UNITY;
> +
> +	ret = lv0104cs_write_reg(lv0104cs,
> +			lv0104cs_calibscales[LV0104CS_CALIB_UNITY].regval);
> +	if (ret)
> +		return -ENODEV;
> +
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->dev.parent = dev;
> +	indio_dev->channels = lv0104cs_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(lv0104cs_channels);
> +	indio_dev->name = client->name;
> +	indio_dev->info = &lv0104cs_info;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to register device: %d\n", ret);
> +		return ret;
> +	}
> +
> +	dev_info(dev, "Successfully registered device\n");

please drop this output, considered just clutter

> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id lv0104cs_id[] = {
> +	{ "lv0104cs", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, lv0104cs_id);
> +
> +static struct i2c_driver lv0104cs_i2c_driver = {
> +	.driver = {
> +		.name	= "lv0104cs",
> +	},
> +
> +	.id_table	= lv0104cs_id,
> +	.probe		= lv0104cs_probe,
> +};
> +module_i2c_driver(lv0104cs_i2c_driver);
> +
> +MODULE_AUTHOR("Jeff LaBundy <jeff@labundy.com>");
> +MODULE_DESCRIPTION("LV0104CS Ambient Light Sensor Driver");
> +MODULE_LICENSE("GPL v2");
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
