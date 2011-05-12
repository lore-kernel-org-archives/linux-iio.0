Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:53257 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756069Ab1ELNiV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 May 2011 09:38:21 -0400
Message-ID: <4DCBE36A.5050801@cam.ac.uk>
Date: Thu, 12 May 2011 14:40:58 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org, randy.dunlap@oracle.com
Subject: Re: [PATCH] iio: adc: ad7780: Add missing GPIOLIB dependency
References: <1305200160-2217-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1305200160-2217-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/12/11 12:36, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Reported-by: Randy Dunlap <randy.dunlap@oracle.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/adc/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
> index 4159389..0a19cee 100644
> --- a/drivers/staging/iio/adc/Kconfig
> +++ b/drivers/staging/iio/adc/Kconfig
> @@ -145,6 +145,7 @@ config AD7887
>  config AD7780
>  	tristate "Analog Devices AD7780 AD7781 ADC driver"
>  	depends on SPI
> +	depends on GPIOLIB
>  	help
>  	  Say yes here to build support for Analog Devices
>  	  AD7780 and AD7781 SPI analog to digital convertors (ADC).
> --
> 1.6.0.2
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

