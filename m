Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44139 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218AbbCIPI6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2015 11:08:58 -0400
Message-ID: <54FDB788.3050009@kernel.org>
Date: Mon, 09 Mar 2015 15:08:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: =?UTF-8?B?Vmlhbm5leSBsZSBDbMOpbWVudCBkZSBTYWludC1NYXJjcQ==?=
	<vianney.leclement@essensium.com>, linux-iio@vger.kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: "Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
Subject: Re: [PATCH 3/7] iio: mlx90614: Add processed temperature output
References: <1424879712-28304-1-git-send-email-vianney.leclement@essensium.com> <1424879712-28304-4-git-send-email-vianney.leclement@essensium.com>
In-Reply-To: <1424879712-28304-4-git-send-email-vianney.leclement@essensium.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/02/15 15:55, Vianney le Clément de Saint-Marcq wrote:
> Provide processed temperature in milli-Celsius through the
> in_temp_*_input interface.
Why?  It's trivial for userspace to do the conversion, so
why provide the additional interface?  As a rule we don't provide
both as in general these sensors are wrapped up in a library that can
do the work more efficiently in userspace when needed.

J
> 
> Also correct the formula in the comment as 1/20 = 0.05 instead of 0.02.
> 
> Signed-off-by: Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>
> Cc: Arnout Vandecappelle (Essensium/Mind) <arnout@mind.be>
> ---
>  drivers/iio/temperature/mlx90614.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> index a2e3aa6..d5b41fd 100644
> --- a/drivers/iio/temperature/mlx90614.c
> +++ b/drivers/iio/temperature/mlx90614.c
> @@ -2,6 +2,7 @@
>   * mlx90614.c - Support for Melexis MLX90614 contactless IR temperature sensor
>   *
>   * Copyright (c) 2014 Peter Meerwald <pmeerw@pmeerw.net>
> + * Copyright (c) 2015 Essensium NV
>   *
>   * This file is subject to the terms and conditions of version 2 of
>   * the GNU General Public License.  See the file COPYING in the main
> @@ -62,7 +63,8 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
>  	s32 ret;
>  
>  	switch (mask) {
> -	case IIO_CHAN_INFO_RAW: /* 0.02K / LSB */
> +	case IIO_CHAN_INFO_RAW: /* 0.05K / LSB */
> +	case IIO_CHAN_INFO_PROCESSED:
>  		switch (channel->channel2) {
>  		case IIO_MOD_TEMP_AMBIENT:
>  			ret = i2c_smbus_read_word_data(data->client,
> @@ -79,7 +81,14 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> -		*val = ret;
> +		switch (mask) {
> +		case IIO_CHAN_INFO_RAW:
> +			*val = ret;
> +			break;
> +		case IIO_CHAN_INFO_PROCESSED:
> +			*val = ret * 20 - 273150;
> +			break;
> +		}
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_OFFSET:
>  		*val = 13657;
> @@ -98,7 +107,8 @@ static const struct iio_chan_spec mlx90614_channels[] = {
>  		.type = IIO_TEMP,
>  		.modified = 1,
>  		.channel2 = IIO_MOD_TEMP_AMBIENT,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +		    BIT(IIO_CHAN_INFO_PROCESSED),
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
>  		    BIT(IIO_CHAN_INFO_SCALE),
>  	},
> @@ -106,7 +116,8 @@ static const struct iio_chan_spec mlx90614_channels[] = {
>  		.type = IIO_TEMP,
>  		.modified = 1,
>  		.channel2 = IIO_MOD_TEMP_OBJECT,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +		    BIT(IIO_CHAN_INFO_PROCESSED),
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
>  		    BIT(IIO_CHAN_INFO_SCALE),
>  	},
> @@ -170,5 +181,6 @@ static struct i2c_driver mlx90614_driver = {
>  module_i2c_driver(mlx90614_driver);
>  
>  MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
> +MODULE_AUTHOR("Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>");
>  MODULE_DESCRIPTION("Melexis MLX90614 contactless IR temperature sensor driver");
>  MODULE_LICENSE("GPL");
> 

