Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:48384 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751900AbeEGI14 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 May 2018 04:27:56 -0400
Subject: Re: [PATCH] iio: potentiometer: add driver for Maxim Integrated
 DS1807
To: Michael Trimarchi <michael@amarulasolutions.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <1525613447-32734-1-git-send-email-michael@amarulasolutions.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <c5419723-a2e6-d322-339b-20cdd3766075@metafoo.de>
Date: Mon, 7 May 2018 10:27:52 +0200
MIME-Version: 1.0
In-Reply-To: <1525613447-32734-1-git-send-email-michael@amarulasolutions.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/06/2018 03:30 PM, Michael Trimarchi wrote:
[..]
> +static int ds1807_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct ds1807_data *data = iio_priv(indio_dev);
> +	int pot = chan->channel;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		if (val2 != 0 || val < DS1807_MUTE || val > 0)
> +			return -EINVAL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	val = (val == DS1807_MUTE) ? DS1807_MAX_VALUE : -val;

Writing anything between -63 and -90 will cause a bogus value to be written
to the register. Might want to change this to

if (val < -DS1807_MAX_VALUE)
	val = -DS1807_MAX_VALUE;

So anything smaller than -63dB gets rounded down to the mute setting.

> +
> +	return i2c_smbus_write_byte_data(data->client, DS1807_WRITE(pot), val);
> +}
> +
> +static const struct iio_info ds1807_info = {
> +	.read_raw = ds1807_read_raw,
> +	.write_raw = ds1807_write_raw,
> +};
> +
> +static int ds1807_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	struct ds1807_data *data;
> +	struct iio_dev *indio_dev;
> +	int channel, ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, indio_dev);

clientdata never seems to be used, so this could be removed.

> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +
> +	indio_dev->dev.parent = dev;
> +	indio_dev->info = &ds1807_info;
> +	indio_dev->channels = ds1807_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ds1807_channels);
> +	indio_dev->name = client->name;
> +
> +	/* reset device gain */
> +	for (channel = 0; channel < indio_dev->num_channels; channel++) {
> +		ret = i2c_smbus_write_byte_data(client, DS1807_WRITE(channel),
> +						DS1807_MUTE);
You could use the write both channels at the same time feature here and get
rid of the loop.

> +		if (ret < 0)
> +			return -ENODEV;
> +	}
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
