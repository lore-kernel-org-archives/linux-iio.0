Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-169.synserver.de ([212.40.185.169]:1092 "EHLO
	smtp-out-160.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751680Ab3HDNsG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Aug 2013 09:48:06 -0400
Message-ID: <51FE5BD5.3060700@metafoo.de>
Date: Sun, 04 Aug 2013 15:49:09 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Add tmp006 IR temperature sensor
References: <1375136888-19978-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1375136888-19978-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/30/2013 12:28 AM, Peter Meerwald wrote:
[...]
> +static int tmp006_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *channel, int *val,
> +			    int *val2, long mask)
> +{
> +	struct tmp006_data *data = iio_priv(indio_dev);
> +	s32 ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (channel->type == IIO_VOLTAGE) {
> +			ret = tmp006_read_measurement(data, TMP006_VOBJECT);
> +			if (ret < 0)
> +				return ret;
> +			*val = (s16) ret;
> +		} else if (channel->type == IIO_TEMP) {
> +			ret = tmp006_read_measurement(data, TMP006_TAMBIENT);
> +			if (ret < 0)
> +				return ret;
> +			*val = (s16) ret >> 2;
> +		} else
> +			break;

Needs braces around the last else branch.

> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (channel->type == IIO_VOLTAGE) {
> +			*val = 0;
> +			*val2 = 156250;
> +		} else if (channel->type == IIO_TEMP) {
> +			*val = 31;
> +			*val2 = 250000;
> +		} else
> +			break;

Same here.

> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +

[...]
> +
> +static int tmp006_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct iio_dev *indio_dev;
> +	struct tmp006_data *data;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
> +		return -ENODEV;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->name = dev_name(&client->dev);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &tmp006_info;
> +
> +	indio_dev->channels = tmp006_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(tmp006_channels);
> +
> +	if (!tmp006_check_identification(data)) {
> +		dev_err(&client->dev, "no TMP006 sensor\n");
> +		return -ENODEV;
> +	}
> +
> +	dev_info(&client->dev, "TMP006 IR thermophile sensor\n");

That's just noise.

> +
> +	ret = i2c_smbus_read_word_swapped(data->client, TMP006_CONFIG);
> +	if (ret < 0)
> +		return ret;
> +	data->config = ret;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
return 0;
> +}
[...]

