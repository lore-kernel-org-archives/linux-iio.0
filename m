Return-Path: <festevam@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20130905181639.GA19090@elgon.mountain>
References: <201309051216.18305.jbe@pengutronix.de>
	<20130905181639.GA19090@elgon.mountain>
Date: Thu, 5 Sep 2013 17:15:02 -0300
Message-ID: <CAOMZO5BmeG3X+cyNcwg0B7hsaqTY5hxjfNiWbxMivinhcZZp7g@mail.gmail.com>
Subject: Re: [patch] iio: mxs-lradc: use helper functions to simplify the code
From: Fabio Estevam <festevam@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, =?UTF-8?Q?J=C3=BCrgen_Beisert?= <jbe@pengutronix.de>,
	Marek Vasut <marex@denx.de>, devel@driverdev.osuosl.org,
	Fabio Estevam <fabio.estevam@freescale.com>, linux-iio@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <rob.herring@calxeda.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, Sep 5, 2013 at 3:16 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> I have introduced lradc_reg_set() and lradc_reg_clear().  It simplifies
> the callers and makes the lines shorter.

Looks good, just one minor suggestion:

> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index a08c173..da5d04b 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -228,6 +228,16 @@ struct mxs_lradc {
>  #define LRADC_RESOLUTION                       12
>  #define LRADC_SINGLE_SAMPLE_MASK               ((1 << LRADC_RESOLUTION) - 1)
>
> +static void lradc_reg_set(struct mxs_lradc *lradc, u32 val, size_t chan)
> +{
> +       writel(val, lradc->base + chan + STMP_OFFSET_REG_SET);
> +}
> +
> +static void lradc_reg_clear(struct mxs_lradc *lradc, u32 val, size_t chan)
> +{
> +       writel(val, lradc->base + chan + STMP_OFFSET_REG_CLR);
> +}

Maybe 'static inline' ?
