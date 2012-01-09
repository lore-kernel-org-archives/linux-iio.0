Return-Path: <lars@metafoo.de>
Message-ID: <4F0ABDED.2090407@metafoo.de>
Date: Mon, 09 Jan 2012 11:14:05 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, pirmin.duss@flytec.ch
Subject: Re: [PATCH 6/6] staging:iio: attrs/event_attrs -> struct attribute
 * + move to iio_dev.
References: <1325931921-14547-1-git-send-email-jic23@kernel.org> <1325931921-14547-7-git-send-email-jic23@kernel.org>
In-Reply-To: <1325931921-14547-7-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 01/07/2012 11:25 AM, Jonathan Cameron wrote:
>
> diff --git a/drivers/staging/iio/adc/ad7606_core.c
b/drivers/staging/iio/adc/ad7606_core.c
> index 97e8d3d..99d91ee 100644
> --- a/drivers/staging/iio/adc/ad7606_core.c
> +++ b/drivers/staging/iio/adc/ad7606_core.c
> @@ -205,30 +205,18 @@ static struct attribute
*ad7606_attributes_os_and_range[] = {
>  	NULL,
>  };
>
> -static const struct attribute_group ad7606_attribute_group_os_and_range = {
> -	.attrs = ad7606_attributes_os_and_range,
> -};
> -
>  static struct attribute *ad7606_attributes_os[] = {
>  	&iio_dev_attr_oversampling_ratio.dev_attr.attr,
>  	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
>  	NULL,
>  };
>
> -static const struct attribute_group ad7606_attribute_group_os = {
> -	.attrs = ad7606_attributes_os,
> -};
> -
>  static struct attribute *ad7606_attributes_range[] = {
>  	&iio_dev_attr_in_voltage_range.dev_attr.attr,
>  	&iio_const_attr_in_voltage_range_available.dev_attr.attr,
>  	NULL,
>  };
>
> -static const struct attribute_group ad7606_attribute_group_range = {
> -	.attrs = ad7606_attributes_range,
> -};
> -
>  #define AD7606_CHANNEL(num)				\
>  	{						\
>  		.type = IIO_VOLTAGE,			\
> @@ -429,27 +417,9 @@ static irqreturn_t ad7606_interrupt(int irq, void
*dev_id)
>  	return IRQ_HANDLED;
>  };
>
> -static const struct iio_info ad7606_info_no_os_or_range = {
> -	.driver_module = THIS_MODULE,
> -	.read_raw = &ad7606_read_raw,
> -};
> -
> -static const struct iio_info ad7606_info_os_and_range = {
> -	.driver_module = THIS_MODULE,
> -	.read_raw = &ad7606_read_raw,
> -	.attrs = &ad7606_attribute_group_os_and_range,
> -};
> -
> -static const struct iio_info ad7606_info_os = {
> +static const struct iio_info ad7606_info = {
>  	.driver_module = THIS_MODULE,
>  	.read_raw = &ad7606_read_raw,
> -	.attrs = &ad7606_attribute_group_os,
> -};
> -
> -static const struct iio_info ad7606_info_range = {
> -	.driver_module = THIS_MODULE,
> -	.read_raw = &ad7606_read_raw,
> -	.attrs = &ad7606_attribute_group_range,
>  };
>
>  struct iio_dev *ad7606_probe(struct device *dev, int irq,
> @@ -494,19 +464,16 @@ struct iio_dev *ad7606_probe(struct device *dev, int
irq,
>  	st->chip_info = &ad7606_chip_info_tbl[id];
>
>  	indio_dev->dev.parent = dev;
> +	indio_dev->info = &ad7606_info;
>  	if (gpio_is_valid(st->pdata->gpio_os0) &&
>  	    gpio_is_valid(st->pdata->gpio_os1) &&
>  	    gpio_is_valid(st->pdata->gpio_os2)) {
>  		if (gpio_is_valid(st->pdata->gpio_range))
> -			indio_dev->info = &ad7606_info_os_and_range;
> +			indio_dev->attrs = ad7606_attributes_os_and_range;
>  		else
> -			indio_dev->info = &ad7606_info_os;
> -	} else {
> -		if (gpio_is_valid(st->pdata->gpio_range))
> -			indio_dev->info = &ad7606_info_range;
> -		else
> -			indio_dev->info = &ad7606_info_no_os_or_range;
> -	}
> +			indio_dev->attrs = ad7606_attributes_os;
> +	} else if (gpio_is_valid(st->pdata->gpio_range))
> +			indio_dev->attrs = ad7606_attributes_range;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->name = st->chip_info->name;
>  	indio_dev->channels = st->chip_info->channels;

This makes me wonder if we not better add a function which can add a single
attribute to the attribute list at runtime. Or maybe just use
device_create_file directly.

- Lars
