Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40834 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753542AbcK0KQz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Nov 2016 05:16:55 -0500
Subject: Re: [PATCH v3] Staging: iio: adc: fix sysfs files modes in ad7192.c
To: Boyan Vladinov <nayobix@nayobix.org>, gregkh@linuxfoundation.org,
        lars@metafoo.de, Michael.Hennerich@analog.com
References: <1480199964-9554-1-git-send-email-nayobix@nayobix.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <139aad02-061c-0931-5f30-ba5d707691c1@kernel.org>
Date: Sun, 27 Nov 2016 10:09:47 +0000
MIME-Version: 1.0
In-Reply-To: <1480199964-9554-1-git-send-email-nayobix@nayobix.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/11/16 22:39, Boyan Vladinov wrote:
> Fixes warnings found by checkpatch.pl:
> - sysfs entries user/group modes to use their octal representation
> - use the IIO_DEVICE_ATTR_[RO|RW] macroses
> - coding style
> 
> Signed-off-by: Boyan Vladinov <nayobix@nayobix.org>
Unfortunately this isn't quite as straight forward as it initially appears.
Making these changes is good if it makes the code simpler of cleaner.  In a couple
of cases here it actually makes it harder to tell what is going on.

Anyhow, a few suggestions inline on how to proceed.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/adc/ad7192.c | 39 ++++++++++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index 1fb68c01abd5..29b8a291fb6a 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -340,15 +340,21 @@ ad7192_show_scale_available(struct device *dev,
>  	return len;
>  }
>  
> +static ssize_t
> +in_voltage_scale_available_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	return ad7192_show_scale_available(dev, attr, buf);
> +}
> +
>  static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
>  			     in_voltage-voltage_scale_available,
> -			     S_IRUGO, ad7192_show_scale_available, NULL, 0);
> +			     0444, ad7192_show_scale_available, NULL, 0);
>  

> -static IIO_DEVICE_ATTR(in_voltage_scale_available, S_IRUGO,
> -		       ad7192_show_scale_available, NULL, 0);
> +static IIO_DEVICE_ATTR_RO(in_voltage_scale_available, 0);
I'd prefer this one was left alone.  By using the macro for one of the two cases
we've just obscured the fact that they are really the same thing just with two
different names.

We do have new infrastructure to support available attributes directly in the core.
If you want to look at implementing both of these using that it would be great.
See the info_mask_*_available elements of struct iio_dev and the read_avail
callback.  Documentation is a bit weak on these at the moment unfortunately so
you may want to look back at the descriptions of the patches that introduced them.

>  
> -static ssize_t ad7192_show_ac_excitation(struct device *dev,
> -					 struct device_attribute *attr,
> +static ssize_t ac_excitation_en_show(struct device *dev,
> +				     struct device_attribute *attr,
>  					 char *buf)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> @@ -357,8 +363,8 @@ static ssize_t ad7192_show_ac_excitation(struct device *dev,
>  	return sprintf(buf, "%d\n", !!(st->mode & AD7192_MODE_ACX));
>  }
>  
> -static ssize_t ad7192_show_bridge_switch(struct device *dev,
> -					 struct device_attribute *attr,
> +static ssize_t bridge_switch_en_show(struct device *dev,
> +				     struct device_attribute *attr,
>  					 char *buf)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> @@ -367,8 +373,8 @@ static ssize_t ad7192_show_bridge_switch(struct device *dev,
>  	return sprintf(buf, "%d\n", !!(st->gpocon & AD7192_GPOCON_BPDSW));
>  }
>  
> -static ssize_t ad7192_set(struct device *dev,
> -			  struct device_attribute *attr,
> +static ssize_t bridge_switch_en_store(struct device *dev,
> +				      struct device_attribute *attr,
>  			  const char *buf,
>  			  size_t len)
>  {
> @@ -412,13 +418,16 @@ static ssize_t ad7192_set(struct device *dev,
>  	return ret ? ret : len;
>  }
>  
> -static IIO_DEVICE_ATTR(bridge_switch_en, S_IRUGO | S_IWUSR,
> -		       ad7192_show_bridge_switch, ad7192_set,
> -		       AD7192_REG_GPOCON);
> +static ssize_t ac_excitation_en_store(struct device *dev,
> +				      struct device_attribute *attr,
> +					 const char *buf, size_t len)
> +{
This function naming is confusing. It's not enabling the bridge switch in this
case... Hence if you were going to do this you'd need to wrap a single function
with a name covering both cases, once for each of the cases.

Or take the view that the 'shared' code is trivial and break out the relevant bits
into each of these two functions directly.
> +	return bridge_switch_en_store(dev, attr, buf, len);
> +}
> +
> +static IIO_DEVICE_ATTR_RW(bridge_switch_en, AD7192_REG_GPOCON);
>  
> -static IIO_DEVICE_ATTR(ac_excitation_en, S_IRUGO | S_IWUSR,
> -		       ad7192_show_ac_excitation, ad7192_set,
> -		       AD7192_REG_MODE);
> +static IIO_DEVICE_ATTR_RW(ac_excitation_en, AD7192_REG_MODE);
>  
>  static struct attribute *ad7192_attributes[] = {
>  	&iio_dev_attr_in_v_m_v_scale_available.dev_attr.attr,
> 

