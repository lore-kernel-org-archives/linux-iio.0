Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751766AbeEFSHq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 May 2018 14:07:46 -0400
Date: Sun, 6 May 2018 19:05:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        drew.paterson@ams.com
Subject: Re: [PATCH v2 03/11] staging: iio: tsl2x7x: don't setup event
 handlers if interrupts are not configured
Message-ID: <20180506190509.2b8098d8@archlinux>
In-Reply-To: <20180504025319.28953-4-masneyb@onstation.org>
References: <20180504025319.28953-1-masneyb@onstation.org>
        <20180504025319.28953-4-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu,  3 May 2018 22:53:11 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The driver would expose to userspace the events directory even if the
> interrupts were not configured. This patch changes the driver so that
> the events directory is not exposed to user space if interrupts are
> not configured. This patch also corrects the indentation of the
> chan_table_elements and info structure members.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 130 +++++++++++++++++++++++++++++++-----
>  1 file changed, 112 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index b4d77f65ca12..7e8db5178a2c 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -134,8 +134,9 @@ struct tsl2x7x_als_info {
>  
>  struct tsl2x7x_chip_info {
>  	int chan_table_elements;
> -	struct iio_chan_spec		channel[4];
> -	const struct iio_info		*info;
> +	struct iio_chan_spec channel_with_events[4];
> +	struct iio_chan_spec channel_without_events[4];
> +	const struct iio_info *info;
>  };
>  
>  struct tsl2X7X_chip {
> @@ -1447,7 +1448,7 @@ static const struct iio_event_spec tsl2x7x_events[] = {
>  
>  static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  	[ALS] = {
> -		.channel = {
> +		.channel_with_events = {
>  			{
>  			.type = IIO_LIGHT,
>  			.indexed = 1,
> @@ -1469,11 +1470,31 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			.channel = 1,
>  			},
>  		},
> -	.chan_table_elements = 3,
> -	.info = &tsl2X7X_device_info[ALS],
> +		.channel_without_events = {
> +			{
> +			.type = IIO_LIGHT,
> +			.indexed = 1,
> +			.channel = 0,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +			}, {
> +			.type = IIO_INTENSITY,
> +			.indexed = 1,
> +			.channel = 0,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				BIT(IIO_CHAN_INFO_INT_TIME) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE) |
> +				BIT(IIO_CHAN_INFO_CALIBBIAS),
> +			}, {
> +			.type = IIO_INTENSITY,
> +			.indexed = 1,
> +			.channel = 1,
> +			},
> +		},
> +		.chan_table_elements = 3,
> +		.info = &tsl2X7X_device_info[ALS],
>  	},
>  	[PRX] = {
> -		.channel = {
> +		.channel_with_events = {
>  			{
>  			.type = IIO_PROXIMITY,
>  			.indexed = 1,
> @@ -1483,11 +1504,19 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
>  			},
>  		},
> -	.chan_table_elements = 1,
> -	.info = &tsl2X7X_device_info[PRX],
> +		.channel_without_events = {
> +			{
> +			.type = IIO_PROXIMITY,
> +			.indexed = 1,
> +			.channel = 0,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +			},
> +		},
> +		.chan_table_elements = 1,
> +		.info = &tsl2X7X_device_info[PRX],
>  	},
>  	[ALSPRX] = {
> -		.channel = {
> +		.channel_with_events = {
>  			{
>  			.type = IIO_LIGHT,
>  			.indexed = 1,
> @@ -1517,11 +1546,37 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
>  			},
>  		},
> -	.chan_table_elements = 4,
> -	.info = &tsl2X7X_device_info[ALSPRX],
> +		.channel_without_events = {
> +			{
> +			.type = IIO_LIGHT,
> +			.indexed = 1,
> +			.channel = 0,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +			}, {
> +			.type = IIO_INTENSITY,
> +			.indexed = 1,
> +			.channel = 0,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				BIT(IIO_CHAN_INFO_INT_TIME) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE) |
> +				BIT(IIO_CHAN_INFO_CALIBBIAS),
> +			}, {
> +			.type = IIO_INTENSITY,
> +			.indexed = 1,
> +			.channel = 1,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +			}, {
> +			.type = IIO_PROXIMITY,
> +			.indexed = 1,
> +			.channel = 0,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +			},
> +		},
> +		.chan_table_elements = 4,
> +		.info = &tsl2X7X_device_info[ALSPRX],
>  	},
>  	[PRX2] = {
> -		.channel = {
> +		.channel_with_events = {
>  			{
>  			.type = IIO_PROXIMITY,
>  			.indexed = 1,
> @@ -1532,11 +1587,20 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
>  			},
>  		},
> -	.chan_table_elements = 1,
> -	.info = &tsl2X7X_device_info[PRX2],
> +		.channel_without_events = {
> +			{
> +			.type = IIO_PROXIMITY,
> +			.indexed = 1,
> +			.channel = 0,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE),
> +			},
> +		},
> +		.chan_table_elements = 1,
> +		.info = &tsl2X7X_device_info[PRX2],
>  	},
>  	[ALSPRX2] = {
> -		.channel = {
> +		.channel_with_events = {
>  			{
>  			.type = IIO_LIGHT,
>  			.indexed = 1,
> @@ -1567,8 +1631,35 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
>  			},
>  		},
> -	.chan_table_elements = 4,
> -	.info = &tsl2X7X_device_info[ALSPRX2],
> +		.channel_without_events = {
> +			{
> +			.type = IIO_LIGHT,
> +			.indexed = 1,
> +			.channel = 0,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +			}, {
> +			.type = IIO_INTENSITY,
> +			.indexed = 1,
> +			.channel = 0,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				BIT(IIO_CHAN_INFO_INT_TIME) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE) |
> +				BIT(IIO_CHAN_INFO_CALIBBIAS),
> +			}, {
> +			.type = IIO_INTENSITY,
> +			.indexed = 1,
> +			.channel = 1,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +			}, {
> +			.type = IIO_PROXIMITY,
> +			.indexed = 1,
> +			.channel = 0,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE),
> +			},
> +		},
> +		.chan_table_elements = 4,
> +		.info = &tsl2X7X_device_info[ALSPRX2],
>  	},
>  };
>  
> @@ -1620,10 +1711,11 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
>  	indio_dev->dev.parent = &clientp->dev;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->name = chip->client->name;
> -	indio_dev->channels = chip->chip_info->channel;
>  	indio_dev->num_channels = chip->chip_info->chan_table_elements;
>  
>  	if (clientp->irq) {
> +		indio_dev->channels = chip->chip_info->channel_with_events;
> +
>  		ret = devm_request_threaded_irq(&clientp->dev, clientp->irq,
>  						NULL,
>  						&tsl2x7x_event_handler,
> @@ -1636,6 +1728,8 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
>  				"%s: irq request failed\n", __func__);
>  			return ret;
>  		}
> +	} else {
> +		indio_dev->channels = chip->chip_info->channel_without_events;
>  	}
>  
>  	tsl2x7x_defaults(chip);

