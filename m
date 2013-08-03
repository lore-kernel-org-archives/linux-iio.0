Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38290 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450Ab3HCQyr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 Aug 2013 12:54:47 -0400
Message-ID: <51FD43EF.30001@kernel.org>
Date: Sat, 03 Aug 2013 18:54:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, jic23@cam.ac.uk,
	Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH 5/6] iio: light: lm3533-als: Use devm_iio_device_alloc
References: <1375173868-13235-1-git-send-email-sachin.kamat@linaro.org> <1375173868-13235-5-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1375173868-13235-5-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/30/13 09:44, Sachin Kamat wrote:
> Using devm_iio_device_alloc makes code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Johan Hovold <jhovold@gmail.com>
Applied to the togreg branch of iio.git

> ---
>  drivers/iio/light/lm3533-als.c |    7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
> index 5fa31a4..c1aadc6 100644
> --- a/drivers/iio/light/lm3533-als.c
> +++ b/drivers/iio/light/lm3533-als.c
> @@ -847,7 +847,7 @@ static int lm3533_als_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	indio_dev = iio_device_alloc(sizeof(*als));
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*als));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> @@ -870,7 +870,7 @@ static int lm3533_als_probe(struct platform_device *pdev)
>  	if (als->irq) {
>  		ret = lm3533_als_setup_irq(als, indio_dev);
>  		if (ret)
> -			goto err_free_dev;
> +			return ret;
>  	}
>  
>  	ret = lm3533_als_setup(als, pdata);
> @@ -894,8 +894,6 @@ err_disable:
>  err_free_irq:
>  	if (als->irq)
>  		free_irq(als->irq, indio_dev);
> -err_free_dev:
> -	iio_device_free(indio_dev);
>  
>  	return ret;
>  }
> @@ -910,7 +908,6 @@ static int lm3533_als_remove(struct platform_device *pdev)
>  	lm3533_als_disable(als);
>  	if (als->irq)
>  		free_irq(als->irq, indio_dev);
> -	iio_device_free(indio_dev);
>  
>  	return 0;
>  }
> 
