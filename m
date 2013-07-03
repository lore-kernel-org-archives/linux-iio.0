Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35704 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932690Ab3GCTuq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jul 2013 15:50:46 -0400
Message-ID: <51D48096.5000206@kernel.org>
Date: Wed, 03 Jul 2013 20:50:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>
CC: linux-iio@vger.kernel.org, otavio@ossystems.com.br,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] iio: mxs-lradc: Fix misuse of iio->trig
References: <1372540813-12540-1-git-send-email-marex@denx.de>
In-Reply-To: <1372540813-12540-1-git-send-email-marex@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/29/2013 10:20 PM, Marek Vasut wrote:
> The struct iio_dev .trig field is to be used only by the IIO core,
> the driver shall not fill this field. This fixes ugly crash when
> the driver is compiled as a module and the module is rmmod'd.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>

I've applied this to the fixes-togreg branch of iio.git but had a bit
of fuzz, could you just santiy check that nothing went wrong please.

https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/log/?h=fixes-togreg

Thanks

Jonathan
> ---
>  drivers/staging/iio/adc/mxs-lradc.c |   11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index 55a459b..28e029a 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -664,12 +664,13 @@ static int mxs_lradc_trigger_init(struct iio_dev *iio)
>  {
>  	int ret;
>  	struct iio_trigger *trig;
> +	struct mxs_lradc *lradc = iio_priv(iio);
>  
>  	trig = iio_trigger_alloc("%s-dev%i", iio->name, iio->id);
>  	if (trig == NULL)
>  		return -ENOMEM;
>  
> -	trig->dev.parent = iio->dev.parent;
> +	trig->dev.parent = lradc->dev;
>  	trig->private_data = iio;
>  	trig->ops = &mxs_lradc_trigger_ops;
>  
> @@ -679,15 +680,17 @@ static int mxs_lradc_trigger_init(struct iio_dev *iio)
>  		return ret;
>  	}
>  
> -	iio->trig = trig;
> +	lradc->trig = trig;
>  
>  	return 0;
>  }
>  
>  static void mxs_lradc_trigger_remove(struct iio_dev *iio)
>  {
> -	iio_trigger_unregister(iio->trig);
> -	iio_trigger_free(iio->trig);
> +	struct mxs_lradc *lradc = iio_priv(iio);
> +
> +	iio_trigger_unregister(lradc->trig);
> +	iio_trigger_free(lradc->trig);
>  }
>  
>  static int mxs_lradc_buffer_preenable(struct iio_dev *iio)
> 
