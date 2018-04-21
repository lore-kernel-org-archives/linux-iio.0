Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752881AbeDUQdK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Apr 2018 12:33:10 -0400
Date: Sat, 21 Apr 2018 17:33:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 09/13] staging: iio: tsl2x7x: move power and diode
 settings into header file
Message-ID: <20180421173305.3ae125a2@archlinux>
In-Reply-To: <20180421004153.19073-10-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
        <20180421004153.19073-10-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 20 Apr 2018 20:41:49 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The power and diode defines are needed for the platform data so this
> patch moves the defines out of the .c file and into the header file. A
> comment for the diode is also cleaned up while this code is touched.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Makes sense.

Applied,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 12 ------------
>  drivers/staging/iio/light/tsl2x7x.h | 12 ++++++++++++
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 15bc0af1bb6c..87b99deef7a8 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -103,18 +103,6 @@
>  #define TSL2X7X_CNTL_PROXPON_ENBL	0x0F
>  #define TSL2X7X_CNTL_INTPROXPON_ENBL	0x2F
>  
> -/*Prox diode to use */
> -#define TSL2X7X_DIODE0			0x01
> -#define TSL2X7X_DIODE1			0x02
> -#define TSL2X7X_DIODE_BOTH		0x03
> -
> -/* LED Power */
> -#define TSL2X7X_100_mA			0x00
> -#define TSL2X7X_50_mA			0x01
> -#define TSL2X7X_25_mA			0x02
> -#define TSL2X7X_13_mA			0x03
> -#define TSL2X7X_MAX_TIMER_CNT		0xFF
> -
>  #define TSL2X7X_MIN_ITIME		3
>  
>  /* TAOS txx2x7x Device family members */
> diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
> index 992ee2465609..2c96f0b39b1e 100644
> --- a/drivers/staging/iio/light/tsl2x7x.h
> +++ b/drivers/staging/iio/light/tsl2x7x.h
> @@ -23,6 +23,18 @@ struct tsl2x7x_lux {
>  #define TSL2X7X_DEFAULT_TABLE_BYTES (sizeof(struct tsl2x7x_lux) * \
>  				     TSL2X7X_DEF_LUX_TABLE_SZ)
>  
> +/* Proximity diode to use */
> +#define TSL2X7X_DIODE0                  0x01
> +#define TSL2X7X_DIODE1                  0x02
> +#define TSL2X7X_DIODE_BOTH              0x03
> +
> +/* LED Power */
> +#define TSL2X7X_100_mA                  0x00
> +#define TSL2X7X_50_mA                   0x01
> +#define TSL2X7X_25_mA                   0x02
> +#define TSL2X7X_13_mA                   0x03
> +#define TSL2X7X_MAX_TIMER_CNT           0xFF
> +
>  /**
>   * struct tsl2x7x_default_settings - power on defaults unless
>   *                                   overridden by platform data.

