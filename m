Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41559 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814Ab3I1Jty (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Sep 2013 05:49:54 -0400
Message-ID: <5246B46B.9040106@kernel.org>
Date: Sat, 28 Sep 2013 11:50:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: amplifiers: ad8366: Remove regulator_put
References: <1380023350-25116-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380023350-25116-1-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/24/13 12:49, Sachin Kamat wrote:
> Since devm_regulator_get is used, regulator_put should not be
> used. Remove it.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied to the fixes-togreg branch of iio.git

Thanks
> ---
>  drivers/iio/amplifiers/ad8366.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
> index d0a79a4..ba6f6a9 100644
> --- a/drivers/iio/amplifiers/ad8366.c
> +++ b/drivers/iio/amplifiers/ad8366.c
> @@ -185,10 +185,8 @@ static int ad8366_remove(struct spi_device *spi)
>  
>  	iio_device_unregister(indio_dev);
>  
> -	if (!IS_ERR(reg)) {
> +	if (!IS_ERR(reg))
>  		regulator_disable(reg);
> -		regulator_put(reg);
> -	}
>  
>  	return 0;
>  }
> 
