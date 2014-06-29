Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:63984 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751197AbaF2PqS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 29 Jun 2014 11:46:18 -0400
Message-ID: <53B034C6.8090805@gmx.de>
Date: Sun, 29 Jun 2014 17:46:14 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
CC: kristina.martsenko@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 7/7] iio: imu: adis16480 switch sampling frequency attr
 to core support
References: <1403467186-26639-1-git-send-email-jic23@kernel.org> <1403467186-26639-8-git-send-email-jic23@kernel.org>
In-Reply-To: <1403467186-26639-8-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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
>  drivers/iio/imu/adis16480.c | 82 ++++++++++++---------------------------------
>  1 file changed, 22 insertions(+), 60 deletions(-)
>
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index dd4206c..426f3bd 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -257,11 +257,16 @@ static int adis16480_debugfs_init(struct iio_dev *indio_dev)
>  
>  #endif
>  
> -static int adis16480_set_freq(struct adis16480 *st, unsigned int freq)
> +static int adis16480_set_freq(struct iio_dev *indio_dev, int val, int val2)
>  {
> +	struct adis16480 *st = iio_priv(indio_dev);
>  	unsigned int t;
> +	
> +	t =  val * 1000 + val2 / 1000;
> +	if (t <= 0)
> +	   	return -EINVAL;
>  
> -	t = 2460000 / freq;
> +	t = 2460000 / t;
>  	if (t > 2048)
>  		t = 2048;
>  
> @@ -271,65 +276,24 @@ static int adis16480_set_freq(struct adis16480 *st, unsigned int freq)
>  	return adis_write_reg_16(&st->adis, ADIS16480_REG_DEC_RATE, t);
>  }
>  
> -static int adis16480_get_freq(struct adis16480 *st, unsigned int *freq)
> +static int adis16480_get_freq(struct iio_dev *indio_dev, int *val, int *val2)
>  {
> +	struct adis16480 *st = iio_priv(indio_dev);
>  	uint16_t t;
>  	int ret;
> +	unsigned freq;
>  
>  	ret = adis_read_reg_16(&st->adis, ADIS16480_REG_DEC_RATE, &t);
>  	if (ret < 0)
>  		return ret;
>  
> -	*freq = 2460000 / (t + 1);
> -
> -	return 0;
> -}
> -
> -static ssize_t adis16480_read_frequency(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct adis16480 *st = iio_priv(indio_dev);
> -	unsigned int freq;
> -	int ret;
> -
> -	ret = adis16480_get_freq(st, &freq);
> -	if (ret < 0)
> -		return ret;
> +	freq = 2460000 / (t + 1);
> +	*val = freq / 1000;
> +	*val2 = (freq % 1000) * 1000;
>  
> -	return sprintf(buf, "%d.%.3d\n", freq / 1000, freq % 1000);
> +	return IIO_VAL_INT_PLUS_MICRO;
>  }
>  
> -static ssize_t adis16480_write_frequency(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct adis16480 *st = iio_priv(indio_dev);
> -	int freq_int, freq_fract;
> -	long val;
> -	int ret;
> -
> -	ret = iio_str_to_fixpoint(buf, 100, &freq_int, &freq_fract);
> -	if (ret)
> -		return ret;
> -
> -	val = freq_int * 1000 + freq_fract;
> -
> -	if (val <= 0)
> -		return -EINVAL;
> -
> -	ret = adis16480_set_freq(st, val);
> -
> -	return ret ? ret : len;
> -}
> -
> -static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
> -			      adis16480_read_frequency,
> -			      adis16480_write_frequency);
> -
>  enum {
>  	ADIS16480_SCAN_GYRO_X,
>  	ADIS16480_SCAN_GYRO_Y,
> @@ -571,6 +535,8 @@ static int adis16480_read_raw(struct iio_dev *indio_dev,
>  		return adis16480_get_calibscale(indio_dev, chan, val);
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>  		return adis16480_get_filter_freq(indio_dev, chan, val);
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return adis16480_get_freq(indio_dev, val, val2);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -586,6 +552,9 @@ static int adis16480_write_raw(struct iio_dev *indio_dev,
>  		return adis16480_set_calibscale(indio_dev, chan, val);
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>  		return adis16480_set_filter_freq(indio_dev, chan, val);
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return adis16480_set_freq(indio_dev, val, val2);
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -600,6 +569,7 @@ static int adis16480_write_raw(struct iio_dev *indio_dev,
>  			BIT(IIO_CHAN_INFO_CALIBBIAS) | \
>  			_info_sep, \
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
>  		.address = (_address), \
>  		.scan_index = (_si), \
>  		.scan_type = { \
> @@ -638,6 +608,7 @@ static int adis16480_write_raw(struct iio_dev *indio_dev,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
>  			BIT(IIO_CHAN_INFO_CALIBBIAS) | \
>  			BIT(IIO_CHAN_INFO_SCALE), \
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
>  		.address = ADIS16480_REG_BAROM_OUT, \
>  		.scan_index = ADIS16480_SCAN_BARO, \
>  		.scan_type = { \
> @@ -655,6 +626,7 @@ static int adis16480_write_raw(struct iio_dev *indio_dev,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
>  			BIT(IIO_CHAN_INFO_SCALE) | \
>  			BIT(IIO_CHAN_INFO_OFFSET), \
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
>  		.address = ADIS16480_REG_TEMP_OUT, \
>  		.scan_index = ADIS16480_SCAN_TEMP, \
>  		.scan_type = { \
> @@ -717,17 +689,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  	},
>  };
>  
> -static struct attribute *adis16480_attributes[] = {
> -	&iio_dev_attr_sampling_frequency.dev_attr.attr,
> -	NULL
> -};
> -
> -static const struct attribute_group adis16480_attribute_group = {
> -	.attrs = adis16480_attributes,
> -};
> -
>  static const struct iio_info adis16480_info = {
> -	.attrs = &adis16480_attribute_group,
>  	.read_raw = &adis16480_read_raw,
>  	.write_raw = &adis16480_write_raw,
>  	.update_scan_mode = adis_update_scan_mode,

