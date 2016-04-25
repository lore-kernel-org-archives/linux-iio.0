Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33839 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964911AbcDYVAp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Apr 2016 17:00:45 -0400
Date: Mon, 25 Apr 2016 14:00:41 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Marek Vasut <marex@denx.de>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Juergen Borleis <jbe@pengutronix.de>,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V3 2/3] iio: mxs-lradc: remove mxs_lradc_ts_unregister
Message-ID: <20160425210041.GB26059@dtor-ws>
References: <1461441479-23218-1-git-send-email-stefan.wahren@i2se.com>
 <1461441479-23218-3-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461441479-23218-3-git-send-email-stefan.wahren@i2se.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Apr 23, 2016 at 07:57:58PM +0000, Stefan Wahren wrote:
> After using devm_input_allocate_device for registration
> the function mxs_lradc_ts_unregister isn't necessary anymore
> since mxs_lradc_ts_close already does the job.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/iio/adc/mxs-lradc.c |   13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
> index 3d1d370..90242ba 100644
> --- a/drivers/iio/adc/mxs-lradc.c
> +++ b/drivers/iio/adc/mxs-lradc.c
> @@ -1148,14 +1148,6 @@ static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
>  	return input_register_device(input);
>  }
>  
> -static void mxs_lradc_ts_unregister(struct mxs_lradc *lradc)
> -{
> -	if (!lradc->use_touchscreen)
> -		return;
> -
> -	mxs_lradc_disable_ts(lradc);
> -}
> -
>  /*
>   * IRQ Handling
>   */
> @@ -1715,13 +1707,11 @@ static int mxs_lradc_probe(struct platform_device *pdev)
>  	ret = iio_device_register(iio);
>  	if (ret) {
>  		dev_err(dev, "Failed to register IIO device\n");
> -		goto err_ts;
> +		return ret;
>  	}
>  
>  	return 0;
>  
> -err_ts:
> -	mxs_lradc_ts_unregister(lradc);
>  err_ts_register:
>  	mxs_lradc_hw_stop(lradc);
>  err_dev:
> @@ -1739,7 +1729,6 @@ static int mxs_lradc_remove(struct platform_device *pdev)
>  	struct mxs_lradc *lradc = iio_priv(iio);
>  
>  	iio_device_unregister(iio);
> -	mxs_lradc_ts_unregister(lradc);
>  	mxs_lradc_hw_stop(lradc);
>  	mxs_lradc_trigger_remove(iio);
>  	iio_triggered_buffer_cleanup(iio);
> -- 
> 1.7.9.5
> 

-- 
Dmitry
