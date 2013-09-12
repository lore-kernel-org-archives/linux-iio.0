Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45566 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208Ab3ILUHL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 Sep 2013 16:07:11 -0400
Message-ID: <52322D09.1050901@kernel.org>
Date: Thu, 12 Sep 2013 22:07:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 09/18] staging:iio:hmc5843: Use CALIBSCALE instead of
 magn_range
References: <1378170320-27538-1-git-send-email-pmeerw@pmeerw.net> <1378170320-27538-10-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1378170320-27538-10-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/03/13 02:05, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> ---
Hi Peter,

This one has me a little confused.  To be a correct use of calibscale it should have no
effect on the calculation to convert the raw reading into Gauss.

Can you confirm this is true here?  I can't immediately work out whether that is true
from the datasheet.

>  drivers/staging/iio/magnetometer/hmc5843.c |  108 ++++++++++++----------------
>  1 file changed, 47 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
> index bff03d5..faaaafc 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -125,16 +125,19 @@ static const int hmc5883l_regval_to_nanoscale[] = {
>   * 6		| (+-)5.6				| 330
>   * 7		| (+-)8.1				| 230
>   */
> -static const int hmc5843_regval_to_input_field_mga[] = {
> -	700, 1000, 1500, 2000, 3200, 3800, 4500, 6500
> +static const int hmc5843_regval_to_range_ga[8][2] = {
> +	{0, 700000}, {1, 0}, {1, 500000}, {2, 0}, {3, 200000},
> +	{3, 800000}, {4, 500000}, {6, 500000}
>  };
>  
> -static const int hmc5883_regval_to_input_field_mga[] = {
> -	900, 1200, 1900, 2500, 4000, 4600, 5500, 7900
> +static const int hmc5883_regval_to_range_ga[8][2] = {
> +	{0, 900000}, {1, 200000}, {1, 900000}, {2, 500000}, {4, 0},
> +	{4, 600000}, {5, 500000}, {7, 900000}
>  };
>  
> -static const int hmc5883l_regval_to_input_field_mga[] = {
> -	880, 1300, 1900, 2500, 4000, 4700, 5600, 8100
> +static const int hmc5883l_regval_to_range_ga[8][2] = {
> +	{0, 880000}, {1, 300000}, {1, 900000}, {2, 500000}, {4, 0},
> +	{4, 700000}, {5, 600000}, {8, 100000}
>  };
>  
>  /*
> @@ -163,7 +166,7 @@ static const int hmc5883_regval_to_samp_freq[7][2] = {
>  struct hmc5843_chip_info {
>  	const struct iio_chan_spec *channels;
>  	const int (*regval_to_samp_freq)[2];
> -	const int *regval_to_input_field_mga;
> +	const int (*regval_to_range_ga)[2];
>  	const int *regval_to_nanoscale;
>  };
>  
> @@ -413,58 +416,25 @@ static int hmc5843_check_samp_freq(struct hmc5843_data *data,
>  		val, val2);
>  }
>  
> -static ssize_t hmc5843_show_range_gain(struct device *dev,
> -				struct device_attribute *attr,
> -				char *buf)
> +static ssize_t hmc5843_show_calibscale_avail(struct device *dev,
> +				struct device_attribute *attr, char *buf)
>  {
> -	u8 range;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct hmc5843_data *data = iio_priv(indio_dev);
> +	struct hmc5843_data *data = iio_priv(dev_to_iio_dev(dev));
>  
> -	range = data->range;
> -	return sprintf(buf, "%d\n", data->variant->regval_to_input_field_mga[range]);
> +	return hmc5843_show_int_plus_micros(buf,
> +		data->variant->regval_to_range_ga, HMC5843_RANGE_GAIN_MAX+1);
>  }
>  
> -static ssize_t hmc5843_set_range_gain(struct device *dev,
> -			struct device_attribute *attr,
> -			const char *buf,
> -			size_t count)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -	struct hmc5843_data *data = iio_priv(indio_dev);
> -	unsigned long range = 0;
> -	int error;
> -
> -	mutex_lock(&data->lock);
> -	error = kstrtoul(buf, 10, &range);
> -	if (error) {
> -		count = error;
> -		goto exit;
> -	}
> -	dev_dbg(dev, "set range to %lu\n", range);
> +static IIO_DEVICE_ATTR(calibscale_available, S_IRUGO,
> +	hmc5843_show_calibscale_avail, NULL, 0);
>  
> -	if (range > HMC5843_RANGE_GAIN_MAX) {
> -		count = -EINVAL;
> -		goto exit;
> -	}
> -
> -	data->range = range;
> -	range = range << HMC5843_RANGE_GAIN_OFFSET;
> -	if (i2c_smbus_write_byte_data(data->client, this_attr->address, range))
> -		count = -EINVAL;
> -
> -exit:
> -	mutex_unlock(&data->lock);
> -	return count;
> +static int hmc5843_check_range(struct hmc5843_data *data,
> +	int val, int val2)
> +{
> +	return hmc5843_check_int_plus_micros(data->variant->regval_to_range_ga,
> +		HMC5843_RANGE_GAIN_MAX+1, val, val2);
>  }
>  
> -static IIO_DEVICE_ATTR(in_magn_range,
> -			S_IWUSR | S_IRUGO,
> -			hmc5843_show_range_gain,
> -			hmc5843_set_range_gain,
> -			HMC5843_CONFIG_REG_B);
> -
>  static int hmc5843_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int *val, int *val2, long mask)
> @@ -482,6 +452,10 @@ static int hmc5843_read_raw(struct iio_dev *indio_dev,
>  		*val = data->variant->regval_to_samp_freq[data->rate][0];
>  		*val2 = data->variant->regval_to_samp_freq[data->rate][1];
>  		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		*val = data->variant->regval_to_range_ga[data->range][0];
> +		*val2 = data->variant->regval_to_range_ga[data->range][1];
> +		return IIO_VAL_INT_PLUS_MICRO;
>  	}
>  	return -EINVAL;
>  }
> @@ -491,7 +465,7 @@ static int hmc5843_write_raw(struct iio_dev *indio_dev,
>  			     int val, int val2, long mask)
>  {
>  	struct hmc5843_data *data = iio_priv(indio_dev);
> -	int ret, rate;
> +	int ret, rate, range;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> @@ -506,6 +480,20 @@ static int hmc5843_write_raw(struct iio_dev *indio_dev,
>  		mutex_unlock(&data->lock);
>  
>  		return ret;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		range = hmc5843_check_range(data, val, val2);
> +		if (range < 0)
> +			return -EINVAL;
> +
> +		range <<= HMC5843_RANGE_GAIN_OFFSET;
> +		mutex_lock(&data->lock);
> +		ret = i2c_smbus_write_byte_data(data->client,
> +			HMC5843_CONFIG_REG_B, range);
> +		if (ret >= 0)
> +			data->range = range;
> +		mutex_unlock(&data->lock);
> +
> +		return ret;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -518,7 +506,8 @@ static int hmc5843_write_raw(struct iio_dev *indio_dev,
>  		.channel2 = IIO_MOD_##axis,				\
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> -			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ) |			\
> +			BIT(IIO_CHAN_INFO_CALIBSCALE),			\
>  		.address = addr						\
>  	}
>  
> @@ -537,7 +526,7 @@ static const struct iio_chan_spec hmc5883_channels[] = {
>  static struct attribute *hmc5843_attributes[] = {
>  	&iio_dev_attr_meas_conf.dev_attr.attr,
>  	&iio_dev_attr_operating_mode.dev_attr.attr,
> -	&iio_dev_attr_in_magn_range.dev_attr.attr,
> +	&iio_dev_attr_calibscale_available.dev_attr.attr,
>  	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>  	NULL
>  };
> @@ -550,22 +539,19 @@ static const struct hmc5843_chip_info hmc5843_chip_info_tbl[] = {
>  	[HMC5843_ID] = {
>  		.channels = hmc5843_channels,
>  		.regval_to_samp_freq = hmc5843_regval_to_samp_freq,
> -		.regval_to_input_field_mga =
> -			hmc5843_regval_to_input_field_mga,
> +		.regval_to_range_ga = hmc5843_regval_to_range_ga,
>  		.regval_to_nanoscale = hmc5843_regval_to_nanoscale,
>  	},
>  	[HMC5883_ID] = {
>  		.channels = hmc5883_channels,
>  		.regval_to_samp_freq = hmc5883_regval_to_samp_freq,
> -		.regval_to_input_field_mga =
> -			hmc5883_regval_to_input_field_mga,
> +		.regval_to_range_ga = hmc5883_regval_to_range_ga,
>  		.regval_to_nanoscale = hmc5883_regval_to_nanoscale,
>  	},
>  	[HMC5883L_ID] = {
>  		.channels = hmc5883_channels,
>  		.regval_to_samp_freq = hmc5883_regval_to_samp_freq,
> -		.regval_to_input_field_mga =
> -			hmc5883l_regval_to_input_field_mga,
> +		.regval_to_range_ga = hmc5883l_regval_to_range_ga,
>  		.regval_to_nanoscale = hmc5883l_regval_to_nanoscale,
>  	},
>  };
> 
