Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39388 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701Ab3INJ1z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Sep 2013 05:27:55 -0400
Message-ID: <52343A33.9090703@kernel.org>
Date: Sat, 14 Sep 2013 11:28:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 1/1] staging: iio: ade7854-spi: Fix return value
References: <1378891978-3819-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378891978-3819-1-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/11/13 10:32, Sachin Kamat wrote:
> ade7854_probe can fail. Return the value obtained from it
> instead of 0 (success).
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Barry Song <21cnbao@gmail.com>
Applied to the the fixes-togreg branch of iio.git

Thanks
> ---
>  drivers/staging/iio/meter/ade7854-spi.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
> index a802cf2..4c6d204 100644
> --- a/drivers/staging/iio/meter/ade7854-spi.c
> +++ b/drivers/staging/iio/meter/ade7854-spi.c
> @@ -299,7 +299,7 @@ static int ade7854_spi_probe(struct spi_device *spi)
>  	if (ret)
>  		iio_device_free(indio_dev);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int ade7854_spi_remove(struct spi_device *spi)
> 
