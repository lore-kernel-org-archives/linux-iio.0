Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52459 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783Ab3JAIo0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 04:44:26 -0400
Message-ID: <524A9995.4070607@kernel.org>
Date: Tue, 01 Oct 2013 10:44:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 03/15] staging:iio:hmc5843: Use INFO_SAMP_FREQ
References: <1379619360-8150-1-git-send-email-pmeerw@pmeerw.net> <1379619360-8150-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1379619360-8150-4-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/19/13 20:35, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git with a fair bit
of hand editting given the context clash with the fixup I
put in the first patch.

Please check I didn't mess it up!

Jonathan
> ---
>  drivers/staging/iio/magnetometer/hmc5843.c | 135 ++++++++++++-----------------
>  1 file changed, 54 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
> index 49a105d..faeb115 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -165,18 +165,19 @@ static const int hmc5883l_regval_to_input_field_mga[] = {
>   * 6		| 50			| 75
>   * 7		| Not used		| Not used
>   */
> -static const char * const hmc5843_regval_to_sample_freq[] = {
> -	"0.5", "1", "2", "5", "10", "20", "50",
> +static const int hmc5843_regval_to_samp_freq[7][2] = {
> +	{0, 500000}, {1, 0}, {2, 0}, {5, 0}, {10, 0}, {20, 0}, {50, 0}
>  };
>  
> -static const char * const hmc5883_regval_to_sample_freq[] = {
> -	"0.75", "1.5", "3", "7.5", "15", "30", "75",
> +static const int hmc5883_regval_to_samp_freq[7][2] = {
> +	{0, 750000}, {1, 500000}, {3, 0}, {7, 500000}, {15, 0}, {30, 0},
> +	{75, 0}
>  };
>  
>  /* Describe chip variants */
>  struct hmc5843_chip_info {
>  	const struct iio_chan_spec *channels;
> -	const char * const *regval_to_sample_freq;
> +	const int (*regval_to_samp_freq)[2];
>  	const int *regval_to_input_field_mga;
>  	const int *regval_to_nanoscale;
>  };
> @@ -370,17 +371,17 @@ static IIO_DEVICE_ATTR(meas_conf,
>  			hmc5843_set_measurement_configuration,
>  			0);
>  
> -static ssize_t hmc5843_show_sampling_frequencies_available(struct device *dev,
> -						struct device_attribute *attr,
> -						char *buf)
> +static ssize_t hmc5843_show_samp_freq_avail(struct device *dev,
> +				struct device_attribute *attr, char *buf)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct hmc5843_data *data = iio_priv(indio_dev);
> +	struct hmc5843_data *data = iio_priv(dev_to_iio_dev(dev));
>  	ssize_t total_n = 0;
>  	int i;
>  
>  	for (i = 0; i < HMC5843_RATE_NOT_USED; i++) {
> -		ssize_t n = sprintf(buf, "%s ", data->variant->regval_to_sample_freq[i]);
> +		ssize_t n = sprintf(buf, "%d.%d ",
> +			data->variant->regval_to_samp_freq[i][0],
> +			data->variant->regval_to_samp_freq[i][1]);
>  		buf += n;
>  		total_n += n;
>  	}
> @@ -390,87 +391,30 @@ static ssize_t hmc5843_show_sampling_frequencies_available(struct device *dev,
>  	return total_n;
>  }
>  
> -static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(hmc5843_show_sampling_frequencies_available);
> +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(hmc5843_show_samp_freq_avail);
>  
>  static s32 hmc5843_set_rate(struct hmc5843_data *data, u8 rate)
>  {
> -	u8 reg_val;
> -
> -	if (rate >= HMC5843_RATE_NOT_USED) {
> -		dev_err(&data->client->dev,
> -			"data output rate is not supported\n");
> -		return -EINVAL;
> -	}
> +	u8 reg_val = data->meas_conf | (rate << HMC5843_RATE_OFFSET);
>  
> -	reg_val = data->meas_conf | (rate << HMC5843_RATE_OFFSET);
>  	return i2c_smbus_write_byte_data(data->client, HMC5843_CONFIG_REG_A,
>  		reg_val);
>  }
>  
> -static int hmc5843_check_sampling_frequency(struct hmc5843_data *data,
> -						const char *buf)
> +static int hmc5843_check_samp_freq(struct hmc5843_data *data,
> +	int val, int val2)
>  {
> -	const char * const *samp_freq = data->variant->regval_to_sample_freq;
>  	int i;
>  
>  	for (i = 0; i < HMC5843_RATE_NOT_USED; i++) {
> -		if (sysfs_streq(buf, samp_freq[i]))
> +		if (val == data->variant->regval_to_samp_freq[i][0] &&
> +			val2 == data->variant->regval_to_samp_freq[i][1])
>  			return i;
>  	}
>  
>  	return -EINVAL;
>  }
>  
> -static ssize_t hmc5843_set_sampling_frequency(struct device *dev,
> -					struct device_attribute *attr,
> -					const char *buf, size_t count)
> -{
> -
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct hmc5843_data *data = iio_priv(indio_dev);
> -	int rate;
> -
> -	rate = hmc5843_check_sampling_frequency(data, buf);
> -	if (rate < 0) {
> -		dev_err(&data->client->dev,
> -			"sampling frequency is not supported\n");
> -		return rate;
> -	}
> -
> -	mutex_lock(&data->lock);
> -	dev_dbg(dev, "set rate to %d\n", rate);
> -	if (hmc5843_set_rate(data->client, rate)) {
> -		count = -EINVAL;
> -		goto exit;
> -	}
> -	data->rate = rate;
> -
> -exit:
> -	mutex_unlock(&data->lock);
> -	return count;
> -}
> -
> -static ssize_t hmc5843_show_sampling_frequency(struct device *dev,
> -			struct device_attribute *attr, char *buf)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -	struct hmc5843_data *data = iio_priv(indio_dev);
> -	s32 rate;
> -
> -	rate = i2c_smbus_read_byte_data(data->client, this_attr->address);
> -	if (rate < 0)
> -		return rate;
> -	rate = (rate & HMC5843_RATE_BITMASK) >> HMC5843_RATE_OFFSET;
> -	return sprintf(buf, "%s\n", data->variant->regval_to_sample_freq[rate]);
> -}
> -
> -static IIO_DEVICE_ATTR(sampling_frequency,
> -			S_IWUSR | S_IRUGO,
> -			hmc5843_show_sampling_frequency,
> -			hmc5843_set_sampling_frequency,
> -			HMC5843_CONFIG_REG_A);
> -
>  static ssize_t hmc5843_show_range_gain(struct device *dev,
>  				struct device_attribute *attr,
>  				char *buf)
> @@ -525,8 +469,7 @@ static IIO_DEVICE_ATTR(in_magn_range,
>  
>  static int hmc5843_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
> -			    int *val, int *val2,
> -			    long mask)
> +			    int *val, int *val2, long mask)
>  {
>  	struct hmc5843_data *data = iio_priv(indio_dev);
>  
> @@ -537,17 +480,47 @@ static int hmc5843_read_raw(struct iio_dev *indio_dev,
>  		*val = 0;
>  		*val2 = data->variant->regval_to_nanoscale[data->range];
>  		return IIO_VAL_INT_PLUS_NANO;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = data->variant->regval_to_samp_freq[data->rate][0];
> +		*val2 = data->variant->regval_to_samp_freq[data->rate][1];
> +		return IIO_VAL_INT_PLUS_MICRO;
>  	}
>  	return -EINVAL;
>  }
>  
> +static int hmc5843_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct hmc5843_data *data = iio_priv(indio_dev);
> +	int ret, rate;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		rate = hmc5843_check_samp_freq(data, val, val2);
> +		if (rate < 0)
> +			return -EINVAL;
> +
> +		mutex_lock(&data->lock);
> +		ret = hmc5843_set_rate(data, rate);
> +		if (ret >= 0)
> +			data->rate = rate;
> +		mutex_unlock(&data->lock);
> +
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  #define HMC5843_CHANNEL(axis, addr)					\
>  	{								\
>  		.type = IIO_MAGN,					\
>  		.modified = 1,						\
>  		.channel2 = IIO_MOD_##axis,				\
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> -		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
>  		.address = addr						\
>  	}
>  
> @@ -566,7 +539,6 @@ static const struct iio_chan_spec hmc5883_channels[] = {
>  static struct attribute *hmc5843_attributes[] = {
>  	&iio_dev_attr_meas_conf.dev_attr.attr,
>  	&iio_dev_attr_operating_mode.dev_attr.attr,
> -	&iio_dev_attr_sampling_frequency.dev_attr.attr,
>  	&iio_dev_attr_in_magn_range.dev_attr.attr,
>  	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>  	NULL
> @@ -579,21 +551,21 @@ static const struct attribute_group hmc5843_group = {
>  static const struct hmc5843_chip_info hmc5843_chip_info_tbl[] = {
>  	[HMC5843_ID] = {
>  		.channels = hmc5843_channels,
> -		.regval_to_sample_freq = hmc5843_regval_to_sample_freq,
> +		.regval_to_samp_freq = hmc5843_regval_to_samp_freq,
>  		.regval_to_input_field_mga =
>  			hmc5843_regval_to_input_field_mga,
>  		.regval_to_nanoscale = hmc5843_regval_to_nanoscale,
>  	},
>  	[HMC5883_ID] = {
>  		.channels = hmc5883_channels,
> -		.regval_to_sample_freq = hmc5883_regval_to_sample_freq,
> +		.regval_to_samp_freq = hmc5883_regval_to_samp_freq,
>  		.regval_to_input_field_mga =
>  			hmc5883_regval_to_input_field_mga,
>  		.regval_to_nanoscale = hmc5883_regval_to_nanoscale,
>  	},
>  	[HMC5883L_ID] = {
>  		.channels = hmc5883_channels,
> -		.regval_to_sample_freq = hmc5883_regval_to_sample_freq,
> +		.regval_to_samp_freq = hmc5883_regval_to_samp_freq,
>  		.regval_to_input_field_mga =
>  			hmc5883l_regval_to_input_field_mga,
>  		.regval_to_nanoscale = hmc5883l_regval_to_nanoscale,
> @@ -612,6 +584,7 @@ static void hmc5843_init(struct hmc5843_data *data)
>  static const struct iio_info hmc5843_info = {
>  	.attrs = &hmc5843_group,
>  	.read_raw = &hmc5843_read_raw,
> +	.write_raw = &hmc5843_write_raw,
>  	.driver_module = THIS_MODULE,
>  };
>  
> 
