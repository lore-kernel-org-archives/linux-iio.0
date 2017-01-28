Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45288 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751720AbdA1M3g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Jan 2017 07:29:36 -0500
Subject: Re: [PATCH] Staging: iio: adc: fix symbolic permissions coding style
 issue
To: =?UTF-8?Q?Juli=c3=a1n_de_Gortari?= <kiototeko@gmail.com>
References: <1485194909-12453-1-git-send-email-kiototeko@gmail.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <87c48e6c-dbfb-088b-d200-10fda3818c7c@kernel.org>
Date: Sat, 28 Jan 2017 12:22:24 +0000
MIME-Version: 1.0
In-Reply-To: <1485194909-12453-1-git-send-email-kiototeko@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/01/17 18:08, Julián de Gortari wrote:
> Octal permissions should be used instead of symbolic ones for easier
> reading.
> 
> Signed-off-by: Julián de Gortari <kiototeko@gmail.com>
While I find it exceptionally hard to care about this one, the driver in question
doesn't seem to be undergoing much churn so I've applied this. This all came
from a somewhat throw away comment Linus made rather than anyone caring that
strongly about it.  He was more saying he disliked patches going the other way
than anything else.  Anyhow, no way you would necessarily know this and it's
a nicely presented patch.  Please do put the name of the driver in the
title though - I've fixed up whilst applying.

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/adc/ad7816.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 72551f8..17d2805 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -139,7 +139,7 @@ static ssize_t ad7816_store_mode(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(mode, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(mode, 0644,
>  		ad7816_show_mode,
>  		ad7816_store_mode,
>  		0);
> @@ -151,7 +151,7 @@ static ssize_t ad7816_show_available_modes(struct device *dev,
>  	return sprintf(buf, "full\npower-save\n");
>  }
>  
> -static IIO_DEVICE_ATTR(available_modes, S_IRUGO, ad7816_show_available_modes,
> +static IIO_DEVICE_ATTR(available_modes, 0444, ad7816_show_available_modes,
>  			NULL, 0);
>  
>  static ssize_t ad7816_show_channel(struct device *dev,
> @@ -197,7 +197,7 @@ static ssize_t ad7816_store_channel(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(channel, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(channel, 0644,
>  		ad7816_show_channel,
>  		ad7816_store_channel,
>  		0);
> @@ -228,7 +228,7 @@ static ssize_t ad7816_show_value(struct device *dev,
>  	return sprintf(buf, "%u\n", data);
>  }
>  
> -static IIO_DEVICE_ATTR(value, S_IRUGO, ad7816_show_value, NULL, 0);
> +static IIO_DEVICE_ATTR(value, 0444, ad7816_show_value, NULL, 0);
>  
>  static struct attribute *ad7816_attributes[] = {
>  	&iio_dev_attr_available_modes.dev_attr.attr,
> @@ -319,7 +319,7 @@ static inline ssize_t ad7816_set_oti(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(oti, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(oti, 0644,
>  		       ad7816_show_oti, ad7816_set_oti, 0);
>  
>  static struct attribute *ad7816_event_attributes[] = {
> 

