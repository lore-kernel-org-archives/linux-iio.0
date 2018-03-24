Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751953AbeCXNkk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Mar 2018 09:40:40 -0400
Date: Sat, 24 Mar 2018 13:40:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 07/11] staging: iio: tsl2x7x: split out als and prox
 persistence settings
Message-ID: <20180324134034.7080dd6f@archlinux>
In-Reply-To: <20180321102912.5130-8-masneyb@onstation.org>
References: <20180321102912.5130-1-masneyb@onstation.org>
        <20180321102912.5130-8-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 21 Mar 2018 06:29:08 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The struct tsl2x7x_settings contained a persistence member that
> contained both the ALS and proximity persistence fields. This patch
> splits this out into two separate fields so that the bitmasks in
> several parts of the code are no longer necessary.
> 
> The default persistence settings are also changed by this patch from:
> 
> - Proximity: 0 (Every proximity cycle generates an interrupt)
> - ALS: 255 (60 consecutive values out of range)
> 
> to something a little more reasonable based on my testing:
> 
> - Proximity: 1 (1 proximity value out of range)
> - ALS: 1 (1 value outside of threshold range)
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied, thanks.

Jonathan
> ---
>  drivers/staging/iio/light/tsl2x7x.c | 24 +++++++++++-------------
>  drivers/staging/iio/light/tsl2x7x.h |  9 ++++++---
>  2 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 07ce3076a05d..c1e441857226 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -226,10 +226,11 @@ static const struct tsl2x7x_settings tsl2x7x_default_settings = {
>  	.prox_config = 0,
>  	.als_gain_trim = 1000,
>  	.als_cal_target = 150,
> +	.als_persistence = 1,
>  	.als_interrupt_en = false,
>  	.als_thresh_low = 200,
>  	.als_thresh_high = 256,
> -	.persistence = 255,
> +	.prox_persistence = 1,
>  	.prox_interrupt_en = false,
>  	.prox_thres_low  = 0,
>  	.prox_thres_high = 512,
> @@ -621,7 +622,9 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  		(chip->settings.als_thresh_high) & 0xFF;
>  	chip->tsl2x7x_config[TSL2X7X_ALS_MAXTHRESHHI] =
>  		(chip->settings.als_thresh_high >> 8) & 0xFF;
> -	chip->tsl2x7x_config[TSL2X7X_PERSISTENCE] = chip->settings.persistence;
> +	chip->tsl2x7x_config[TSL2X7X_PERSISTENCE] =
> +		(chip->settings.prox_persistence & 0xFF) << 4 |
> +		(chip->settings.als_persistence & 0xFF);
>  
>  	chip->tsl2x7x_config[TSL2X7X_PRX_COUNT] =
>  			chip->settings.prox_pulse_count;
> @@ -1043,15 +1046,10 @@ static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,
>  
>  		filter_delay = DIV_ROUND_UP((val * 1000) + val2, z);
>  
> -		if (chan->type == IIO_INTENSITY) {
> -			chip->settings.persistence &= 0xF0;
> -			chip->settings.persistence |=
> -				(filter_delay & 0x0F);
> -		} else {
> -			chip->settings.persistence &= 0x0F;
> -			chip->settings.persistence |=
> -				((filter_delay << 4) & 0xF0);
> -		}
> +		if (chan->type == IIO_INTENSITY)
> +			chip->settings.als_persistence = filter_delay;
> +		else
> +			chip->settings.prox_persistence = filter_delay;
>  		ret = 0;
>  		break;
>  	default:
> @@ -1108,10 +1106,10 @@ static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
>  	case IIO_EV_INFO_PERIOD:
>  		if (chan->type == IIO_INTENSITY) {
>  			time = chip->settings.als_time;
> -			mult = chip->settings.persistence & 0x0F;
> +			mult = chip->settings.als_persistence;
>  		} else {
>  			time = chip->settings.prx_time;
> -			mult = (chip->settings.persistence & 0xF0) >> 4;
> +			mult = chip->settings.prox_persistence;
>  		}
>  
>  		/* Determine integration time */
> diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
> index b2aa642299b3..d382cdbb976e 100644
> --- a/drivers/staging/iio/light/tsl2x7x.h
> +++ b/drivers/staging/iio/light/tsl2x7x.h
> @@ -50,11 +50,13 @@ struct tsl2x7x_lux {
>   *  @prox_config:           Prox configuration filters.
>   *  @als_cal_target:        Known external ALS reading for
>   *                          calibration.
> - *  @persistence:           H/W Filters, Number of 'out of limits'
> - *                          ADC readings PRX/ALS.
> + *  @als_persistence:       H/W Filters, Number of 'out of limits'
> + *                          ALS readings.
>   *  @als_interrupt_en:      Enable/Disable ALS interrupts
>   *  @als_thresh_low:        CH0 'low' count to trigger interrupt.
>   *  @als_thresh_high:       CH0 'high' count to trigger interrupt.
> + *  @prox_persistence:      H/W Filters, Number of 'out of limits'
> + *                          proximity readings.
>   *  @prox_interrupt_en:     Enable/Disable proximity interrupts
>   *  @prox_thres_low:        Low threshold proximity detection.
>   *  @prox_thres_high:       High threshold proximity detection
> @@ -70,10 +72,11 @@ struct tsl2x7x_settings {
>  	int prox_gain;
>  	int prox_config;
>  	int als_cal_target;
> -	u8  persistence;
> +	u8 als_persistence;
>  	bool als_interrupt_en;
>  	int als_thresh_low;
>  	int als_thresh_high;
> +	u8 prox_persistence;
>  	bool prox_interrupt_en;
>  	int prox_thres_low;
>  	int prox_thres_high;

