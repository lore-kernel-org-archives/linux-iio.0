Return-Path: <knaack.h@gmx.de>
Message-ID: <53B000B5.5000202@gmx.de>
Date: Sun, 29 Jun 2014 14:04:05 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
CC: kristina.martsenko@gmail.com,
 Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
 Thorsten Nowak <thorsten.nowak@iis.fraunhofer.de>,
 Christian Strobel <christian.strobel@iis.fraunhofer.de>
Subject: Re: [PATCH 2/7] iio: gyro: itg3200 switch sampling frequency attr
 to core support.
References: <1403467186-26639-1-git-send-email-jic23@kernel.org> <1403467186-26639-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1403467186-26639-3-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron schrieb:
> By using the info_mask_shared_by_all element of the channel spec, access
> to the sampling frequency becomes available to in kernel users of the
> driver.  It also shortens and simplifies the code a little.
>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> Cc: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
> Cc: Thorsten Nowak <thorsten.nowak@iis.fraunhofer.de>
> Cc: Christian Strobel <christian.strobel@iis.fraunhofer.de>
Reviewed-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
Looks good to me.
>  drivers/iio/gyro/itg3200_core.c | 101 +++++++++++++++++-----------------------
>  1 file changed, 43 insertions(+), 58 deletions(-)
>
> diff --git a/drivers/iio/gyro/itg3200_core.c b/drivers/iio/gyro/itg3200_core.c
> index 8295e31..6a8020d 100644
> --- a/drivers/iio/gyro/itg3200_core.c
> +++ b/drivers/iio/gyro/itg3200_core.c
> @@ -90,6 +90,7 @@ static int itg3200_read_raw(struct iio_dev *indio_dev,
>  {
>  	int ret = 0;
>  	u8 reg;
> +	u8 regval;
>  
>  	switch (info) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -107,65 +108,60 @@ static int itg3200_read_raw(struct iio_dev *indio_dev,
>  		/* Only the temperature channel has an offset */
>  		*val = 23000;
>  		return IIO_VAL_INT;
> -	default:
> -		return -EINVAL;
> -	}
> -}
> -
> -static ssize_t itg3200_read_frequency(struct device *dev,
> -		struct device_attribute *attr, char *buf)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	int ret, sps;
> -	u8 val;
> -
> -	ret = itg3200_read_reg_8(indio_dev, ITG3200_REG_DLPF, &val);
> -	if (ret)
> -		return ret;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = itg3200_read_reg_8(indio_dev, ITG3200_REG_DLPF, &regval);
> +		if (ret)
> +			return ret;
>  
> -	sps = (val & ITG3200_DLPF_CFG_MASK) ? 1000 : 8000;
> +		*val = (regval & ITG3200_DLPF_CFG_MASK) ? 1000 : 8000;
>  
> -	ret = itg3200_read_reg_8(indio_dev, ITG3200_REG_SAMPLE_RATE_DIV, &val);
> -	if (ret)
> -		return ret;
> +		ret = itg3200_read_reg_8(indio_dev,
> +					 ITG3200_REG_SAMPLE_RATE_DIV,
> +					 &regval);
> +		if (ret)
> +			return ret;
>  
> -	sps /= val + 1;
> +		*val /= regval + 1;
> +		return IIO_VAL_INT;
>  
> -	return sprintf(buf, "%d\n", sps);
> +	default:
> +		return -EINVAL;
> +	}
>  }
>  
> -static ssize_t itg3200_write_frequency(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +static int itg3200_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val,
> +			     int val2,
> +			     long mask)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	unsigned val;
>  	int ret;
>  	u8 t;
>  
> -	ret = kstrtouint(buf, 10, &val);
> -	if (ret)
> -		return ret;
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (val == 0 || val2 != 0)
> +			return -EINVAL;
>  
> -	mutex_lock(&indio_dev->mlock);
> +		mutex_lock(&indio_dev->mlock);
>  
> -	ret = itg3200_read_reg_8(indio_dev, ITG3200_REG_DLPF, &t);
> -	if (ret)
> -		goto err_ret;
> +		ret = itg3200_read_reg_8(indio_dev, ITG3200_REG_DLPF, &t);
> +		if (ret) {
> +			mutex_unlock(&indio_dev->mlock);
> +			return ret;
> +		}
> +		t = ((t & ITG3200_DLPF_CFG_MASK) ? 1000u : 8000u) / val - 1;
>  
> -	if (val == 0) {
> -		ret = -EINVAL;
> -		goto err_ret;
> -	}
> -	t = ((t & ITG3200_DLPF_CFG_MASK) ? 1000u : 8000u) / val - 1;
> +		ret = itg3200_write_reg_8(indio_dev,
> +					  ITG3200_REG_SAMPLE_RATE_DIV,
> +					  t);
>  
> -	ret = itg3200_write_reg_8(indio_dev, ITG3200_REG_SAMPLE_RATE_DIV, t);
> -
> -err_ret:
> -	mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(&indio_dev->mlock);
> +	return ret;
>  
> -	return ret ? ret : len;
> +	default:
> +		return -EINVAL;
> +	}
>  }
>  
>  /*
> @@ -255,6 +251,7 @@ err_ret:
>  	.channel2 = IIO_MOD_ ## _mod, \
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
>  	.address = ITG3200_REG_GYRO_ ## _mod ## OUT_H, \
>  	.scan_index = ITG3200_SCAN_GYRO_ ## _mod, \
>  	.scan_type = ITG3200_ST, \
> @@ -267,6 +264,7 @@ static const struct iio_chan_spec itg3200_channels[] = {
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
>  		BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.address = ITG3200_REG_TEMP_OUT_H,
>  		.scan_index = ITG3200_SCAN_TEMP,
>  		.scan_type = ITG3200_ST,
> @@ -277,22 +275,9 @@ static const struct iio_chan_spec itg3200_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(ITG3200_SCAN_ELEMENTS),
>  };
>  
> -/* IIO device attributes */
> -static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO, itg3200_read_frequency,
> -		itg3200_write_frequency);
> -
> -static struct attribute *itg3200_attributes[] = {
> -	&iio_dev_attr_sampling_frequency.dev_attr.attr,
> -	NULL
> -};
> -
> -static const struct attribute_group itg3200_attribute_group = {
> -	.attrs = itg3200_attributes,
> -};
> -
>  static const struct iio_info itg3200_info = {
> -	.attrs = &itg3200_attribute_group,
>  	.read_raw = &itg3200_read_raw,
> +	.write_raw = &itg3200_write_raw,
>  	.driver_module = THIS_MODULE,
>  };
>  
