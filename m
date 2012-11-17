Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45634 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab2KQLpJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 17 Nov 2012 06:45:09 -0500
Message-ID: <50A778C2.809@kernel.org>
Date: Sat, 17 Nov 2012 11:45:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	drivers@analog.com
Subject: Re: [PATCH 5/5] staging:iio: Move the ad7298 driver out of staging
References: <1352985328-24322-1-git-send-email-lars@metafoo.de> <1352985328-24322-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1352985328-24322-5-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/15/2012 01:15 PM, Lars-Peter Clausen wrote:
> The driver does not expose any custom API to userspace and none of the standard
> static code checker tools report any issues, so move it out of staging.
> 
one day I'll work out how to make a tiny change in an earlier patch without needing
to respin the entire follow up more or less by hand.

Anyhow, now done, and added to togreg branch of iio.git

Other than that little slip, a nice patch set Lars.
Thanks!
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/iio/adc/Kconfig                                      | 12 ++++++++++++
>  drivers/iio/adc/Makefile                                     |  1 +
>  drivers/{staging => }/iio/adc/ad7298.c                       |  2 +-
>  drivers/staging/iio/adc/Kconfig                              | 12 ------------
>  drivers/staging/iio/adc/Makefile                             |  1 -
>  .../staging/iio/adc => include/linux/platform_data}/ad7298.h |  4 ++--
>  6 files changed, 16 insertions(+), 16 deletions(-)
>  rename drivers/{staging => }/iio/adc/ad7298.c (99%)
>  rename {drivers/staging/iio/adc => include/linux/platform_data}/ad7298.h (80%)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index ef5200a..cd5eed6 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -18,6 +18,18 @@ config AD7266
>  	  Say yes here to build support for Analog Devices AD7265 and AD7266
>  	  ADCs.
>  
> +config AD7298
> +	tristate "Analog Devices AD7298 ADC driver"
> +	depends on SPI
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say yes here to build support for Analog Devices AD7298
> +	  8 Channel ADC with temperature sensor.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad7298.
> +
>  config AD7791
>  	tristate "Analog Devices AD7791 ADC driver"
>  	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 54ac7bb..3256dc6 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -4,6 +4,7 @@
>  
>  obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
>  obj-$(CONFIG_AD7266) += ad7266.o
> +obj-$(CONFIG_AD7298) += ad7298.o
>  obj-$(CONFIG_AD7476) += ad7476.o
>  obj-$(CONFIG_AD7791) += ad7791.o
>  obj-$(CONFIG_AD7887) += ad7887.o
> diff --git a/drivers/staging/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
> similarity index 99%
> rename from drivers/staging/iio/adc/ad7298.c
> rename to drivers/iio/adc/ad7298.c
> index 2742a9d..441a9a2 100644
> --- a/drivers/staging/iio/adc/ad7298.c
> +++ b/drivers/iio/adc/ad7298.c
> @@ -23,7 +23,7 @@
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
>  
> -#include "ad7298.h"
> +#include <linux/platform_data/ad7298.h>
>  
>  #define AD7298_WRITE	(1 << 15) /* write to the control register */
>  #define AD7298_REPEAT	(1 << 14) /* repeated conversion enable */
> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
> index 5086a46..dc8582b 100644
> --- a/drivers/staging/iio/adc/Kconfig
> +++ b/drivers/staging/iio/adc/Kconfig
> @@ -10,18 +10,6 @@ config AD7291
>  	  Say yes here to build support for Analog Devices AD7291
>  	  8 Channel ADC with temperature sensor.
>  
> -config AD7298
> -	tristate "Analog Devices AD7298 ADC driver"
> -	depends on SPI
> -	select IIO_BUFFER
> -	select IIO_TRIGGERED_BUFFER
> -	help
> -	  Say yes here to build support for Analog Devices AD7298
> -	  8 Channel ADC with temperature sensor.
> -
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called ad7298.
> -
>  config AD7606
>  	tristate "Analog Devices AD7606 ADC driver"
>  	depends on GPIOLIB
> diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
> index e867d01..a80e603 100644
> --- a/drivers/staging/iio/adc/Makefile
> +++ b/drivers/staging/iio/adc/Makefile
> @@ -13,7 +13,6 @@ ad799x-$(CONFIG_AD799X_RING_BUFFER) += ad799x_ring.o
>  obj-$(CONFIG_AD799X) += ad799x.o
>  
>  obj-$(CONFIG_AD7887) += ad7887.o
> -obj-$(CONFIG_AD7298) += ad7298.o
>  
>  obj-$(CONFIG_AD7291) += ad7291.o
>  obj-$(CONFIG_AD7780) += ad7780.o
> diff --git a/drivers/staging/iio/adc/ad7298.h b/include/linux/platform_data/ad7298.h
> similarity index 80%
> rename from drivers/staging/iio/adc/ad7298.h
> rename to include/linux/platform_data/ad7298.h
> index c8ac969..fbf8adf 100644
> --- a/drivers/staging/iio/adc/ad7298.h
> +++ b/include/linux/platform_data/ad7298.h
> @@ -6,8 +6,8 @@
>   * Licensed under the GPL-2.
>   */
>  
> -#ifndef IIO_ADC_AD7298_H_
> -#define IIO_ADC_AD7298_H_
> +#ifndef __LINUX_PLATFORM_DATA_AD7298_H__
> +#define __LINUX_PLATFORM_DATA_AD7298_H__
>  
>  /**
>   * struct ad7298_platform_data - Platform data for the ad7298 ADC driver
> 
