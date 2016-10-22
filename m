Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53645 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935413AbcJVRJN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Oct 2016 13:09:13 -0400
Subject: Re: [PATCH 10/13] staging:iio:ad7606: Let common remove function take
 a struct device *
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1476896828-10544-1-git-send-email-lars@metafoo.de>
 <1476896828-10544-11-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c7bfc81d-3892-df35-36e5-b36dcbca4145@kernel.org>
Date: Sat, 22 Oct 2016 18:09:11 +0100
MIME-Version: 1.0
In-Reply-To: <1476896828-10544-11-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/10/16 18:07, Lars-Peter Clausen wrote:
> Currently the common remove function takes a struct iio_dev *. This
> parameter is retrieved by the individual driver remove functions by calling
> get_drvdata() on their device. To simplify the code let the common remove
> function directly take a struct dev * and do the IIO device in retrieval
> the common remove function.
> 
> This also aligns the interface with the common probe function.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/adc/ad7606.h      | 2 +-
>  drivers/staging/iio/adc/ad7606_core.c | 3 ++-
>  drivers/staging/iio/adc/ad7606_par.c  | 6 +-----
>  drivers/staging/iio/adc/ad7606_spi.c  | 4 +---
>  4 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
> index b4b25a2..6dde987 100644
> --- a/drivers/staging/iio/adc/ad7606.h
> +++ b/drivers/staging/iio/adc/ad7606.h
> @@ -81,7 +81,7 @@ struct ad7606_bus_ops {
>  int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  		 const char *name, unsigned int id,
>  		 const struct ad7606_bus_ops *bops);
> -int ad7606_remove(struct iio_dev *indio_dev, int irq);
> +int ad7606_remove(struct device *dev, int irq);
>  int ad7606_reset(struct ad7606_state *st);
>  int ad7606_read_samples(struct ad7606_state *st);
>  
> diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
> index 1ee7a29..670caa2 100644
> --- a/drivers/staging/iio/adc/ad7606_core.c
> +++ b/drivers/staging/iio/adc/ad7606_core.c
> @@ -535,8 +535,9 @@ error_disable_reg:
>  }
>  EXPORT_SYMBOL_GPL(ad7606_probe);
>  
> -int ad7606_remove(struct iio_dev *indio_dev, int irq)
> +int ad7606_remove(struct device *dev, int irq)
>  {
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct ad7606_state *st = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
> index 42eb9e0..cd6c410c 100644
> --- a/drivers/staging/iio/adc/ad7606_par.c
> +++ b/drivers/staging/iio/adc/ad7606_par.c
> @@ -76,11 +76,7 @@ static int ad7606_par_probe(struct platform_device *pdev)
>  
>  static int ad7606_par_remove(struct platform_device *pdev)
>  {
> -	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> -
> -	ad7606_remove(indio_dev, platform_get_irq(pdev, 0));
> -
> -	return 0;
> +	return ad7606_remove(&pdev->dev, platform_get_irq(pdev, 0));
>  }
>  
>  static const struct platform_device_id ad7606_driver_ids[] = {
> diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
> index 064c4c2..c9b1f266 100644
> --- a/drivers/staging/iio/adc/ad7606_spi.c
> +++ b/drivers/staging/iio/adc/ad7606_spi.c
> @@ -51,9 +51,7 @@ static int ad7606_spi_probe(struct spi_device *spi)
>  
>  static int ad7606_spi_remove(struct spi_device *spi)
>  {
> -	struct iio_dev *indio_dev = dev_get_drvdata(&spi->dev);
> -
> -	return ad7606_remove(indio_dev, spi->irq);
> +	return ad7606_remove(&spi->dev, spi->irq);
>  }
>  
>  static const struct spi_device_id ad7606_id[] = {
> 

