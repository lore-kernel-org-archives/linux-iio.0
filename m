Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53007 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932289AbbEPJ5j (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 May 2015 05:57:39 -0400
Message-ID: <55571492.3080605@kernel.org>
Date: Sat, 16 May 2015 10:57:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, Paul Cercueil <paul.cercueil@analog.com>
Subject: Re: [PATCH 2/5] iio: adis16400: Use != channel indices for the two
 voltage channels
References: <1431703118-32676-1-git-send-email-lars@metafoo.de> <1431703118-32676-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1431703118-32676-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/05/15 16:18, Lars-Peter Clausen wrote:
> From: Paul Cercueil <paul.cercueil@analog.com>
> 
> Previously, the two voltage channels had the same ID, which didn't cause
> conflicts in sysfs only because one channel is named and the other isn't;
> this is still violating the spec though, two indexed channels should never
> have the same index.
> 
> Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to fixes-togreg branch, marked for stable.
> ---
>  drivers/iio/imu/adis16400_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
> index 8de6427..7b63788 100644
> --- a/drivers/iio/imu/adis16400_core.c
> +++ b/drivers/iio/imu/adis16400_core.c
> @@ -459,10 +459,10 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> -#define ADIS16400_VOLTAGE_CHAN(addr, bits, name, si) { \
> +#define ADIS16400_VOLTAGE_CHAN(addr, bits, name, si, chn) { \
>  	.type = IIO_VOLTAGE, \
>  	.indexed = 1, \
> -	.channel = 0, \
> +	.channel = chn, \
>  	.extend_name = name, \
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
>  		BIT(IIO_CHAN_INFO_SCALE), \
> @@ -479,10 +479,10 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
>  }
>  
>  #define ADIS16400_SUPPLY_CHAN(addr, bits) \
> -	ADIS16400_VOLTAGE_CHAN(addr, bits, "supply", ADIS16400_SCAN_SUPPLY)
> +	ADIS16400_VOLTAGE_CHAN(addr, bits, "supply", ADIS16400_SCAN_SUPPLY, 0)
>  
>  #define ADIS16400_AUX_ADC_CHAN(addr, bits) \
> -	ADIS16400_VOLTAGE_CHAN(addr, bits, NULL, ADIS16400_SCAN_ADC)
> +	ADIS16400_VOLTAGE_CHAN(addr, bits, NULL, ADIS16400_SCAN_ADC, 1)
>  
>  #define ADIS16400_GYRO_CHAN(mod, addr, bits) { \
>  	.type = IIO_ANGL_VEL, \
> 

