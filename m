Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58681 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964774AbbHHOI2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2015 10:08:28 -0400
Subject: Re: [PATCH 7/9] iio: adis16400: Add ADIS16367 support
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1438781901-28000-1-git-send-email-lars@metafoo.de>
 <1438781901-28000-8-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55C60D5A.4040000@kernel.org>
Date: Sat, 8 Aug 2015 15:08:26 +0100
MIME-Version: 1.0
In-Reply-To: <1438781901-28000-8-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/08/15 14:38, Lars-Peter Clausen wrote:
> The ADIS16367 is mostly register compatible to the ADIS16360. The only
> difference is the scale factor for the gyroscope output.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied.
> ---
>  drivers/iio/imu/adis16400_core.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
> index e4cc2ec..a9f4043 100644
> --- a/drivers/iio/imu/adis16400_core.c
> +++ b/drivers/iio/imu/adis16400_core.c
> @@ -139,6 +139,7 @@ enum adis16400_chip_variant {
>  	ADIS16360,
>  	ADIS16362,
>  	ADIS16364,
> +	ADIS16367,
>  	ADIS16400,
>  	ADIS16448,
>  };
> @@ -764,6 +765,18 @@ static struct adis16400_chip_info adis16400_chips[] = {
>  		.set_freq = adis16400_set_freq,
>  		.get_freq = adis16400_get_freq,
>  	},
> +	[ADIS16367] = {
> +		.channels = adis16350_channels,
> +		.num_channels = ARRAY_SIZE(adis16350_channels),
> +		.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE |
> +				ADIS16400_HAS_SERIAL_NUMBER,
> +		.gyro_scale_micro = IIO_DEGREE_TO_RAD(2000), /* 0.2 deg/s */
> +		.accel_scale_micro = IIO_G_TO_M_S_2(3333), /* 3.333 mg */
> +		.temp_scale_nano = 136000000, /* 0.136 C */
> +		.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
> +		.set_freq = adis16400_set_freq,
> +		.get_freq = adis16400_get_freq,
> +	},
>  	[ADIS16400] = {
>  		.channels = adis16400_channels,
>  		.num_channels = ARRAY_SIZE(adis16400_channels),
> @@ -936,6 +949,7 @@ static const struct spi_device_id adis16400_id[] = {
>  	{"adis16362", ADIS16362},
>  	{"adis16364", ADIS16364},
>  	{"adis16365", ADIS16360},
> +	{"adis16367", ADIS16367},
>  	{"adis16400", ADIS16400},
>  	{"adis16405", ADIS16400},
>  	{"adis16448", ADIS16448},
> 

