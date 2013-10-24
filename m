Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35671 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754339Ab3JXMua (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Oct 2013 08:50:30 -0400
Message-ID: <526925D2.3050207@kernel.org>
Date: Thu, 24 Oct 2013 14:51:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 5/9] iio: dac: ad5421: Remove redundant code
References: <1382615615-20153-1-git-send-email-sachin.kamat@linaro.org> <1382615615-20153-5-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1382615615-20153-5-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/24/13 12:53, Sachin Kamat wrote:
> The if check is redundant as the value obtained from
> iio_device_register() is already in the required format.
> Hence return the function directly. Error messages are already
> printed by iio_device_register(); hence not needed.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Technically changing a dmesg output is userspace abi, but I doubt anyone
actually cares so dropping it is fine  (anyone who does should shout and we'll
put it back!)

Hence Applied to the togreg branch of iio.git

> ---
>  drivers/iio/dac/ad5421.c |    8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5421.c b/drivers/iio/dac/ad5421.c
> index c44afeb..3eeaa82 100644
> --- a/drivers/iio/dac/ad5421.c
> +++ b/drivers/iio/dac/ad5421.c
> @@ -514,13 +514,7 @@ static int ad5421_probe(struct spi_device *spi)
>  			return ret;
>  	}
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
>  static int ad5421_remove(struct spi_device *spi)
> 
