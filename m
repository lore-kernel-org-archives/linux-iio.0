Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35687 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754709Ab3JXMvC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Oct 2013 08:51:02 -0400
Message-ID: <526925F2.9090506@kernel.org>
Date: Thu, 24 Oct 2013 14:51:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 6/9] iio: dac: ad5755: Remove redundant code
References: <1382615615-20153-1-git-send-email-sachin.kamat@linaro.org> <1382615615-20153-6-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1382615615-20153-6-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/24/13 12:53, Sachin Kamat wrote:
> The if check is redundant as the value obtained from
> iio_device_register() is already in the required format.
> Error messages are already printed by iio_device_register();
> hence not needed.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/dac/ad5755.c |    8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
> index bd31dbc..9a78d5a 100644
> --- a/drivers/iio/dac/ad5755.c
> +++ b/drivers/iio/dac/ad5755.c
> @@ -589,13 +589,7 @@ static int ad5755_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> -	ret = iio_device_register(indio_dev);
> -	if (ret) {
> -		dev_err(&spi->dev, "Failed to register iio device: %d\n", ret);
> -		return ret;
> -	}
> -
> -	return 0;
> +	return iio_device_register(indio_dev);
>  }
>  
>  static int ad5755_remove(struct spi_device *spi)
> 
