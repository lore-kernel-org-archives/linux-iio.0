Return-Path: <lars@metafoo.de>
Message-ID: <4FBFB2DB.6020702@metafoo.de>
Date: Fri, 25 May 2012 18:27:07 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
 Roland Stigge <stigge@antcom.de>
Subject: Re: [PATCH 10/18] staging:iio:dac:max517: Convert to channel spec
References: <1337600587-19848-1-git-send-email-lars@metafoo.de> <1337600587-19848-10-git-send-email-lars@metafoo.de>
In-Reply-To: <1337600587-19848-10-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 05/21/2012 01:42 PM, Lars-Peter Clausen wrote:
> Convert the max517 driver to channel spec. As part of the conversion the
> "out_voltage_1&2_raw" property, which updates both channel 1 and 2
> simultaneously with the same value, is lost, since this is not really covered by
> the IIO spec and has only a limited use case in practice.
> 
> Also the channel index for the sysfs files is now zero based instead of one
> based, which means all channes numbers will be lower by one. E.g.
> "out_voltage_1_scale" instead of "out_voltage_2_scale"
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Roland Stigge <stigge@antcom.de>
> Acked-by: Jonathan Cameron <jic23@kernel.org>

Hi Roland,

Any chance to get a Acked-by from you for this patch

Thanks,
- Lars

> ---
> Changes since v1:
> 	* Fix a bug which would have caused the channels not to be updated properly.
> 	  Writes to channel one would have had no effect, writes to channel two
> 	  would have updated channel one. As part of this the support for updating
> 	  both channels at once has been removed from max517_set_value since we
> 	  weren't using that anymore anyway.
> ---
>  drivers/staging/iio/dac/max517.c |  172 ++++++++++++++------------------------
>  1 file changed, 61 insertions(+), 111 deletions(-)
> 
> diff --git a/drivers/staging/iio/dac/max517.c b/drivers/staging/iio/dac/max517.c
> index 5287cad..403e06f 100644
> --- a/drivers/staging/iio/dac/max517.c
> +++ b/drivers/staging/iio/dac/max517.c
> @@ -27,7 +27,6 @@
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> -#include "dac.h"
>  
>  #include "max517.h"
>  
> @@ -55,129 +54,67 @@ struct max517_data {
>   *          bit 1: channel 2
>   * (this way, it's possible to set both channels at once)
>   */
> -static ssize_t max517_set_value(struct device *dev,
> -				 struct device_attribute *attr,
> -				 const char *buf, size_t count, int channel)
> +static int max517_set_value(struct iio_dev *indio_dev,
> +	long val, int channel)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct max517_data *data = iio_priv(indio_dev);
>  	struct i2c_client *client = data->client;
> -	u8 outbuf[4]; /* 1x or 2x command + value */
> -	int outbuf_size = 0;
> +	u8 outbuf[2];
>  	int res;
> -	long val;
> -
> -	res = strict_strtol(buf, 10, &val);
> -
> -	if (res)
> -		return res;
>  
>  	if (val < 0 || val > 255)
>  		return -EINVAL;
>  
> -	if (channel & 1) {
> -		outbuf[outbuf_size++] = COMMAND_CHANNEL0;
> -		outbuf[outbuf_size++] = val;
> -	}
> -	if (channel & 2) {
> -		outbuf[outbuf_size++] = COMMAND_CHANNEL1;
> -		outbuf[outbuf_size++] = val;
> -	}
> +	outbuf[0] = channel;
> +	outbuf[1] = val;
>  
> -	/*
> -	 * At this point, there are always 1 or 2 two-byte commands in
> -	 * outbuf. With 2 commands, the device can set two outputs
> -	 * simultaneously, latching the values upon the end of the I2C
> -	 * transfer.
> -	 */
> -
> -	res = i2c_master_send(client, outbuf, outbuf_size);
> +	res = i2c_master_send(client, outbuf, 2);
>  	if (res < 0)
>  		return res;
> -
> -	return count;
> -}
> -
> -static ssize_t max517_set_value_1(struct device *dev,
> -				 struct device_attribute *attr,
> -				 const char *buf, size_t count)
> -{
> -	return max517_set_value(dev, attr, buf, count, 1);
> -}
> -static IIO_DEV_ATTR_OUT_RAW(1, max517_set_value_1, 0);
> -
> -static ssize_t max517_set_value_2(struct device *dev,
> -				 struct device_attribute *attr,
> -				 const char *buf, size_t count)
> -{
> -	return max517_set_value(dev, attr, buf, count, 2);
> -}
> -static IIO_DEV_ATTR_OUT_RAW(2, max517_set_value_2, 1);
> -
> -static ssize_t max517_set_value_both(struct device *dev,
> -				 struct device_attribute *attr,
> -				 const char *buf, size_t count)
> -{
> -	return max517_set_value(dev, attr, buf, count, 3);
> +	else if (res != 2)
> +		return -EIO;
> +	else
> +		return 0;
>  }
> -static IIO_DEVICE_ATTR_NAMED(out_voltage1and2_raw,
> -			     out_voltage1&2_raw, S_IWUSR, NULL,
> -			     max517_set_value_both, -1);
>  
> -static ssize_t max517_show_scale(struct device *dev,
> -				struct device_attribute *attr,
> -				char *buf, int channel)
> +static int max517_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val,
> +			   int *val2,
> +			   long m)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct max517_data *data = iio_priv(indio_dev);
> -	/* Corresponds to Vref / 2^(bits) */
> -	unsigned int scale_uv = (data->vref_mv[channel - 1] * 1000) >> 8;
> -
> -	return sprintf(buf, "%d.%03d\n", scale_uv / 1000, scale_uv % 1000);
> +	unsigned int scale_uv;
> +
> +	switch (m) {
> +	case IIO_CHAN_INFO_SCALE:
> +		/* Corresponds to Vref / 2^(bits) */
> +		scale_uv = (data->vref_mv[chan->channel] * 1000) >> 8;
> +		*val =  scale_uv / 1000000;
> +		*val2 = scale_uv % 1000000;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		break;
> +	}
> +	return -EINVAL;
>  }
>  
> -static ssize_t max517_show_scale1(struct device *dev,
> -				struct device_attribute *attr,
> -				char *buf)
> +static int max517_write_raw(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *chan, int val, int val2, long mask)
>  {
> -	return max517_show_scale(dev, attr, buf, 1);
> -}
> -static IIO_DEVICE_ATTR(out_voltage1_scale, S_IRUGO,
> -		       max517_show_scale1, NULL, 0);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = max517_set_value(indio_dev, val, chan->channel);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
>  
> -static ssize_t max517_show_scale2(struct device *dev,
> -				struct device_attribute *attr,
> -				char *buf)
> -{
> -	return max517_show_scale(dev, attr, buf, 2);
> +	return ret;
>  }
> -static IIO_DEVICE_ATTR(out_voltage2_scale, S_IRUGO,
> -		       max517_show_scale2, NULL, 0);
> -
> -/* On MAX517 variant, we have one output */
> -static struct attribute *max517_attributes[] = {
> -	&iio_dev_attr_out_voltage1_raw.dev_attr.attr,
> -	&iio_dev_attr_out_voltage1_scale.dev_attr.attr,
> -	NULL
> -};
> -
> -static struct attribute_group max517_attribute_group = {
> -	.attrs = max517_attributes,
> -};
> -
> -/* On MAX518 and MAX519 variant, we have two outputs */
> -static struct attribute *max518_attributes[] = {
> -	&iio_dev_attr_out_voltage1_raw.dev_attr.attr,
> -	&iio_dev_attr_out_voltage1_scale.dev_attr.attr,
> -	&iio_dev_attr_out_voltage2_raw.dev_attr.attr,
> -	&iio_dev_attr_out_voltage2_scale.dev_attr.attr,
> -	&iio_dev_attr_out_voltage1and2_raw.dev_attr.attr,
> -	NULL
> -};
> -
> -static struct attribute_group max518_attribute_group = {
> -	.attrs = max518_attributes,
> -};
>  
>  #ifdef CONFIG_PM_SLEEP
>  static int max517_suspend(struct device *dev)
> @@ -201,13 +138,24 @@ static SIMPLE_DEV_PM_OPS(max517_pm_ops, max517_suspend, max517_resume);
>  #endif
>  
>  static const struct iio_info max517_info = {
> -	.attrs = &max517_attribute_group,
> +	.read_raw = max517_read_raw,
> +	.write_raw = max517_write_raw,
>  	.driver_module = THIS_MODULE,
>  };
>  
> -static const struct iio_info max518_info = {
> -	.attrs = &max518_attribute_group,
> -	.driver_module = THIS_MODULE,
> +#define MAX517_CHANNEL(chan) {				\
> +	.type = IIO_VOLTAGE,				\
> +	.indexed = 1,					\
> +	.output = 1,					\
> +	.channel = (chan),				\
> +	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |	\
> +	IIO_CHAN_INFO_SCALE_SEPARATE_BIT,		\
> +	.scan_type = IIO_ST('u', 8, 8, 0),		\
> +}
> +
> +static const struct iio_chan_spec max517_channels[] = {
> +	MAX517_CHANNEL(0),
> +	MAX517_CHANNEL(1)
>  };
>  
>  static int max517_probe(struct i2c_client *client,
> @@ -230,12 +178,14 @@ static int max517_probe(struct i2c_client *client,
>  	/* establish that the iio_dev is a child of the i2c device */
>  	indio_dev->dev.parent = &client->dev;
>  
> -	/* reduced attribute set for MAX517 */
> +	/* reduced channel set for MAX517 */
>  	if (id->driver_data == ID_MAX517)
> -		indio_dev->info = &max517_info;
> +		indio_dev->num_channels = 1;
>  	else
> -		indio_dev->info = &max518_info;
> +		indio_dev->num_channels = 2;
> +	indio_dev->channels = max517_channels;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &max517_info;
>  
>  	/*
>  	 * Reference voltage on MAX518 and default is 5V, else take vref_mv
