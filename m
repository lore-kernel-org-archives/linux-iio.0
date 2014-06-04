Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-156.synserver.de ([212.40.185.156]:1157 "EHLO
	smtp-out-156.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932327AbaFDIFr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 Jun 2014 04:05:47 -0400
Message-ID: <538ED354.6040808@metafoo.de>
Date: Wed, 04 Jun 2014 10:05:40 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, knaack.h@gmx.de
Subject: Re: [PATCH 12/15] iio:adc:ad799x: Write default config on probe and
 reset alert status on probe
References: <1401835335-29969-1-git-send-email-pmeerw@pmeerw.net> <1401835335-29969-13-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1401835335-29969-13-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/04/2014 12:42 AM, Peter Meerwald wrote:
> writing ALERT_EN and BUSY_ALERT to the chip config register clears
> pending alerts, BUSY_ALERT is cleared when reading back the register
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>   drivers/iio/adc/ad799x.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index 0219970..f8e029d 100644
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
> @@ -733,7 +733,6 @@ static int ad799x_probe(struct i2c_client *client,
>   	st->id = id->driver_data;
>   	st->chip_config = (client->irq > 0 && chip_info->irq_config.info) ?
>   		&chip_info->irq_config : &chip_info->noirq_config;
> -	st->config = st->chip_config->default_config;
>
>   	/* TODO: Add pdata options for filtering and bit delay */
>
> @@ -762,6 +761,14 @@ static int ad799x_probe(struct i2c_client *client,
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

