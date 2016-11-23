Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:59470 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752680AbcKWHhk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Nov 2016 02:37:40 -0500
Date: Wed, 23 Nov 2016 08:37:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Boyan Vladinov <nayobix@nayobix.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: iio: adc: fix sysfs files modes in ad7192.c
Message-ID: <20161123073700.GA16431@kroah.com>
References: <1479885914-17615-1-git-send-email-nayobix@nayobix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479885914-17615-1-git-send-email-nayobix@nayobix.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Nov 22, 2016 at 11:25:14PM -0800, Boyan Vladinov wrote:
> Fixes sysfs entries user/group modes and coding style warnings
> found by checkpatch.pl tool
> 
> Signed-off-by: Boyan Vladinov <nayobix@nayobix.org>
> ---
>  drivers/staging/iio/adc/ad7192.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index 1fb68c01abd5..3f9f54b654f7 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -341,10 +341,10 @@ ad7192_show_scale_available(struct device *dev,
>  }
>  
>  static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
> -			     in_voltage-voltage_scale_available,
> -			     S_IRUGO, ad7192_show_scale_available, NULL, 0);
> +			     in_voltage - voltage_scale_available,
> +			     0444, ad7192_show_scale_available, NULL, 0);

IIO_DEVICE_ATTR_RO() after fixing up some variable names?

>  
> -static IIO_DEVICE_ATTR(in_voltage_scale_available, S_IRUGO,
> +static IIO_DEVICE_ATTR(in_voltage_scale_available, 0444,
>  		       ad7192_show_scale_available, NULL, 0);

IIO_DEVICE_ATTR_RO()?

>  
>  static ssize_t ad7192_show_ac_excitation(struct device *dev,
> @@ -412,11 +412,11 @@ static ssize_t ad7192_set(struct device *dev,
>  	return ret ? ret : len;
>  }
>  
> -static IIO_DEVICE_ATTR(bridge_switch_en, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(bridge_switch_en, 0444 | 0200,
>  		       ad7192_show_bridge_switch, ad7192_set,
>  		       AD7192_REG_GPOCON);

IIO_DEVICE_ATTR_RW()?

thanks,

greg k-h
