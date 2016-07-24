Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59416 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbcGXNiO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jul 2016 09:38:14 -0400
Subject: Re: [PATCH] iio: add Kconfig selects needed for triggered buffer
 compiles
To: Alison Schofield <amsfield22@gmail.com>
References: <20160719005634.GA27399@d830.WORKGROUP>
Cc: tiberiu.a.breana@intel.com, leonard.crestez@intel.com,
	mranostay@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3b7c50c7-112d-c4b1-8ff5-14507430f709@kernel.org>
Date: Sun, 24 Jul 2016 14:38:12 +0100
MIME-Version: 1.0
In-Reply-To: <20160719005634.GA27399@d830.WORKGROUP>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/07/16 01:56, Alison Schofield wrote:
> Select IIO_BUFFER and IIO_TRIGGERED_BUFFER to compile.
> Remove IIO_TRIGGER if present since IIO_BUFFER selects it.
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
I'm somewhat confused as to why I've not be getting lots
of autobuilder fails from these having been missing.

Ah well, luck (or bad luck) I guess.  Applied to the
fixes-togreg-post-rc1 branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/Kconfig       | 5 ++++-
>  drivers/iio/humidity/Kconfig    | 2 ++
>  drivers/iio/light/Kconfig       | 2 ++
>  drivers/iio/temperature/Kconfig | 2 ++
>  4 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 89d7820..78f148e 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -20,6 +20,8 @@ config BMA180
>  config BMA220
>      tristate "Bosch BMA220 3-Axis Accelerometer Driver"
>  	depends on SPI
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>      help
>        Say yes here to add support for the Bosch BMA220 triaxial
>        acceleration sensor.
> @@ -234,7 +236,8 @@ config STK8312
>  config STK8BA50
>  	tristate "Sensortek STK8BA50 3-Axis Accelerometer Driver"
>  	depends on I2C
> -	depends on IIO_TRIGGER
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to get support for the Sensortek STK8BA50 3-axis
>  	  accelerometer.
> diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
> index 738a86d..d041243 100644
> --- a/drivers/iio/humidity/Kconfig
> +++ b/drivers/iio/humidity/Kconfig
> @@ -6,6 +6,8 @@ menu "Humidity sensors"
>  config AM2315
>      tristate "Aosong AM2315 relative humidity and temperature sensor"
>      depends on I2C
> +    select IIO_BUFFER
> +    select IIO_TRIGGERED_BUFFER
>      help
>        If you say yes here you get support for the Aosong AM2315
>        relative humidity and ambient temperature sensor.
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 2821747..73c0140 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -238,6 +238,8 @@ config MAX44000
>  	tristate "MAX44000 Ambient and Infrared Proximity Sensor"
>  	depends on I2C
>  	select REGMAP_I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	 Say Y here if you want to build support for Maxim Integrated's
>  	 MAX44000 ambient and infrared proximity sensor device.
> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> index 1d3da05..5ea77a7 100644
> --- a/drivers/iio/temperature/Kconfig
> +++ b/drivers/iio/temperature/Kconfig
> @@ -6,6 +6,8 @@ menu "Temperature sensors"
>  config MAXIM_THERMOCOUPLE
>  	tristate "Maxim thermocouple sensors"
>  	depends on SPI
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  If you say yes here you get support for the Maxim series of
>  	  thermocouple sensors connected via SPI.
> 

