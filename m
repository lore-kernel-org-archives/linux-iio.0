Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from antcom.de ([188.40.178.216]:38683 "EHLO chuck.antcom.de"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750733Ab3FFPR6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 6 Jun 2013 11:17:58 -0400
Message-ID: <51B0A668.3060905@antcom.de>
Date: Thu, 06 Jun 2013 17:10:32 +0200
From: Roland Stigge <stigge@antcom.de>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: devel@driverdev.osuosl.org, linux-iio@vger.kernel.org,
	gregkh@linuxfoundation.org, jic23@cam.ac.uk
Subject: Re: [PATCH 3/3] staging: iio: lpc32xx_adc: Remove redundant platform_set_drvdata()
References: <1370510844-23603-1-git-send-email-sachin.kamat@linaro.org> <1370510844-23603-3-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1370510844-23603-3-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/06/2013 11:27 AM, Sachin Kamat wrote:
> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Roland Stigge <stigge@antcom.de>

Tested-by: Roland Stigge <stigge@antcom.de>
Acked-by: Roland Stigge <stigge@antcom.de>

Thanks!

> ---
>  drivers/staging/iio/adc/lpc32xx_adc.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/lpc32xx_adc.c b/drivers/staging/iio/adc/lpc32xx_adc.c
> index 2f2f7fd..9a4bb09 100644
> --- a/drivers/staging/iio/adc/lpc32xx_adc.c
> +++ b/drivers/staging/iio/adc/lpc32xx_adc.c
> @@ -215,7 +215,6 @@ static int lpc32xx_adc_remove(struct platform_device *pdev)
>  
>  	iio_device_unregister(iodev);
>  	free_irq(irq, info);
> -	platform_set_drvdata(pdev, NULL);
>  	clk_put(info->clk);
>  	iounmap(info->adc_base);
>  	iio_device_free(iodev);

