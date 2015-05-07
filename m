Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46173 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbbEGXdl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 May 2015 19:33:41 -0400
Message-ID: <554B4069.4090408@kernel.org>
Date: Thu, 07 May 2015 11:37:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
CC: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 07/27] iio: Allow compile test of GPIO consumers if !GPIOLIB
References: <1430836404-15513-1-git-send-email-geert@linux-m68k.org> <1430843563-18615-1-git-send-email-geert@linux-m68k.org> <1430843563-18615-7-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1430843563-18615-7-git-send-email-geert@linux-m68k.org>
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
Not entirely convinced that the extra build coverage from this is going
to be that extensive, but it does no harm, so why not?

Applied to the togreg branch of iio.git, will sometime be pushed out
as testing, for the autobuilders to play with it, as I am travelling.

Jonathan
> ---
>  drivers/iio/humidity/Kconfig     | 2 +-
>  drivers/iio/magnetometer/Kconfig | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
> index 4813b793b9f7f944..688c0d1cb47dea36 100644
> --- a/drivers/iio/humidity/Kconfig
> +++ b/drivers/iio/humidity/Kconfig
> @@ -5,7 +5,7 @@ menu "Humidity sensors"
>  
>  config DHT11
>  	tristate "DHT11 (and compatible sensors) driver"
> -	depends on GPIOLIB
> +	depends on GPIOLIB || COMPILE_TEST
>  	help
>  	  This driver supports reading data via a single interrupt
>  	  generating GPIO line. Currently tested are DHT11 and DHT22.
> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> index a5d6de72c523bab2..00297bbb7e4b4a0b 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig
> @@ -8,7 +8,7 @@ menu "Magnetometer sensors"
>  config AK8975
>  	tristate "Asahi Kasei AK 3-Axis Magnetometer"
>  	depends on I2C
> -	depends on GPIOLIB
> +	depends on GPIOLIB || COMPILE_TEST
>  	help
>  	  Say yes here to build support for Asahi Kasei AK8975, AK8963,
>  	  AK09911 or AK09912 3-Axis Magnetometer.
> @@ -19,7 +19,7 @@ config AK8975
>  config AK09911
>  	tristate "Asahi Kasei AK09911 3-axis Compass"
>  	depends on I2C
> -	depends on GPIOLIB
> +	depends on GPIOLIB || COMPILE_TEST
>  	select AK8975
>  	help
>  	  Deprecated: AK09911 is now supported by AK8975 driver.
> 

