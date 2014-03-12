Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:62587 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963AbaCLUqc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 12 Mar 2014 16:46:32 -0400
Message-ID: <5320C79B.4000109@gmx.de>
Date: Wed, 12 Mar 2014 21:46:19 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
CC: sr@denx.de
Subject: Re: [PATCH 5/5] iio:adc:spear_adc move out of staging
References: <1394570219-7672-1-git-send-email-jic23@kernel.org> <1394570219-7672-6-git-send-email-jic23@kernel.org>
In-Reply-To: <1394570219-7672-6-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron schrieb:
> This simple driver is ready to move out of staging.
>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/iio/adc/Kconfig             |   8 +
>  drivers/iio/adc/Makefile            |   1 +
>  drivers/iio/adc/spear_adc.c         | 429 ++++++++++++++++++++++++++++++++++++
>  drivers/staging/iio/adc/Kconfig     |   8 -
>  drivers/staging/iio/adc/Makefile    |   1 -
>  drivers/staging/iio/adc/spear_adc.c | 429 ------------------------------------
>  6 files changed, 438 insertions(+), 438 deletions(-)
>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 5553206..2e3e1b0 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -164,6 +164,14 @@ config NAU7802
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called nau7802.
>  
> +config SPEAR_ADC
> +	tristate "ST SPEAr ADC"
> +	depends on PLAT_SPEAR || COMPILE_TEST
Are you sure to keep COMPILE_TEST in?
> +	depends on HAS_IOMEM
> +	help
> +	  Say yes here to build support for the integrated ADC inside the
> +	  ST SPEAr SoC. Provides direct access via sysfs.
> +
>  config TI_ADC081C
>  	tristate "Texas Instruments ADC081C021/027"
>  	depends on I2C
>

