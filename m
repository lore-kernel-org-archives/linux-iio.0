Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33580 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409AbbDRTfd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 18 Apr 2015 15:35:33 -0400
Message-ID: <5532B203.1020800@kernel.org>
Date: Sat, 18 Apr 2015 20:35:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:tsl2563: Use tsl2563_ prefix for driver's functions
References: <1429130378-19941-1-git-send-email-pmeerw@pmeerw.net> <1429130378-19941-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1429130378-19941-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/04/15 21:39, Peter Meerwald wrote:
> just cleanup, no functional change
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied with the small issue you left in to check I was awake fixed.

There are to more calib_to_sys calls that you didn't update.


> ---
>  drivers/iio/light/tsl2563.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
> index 94daa9f..8166944 100644
> --- a/drivers/iio/light/tsl2563.c
> +++ b/drivers/iio/light/tsl2563.c
> @@ -240,7 +240,7 @@ static int tsl2563_read_id(struct tsl2563_chip *chip, u8 *id)
>   * convert between normalized values and HW values obtained using given
>   * timing and gain settings.
>   */
> -static int adc_shiftbits(u8 timing)
> +static int tsl2563_adc_shiftbits(u8 timing)
>  {
>  	int shift = 0;
>  
> @@ -263,9 +263,9 @@ static int adc_shiftbits(u8 timing)
>  }
>  
>  /* Convert a HW ADC value to normalized scale. */
> -static u32 normalize_adc(u16 adc, u8 timing)
> +static u32 tsl2563_normalize_adc(u16 adc, u8 timing)
>  {
> -	return adc << adc_shiftbits(timing);
> +	return adc << tsl2563_adc_shiftbits(timing);
>  }
>  
>  static void tsl2563_wait_adc(struct tsl2563_chip *chip)
> @@ -350,8 +350,8 @@ static int tsl2563_get_adc(struct tsl2563_chip *chip)
>  		retry = tsl2563_adjust_gainlevel(chip, adc0);
>  	}
>  
> -	chip->data0 = normalize_adc(adc0, chip->gainlevel->gaintime);
> -	chip->data1 = normalize_adc(adc1, chip->gainlevel->gaintime);
> +	chip->data0 = tsl2563_normalize_adc(adc0, chip->gainlevel->gaintime);
> +	chip->data1 = tsl2563_normalize_adc(adc1, chip->gainlevel->gaintime);
>  
>  	if (!chip->int_enabled)
>  		schedule_delayed_work(&chip->poweroff_work, 5 * HZ);
> @@ -361,13 +361,13 @@ out:
>  	return ret;
>  }
>  
> -static inline int calib_to_sysfs(u32 calib)
> +static inline int tsl2563_calib_to_sysfs(u32 calib)
>  {
>  	return (int) (((calib * CALIB_BASE_SYSFS) +
>  		       CALIB_FRAC_HALF) >> CALIB_FRAC_BITS);
>  }
>  
> -static inline u32 calib_from_sysfs(int value)
> +static inline u32 tsl2563_calib_from_sysfs(int value)
>  {
>  	return (((u32) value) << CALIB_FRAC_BITS) / CALIB_BASE_SYSFS;
>  }
> @@ -426,7 +426,7 @@ static const struct tsl2563_lux_coeff lux_table[] = {
>  };
>  
>  /* Convert normalized, scaled ADC values to lux. */
> -static unsigned int adc_to_lux(u32 adc0, u32 adc1)
> +static unsigned int tsl2563_adc_to_lux(u32 adc0, u32 adc1)
>  {
>  	const struct tsl2563_lux_coeff *lp = lux_table;
>  	unsigned long ratio, lux, ch0 = adc0, ch1 = adc1;
> @@ -442,7 +442,7 @@ static unsigned int adc_to_lux(u32 adc0, u32 adc1)
>  }
>  
>  /* Apply calibration coefficient to ADC count. */
> -static u32 calib_adc(u32 adc, u32 calib)
> +static u32 tsl2563_calib_adc(u32 adc, u32 calib)
>  {
>  	unsigned long scaled = adc;
>  
> @@ -463,9 +463,9 @@ static int tsl2563_write_raw(struct iio_dev *indio_dev,
>  	if (mask != IIO_CHAN_INFO_CALIBSCALE)
>  		return -EINVAL;
>  	if (chan->channel2 == IIO_MOD_LIGHT_BOTH)
> -		chip->calib0 = calib_from_sysfs(val);
> +		chip->calib0 = tsl2563_calib_from_sysfs(val);
>  	else if (chan->channel2 == IIO_MOD_LIGHT_IR)
> -		chip->calib1 = calib_from_sysfs(val);
> +		chip->calib1 = tsl2563_calib_from_sysfs(val);
>  	else
>  		return -EINVAL;
>  
> @@ -491,11 +491,11 @@ static int tsl2563_read_raw(struct iio_dev *indio_dev,
>  			ret = tsl2563_get_adc(chip);
>  			if (ret)
>  				goto error_ret;
> -			calib0 = calib_adc(chip->data0, chip->calib0) *
> +			calib0 = tsl2563_calib_adc(chip->data0, chip->calib0) *
>  				chip->cover_comp_gain;
> -			calib1 = calib_adc(chip->data1, chip->calib1) *
> +			calib1 = tsl2563_calib_adc(chip->data1, chip->calib1) *
>  				chip->cover_comp_gain;
> -			*val = adc_to_lux(calib0, calib1);
> +			*val = tsl2563_adc_to_lux(calib0, calib1);
>  			ret = IIO_VAL_INT;
>  			break;
>  		case IIO_INTENSITY:
> @@ -515,9 +515,9 @@ static int tsl2563_read_raw(struct iio_dev *indio_dev,
>  
>  	case IIO_CHAN_INFO_CALIBSCALE:
>  		if (chan->channel2 == IIO_MOD_LIGHT_BOTH)
> -			*val = calib_to_sysfs(chip->calib0);
> +			*val = tsl2563_calib_to_sysfs(chip->calib0);
>  		else
> -			*val = calib_to_sysfs(chip->calib1);
> +			*val = tsl2563_calib_to_sysfs(chip->calib1);
>  		ret = IIO_VAL_INT;
>  		break;
>  	default:
> 

