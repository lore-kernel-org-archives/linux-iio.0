Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39746 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362Ab3INJ4g (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Sep 2013 05:56:36 -0400
Message-ID: <523440F2.4050004@kernel.org>
Date: Sat, 14 Sep 2013 11:56:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 08/10] staging: iio: ade7758_core: Use devm_iio_device_alloc
References: <1378893325-31764-1-git-send-email-sachin.kamat@linaro.org> <1378893325-31764-8-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378893325-31764-8-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/11/13 10:55, Sachin Kamat wrote:
> devm_iio_device_alloc makes code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Barry Song <21cnbao@gmail.com>
Applied to the togreg branch of iio.git
> ---
>  drivers/staging/iio/meter/ade7758_core.c |   20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
> index 6a62751..cba183e 100644
> --- a/drivers/staging/iio/meter/ade7758_core.c
> +++ b/drivers/staging/iio/meter/ade7758_core.c
> @@ -849,12 +849,11 @@ static int ade7758_probe(struct spi_device *spi)
>  {
>  	int ret;
>  	struct ade7758_state *st;
> -	struct iio_dev *indio_dev = iio_device_alloc(sizeof(*st));
> +	struct iio_dev *indio_dev;
>  
> -	if (indio_dev == NULL) {
> -		ret = -ENOMEM;
> -		goto error_ret;
> -	}
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
>  	/* this is only used for removal purposes */
> @@ -862,10 +861,8 @@ static int ade7758_probe(struct spi_device *spi)
>  
>  	/* Allocate the comms buffers */
>  	st->rx = kcalloc(ADE7758_MAX_RX, sizeof(*st->rx), GFP_KERNEL);
> -	if (st->rx == NULL) {
> -		ret = -ENOMEM;
> -		goto error_free_dev;
> -	}
> +	if (!st->rx)
> +		return -ENOMEM;
>  	st->tx = kcalloc(ADE7758_MAX_TX, sizeof(*st->tx), GFP_KERNEL);
>  	if (st->tx == NULL) {
>  		ret = -ENOMEM;
> @@ -920,9 +917,6 @@ error_free_tx:
>  	kfree(st->tx);
>  error_free_rx:
>  	kfree(st->rx);
> -error_free_dev:
> -	iio_device_free(indio_dev);
> -error_ret:
>  	return ret;
>  }
>  
> @@ -939,8 +933,6 @@ static int ade7758_remove(struct spi_device *spi)
>  	kfree(st->tx);
>  	kfree(st->rx);
>  
> -	iio_device_free(indio_dev);
> -
>  	return 0;
>  }
>  
> 
