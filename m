Return-Path: <festevam@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1354893893-26338-1-git-send-email-marex@denx.de>
References: <1354893893-26338-1-git-send-email-marex@denx.de>
Date: Sat, 8 Dec 2012 17:39:02 -0200
Message-ID: <CAOMZO5B37U=c08=2-m8aCxDwJ1tBDyD37kwc+NivEGPU+37OeQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] iio: mxs: Remove unused struct mxs_lradc_chan
From: Fabio Estevam <festevam@gmail.com>
To: Marek Vasut <marex@denx.de>
Cc: linux-iio@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>,
	Shawn Guo <shawn.guo@linaro.org>, Jonathan Cameron <jic23@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Marek,

On Fri, Dec 7, 2012 at 1:24 PM, Marek Vasut <marex@denx.de> wrote:
> This structure definition seems to be some kind of remnant from
> previous development that accidentally made it mainline. Remove
> it as it's unused.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/staging/iio/adc/mxs-lradc.c |    5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index ca7c1fa..67abf50 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -75,11 +75,6 @@ static const char * const mxs_lradc_irq_name[] = {
>         "mxs-lradc-button1",
>  };
>
> -struct mxs_lradc_chan {
> -       uint8_t                         slot;
> -       uint8_t                         flags;
> -};
> -
>  struct mxs_lradc {
>         struct device           *dev;
>         void __iomem            *base;

Can you combine patches 1 and 2 into a single patch?

Thanks for working on this. I will test the series next week on my mx28evk.

Regards,

Fabio Estevam
