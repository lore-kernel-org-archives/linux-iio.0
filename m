Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35501 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754726AbcJHQpR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Oct 2016 12:45:17 -0400
Subject: Re: [PATCH v4 2/2] staging: iio: ad7606: implement
 IIO_CHAN_INFO_OVERSAMPLING_RATIO
To: Eva Rachel Retuya <eraretuya@gmail.com>, linux-iio@vger.kernel.org,
        outreachy-kernel@googlegroups.com
References: <cover.1475942324.git.eraretuya@gmail.com>
 <112de0943e9e3b8764d11612451b04b1f2939509.1475942324.git.eraretuya@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8bdd593d-b0da-31a7-d3e1-f9c16ea3db07@kernel.org>
Date: Sat, 8 Oct 2016 17:45:15 +0100
MIME-Version: 1.0
In-Reply-To: <112de0943e9e3b8764d11612451b04b1f2939509.1475942324.git.eraretuya@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/10/16 17:05, Eva Rachel Retuya wrote:
> This driver predates the availability of IIO_CHAN_INFO_OVERSAMPLING_RATIO
> attribute wherein usage has some advantages like it can be accessed by
> in-kernel consumers as well as reduces the code size.
> 
> Therefore, use IIO_CHAN_INFO_OVERSAMPLING_RATIO to implement the
> oversampling_ratio attribute instead of using IIO_DEVICE_ATTR() macro.
> 
> Move code from the functions associated with IIO_DEVICE_ATTR() into
> the read_raw hook as well as add the write_raw hook with both masks set
> to IIO_CHAN_INFO_OVERSAMPLING_RATIO.
> 
> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/adc/ad7606_core.c | 67 ++++++++++++++++-------------------
>  1 file changed, 31 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
> index cbd6bc5..2042225 100644
> --- a/drivers/staging/iio/adc/ad7606_core.c
> +++ b/drivers/staging/iio/adc/ad7606_core.c
> @@ -103,6 +103,9 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
>  		*val = st->range * 2;
>  		*val2 = st->chip_info->channels[0].scan_type.realbits;
>  		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*val = st->oversampling;
> +		return IIO_VAL_INT;
>  	}
>  	return -EINVAL;
>  }
> @@ -145,16 +148,6 @@ static IIO_DEVICE_ATTR(in_voltage_range, S_IRUGO | S_IWUSR,
>  		       ad7606_show_range, ad7606_store_range, 0);
>  static IIO_CONST_ATTR(in_voltage_range_available, "5000 10000");
>  
> -static ssize_t ad7606_show_oversampling_ratio(struct device *dev,
> -					      struct device_attribute *attr,
> -					      char *buf)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ad7606_state *st = iio_priv(indio_dev);
> -
> -	return sprintf(buf, "%u\n", st->oversampling);
> -}
> -
>  static int ad7606_oversampling_get_index(unsigned int val)
>  {
>  	unsigned char supported[] = {0, 2, 4, 8, 16, 32, 64};
> @@ -167,44 +160,43 @@ static int ad7606_oversampling_get_index(unsigned int val)
>  	return -EINVAL;
>  }
>  
> -static ssize_t ad7606_store_oversampling_ratio(struct device *dev,
> -					       struct device_attribute *attr,
> -					       const char *buf, size_t count)
> +static int ad7606_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val,
> +			    int val2,
> +			    long mask)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad7606_state *st = iio_priv(indio_dev);
> -	unsigned long lval;
>  	int ret;
>  
> -	ret = kstrtoul(buf, 10, &lval);
> -	if (ret)
> -		return ret;
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		if (val2)
> +			return -EINVAL;
> +		ret = ad7606_oversampling_get_index(val);
> +		if (ret < 0) {
> +			dev_err(st->dev, "oversampling %d is not supported\n",
> +				val);
> +			return ret;
> +		}
>  
> -	ret = ad7606_oversampling_get_index(lval);
> -	if (ret < 0) {
> -		dev_err(dev, "oversampling %lu is not supported\n", lval);
> -		return ret;
> +		mutex_lock(&indio_dev->mlock);
> +		gpio_set_value(st->pdata->gpio_os0, (ret >> 0) & 1);
> +		gpio_set_value(st->pdata->gpio_os1, (ret >> 1) & 1);
> +		gpio_set_value(st->pdata->gpio_os2, (ret >> 2) & 1);
> +		st->oversampling = val;
> +		mutex_unlock(&indio_dev->mlock);
> +		return 0;
> +	default:
> +		return -EINVAL;
>  	}
> -
> -	mutex_lock(&indio_dev->mlock);
> -	gpio_set_value(st->pdata->gpio_os0, (ret >> 0) & 1);
> -	gpio_set_value(st->pdata->gpio_os1, (ret >> 1) & 1);
> -	gpio_set_value(st->pdata->gpio_os2, (ret >> 2) & 1);
> -	st->oversampling = lval;
> -	mutex_unlock(&indio_dev->mlock);
> -
> -	return count;
>  }
>  
> -static IIO_DEVICE_ATTR(oversampling_ratio, S_IRUGO | S_IWUSR,
> -		       ad7606_show_oversampling_ratio,
> -		       ad7606_store_oversampling_ratio, 0);
>  static IIO_CONST_ATTR(oversampling_ratio_available, "0 2 4 8 16 32 64");
>  
>  static struct attribute *ad7606_attributes_os_and_range[] = {
>  	&iio_dev_attr_in_voltage_range.dev_attr.attr,
>  	&iio_const_attr_in_voltage_range_available.dev_attr.attr,
> -	&iio_dev_attr_oversampling_ratio.dev_attr.attr,
>  	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
>  	NULL,
>  };
> @@ -214,7 +206,6 @@ static const struct attribute_group ad7606_attribute_group_os_and_range = {
>  };
>  
>  static struct attribute *ad7606_attributes_os[] = {
> -	&iio_dev_attr_oversampling_ratio.dev_attr.attr,
>  	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
>  	NULL,
>  };
> @@ -241,6 +232,8 @@ static const struct attribute_group ad7606_attribute_group_range = {
>  		.address = num,					\
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
> +		.info_mask_shared_by_all =			\
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
>  		.scan_index = num,				\
>  		.scan_type = {					\
>  			.sign = 's',				\
> @@ -429,12 +422,14 @@ static const struct iio_info ad7606_info_no_os_or_range = {
>  static const struct iio_info ad7606_info_os_and_range = {
>  	.driver_module = THIS_MODULE,
>  	.read_raw = &ad7606_read_raw,
> +	.write_raw = &ad7606_write_raw,
>  	.attrs = &ad7606_attribute_group_os_and_range,
>  };
>  
>  static const struct iio_info ad7606_info_os = {
>  	.driver_module = THIS_MODULE,
>  	.read_raw = &ad7606_read_raw,
> +	.write_raw = &ad7606_write_raw,
>  	.attrs = &ad7606_attribute_group_os,
>  };
>  
> 

