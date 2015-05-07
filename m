Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46178 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbbEGXdl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 May 2015 19:33:41 -0400
Message-ID: <554B4093.9080207@kernel.org>
Date: Thu, 07 May 2015 11:38:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
CC: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH 20/27] Staging: iio: Allow compile test of GPIO consumers
 if !GPIOLIB
References: <1430836404-15513-1-git-send-email-geert@linux-m68k.org> <1430843563-18615-1-git-send-email-geert@linux-m68k.org> <1430843563-18615-20-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1430843563-18615-20-git-send-email-geert@linux-m68k.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/05/15 17:32, Geert Uytterhoeven wrote:
> The GPIO subsystem provides dummy GPIO consumer functions if GPIOLIB is
> not enabled. Hence drivers that depend on GPIOLIB, but use GPIO consumer
> functionality only, can still be compiled if GPIOLIB is not enabled.
> 
> Relax the dependency on GPIOLIB if COMPILE_TEST is enabled, where
> appropriate.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: linux-iio@vger.kernel.org
> Cc: devel@driverdev.osuosl.org
Applied to the togreg branch of iio.git - to be pushed out as testing
'soonish'.
> ---
>  drivers/staging/iio/accel/Kconfig    | 2 +-
>  drivers/staging/iio/adc/Kconfig      | 6 +++---
>  drivers/staging/iio/addac/Kconfig    | 2 +-
>  drivers/staging/iio/resolver/Kconfig | 4 ++--
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig
> index 07b7ffa00ab53c86..fa67da9408b6b3b7 100644
> --- a/drivers/staging/iio/accel/Kconfig
> +++ b/drivers/staging/iio/accel/Kconfig
> @@ -79,7 +79,7 @@ config LIS3L02DQ
>  	depends on SPI
>  	select IIO_TRIGGER if IIO_BUFFER
>  	depends on !IIO_BUFFER || IIO_KFIFO_BUF
> -	depends on GPIOLIB
> +	depends on GPIOLIB || COMPILE_TEST
>  	help
>  	  Say Y here to build SPI support for the ST microelectronics
>  	  accelerometer. The driver supplies direct access via sysfs files
> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
> index d0016ce6e65840e6..94ae4232ee773497 100644
> --- a/drivers/staging/iio/adc/Kconfig
> +++ b/drivers/staging/iio/adc/Kconfig
> @@ -5,7 +5,7 @@ menu "Analog to digital converters"
>  
>  config AD7606
>  	tristate "Analog Devices AD7606 ADC driver"
> -	depends on GPIOLIB
> +	depends on GPIOLIB || COMPILE_TEST
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
> @@ -39,7 +39,7 @@ config AD7606_IFACE_SPI
>  config AD7780
>  	tristate "Analog Devices AD7780 and similar ADCs driver"
>  	depends on SPI
> -	depends on GPIOLIB
> +	depends on GPIOLIB || COMPILE_TEST
>  	select AD_SIGMA_DELTA
>  	help
>  	  Say yes here to build support for Analog Devices AD7170, AD7171,
> @@ -52,7 +52,7 @@ config AD7780
>  config AD7816
>  	tristate "Analog Devices AD7816/7/8 temperature sensor and ADC driver"
>  	depends on SPI
> -	depends on GPIOLIB
> +	depends on GPIOLIB || COMPILE_TEST
>  	help
>  	  Say yes here to build support for Analog Devices AD7816/7/8
>  	  temperature sensors and ADC.
> diff --git a/drivers/staging/iio/addac/Kconfig b/drivers/staging/iio/addac/Kconfig
> index 0ed7e13e2283edb0..ba18b8432d9cce6e 100644
> --- a/drivers/staging/iio/addac/Kconfig
> +++ b/drivers/staging/iio/addac/Kconfig
> @@ -5,7 +5,7 @@ menu "Analog digital bi-direction converters"
>  
>  config ADT7316
>  	tristate "Analog Devices ADT7316/7/8 ADT7516/7/9 temperature sensor, ADC and DAC driver"
> -	depends on GPIOLIB
> +	depends on GPIOLIB || COMPILE_TEST
>  	help
>  	  Say yes here to build support for Analog Devices ADT7316, ADT7317, ADT7318
>  	  and ADT7516, ADT7517, ADT7519 temperature sensors, ADC and DAC.
> diff --git a/drivers/staging/iio/resolver/Kconfig b/drivers/staging/iio/resolver/Kconfig
> index c7a742ec122727b0..1c7e2860d6b75d56 100644
> --- a/drivers/staging/iio/resolver/Kconfig
> +++ b/drivers/staging/iio/resolver/Kconfig
> @@ -16,7 +16,7 @@ config AD2S90
>  config AD2S1200
>  	tristate "Analog Devices ad2s1200/ad2s1205 driver"
>  	depends on SPI
> -	depends on GPIOLIB
> +	depends on GPIOLIB || COMPILE_TEST
>  	help
>  	  Say yes here to build support for Analog Devices spi resolver
>  	  to digital converters, ad2s1200 and ad2s1205, provides direct access
> @@ -28,7 +28,7 @@ config AD2S1200
>  config AD2S1210
>  	tristate "Analog Devices ad2s1210 driver"
>  	depends on SPI
> -	depends on GPIOLIB
> +	depends on GPIOLIB || COMPILE_TEST
>  	help
>  	  Say yes here to build support for Analog Devices spi resolver
>  	  to digital converters, ad2s1210, provides direct access via sysfs.
> 

