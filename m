Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48732 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754311AbcJOPMX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Oct 2016 11:12:23 -0400
Subject: Re: [PATCH] iio: light: ltr501: claim direct mode during raw writes
To: Alison Schofield <amsfield22@gmail.com>
References: <20161011195714.GA9549@d830.WORKGROUP>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <527113a8-fa49-5b22-37d7-af580d7b4ca8@kernel.org>
Date: Sat, 15 Oct 2016 16:12:20 +0100
MIME-Version: 1.0
In-Reply-To: <20161011195714.GA9549@d830.WORKGROUP>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/10/16 20:57, Alison Schofield wrote:
> Driver was checking for direct mode but not locking it.  Use
> claim/release helper functions to guarantee the device stays
> in direct mode during all raw write operations.
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Again, use of break to get out of the case code blocks, will
be more elegant than a goto which drops down several levels.

Otherwise, looks fine.
> ---
>  drivers/iio/light/ltr501.c | 71 +++++++++++++++++++++++++++-------------------
>  1 file changed, 42 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index 3afc53a..0f1032d 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -729,8 +729,9 @@ static int ltr501_write_raw(struct iio_dev *indio_dev,
>  	int i, ret, freq_val, freq_val2;
>  	struct ltr501_chip_info *info = data->chip_info;
>  
> -	if (iio_buffer_enabled(indio_dev))
> -		return -EBUSY;
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
> @@ -739,39 +740,50 @@ static int ltr501_write_raw(struct iio_dev *indio_dev,
>  			i = ltr501_get_gain_index(info->als_gain,
>  						  info->als_gain_tbl_size,
>  						  val, val2);
> -			if (i < 0)
> -				return -EINVAL;
> +			if (i < 0) {
> +				ret = -EINVAL;
> +				goto release;
> +			}
>  
>  			data->als_contr &= ~info->als_gain_mask;
>  			data->als_contr |= i << info->als_gain_shift;
>  
> -			return regmap_write(data->regmap, LTR501_ALS_CONTR,
> -					    data->als_contr);
> +			ret = regmap_write(data->regmap, LTR501_ALS_CONTR,
> +					   data->als_contr);
> +			goto release;
>  		case IIO_PROXIMITY:
>  			i = ltr501_get_gain_index(info->ps_gain,
>  						  info->ps_gain_tbl_size,
>  						  val, val2);
> -			if (i < 0)
> -				return -EINVAL;
> +			if (i < 0) {
> +				ret = -EINVAL;
> +				goto release;
> +			}
>  			data->ps_contr &= ~LTR501_CONTR_PS_GAIN_MASK;
>  			data->ps_contr |= i << LTR501_CONTR_PS_GAIN_SHIFT;
>  
> -			return regmap_write(data->regmap, LTR501_PS_CONTR,
> -					    data->ps_contr);
> +			ret = regmap_write(data->regmap, LTR501_PS_CONTR,
> +					   data->ps_contr);
> +			goto release;
>  		default:
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			goto release;
>  		}
>  	case IIO_CHAN_INFO_INT_TIME:
>  		switch (chan->type) {
>  		case IIO_INTENSITY:
> -			if (val != 0)
> -				return -EINVAL;
> +			if (val != 0) {
> +				ret = -EINVAL;
> +				goto release;
> +			}
>  			mutex_lock(&data->lock_als);
>  			i = ltr501_set_it_time(data, val2);
>  			mutex_unlock(&data->lock_als);
> -			return i;
> +			ret = i;
> +			goto release;
>  		default:
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			goto release;
>  		}
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		switch (chan->type) {
> @@ -779,45 +791,46 @@ static int ltr501_write_raw(struct iio_dev *indio_dev,
>  			ret = ltr501_als_read_samp_freq(data, &freq_val,
>  							&freq_val2);
>  			if (ret < 0)
> -				return ret;
> +				goto release;
>  
>  			ret = ltr501_als_write_samp_freq(data, val, val2);
>  			if (ret < 0)
> -				return ret;
> +				goto release;
>  
>  			/* update persistence count when changing frequency */
>  			ret = ltr501_write_intr_prst(data, chan->type,
>  						     0, data->als_period);
>  
>  			if (ret < 0)
> -				return ltr501_als_write_samp_freq(data,
> -								  freq_val,
> -								  freq_val2);
> -			return ret;
> +				ret = ltr501_als_write_samp_freq(data, freq_val,
> +								 freq_val2);
> +			goto release;
>  		case IIO_PROXIMITY:
>  			ret = ltr501_ps_read_samp_freq(data, &freq_val,
>  						       &freq_val2);
>  			if (ret < 0)
> -				return ret;
> +				goto release;
>  
>  			ret = ltr501_ps_write_samp_freq(data, val, val2);
>  			if (ret < 0)
> -				return ret;
> +				goto release;
>  
>  			/* update persistence count when changing frequency */
>  			ret = ltr501_write_intr_prst(data, chan->type,
>  						     0, data->ps_period);
>  
>  			if (ret < 0)
> -				return ltr501_ps_write_samp_freq(data,
> -								 freq_val,
> -								 freq_val2);
> -			return ret;
> +				ret = ltr501_ps_write_samp_freq(data, freq_val,
> +								freq_val2);
> +			goto release;
>  		default:
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			goto release;
>  		}
>  	}
> -	return -EINVAL;
> +release:
> +	iio_device_release_direct_mode(indio_dev);
> +	return ret;
>  }
>  
>  static int ltr501_read_thresh(struct iio_dev *indio_dev,
> 

