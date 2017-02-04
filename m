Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36001 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751033AbdBDVLh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Feb 2017 16:11:37 -0500
Subject: Re: [PATCH] iio: adc: handle unknow of_device_id data
To: Arnd Bergmann <arnd@arndb.de>, Jonathan Cameron <jic23@kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>
References: <20170203193756.3848151-1-arnd@arndb.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <d38423fb-2759-4774-1ead-86176908d4b0@gmail.com>
Date: Sat, 4 Feb 2017 22:11:32 +0100
MIME-Version: 1.0
In-Reply-To: <20170203193756.3848151-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/03/2017 06:01 PM, Arnd Bergmann wrote:
> If we get an unknown 'childmode' value, a number of variables are not
> initialized properly:
> 
> drivers/iio/adc/rcar-gyroadc.c: In function 'rcar_gyroadc_probe':
> drivers/iio/adc/rcar-gyroadc.c:390:5: error: 'num_channels' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> drivers/iio/adc/rcar-gyroadc.c:426:22: error: 'sample_width' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> drivers/iio/adc/rcar-gyroadc.c:428:23: error: 'channels' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> The driver is currently correct, but handling this properly is more robust
> for possible modifications.

Yeah, the OF match will make sure this case is never triggered.
But then again, it triggers kernel ci, so it should be fixed.
Thanks for the patch :)

> There is also a false-positive warning about adcmode being possibly uninitialized,
> but that cannot happen as we also check the 'first' flag:
> 
> drivers/iio/adc/rcar-gyroadc.c:398:26: error: 'adcmode' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> This adds an initialization for 'adcmode' and bails out for any unknown childmode.
> 
> Fixes: 059c53b32329 ("iio: adc: Add Renesas GyroADC driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/iio/adc/rcar-gyroadc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
> index 0c44f72c32a8..331ff9a673be 100644
> --- a/drivers/iio/adc/rcar-gyroadc.c
> +++ b/drivers/iio/adc/rcar-gyroadc.c
> @@ -336,7 +336,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
>  	struct device_node *child;
>  	struct regulator *vref;
>  	unsigned int reg;
> -	unsigned int adcmode, childmode;
> +	unsigned int adcmode = -1, childmode;
>  	unsigned int sample_width;
>  	unsigned int num_channels;
>  	int ret, first = 1;
> @@ -366,6 +366,9 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
>  			channels = rcar_gyroadc_iio_channels_3;
>  			num_channels = ARRAY_SIZE(rcar_gyroadc_iio_channels_3);
>  			break;
> +		default:
> +			dev_err(dev, "unknown device type");

Is this verbose output really needed ?

> +			return -EINVAL;
>  		}
>  
>  		/*
> 


-- 
Best regards,
Marek Vasut
