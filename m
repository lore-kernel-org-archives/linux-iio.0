Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:49216 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752089AbaKWV6Y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 23 Nov 2014 16:58:24 -0500
Message-ID: <54725879.6030602@gmx.de>
Date: Sun, 23 Nov 2014 22:58:17 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Octavian Purdila <octavian.purdila@intel.com>,
	linux-iio@vger.kernel.org
CC: srinivas.pandruvada@intel.com
Subject: Re: [RFC 2/8] iio: bmc150: refactor slope duration and threshold update
References: <1416246966-3083-1-git-send-email-octavian.purdila@intel.com> <1416246966-3083-3-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1416246966-3083-3-git-send-email-octavian.purdila@intel.com>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Octavian Purdila schrieb am 17.11.2014 18:56:
> Move the slope duration and threshold update in separate functions
> to reduce code duplicate between chip init and motion interrupt setup.
> 
> The patch also moves the update from the motion interrupt setup
> function to the write event function so that we can later refactor the
> interrupt code.
> 
> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> ---
>  drivers/iio/accel/bmc150-accel.c | 109 ++++++++++++++++++++++-----------------
>  1 file changed, 62 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
> index 22c096c..5bfb09d 100644
> --- a/drivers/iio/accel/bmc150-accel.c
> +++ b/drivers/iio/accel/bmc150-accel.c
> @@ -266,6 +266,51 @@ static int bmc150_accel_set_bw(struct bmc150_accel_data *data, int val,
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
> +	ret = i2c_smbus_write_byte_data(data->client, BMC150_ACCEL_REG_INT_5,
> +					val | ret);
You will have more joy if you clear the appropriate bits in ret before setting new ones.
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
> @@ -304,32 +349,16 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
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
> @@ -372,24 +401,6 @@ static int bmc150_accel_setup_any_motion_interrupt(
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
> @@ -726,7 +737,7 @@ static int bmc150_accel_read_event(struct iio_dev *indio_dev,
>  		*val = data->slope_thres;
>  		break;
>  	case IIO_EV_INFO_PERIOD:
> -		*val = data->slope_dur & BMC150_ACCEL_SLOPE_DUR_MASK;
> +		*val = data->slope_dur;
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -743,23 +754,27 @@ static int bmc150_accel_write_event(struct iio_dev *indio_dev,
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

