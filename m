Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:37217 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171Ab2BUPOF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 21 Feb 2012 10:14:05 -0500
Message-ID: <4F43B492.2060101@cam.ac.uk>
Date: Tue, 21 Feb 2012 15:13:22 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH v2 4/6] staging:iio:dac:ad5064: Add AD5025/AD5045/AD5065
 support
References: <1329738920-14281-1-git-send-email-lars@metafoo.de> <1329738920-14281-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1329738920-14281-4-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2/20/2012 11:55 AM, Lars-Peter Clausen wrote:
> The AD5025/AD5045/AD5065 are identical to the AD5024/AD5044/AD5064 excpet that
except
> they have 2 instead of 4 DAC channels.
>
> Signed-off-by: Lars-Peter Clausen<lars@metafoo.de>
> Acked-by: Jonathan Cameron<jic23@kernel.org>
> ---
>   drivers/staging/iio/dac/Kconfig  |    6 +++---
>   drivers/staging/iio/dac/ad5064.c |   26 ++++++++++++++++++++++++--
>   2 files changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/staging/iio/dac/Kconfig b/drivers/staging/iio/dac/Kconfig
> index 13e2797..66b2504 100644
> --- a/drivers/staging/iio/dac/Kconfig
> +++ b/drivers/staging/iio/dac/Kconfig
> @@ -4,11 +4,11 @@
>   menu "Digital to analog converters"
>
>   config AD5064
> -	tristate "Analog Devices AD5064/64-1/44/24 DAC driver"
> +	tristate "Analog Devices AD5064/64-1/65/44/45/24/25 DAC driver"
>   	depends on SPI
>   	help
> -	  Say yes here to build support for Analog Devices AD5064, AD5064-1,
> -	  AD5044, AD5024 Digital to Analog Converter.
> +	  Say yes here to build support for Analog Devices AD5024, AD5025, AD5044,
> +	  AD5045, AD5064, AD5064-1, AD5065 Digital to Analog Converter.
>
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called ad5064.
> diff --git a/drivers/staging/iio/dac/ad5064.c b/drivers/staging/iio/dac/ad5064.c
> index 40db679..865e81f 100644
> --- a/drivers/staging/iio/dac/ad5064.c
> +++ b/drivers/staging/iio/dac/ad5064.c
> @@ -1,5 +1,6 @@
>   /*
> - * AD5064, AD5064-1, AD5044, AD5024 Digital to analog converters  driver
> + * AD5024, AD5025, AD5044, AD5045, AD5064, AD5064-1 Digital to analog converters
> + * driver
>    *
>    * Copyright 2011 Analog Devices Inc.
>    *
> @@ -84,9 +85,12 @@ struct ad5064_state {
>
>   enum ad5064_type {
>   	ID_AD5024,
> +	ID_AD5025,
>   	ID_AD5044,
> +	ID_AD5045,
>   	ID_AD5064,
>   	ID_AD5064_1,
> +	ID_AD5065,
>   };
>
>   static int ad5064_spi_write(struct ad5064_state *st, unsigned int cmd,
> @@ -301,11 +305,21 @@ static const struct ad5064_chip_info ad5064_chip_info_tbl[] = {
>   		.channels = ad5024_channels,
>   		.num_channels = 4,
>   	},
> +	[ID_AD5025] = {
> +		.shared_vref = false,
> +		.channels = ad5024_channels,
> +		.num_channels = 2,
> +	},
>   	[ID_AD5044] = {
>   		.shared_vref = false,
>   		.channels = ad5044_channels,
>   		.num_channels = 4,
>   	},
> +	[ID_AD5045] = {
> +		.shared_vref = false,
> +		.channels = ad5044_channels,
> +		.num_channels = 2,
> +	},
>   	[ID_AD5064] = {
>   		.shared_vref = false,
>   		.channels = ad5064_channels,
> @@ -316,6 +330,11 @@ static const struct ad5064_chip_info ad5064_chip_info_tbl[] = {
>   		.channels = ad5064_channels,
>   		.num_channels = 4,
>   	},
> +	[ID_AD5065] = {
> +		.shared_vref = false,
> +		.channels = ad5064_channels,
> +		.num_channels = 2,
> +	},
>   };
>
>   static inline unsigned int ad5064_num_vref(struct ad5064_state *st)
> @@ -412,9 +431,12 @@ static int __devexit ad5064_remove(struct spi_device *spi)
>
>   static const struct spi_device_id ad5064_id[] = {
>   	{"ad5024", ID_AD5024},
> +	{"ad5025", ID_AD5025},
>   	{"ad5044", ID_AD5044},
> +	{"ad5045", ID_AD5045},
>   	{"ad5064", ID_AD5064},
>   	{"ad5064-1", ID_AD5064_1},
> +	{"ad5065", ID_AD5065},
>   	{}
>   };
>   MODULE_DEVICE_TABLE(spi, ad5064_id);
> @@ -431,5 +453,5 @@ static struct spi_driver ad5064_driver = {
>   module_spi_driver(ad5064_driver);
>
>   MODULE_AUTHOR("Lars-Peter Clausen<lars@metafoo.de>");
> -MODULE_DESCRIPTION("Analog Devices AD5064/64-1/44/24 DAC");
> +MODULE_DESCRIPTION("Analog Devices AD5024/25/44/45/64/64-1/65 DAC");
>   MODULE_LICENSE("GPL v2");

