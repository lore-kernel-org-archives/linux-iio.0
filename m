Return-Path: <knaack.h@gmx.de>
Message-ID: <53B03275.9020805@gmx.de>
Date: Sun, 29 Jun 2014 17:36:21 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
CC: kristina.martsenko@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 6/7] iio: imu: adis16400 switch sampling frequency attr
 to core support.
References: <1403467186-26639-1-git-send-email-jic23@kernel.org> <1403467186-26639-7-git-send-email-jic23@kernel.org>
In-Reply-To: <1403467186-26639-7-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron schrieb:
> By using the info_mask_shared_by_all element of the channel spec, access
> to the sampling frequency becomes available to in kernel users of the
> driver.  It also shortens and simplifies the code.
>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
Reviewed-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
Looks good to me.
>  drivers/iio/imu/adis16400_core.c | 78 +++++++++++++---------------------------
>  1 file changed, 25 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
> index 433583b..dfad54b 100644
> --- a/drivers/iio/imu/adis16400_core.c
> +++ b/drivers/iio/imu/adis16400_core.c
> @@ -214,21 +214,6 @@ static int adis16400_set_freq(struct adis16400_state *st, unsigned int freq)
>  	return adis_write_reg_8(&st->adis, ADIS16400_SMPL_PRD, val);
>  }
>  
> -static ssize_t adis16400_read_frequency(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct adis16400_state *st = iio_priv(indio_dev);
> -	int ret;
> -
> -	ret = st->variant->get_freq(st);
> -	if (ret < 0)
> -		return ret;
> -
> -	return sprintf(buf, "%d.%.3d\n", ret / 1000, ret % 1000);
> -}
> -
>  static const unsigned adis16400_3db_divisors[] = {
>  	[0] = 2, /* Special case */
>  	[1] = 6,
> @@ -260,30 +245,6 @@ static int adis16400_set_filter(struct iio_dev *indio_dev, int sps, int val)
>  	return ret;
>  }
>  
> -static ssize_t adis16400_write_frequency(struct device *dev,
> -	struct device_attribute *attr, const char *buf, size_t len)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct adis16400_state *st = iio_priv(indio_dev);
> -	int i, f, val;
> -	int ret;
> -
> -	ret = iio_str_to_fixpoint(buf, 100, &i, &f);
> -	if (ret)
> -		return ret;
> -
> -	val = i * 1000 + f;
> -
> -	if (val <= 0)
> -		return -EINVAL;
> -
> -	mutex_lock(&indio_dev->mlock);
> -	st->variant->set_freq(st, val);
> -	mutex_unlock(&indio_dev->mlock);
> -
> -	return len;
> -}
> -
>  /* Power down the device */
>  static int adis16400_stop_device(struct iio_dev *indio_dev)
>  {
> @@ -350,10 +311,6 @@ err_ret:
>  	return ret;
>  }
>  
> -static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
> -			      adis16400_read_frequency,
> -			      adis16400_write_frequency);
> -
>  static const uint8_t adis16400_addresses[] = {
>  	[ADIS16400_SCAN_GYRO_X] = ADIS16400_XGYRO_OFF,
>  	[ADIS16400_SCAN_GYRO_Y] = ADIS16400_YGYRO_OFF,
> @@ -394,6 +351,16 @@ static int adis16400_write_raw(struct iio_dev *indio_dev,
>  			val * 1000 + val2 / 1000);
>  		mutex_unlock(&indio_dev->mlock);
>  		return ret;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		sps = val * 1000 + val2 / 1000; 
> +
> +		if (sps <= 0)
> +			return -EINVAL;
> +
> +		mutex_lock(&indio_dev->mlock);
> +		ret = st->variant->set_freq(st, sps);
> +		mutex_unlock(&indio_dev->mlock);
> +		return ret;		
>  	default:
>  		return -EINVAL;
>  	}
> @@ -474,6 +441,13 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = st->variant->get_freq(st);
> +		if (ret < 0)
> +		   	return ret;
> +		*val = ret / 1000;
> +		*val2 = (ret % 1000) * 1000;
> +		return IIO_VAL_INT_PLUS_MICRO;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -486,6 +460,7 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
>  	.extend_name = name, \
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
>  		BIT(IIO_CHAN_INFO_SCALE), \
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
>  	.address = (addr), \
>  	.scan_index = (si), \
>  	.scan_type = { \
> @@ -511,6 +486,7 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
>  		BIT(IIO_CHAN_INFO_CALIBBIAS),		  \
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | \
>  		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY), \
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
>  	.address = addr, \
>  	.scan_index = ADIS16400_SCAN_GYRO_ ## mod, \
>  	.scan_type = { \
> @@ -530,6 +506,7 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
>  		BIT(IIO_CHAN_INFO_CALIBBIAS), \
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | \
>  		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY), \
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
>  	.address = (addr), \
>  	.scan_index = ADIS16400_SCAN_ACC_ ## mod, \
>  	.scan_type = { \
> @@ -548,6 +525,7 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | \
>  		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY), \
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
>  	.address = (addr), \
>  	.scan_index = ADIS16400_SCAN_MAGN_ ## mod, \
>  	.scan_type = { \
> @@ -573,6 +551,7 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
>  		BIT(IIO_CHAN_INFO_SCALE), \
>  	.info_mask_shared_by_type = \
>  		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY), \
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
>  	.address = (addr), \
>  	.scan_index = ADIS16350_SCAN_TEMP_ ## mod, \
>  	.scan_type = { \
> @@ -591,6 +570,7 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
>  		BIT(IIO_CHAN_INFO_OFFSET) | \
>  		BIT(IIO_CHAN_INFO_SCALE), \
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
>  	.address = (addr), \
>  	.scan_index = ADIS16350_SCAN_TEMP_X, \
>  	.scan_type = { \
> @@ -608,6 +588,7 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
>  	.channel2 = IIO_MOD_ ## mod, \
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
>  	.address = (addr), \
>  	.scan_index = ADIS16300_SCAN_INCLI_ ## mod, \
>  	.scan_type = { \
> @@ -649,6 +630,7 @@ static const struct iio_chan_spec adis16448_channels[] = {
>  		.type = IIO_PRESSURE,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
>  		.address = ADIS16448_BARO_OUT,
>  		.scan_index = ADIS16400_SCAN_BARO,
>  		.scan_type = {
> @@ -704,15 +686,6 @@ static const struct iio_chan_spec adis16334_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(ADIS16400_SCAN_TIMESTAMP),
>  };
>  
> -static struct attribute *adis16400_attributes[] = {
> -	&iio_dev_attr_sampling_frequency.dev_attr.attr,
> -	NULL
> -};
> -
> -static const struct attribute_group adis16400_attribute_group = {
> -	.attrs = adis16400_attributes,
> -};
> -
>  static struct adis16400_chip_info adis16400_chips[] = {
>  	[ADIS16300] = {
>  		.channels = adis16300_channels,
> @@ -813,7 +786,6 @@ static const struct iio_info adis16400_info = {
>  	.driver_module = THIS_MODULE,
>  	.read_raw = &adis16400_read_raw,
>  	.write_raw = &adis16400_write_raw,
> -	.attrs = &adis16400_attribute_group,
>  	.update_scan_mode = adis16400_update_scan_mode,
>  	.debugfs_reg_access = adis_debugfs_reg_access,
>  };
