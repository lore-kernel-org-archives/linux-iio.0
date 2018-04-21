Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753162AbeDUQeA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Apr 2018 12:34:00 -0400
Date: Sat, 21 Apr 2018 17:33:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 10/13] staging: iio: tsl2x7x: rename prx to prox for
 consistency
Message-ID: <20180421173354.6a8ae0c1@archlinux>
In-Reply-To: <20180421004153.19073-11-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
        <20180421004153.19073-11-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 20 Apr 2018 20:41:50 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The driver mostly uses the 'prox' naming convention for most of the
> proximity settings, however prx_time and tsl2x7x_prx_gain was present.
> This patch renames these to prox_time and tsl2x7x_prox_gain for
> consistency with everything else in the driver.
> 
> The kernel documentation for prx_gain is corrected to prox_gain so that
> it matches what is actually in the structure.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied,

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 12 ++++++------
>  drivers/staging/iio/light/tsl2x7x.h |  6 +++---
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 87b99deef7a8..a7b4fcba7935 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -203,7 +203,7 @@ static const struct tsl2x7x_lux *tsl2x7x_default_lux_table_group[] = {
>  static const struct tsl2x7x_settings tsl2x7x_default_settings = {
>  	.als_time = 219, /* 101 ms */
>  	.als_gain = 0,
> -	.prx_time = 254, /* 5.4 ms */
> +	.prox_time = 254, /* 5.4 ms */
>  	.prox_gain = 0,
>  	.wait_time = 245,
>  	.prox_config = 0,
> @@ -230,7 +230,7 @@ static const s16 tsl2x7x_als_gain[] = {
>  	120
>  };
>  
> -static const s16 tsl2x7x_prx_gain[] = {
> +static const s16 tsl2x7x_prox_gain[] = {
>  	1,
>  	2,
>  	4,
> @@ -594,7 +594,7 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  	u8 *dev_reg, reg_val;
>  
>  	/* Non calculated parameters */
> -	chip->tsl2x7x_config[TSL2X7X_PRX_TIME] = chip->settings.prx_time;
> +	chip->tsl2x7x_config[TSL2X7X_PRX_TIME] = chip->settings.prox_time;
>  	chip->tsl2x7x_config[TSL2X7X_WAIT_TIME] = chip->settings.wait_time;
>  	chip->tsl2x7x_config[TSL2X7X_PRX_CONFIG] = chip->settings.prox_config;
>  
> @@ -1021,7 +1021,7 @@ static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,
>  		if (chan->type == IIO_INTENSITY)
>  			time = chip->settings.als_time;
>  		else
> -			time = chip->settings.prx_time;
> +			time = chip->settings.prox_time;
>  
>  		y = (TSL2X7X_MAX_TIMER_CNT - time) + 1;
>  		z = y * TSL2X7X_MIN_ITIME;
> @@ -1090,7 +1090,7 @@ static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
>  			time = chip->settings.als_time;
>  			mult = chip->settings.als_persistence;
>  		} else {
> -			time = chip->settings.prx_time;
> +			time = chip->settings.prox_time;
>  			mult = chip->settings.prox_persistence;
>  		}
>  
> @@ -1153,7 +1153,7 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
>  		if (chan->type == IIO_LIGHT)
>  			*val = tsl2x7x_als_gain[chip->settings.als_gain];
>  		else
> -			*val = tsl2x7x_prx_gain[chip->settings.prox_gain];
> +			*val = tsl2x7x_prox_gain[chip->settings.prox_gain];
>  		ret = IIO_VAL_INT;
>  		break;
>  	case IIO_CHAN_INFO_CALIBBIAS:
> diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
> index 2c96f0b39b1e..408e5a89edb1 100644
> --- a/drivers/staging/iio/light/tsl2x7x.h
> +++ b/drivers/staging/iio/light/tsl2x7x.h
> @@ -44,9 +44,9 @@ struct tsl2x7x_lux {
>   *                          aperture effects.
>   *  @wait_time:             Time between PRX and ALS cycles
>   *                          in 2.7 periods
> - *  @prx_time:              5.2ms prox integration time -
> + *  @prox_time:             5.2ms prox integration time -
>   *                          decrease in 2.7ms periods
> - *  @prx_gain:              Proximity gain index
> + *  @prox_gain:             Proximity gain index
>   *  @prox_config:           Prox configuration filters.
>   *  @als_cal_target:        Known external ALS reading for
>   *                          calibration.
> @@ -68,7 +68,7 @@ struct tsl2x7x_settings {
>  	int als_gain;
>  	int als_gain_trim;
>  	int wait_time;
> -	int prx_time;
> +	int prox_time;
>  	int prox_gain;
>  	int prox_config;
>  	int als_cal_target;

