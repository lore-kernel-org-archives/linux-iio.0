Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37897 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449Ab3IHN3U (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Sep 2013 09:29:20 -0400
Message-ID: <522C89C7.1010106@kernel.org>
Date: Sun, 08 Sep 2013 15:29:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Fabio Estevam <festevam@gmail.com>
CC: jic23@cam.ac.uk, marex@denx.de, linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH 1/2] iio: mxs-lradc: Fix the order of resources removal
References: <1378169292-29899-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1378169292-29899-1-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/03/13 01:48, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Fix the order of resources removal in the error path of mxs_lradc_probe()
> and also in mxs_lradc_remove().
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
I 'think' this bug could cause actual trouble but I'll assume it is relatively unlikely
and have applied this to the togreg branch of iio.git (won't apply to the current fixes
branch).

Anyhow, applied to the togreg branch of iio.git

> ---
>  drivers/staging/iio/adc/mxs-lradc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index a08c173..75f5aac 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -987,7 +987,7 @@ static int mxs_lradc_probe(struct platform_device *pdev)
>  	/* Register the touchscreen input device. */
>  	ret = mxs_lradc_ts_register(lradc);
>  	if (ret)
> -		goto err_dev;
> +		goto err_ts_register;
>  
>  	/* Register IIO device. */
>  	ret = iio_device_register(iio);
> @@ -1000,6 +1000,8 @@ static int mxs_lradc_probe(struct platform_device *pdev)
>  
>  err_ts:
>  	mxs_lradc_ts_unregister(lradc);
> +err_ts_register:
> +	mxs_lradc_hw_stop(lradc);
>  err_dev:
>  	mxs_lradc_trigger_remove(iio);
>  err_trig:
> @@ -1012,13 +1014,11 @@ static int mxs_lradc_remove(struct platform_device *pdev)
>  	struct iio_dev *iio = platform_get_drvdata(pdev);
>  	struct mxs_lradc *lradc = iio_priv(iio);
>  
> +	iio_device_unregister(iio);
>  	mxs_lradc_ts_unregister(lradc);
> -
>  	mxs_lradc_hw_stop(lradc);
> -
> -	iio_device_unregister(iio);
> -	iio_triggered_buffer_cleanup(iio);
>  	mxs_lradc_trigger_remove(iio);
> +	iio_triggered_buffer_cleanup(iio);
>  
>  	return 0;
>  }
> 
