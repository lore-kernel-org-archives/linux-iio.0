Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57738 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbaJDLes (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 4 Oct 2014 07:34:48 -0400
Message-ID: <542FDB57.9020308@kernel.org>
Date: Sat, 04 Oct 2014 12:34:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Fabio Estevam <festevam@gmail.com>
CC: B38611@freescale.com, linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH 5/5] iio: adc: vf610: Remove CONFIG_PM_SLEEP ifdef's
References: <1412299526-1331-1-git-send-email-festevam@gmail.com> <1412299526-1331-5-git-send-email-festevam@gmail.com>
In-Reply-To: <1412299526-1331-5-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/10/14 02:25, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Mark the suspend/resume functions as '__maybe_unused' so that we can get rid
> of the CONFIG_PM_SLEEP ifdef.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
This is always debatable.  Personally my view is that it's actually
slightly clearer what is going on with the ifdef than the maybe_unused
so my gut feeling is to leave it alone.  Now if we get strong sentiments
the other way I might change my mind!


> ---
>  drivers/iio/adc/vf610_adc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> index 6164558..bae9638 100644
> --- a/drivers/iio/adc/vf610_adc.c
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -650,8 +650,7 @@ static int vf610_adc_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int vf610_adc_suspend(struct device *dev)
> +static int __maybe_unused vf610_adc_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct vf610_adc *info = iio_priv(indio_dev);
> @@ -668,7 +667,7 @@ static int vf610_adc_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int vf610_adc_resume(struct device *dev)
> +static int __maybe_unused vf610_adc_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct vf610_adc *info = iio_priv(indio_dev);
> @@ -690,7 +689,6 @@ disable_reg:
>  	regulator_disable(info->vref);
>  	return ret;
>  }
> -#endif
>  
>  static SIMPLE_DEV_PM_OPS(vf610_adc_pm_ops, vf610_adc_suspend, vf610_adc_resume);
>  
> 
