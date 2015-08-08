Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58101 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964772AbbHHLsh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2015 07:48:37 -0400
Subject: Re: [PATCH 1/9] iio: adis16400: Fix adis16448 gyroscope scale
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1438781901-28000-1-git-send-email-lars@metafoo.de>
 <1438781901-28000-2-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55C5EC92.2000805@kernel.org>
Date: Sat, 8 Aug 2015 12:48:34 +0100
MIME-Version: 1.0
In-Reply-To: <1438781901-28000-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/08/15 14:38, Lars-Peter Clausen wrote:
> Use the correct scale for the adis16448 gyroscope output.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Given we are late in the cycle and these are fixes for long broken
issues, I'm going to take them through the togreg tree and mark
for stable so they'll get pushed back to stable after the next
merge window.

So applied to the togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
> ---
>  drivers/iio/imu/adis16400_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
> index 2fd68f22..d42e4fe 100644
> --- a/drivers/iio/imu/adis16400_core.c
> +++ b/drivers/iio/imu/adis16400_core.c
> @@ -780,7 +780,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
>  		.flags = ADIS16400_HAS_PROD_ID |
>  				ADIS16400_HAS_SERIAL_NUMBER |
>  				ADIS16400_BURST_DIAG_STAT,
> -		.gyro_scale_micro = IIO_DEGREE_TO_RAD(10000), /* 0.01 deg/s */
> +		.gyro_scale_micro = IIO_DEGREE_TO_RAD(40000), /* 0.04 deg/s */
>  		.accel_scale_micro = IIO_G_TO_M_S_2(833), /* 1/1200 g */
>  		.temp_scale_nano = 73860000, /* 0.07386 C */
>  		.temp_offset = 31000000 / 73860, /* 31 C = 0x00 */
> 

