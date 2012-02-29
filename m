Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44385 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773Ab2B2UPc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Feb 2012 15:15:32 -0500
Message-ID: <4F4E87A9.2030202@kernel.org>
Date: Wed, 29 Feb 2012 20:16:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 3/3] iio: Convert platform_drivers to use module_platform_driver
References: <1329913815-5382-1-git-send-email-michael.hennerich@analog.com> <1329913815-5382-3-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1329913815-5382-3-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/22/2012 12:30 PM, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> No functional changes.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/adc/ad7606_par.c               |   13 +------------
>  drivers/staging/iio/trigger/iio-trig-bfin-timer.c  |   12 +-----------
>  drivers/staging/iio/trigger/iio-trig-gpio.c        |   12 +-----------
>  .../staging/iio/trigger/iio-trig-periodic-rtc.c    |   12 +-----------
>  4 files changed, 4 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
> index cff9756..bb152a8 100644
> --- a/drivers/staging/iio/adc/ad7606_par.c
> +++ b/drivers/staging/iio/adc/ad7606_par.c
> @@ -173,18 +173,7 @@ static struct platform_driver ad7606_driver = {
>  	},
>  };
>  
> -static int __init ad7606_init(void)
> -{
> -	return platform_driver_register(&ad7606_driver);
> -}
> -
> -static void __exit ad7606_cleanup(void)
> -{
> -	platform_driver_unregister(&ad7606_driver);
> -}
> -
> -module_init(ad7606_init);
> -module_exit(ad7606_cleanup);
> +module_platform_driver(ad7606_driver);
>  
>  MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
>  MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
> diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> index 1cbb25d..665653d 100644
> --- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> +++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> @@ -232,17 +232,7 @@ static struct platform_driver iio_bfin_tmr_trigger_driver = {
>  	.remove = __devexit_p(iio_bfin_tmr_trigger_remove),
>  };
>  
> -static int __init iio_bfin_tmr_trig_init(void)
> -{
> -	return platform_driver_register(&iio_bfin_tmr_trigger_driver);
> -}
> -module_init(iio_bfin_tmr_trig_init);
> -
> -static void __exit iio_bfin_tmr_trig_exit(void)
> -{
> -	platform_driver_unregister(&iio_bfin_tmr_trigger_driver);
> -}
> -module_exit(iio_bfin_tmr_trig_exit);
> +module_platform_driver(iio_bfin_tmr_trigger_driver);
>  
>  MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
>  MODULE_DESCRIPTION("Blackfin system timer based trigger for the iio subsystem");
> diff --git a/drivers/staging/iio/trigger/iio-trig-gpio.c b/drivers/staging/iio/trigger/iio-trig-gpio.c
> index f2a6559..a346594 100644
> --- a/drivers/staging/iio/trigger/iio-trig-gpio.c
> +++ b/drivers/staging/iio/trigger/iio-trig-gpio.c
> @@ -160,17 +160,7 @@ static struct platform_driver iio_gpio_trigger_driver = {
>  	},
>  };
>  
> -static int __init iio_gpio_trig_init(void)
> -{
> -	return platform_driver_register(&iio_gpio_trigger_driver);
> -}
> -module_init(iio_gpio_trig_init);
> -
> -static void __exit iio_gpio_trig_exit(void)
> -{
> -	platform_driver_unregister(&iio_gpio_trigger_driver);
> -}
> -module_exit(iio_gpio_trig_exit);
> +module_platform_driver(iio_gpio_trigger_driver);
>  
>  MODULE_AUTHOR("Jonathan Cameron <jic23@cam.ac.uk>");
>  MODULE_DESCRIPTION("Example gpio trigger for the iio subsystem");
> diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> index bd7416b..a80cf67 100644
> --- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> +++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> @@ -195,18 +195,8 @@ static struct platform_driver iio_trig_periodic_rtc_driver = {
>  	},
>  };
>  
> -static int __init iio_trig_periodic_rtc_init(void)
> -{
> -	return platform_driver_register(&iio_trig_periodic_rtc_driver);
> -}
> -
> -static void __exit iio_trig_periodic_rtc_exit(void)
> -{
> -	return platform_driver_unregister(&iio_trig_periodic_rtc_driver);
> -}
> +module_platform_driver(iio_trig_periodic_rtc_driver);
>  
> -module_init(iio_trig_periodic_rtc_init);
> -module_exit(iio_trig_periodic_rtc_exit);
>  MODULE_AUTHOR("Jonathan Cameron <jic23@cam.ac.uk>");
>  MODULE_DESCRIPTION("Periodic realtime clock  trigger for the iio subsystem");
>  MODULE_LICENSE("GPL v2");

