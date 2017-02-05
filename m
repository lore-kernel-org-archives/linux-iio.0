Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35307 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751661AbdBEJUO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Feb 2017 04:20:14 -0500
Subject: Re: [PATCH 1/1] iio: fixed symbolic permission references 'S_IRUGO |
 S_IWUSR'
To: Artur Lorincz <larturus@yahoo.com>
References: <1486235494-3736-1-git-send-email-larturus@yahoo.com>
Cc: devel@driverdev.osuosl.org,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f0492cf5-fb36-f273-d329-ae0133cc3377@kernel.org>
Date: Sun, 5 Feb 2017 09:20:11 +0000
MIME-Version: 1.0
In-Reply-To: <1486235494-3736-1-git-send-email-larturus@yahoo.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/02/17 19:11, Artur Lorincz wrote:
> Replaced the symbolic permission references S_IRUGO and S_IWUSR with their
> octal counterparts.
> 
> Signed-off-by: Artur Lorincz <larturus@yahoo.com>
Applied with a small change to the description to mention which driver we
are dealing with.

Also, for IIO patches please cc linux-iio as now done.

Jonathan
> ---
>  drivers/staging/iio/adc/ad7192.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index 1fb68c0..4fc8588 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -342,9 +342,9 @@ static int ad7192_setup(struct ad7192_state *st,
> 
>  static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
>  			     in_voltage-voltage_scale_available,
> -			     S_IRUGO, ad7192_show_scale_available, NULL, 0);
> +			     0444, ad7192_show_scale_available, NULL, 0);
> 
> -static IIO_DEVICE_ATTR(in_voltage_scale_available, S_IRUGO,
> +static IIO_DEVICE_ATTR(in_voltage_scale_available, 0444,
>  		       ad7192_show_scale_available, NULL, 0);
> 
>  static ssize_t ad7192_show_ac_excitation(struct device *dev,
> @@ -412,11 +412,11 @@ static ssize_t ad7192_set(struct device *dev,
>  	return ret ? ret : len;
>  }
> 
> -static IIO_DEVICE_ATTR(bridge_switch_en, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(bridge_switch_en, 0644,
>  		       ad7192_show_bridge_switch, ad7192_set,
>  		       AD7192_REG_GPOCON);
> 
> -static IIO_DEVICE_ATTR(ac_excitation_en, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(ac_excitation_en, 0644,
>  		       ad7192_show_ac_excitation, ad7192_set,
>  		       AD7192_REG_MODE);
> 
> --
> 1.9.1
> 

