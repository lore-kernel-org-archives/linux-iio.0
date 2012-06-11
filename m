Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-194.synserver.de ([212.40.185.194]:1103 "EHLO
	smtp-out-178.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752154Ab2FKLJm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jun 2012 07:09:42 -0400
Message-ID: <4FD5D2C5.9090803@metafoo.de>
Date: Mon, 11 Jun 2012 13:13:09 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: add vcnl4000 combined ALS and proximity sensor
References: <1339367961-22456-1-git-send-email-pmeerw@pmeerw.net> <1339367961-22456-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339367961-22456-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/11/2012 12:39 AM, Peter Meerwald wrote:
> minimal driver, submitting to staging
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>

Just some minor nitpicks inline.

> ---
> [...]
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

__be16

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

This should have a timeout, so it does not get stuck in a endless loop in
case there is an issue with the hardware.

> +
> +	ret = i2c_smbus_read_i2c_block_data(data->client,
> +		VCNL4000_AL_RESULT_HI, sizeof(buf), (u8 *) &buf);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev,
> +			"i2c_smbus_read_block_data() failed, error %d\n", ret);
> +		return ret;
> +	}
> +
> +	*val = __be16_to_cpu(buf);

just be16_to_cpu, without the underscores

> +
> +	return 0;
> +}
> +
> +static int vcnl4000_get_ps(struct vcnl4000_data *data, int *val)
> +{
> +	u16 buf;
> +	int ret;

This function has the same structure as the one above, maybe put this in a
common function which takes the OD and RDY bits and the RESULT register as
parameters.

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

Does it make sense to do this processing here? Or should it rather return
the raw value and have a scale attribute?

> +			ret = IIO_VAL_INT;
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

The result of this read is never used.

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
> +[...]
