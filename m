Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: [PATCH 2/5] Staging/iio/adc/touchscreen/MXS: separate i.MX28 specific register bits
Date: Wed, 4 Sep 2013 16:06:34 +0200
Cc: linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devel@driverdev.osuosl.org,
 Fabio Estevam <fabio.estevam@freescale.com>,
 Jonathan Cameron <jic23@cam.ac.uk>
References: <1378299706-6742-1-git-send-email-jbe@pengutronix.de> <1378299706-6742-3-git-send-email-jbe@pengutronix.de>
In-Reply-To: <1378299706-6742-3-git-send-email-jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201309041606.34837.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Juergen Beisert,

> In order to support i.MX23 and i.MX28 within one driver we need to separate
> the register definitions which differ in both SoC variants.
> 
> Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> CC: linux-arm-kernel@lists.infradead.org
> CC: devel@driverdev.osuosl.org
> CC: Marek Vasut <marex@denx.de>
> CC: Fabio Estevam <fabio.estevam@freescale.com>
> CC: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/adc/mxs-lradc.c | 60
> ++++++++++++++++++++----------------- 1 file changed, 32 insertions(+), 28
> deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
> b/drivers/staging/iio/adc/mxs-lradc.c index dffca90..00e0c29 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -179,24 +179,28 @@ struct mxs_lradc {
>  };
> 
>  #define	LRADC_CTRL0				0x00
> -#define	LRADC_CTRL0_TOUCH_DETECT_ENABLE		(1 << 23)
> -#define	LRADC_CTRL0_TOUCH_SCREEN_TYPE		(1 << 22)
> -#define	LRADC_CTRL0_YNNSW	/* YM */	(1 << 21)
> -#define	LRADC_CTRL0_YPNSW	/* YP */	(1 << 20)
> -#define	LRADC_CTRL0_YPPSW	/* YP */	(1 << 19)
> -#define	LRADC_CTRL0_XNNSW	/* XM */	(1 << 18)
> -#define	LRADC_CTRL0_XNPSW	/* XM */	(1 << 17)
> -#define	LRADC_CTRL0_XPPSW	/* XP */	(1 << 16)
> -#define	LRADC_CTRL0_PLATE_MASK			(0x3f << 16)
> +# define LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE	(1 << 23)
> +# define LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE	(1 << 22)
> +# define LRADC_CTRL0_MX28_YNNSW	/* YM */	(1 << 21)
> +# define LRADC_CTRL0_MX28_YPNSW	/* YP */	(1 << 20)
> +# define LRADC_CTRL0_MX28_YPPSW	/* YP */	(1 << 19)
> +# define LRADC_CTRL0_MX28_XNNSW	/* XM */	(1 << 18)
> +# define LRADC_CTRL0_MX28_XNPSW	/* XM */	(1 << 17)
> +# define LRADC_CTRL0_MX28_XPPSW	/* XP */	(1 << 16)

Why do you put this space between # and define?

> +#define	LRADC_CTRL0_MX28_PLATE_MASK \
> +		LRADC_CTRL0_MX28_YNNSW | LRADC_CTRL0_MX28_YPNSW | \
> +		LRADC_CTRL0_MX28_YPPSW | LRADC_CTRL0_MX28_XNNSW | \
> +		LRADC_CTRL0_MX28_XNPSW | LRADC_CTRL0_MX28_XPPSW
> 
>  #define	LRADC_CTRL1				0x10
>  #define	LRADC_CTRL1_TOUCH_DETECT_IRQ_EN		(1 << 24)
>  #define	LRADC_CTRL1_LRADC_IRQ_EN(n)		(1 << ((n) + 16))
> -#define	LRADC_CTRL1_LRADC_IRQ_EN_MASK		(0x1fff << 16)
> +#define	LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK	(0x1fff << 16)
>  #define	LRADC_CTRL1_LRADC_IRQ_EN_OFFSET		16
>  #define	LRADC_CTRL1_TOUCH_DETECT_IRQ		(1 << 8)
>  #define	LRADC_CTRL1_LRADC_IRQ(n)		(1 << (n))
> -#define	LRADC_CTRL1_LRADC_IRQ_MASK		0x1fff
> +#define	LRADC_CTRL1_MX28_LRADC_IRQ_MASK		0x1fff

MIght just be easier to define this as

LRADC....IRQ_MASK(id) (((id) == MX23) ? 0x1ff : 0x1fff)

just like the MXS SSP driver does it. Then there won't be so much churn.

[...]

Best regards,
Marek Vasut
