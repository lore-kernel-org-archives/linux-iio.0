Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52835 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189Ab2IVJVt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 22 Sep 2012 05:21:49 -0400
Message-ID: <505D832E.5000607@kernel.org>
Date: Sat, 22 Sep 2012 10:21:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/8] staging:iio:adis16200: Do not return a error in remove
 function
References: <1348304198-5793-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1348304198-5793-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/22/2012 09:56 AM, Lars-Peter Clausen wrote:
> In the Linux device driver model the remove callback is not allowed to fail and
> the device will be removed regardless of the return value of the remove
> callback. So if we abort in the remove function and do not free all resources we
> will create a resource leak. Also all kinds of undefined behaviour are expected
> to happen since the IIO device is still there while its parent is already gone.
> 
> The error which the driver tries to handle in the remove function is
> non-critical, so we can just ignore it and continue to free all resources and
> remove the IIO device.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Added all 8 to togreg branch of iio.git.

Eariler in the cycle I'd have pushed these as fixes, but as they've been
there a long time, lets just leave it to the next cycle.

Good catch on these btw.

> ---
>  drivers/staging/iio/gyro/adis16260_core.c |   10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
> index 1d58d0e..9571c03 100644
> --- a/drivers/staging/iio/gyro/adis16260_core.c
> +++ b/drivers/staging/iio/gyro/adis16260_core.c
> @@ -702,22 +702,16 @@ error_ret:
>  
>  static int __devexit adis16260_remove(struct spi_device *spi)
>  {
> -	int ret;
>  	struct iio_dev *indio_dev = spi_get_drvdata(spi);
>  
>  	iio_device_unregister(indio_dev);
> -
> -	ret = adis16260_stop_device(indio_dev);
> -	if (ret)
> -		goto err_ret;
> -
> +	adis16260_stop_device(indio_dev);
>  	adis16260_remove_trigger(indio_dev);
>  	iio_buffer_unregister(indio_dev);
>  	adis16260_unconfigure_ring(indio_dev);
>  	iio_device_free(indio_dev);
>  
> -err_ret:
> -	return ret;
> +	return 0;
>  }
>  
>  /*
> 
