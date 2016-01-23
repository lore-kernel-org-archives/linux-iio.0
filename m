Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40354 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472AbcAWQRX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Jan 2016 11:17:23 -0500
Subject: Re: [PATCH 2/2] iio:adc:at91-sama5d2: code cleanup
To: Ludovic Desroches <ludovic.desroches@atmel.com>,
	nicolas.ferre@atmel.com
References: <1453106516-17935-1-git-send-email-ludovic.desroches@atmel.com>
 <1453106516-17935-2-git-send-email-ludovic.desroches@atmel.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56A3A792.2000901@kernel.org>
Date: Sat, 23 Jan 2016 16:17:22 +0000
MIME-Version: 1.0
In-Reply-To: <1453106516-17935-2-git-send-email-ludovic.desroches@atmel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/01/16 08:41, Ludovic Desroches wrote:
> Use var type for sizeof argument instead of the struct name.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Applied, thanks.

Jonathan
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index f2d8bd5..dbee13a 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -353,8 +353,7 @@ static int at91_adc_probe(struct platform_device *pdev)
>  	struct resource	*res;
>  	int ret;
>  
> -	indio_dev = devm_iio_device_alloc(&pdev->dev,
> -					  sizeof(struct at91_adc_state));
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*st));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> 

