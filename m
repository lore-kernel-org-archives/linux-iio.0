Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45013 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753600AbdBKJyd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Feb 2017 04:54:33 -0500
Subject: Re: [PATCH 7/7] staging: iio: isl29028: move out of staging
To: Brian Masney <masneyb@onstation.org>
References: <20170209015431.17380-1-masneyb@onstation.org>
 <20170209015431.17380-8-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        ldewangan@nvidia.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e22c82d0-568f-1699-0847-e04b22b15822@kernel.org>
Date: Sat, 11 Feb 2017 09:54:12 +0000
MIME-Version: 1.0
In-Reply-To: <20170209015431.17380-8-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/02/17 01:54, Brian Masney wrote:
> Move ISL29028 ALS / Proximity Sensor out of staging and into mainline.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
I've taken another quick look at the driver and think this will be fine once
we have cleaned up that small question on the sampling frequencies.

Jonathan
> ---
>  drivers/iio/light/Kconfig                  | 10 ++++++++++
>  drivers/iio/light/Makefile                 |  1 +
>  drivers/{staging => }/iio/light/isl29028.c |  0
>  drivers/staging/iio/light/Kconfig          | 10 ----------
>  drivers/staging/iio/light/Makefile         |  1 -
>  5 files changed, 11 insertions(+), 11 deletions(-)
>  rename drivers/{staging => }/iio/light/isl29028.c (100%)
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 2afcbac..8b8c9e2 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -172,6 +172,16 @@ config SENSORS_ISL29018
>  	 in lux, proximity infrared sensing and normal infrared sensing.
>  	 Data from sensor is accessible via sysfs.
>  
> +config SENSORS_ISL29028
> +	tristate "Intersil ISL29028 Concurrent Light and Proximity Sensor"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	 Provides driver for the Intersil's ISL29028 device.
> +	 This driver supports the sysfs interface to get the ALS, IR intensity,
> +	 Proximity value via iio. The ISL29028 provides the concurrent sensing
> +	 of ambient light and proximity.
> +
>  config ISL29125
>  	tristate "Intersil ISL29125 digital color light sensor"
>  	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index edfd69b..2e730af 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_GP2AP020A00F)	+= gp2ap020a00f.o
>  obj-$(CONFIG_HID_SENSOR_ALS)	+= hid-sensor-als.o
>  obj-$(CONFIG_HID_SENSOR_PROX)	+= hid-sensor-prox.o
>  obj-$(CONFIG_SENSORS_ISL29018)	+= isl29018.o
> +obj-$(CONFIG_SENSORS_ISL29028)	+= isl29028.o
>  obj-$(CONFIG_ISL29125)		+= isl29125.o
>  obj-$(CONFIG_JSA1212)		+= jsa1212.o
>  obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
> diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
> similarity index 100%
> rename from drivers/staging/iio/light/isl29028.c
> rename to drivers/iio/light/isl29028.c
> diff --git a/drivers/staging/iio/light/Kconfig b/drivers/staging/iio/light/Kconfig
> index 4fbf629..aacb0ae 100644
> --- a/drivers/staging/iio/light/Kconfig
> +++ b/drivers/staging/iio/light/Kconfig
> @@ -3,16 +3,6 @@
>  #
>  menu "Light sensors"
>  
> -config SENSORS_ISL29028
> -	tristate "Intersil ISL29028 Concurrent Light and Proximity Sensor"
> -	depends on I2C
> -	select REGMAP_I2C
> -	help
> -	 Provides driver for the Intersil's ISL29028 device.
> -	 This driver supports the sysfs interface to get the ALS, IR intensity,
> -	 Proximity value via iio. The ISL29028 provides the concurrent sensing
> -	 of ambient light and proximity.
> -
>  config TSL2x7x
>  	tristate "TAOS TSL/TMD2x71 and TSL/TMD2x72 Family of light and proximity sensors"
>  	depends on I2C
> diff --git a/drivers/staging/iio/light/Makefile b/drivers/staging/iio/light/Makefile
> index f8693e9..10286c3 100644
> --- a/drivers/staging/iio/light/Makefile
> +++ b/drivers/staging/iio/light/Makefile
> @@ -2,5 +2,4 @@
>  # Makefile for industrial I/O Light sensors
>  #
>  
> -obj-$(CONFIG_SENSORS_ISL29028)	+= isl29028.o
>  obj-$(CONFIG_TSL2x7x)	+= tsl2x7x_core.o
> 

