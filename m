Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-077.synserver.de ([212.40.185.77]:1024 "EHLO
	smtp-out-015.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751794AbaAJJZX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jan 2014 04:25:23 -0500
Message-ID: <52CFBC9D.4070509@metafoo.de>
Date: Fri, 10 Jan 2014 10:25:49 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Add Lite-On ltr501 ambient light / proximity sensor
 driver
References: <1389133660-28024-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1389133660-28024-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/07/2014 11:27 PM, Peter Meerwald wrote:

> +static int ltr501_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	struct ltr501_data *data = iio_priv(indio_dev);
> +	__le16 buf[2];
> +	int ret, i;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (iio_buffer_enabled(indio_dev))
> +			return -EBUSY;
> +
> +		switch (chan->type) {
> +		case IIO_INTENSITY:
> +			ret = ltr501_drdy(data, LTR501_STATUS_ALS_RDY);
> +			if (ret < 0)
> +				return ret;
> +			/* always read both ALS channels in given order */
> +			ret = i2c_smbus_read_i2c_block_data(data->client,
> +				LTR501_ALS_DATA1, sizeof(buf), (u8 *) buf);
> +			if (ret < 0)
> +				return ret;
> +			*val = le16_to_cpu(chan->address == LTR501_ALS_DATA1 ?
> +				buf[0] : buf[1]);
> +			return IIO_VAL_INT;
> +		case IIO_PROXIMITY:
> +			ret = ltr501_drdy(data, LTR501_STATUS_PS_RDY);
> +			if (ret < 0)
> +				return ret;
> +			ret = i2c_smbus_read_word_data(data->client,
> +				chan->address);
> +			if (ret < 0)
> +				return ret;
> +			*val = ret & LTR501_PS_DATA_MASK;
> +			return IIO_VAL_INT;

Will anything bad happen if two processes concurrently read from the device?

> +		}

[...]
> +
> +static int ltr501_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *id)
> +{
> +	struct ltr501_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, LTR501_PART_ID);
> +	if (ret < 0)
> +		return ret;
> +
> +	dev_info(&client->dev, "LTR501 Ambient light/proximity sensor, Part number %02x, Rev: %02x\n",
> +		ret >> 4, ret & 0xf);

I'm not a fan of those probe() dev_info()s. It becomes pretty useless if all
drivers start doing this as you'll end up with a endless streams of "Hello
here I am, look at me!!!".

> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->info = &ltr501_info;
> +	indio_dev->channels = ltr501_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ltr501_channels);
> +	indio_dev->name = LTR501_DRV_NAME;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = ltr501_init(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> +		ltr501_trigger_handler, NULL);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_device_register(&client->dev, indio_dev);

This is one of the cases where we can not use devm_iio_device_register since
it changes the cleanup order. If you uss managed registration
iio_device_unregister will run after iio_triggered_buffer_cleanup and
ltr501_powerdown. Which means there is a chance of a race as the device will
still be accessible until iio_device_unregister has been called.

> +	if (ret)
> +		goto error_unreg_buffer;
> +
> +	return 0;
> +
> +error_unreg_buffer:
> +	iio_triggered_buffer_cleanup(indio_dev);
> +	return ret;
> +}

