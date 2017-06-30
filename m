Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:34695 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751659AbdF3OLR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Jun 2017 10:11:17 -0400
Subject: Re: [PATCH] iio: Add LTC2471/LTC2473 driver
To: Mike Looijmans <mike.looijmans@topic.nl>, linux-iio@vger.kernel.org
References: <1498807267-946-1-git-send-email-mike.looijmans@topic.nl>
Cc: linux-kernel@vger.kernel.org, jic23@kernel.org, linux@roeck-us.net
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <859a730d-1970-8b03-06ee-64ec6da876a6@metafoo.de>
Date: Fri, 30 Jun 2017 16:11:14 +0200
MIME-Version: 1.0
In-Reply-To: <1498807267-946-1-git-send-email-mike.looijmans@topic.nl>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/30/2017 09:21 AM, Mike Looijmans wrote:
> The LTC2741 and LTC2473 are single voltage ADC chips. The LTC2473
> is similar to the LTC2471 but outputs a signed differential value.
> 
> Datasheet:
>   http://cds.linear.com/docs/en/datasheet/24713fb.pdf
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

Looks good, thanks!

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

Just two tiny nitpicks inline.

> +static const struct iio_chan_spec ltc2471_channel[] = {
> +	{
> +		.type = IIO_VOLTAGE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +		.differential = 0,
> +	},
> +};

There should be a newline here.

> +static const struct iio_chan_spec ltc2473_channel[] = {
> +	{
> +		.type = IIO_VOLTAGE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
> +					    BIT(IIO_CHAN_INFO_OFFSET),
> +		.differential = 1,
> +	},
> +};
> [...]
> +static int ltc2471_i2c_probe(struct i2c_client *client,
> +			     const struct i2c_device_id *id)
> +{
> [...]
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);

You don't need this since i2c_get_clientdata() is never used.

> +	data->client = client;
> +

