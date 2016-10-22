Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53204 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937392AbcJVPXY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Oct 2016 11:23:24 -0400
Subject: Re: [PATCH 02/13] staging:iio:ad7606: Remove redundant name field
 from ad7606_chip_info
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1476896828-10544-1-git-send-email-lars@metafoo.de>
 <1476896828-10544-3-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d52756b5-5ff9-adde-2837-4cf8d9715d11@kernel.org>
Date: Sat, 22 Oct 2016 16:23:22 +0100
MIME-Version: 1.0
In-Reply-To: <1476896828-10544-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/10/16 18:06, Lars-Peter Clausen wrote:
> The name field in the ad7606_chip_info struct is set to the same value as
> the as the name field in the corresponding {platform,spi}_device_id table
> entry. Remove it from the ad7606_chip_info struct and pass the name from
> the ID to the probe function. This slightly reduces the size of the
> chip_info table and adding new entries requires less boilerplate.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied.
> ---
>  drivers/staging/iio/adc/ad7606.h      |  4 ++--
>  drivers/staging/iio/adc/ad7606_core.c | 11 ++++-------
>  drivers/staging/iio/adc/ad7606_par.c  |  3 ++-
>  drivers/staging/iio/adc/ad7606_spi.c  |  3 ++-
>  4 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
> index b7e59a6..380c56a 100644
> --- a/drivers/staging/iio/adc/ad7606.h
> +++ b/drivers/staging/iio/adc/ad7606.h
> @@ -48,7 +48,6 @@ struct ad7606_platform_data {
>   */
>  
>  struct ad7606_chip_info {
> -	const char			*name;
>  	const struct iio_chan_spec	*channels;
>  	unsigned int			num_channels;
>  };
> @@ -84,7 +83,8 @@ struct ad7606_bus_ops {
>  };
>  
>  struct iio_dev *ad7606_probe(struct device *dev, int irq,
> -			      void __iomem *base_address, unsigned int id,
> +			      void __iomem *base_address,
> +			      const char *name, unsigned int id,
>  			      const struct ad7606_bus_ops *bops);
>  int ad7606_remove(struct iio_dev *indio_dev, int irq);
>  int ad7606_reset(struct ad7606_state *st);
> diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
> index a1f18d4..1093647 100644
> --- a/drivers/staging/iio/adc/ad7606_core.c
> +++ b/drivers/staging/iio/adc/ad7606_core.c
> @@ -260,17 +260,14 @@ static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
>  	 * More devices added in future
>  	 */
>  	[ID_AD7606_8] = {
> -		.name = "ad7606",
>  		.channels = ad7606_channels,
>  		.num_channels = 9,
>  	},
>  	[ID_AD7606_6] = {
> -		.name = "ad7606-6",
>  		.channels = ad7606_channels,
>  		.num_channels = 7,
>  	},
>  	[ID_AD7606_4] = {
> -		.name = "ad7606-4",
>  		.channels = ad7606_channels,
>  		.num_channels = 5,
>  	},
> @@ -438,7 +435,7 @@ static const struct iio_info ad7606_info_range = {
>  
>  struct iio_dev *ad7606_probe(struct device *dev, int irq,
>  			     void __iomem *base_address,
> -			     unsigned int id,
> +			     const char *name, unsigned int id,
>  			     const struct ad7606_bus_ops *bops)
>  {
>  	struct ad7606_platform_data *pdata = dev->platform_data;
> @@ -491,7 +488,7 @@ struct iio_dev *ad7606_probe(struct device *dev, int irq,
>  			indio_dev->info = &ad7606_info_no_os_or_range;
>  	}
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->name = st->chip_info->name;
> +	indio_dev->name = name;
>  	indio_dev->channels = st->chip_info->channels;
>  	indio_dev->num_channels = st->chip_info->num_channels;
>  
> @@ -505,8 +502,8 @@ struct iio_dev *ad7606_probe(struct device *dev, int irq,
>  	if (ret)
>  		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
>  
> -	ret = request_irq(irq, ad7606_interrupt,
> -			  IRQF_TRIGGER_FALLING, st->chip_info->name, indio_dev);
> +	ret = request_irq(irq, ad7606_interrupt, IRQF_TRIGGER_FALLING, name,
> +			  indio_dev);
>  	if (ret)
>  		goto error_free_gpios;
>  
> diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
> index 84d2393..0a23cd9 100644
> --- a/drivers/staging/iio/adc/ad7606_par.c
> +++ b/drivers/staging/iio/adc/ad7606_par.c
> @@ -49,6 +49,7 @@ static const struct ad7606_bus_ops ad7606_par8_bops = {
>  
>  static int ad7606_par_probe(struct platform_device *pdev)
>  {
> +	const struct platform_device_id *id = platform_get_device_id(pdev);
>  	struct resource *res;
>  	struct iio_dev *indio_dev;
>  	void __iomem *addr;
> @@ -69,7 +70,7 @@ static int ad7606_par_probe(struct platform_device *pdev)
>  	remap_size = resource_size(res);
>  
>  	indio_dev = ad7606_probe(&pdev->dev, irq, addr,
> -				 platform_get_device_id(pdev)->driver_data,
> +				 id->name, id->driver_data,
>  				 remap_size > 1 ? &ad7606_par16_bops :
>  				 &ad7606_par8_bops);
>  
> diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
> index 9587fa8..f69db59 100644
> --- a/drivers/staging/iio/adc/ad7606_spi.c
> +++ b/drivers/staging/iio/adc/ad7606_spi.c
> @@ -42,10 +42,11 @@ static const struct ad7606_bus_ops ad7606_spi_bops = {
>  
>  static int ad7606_spi_probe(struct spi_device *spi)
>  {
> +	const struct spi_device_id *id = spi_get_device_id(spi);
>  	struct iio_dev *indio_dev;
>  
>  	indio_dev = ad7606_probe(&spi->dev, spi->irq, NULL,
> -				 spi_get_device_id(spi)->driver_data,
> +				 id->name, id->driver_data,
>  				 &ad7606_spi_bops);
>  
>  	if (IS_ERR(indio_dev))
> 

