Return-Path: <lars@metafoo.de>
Message-ID: <5343F2E3.2020809@metafoo.de>
Date: Tue, 08 Apr 2014 15:00:19 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jean Delvare <jdelvare@suse.de>
CC: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
 Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCH] iio: adc: Fix exynos_adc dependencies
References: <20140408145421.530243bf@endymion.delvare>
In-Reply-To: <20140408145421.530243bf@endymion.delvare>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 04/08/2014 02:54 PM, Jean Delvare wrote:
> --- linux-3.15-rc0.orig/drivers/iio/adc/Kconfig	2014-04-07 10:23:04.475166797 +0200
> +++ linux-3.15-rc0/drivers/iio/adc/Kconfig	2014-04-08 14:49:16.205616632 +0200
> @@ -107,7 +107,7 @@ config AT91_ADC
>
>   config EXYNOS_ADC
>   	bool "Exynos ADC driver support"
> -	depends on OF
> +	depends on ARCH_EXYNOS

|| COMPILE_TEST
