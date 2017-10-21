Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932179AbdJURml (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Oct 2017 13:42:41 -0400
Date: Sat, 21 Oct 2017 18:42:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 10/13] staging: iio: tsl2x7x: rename power defines to
 improve code readability
Message-ID: <20171021184236.02bb778d@archlinux>
In-Reply-To: <20171019200632.25820-11-masneyb@onstation.org>
References: <20171019200632.25820-1-masneyb@onstation.org>
        <20171019200632.25820-11-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 19 Oct 2017 16:06:29 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The LED power defines are named like TSL2X7X_mAXXX. Rename these values
> to TSL2X7X_XXX_mA to improve code readability.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied
> ---
>  drivers/staging/iio/light/tsl2x7x.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 70007117d985..bb9fb60509cf 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -114,10 +114,10 @@
>  #define TSL2X7X_DIODE_BOTH		0x30
>  
>  /* LED Power */
> -#define TSL2X7X_mA100			0x00
> -#define TSL2X7X_mA50			0x40
> -#define TSL2X7X_mA25			0x80
> -#define TSL2X7X_mA13			0xD0
> +#define TSL2X7X_100_mA			0x00
> +#define TSL2X7X_50_mA			0x40
> +#define TSL2X7X_25_mA			0x80
> +#define TSL2X7X_13_mA			0xD0
>  #define TSL2X7X_MAX_TIMER_CNT		0xFF
>  
>  #define TSL2X7X_MIN_ITIME		3
> @@ -636,7 +636,7 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  	/* Set the gain based on tsl2x7x_settings struct */
>  	chip->tsl2x7x_config[TSL2X7X_GAIN] =
>  		chip->settings.als_gain |
> -			(TSL2X7X_mA100 | TSL2X7X_DIODE1) |
> +			(TSL2X7X_100_mA | TSL2X7X_DIODE1) |
>  			(chip->settings.prox_gain << 2);
>  
>  	/* set chip struct re scaling and saturation */

