Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:19071 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754369AbbBERDk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 5 Feb 2015 12:03:40 -0500
Message-ID: <1423155753.2136.164.camel@spandruv-DESK3.jf.intel.com>
Subject: Re: [PATCH v3 4/9] iio: bmc150: refactor slope duration and
 threshold update
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: linux-iio@vger.kernel.org
Date: Thu, 05 Feb 2015 09:02:33 -0800
In-Reply-To: <1422662408-8149-5-git-send-email-octavian.purdila@intel.com>
References: <1422662408-8149-1-git-send-email-octavian.purdila@intel.com>
	 <1422662408-8149-5-git-send-email-octavian.purdila@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 2015-01-31 at 02:00 +0200, Octavian Purdila wrote: 
> Move the slope duration and threshold update in a separate function to
> reduce code duplicate between chip init and motion interrupt setup.
> 
> Also move the slope update code from the interrupt setup function to
> the trigger set state function so that we can later refactor the
> interrupt code.
> 
> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> 
> ---
>  drivers/iio/accel/bmc150-accel.c | 97 +++++++++++++++++++---------------------
>  1 file changed, 47 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
> index 066d0c0..2b6b80d 100644
> --- a/drivers/iio/accel/bmc150-accel.c
> +++ b/drivers/iio/accel/bmc150-accel.c
> @@ -269,6 +269,37 @@ static int bmc150_accel_set_bw(struct bmc150_accel_data *data, int val,
>  	return -EINVAL;
>  }
>  
> +static int bmc150_accel_update_slope(struct bmc150_accel_data *data)
> +{
> +	int ret, val;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, BMC150_ACCEL_REG_INT_6,
> +					data->slope_thres);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing reg_int_6\n");
> +		return ret;
> +	}
> +
> +	ret = i2c_smbus_read_byte_data(data->client, BMC150_ACCEL_REG_INT_5);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading reg_int_5\n");
> +		return ret;
> +	}
> +
> +	val = (ret & ~BMC150_ACCEL_SLOPE_DUR_MASK) | data->slope_dur;
> +	ret = i2c_smbus_write_byte_data(data->client, BMC150_ACCEL_REG_INT_5,
> +					val);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error write reg_int_5\n");
> +		return ret;
> +	}
> +
> +	dev_dbg(&data->client->dev, "%s: %x %x\n", __func__, data->slope_thres,
> +		data->slope_dur);
> +
> +	return ret;
> +}
> +
>  static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
>  {
>  	int ret;
> @@ -307,32 +338,12 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
>  
>  	data->range = BMC150_ACCEL_DEF_RANGE_4G;
>  
> -	/* Set default slope duration */
> -	ret = i2c_smbus_read_byte_data(data->client, BMC150_ACCEL_REG_INT_5);
> -	if (ret < 0) {
> -		dev_err(&data->client->dev, "Error reading reg_int_5\n");
> -		return ret;
> -	}
> -	data->slope_dur |= BMC150_ACCEL_DEF_SLOPE_DURATION;
> -	ret = i2c_smbus_write_byte_data(data->client,
> -					BMC150_ACCEL_REG_INT_5,
> -					data->slope_dur);
> -	if (ret < 0) {
> -		dev_err(&data->client->dev, "Error writing reg_int_5\n");
> -		return ret;
> -	}
> -	dev_dbg(&data->client->dev, "slope_dur %x\n", data->slope_dur);
> -
> -	/* Set default slope thresholds */
> -	ret = i2c_smbus_write_byte_data(data->client,
> -					BMC150_ACCEL_REG_INT_6,
> -					BMC150_ACCEL_DEF_SLOPE_THRESHOLD);
> -	if (ret < 0) {
> -		dev_err(&data->client->dev, "Error writing reg_int_6\n");
> -		return ret;
> -	}
> +	/* Set default slope duration and thresholds */
>  	data->slope_thres = BMC150_ACCEL_DEF_SLOPE_THRESHOLD;
> -	dev_dbg(&data->client->dev, "slope_thres %x\n", data->slope_thres);
> +	data->slope_dur = BMC150_ACCEL_DEF_SLOPE_DURATION;
> +	ret = bmc150_accel_update_slope(data);
> +	if (ret < 0)
> +		return ret;
>  
>  	/* Set default as latched interrupts */
>  	ret = i2c_smbus_write_byte_data(data->client,
> @@ -375,24 +386,6 @@ static int bmc150_accel_setup_any_motion_interrupt(
>  	}
>  
>  	if (status) {
> -		/* Set slope duration (no of samples) */
> -		ret = i2c_smbus_write_byte_data(data->client,
> -						BMC150_ACCEL_REG_INT_5,
> -						data->slope_dur);
> -		if (ret < 0) {
> -			dev_err(&data->client->dev, "Error write reg_int_5\n");
> -			return ret;
> -		}
> -
> -		/* Set slope thresholds */
> -		ret = i2c_smbus_write_byte_data(data->client,
> -						BMC150_ACCEL_REG_INT_6,
> -						data->slope_thres);
> -		if (ret < 0) {
> -			dev_err(&data->client->dev, "Error write reg_int_6\n");
> -			return ret;
> -		}
> -
>  		/*
>  		 * New data interrupt is always non-latched,
>  		 * which will have higher priority, so no need
> @@ -732,7 +725,7 @@ static int bmc150_accel_read_event(struct iio_dev *indio_dev,
>  		*val = data->slope_thres;
>  		break;
>  	case IIO_EV_INFO_PERIOD:
> -		*val = data->slope_dur & BMC150_ACCEL_SLOPE_DUR_MASK;
> +		*val = data->slope_dur;
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -755,11 +748,10 @@ static int bmc150_accel_write_event(struct iio_dev *indio_dev,
>  
>  	switch (info) {
>  	case IIO_EV_INFO_VALUE:
> -		data->slope_thres = val;
> +		data->slope_thres = val & 0xFF;
>  		break;
>  	case IIO_EV_INFO_PERIOD:
> -		data->slope_dur &= ~BMC150_ACCEL_SLOPE_DUR_MASK;
> -		data->slope_dur |= val & BMC150_ACCEL_SLOPE_DUR_MASK;
> +		data->slope_dur = val & BMC150_ACCEL_SLOPE_DUR_MASK;
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -1056,10 +1048,15 @@ static int bmc150_accel_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  		mutex_unlock(&data->mutex);
>  		return ret;
>  	}
> -	if (data->motion_trig == trig)
> -		ret =  bmc150_accel_setup_any_motion_interrupt(data, state);
> -	else
> +
> +	if (data->motion_trig == trig) {
> +		ret = bmc150_accel_update_slope(data);
> +		if (!ret)
> +			ret = bmc150_accel_setup_any_motion_interrupt(data,
> +								      state);
> +	} else {
>  		ret = bmc150_accel_setup_new_data_interrupt(data, state);
> +	}
>  	if (ret < 0) {
>  		bmc150_accel_set_power_state(data, false);
>  		mutex_unlock(&data->mutex);


