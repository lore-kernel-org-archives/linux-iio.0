Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58641 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755517Ab3KWRFO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Nov 2013 12:05:14 -0500
Message-ID: <5290EE9F.8090608@kernel.org>
Date: Sat, 23 Nov 2013 18:06:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
CC: lars@metafoo.de
Subject: Re: [PATCH 16/33] staging: iio: lpc32xx_adc: Use devm_iio_device_register
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org> <1383046796-329-17-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-17-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/13 11:39, Sachin Kamat wrote:
> devm_iio_device_register simplifies the code.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/staging/iio/adc/lpc32xx_adc.c |   12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/lpc32xx_adc.c b/drivers/staging/iio/adc/lpc32xx_adc.c
> index ef0a21d..a876ce7 100644
> --- a/drivers/staging/iio/adc/lpc32xx_adc.c
> +++ b/drivers/staging/iio/adc/lpc32xx_adc.c
> @@ -183,7 +183,7 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
>  	iodev->channels = lpc32xx_adc_iio_channels;
>  	iodev->num_channels = ARRAY_SIZE(lpc32xx_adc_iio_channels);
>  
> -	retval = iio_device_register(iodev);
> +	retval = devm_iio_device_register(&pdev->dev, iodev);
>  	if (retval)
>  		return retval;
>  
> @@ -192,15 +192,6 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int lpc32xx_adc_remove(struct platform_device *pdev)
> -{
> -	struct iio_dev *iodev = platform_get_drvdata(pdev);
> -
> -	iio_device_unregister(iodev);
> -
> -	return 0;
> -}
> -
>  #ifdef CONFIG_OF
>  static const struct of_device_id lpc32xx_adc_match[] = {
>  	{ .compatible = "nxp,lpc3220-adc" },
> @@ -211,7 +202,6 @@ MODULE_DEVICE_TABLE(of, lpc32xx_adc_match);
>  
>  static struct platform_driver lpc32xx_adc_driver = {
>  	.probe		= lpc32xx_adc_probe,
> -	.remove		= lpc32xx_adc_remove,
>  	.driver		= {
>  		.name	= MOD_NAME,
>  		.owner	= THIS_MODULE,
> 
