Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39167 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640Ab3HCTAG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 Aug 2013 15:00:06 -0400
Message-ID: <51FD6147.5090101@kernel.org>
Date: Sat, 03 Aug 2013 21:00:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, jic23@cam.ac.uk,
	Michael Hennerich <hennerich@blackfin.uclinux.org>
Subject: Re: [PATCH 1/3] iio: amplifiers: ad8366: Use devm_* APIs
References: <1375165463-23453-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1375165463-23453-1-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/30/13 07:24, Sachin Kamat wrote:
> devm_* APIs are device managed and make code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Michael Hennerich <hennerich@blackfin.uclinux.org>
Applied to the togreg branch of iio.git

Thanks.
> ---
> This series compile tested on togreg branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
> ---
>  drivers/iio/amplifiers/ad8366.c |   13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
> index d354554..d0a79a4 100644
> --- a/drivers/iio/amplifiers/ad8366.c
> +++ b/drivers/iio/amplifiers/ad8366.c
> @@ -139,17 +139,17 @@ static int ad8366_probe(struct spi_device *spi)
>  	struct ad8366_state *st;
>  	int ret;
>  
> -	indio_dev = iio_device_alloc(sizeof(*st));
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (indio_dev == NULL)
>  		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
>  
> -	st->reg = regulator_get(&spi->dev, "vcc");
> +	st->reg = devm_regulator_get(&spi->dev, "vcc");
>  	if (!IS_ERR(st->reg)) {
>  		ret = regulator_enable(st->reg);
>  		if (ret)
> -			goto error_put_reg;
> +			return ret;
>  	}
>  
>  	spi_set_drvdata(spi, indio_dev);
> @@ -173,11 +173,6 @@ static int ad8366_probe(struct spi_device *spi)
>  error_disable_reg:
>  	if (!IS_ERR(st->reg))
>  		regulator_disable(st->reg);
> -error_put_reg:
> -	if (!IS_ERR(st->reg))
> -		regulator_put(st->reg);
> -
> -	iio_device_free(indio_dev);
>  
>  	return ret;
>  }
> @@ -195,8 +190,6 @@ static int ad8366_remove(struct spi_device *spi)
>  		regulator_put(reg);
>  	}
>  
> -	iio_device_free(indio_dev);
> -
>  	return 0;
>  }
>  
> 
