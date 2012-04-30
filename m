Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:58139 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266Ab2D3NsQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Apr 2012 09:48:16 -0400
Message-ID: <4F9E9818.6080605@cam.ac.uk>
Date: Mon, 30 Apr 2012 14:48:08 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: jic23@kernel.org, linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] staging: iio: adc: convert ADI drivers to use kfifo.
References: <1335788878-30687-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1335788878-30687-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 4/30/2012 1:27 PM, michael.hennerich@analog.com wrote:
> From: Michael Hennerich<michael.hennerich@analog.com>
>
> sw_ring is depreciated and therefore won't move out of staging.
> Prerequisite for lifting affected drivers is to convert them to kfifo.
All look fine to me.
>
> Signed-off-by: Michael Hennerich<michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   drivers/staging/iio/adc/Kconfig       |   12 ++++++------
>   drivers/staging/iio/adc/ad7192.c      |   12 ++++++------
>   drivers/staging/iio/adc/ad7298_ring.c |   12 ++++++------
>   drivers/staging/iio/adc/ad7476_ring.c |   12 ++++++------
>   drivers/staging/iio/adc/ad7606_ring.c |   12 ++++++------
>   drivers/staging/iio/adc/ad7793.c      |   12 ++++++------
>   drivers/staging/iio/adc/ad7887_ring.c |   12 ++++++------
>   drivers/staging/iio/adc/ad799x_ring.c |   12 ++++++------
>   8 files changed, 48 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
> index 9ae5467..2490dd2 100644
> --- a/drivers/staging/iio/adc/Kconfig
> +++ b/drivers/staging/iio/adc/Kconfig
> @@ -25,7 +25,7 @@ config AD7606
>   	depends on GPIOLIB
>   	select IIO_BUFFER
>   	select IIO_TRIGGER
> -	select IIO_SW_RING
> +	select IIO_KFIFO_BUF
>   	help
>   	  Say yes here to build support for Analog Devices:
>   	  ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
> @@ -63,7 +63,7 @@ config AD799X_RING_BUFFER
>   	bool "Analog Devices AD799x: use ring buffer"
>   	depends on AD799X
>   	select IIO_BUFFER
> -	select IIO_SW_RING
> +	select IIO_KFIFO_BUF
>   	help
>   	  Say yes here to include ring buffer support in the AD799X
>   	  ADC driver.
> @@ -72,7 +72,7 @@ config AD7476
>   	tristate "Analog Devices AD7475/6/7/8 AD7466/7/8 and AD7495 ADC driver"
>   	depends on SPI
>   	select IIO_BUFFER
> -	select IIO_SW_RING
> +	select IIO_KFIFO_BUF
>   	select IIO_TRIGGER
>   	help
>   	  Say yes here to build support for Analog Devices
> @@ -87,7 +87,7 @@ config AD7887
>   	tristate "Analog Devices AD7887 ADC driver"
>   	depends on SPI
>   	select IIO_BUFFER
> -	select IIO_SW_RING
> +	select IIO_KFIFO_BUF
>   	select IIO_TRIGGER
>   	help
>   	  Say yes here to build support for Analog Devices
> @@ -113,7 +113,7 @@ config AD7793
>   	tristate "Analog Devices AD7792 AD7793 ADC driver"
>   	depends on SPI
>   	select IIO_BUFFER
> -	select IIO_SW_RING
> +	select IIO_KFIFO_BUF
>   	select IIO_TRIGGER
>   	help
>   	  Say yes here to build support for Analog Devices
> @@ -135,7 +135,7 @@ config AD7192
>   	tristate "Analog Devices AD7190 AD7192 AD7195 ADC driver"
>   	depends on SPI
>   	select IIO_BUFFER
> -	select IIO_SW_RING
> +	select IIO_KFIFO_BUF
>   	select IIO_TRIGGER
>   	help
>   	  Say yes here to build support for Analog Devices AD7190,
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index 7b44705..c9b4605 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -20,7 +20,7 @@
>   #include<linux/iio/iio.h>
>   #include<linux/iio/sysfs.h>
>   #include<linux/iio/buffer.h>
> -#include "../ring_sw.h"
> +#include<linux/iio/kfifo_buf.h>
>   #include<linux/iio/trigger.h>
>   #include<linux/iio/trigger_consumer.h>
>
> @@ -544,7 +544,7 @@ static int ad7192_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>   {
>   	int ret;
>
> -	indio_dev->buffer = iio_sw_rb_allocate(indio_dev);
> +	indio_dev->buffer = iio_kfifo_allocate(indio_dev);
>   	if (!indio_dev->buffer) {
>   		ret = -ENOMEM;
>   		goto error_ret;
> @@ -557,7 +557,7 @@ static int ad7192_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>   						 indio_dev->id);
>   	if (indio_dev->pollfunc == NULL) {
>   		ret = -ENOMEM;
> -		goto error_deallocate_sw_rb;
> +		goto error_deallocate_kfifo;
>   	}
>
>   	/* Ring buffer functions - here trigger setup related */
> @@ -567,8 +567,8 @@ static int ad7192_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>   	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
>   	return 0;
>
> -error_deallocate_sw_rb:
> -	iio_sw_rb_free(indio_dev->buffer);
> +error_deallocate_kfifo:
> +	iio_kfifo_free(indio_dev->buffer);
>   error_ret:
>   	return ret;
>   }
> @@ -576,7 +576,7 @@ error_ret:
>   static void ad7192_ring_cleanup(struct iio_dev *indio_dev)
>   {
>   	iio_dealloc_pollfunc(indio_dev->pollfunc);
> -	iio_sw_rb_free(indio_dev->buffer);
> +	iio_kfifo_free(indio_dev->buffer);
>   }
>
>   /**
> diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
> index 943caa3..0da017e 100644
> --- a/drivers/staging/iio/adc/ad7298_ring.c
> +++ b/drivers/staging/iio/adc/ad7298_ring.c
> @@ -13,7 +13,7 @@
>
>   #include<linux/iio/iio.h>
>   #include<linux/iio/buffer.h>
> -#include "../ring_sw.h"
> +#include<linux/iio/kfifo_buf.h>
>   #include<linux/iio/trigger_consumer.h>
>
>   #include "ad7298.h"
> @@ -118,7 +118,7 @@ int ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>   {
>   	int ret;
>
> -	indio_dev->buffer = iio_sw_rb_allocate(indio_dev);
> +	indio_dev->buffer = iio_kfifo_allocate(indio_dev);
>   	if (!indio_dev->buffer) {
>   		ret = -ENOMEM;
>   		goto error_ret;
> @@ -132,7 +132,7 @@ int ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>
>   	if (indio_dev->pollfunc == NULL) {
>   		ret = -ENOMEM;
> -		goto error_deallocate_sw_rb;
> +		goto error_deallocate_kfifo;
>   	}
>
>   	/* Ring buffer functions - here trigger setup related */
> @@ -143,8 +143,8 @@ int ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>   	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
>   	return 0;
>
> -error_deallocate_sw_rb:
> -	iio_sw_rb_free(indio_dev->buffer);
> +error_deallocate_kfifo:
> +	iio_kfifo_free(indio_dev->buffer);
>   error_ret:
>   	return ret;
>   }
> @@ -152,5 +152,5 @@ error_ret:
>   void ad7298_ring_cleanup(struct iio_dev *indio_dev)
>   {
>   	iio_dealloc_pollfunc(indio_dev->pollfunc);
> -	iio_sw_rb_free(indio_dev->buffer);
> +	iio_kfifo_free(indio_dev->buffer);
>   }
> diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
> index 5140389..fb50b20 100644
> --- a/drivers/staging/iio/adc/ad7476_ring.c
> +++ b/drivers/staging/iio/adc/ad7476_ring.c
> @@ -15,7 +15,7 @@
>
>   #include<linux/iio/iio.h>
>   #include<linux/iio/buffer.h>
> -#include "../ring_sw.h"
> +#include<linux/iio/kfifo_buf.h>
>   #include<linux/iio/trigger_consumer.h>
>
>   #include "ad7476.h"
> @@ -63,7 +63,7 @@ int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>   	struct ad7476_state *st = iio_priv(indio_dev);
>   	int ret = 0;
>
> -	indio_dev->buffer = iio_sw_rb_allocate(indio_dev);
> +	indio_dev->buffer = iio_kfifo_allocate(indio_dev);
>   	if (!indio_dev->buffer) {
>   		ret = -ENOMEM;
>   		goto error_ret;
> @@ -78,7 +78,7 @@ int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>   				     indio_dev->id);
>   	if (indio_dev->pollfunc == NULL) {
>   		ret = -ENOMEM;
> -		goto error_deallocate_sw_rb;
> +		goto error_deallocate_kfifo;
>   	}
>
>   	/* Ring buffer functions - here trigger setup related */
> @@ -89,8 +89,8 @@ int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>   	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
>   	return 0;
>
> -error_deallocate_sw_rb:
> -	iio_sw_rb_free(indio_dev->buffer);
> +error_deallocate_kfifo:
> +	iio_kfifo_free(indio_dev->buffer);
>   error_ret:
>   	return ret;
>   }
> @@ -98,5 +98,5 @@ error_ret:
>   void ad7476_ring_cleanup(struct iio_dev *indio_dev)
>   {
>   	iio_dealloc_pollfunc(indio_dev->pollfunc);
> -	iio_sw_rb_free(indio_dev->buffer);
> +	iio_kfifo_free(indio_dev->buffer);
>   }
> diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
> index 3dd9602..3faff0e 100644
> --- a/drivers/staging/iio/adc/ad7606_ring.c
> +++ b/drivers/staging/iio/adc/ad7606_ring.c
> @@ -13,7 +13,7 @@
>
>   #include<linux/iio/iio.h>
>   #include<linux/iio/buffer.h>
> -#include "../ring_sw.h"
> +#include<linux/iio/kfifo_buf.h>
>   #include<linux/iio/trigger_consumer.h>
>
>   #include "ad7606.h"
> @@ -102,7 +102,7 @@ int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>   	struct ad7606_state *st = iio_priv(indio_dev);
>   	int ret;
>
> -	indio_dev->buffer = iio_sw_rb_allocate(indio_dev);
> +	indio_dev->buffer = iio_kfifo_allocate(indio_dev);
>   	if (!indio_dev->buffer) {
>   		ret = -ENOMEM;
>   		goto error_ret;
> @@ -117,7 +117,7 @@ int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>   						 indio_dev->id);
>   	if (indio_dev->pollfunc == NULL) {
>   		ret = -ENOMEM;
> -		goto error_deallocate_sw_rb;
> +		goto error_deallocate_kfifo;
>   	}
>
>   	/* Ring buffer functions - here trigger setup related */
> @@ -131,8 +131,8 @@ int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>   	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
>   	return 0;
>
> -error_deallocate_sw_rb:
> -	iio_sw_rb_free(indio_dev->buffer);
> +error_deallocate_kfifo:
> +	iio_kfifo_free(indio_dev->buffer);
>   error_ret:
>   	return ret;
>   }
> @@ -140,5 +140,5 @@ error_ret:
>   void ad7606_ring_cleanup(struct iio_dev *indio_dev)
>   {
>   	iio_dealloc_pollfunc(indio_dev->pollfunc);
> -	iio_sw_rb_free(indio_dev->buffer);
> +	iio_kfifo_free(indio_dev->buffer);
>   }
> diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
> index 8ffdd80..c40f766 100644
> --- a/drivers/staging/iio/adc/ad7793.c
> +++ b/drivers/staging/iio/adc/ad7793.c
> @@ -21,7 +21,7 @@
>   #include<linux/iio/iio.h>
>   #include<linux/iio/sysfs.h>
>   #include<linux/iio/buffer.h>
> -#include "../ring_sw.h"
> +#include<linux/iio/kfifo_buf.h>
>   #include<linux/iio/trigger.h>
>   #include<linux/iio/trigger_consumer.h>
>
> @@ -409,7 +409,7 @@ static int ad7793_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>   {
>   	int ret;
>
> -	indio_dev->buffer = iio_sw_rb_allocate(indio_dev);
> +	indio_dev->buffer = iio_kfifo_allocate(indio_dev);
>   	if (!indio_dev->buffer) {
>   		ret = -ENOMEM;
>   		goto error_ret;
> @@ -422,7 +422,7 @@ static int ad7793_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>   						 indio_dev->id);
>   	if (indio_dev->pollfunc == NULL) {
>   		ret = -ENOMEM;
> -		goto error_deallocate_sw_rb;
> +		goto error_deallocate_kfifo;
>   	}
>
>   	/* Ring buffer functions - here trigger setup related */
> @@ -432,8 +432,8 @@ static int ad7793_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>   	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
>   	return 0;
>
> -error_deallocate_sw_rb:
> -	iio_sw_rb_free(indio_dev->buffer);
> +error_deallocate_kfifo:
> +	iio_kfifo_free(indio_dev->buffer);
>   error_ret:
>   	return ret;
>   }
> @@ -441,7 +441,7 @@ error_ret:
>   static void ad7793_ring_cleanup(struct iio_dev *indio_dev)
>   {
>   	iio_dealloc_pollfunc(indio_dev->pollfunc);
> -	iio_sw_rb_free(indio_dev->buffer);
> +	iio_kfifo_free(indio_dev->buffer);
>   }
>
>   /**
> diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
> index f1846db..92735c6 100644
> --- a/drivers/staging/iio/adc/ad7887_ring.c
> +++ b/drivers/staging/iio/adc/ad7887_ring.c
> @@ -14,7 +14,7 @@
>
>   #include<linux/iio/iio.h>
>   #include<linux/iio/buffer.h>
> -#include "../ring_sw.h"
> +#include<linux/iio/kfifo_buf.h>
>   #include<linux/iio/trigger_consumer.h>
>
>   #include "ad7887.h"
> @@ -114,7 +114,7 @@ int ad7887_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>   {
>   	int ret;
>
> -	indio_dev->buffer = iio_sw_rb_allocate(indio_dev);
> +	indio_dev->buffer = iio_kfifo_allocate(indio_dev);
>   	if (!indio_dev->buffer) {
>   		ret = -ENOMEM;
>   		goto error_ret;
> @@ -127,7 +127,7 @@ int ad7887_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>   						 indio_dev->id);
>   	if (indio_dev->pollfunc == NULL) {
>   		ret = -ENOMEM;
> -		goto error_deallocate_sw_rb;
> +		goto error_deallocate_kfifo;
>   	}
>   	/* Ring buffer functions - here trigger setup related */
>   	indio_dev->setup_ops =&ad7887_ring_setup_ops;
> @@ -136,8 +136,8 @@ int ad7887_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>   	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
>   	return 0;
>
> -error_deallocate_sw_rb:
> -	iio_sw_rb_free(indio_dev->buffer);
> +error_deallocate_kfifo:
> +	iio_kfifo_free(indio_dev->buffer);
>   error_ret:
>   	return ret;
>   }
> @@ -145,5 +145,5 @@ error_ret:
>   void ad7887_ring_cleanup(struct iio_dev *indio_dev)
>   {
>   	iio_dealloc_pollfunc(indio_dev->pollfunc);
> -	iio_sw_rb_free(indio_dev->buffer);
> +	iio_kfifo_free(indio_dev->buffer);
>   }
> diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
> index 18366b5..10bcb81 100644
> --- a/drivers/staging/iio/adc/ad799x_ring.c
> +++ b/drivers/staging/iio/adc/ad799x_ring.c
> @@ -18,7 +18,7 @@
>
>   #include<linux/iio/iio.h>
>   #include<linux/iio/buffer.h>
> -#include "../ring_sw.h"
> +#include<linux/iio/kfifo_buf.h>
>   #include<linux/iio/trigger_consumer.h>
>
>   #include "ad799x.h"
> @@ -120,7 +120,7 @@ int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>   {
>   	int ret = 0;
>
> -	indio_dev->buffer = iio_sw_rb_allocate(indio_dev);
> +	indio_dev->buffer = iio_kfifo_allocate(indio_dev);
>   	if (!indio_dev->buffer) {
>   		ret = -ENOMEM;
>   		goto error_ret;
> @@ -134,7 +134,7 @@ int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>   						 indio_dev->id);
>   	if (indio_dev->pollfunc == NULL) {
>   		ret = -ENOMEM;
> -		goto error_deallocate_sw_rb;
> +		goto error_deallocate_kfifo;
>   	}
>
>   	/* Ring buffer functions - here trigger setup related */
> @@ -145,8 +145,8 @@ int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>   	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
>   	return 0;
>
> -error_deallocate_sw_rb:
> -	iio_sw_rb_free(indio_dev->buffer);
> +error_deallocate_kfifo:
> +	iio_kfifo_free(indio_dev->buffer);
>   error_ret:
>   	return ret;
>   }
> @@ -154,5 +154,5 @@ error_ret:
>   void ad799x_ring_cleanup(struct iio_dev *indio_dev)
>   {
>   	iio_dealloc_pollfunc(indio_dev->pollfunc);
> -	iio_sw_rb_free(indio_dev->buffer);
> +	iio_kfifo_free(indio_dev->buffer);
>   }

