Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37234 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034683AbdD3X7h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Apr 2017 19:59:37 -0400
Subject: Re: [PATCH 1/5] iio: ad9834 convert symbolic permissions to octal
To: Quentin Swain <dudebrobro179@gmail.com>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        apw@canonical.com, joe@perches.com
References: <20170430231702.377-1-dudebrobro179@gmail.com>
 <20170430231702.377-2-dudebrobro179@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <890a80da-b465-a1e5-419d-f7ba291b6211@kernel.org>
Date: Mon, 1 May 2017 00:59:32 +0100
MIME-Version: 1.0
In-Reply-To: <20170430231702.377-2-dudebrobro179@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/05/17 00:16, Quentin Swain wrote:
> Remove checkpatch warnings by converting symbolic S_IRUGO and S_IWUSR
> permissions to octal
> 
> Signed-off-by: Quentin Swain <dudebrobro179@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/frequency/ad9834.c | 22 +++++++++++-----------
>  drivers/staging/iio/frequency/dds.h    |  2 +-
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index af108e9..995acdd 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -292,7 +292,7 @@ ssize_t ad9834_show_out0_wavetype_available(struct device *dev,
>  	return sprintf(buf, "%s\n", str);
>  }
>  
> -static IIO_DEVICE_ATTR(out_altvoltage0_out0_wavetype_available, S_IRUGO,
> +static IIO_DEVICE_ATTR(out_altvoltage0_out0_wavetype_available, 0444,
>  		       ad9834_show_out0_wavetype_available, NULL, 0);
>  
>  static
> @@ -312,27 +312,27 @@ ssize_t ad9834_show_out1_wavetype_available(struct device *dev,
>  	return sprintf(buf, "%s\n", str);
>  }
>  
> -static IIO_DEVICE_ATTR(out_altvoltage0_out1_wavetype_available, S_IRUGO,
> +static IIO_DEVICE_ATTR(out_altvoltage0_out1_wavetype_available, 0444,
>  		       ad9834_show_out1_wavetype_available, NULL, 0);
>  
>  /**
>   * see dds.h for further information
>   */
>  
> -static IIO_DEV_ATTR_FREQ(0, 0, S_IWUSR, NULL, ad9834_write, AD9834_REG_FREQ0);
> -static IIO_DEV_ATTR_FREQ(0, 1, S_IWUSR, NULL, ad9834_write, AD9834_REG_FREQ1);
> -static IIO_DEV_ATTR_FREQSYMBOL(0, S_IWUSR, NULL, ad9834_write, AD9834_FSEL);
> +static IIO_DEV_ATTR_FREQ(0, 0, 0200, NULL, ad9834_write, AD9834_REG_FREQ0);
> +static IIO_DEV_ATTR_FREQ(0, 1, 0200, NULL, ad9834_write, AD9834_REG_FREQ1);
> +static IIO_DEV_ATTR_FREQSYMBOL(0, 0200, NULL, ad9834_write, AD9834_FSEL);
>  static IIO_CONST_ATTR_FREQ_SCALE(0, "1"); /* 1Hz */
>  
> -static IIO_DEV_ATTR_PHASE(0, 0, S_IWUSR, NULL, ad9834_write, AD9834_REG_PHASE0);
> -static IIO_DEV_ATTR_PHASE(0, 1, S_IWUSR, NULL, ad9834_write, AD9834_REG_PHASE1);
> -static IIO_DEV_ATTR_PHASESYMBOL(0, S_IWUSR, NULL, ad9834_write, AD9834_PSEL);
> +static IIO_DEV_ATTR_PHASE(0, 0, 0200, NULL, ad9834_write, AD9834_REG_PHASE0);
> +static IIO_DEV_ATTR_PHASE(0, 1, 0200, NULL, ad9834_write, AD9834_REG_PHASE1);
> +static IIO_DEV_ATTR_PHASESYMBOL(0, 0200, NULL, ad9834_write, AD9834_PSEL);
>  static IIO_CONST_ATTR_PHASE_SCALE(0, "0.0015339808"); /* 2PI/2^12 rad*/
>  
> -static IIO_DEV_ATTR_PINCONTROL_EN(0, S_IWUSR, NULL,
> +static IIO_DEV_ATTR_PINCONTROL_EN(0, 0200, NULL,
>  	ad9834_write, AD9834_PIN_SW);
> -static IIO_DEV_ATTR_OUT_ENABLE(0, S_IWUSR, NULL, ad9834_write, AD9834_RESET);
> -static IIO_DEV_ATTR_OUTY_ENABLE(0, 1, S_IWUSR, NULL,
> +static IIO_DEV_ATTR_OUT_ENABLE(0, 0200, NULL, ad9834_write, AD9834_RESET);
> +static IIO_DEV_ATTR_OUTY_ENABLE(0, 1, 0200, NULL,
>  	ad9834_write, AD9834_OPBITEN);
>  static IIO_DEV_ATTR_OUT_WAVETYPE(0, 0, ad9834_store_wavetype, 0);
>  static IIO_DEV_ATTR_OUT_WAVETYPE(0, 1, ad9834_store_wavetype, 1);
> diff --git a/drivers/staging/iio/frequency/dds.h b/drivers/staging/iio/frequency/dds.h
> index fe53e732..d6ccd99 100644
> --- a/drivers/staging/iio/frequency/dds.h
> +++ b/drivers/staging/iio/frequency/dds.h
> @@ -101,7 +101,7 @@
>  
>  #define IIO_DEV_ATTR_OUT_WAVETYPE(_channel, _output, _store, _addr)	\
>  	IIO_DEVICE_ATTR(out_altvoltage##_channel##_out##_output##_wavetype,\
> -			S_IWUSR, NULL, _store, _addr)
> +			0200, NULL, _store, _addr)
>  
>  /**
>   * /sys/bus/iio/devices/.../out_altvoltageX_outY_wavetype_available
> 

