Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:64489 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753398Ab3IETDX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 5 Sep 2013 15:03:23 -0400
Message-ID: <5228D594.3080403@metafoo.de>
Date: Thu, 05 Sep 2013 21:03:48 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, Jon Brenner <jon.brenner@ams.com>
Subject: Re: [PATCH v2] iio: Add tsl4531 ambient light sensor driver
References: <1378170611-27795-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1378170611-27795-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/03/2013 03:10 AM, Peter Meerwald wrote:
[...]
> +static int tsl4531_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct tsl4531_data *data = iio_priv(indio_dev);
> +	int int_time, ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		if (val != 0)
> +			return -EINVAL;
> +		if (val2 == 400000)
> +			int_time = 0;
> +		else if (val2 == 200000)
> +			int_time = 1;
> +		else if (val2 == 100000)
> +			int_time = 2;
> +		else
> +			return -EINVAL;
> +		ret = i2c_smbus_write_byte_data(data->client,
> +			TSL4531_CONFIG, int_time);
> +		if (ret >= 0)
> +			data->int_time = int_time;

This probably needs locking to make sure that the register value and the cached 
value stay in sync.

> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
[...]
> +static int tsl4531_check_id(struct i2c_client *client)
> +{
> +	int ret = i2c_smbus_read_byte_data(client, TSL4531_ID);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret >>= TSL4531_ID_SHIFT;
> +	return ret == TSL45313_ID || ret == TSL45315_ID ||
> +		ret == TSL45315_ID || ret == TSL45317_ID;

nitpick: A switch statement would in my opinion looks cleaner. And you have 
TSL45315_ID twice, but 11 is missing.

> +}
> +
> +static int tsl4531_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *id)
> +{
> +	struct tsl4531_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev =  devm_iio_device_alloc(&client->dev, sizeof(*data));

extra space after the =

> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +
> +	if (!tsl4531_check_id(client)) {
> +		dev_err(&client->dev, "no TSL4531 sensor\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = i2c_smbus_write_byte_data(data->client, TSL4531_CONTROL,
> +		TSL4531_MODE_NORMAL);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, TSL4531_CONFIG,
> +		TSL4531_TCNTRL_400MS);
> +	if (ret < 0)
> +		return ret;
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->info = &tsl4531_info;
> +	indio_dev->channels = tsl4531_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(tsl4531_channels);
> +	indio_dev->name = TSL4531_DRV_NAME;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = iio_device_register(indio_dev);

return iio_device_register(indio_dev);

> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
[...]

