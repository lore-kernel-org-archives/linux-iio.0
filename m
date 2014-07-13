Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:35243 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747AbaGMUyb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 13 Jul 2014 16:54:31 -0400
Message-ID: <53C2F28C.2030204@kernel.org>
Date: Sun, 13 Jul 2014 21:56:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 06/12] iio:adc:ad799x: Only expose event interface
 when IRQ is available
References: <1402548856-3564-1-git-send-email-pmeerw@pmeerw.net> <1402548856-3564-7-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402548856-3564-7-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/06/14 05:54, Peter Meerwald wrote:
> an IRQ is necessary to handle the ALERT condition; without
> IRQ, the IIO event interface serves no purpose
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Applied.
> ---
>   drivers/iio/adc/ad799x.c | 265 ++++++++++++++++++++++++++++++++---------------
>   1 file changed, 179 insertions(+), 86 deletions(-)
>
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index b3799a8..b8a8117 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -101,22 +101,32 @@ enum {
>   };
>
>   /**
> - * struct ad799x_chip_info - chip specific information
> + * struct ad799x_chip_config - chip specific information
>    * @channel:		channel specification
> - * @num_channels:	number of channels
>    * @default_config:	device default configuration
>    * @info:		pointer to iio_info struct
>    */
> -struct ad799x_chip_info {
> +struct ad799x_chip_config {
>   	struct iio_chan_spec		channel[9];
> -	int				num_channels;
>   	u16				default_config;
>   	const struct iio_info		*info;
>   };
>
> +/**
> + * struct ad799x_chip_info - chip specific information
> + * @num_channels:	number of channels
> + * @noirq_config:	device configuration w/o IRQ
> + * @irq_config:		device configuration w/IRQ
> + */
> +struct ad799x_chip_info {
> +	int				num_channels;
> +	const struct ad799x_chip_config	noirq_config;
> +	const struct ad799x_chip_config	irq_config;
> +};
> +
>   struct ad799x_state {
>   	struct i2c_client		*client;
> -	const struct ad799x_chip_info	*chip_info;
> +	const struct ad799x_chip_config	*chip_config;
>   	struct regulator		*reg;
>   	struct regulator		*vref;
>   	unsigned			id;
> @@ -446,7 +456,13 @@ static const struct iio_info ad7991_info = {
>   	.driver_module = THIS_MODULE,
>   };
>
> -static const struct iio_info ad7993_4_7_8_info = {
> +static const struct iio_info ad7993_4_7_8_noirq_info = {
> +	.read_raw = &ad799x_read_raw,
> +	.driver_module = THIS_MODULE,
> +	.update_scan_mode = ad7997_8_update_scan_mode,
> +};
> +
> +static const struct iio_info ad7993_4_7_8_irq_info = {
>   	.read_raw = &ad799x_read_raw,
>   	.event_attrs = &ad799x_event_attrs_group,
>   	.read_event_config = &ad799x_read_event_config,
> @@ -501,103 +517,175 @@ static const struct iio_event_spec ad799x_events[] = {
>
>   static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
>   	[ad7991] = {
> -		.channel = {
> -			AD799X_CHANNEL(0, 12),
> -			AD799X_CHANNEL(1, 12),
> -			AD799X_CHANNEL(2, 12),
> -			AD799X_CHANNEL(3, 12),
> -			IIO_CHAN_SOFT_TIMESTAMP(4),
> -		},
>   		.num_channels = 5,
> -		.info = &ad7991_info,
> +		.noirq_config = {
> +			.channel = {
> +				AD799X_CHANNEL(0, 12),
> +				AD799X_CHANNEL(1, 12),
> +				AD799X_CHANNEL(2, 12),
> +				AD799X_CHANNEL(3, 12),
> +				IIO_CHAN_SOFT_TIMESTAMP(4),
> +			},
> +			.info = &ad7991_info,
> +		},
>   	},
>   	[ad7995] = {
> -		.channel = {
> -			AD799X_CHANNEL(0, 10),
> -			AD799X_CHANNEL(1, 10),
> -			AD799X_CHANNEL(2, 10),
> -			AD799X_CHANNEL(3, 10),
> -			IIO_CHAN_SOFT_TIMESTAMP(4),
> -		},
>   		.num_channels = 5,
> -		.info = &ad7991_info,
> +		.noirq_config = {
> +			.channel = {
> +				AD799X_CHANNEL(0, 10),
> +				AD799X_CHANNEL(1, 10),
> +				AD799X_CHANNEL(2, 10),
> +				AD799X_CHANNEL(3, 10),
> +				IIO_CHAN_SOFT_TIMESTAMP(4),
> +			},
> +			.info = &ad7991_info,
> +		},
>   	},
>   	[ad7999] = {
> -		.channel = {
> -			AD799X_CHANNEL(0, 8),
> -			AD799X_CHANNEL(1, 8),
> -			AD799X_CHANNEL(2, 8),
> -			AD799X_CHANNEL(3, 8),
> -			IIO_CHAN_SOFT_TIMESTAMP(4),
> -		},
>   		.num_channels = 5,
> -		.info = &ad7991_info,
> +		.noirq_config = {
> +			.channel = {
> +				AD799X_CHANNEL(0, 8),
> +				AD799X_CHANNEL(1, 8),
> +				AD799X_CHANNEL(2, 8),
> +				AD799X_CHANNEL(3, 8),
> +				IIO_CHAN_SOFT_TIMESTAMP(4),
> +			},
> +			.info = &ad7991_info,
> +		},
>   	},
>   	[ad7992] = {
> -		.channel = {
> -			AD799X_CHANNEL_WITH_EVENTS(0, 12),
> -			AD799X_CHANNEL_WITH_EVENTS(1, 12),
> -			IIO_CHAN_SOFT_TIMESTAMP(3),
> -		},
>   		.num_channels = 3,
> -		.default_config = AD7998_ALERT_EN,
> -		.info = &ad7993_4_7_8_info,
> +		.noirq_config = {
> +			.channel = {
> +				AD799X_CHANNEL(0, 12),
> +				AD799X_CHANNEL(1, 12),
> +				IIO_CHAN_SOFT_TIMESTAMP(3),
> +			},
> +			.info = &ad7993_4_7_8_noirq_info,
> +		},
> +		.irq_config = {
> +			.channel = {
> +				AD799X_CHANNEL_WITH_EVENTS(0, 12),
> +				AD799X_CHANNEL_WITH_EVENTS(1, 12),
> +				IIO_CHAN_SOFT_TIMESTAMP(3),
> +			},
> +			.default_config = AD7998_ALERT_EN,
> +			.info = &ad7993_4_7_8_irq_info,
> +		},
>   	},
>   	[ad7993] = {
> -		.channel = {
> -			AD799X_CHANNEL_WITH_EVENTS(0, 10),
> -			AD799X_CHANNEL_WITH_EVENTS(1, 10),
> -			AD799X_CHANNEL_WITH_EVENTS(2, 10),
> -			AD799X_CHANNEL_WITH_EVENTS(3, 10),
> -			IIO_CHAN_SOFT_TIMESTAMP(4),
> -		},
>   		.num_channels = 5,
> -		.default_config = AD7998_ALERT_EN,
> -		.info = &ad7993_4_7_8_info,
> +		.noirq_config = {
> +			.channel = {
> +				AD799X_CHANNEL(0, 10),
> +				AD799X_CHANNEL(1, 10),
> +				AD799X_CHANNEL(2, 10),
> +				AD799X_CHANNEL(3, 10),
> +				IIO_CHAN_SOFT_TIMESTAMP(4),
> +			},
> +			.info = &ad7993_4_7_8_noirq_info,
> +		},
> +		.irq_config = {
> +			.channel = {
> +				AD799X_CHANNEL_WITH_EVENTS(0, 10),
> +				AD799X_CHANNEL_WITH_EVENTS(1, 10),
> +				AD799X_CHANNEL_WITH_EVENTS(2, 10),
> +				AD799X_CHANNEL_WITH_EVENTS(3, 10),
> +				IIO_CHAN_SOFT_TIMESTAMP(4),
> +			},
> +			.default_config = AD7998_ALERT_EN,
> +			.info = &ad7993_4_7_8_irq_info,
> +		},
>   	},
>   	[ad7994] = {
> -		.channel = {
> -			AD799X_CHANNEL_WITH_EVENTS(0, 12),
> -			AD799X_CHANNEL_WITH_EVENTS(1, 12),
> -			AD799X_CHANNEL_WITH_EVENTS(2, 12),
> -			AD799X_CHANNEL_WITH_EVENTS(3, 12),
> -			IIO_CHAN_SOFT_TIMESTAMP(4),
> -		},
>   		.num_channels = 5,
> -		.default_config = AD7998_ALERT_EN,
> -		.info = &ad7993_4_7_8_info,
> +		.noirq_config = {
> +			.channel = {
> +				AD799X_CHANNEL(0, 12),
> +				AD799X_CHANNEL(1, 12),
> +				AD799X_CHANNEL(2, 12),
> +				AD799X_CHANNEL(3, 12),
> +				IIO_CHAN_SOFT_TIMESTAMP(4),
> +			},
> +			.info = &ad7993_4_7_8_noirq_info,
> +		},
> +		.irq_config = {
> +			.channel = {
> +				AD799X_CHANNEL_WITH_EVENTS(0, 12),
> +				AD799X_CHANNEL_WITH_EVENTS(1, 12),
> +				AD799X_CHANNEL_WITH_EVENTS(2, 12),
> +				AD799X_CHANNEL_WITH_EVENTS(3, 12),
> +				IIO_CHAN_SOFT_TIMESTAMP(4),
> +			},
> +			.default_config = AD7998_ALERT_EN,
> +			.info = &ad7993_4_7_8_irq_info,
> +		},
>   	},
>   	[ad7997] = {
> -		.channel = {
> -			AD799X_CHANNEL_WITH_EVENTS(0, 10),
> -			AD799X_CHANNEL_WITH_EVENTS(1, 10),
> -			AD799X_CHANNEL_WITH_EVENTS(2, 10),
> -			AD799X_CHANNEL_WITH_EVENTS(3, 10),
> -			AD799X_CHANNEL(4, 10),
> -			AD799X_CHANNEL(5, 10),
> -			AD799X_CHANNEL(6, 10),
> -			AD799X_CHANNEL(7, 10),
> -			IIO_CHAN_SOFT_TIMESTAMP(8),
> -		},
>   		.num_channels = 9,
> -		.default_config = AD7998_ALERT_EN,
> -		.info = &ad7993_4_7_8_info,
> +		.noirq_config = {
> +			.channel = {
> +				AD799X_CHANNEL(0, 10),
> +				AD799X_CHANNEL(1, 10),
> +				AD799X_CHANNEL(2, 10),
> +				AD799X_CHANNEL(3, 10),
> +				AD799X_CHANNEL(4, 10),
> +				AD799X_CHANNEL(5, 10),
> +				AD799X_CHANNEL(6, 10),
> +				AD799X_CHANNEL(7, 10),
> +				IIO_CHAN_SOFT_TIMESTAMP(8),
> +			},
> +			.info = &ad7993_4_7_8_noirq_info,
> +		},
> +		.irq_config = {
> +			.channel = {
> +				AD799X_CHANNEL_WITH_EVENTS(0, 10),
> +				AD799X_CHANNEL_WITH_EVENTS(1, 10),
> +				AD799X_CHANNEL_WITH_EVENTS(2, 10),
> +				AD799X_CHANNEL_WITH_EVENTS(3, 10),
> +				AD799X_CHANNEL(4, 10),
> +				AD799X_CHANNEL(5, 10),
> +				AD799X_CHANNEL(6, 10),
> +				AD799X_CHANNEL(7, 10),
> +				IIO_CHAN_SOFT_TIMESTAMP(8),
> +			},
> +			.default_config = AD7998_ALERT_EN,
> +			.info = &ad7993_4_7_8_irq_info,
> +		},
>   	},
>   	[ad7998] = {
> -		.channel = {
> -			AD799X_CHANNEL_WITH_EVENTS(0, 12),
> -			AD799X_CHANNEL_WITH_EVENTS(1, 12),
> -			AD799X_CHANNEL_WITH_EVENTS(2, 12),
> -			AD799X_CHANNEL_WITH_EVENTS(3, 12),
> -			AD799X_CHANNEL(4, 12),
> -			AD799X_CHANNEL(5, 12),
> -			AD799X_CHANNEL(6, 12),
> -			AD799X_CHANNEL(7, 12),
> -			IIO_CHAN_SOFT_TIMESTAMP(8),
> -		},
>   		.num_channels = 9,
> -		.default_config = AD7998_ALERT_EN,
> -		.info = &ad7993_4_7_8_info,
> +		.noirq_config = {
> +			.channel = {
> +				AD799X_CHANNEL(0, 12),
> +				AD799X_CHANNEL(1, 12),
> +				AD799X_CHANNEL(2, 12),
> +				AD799X_CHANNEL(3, 12),
> +				AD799X_CHANNEL(4, 12),
> +				AD799X_CHANNEL(5, 12),
> +				AD799X_CHANNEL(6, 12),
> +				AD799X_CHANNEL(7, 12),
> +				IIO_CHAN_SOFT_TIMESTAMP(8),
> +			},
> +			.info = &ad7993_4_7_8_noirq_info,
> +		},
> +		.irq_config = {
> +			.channel = {
> +				AD799X_CHANNEL_WITH_EVENTS(0, 12),
> +				AD799X_CHANNEL_WITH_EVENTS(1, 12),
> +				AD799X_CHANNEL_WITH_EVENTS(2, 12),
> +				AD799X_CHANNEL_WITH_EVENTS(3, 12),
> +				AD799X_CHANNEL(4, 12),
> +				AD799X_CHANNEL(5, 12),
> +				AD799X_CHANNEL(6, 12),
> +				AD799X_CHANNEL(7, 12),
> +				IIO_CHAN_SOFT_TIMESTAMP(8),
> +			},
> +			.default_config = AD7998_ALERT_EN,
> +			.info = &ad7993_4_7_8_irq_info,
> +		},
>   	},
>   };
>
> @@ -607,6 +695,8 @@ static int ad799x_probe(struct i2c_client *client,
>   	int ret;
>   	struct ad799x_state *st;
>   	struct iio_dev *indio_dev;
> +	const struct ad799x_chip_info *chip_info =
> +		&ad799x_chip_info_tbl[id->driver_data];
>
>   	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
>   	if (indio_dev == NULL)
> @@ -617,8 +707,11 @@ static int ad799x_probe(struct i2c_client *client,
>   	i2c_set_clientdata(client, indio_dev);
>
>   	st->id = id->driver_data;
> -	st->chip_info = &ad799x_chip_info_tbl[st->id];
> -	st->config = st->chip_info->default_config;
> +	if (client->irq > 0 && chip_info->irq_config.info)
> +		st->chip_config = &chip_info->irq_config;
> +	else
> +		st->chip_config = &chip_info->noirq_config;
> +	st->config = st->chip_config->default_config;
>
>   	/* TODO: Add pdata options for filtering and bit delay */
>
> @@ -641,11 +734,11 @@ static int ad799x_probe(struct i2c_client *client,
>
>   	indio_dev->dev.parent = &client->dev;
>   	indio_dev->name = id->name;
> -	indio_dev->info = st->chip_info->info;
> +	indio_dev->info = st->chip_config->info;
>
>   	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->channels = st->chip_info->channel;
> -	indio_dev->num_channels = st->chip_info->num_channels;
> +	indio_dev->channels = st->chip_config->channel;
> +	indio_dev->num_channels = chip_info->num_channels;
>
>   	ret = iio_triggered_buffer_setup(indio_dev, NULL,
>   		&ad799x_trigger_handler, NULL);
>

