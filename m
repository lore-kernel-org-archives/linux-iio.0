Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56221 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbbLLPKY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Dec 2015 10:10:24 -0500
Subject: Re: [PATCH 3/3] iio: light: us5182d: Refactor read_raw function
To: Adriana Reus <adriana.reus@intel.com>
References: <1449661244-18692-1-git-send-email-adriana.reus@intel.com>
 <1449661244-18692-4-git-send-email-adriana.reus@intel.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <566C38DF.7040901@kernel.org>
Date: Sat, 12 Dec 2015 15:10:23 +0000
MIME-Version: 1.0
In-Reply-To: <1449661244-18692-4-git-send-email-adriana.reus@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/12/15 11:40, Adriana Reus wrote:
> A bit of refactoring for better readability.
> Moved and slightly reorganized all the activity necessary for reading als and
> proximity into a different function. This way the switch in read raw becomes
> clearer and more compact.
> 
> Signed-off-by: Adriana Reus <adriana.reus@intel.com>
Sensible tidy up.  Will take once the others are sorted.
> ---
>  drivers/iio/light/us5182d.c | 155 ++++++++++++++++++++++----------------------
>  1 file changed, 78 insertions(+), 77 deletions(-)
> 
> diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
> index 033f5cf..53d161d 100644
> --- a/drivers/iio/light/us5182d.c
> +++ b/drivers/iio/light/us5182d.c
> @@ -203,23 +203,6 @@ static const struct iio_chan_spec us5182d_channels[] = {
>  	}
>  };
>  
> -static int us5182d_get_als(struct us5182d_data *data)
> -{
> -	int ret;
> -	unsigned long result;
> -
> -	ret = i2c_smbus_read_word_data(data->client,
> -				       US5182D_REG_ADL);
> -	if (ret < 0)
> -		return ret;
> -
> -	result = ret * data->ga / US5182D_GA_RESOLUTION;
> -	if (result > 0xffff)
> -		result = 0xffff;
> -
> -	return result;
> -}
> -
>  static int us5182d_oneshot_en(struct us5182d_data *data)
>  {
>  	int ret;
> @@ -324,6 +307,39 @@ static int us5182d_px_enable(struct us5182d_data *data)
>  	return 0;
>  }
>  
> +static int us5182d_get_als(struct us5182d_data *data)
> +{
> +	int ret;
> +	unsigned long result;
> +
> +	ret = us5182d_als_enable(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_smbus_read_word_data(data->client,
> +				       US5182D_REG_ADL);
> +	if (ret < 0)
> +		return ret;
> +
> +	result = ret * data->ga / US5182D_GA_RESOLUTION;
> +	if (result > 0xffff)
> +		result = 0xffff;
> +
> +	return result;
> +}
> +
> +static int us5182d_get_px(struct us5182d_data *data)
> +{
> +	int ret;
> +
> +	ret = us5182d_px_enable(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	return i2c_smbus_read_word_data(data->client,
> +					US5182D_REG_PDL);
> +}
> +
>  static int us5182d_shutdown_en(struct us5182d_data *data, u8 state)
>  {
>  	int ret;
> @@ -370,6 +386,46 @@ static int us5182d_set_power_state(struct us5182d_data *data, bool on)
>  	return ret;
>  }
>  
> +static int us5182d_read_value(struct us5182d_data *data,
> +			      struct iio_chan_spec const *chan)
> +{
> +	int ret, value;
> +
> +	mutex_lock(&data->lock);
> +
> +	if (data->power_mode == US5182D_ONESHOT) {
> +		ret = us5182d_oneshot_en(data);
> +		if (ret < 0)
> +			goto out_err;
> +	}
> +
> +	ret = us5182d_set_power_state(data, true);
> +	if (ret < 0)
> +		goto out_err;
> +
> +	if (chan->type == IIO_LIGHT)
> +		ret = us5182d_get_als(data);
> +	else
> +		ret = us5182d_get_px(data);
> +	if (ret < 0)
> +		goto out_poweroff;
> +
> +	value = ret;
> +
> +	ret = us5182d_set_power_state(data, false);
> +	if (ret < 0)
> +		goto out_err;
> +
> +	mutex_unlock(&data->lock);
> +	return value;
> +
> +out_poweroff:
> +	us5182d_set_power_state(data, false);
> +out_err:
> +	mutex_unlock(&data->lock);
> +	return ret;
> +}
> +
>  static int us5182d_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan, int *val,
>  			    int *val2, long mask)
> @@ -379,76 +435,21 @@ static int us5182d_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		switch (chan->type) {
> -		case IIO_LIGHT:
> -			mutex_lock(&data->lock);
> -			if (data->power_mode == US5182D_ONESHOT) {
> -				ret = us5182d_oneshot_en(data);
> -				if (ret < 0)
> -					goto out_err;
> -			}
> -			ret = us5182d_set_power_state(data, true);
> -			if (ret < 0)
> -				goto out_err;
> -			ret = us5182d_als_enable(data);
> -			if (ret < 0)
> -				goto out_poweroff;
> -			ret = us5182d_get_als(data);
> -			if (ret < 0)
> -				goto out_poweroff;
> -			*val = ret;
> -			ret = us5182d_set_power_state(data, false);
> -			if (ret < 0)
> -				goto out_err;
> -			mutex_unlock(&data->lock);
> -			return IIO_VAL_INT;
> -		case IIO_PROXIMITY:
> -			mutex_lock(&data->lock);
> -			if (data->power_mode == US5182D_ONESHOT) {
> -				ret = us5182d_oneshot_en(data);
> -				if (ret < 0)
> -					goto out_err;
> -			}
> -			ret = us5182d_set_power_state(data, true);
> -			if (ret < 0)
> -				goto out_err;
> -			ret = us5182d_px_enable(data);
> -			if (ret < 0)
> -				goto out_poweroff;
> -			ret = i2c_smbus_read_word_data(data->client,
> -						       US5182D_REG_PDL);
> -			if (ret < 0)
> -				goto out_poweroff;
> -			*val = ret;
> -			ret = us5182d_set_power_state(data, false);
> -			if (ret < 0)
> -				goto out_err;
> -			mutex_unlock(&data->lock);
> -			return IIO_VAL_INT;
> -		default:
> -			return -EINVAL;
> -		}
> -
> +		ret = us5182d_read_value(data, chan);
> +		if (ret < 0)
> +			return ret;
> +		*val = ret;
> +		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		ret = i2c_smbus_read_byte_data(data->client, US5182D_REG_CFG1);
>  		if (ret < 0)
>  			return ret;
> -
>  		*val = 0;
>  		*val2 = us5182d_scales[ret & US5182D_AGAIN_MASK];
> -
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	default:
>  		return -EINVAL;
>  	}
> -
> -	return -EINVAL;
> -
> -out_poweroff:
> -	us5182d_set_power_state(data, false);
> -out_err:
> -	mutex_unlock(&data->lock);
> -	return ret;
>  }
>  
>  /**
> 

