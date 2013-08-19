Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53242 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052Ab3HSSdN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Aug 2013 14:33:13 -0400
Message-ID: <521272FA.8050904@kernel.org>
Date: Mon, 19 Aug 2013 20:33:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, lars@metafoo.de, jic23@cam.ac.uk
Subject: Re: [PATCH 10/14] iio: dac: ad5755: Use devm_iio_device_alloc
References: <1376912305-6423-1-git-send-email-sachin.kamat@linaro.org> <1376912305-6423-10-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1376912305-6423-10-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/19/13 12:38, Sachin Kamat wrote:
> Using devm_iio_device_alloc makes code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
I made an ever so tiny mod in this one before applying.
Don't like the removal of the white space before the return
in the remove function.  Guessing you didn't mean to do that.

Applied to the togreg branch of iio.git.

Jonathan
> ---
>  drivers/iio/dac/ad5755.c |   15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
> index 12bb315..124d53b 100644
> --- a/drivers/iio/dac/ad5755.c
> +++ b/drivers/iio/dac/ad5755.c
> @@ -565,7 +565,7 @@ static int ad5755_probe(struct spi_device *spi)
>  	struct ad5755_state *st;
>  	int ret;
>  
> -	indio_dev = iio_device_alloc(sizeof(*st));
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (indio_dev == NULL) {
>  		dev_err(&spi->dev, "Failed to allocate iio device\n");
>  		return  -ENOMEM;
> @@ -589,24 +589,19 @@ static int ad5755_probe(struct spi_device *spi)
>  
>  	ret = ad5755_init_channels(indio_dev, pdata);
>  	if (ret)
> -		goto error_free;
> +		return ret;
>  
>  	ret = ad5755_setup_pdata(indio_dev, pdata);
>  	if (ret)
> -		goto error_free;
> +		return ret;
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret) {
>  		dev_err(&spi->dev, "Failed to register iio device: %d\n", ret);
> -		goto error_free;
> +		return ret;
>  	}
>  
>  	return 0;
> -
> -error_free:
> -	iio_device_free(indio_dev);
> -
> -	return ret;
>  }
>  
>  static int ad5755_remove(struct spi_device *spi)
> @@ -614,8 +609,6 @@ static int ad5755_remove(struct spi_device *spi)
>  	struct iio_dev *indio_dev = spi_get_drvdata(spi);
>  
>  	iio_device_unregister(indio_dev);
> -	iio_device_free(indio_dev);
> -
>  	return 0;
>  }
>  
> 
