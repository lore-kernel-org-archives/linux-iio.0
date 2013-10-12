Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47178 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038Ab3JLLBo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Oct 2013 07:01:44 -0400
Message-ID: <52593A44.3080007@kernel.org>
Date: Sat, 12 Oct 2013 13:02:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 18/20] staging:iio:ad799x: Use event spec for threshold
 hysteresis
References: <1381155094-20166-1-git-send-email-lars@metafoo.de> <1381155094-20166-18-git-send-email-lars@metafoo.de>
In-Reply-To: <1381155094-20166-18-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/07/13 15:11, Lars-Peter Clausen wrote:
> Register the event threshold hysteresis attributes by using the new
> IIO_EV_INFO_HYSTERESIS event spec type. This allows us to throw away a good
> portion of boiler-plate code.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Applied, as here as it is a great improvement.

I do wonder if we can handle the EITHER direction of the event more
cleanly, now we have the different event masks.

Maybe that is even uglier than the current option.

What do you think?
> ---
>  drivers/staging/iio/adc/ad799x_core.c | 132 ++++++++--------------------------
>  1 file changed, 29 insertions(+), 103 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
> index fa0ada1..9428be8 100644
> --- a/drivers/staging/iio/adc/ad799x_core.c
> +++ b/drivers/staging/iio/adc/ad799x_core.c
> @@ -259,13 +259,23 @@ static int ad799x_read_event_config(struct iio_dev *indio_dev,
>  	return 1;
>  }
>  
> -static int ad799x_threshold_reg(const struct iio_chan_spec *chan,
> -					enum iio_event_direction dir)
> +static unsigned int ad799x_threshold_reg(const struct iio_chan_spec *chan,
> +					 enum iio_event_direction dir,
> +					 enum iio_event_info info)
>  {
> -	if (dir == IIO_EV_DIR_FALLING)
> -		return AD7998_DATALOW_REG(chan->channel);
> -	else
> -		return AD7998_DATAHIGH_REG(chan->channel);
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		if (dir == IIO_EV_DIR_FALLING)
> +			return AD7998_DATALOW_REG(chan->channel);
> +		else
> +			return AD7998_DATAHIGH_REG(chan->channel);
> +	case IIO_EV_INFO_HYSTERESIS:
> +		return AD7998_HYST_REG(chan->channel);
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
>  }
>  
>  static int ad799x_write_event_value(struct iio_dev *indio_dev,
> @@ -279,7 +289,8 @@ static int ad799x_write_event_value(struct iio_dev *indio_dev,
>  	struct ad799x_state *st = iio_priv(indio_dev);
>  
>  	mutex_lock(&indio_dev->mlock);
> -	ret = ad799x_i2c_write16(st, ad799x_threshold_reg(chan, dir), val);
> +	ret = ad799x_i2c_write16(st, ad799x_threshold_reg(chan, dir, info),
> +		val);
>  	mutex_unlock(&indio_dev->mlock);
>  
>  	return ret;
> @@ -297,7 +308,8 @@ static int ad799x_read_event_value(struct iio_dev *indio_dev,
>  	u16 valin;
>  
>  	mutex_lock(&indio_dev->mlock);
> -	ret = ad799x_i2c_read16(st, ad799x_threshold_reg(chan, dir), &valin);
> +	ret = ad799x_i2c_read16(st, ad799x_threshold_reg(chan, dir, info),
> +		&valin);
>  	mutex_unlock(&indio_dev->mlock);
>  	if (ret < 0)
>  		return ret;
> @@ -306,46 +318,6 @@ static int ad799x_read_event_value(struct iio_dev *indio_dev,
>  	return IIO_VAL_INT;
>  }
>  
> -static ssize_t ad799x_read_channel_config(struct device *dev,
> -					struct device_attribute *attr,
> -					char *buf)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ad799x_state *st = iio_priv(indio_dev);
> -	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -
> -	int ret;
> -	u16 val;
> -	ret = ad799x_i2c_read16(st, this_attr->address, &val);
> -	if (ret)
> -		return ret;
> -
> -	return sprintf(buf, "%d\n", val);
> -}
> -
> -static ssize_t ad799x_write_channel_config(struct device *dev,
> -					 struct device_attribute *attr,
> -					 const char *buf,
> -					 size_t len)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ad799x_state *st = iio_priv(indio_dev);
> -	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -
> -	long val;
> -	int ret;
> -
> -	ret = kstrtol(buf, 10, &val);
> -	if (ret)
> -		return ret;
> -
> -	mutex_lock(&indio_dev->mlock);
> -	ret = ad799x_i2c_write16(st, this_attr->address, val);
> -	mutex_unlock(&indio_dev->mlock);
> -
> -	return ret ? ret : len;
> -}
> -
>  static irqreturn_t ad799x_event_handler(int irq, void *private)
>  {
>  	struct iio_dev *indio_dev = private;
> @@ -381,60 +353,19 @@ done:
>  	return IRQ_HANDLED;
>  }
>  
> -static IIO_DEVICE_ATTR(in_voltage0_thresh_both_hyst_raw,
> -		       S_IRUGO | S_IWUSR,
> -		       ad799x_read_channel_config,
> -		       ad799x_write_channel_config,
> -		       AD7998_HYST_REG(0));
> -
> -static IIO_DEVICE_ATTR(in_voltage1_thresh_both_hyst_raw,
> -		       S_IRUGO | S_IWUSR,
> -		       ad799x_read_channel_config,
> -		       ad799x_write_channel_config,
> -		       AD7998_HYST_REG(1));
> -
> -static IIO_DEVICE_ATTR(in_voltage2_thresh_both_hyst_raw,
> -		       S_IRUGO | S_IWUSR,
> -		       ad799x_read_channel_config,
> -		       ad799x_write_channel_config,
> -		       AD7998_HYST_REG(2));
> -
> -static IIO_DEVICE_ATTR(in_voltage3_thresh_both_hyst_raw,
> -		       S_IRUGO | S_IWUSR,
> -		       ad799x_read_channel_config,
> -		       ad799x_write_channel_config,
> -		       AD7998_HYST_REG(3));
> -
>  static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
>  			      ad799x_read_frequency,
>  			      ad799x_write_frequency);
>  static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("15625 7812 3906 1953 976 488 244 0");
>  
> -static struct attribute *ad7993_4_7_8_event_attributes[] = {
> -	&iio_dev_attr_in_voltage0_thresh_both_hyst_raw.dev_attr.attr,
> -	&iio_dev_attr_in_voltage1_thresh_both_hyst_raw.dev_attr.attr,
> -	&iio_dev_attr_in_voltage2_thresh_both_hyst_raw.dev_attr.attr,
> -	&iio_dev_attr_in_voltage3_thresh_both_hyst_raw.dev_attr.attr,
> -	&iio_dev_attr_sampling_frequency.dev_attr.attr,
> -	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> -	NULL,
> -};
> -
> -static struct attribute_group ad7993_4_7_8_event_attrs_group = {
> -	.attrs = ad7993_4_7_8_event_attributes,
> -	.name = "events",
> -};
> -
> -static struct attribute *ad7992_event_attributes[] = {
> -	&iio_dev_attr_in_voltage0_thresh_both_hyst_raw.dev_attr.attr,
> -	&iio_dev_attr_in_voltage1_thresh_both_hyst_raw.dev_attr.attr,
> +static struct attribute *ad799x_event_attributes[] = {
>  	&iio_dev_attr_sampling_frequency.dev_attr.attr,
>  	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
>  	NULL,
>  };
>  
> -static struct attribute_group ad7992_event_attrs_group = {
> -	.attrs = ad7992_event_attributes,
> +static struct attribute_group ad799x_event_attrs_group = {
> +	.attrs = ad799x_event_attributes,
>  	.name = "events",
>  };
>  
> @@ -443,18 +374,9 @@ static const struct iio_info ad7991_info = {
>  	.driver_module = THIS_MODULE,
>  };
>  
> -static const struct iio_info ad7992_info = {
> -	.read_raw = &ad799x_read_raw,
> -	.event_attrs = &ad7992_event_attrs_group,
> -	.read_event_config_new = &ad799x_read_event_config,
> -	.read_event_value_new = &ad799x_read_event_value,
> -	.write_event_value_new = &ad799x_write_event_value,
> -	.driver_module = THIS_MODULE,
> -};
> -
>  static const struct iio_info ad7993_4_7_8_info = {
>  	.read_raw = &ad799x_read_raw,
> -	.event_attrs = &ad7993_4_7_8_event_attrs_group,
> +	.event_attrs = &ad799x_event_attrs_group,
>  	.read_event_config_new = &ad799x_read_event_config,
>  	.read_event_value_new = &ad799x_read_event_value,
>  	.write_event_value_new = &ad799x_write_event_value,
> @@ -473,6 +395,10 @@ static const struct iio_event_spec ad799x_events[] = {
>  		.dir = IIO_EV_DIR_FALLING,
>  		.mask_separate = BIT(IIO_EV_INFO_VALUE),
>  			BIT(IIO_EV_INFO_ENABLE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_HYSTERESIS),
This is a little ugly, but I can see why you did it.  Do we need to allow an additional
event_mask, perhaps
mask_shared_by_both_directions ?

Then we could drop the IIO_EV_DIR_EITHER direction entirely.


>  	},
>  };
>  
> @@ -537,7 +463,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
>  		},
>  		.num_channels = 3,
>  		.default_config = AD7998_ALERT_EN,
> -		.info = &ad7992_info,
> +		.info = &ad7993_4_7_8_info,
>  	},
>  	[ad7993] = {
>  		.channel = {
> 
