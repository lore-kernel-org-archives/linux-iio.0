Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:60017 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581Ab1CJMN2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 10 Mar 2011 07:13:28 -0500
Message-ID: <4D78C09E.9080502@cam.ac.uk>
Date: Thu, 10 Mar 2011 12:14:22 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 3/3] IIO: DAC: AD5446: Add support for AD5601/AD5611/AD5621
References: <1299757966-25592-1-git-send-email-michael.hennerich@analog.com> <1299757966-25592-3-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1299757966-25592-3-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/10/11 11:52, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> This patch adds support for the AD5601/AD5611/AD5621 single channel,
> 8-/10-/12-bit, buffered voltage output DACs.
> 
Queries on ordering of part numbers in line.  Nitpick though so up to
you whether you want to have them sorted by number or grouped in some
other way.
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/dac/Kconfig  |    3 ++-
>  drivers/staging/iio/dac/ad5446.c |   24 ++++++++++++++++++++++++
>  drivers/staging/iio/dac/ad5446.h |    3 +++
>  3 files changed, 29 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/iio/dac/Kconfig b/drivers/staging/iio/dac/Kconfig
> index 3c72871..9539545 100644
> --- a/drivers/staging/iio/dac/Kconfig
> +++ b/drivers/staging/iio/dac/Kconfig
> @@ -15,7 +15,8 @@ config AD5446
>  	depends on SPI
>  	help
>  	  Say yes here to build support for Analog Devices AD5444, AD5446,
> -	  AD5512A, AD5542A, AD5543, AD5553, AD5620, AD5640, AD5660 DACs.
> +	  AD5512A, AD5542A, AD5543, AD5553, AD5601, AD5611, AD5621, AD5620,
Slightly odd ordering at end of line above...  If the intent is numerical order
then you'll want to fix that.

> +	  AD5640, AD5660 DACs.
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad5446.
> diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
> index 861a7ea..8623a72 100644
> --- a/drivers/staging/iio/dac/ad5446.c
> +++ b/drivers/staging/iio/dac/ad5446.c
> @@ -269,6 +269,27 @@ static const struct ad5446_chip_info ad5446_chip_info_tbl[] = {
>  		.left_shift = 0,
>  		.store_sample = ad5542_store_sample,
>  	},
> +	[ID_AD5601] = {
> +		.bits = 8,
> +		.storagebits = 16,
> +		.left_shift = 6,
> +		.store_sample = ad5542_store_sample,
> +		.store_pwr_down = ad5620_store_pwr_down,
> +	},
> +	[ID_AD5611] = {
> +		.bits = 10,
> +		.storagebits = 16,
> +		.left_shift = 4,
> +		.store_sample = ad5542_store_sample,
> +		.store_pwr_down = ad5620_store_pwr_down,
> +	},
Again, is the intent numerical order here?
> +	[ID_AD5621] = {
> +		.bits = 12,
> +		.storagebits = 16,
> +		.left_shift = 2,
> +		.store_sample = ad5542_store_sample,
> +		.store_pwr_down = ad5620_store_pwr_down,
> +	},
>  	[ID_AD5620_2500] = {
>  		.bits = 12,
>  		.storagebits = 16,
> @@ -424,6 +445,9 @@ static const struct spi_device_id ad5446_id[] = {
>  	{"ad5542a", ID_AD5542A},
>  	{"ad5543", ID_AD5543},
>  	{"ad5553", ID_AD5553},
> +	{"ad5601", ID_AD5601},
> +	{"ad5611", ID_AD5611},
> +	{"ad5621", ID_AD5621},
and here?
>  	{"ad5620-2500", ID_AD5620_2500}, /* AD5620/40/60: */
>  	{"ad5620-1250", ID_AD5620_1250}, /* part numbers may look differently */
>  	{"ad5640-2500", ID_AD5640_2500},
> diff --git a/drivers/staging/iio/dac/ad5446.h b/drivers/staging/iio/dac/ad5446.h
> index e9397a6..7ac63ab 100644
> --- a/drivers/staging/iio/dac/ad5446.h
> +++ b/drivers/staging/iio/dac/ad5446.h
> @@ -96,6 +96,9 @@ enum ad5446_supported_device_ids {
>  	ID_AD5543,
>  	ID_AD5512A,
>  	ID_AD5553,
> +	ID_AD5601,
> +	ID_AD5611,
> +	ID_AD5621,
>  	ID_AD5620_2500,
>  	ID_AD5620_1250,
>  	ID_AD5640_2500,

