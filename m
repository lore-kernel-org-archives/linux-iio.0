Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751180AbdFCJnn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jun 2017 05:43:43 -0400
Date: Sat, 3 Jun 2017 10:40:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        J Keerthy <j-keerthy@ti.com>, linux-iio@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] iio: adc: twl4030: Drop struct
 twl4030_madc_user_parms
Message-ID: <20170603104047.6952807f@kernel.org>
In-Reply-To: <20170427153012.32310-6-sebastian.reichel@collabora.co.uk>
References: <20170427153012.32310-1-sebastian.reichel@collabora.co.uk>
        <20170427153012.32310-6-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 27 Apr 2017 17:30:10 +0200
Sebastian Reichel <sebastian.reichel@collabora.co.uk> wrote:

> This struct is no longer used by anything in the kernel.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to see if we have missed anything.

Jonathan
> ---
>  include/linux/i2c/twl4030-madc.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/include/linux/i2c/twl4030-madc.h b/include/linux/i2c/twl4030-madc.h
> index be9260e261ac..f395700fb933 100644
> --- a/include/linux/i2c/twl4030-madc.h
> +++ b/include/linux/i2c/twl4030-madc.h
> @@ -135,10 +135,4 @@ enum sample_type {
>  #define TWL4030_REG_GPBR1		0x0c
>  #define TWL4030_GPBR1_MADC_HFCLK_EN	(1 << 7)
>  
> -struct twl4030_madc_user_parms {
> -	int channel;
> -	int average;
> -	int status;
> -	u16 result;
> -};
>  #endif

