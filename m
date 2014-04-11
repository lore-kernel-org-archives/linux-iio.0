Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39186 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754930AbaDKUrh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 Apr 2014 16:47:37 -0400
Message-ID: <53485536.10900@kernel.org>
Date: Fri, 11 Apr 2014 21:48:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jean Delvare <jdelvare@suse.de>, linux-iio@vger.kernel.org
CC: Kukjin Kim <kgene.kim@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2] iio: adc: Fix exynos_adc dependencies
References: <20140408152451.6dc2b230@endymion.delvare>
In-Reply-To: <20140408152451.6dc2b230@endymion.delvare>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/04/14 14:24, Jean Delvare wrote:
> EXYNOS_ADC shouldn't only depend on OF. It is useless on architectures
> other than Exynos so it should depend on ARCH_EXYNOS (which implies
> OF.)
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
Applied to the togreg branch of iio.git - initially pushed out as testing.

Thanks,

Jonathan
> ---
> Changes since v1:
>   * Alternatively depend on COMPILE_TEST as requested by Lars-Peter
>     Clausen. Thanks for the review!
>
>   drivers/iio/adc/Kconfig |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-3.15-rc0.orig/drivers/iio/adc/Kconfig	2014-04-08 14:54:37.418421834 +0200
> +++ linux-3.15-rc0/drivers/iio/adc/Kconfig	2014-04-08 15:20:42.735670677 +0200
> @@ -107,7 +107,7 @@ config AT91_ADC
>
>   config EXYNOS_ADC
>   	bool "Exynos ADC driver support"
> -	depends on OF
> +	depends on ARCH_EXYNOS || (OF && COMPILE_TEST)
>   	help
>   	  Core support for the ADC block found in the Samsung EXYNOS series
>   	  of SoCs for drivers such as the touchscreen and hwmon to use to share
>
>

