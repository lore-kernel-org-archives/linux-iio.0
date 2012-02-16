Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:51808 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389Ab2BPPJ4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 16 Feb 2012 10:09:56 -0500
Message-ID: <4F3D1C1A.4040604@cam.ac.uk>
Date: Thu, 16 Feb 2012 15:09:14 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 2/5] staging:iio:dac:ad5064: Convert to extended channel
 info attributes
References: <1329389351-21584-1-git-send-email-lars@metafoo.de> <1329389351-21584-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1329389351-21584-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2/16/2012 10:49 AM, Lars-Peter Clausen wrote:
> Use extended channel info attributes for the powerdown and powerdown_mode
> attributes.
You could even take the power_down_mode_available in as a shared
iio_chan_spec_ext_info?  Nice as it would get rid of the attrs group 
entirely.

Up to you and fine with me either way.
>
> Signed-off-by: Lars-Peter Clausen<lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   drivers/staging/iio/dac/ad5064.c |   92 ++++++++++++++++----------------------
>   1 files changed, 39 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/staging/iio/dac/ad5064.c b/drivers/staging/iio/dac/ad5064.c
> index 049a855..202f927 100644
> --- a/drivers/staging/iio/dac/ad5064.c
> +++ b/drivers/staging/iio/dac/ad5064.c
> @@ -86,6 +86,29 @@ enum ad5064_type {
>   	ID_AD5064_1,
>   };
>
> +static ssize_t ad5064_read_powerdown_mode(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *chan, char *buf);
> +static ssize_t ad5064_write_powerdown_mode(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *chan, const char *buf, size_t len);
> +static ssize_t ad5064_read_dac_powerdown(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *chan, char *buf);
> +static ssize_t ad5064_write_dac_powerdown(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *chan, const char *buf, size_t len);
> +
> +static struct iio_chan_spec_ext_info ad5064_ext_info[] = {
> +	{
> +		.name = "powerdown",
> +		.read = ad5064_read_dac_powerdown,
> +		.write = ad5064_write_dac_powerdown,
> +	},
> +	{
> +		.name = "powerdown_mode",
> +		.read = ad5064_read_powerdown_mode,
> +		.write = ad5064_write_powerdown_mode,
> +	},
> +	{ },
> +};
> +
>   #define AD5064_CHANNEL(chan, bits) {				\
>   	.type = IIO_VOLTAGE,					\
>   	.indexed = 1,						\
> @@ -93,7 +116,8 @@ enum ad5064_type {
>   	.channel = (chan),					\
>   	.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,	\
>   	.address = AD5064_ADDR_DAC(chan),			\
> -	.scan_type = IIO_ST('u', (bits), 16, 20 - (bits))	\
> +	.scan_type = IIO_ST('u', (bits), 16, 20 - (bits)),	\
> +	.ext_info = ad5064_ext_info,				\
>   }
>
>   static const struct ad5064_chip_info ad5064_chip_info_tbl[] = {
> @@ -160,22 +184,18 @@ static const char ad5064_powerdown_modes[][15] = {
>   	[AD5064_LDAC_PWRDN_3STATE]	= "three_state",
>   };
>
> -static ssize_t ad5064_read_powerdown_mode(struct device *dev,
> -	struct device_attribute *attr, char *buf)
> +static ssize_t ad5064_read_powerdown_mode(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan, char *buf)
>   {
> -	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>   	struct ad5064_state *st = iio_priv(indio_dev);
>
>   	return sprintf(buf, "%s\n",
> -		ad5064_powerdown_modes[st->pwr_down_mode[this_attr->address]]);
> +		ad5064_powerdown_modes[st->pwr_down_mode[chan->channel]]);
>   }
>
> -static ssize_t ad5064_write_powerdown_mode(struct device *dev,
> -	struct device_attribute *attr, const char *buf, size_t len)
> +static ssize_t ad5064_write_powerdown_mode(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan, const char *buf, size_t len)
>   {
> -	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>   	struct ad5064_state *st = iio_priv(indio_dev);
>   	unsigned int mode, i;
>   	int ret;
> @@ -192,31 +212,26 @@ static ssize_t ad5064_write_powerdown_mode(struct device *dev,
>   		return  -EINVAL;
>
>   	mutex_lock(&indio_dev->mlock);
> -	st->pwr_down_mode[this_attr->address] = mode;
> +	st->pwr_down_mode[chan->channel] = mode;
>
> -	ret = ad5064_sync_powerdown_mode(st, this_attr->address);
> +	ret = ad5064_sync_powerdown_mode(st, chan->channel);
>   	mutex_unlock(&indio_dev->mlock);
>
>   	return ret ? ret : len;
>   }
>
> -static ssize_t ad5064_read_dac_powerdown(struct device *dev,
> -					   struct device_attribute *attr,
> -					   char *buf)
> +static ssize_t ad5064_read_dac_powerdown(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan, char *buf)
>   {
> -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>   	struct ad5064_state *st = iio_priv(indio_dev);
> -	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>
> -	return sprintf(buf, "%d\n", st->pwr_down[this_attr->address]);
> +	return sprintf(buf, "%d\n", st->pwr_down[chan->channel]);
>   }
>
> -static ssize_t ad5064_write_dac_powerdown(struct device *dev,
> -	struct device_attribute *attr, const char *buf, size_t len)
> +static ssize_t ad5064_write_dac_powerdown(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan, const char *buf, size_t len)
>   {
> -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>   	struct ad5064_state *st = iio_priv(indio_dev);
> -	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>   	bool pwr_down;
>   	int ret;
>
> @@ -225,9 +240,9 @@ static ssize_t ad5064_write_dac_powerdown(struct device *dev,
>   		return ret;
>
>   	mutex_lock(&indio_dev->mlock);
> -	st->pwr_down[this_attr->address] = pwr_down;
> +	st->pwr_down[chan->channel] = pwr_down;
>
> -	ret = ad5064_sync_powerdown_mode(st, this_attr->address);
> +	ret = ad5064_sync_powerdown_mode(st, chan->channel);
>   	mutex_unlock(&indio_dev->mlock);
>   	return ret ? ret : len;
>   }
> @@ -235,36 +250,7 @@ static ssize_t ad5064_write_dac_powerdown(struct device *dev,
>   static IIO_CONST_ATTR(out_voltage_powerdown_mode_available,
>   			"1kohm_to_gnd 100kohm_to_gnd three_state");
>
> -#define IIO_DEV_ATTR_DAC_POWERDOWN_MODE(_chan) \
> -	IIO_DEVICE_ATTR(out_voltage##_chan##_powerdown_mode, \
> -			S_IRUGO | S_IWUSR, \
> -			ad5064_read_powerdown_mode, \
> -			ad5064_write_powerdown_mode, _chan);
> -
> -#define IIO_DEV_ATTR_DAC_POWERDOWN(_chan)				\
> -	IIO_DEVICE_ATTR(out_voltage##_chan##_powerdown,			\
> -			S_IRUGO | S_IWUSR,				\
> -			ad5064_read_dac_powerdown,			\
> -			ad5064_write_dac_powerdown, _chan)
> -
> -static IIO_DEV_ATTR_DAC_POWERDOWN(0);
> -static IIO_DEV_ATTR_DAC_POWERDOWN_MODE(0);
> -static IIO_DEV_ATTR_DAC_POWERDOWN(1);
> -static IIO_DEV_ATTR_DAC_POWERDOWN_MODE(1);
> -static IIO_DEV_ATTR_DAC_POWERDOWN(2);
> -static IIO_DEV_ATTR_DAC_POWERDOWN_MODE(2);
> -static IIO_DEV_ATTR_DAC_POWERDOWN(3);
> -static IIO_DEV_ATTR_DAC_POWERDOWN_MODE(3);
> -
>   static struct attribute *ad5064_attributes[] = {
> -	&iio_dev_attr_out_voltage0_powerdown.dev_attr.attr,
> -	&iio_dev_attr_out_voltage1_powerdown.dev_attr.attr,
> -	&iio_dev_attr_out_voltage2_powerdown.dev_attr.attr,
> -	&iio_dev_attr_out_voltage3_powerdown.dev_attr.attr,
> -	&iio_dev_attr_out_voltage0_powerdown_mode.dev_attr.attr,
> -	&iio_dev_attr_out_voltage1_powerdown_mode.dev_attr.attr,
> -	&iio_dev_attr_out_voltage2_powerdown_mode.dev_attr.attr,
> -	&iio_dev_attr_out_voltage3_powerdown_mode.dev_attr.attr,
>   	&iio_const_attr_out_voltage_powerdown_mode_available.dev_attr.attr,
>   	NULL,
>   };

