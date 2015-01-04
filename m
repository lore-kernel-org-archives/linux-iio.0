Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49763 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586AbbADQVH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Jan 2015 11:21:07 -0500
Message-ID: <54A96870.1000206@kernel.org>
Date: Sun, 04 Jan 2015 16:21:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Octavian Purdila <octavian.purdila@intel.com>,
	linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Laurentiu Palcu <laurentiu.palcu@intel.com>
Subject: Re: [PATCH v2 05/11] iio: bmc150: refactor slope duration and threshold
 update
References: <1419122556-8100-1-git-send-email-octavian.purdila@intel.com> <1419122556-8100-6-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1419122556-8100-6-git-send-email-octavian.purdila@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/12/14 00:42, Octavian Purdila wrote:
> Move the slope duration and threshold update in separate functions
> to reduce code duplicate between chip init and motion interrupt setup.
> 
> The patch also moves the update from the motion interrupt setup
> function to the write event function so that we can later refactor the
> interrupt code.
The side effect of this is that these will get updated at a different
point in time from before.  Previously these values would only get
updated when the event was enabled (or the trigger).  So to change
them a disable / enable cycle was needed. Now they happen the moment
they are relevant.

I prefer the new option, but it is an ABI change (be it one most people
won't notice!)

Hence I'd like an Ack from Srinivas and time for comments from others
before taking this one.

Otherwise, looks good ;)

Jonathan
> 
> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> ---
>  drivers/iio/accel/bmc150-accel.c | 110 ++++++++++++++++++++++-----------------
>  1 file changed, 63 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
> index 22c096c..92f1d2b 100644
> --- a/drivers/iio/accel/bmc150-accel.c
> +++ b/drivers/iio/accel/bmc150-accel.c
> @@ -266,6 +266,52 @@ static int bmc150_accel_set_bw(struct bmc150_accel_data *data, int val,
>  	return -EINVAL;
>  }
>  
> +static int bmc150_accel_update_slope_threshold(struct bmc150_accel_data *data,
> +					       int val)
> +{
> +	int ret = 0;
> +
> +	val &= 0xFF;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, BMC150_ACCEL_REG_INT_6,
> +					val);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing reg_int_6\n");
> +		return ret;
> +	}
> +	data->slope_thres = val;
> +
> +	dev_dbg(&data->client->dev, "%s: %x\n", __func__, val);
> +
> +	return ret;
> +}
> +
> +static int bmc150_accel_update_slope_duration(struct bmc150_accel_data *data,
> +					      int val)
> +{
> +	int ret;
> +
> +	val &= BMC150_ACCEL_SLOPE_DUR_MASK;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, BMC150_ACCEL_REG_INT_5);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading reg_int_5\n");
> +		return ret;
> +	}
> +	val |= ret & ~BMC150_ACCEL_SLOPE_DUR_MASK;
> +	ret = i2c_smbus_write_byte_data(data->client, BMC150_ACCEL_REG_INT_5,
> +					val);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error write reg_int_5\n");
> +		return ret;
> +	}
> +	data->slope_dur = val;
> +
> +	dev_dbg(&data->client->dev, "%s: %x\n", __func__, val);
> +
> +	return ret;
> +}
> +
>  static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
>  {
>  	int ret;
> @@ -304,32 +350,16 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
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
> +	/* Set default slope duration and thresholds */
> +	ret = bmc150_accel_update_slope_duration(data,
> +					 BMC150_ACCEL_DEF_SLOPE_DURATION);
> +	if (ret < 0)
>  		return ret;
> -	}
> -	dev_dbg(&data->client->dev, "slope_dur %x\n", data->slope_dur);
>  
> -	/* Set default slope thresholds */
> -	ret = i2c_smbus_write_byte_data(data->client,
> -					BMC150_ACCEL_REG_INT_6,
> -					BMC150_ACCEL_DEF_SLOPE_THRESHOLD);
> -	if (ret < 0) {
> -		dev_err(&data->client->dev, "Error writing reg_int_6\n");
> +	ret = bmc150_accel_update_slope_threshold(data,
> +					  BMC150_ACCEL_DEF_SLOPE_THRESHOLD);
> +	if (ret < 0)
>  		return ret;
> -	}
> -	data->slope_thres = BMC150_ACCEL_DEF_SLOPE_THRESHOLD;
> -	dev_dbg(&data->client->dev, "slope_thres %x\n", data->slope_thres);
>  
>  	/* Set default as latched interrupts */
>  	ret = i2c_smbus_write_byte_data(data->client,
> @@ -372,24 +402,6 @@ static int bmc150_accel_setup_any_motion_interrupt(
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
> @@ -726,7 +738,7 @@ static int bmc150_accel_read_event(struct iio_dev *indio_dev,
>  		*val = data->slope_thres;
>  		break;
>  	case IIO_EV_INFO_PERIOD:
> -		*val = data->slope_dur & BMC150_ACCEL_SLOPE_DUR_MASK;
> +		*val = data->slope_dur;
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -743,23 +755,27 @@ static int bmc150_accel_write_event(struct iio_dev *indio_dev,
>  				    int val, int val2)
>  {
>  	struct bmc150_accel_data *data = iio_priv(indio_dev);
> +	int ret;
>  
>  	if (data->ev_enable_state)
>  		return -EBUSY;
>  
>  	switch (info) {
>  	case IIO_EV_INFO_VALUE:
> -		data->slope_thres = val;
> +		mutex_lock(&data->mutex);
> +		ret = bmc150_accel_update_slope_threshold(data, val);
> +		mutex_unlock(&data->mutex);
>  		break;
>  	case IIO_EV_INFO_PERIOD:
> -		data->slope_dur &= ~BMC150_ACCEL_SLOPE_DUR_MASK;
> -		data->slope_dur |= val & BMC150_ACCEL_SLOPE_DUR_MASK;
> +		mutex_lock(&data->mutex);
> +		ret = bmc150_accel_update_slope_duration(data, val);
> +		mutex_unlock(&data->mutex);
>  		break;
>  	default:
> -		return -EINVAL;
> +		ret = -EINVAL;
>  	}
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int bmc150_accel_read_event_config(struct iio_dev *indio_dev,
> 

