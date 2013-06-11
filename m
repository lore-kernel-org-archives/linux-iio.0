Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55489 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792Ab3FKTfh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 11 Jun 2013 15:35:37 -0400
Message-ID: <51B77C03.1030500@kernel.org>
Date: Tue, 11 Jun 2013 20:35:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/4] staging:iio:adis16130: Move out of staging
References: <1370872815-14386-1-git-send-email-lars@metafoo.de> <1370872815-14386-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1370872815-14386-4-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/10/2013 03:00 PM, Lars-Peter Clausen wrote:
> The adis16130 driver is fairly simple and it a good shape now, so move it out of
> staging. Remove an outdated FIXME along the way.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks for tidying this one up and getting out of staging.  Lots more to go ;)
> ---
>  drivers/iio/gyro/Kconfig                                           | 7 +++++++
>  drivers/iio/gyro/Makefile                                          | 1 +
>  .../{staging/iio/gyro/adis16130_core.c => iio/gyro/adis16130.c}    | 1 -
>  drivers/staging/iio/gyro/Kconfig                                   | 7 -------
>  drivers/staging/iio/gyro/Makefile                                  | 3 ---
>  5 files changed, 8 insertions(+), 11 deletions(-)
>  rename drivers/{staging/iio/gyro/adis16130_core.c => iio/gyro/adis16130.c} (99%)
> 
> diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
> index b8daf1b..8498e9d 100644
> --- a/drivers/iio/gyro/Kconfig
> +++ b/drivers/iio/gyro/Kconfig
> @@ -10,6 +10,13 @@ config ADIS16080
>  	  Say yes here to build support for Analog Devices ADIS16080, ADIS16100 Yaw
>  	  Rate Gyroscope with SPI.
>  
> +config ADIS16130
> +	tristate "Analog Devices ADIS16130 High Precision Angular Rate Sensor driver"
> +	depends on SPI
> +	help
> +	  Say yes here to build support for Analog Devices ADIS16130 High Precision
> +	  Angular Rate Sensor driver.
> +
>  config ADIS16136
>  	tristate "Analog devices ADIS16136 and similar gyroscopes driver"
>  	depends on SPI_MASTER
> diff --git a/drivers/iio/gyro/Makefile b/drivers/iio/gyro/Makefile
> index 225d289..e9dc034 100644
> --- a/drivers/iio/gyro/Makefile
> +++ b/drivers/iio/gyro/Makefile
> @@ -3,6 +3,7 @@
>  #
>  
>  obj-$(CONFIG_ADIS16080) += adis16080.o
> +obj-$(CONFIG_ADIS16130) += adis16130.o
>  obj-$(CONFIG_ADIS16136) += adis16136.o
>  obj-$(CONFIG_ADXRS450) += adxrs450.o
>  
> diff --git a/drivers/staging/iio/gyro/adis16130_core.c b/drivers/iio/gyro/adis16130.c
> similarity index 99%
> rename from drivers/staging/iio/gyro/adis16130_core.c
> rename to drivers/iio/gyro/adis16130.c
> index 8979435..129acdf 100644
> --- a/drivers/staging/iio/gyro/adis16130_core.c
> +++ b/drivers/iio/gyro/adis16130.c
> @@ -183,7 +183,6 @@ error_ret:
>  	return ret;
>  }
>  
> -/* fixme, confirm ordering in this function */
>  static int adis16130_remove(struct spi_device *spi)
>  {
>  	iio_device_unregister(spi_get_drvdata(spi));
> diff --git a/drivers/staging/iio/gyro/Kconfig b/drivers/staging/iio/gyro/Kconfig
> index 8360662..b433371 100644
> --- a/drivers/staging/iio/gyro/Kconfig
> +++ b/drivers/staging/iio/gyro/Kconfig
> @@ -10,13 +10,6 @@ config ADIS16060
>  	  Say yes here to build support for Analog Devices adis16060 wide bandwidth
>  	  yaw rate gyroscope with SPI.
>  
> -config ADIS16130
> -	tristate "Analog Devices ADIS16130 High Precision Angular Rate Sensor driver"
> -	depends on SPI
> -	help
> -	  Say yes here to build support for Analog Devices ADIS16130 High Precision
> -	  Angular Rate Sensor driver.
> -
>  config ADIS16260
>  	tristate "Analog Devices ADIS16260 Digital Gyroscope Sensor SPI driver"
>  	depends on SPI
> diff --git a/drivers/staging/iio/gyro/Makefile b/drivers/staging/iio/gyro/Makefile
> index 98e6500..975f95b 100644
> --- a/drivers/staging/iio/gyro/Makefile
> +++ b/drivers/staging/iio/gyro/Makefile
> @@ -5,8 +5,5 @@
>  adis16060-y             := adis16060_core.o
>  obj-$(CONFIG_ADIS16060) += adis16060.o
>  
> -adis16130-y             := adis16130_core.o
> -obj-$(CONFIG_ADIS16130) += adis16130.o
> -
>  adis16260-y             := adis16260_core.o
>  obj-$(CONFIG_ADIS16260) += adis16260.o
> 
