Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:51052 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756398Ab2FOMiv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jun 2012 08:38:51 -0400
Message-ID: <4FDB2CD9.9000605@cam.ac.uk>
Date: Fri, 15 Jun 2012 13:38:49 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/4] staging:iio:adis16400: Fix ADIS16300 ROLL_OUT register
 address
References: <1339748926-4002-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1339748926-4002-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/15/2012 9:28 AM, Lars-Peter Clausen wrote:
> In the current driver ROLL_OUT register address is the same as the PITCH_OUT
> register address. This patch fixes it to use the correct address.
>
> Signed-off-by: Lars-Peter Clausen<lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   drivers/staging/iio/imu/adis16400.h |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/iio/imu/adis16400.h b/drivers/staging/iio/imu/adis16400.h
> index 83d133e..1f4e987 100644
> --- a/drivers/staging/iio/imu/adis16400.h
> +++ b/drivers/staging/iio/imu/adis16400.h
> @@ -42,7 +42,7 @@
>   #define ADIS16350_ZTEMP_OUT 0x14 /* Z-axis gyroscope temperature measurement */
>
>   #define ADIS16300_PITCH_OUT 0x12 /* X axis inclinometer output measurement */
> -#define ADIS16300_ROLL_OUT  0x12 /* Y axis inclinometer output measurement */
> +#define ADIS16300_ROLL_OUT  0x14 /* Y axis inclinometer output measurement */
>
>   /* Calibration parameters */
>   #define ADIS16400_XGYRO_OFF 0x1A /* X-axis gyroscope bias offset factor */

