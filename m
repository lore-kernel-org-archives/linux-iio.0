Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:53475 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751942AbbERMkt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 18 May 2015 08:40:49 -0400
Date: Mon, 18 May 2015 14:40:46 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: =?ISO-8859-15?Q?Urs_F=E4ssler?= <urs.fassler@bytesatwork.ch>
cc: jic23@kernel.org, angelo.compagnucci@gmail.com,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc128s052: add support for adc122s021
In-Reply-To: <1431950676-22379-2-git-send-email-urs.fassler@bytesatwork.ch>
Message-ID: <alpine.DEB.2.02.1505181433350.5336@pmeerw.net>
References: <1431950676-22379-1-git-send-email-urs.fassler@bytesatwork.ch> <1431950676-22379-2-git-send-email-urs.fassler@bytesatwork.ch>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="324295856-296857445-1431952846=:5336"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--324295856-296857445-1431952846=:5336
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT


looks good, maybe add the link to the datasheet:
http://www.ti.com/lit/ds/symlink/adc122s021.pdf

why do you drop the "ti," in the DT compatible?

> Signed-off-by: Urs Fässler <urs.fassler@bytesatwork.ch>
> ---
>  .../devicetree/bindings/iio/adc/ti-adc128s052.txt  |  6 ++---
>  drivers/iio/adc/Kconfig                            |  4 ++--
>  drivers/iio/adc/ti-adc128s052.c                    | 27 ++++++++++++++++++----
>  3 files changed, 27 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt b/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
> index 42ca7de..7cefcf7 100644
> --- a/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
> @@ -1,7 +1,7 @@
> -* Texas Instruments' ADC128S052 ADC chip
> +* Texas Instruments' ADC128S052 and ADC122S021 ADC chip
>  
>  Required properties:
> - - compatible: Should be "ti,adc128s052"
> + - compatible: Should be "adc128s052" or "adc122s021"
>   - reg: spi chip select number for the device
>   - vref-supply: The regulator supply for ADC reference voltage
>  
> @@ -11,7 +11,7 @@ Recommended properties:
>  
>  Example:
>  adc@0 {
> -	compatible = "ti,adc128s052";
> +        compatible = "adc128s052";
>  	reg = <0>;
>  	vref-supply = <&vdd_supply>;
>  	spi-max-frequency = <1000000>;
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
>  
>  	  This driver can also be built as a module. If so, the module will be
>  	  called ti-adc128s052.
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index 655cb56..42c7772 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -1,7 +1,7 @@
>  /*
>   * Copyright (C) 2014 Angelo Compagnucci <angelo.compagnucci@gmail.com>
>   *
> - * Driver for Texas Instruments' ADC128S052 ADC chip.
> + * Driver for Texas Instruments' ADC128S052 and ADC122S021 ADC chip.
>   * Datasheet can be found here:
>   * http://www.ti.com/lit/ds/symlink/adc128s052.pdf
>   *
> @@ -16,6 +16,11 @@
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
> @@ -92,7 +97,7 @@ static int adc128_read_raw(struct iio_dev *indio_dev,
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) \
>  	}
>  
> -static const struct iio_chan_spec adc128_channels[] = {
> +static const struct iio_chan_spec adc128s052_channels[] = {
>  	ADC128_VOLTAGE_CHANNEL(0),
>  	ADC128_VOLTAGE_CHANNEL(1),
>  	ADC128_VOLTAGE_CHANNEL(2),
> @@ -103,6 +108,16 @@ static const struct iio_chan_spec adc128_channels[] = {
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
> +
>  static const struct iio_info adc128_info = {
>  	.read_raw = adc128_read_raw,
>  	.driver_module = THIS_MODULE,
> @@ -112,6 +127,7 @@ static int adc128_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
>  	struct adc128 *adc;
> +	int config = spi_get_device_id(spi)->driver_data;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
> @@ -128,8 +144,8 @@ static int adc128_probe(struct spi_device *spi)
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
> @@ -158,7 +174,8 @@ static int adc128_remove(struct spi_device *spi)
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

-- 

Peter Meerwald
+43-664-2444418 (mobile)
--324295856-296857445-1431952846=:5336--
