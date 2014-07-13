Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:35302 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747AbaGMU4F (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 13 Jul 2014 16:56:05 -0400
Message-ID: <53C2F2EB.9060104@kernel.org>
Date: Sun, 13 Jul 2014 21:58:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 09/12] iio:adc:ad799x: Write default config on probe
 and reset alert status on probe
References: <1402548856-3564-1-git-send-email-pmeerw@pmeerw.net> <1402548856-3564-10-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402548856-3564-10-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/06/14 05:54, Peter Meerwald wrote:
> writing ALERT_EN and BUSY_ALERT to the chip config register clears
> pending alerts, BUSY_ALERT is cleared when reading back the register
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Applied.
> ---
>   drivers/iio/adc/ad799x.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index fe2a9b1..84ce9b4 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -595,7 +595,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
>   				AD799X_CHANNEL_WITH_EVENTS(1, 12),
>   				IIO_CHAN_SOFT_TIMESTAMP(3),
>   			},
> -			.default_config = AD7998_ALERT_EN,
> +			.default_config = AD7998_ALERT_EN | AD7998_BUSY_ALERT,
>   			.info = &ad7993_4_7_8_irq_info,
>   		},
>   	},
> @@ -619,7 +619,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
>   				AD799X_CHANNEL_WITH_EVENTS(3, 10),
>   				IIO_CHAN_SOFT_TIMESTAMP(4),
>   			},
> -			.default_config = AD7998_ALERT_EN,
> +			.default_config = AD7998_ALERT_EN | AD7998_BUSY_ALERT,
>   			.info = &ad7993_4_7_8_irq_info,
>   		},
>   	},
> @@ -643,7 +643,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
>   				AD799X_CHANNEL_WITH_EVENTS(3, 12),
>   				IIO_CHAN_SOFT_TIMESTAMP(4),
>   			},
> -			.default_config = AD7998_ALERT_EN,
> +			.default_config = AD7998_ALERT_EN | AD7998_BUSY_ALERT,
>   			.info = &ad7993_4_7_8_irq_info,
>   		},
>   	},
> @@ -675,7 +675,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
>   				AD799X_CHANNEL(7, 10),
>   				IIO_CHAN_SOFT_TIMESTAMP(8),
>   			},
> -			.default_config = AD7998_ALERT_EN,
> +			.default_config = AD7998_ALERT_EN | AD7998_BUSY_ALERT,
>   			.info = &ad7993_4_7_8_irq_info,
>   		},
>   	},
> @@ -707,7 +707,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
>   				AD799X_CHANNEL(7, 12),
>   				IIO_CHAN_SOFT_TIMESTAMP(8),
>   			},
> -			.default_config = AD7998_ALERT_EN,
> +			.default_config = AD7998_ALERT_EN | AD7998_BUSY_ALERT,
>   			.info = &ad7993_4_7_8_irq_info,
>   		},
>   	},
> @@ -735,7 +735,6 @@ static int ad799x_probe(struct i2c_client *client,
>   		st->chip_config = &chip_info->irq_config;
>   	else
>   		st->chip_config = &chip_info->noirq_config;
> -	st->config = st->chip_config->default_config;
>
>   	/* TODO: Add pdata options for filtering and bit delay */
>
> @@ -764,6 +763,14 @@ static int ad799x_probe(struct i2c_client *client,
>   	indio_dev->channels = st->chip_config->channel;
>   	indio_dev->num_channels = chip_info->num_channels;
>
> +	ret = ad799x_write_config(st, st->chip_config->default_config);
> +	if (ret < 0)
> +		goto error_disable_reg;
> +	ret = ad799x_read_config(st);
> +	if (ret < 0)
> +		goto error_disable_reg;
> +	st->config = ret;
> +
>   	ret = iio_triggered_buffer_setup(indio_dev, NULL,
>   		&ad799x_trigger_handler, NULL);
>   	if (ret)
>

