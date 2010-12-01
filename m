Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:33599 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755015Ab0LAQjQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 1 Dec 2010 11:39:16 -0500
Message-ID: <4CF67BCF.7010102@cam.ac.uk>
Date: Wed, 01 Dec 2010 16:46:07 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] staging: iio: dds: ad9832: Fix kconfig description
References: <1291220542-24848-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1291220542-24848-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/01/10 16:22, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> The AD9832 driver doesn't support the AD9833 and AD9834
> 
For what it's worth...
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/dds/Kconfig |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/dds/Kconfig b/drivers/staging/iio/dds/Kconfig
> index d045ed6..7969be2 100644
> --- a/drivers/staging/iio/dds/Kconfig
> +++ b/drivers/staging/iio/dds/Kconfig
> @@ -11,11 +11,11 @@ config AD5930
>  	  ad5930/ad5932, provides direct access via sysfs.
>  
>  config AD9832
> -	tristate "Analog Devices ad9832/3/4/5 driver"
> +	tristate "Analog Devices ad9832/5 driver"
>  	depends on SPI
>  	help
>  	  Say yes here to build support for Analog Devices DDS chip
> -	  ad9832/3/4/5, provides direct access via sysfs.
> +	  ad9832 and ad9835, provides direct access via sysfs.
>  
>  config AD9850
>  	tristate "Analog Devices ad9850/1 driver"

