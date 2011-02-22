Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:43731 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437Ab1BVOFq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Feb 2011 09:05:46 -0500
Message-ID: <4D63C2D6.8000502@cam.ac.uk>
Date: Tue, 22 Feb 2011 14:06:14 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] IIO: DAC: Add support for the AD5543/AD5553
References: <1297694788-10539-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1297694788-10539-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/14/11 14:46, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Add support for the AD5543/AD5553 SPI 16-/14-Bit DACs
> Fix typo in kconfig description
Now this is the sort of patch I like to see for adding new devices support :)
Couple of trivial questions about ordering of device names inline.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/dac/Kconfig  |    6 +++---
>  drivers/staging/iio/dac/ad5446.c |   12 ++++++++++++
>  drivers/staging/iio/dac/ad5446.h |    2 ++
>  3 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/dac/Kconfig b/drivers/staging/iio/dac/Kconfig
> index 2120904..64e6730 100644
> --- a/drivers/staging/iio/dac/Kconfig
> +++ b/drivers/staging/iio/dac/Kconfig
> @@ -11,11 +11,11 @@ config AD5624R_SPI
>  	  AD5664R convertors (DAC). This driver uses the common SPI interface.
>  
>  config AD5446
> -	tristate "Analog Devices AD5444/6, AD5620/40/60 and AD5541A/12A DAC SPI driver"
> +	tristate "Analog Devices AD5444/6, AD5620/40/60 and AD5542A/12A DAC SPI driver"
Do you want the new devices in this description?  It's getting a bit long anyway
so I can see why you might not want them there!
>  	depends on SPI
>  	help
> -	  Say yes here to build support for Analog Devices AD5444, AD5446,
> -	  AD5620, AD5640, AD5660 and AD5541A, AD5512A DACs.
> +	  Say yes here to build support for Analog Devices AD5444, AD5446, AD5543,
> +	  AD5553, AD5620, AD5640, AD5660 and AD5542A, AD5512A DACs.
Why this ordering?
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad5446.
> diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
> index 0f87eca..dcec297 100644
> --- a/drivers/staging/iio/dac/ad5446.c
> +++ b/drivers/staging/iio/dac/ad5446.c
> @@ -132,12 +132,24 @@ static const struct ad5446_chip_info ad5446_chip_info_tbl[] = {
>  		.left_shift = 0,
>  		.store_sample = ad5542_store_sample,
>  	},
> +	[ID_AD5543] = {
> +		.bits = 16,
> +		.storagebits = 16,
> +		.left_shift = 0,
> +		.store_sample = ad5542_store_sample,
> +	},
>  	[ID_AD5512A] = {
>  		.bits = 12,
>  		.storagebits = 16,
>  		.left_shift = 4,
>  		.store_sample = ad5542_store_sample,
>  	},
> +	[ID_AD5553] = {
> +		.bits = 14,
> +		.storagebits = 16,
> +		.left_shift = 0,
> +		.store_sample = ad5542_store_sample,
> +	},
>  	[ID_AD5620_2500] = {
>  		.bits = 12,
>  		.storagebits = 16,
> diff --git a/drivers/staging/iio/dac/ad5446.h b/drivers/staging/iio/dac/ad5446.h
> index 902542e..0cb9c14 100644
> --- a/drivers/staging/iio/dac/ad5446.h
> +++ b/drivers/staging/iio/dac/ad5446.h
> @@ -84,7 +84,9 @@ enum ad5446_supported_device_ids {
>  	ID_AD5444,
>  	ID_AD5446,
>  	ID_AD5542A,
> +	ID_AD5543,
>  	ID_AD5512A,
This does seem like a slightly random order. Care to explain why it is like this?
(applies to the avoid use of these as well)
> +	ID_AD5553,
>  	ID_AD5620_2500,
>  	ID_AD5620_1250,
>  	ID_AD5640_2500,

