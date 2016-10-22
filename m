Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53595 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935413AbcJVQ7m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Oct 2016 12:59:42 -0400
Subject: Re: [PATCH 08/13] staging:iio:ad7606: Move set_drvdata() into common
 code
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1476896828-10544-1-git-send-email-lars@metafoo.de>
 <1476896828-10544-9-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4c2eab58-eb29-008b-8dac-71cc95f5cc80@kernel.org>
Date: Sat, 22 Oct 2016 17:59:36 +0100
MIME-Version: 1.0
In-Reply-To: <1476896828-10544-9-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/10/16 18:07, Lars-Peter Clausen wrote:
> Both the platform_device and SPI driver call set_drvdata() at the end of
> their probe function. Move this into the common probe() function to reduce
> duplicated code.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied.  Thanks

Jonathan
> ---
>  drivers/staging/iio/adc/ad7606_core.c | 2 ++
>  drivers/staging/iio/adc/ad7606_par.c  | 2 --
>  drivers/staging/iio/adc/ad7606_spi.c  | 2 --
>  3 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
> index 4ce103a..13d8090 100644
> --- a/drivers/staging/iio/adc/ad7606_core.c
> +++ b/drivers/staging/iio/adc/ad7606_core.c
> @@ -517,6 +517,8 @@ struct iio_dev *ad7606_probe(struct device *dev, int irq,
>  	if (ret)
>  		goto error_unregister_ring;
>  
> +	dev_set_drvdata(dev, indio_dev);
> +
>  	return indio_dev;
>  error_unregister_ring:
>  	ad7606_ring_cleanup(indio_dev);
> diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
> index 0a23cd9..c273993 100644
> --- a/drivers/staging/iio/adc/ad7606_par.c
> +++ b/drivers/staging/iio/adc/ad7606_par.c
> @@ -77,8 +77,6 @@ static int ad7606_par_probe(struct platform_device *pdev)
>  	if (IS_ERR(indio_dev))
>  		return PTR_ERR(indio_dev);
>  
> -	platform_set_drvdata(pdev, indio_dev);
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
> index f69db59..9abbc15 100644
> --- a/drivers/staging/iio/adc/ad7606_spi.c
> +++ b/drivers/staging/iio/adc/ad7606_spi.c
> @@ -52,8 +52,6 @@ static int ad7606_spi_probe(struct spi_device *spi)
>  	if (IS_ERR(indio_dev))
>  		return PTR_ERR(indio_dev);
>  
> -	spi_set_drvdata(spi, indio_dev);
> -
>  	return 0;
>  }
>  
> 

