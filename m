Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:56243 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061Ab0KWMfv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 23 Nov 2010 07:35:51 -0500
Message-ID: <4CEBB6B3.9040903@cam.ac.uk>
Date: Tue, 23 Nov 2010 12:42:27 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: greg@kroah.com, linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] staging: iio: dac: ad5446: Remove unused sign member
 from chip specific information structure
References: <1290508813-8599-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1290508813-8599-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/23/10 10:40, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Remove unused sign member from chip specific information structure
> Fix typos
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/dac/ad5446.c |   10 ----------
>  drivers/staging/iio/dac/ad5446.h |    6 ++----
>  2 files changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
> index 4d65d27..e3387cd 100644
> --- a/drivers/staging/iio/dac/ad5446.c
> +++ b/drivers/staging/iio/dac/ad5446.c
> @@ -118,35 +118,30 @@ static const struct ad5446_chip_info ad5446_chip_info_tbl[] = {
>  		.bits = 12,
>  		.storagebits = 16,
>  		.left_shift = 2,
> -		.sign = 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
>  		.store_sample = ad5446_store_sample,
>  	},
>  	[ID_AD5446] = {
>  		.bits = 14,
>  		.storagebits = 16,
>  		.left_shift = 0,
> -		.sign = 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
>  		.store_sample = ad5446_store_sample,
>  	},
>  	[ID_AD5542A] = {
>  		.bits = 16,
>  		.storagebits = 16,
>  		.left_shift = 0,
> -		.sign = 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
>  		.store_sample = ad5542_store_sample,
>  	},
>  	[ID_AD5512A] = {
>  		.bits = 12,
>  		.storagebits = 16,
>  		.left_shift = 4,
> -		.sign = 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
>  		.store_sample = ad5542_store_sample,
>  	},
>  	[ID_AD5620_2500] = {
>  		.bits = 12,
>  		.storagebits = 16,
>  		.left_shift = 2,
> -		.sign = 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
>  		.int_vref_mv = 2500,
>  		.store_sample = ad5620_store_sample,
>  	},
> @@ -154,7 +149,6 @@ static const struct ad5446_chip_info ad5446_chip_info_tbl[] = {
>  		.bits = 12,
>  		.storagebits = 16,
>  		.left_shift = 2,
> -		.sign = 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
>  		.int_vref_mv = 1250,
>  		.store_sample = ad5620_store_sample,
>  	},
> @@ -162,7 +156,6 @@ static const struct ad5446_chip_info ad5446_chip_info_tbl[] = {
>  		.bits = 14,
>  		.storagebits = 16,
>  		.left_shift = 0,
> -		.sign = 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
>  		.int_vref_mv = 2500,
>  		.store_sample = ad5620_store_sample,
>  	},
> @@ -170,7 +163,6 @@ static const struct ad5446_chip_info ad5446_chip_info_tbl[] = {
>  		.bits = 14,
>  		.storagebits = 16,
>  		.left_shift = 0,
> -		.sign = 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
>  		.int_vref_mv = 1250,
>  		.store_sample = ad5620_store_sample,
>  	},
> @@ -178,7 +170,6 @@ static const struct ad5446_chip_info ad5446_chip_info_tbl[] = {
>  		.bits = 16,
>  		.storagebits = 24,
>  		.left_shift = 0,
> -		.sign = 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
>  		.int_vref_mv = 2500,
>  		.store_sample = ad5660_store_sample,
>  	},
> @@ -186,7 +177,6 @@ static const struct ad5446_chip_info ad5446_chip_info_tbl[] = {
>  		.bits = 16,
>  		.storagebits = 24,
>  		.left_shift = 0,
> -		.sign = 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
>  		.int_vref_mv = 1250,
>  		.store_sample = ad5660_store_sample,
>  	},
> diff --git a/drivers/staging/iio/dac/ad5446.h b/drivers/staging/iio/dac/ad5446.h
> index ca795a9..902542e 100644
> --- a/drivers/staging/iio/dac/ad5446.h
> +++ b/drivers/staging/iio/dac/ad5446.h
> @@ -56,20 +56,18 @@ struct ad5446_state {
>  };
>  
>  /**
> - * struct ad5446_chip_info - chip specifc information
> + * struct ad5446_chip_info - chip specific information
>   * @bits:		accuracy of the DAC in bits
>   * @storagebits:	number of bits written to the DAC
>   * @left_shift:		number of bits the datum must be shifted
> - * @sign:		data representation [s]igned or [u]nsigned
>   * @int_vref_mv:	AD5620/40/60: the internal reference voltage
> - * @store_sample:	chip specifc helper function to store the datum
> + * @store_sample:	chip specific helper function to store the datum
>   */
>  
>  struct ad5446_chip_info {
>  	u8				bits;
>  	u8				storagebits;
>  	u8				left_shift;
> -	char				sign;
>  	u16				int_vref_mv;
>  	void (*store_sample)		(struct ad5446_state *st, unsigned val);
>  };

