Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50444 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756243AbbEWLnI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 May 2015 07:43:08 -0400
Message-ID: <556067C9.3070209@kernel.org>
Date: Sat, 23 May 2015 12:43:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: =?UTF-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bytesatwork.ch>,
	angelo.compagnucci@gmail.com
CC: iivanov@mm-sol.com, ezequiel.garcia@imgtec.com,
	jacob.jun.pan@linux.intel.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc128s052: add support for adc122s021
References: <1431955364-25059-1-git-send-email-urs.fassler@bytesatwork.ch> <1431955364-25059-2-git-send-email-urs.fassler@bytesatwork.ch>
In-Reply-To: <1431955364-25059-2-git-send-email-urs.fassler@bytesatwork.ch>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/05/15 14:22, Urs Fässler wrote:
> Signed-off-by: Urs Fässler <urs.fassler@bytesatwork.ch>
looks good. 

Applied to the togreg branch of iio.git with the chip->chips change.

Thanks,

Jonathan
> ---
>  .../devicetree/bindings/iio/adc/ti-adc128s052.txt  |  4 +--
>  drivers/iio/adc/Kconfig                            |  4 +--
>  drivers/iio/adc/ti-adc128s052.c                    | 30 +++++++++++++++++-----
>  3 files changed, 28 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt b/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
> index 42ca7de..15ca6b4 100644
> --- a/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
> @@ -1,7 +1,7 @@
> -* Texas Instruments' ADC128S052 ADC chip
> +* Texas Instruments' ADC128S052 and ADC122S021 ADC chip
>  
>  Required properties:
> - - compatible: Should be "ti,adc128s052"
> + - compatible: Should be "ti,adc128s052" or "ti,adc122s021"
>   - reg: spi chip select number for the device
>   - vref-supply: The regulator supply for ADC reference voltage
>  
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index e36a73e..92c319c 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -285,11 +285,11 @@ config TI_ADC081C
>  	  called ti-adc081c.
>  
>  config TI_ADC128S052
> -	tristate "Texas Instruments ADC128S052"
> +	tristate "Texas Instruments ADC128S052/ADC122S021"
>  	depends on SPI
>  	help
>  	  If you say yes here you get support for Texas Instruments ADC128S052
> -	  chip.
> +	  and ADC122S021 chip.
chips ;)
>  
>  	  This driver can also be built as a module. If so, the module will be
>  	  called ti-adc128s052.
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index 655cb56..915be6b 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -1,9 +1,10 @@
>  /*
>   * Copyright (C) 2014 Angelo Compagnucci <angelo.compagnucci@gmail.com>
>   *
> - * Driver for Texas Instruments' ADC128S052 ADC chip.
> - * Datasheet can be found here:
> + * Driver for Texas Instruments' ADC128S052 and ADC122S021 ADC chip.
> + * Datasheets can be found here:
>   * http://www.ti.com/lit/ds/symlink/adc128s052.pdf
> + * http://www.ti.com/lit/ds/symlink/adc122s021.pdf
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -16,6 +17,11 @@
>  #include <linux/iio/iio.h>
>  #include <linux/regulator/consumer.h>
>  
> +struct adc128_configuration {
> +	const struct iio_chan_spec	*channels;
> +	u8				num_channels;
> +};
> +
>  struct adc128 {
>  	struct spi_device *spi;
>  
> @@ -92,7 +98,7 @@ static int adc128_read_raw(struct iio_dev *indio_dev,
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) \
>  	}
>  
> -static const struct iio_chan_spec adc128_channels[] = {
> +static const struct iio_chan_spec adc128s052_channels[] = {
>  	ADC128_VOLTAGE_CHANNEL(0),
>  	ADC128_VOLTAGE_CHANNEL(1),
>  	ADC128_VOLTAGE_CHANNEL(2),
> @@ -103,6 +109,16 @@ static const struct iio_chan_spec adc128_channels[] = {
>  	ADC128_VOLTAGE_CHANNEL(7),
>  };
>  
> +static const struct iio_chan_spec adc122s021_channels[] = {
> +	ADC128_VOLTAGE_CHANNEL(0),
> +	ADC128_VOLTAGE_CHANNEL(1),
> +};
> +
> +static const struct adc128_configuration adc128_config[] = {
> +	{ adc128s052_channels, ARRAY_SIZE(adc128s052_channels) },
> +	{ adc122s021_channels, ARRAY_SIZE(adc122s021_channels) },
> +};
This is a good flexible solution as opposed to doing it via a switch
in the probe function which would have been shorter, but not allowed
for as easy an extension to moer parts in future.   Looks like there
are lots of fairly similar parts!
> +
>  static const struct iio_info adc128_info = {
>  	.read_raw = adc128_read_raw,
>  	.driver_module = THIS_MODULE,
> @@ -112,6 +128,7 @@ static int adc128_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
>  	struct adc128 *adc;
> +	int config = spi_get_device_id(spi)->driver_data;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
> @@ -128,8 +145,8 @@ static int adc128_probe(struct spi_device *spi)
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &adc128_info;
>  
> -	indio_dev->channels = adc128_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(adc128_channels);
> +	indio_dev->channels = adc128_config[config].channels;
> +	indio_dev->num_channels = adc128_config[config].num_channels;
>  
>  	adc->reg = devm_regulator_get(&spi->dev, "vref");
>  	if (IS_ERR(adc->reg))
> @@ -158,7 +175,8 @@ static int adc128_remove(struct spi_device *spi)
>  }
>  
>  static const struct spi_device_id adc128_id[] = {
> -	{ "adc128s052", 0},
> +	{ "adc128s052", 0},	/* index into adc128_config */
> +	{ "adc122s021",	1},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, adc128_id);
> 

