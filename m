Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58129 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932495AbbHHLyG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2015 07:54:06 -0400
Subject: Re: [PATCH 4/9] iio: adis16400: adis16300 has product ID and serial
 number
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1438781901-28000-1-git-send-email-lars@metafoo.de>
 <1438781901-28000-5-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55C5EDDD.6020706@kernel.org>
Date: Sat, 8 Aug 2015 12:54:05 +0100
MIME-Version: 1.0
In-Reply-To: <1438781901-28000-5-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/08/15 14:38, Lars-Peter Clausen wrote:
> The ADIS16300 has the product ID and serial number registers, they are just
> not documented. Set the appropriate flags so the driver makes use of them.
*mutters darkly*
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/iio/imu/adis16400_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
> index d42e4fe..7d612ab 100644
> --- a/drivers/iio/imu/adis16400_core.c
> +++ b/drivers/iio/imu/adis16400_core.c
> @@ -696,7 +696,8 @@ static struct adis16400_chip_info adis16400_chips[] = {
>  	[ADIS16300] = {
>  		.channels = adis16300_channels,
>  		.num_channels = ARRAY_SIZE(adis16300_channels),
> -		.flags = ADIS16400_HAS_SLOW_MODE,
> +		.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE |
> +				ADIS16400_HAS_SERIAL_NUMBER,
>  		.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
>  		.accel_scale_micro = 5884,
>  		.temp_scale_nano = 140000000, /* 0.14 C */
> 

