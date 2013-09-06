Return-Path: <jbe@pengutronix.de>
From: =?iso-8859-1?q?J=FCrgen_Beisert?= <jbe@pengutronix.de>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] iio: mxs-lradc: use helper functions to simplify the code
Date: Fri, 6 Sep 2013 09:01:01 +0200
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 Rob Herring <rob.herring@calxeda.com>,
 Marek Vasut <marex@denx.de>,
 Fabio Estevam <fabio.estevam@freescale.com>,
 linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org,
 linux-arm-kernel@lists.infradead.org
References: <20130905181639.GA19090@elgon.mountain>
In-Reply-To: <20130905181639.GA19090@elgon.mountain>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201309060901.01056.jbe@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

Hi Dan,

On Thursday 05 September 2013 20:16:39 Dan Carpenter wrote:
> I have introduced lradc_reg_set() and lradc_reg_clear().  It simplifies
> the callers and makes the lines shorter.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
> b/drivers/staging/iio/adc/mxs-lradc.c index a08c173..da5d04b 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -228,6 +228,16 @@ struct mxs_lradc {
>  #define LRADC_RESOLUTION			12
>  #define LRADC_SINGLE_SAMPLE_MASK		((1 << LRADC_RESOLUTION) - 1)
>
> +static void lradc_reg_set(struct mxs_lradc *lradc, u32 val, size_t chan)
> +{
> +	writel(val, lradc->base + chan + STMP_OFFSET_REG_SET);
> +}
> +
> +static void lradc_reg_clear(struct mxs_lradc *lradc, u32 val, size_t cha=
n)
> +{
> +	writel(val, lradc->base + chan + STMP_OFFSET_REG_CLR);
> +}
> +
>  /*
>   * Raw I/O operations
>   */
> @@ -262,21 +272,18 @@ static int mxs_lradc_read_raw(struct iio_dev
> *iio_dev, * Virtual channel 0 is always used here as the others are always
> not * used if doing raw sampling.
>  	 */
> -	writel(LRADC_CTRL1_LRADC_IRQ_EN_MASK,
> -		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
> -	writel(0xff, lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
> +	lradc_reg_clear(lradc, LRADC_CTRL1_LRADC_IRQ_EN_MASK, LRADC_CTRL1);
> +	lradc_reg_clear(lradc, 0xff, LRADC_CTRL0);

[...]

Oh, I did the same yesterday in preparation of the v2 of my patch series.
I will send this new version out today.

Regards,
Juergen

=2D-=20
Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| Juergen Beisert =A0 =A0 =A0 =A0 =A0 =A0 |
Linux Solutions for Science and Industry =A0 =A0 =A0| http://www.pengutroni=
x.de/  |
