Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58685 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754102AbbHHOJI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2015 10:09:08 -0400
Subject: Re: [PATCH 8/9] iio: adis16400: Add ADIS16445 support
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1438781901-28000-1-git-send-email-lars@metafoo.de>
 <1438781901-28000-9-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55C60D83.6070600@kernel.org>
Date: Sat, 8 Aug 2015 15:09:07 +0100
MIME-Version: 1.0
In-Reply-To: <1438781901-28000-9-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/08/15 14:38, Lars-Peter Clausen wrote:
> The ADIS16445 is similar to the ADIS16448, but without the magnetometer and
> pressure channels as well as different scale factors for the gyroscope and
> accelerometer outputs.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied.

Thanks,
> ---
>  drivers/iio/imu/adis16400_core.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
> index a9f4043..abc4c50 100644
> --- a/drivers/iio/imu/adis16400_core.c
> +++ b/drivers/iio/imu/adis16400_core.c
> @@ -141,6 +141,7 @@ enum adis16400_chip_variant {
>  	ADIS16364,
>  	ADIS16367,
>  	ADIS16400,
> +	ADIS16445,
>  	ADIS16448,
>  };
>  
> @@ -623,6 +624,17 @@ static const struct iio_chan_spec adis16400_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(ADIS16400_SCAN_TIMESTAMP),
>  };
>  
> +static const struct iio_chan_spec adis16445_channels[] = {
> +	ADIS16400_GYRO_CHAN(X, ADIS16400_XGYRO_OUT, 16),
> +	ADIS16400_GYRO_CHAN(Y, ADIS16400_YGYRO_OUT, 16),
> +	ADIS16400_GYRO_CHAN(Z, ADIS16400_ZGYRO_OUT, 16),
> +	ADIS16400_ACCEL_CHAN(X, ADIS16400_XACCL_OUT, 16),
> +	ADIS16400_ACCEL_CHAN(Y, ADIS16400_YACCL_OUT, 16),
> +	ADIS16400_ACCEL_CHAN(Z, ADIS16400_ZACCL_OUT, 16),
> +	ADIS16400_TEMP_CHAN(ADIS16448_TEMP_OUT, 12),
> +	IIO_CHAN_SOFT_TIMESTAMP(ADIS16400_SCAN_TIMESTAMP),
> +};
> +
>  static const struct iio_chan_spec adis16448_channels[] = {
>  	ADIS16400_GYRO_CHAN(X, ADIS16400_XGYRO_OUT, 16),
>  	ADIS16400_GYRO_CHAN(Y, ADIS16400_YGYRO_OUT, 16),
> @@ -788,6 +800,19 @@ static struct adis16400_chip_info adis16400_chips[] = {
>  		.set_freq = adis16400_set_freq,
>  		.get_freq = adis16400_get_freq,
>  	},
> +	[ADIS16445] = {
> +		.channels = adis16445_channels,
> +		.num_channels = ARRAY_SIZE(adis16445_channels),
> +		.flags = ADIS16400_HAS_PROD_ID |
> +				ADIS16400_HAS_SERIAL_NUMBER |
> +				ADIS16400_BURST_DIAG_STAT,
> +		.gyro_scale_micro = IIO_DEGREE_TO_RAD(10000), /* 0.01 deg/s */
> +		.accel_scale_micro = IIO_G_TO_M_S_2(250), /* 1/4000 g */
> +		.temp_scale_nano = 73860000, /* 0.07386 C */
> +		.temp_offset = 31000000 / 73860, /* 31 C = 0x00 */
> +		.set_freq = adis16334_set_freq,
> +		.get_freq = adis16334_get_freq,
> +	},
>  	[ADIS16448] = {
>  		.channels = adis16448_channels,
>  		.num_channels = ARRAY_SIZE(adis16448_channels),
> @@ -952,6 +977,7 @@ static const struct spi_device_id adis16400_id[] = {
>  	{"adis16367", ADIS16367},
>  	{"adis16400", ADIS16400},
>  	{"adis16405", ADIS16400},
> +	{"adis16445", ADIS16445},
>  	{"adis16448", ADIS16448},
>  	{}
>  };
> 

