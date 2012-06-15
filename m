Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:52791 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756398Ab2FOMkx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jun 2012 08:40:53 -0400
Message-ID: <4FDB2D53.6070603@cam.ac.uk>
Date: Fri, 15 Jun 2012 13:40:51 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/4] staging:iio:adis16400: Fix ADIS163xx AUX_ADC address
References: <1339748926-4002-1-git-send-email-lars@metafoo.de> <1339748926-4002-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1339748926-4002-4-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/15/2012 9:28 AM, Lars-Peter Clausen wrote:
> The ADIS163xx variants use a different register address for the auxiliary ADC
> channel than the ADIS16400. This patch fixes them to use the correct address.
Ah well, guess I never bothered testing that channel with an actual 
voltage.. oops.
>
> Signed-off-by: Lars-Peter Clausen<lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   drivers/staging/iio/imu/adis16400.h      |    1 +
>   drivers/staging/iio/imu/adis16400_core.c |    8 +++++---
>   2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/iio/imu/adis16400.h b/drivers/staging/iio/imu/adis16400.h
> index 1f4e987..9dd9f14 100644
> --- a/drivers/staging/iio/imu/adis16400.h
> +++ b/drivers/staging/iio/imu/adis16400.h
> @@ -43,6 +43,7 @@
>
>   #define ADIS16300_PITCH_OUT 0x12 /* X axis inclinometer output measurement */
>   #define ADIS16300_ROLL_OUT  0x14 /* Y axis inclinometer output measurement */
> +#define ADIS16300_AUX_ADC   0x16 /* Auxiliary ADC measurement */
>
>   /* Calibration parameters */
>   #define ADIS16400_XGYRO_OFF 0x1A /* X-axis gyroscope bias offset factor */
> diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
> index 7aa3a9a..3873014 100644
> --- a/drivers/staging/iio/imu/adis16400_core.c
> +++ b/drivers/staging/iio/imu/adis16400_core.c
> @@ -472,11 +472,12 @@ enum adis16400_chan {
>   	temp,
>   	temp0, temp1, temp2,
>   	in1,
> +	in2,
>   	incli_x,
>   	incli_y,
>   };
>
> -static u8 adis16400_addresses[17][2] = {
> +static u8 adis16400_addresses[18][2] = {
>   	[in_supply] = { ADIS16400_SUPPLY_OUT },
>   	[gyro_x] = { ADIS16400_XGYRO_OUT, ADIS16400_XGYRO_OFF },
>   	[gyro_y] = { ADIS16400_YGYRO_OUT, ADIS16400_YGYRO_OFF },
> @@ -491,7 +492,8 @@ static u8 adis16400_addresses[17][2] = {
>   	[temp0] = { ADIS16350_XTEMP_OUT },
>   	[temp1] = { ADIS16350_YTEMP_OUT },
>   	[temp2] = { ADIS16350_ZTEMP_OUT },
> -	[in1] = { ADIS16400_AUX_ADC },
> +	[in1] = { ADIS16300_AUX_ADC },
> +	[in2] = { ADIS16400_AUX_ADC },
>   	[incli_x] = { ADIS16300_PITCH_OUT },
>   	[incli_y] = { ADIS16300_ROLL_OUT }
>   };
> @@ -752,7 +754,7 @@ static struct iio_chan_spec adis16400_channels[] = {
>   		.channel = 1,
>   		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
>   		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
> -		.address = in1,
> +		.address = in2,
>   		.scan_index = ADIS16400_SCAN_ADC_0,
>   		.scan_type = IIO_ST('s', 12, 16, 0),
>   	},

