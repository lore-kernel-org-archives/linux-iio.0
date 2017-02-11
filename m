Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45281 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753030AbdBKKqd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Feb 2017 05:46:33 -0500
Subject: Re: [PATCH] Staging: iio: meter: meter.h - style fix
To: Derek Robson <robsonde@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org
References: <20170210070008.14843-1-robsonde@gmail.com>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8378b19d-2e2f-9e64-d237-cb6d93ac8d6c@kernel.org>
Date: Sat, 11 Feb 2017 10:46:30 +0000
MIME-Version: 1.0
In-Reply-To: <20170210070008.14843-1-robsonde@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/02/17 07:00, Derek Robson wrote:
> Changed file permissions to octal.
> Found with checkpatch.
> 
> Signed-off-by: Derek Robson <robsonde@gmail.com>
Applied - thanks,
> ---
>  drivers/staging/iio/meter/meter.h | 60 +++++++++++++++++++--------------------
>  1 file changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/meter.h b/drivers/staging/iio/meter/meter.h
> index dfba510f29be..0e37f23853f1 100644
> --- a/drivers/staging/iio/meter/meter.h
> +++ b/drivers/staging/iio/meter/meter.h
> @@ -81,94 +81,94 @@
>  	IIO_DEVICE_ATTR(reactive_power_c_gain, _mode, _show, _store, _addr)
>  
>  #define IIO_DEV_ATTR_CURRENT_A(_show, _addr)			\
> -	IIO_DEVICE_ATTR(current_a, S_IRUGO, _show, NULL, _addr)
> +	IIO_DEVICE_ATTR(current_a, 0444, _show, NULL, _addr)
>  
>  #define IIO_DEV_ATTR_CURRENT_B(_show, _addr)			\
> -	IIO_DEVICE_ATTR(current_b, S_IRUGO, _show, NULL, _addr)
> +	IIO_DEVICE_ATTR(current_b, 0444, _show, NULL, _addr)
>  
>  #define IIO_DEV_ATTR_CURRENT_C(_show, _addr)			\
> -	IIO_DEVICE_ATTR(current_c, S_IRUGO, _show, NULL, _addr)
> +	IIO_DEVICE_ATTR(current_c, 0444, _show, NULL, _addr)
>  
>  #define IIO_DEV_ATTR_VOLT_A(_show, _addr)			\
> -	IIO_DEVICE_ATTR(volt_a, S_IRUGO, _show, NULL, _addr)
> +	IIO_DEVICE_ATTR(volt_a, 0444, _show, NULL, _addr)
>  
>  #define IIO_DEV_ATTR_VOLT_B(_show, _addr)			\
> -	IIO_DEVICE_ATTR(volt_b, S_IRUGO, _show, NULL, _addr)
> +	IIO_DEVICE_ATTR(volt_b, 0444, _show, NULL, _addr)
>  
>  #define IIO_DEV_ATTR_VOLT_C(_show, _addr)			\
> -	IIO_DEVICE_ATTR(volt_c, S_IRUGO, _show, NULL, _addr)
> +	IIO_DEVICE_ATTR(volt_c, 0444, _show, NULL, _addr)
>  
>  #define IIO_DEV_ATTR_AENERGY(_show, _addr)			\
> -	IIO_DEVICE_ATTR(aenergy, S_IRUGO, _show, NULL, _addr)
> +	IIO_DEVICE_ATTR(aenergy, 0444, _show, NULL, _addr)
>  
>  #define IIO_DEV_ATTR_LENERGY(_show, _addr)			\
> -	IIO_DEVICE_ATTR(lenergy, S_IRUGO, _show, NULL, _addr)
> +	IIO_DEVICE_ATTR(lenergy, 0444, _show, NULL, _addr)
>  
>  #define IIO_DEV_ATTR_RAENERGY(_show, _addr)			\
> -	IIO_DEVICE_ATTR(raenergy, S_IRUGO, _show, NULL, _addr)
> +	IIO_DEVICE_ATTR(raenergy, 0444, _show, NULL, _addr)
>  
>  #define IIO_DEV_ATTR_LAENERGY(_show, _addr)			\
> -	IIO_DEVICE_ATTR(laenergy, S_IRUGO, _show, NULL, _addr)
> +	IIO_DEVICE_ATTR(laenergy, 0444, _show, NULL, _addr)
>  
>  #define IIO_DEV_ATTR_VAENERGY(_show, _addr)			\
> -	IIO_DEVICE_ATTR(vaenergy, S_IRUGO, _show, NULL, _addr)
> +	IIO_DEVICE_ATTR(vaenergy, 0444, _show, NULL, _addr)
>  
>  #define IIO_DEV_ATTR_LVAENERGY(_show, _addr)			\
> -	IIO_DEVICE_ATTR(lvaenergy, S_IRUGO, _show, NULL, _addr)
> +	IIO_DEVICE_ATTR(lvaenergy, 0444, _show, NULL, _addr)
>  
>  #define IIO_DEV_ATTR_RVAENERGY(_show, _addr)			\
> -	IIO_DEVICE_ATTR(rvaenergy, S_IRUGO, _show, NULL, _addr)
> +	IIO_DEVICE_ATTR(rvaenergy, 0444, _show, NULL, _addr)
>  
>  #define IIO_DEV_ATTR_LVARENERGY(_show, _addr)			\
> -	IIO_DEVICE_ATTR(lvarenergy, S_IRUGO, _show, NULL, _addr)
> +	IIO_DEVICE_ATTR(lvarenergy, 0444, _show, NULL, _addr)
>  
>  #define IIO_DEV_ATTR_CHKSUM(_show, _addr)                       \
> -	IIO_DEVICE_ATTR(chksum, S_IRUGO, _show, NULL, _addr)
> +	IIO_DEVICE_ATTR(chksum, 0444, _show, NULL, _addr)
>  
>  #define IIO_DEV_ATTR_ANGLE0(_show, _addr)                       \
> -	IIO_DEVICE_ATTR(angle0, S_IRUGO, _show, NULL, _addr)
> +	IIO_DEVICE_ATTR(angle0, 0444, _show, NULL, _addr)
>  
>  #define IIO_DEV_ATTR_ANGLE1(_show, _addr)                       \
> -	IIO_DEVICE_ATTR(angle1, S_IRUGO, _show, NULL, _addr)
> +	IIO_DEVICE_ATTR(angle1, 0444, _show, NULL, _addr)
>  
>  #define IIO_DEV_ATTR_ANGLE2(_show, _addr)                       \
> -	IIO_DEVICE_ATTR(angle2, S_IRUGO, _show, NULL, _addr)
> +	IIO_DEVICE_ATTR(angle2, 0444, _show, NULL, _addr)
>  
>  #define IIO_DEV_ATTR_AWATTHR(_show, _addr)			\
> -	IIO_DEVICE_ATTR(awatthr, S_IRUGO, _show, NULL, _addr)
> +	IIO_DEVICE_ATTR(awatthr, 0444, _show, NULL, _addr)
>  
>  #define IIO_DEV_ATTR_BWATTHR(_show, _addr)			\
> -	IIO_DEVICE_ATTR(bwatthr, S_IRUGO, _show, NULL, _addr)
> +	IIO_DEVICE_ATTR(bwatthr, 0444, _show, NULL, _addr)
>  
>  #define IIO_DEV_ATTR_CWATTHR(_show, _addr)			\
> -	IIO_DEVICE_ATTR(cwatthr, S_IRUGO, _show, NULL, _addr)
> +	IIO_DEVICE_ATTR(cwatthr, 0444, _show, NULL, _addr)
>  
>  #define IIO_DEV_ATTR_AFWATTHR(_show, _addr)			\
> -	IIO_DEVICE_ATTR(afwatthr, S_IRUGO, _show, NULL, _addr)
> +	IIO_DEVICE_ATTR(afwatthr, 0444, _show, NULL, _addr)
>  
>  #define IIO_DEV_ATTR_BFWATTHR(_show, _addr)			\
> -	IIO_DEVICE_ATTR(bfwatthr, S_IRUGO, _show, NULL, _addr)
> +	IIO_DEVICE_ATTR(bfwatthr, 0444, _show, NULL, _addr)
>  
>  #define IIO_DEV_ATTR_CFWATTHR(_show, _addr)			\
> -	IIO_DEVICE_ATTR(cfwatthr, S_IRUGO, _show, NULL, _addr)
> +	IIO_DEVICE_ATTR(cfwatthr, 0444, _show, NULL, _addr)
>  
>  #define IIO_DEV_ATTR_AVARHR(_show, _addr)			\
> -	IIO_DEVICE_ATTR(avarhr, S_IRUGO, _show, NULL, _addr)
> +	IIO_DEVICE_ATTR(avarhr, 0444, _show, NULL, _addr)
>  
>  #define IIO_DEV_ATTR_BVARHR(_show, _addr)			\
> -	IIO_DEVICE_ATTR(bvarhr, S_IRUGO, _show, NULL, _addr)
> +	IIO_DEVICE_ATTR(bvarhr, 0444, _show, NULL, _addr)
>  
>  #define IIO_DEV_ATTR_CVARHR(_show, _addr)			\
> -	IIO_DEVICE_ATTR(cvarhr, S_IRUGO, _show, NULL, _addr)
> +	IIO_DEVICE_ATTR(cvarhr, 0444, _show, NULL, _addr)
>  
>  #define IIO_DEV_ATTR_AVAHR(_show, _addr)			\
> -	IIO_DEVICE_ATTR(avahr, S_IRUGO, _show, NULL, _addr)
> +	IIO_DEVICE_ATTR(avahr, 0444, _show, NULL, _addr)
>  
>  #define IIO_DEV_ATTR_BVAHR(_show, _addr)			\
> -	IIO_DEVICE_ATTR(bvahr, S_IRUGO, _show, NULL, _addr)
> +	IIO_DEVICE_ATTR(bvahr, 0444, _show, NULL, _addr)
>  
>  #define IIO_DEV_ATTR_CVAHR(_show, _addr)			\
> -	IIO_DEVICE_ATTR(cvahr, S_IRUGO, _show, NULL, _addr)
> +	IIO_DEVICE_ATTR(cvahr, 0444, _show, NULL, _addr)
>  
>  #define IIO_DEV_ATTR_IOS(_mode, _show, _store, _addr)                \
>  	IIO_DEVICE_ATTR(ios, _mode, _show, _store, _addr)
> 

