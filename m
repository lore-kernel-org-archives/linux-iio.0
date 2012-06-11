Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53251 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618Ab2FKSNd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jun 2012 14:13:33 -0400
Message-ID: <4FD63541.6000505@kernel.org>
Date: Mon, 11 Jun 2012 19:13:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: add vcnl4000 combined ALS and proximity sensor
References: <1339367961-22456-1-git-send-email-pmeerw@pmeerw.net> <1339367961-22456-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339367961-22456-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/10/2012 11:39 PM, Peter Meerwald wrote:
> minimal driver, submitting to staging
> 
If we are happy interfaces that are here aren't going to change,
skip the staging bit and submit under drivers/iio directly.
Nothing wrong with a driver supporting some functionality!

Obviously I'm not going to repeat Lars-Peter's comments
(or not most of them anyway ;)

Mostly short and clean which always makes me happy.

> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> ---
>  drivers/staging/iio/light/Kconfig    |   11 ++
>  drivers/staging/iio/light/Makefile   |    1 +
>  drivers/staging/iio/light/vcnl4000.c |  265 ++++++++++++++++++++++++++++++++++
>  3 files changed, 277 insertions(+)
>  create mode 100644 drivers/staging/iio/light/vcnl4000.c
> 
> diff --git a/drivers/staging/iio/light/Kconfig b/drivers/staging/iio/light/Kconfig
> index 4bed30e..6b8d022 100644
> --- a/drivers/staging/iio/light/Kconfig
> +++ b/drivers/staging/iio/light/Kconfig
> @@ -50,4 +50,15 @@ config TSL2x7x
>  	 tmd2672, tsl2772, tmd2772 devices.
>  	 Provides iio_events and direct access via sysfs.
>  
> +config SENSORS_VCNL4000
> +	tristate "VCNL4000 combined ALS and proximity sensor"
> +	depends on I2C
> +	default n
> +	---help---
> +	  Say Y here if you want to build a driver for the VCNL4000
> +	  combined ambient light and proximity sensor.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called vcnl4000.
> +
>  endmenu
> diff --git a/drivers/staging/iio/light/Makefile b/drivers/staging/iio/light/Makefile
> index 141af1e..ea2c2f2 100644
> --- a/drivers/staging/iio/light/Makefile
> +++ b/drivers/staging/iio/light/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_SENSORS_ISL29018)	+= isl29018.o
>  obj-$(CONFIG_SENSORS_ISL29028)	+= isl29028.o
>  obj-$(CONFIG_TSL2583)	+= tsl2583.o
>  obj-$(CONFIG_TSL2x7x)	+= tsl2x7x_core.o
> +obj-$(CONFIG_SENSORS_VCNL4000)	+= vcnl4000.o
> diff --git a/drivers/staging/iio/light/vcnl4000.c b/drivers/staging/iio/light/vcnl4000.c
> new file mode 100644
> index 0000000..c513b4b
> --- /dev/null
> +++ b/drivers/staging/iio/light/vcnl4000.c
> @@ -0,0 +1,265 @@
> +/*
> + * vcnl4000.c - Support for Vishay VCNL4000 combined ambient light and
> + * proximity sensor
> + *
> + * Copyright 2012 Peter Meerwald <pmeerw@pmeerw.net>
> + *
> + * This file is subject to the terms and conditions of version 2 of
> + * the GNU General Public License.  See the file COPYING in the main
> + * directory of this archive for more details.
> + *
> + * IIO driver for VCNL4000 (7-bit I2C slave address 0x13)
> + *
> + * TODO:
> + *   allow to adjust IR current
> + *   need scale/calibscale?
> + *   proximity threshold and event handling
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/err.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define VCNL4000_DRV_NAME "vcnl4000"
> +
> +#define VCNL4000_COMMAND	0x80 /* Command register */
> +#define VCNL4000_PROD_REV	0x81 /* Product ID and Revision ID */
> +#define VCNL4000_LED_CURRENT	0x83 /* IR LED current for proximity mode */
> +#define VCNL4000_AL_PARAM	0x84 /* Ambient light parameter register */
> +#define VCNL4000_AL_RESULT_HI	0x85 /* Ambient light result register, MSB */
> +#define VCNL4000_AL_RESULT_LO	0x86 /* Ambient light result register, LSB */
> +#define VCNL4000_PS_RESULT_HI	0x87 /* Proximity result register, MSB */
> +#define VCNL4000_PS_RESULT_LO	0x88 /* Proximity result register, LSB */
> +#define VCNL4000_PS_MEAS_FREQ	0x89 /* Proximity measurement signal frequency */
> +#define VCNL4000_PS_MOD_ADJ	0x8a /* Proximity modulator timing adjustment */
> +
> +/* Bit masks for COMMAND register */
> +#define VCNL4000_ALS_RDY	0x40 /* ALS data ready? */
> +#define VCNL4000_PS_RDY		0x20 /* proximity data ready? */
> +#define VCNL4000_ALS_OD		0x10 /* start on-demand ALS measurement */
> +#define VCNL4000_PS_OD		0x08 /* start on-demand proximity measurement */
> +
> +struct vcnl4000_data {
> +	struct i2c_client *client;
> +};
> +
> +static const struct i2c_device_id vcnl4000_id[] = {
> +	{ "vcnl4000", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, vcnl4000_id);
> +
> +static int vcnl4000_read(struct vcnl4000_data *data, u8 reg, const char *msg)
> +{
> +	int ret = i2c_smbus_read_byte_data(data->client, reg);
> +	if (ret < 0)
> +		dev_err(&data->client->dev,
> +			"vcnl4000_read(%s) failed, error %d\n",
> +			msg, ret);
Personally I'm a fan of not bothering to wrap standard functions like
this.  The debugging info (which 'should' never happen) isn't
worth the added lines of code...  Still if you are particularly
attached to them, I'm not that bothered.  I'm particularly
anti the passing of a string purely to paste into an error
message....

> +	return ret;
> +}
> +
> +static int vcnl4000_write(struct vcnl4000_data *data,
> +				u8 reg, u8 val, const char *msg)
> +{
> +	int ret = i2c_smbus_write_byte_data(data->client, reg, val);
> +	if (ret < 0)
> +		dev_err(&data->client->dev,
> +			"vcnl4000_write(%s) failed, error %d\n",
> +			msg, ret);
> +	return ret;
> +}
> +
> +
> +static int vcnl4000_get_als(struct vcnl4000_data *data, int *val)
> +{
> +	u16 buf;
> +	int ret;
> +
> +	ret = vcnl4000_write(data, VCNL4000_COMMAND,
> +		VCNL4000_ALS_OD, "COMMAND");
> +	if (ret < 0)
> +		return ret;
> +
> +	/* wait for ALS data to become ready */
> +	do {
> +		ret = vcnl4000_read(data, VCNL4000_COMMAND, "COMMAND");
> +		if (ret < 0)
> +			return ret;
> +	} while (!(ret & VCNL4000_ALS_RDY));
> +
> +	ret = i2c_smbus_read_i2c_block_data(data->client,
> +		VCNL4000_AL_RESULT_HI, sizeof(buf), (u8 *) &buf);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev,
> +			"i2c_smbus_read_block_data() failed, error %d\n", ret);
More informative to say what the read is of? Don't think we care
that it was a block data read...
> +		return ret;
> +	}
> +
> +	*val = __be16_to_cpu(buf);
> +
> +	return 0;
> +}
> +
> +static int vcnl4000_get_ps(struct vcnl4000_data *data, int *val)
> +{
> +	u16 buf;
> +	int ret;
> +
> +	ret = vcnl4000_write(data, VCNL4000_COMMAND,
> +		VCNL4000_PS_OD, "COMMAND");
> +	if (ret < 0)
> +		return ret;
> +
> +	/* wait for proximity data to become ready */
> +	do {
> +		ret = vcnl4000_read(data, VCNL4000_COMMAND, "COMMAND");
> +		if (ret < 0)
> +			return ret;
> +	} while (!(ret & VCNL4000_PS_RDY));
> +
> +	ret = i2c_smbus_read_i2c_block_data(data->client,
> +		VCNL4000_PS_RESULT_HI, sizeof(buf), (u8 *) &buf);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev,
> +			"i2c_smbus_read_block_data() failed, error %d\n", ret);
> +		return ret;
> +	}
> +
> +	*val = __be16_to_cpu(buf);
> +
> +	return 0;
> +}
> +
> +static const struct iio_chan_spec vcnl4000_channels[] = {
> +	{
> +		.type = IIO_INTENSITY,
> +		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
> +	}, {
> +		.type = IIO_PROXIMITY,
> +		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
> +	}, {
> +		.type = IIO_LIGHT,
Some indication of what frequency range is covered would be good.
The modifiers are a bit less than ideal but there we are ;)
> +		.info_mask = IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT,
> +	}
> +};
> +
> +static int vcnl4000_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	int ret = -EINVAL;
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_INTENSITY:
> +			ret = vcnl4000_get_als(data, val);
> +			if (ret < 0)
> +				return ret;
> +			ret = IIO_VAL_INT;
> +			break;
> +		case IIO_PROXIMITY:
> +			ret = vcnl4000_get_ps(data, val);
> +			if (ret < 0)
> +				return ret;
> +			ret = IIO_VAL_INT;
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_PROCESSED:
> +		if (chan->type == IIO_LIGHT) {
> +			ret = vcnl4000_get_als(data, val);
> +			if (ret < 0)
> +				return ret;
> +			*val = (*val + 3) / 4;
> +			ret = IIO_VAL_INT;
Wouldn't bothere with both processed and raw here given simplicity
of the calculation. Pick one and run with it.
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct iio_info vcnl4000_info = {
> +	.read_raw = vcnl4000_read_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static int __devinit vcnl4000_probe(struct i2c_client *client,
> +					const struct i2c_device_id *id)
> +{
> +	struct vcnl4000_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = iio_device_alloc(sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +
> +	ret = vcnl4000_read(data, VCNL4000_PROD_REV, "PROD_REV");
> +	if (ret < 0)
> +		goto error_free_dev;
> +
> +	dev_info(&client->dev, "VCNL4000 Ambient light/proximity sensor, "
> +		"Prod %02x, Rev: %02x\n", ret >> 4, ret & 0xf);
> +
> +	ret = vcnl4000_read(data, VCNL4000_LED_CURRENT, "LED_CURRENT");
> +	if (ret < 0)
> +		goto error_free_dev;
Why?
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->info = &vcnl4000_info;
> +	indio_dev->channels = vcnl4000_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(vcnl4000_channels);
> +	indio_dev->name = VCNL4000_DRV_NAME;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0)
> +		goto error_free_dev;
> +
> +	return 0;
> +
> +error_free_dev:
> +	iio_device_free(indio_dev);
> +	return ret;
> +}
> +
> +static int __devexit vcnl4000_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +
> +	iio_device_unregister(indio_dev);
> +	iio_device_free(indio_dev);
> +
> +	return 0;
> +}
> +
> +static struct i2c_driver vcnl4000_driver = {
> +	.driver = {
> +		.name   = VCNL4000_DRV_NAME,
> +		.owner  = THIS_MODULE,
> +	},
> +	.probe  = vcnl4000_probe,
> +	.remove = __devexit_p(vcnl4000_remove),
> +	.id_table = vcnl4000_id,
> +};
> +
> +module_i2c_driver(vcnl4000_driver);
> +
> +MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
> +MODULE_DESCRIPTION("Vishay VCNL4000 proximity/ambient light sensor driver");
> +MODULE_LICENSE("GPL");

