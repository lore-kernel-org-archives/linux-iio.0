Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51851 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348Ab2GHRFu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jul 2012 13:05:50 -0400
Message-ID: <4FF9BDE5.7050708@kernel.org>
Date: Sun, 08 Jul 2012 18:05:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: remove SENSORS_ from Kconfig
References: <1339939206-19073-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339939206-19073-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/17/2012 02:20 PM, Peter Meerwald wrote:
> IIO sensors are not supposed to be prefixed SENSORS_, cleanup for
> consistency
Hi Peter,

I held off on this one as it may cause some issues with peoples
defconfigs.  It's a question of whether we really care...
I was hoping we'd get a few more opinions.

Anyone care either way?
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> ---
>  drivers/iio/light/Kconfig                 |    2 +-
>  drivers/iio/light/Makefile                |    2 +-
>  drivers/staging/iio/light/Kconfig         |    6 +++---
>  drivers/staging/iio/light/Makefile        |    6 +++---
>  drivers/staging/iio/magnetometer/Kconfig  |    4 ++--
>  drivers/staging/iio/magnetometer/Makefile |    4 ++--
>  6 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index f3ea90d..8bc9675 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -3,7 +3,7 @@
>  #
>  menu "Light sensors"
>  
> -config SENSORS_LM3533
> +config LM3533
>  	tristate "LM3533 ambient light sensor"
>  	depends on MFD_LM3533
>  	help
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index 06fa4d3..5ae2737 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -2,5 +2,5 @@
>  # Makefile for IIO Light sensors
>  #
>  
> -obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
> +obj-$(CONFIG_LM3533)		+= lm3533-als.o
>  obj-$(CONFIG_VCNL4000)		+= vcnl4000.o
> diff --git a/drivers/staging/iio/light/Kconfig b/drivers/staging/iio/light/Kconfig
> index 4bed30e..0f251e4 100644
> --- a/drivers/staging/iio/light/Kconfig
> +++ b/drivers/staging/iio/light/Kconfig
> @@ -3,7 +3,7 @@
>  #
>  menu "Light sensors"
>  
> -config SENSORS_ISL29018
> +config ISL29018
>  	tristate "ISL 29018 light and proximity sensor"
>  	depends on I2C
>  	select REGMAP_I2C
> @@ -15,7 +15,7 @@ config SENSORS_ISL29018
>  	 in lux, proximity infrared sensing and normal infrared sensing.
>  	 Data from sensor is accessible via sysfs.
>  
> -config SENSORS_ISL29028
> +config ISL29028
>  	tristate "Intersil ISL29028 Concurrent Light and Proximity Sensor"
>  	depends on I2C
>  	select REGMAP_I2C
> @@ -25,7 +25,7 @@ config SENSORS_ISL29028
>  	 Proximity value via iio. The ISL29028 provides the concurrent sensing
>  	 of ambient light and proximity.
>  
> -config SENSORS_TSL2563
> +config TSL2563
>  	tristate "TAOS TSL2560, TSL2561, TSL2562 and TSL2563 ambient light sensors"
>  	depends on I2C
>  	help
> diff --git a/drivers/staging/iio/light/Makefile b/drivers/staging/iio/light/Makefile
> index 141af1e..d718a07 100644
> --- a/drivers/staging/iio/light/Makefile
> +++ b/drivers/staging/iio/light/Makefile
> @@ -2,8 +2,8 @@
>  # Makefile for industrial I/O Light sensors
>  #
>  
> -obj-$(CONFIG_SENSORS_TSL2563)	+= tsl2563.o
> -obj-$(CONFIG_SENSORS_ISL29018)	+= isl29018.o
> -obj-$(CONFIG_SENSORS_ISL29028)	+= isl29028.o
> +obj-$(CONFIG_TSL2563)	+= tsl2563.o
> +obj-$(CONFIG_ISL29018)	+= isl29018.o
> +obj-$(CONFIG_ISL29028)	+= isl29028.o
>  obj-$(CONFIG_TSL2583)	+= tsl2583.o
>  obj-$(CONFIG_TSL2x7x)	+= tsl2x7x_core.o
> diff --git a/drivers/staging/iio/magnetometer/Kconfig b/drivers/staging/iio/magnetometer/Kconfig
> index df5e0d4..84a6c0f 100644
> --- a/drivers/staging/iio/magnetometer/Kconfig
> +++ b/drivers/staging/iio/magnetometer/Kconfig
> @@ -3,7 +3,7 @@
>  #
>  menu "Magnetometer sensors"
>  
> -config SENSORS_AK8975
> +config AK8975
>  	tristate "Asahi Kasei AK8975 3-Axis Magnetometer"
>  	depends on I2C
>  	depends on GPIOLIB
> @@ -14,7 +14,7 @@ config SENSORS_AK8975
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called ak8975.
>  
> -config SENSORS_HMC5843
> +config HMC5843
>  	tristate "Honeywell HMC5843/5883/5883L 3-Axis Magnetometer"
>  	depends on I2C
>  	help
> diff --git a/drivers/staging/iio/magnetometer/Makefile b/drivers/staging/iio/magnetometer/Makefile
> index f2a753f..79331bb 100644
> --- a/drivers/staging/iio/magnetometer/Makefile
> +++ b/drivers/staging/iio/magnetometer/Makefile
> @@ -2,5 +2,5 @@
>  # Makefile for industrial I/O Magnetometer sensors
>  #
>  
> -obj-$(CONFIG_SENSORS_AK8975)	+= ak8975.o
> -obj-$(CONFIG_SENSORS_HMC5843)	+= hmc5843.o
> +obj-$(CONFIG_AK8975)	+= ak8975.o
> +obj-$(CONFIG_HMC5843)	+= hmc5843.o
> 


