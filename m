Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750908AbeELLWC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 May 2018 07:22:02 -0400
Date: Sat, 12 May 2018 12:21:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        drew.paterson@ams.com
Subject: Re: [PATCH v3 6/9] staging: iio: tsl2x7x: correct
 IIO_EV_INFO_PERIOD values
Message-ID: <20180512122155.5836865e@archlinux>
In-Reply-To: <20180511001223.12378-7-masneyb@onstation.org>
References: <20180511001223.12378-1-masneyb@onstation.org>
        <20180511001223.12378-7-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 10 May 2018 20:12:20 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The thresh periods assumed an integration time of 3ms. This patch adds
> support for the correct integration time (2.72ms or 2.73ms). The code
> had the ALS filter values as going up to 15, however the values actually
> went up to 60 since the values scaled in increments of 5 once the
> persistence value went above 3.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 44 +++++++++++++++++++++----------------
>  drivers/staging/iio/light/tsl2x7x.h |  1 -
>  2 files changed, 25 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 2d713d3c7c7b..0218eabcd6d7 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -103,8 +103,6 @@
>  #define TSL2X7X_CNTL_PROXPON_ENBL	0x0F
>  #define TSL2X7X_CNTL_INTPROXPON_ENBL	0x2F
>  
> -#define TSL2X7X_MIN_ITIME		3
> -
>  /* TAOS txx2x7x Device family members */
>  enum {
>  	tsl2571,
> @@ -984,7 +982,7 @@ static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,
>  				     int val, int val2)
>  {
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> -	int ret = -EINVAL, y, z, filter_delay;
> +	int ret = -EINVAL, count, persistence;
>  	u8 time;
>  
>  	switch (info) {
> @@ -1023,15 +1021,20 @@ static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,
>  		else
>  			time = chip->settings.prox_time;
>  
> -		y = (TSL2X7X_MAX_TIMER_CNT - time) + 1;
> -		z = y * TSL2X7X_MIN_ITIME;
> +		count = 256 - time;
> +		persistence = ((val * 1000000) + val2) /
> +			(count * tsl2x7x_int_time_avail[chip->id][3]);
>  
> -		filter_delay = DIV_ROUND_UP((val * 1000) + val2, z);
> +		if (chan->type == IIO_INTENSITY) {
> +			/* ALS filter values are 1, 2, 3, 5, 10, 15, ..., 60 */
> +			if (persistence > 3)
> +				persistence = (persistence / 5) + 3;
> +
> +			chip->settings.als_persistence = persistence;
> +		} else {
> +			chip->settings.prox_persistence = persistence;
> +		}
>  
> -		if (chan->type == IIO_INTENSITY)
> -			chip->settings.als_persistence = filter_delay;
> -		else
> -			chip->settings.prox_persistence = filter_delay;
>  		ret = 0;
>  		break;
>  	default:
> @@ -1052,7 +1055,7 @@ static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
>  				    int *val, int *val2)
>  {
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> -	int filter_delay, mult;
> +	int filter_delay, persistence;
>  	u8 time;
>  
>  	switch (info) {
> @@ -1084,18 +1087,21 @@ static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
>  	case IIO_EV_INFO_PERIOD:
>  		if (chan->type == IIO_INTENSITY) {
>  			time = chip->settings.als_time;
> -			mult = chip->settings.als_persistence;
> +			persistence = chip->settings.als_persistence;
> +
> +			/* ALS filter values are 1, 2, 3, 5, 10, 15, ..., 60 */
> +			if (persistence > 3)
> +				persistence = (persistence - 3) * 5;
>  		} else {
>  			time = chip->settings.prox_time;
> -			mult = chip->settings.prox_persistence;
> +			persistence = chip->settings.prox_persistence;
>  		}
>  
> -		/* Determine integration time */
> -		*val = (TSL2X7X_MAX_TIMER_CNT - time) + 1;
> -		*val2 = *val * TSL2X7X_MIN_ITIME;
> -		filter_delay = *val2 * mult;
> -		*val = filter_delay / 1000;
> -		*val2 = filter_delay % 1000;
> +		filter_delay = persistence * (256 - time) *
> +			tsl2x7x_int_time_avail[chip->id][3];
> +
> +		*val = filter_delay / 1000000;
> +		*val2 = filter_delay % 1000000;
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	default:
>  		return -EINVAL;
> diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
> index db344796fc1b..b86f6b260f9f 100644
> --- a/drivers/staging/iio/light/tsl2x7x.h
> +++ b/drivers/staging/iio/light/tsl2x7x.h
> @@ -31,7 +31,6 @@ struct tsl2x7x_lux {
>  #define TSL2X7X_50_mA                   0x01
>  #define TSL2X7X_25_mA                   0x02
>  #define TSL2X7X_13_mA                   0x03
> -#define TSL2X7X_MAX_TIMER_CNT           0xFF
>  
>  /**
>   * struct tsl2x7x_settings - Settings for the tsl2x7x driver

