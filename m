Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:51501 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756398Ab2FOMjW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jun 2012 08:39:22 -0400
Message-ID: <4FDB2CF8.3050706@cam.ac.uk>
Date: Fri, 15 Jun 2012 13:39:20 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/4] staging:iio:adis16400: Fix ADIS16300 temperature
 address
References: <1339748926-4002-1-git-send-email-lars@metafoo.de> <1339748926-4002-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1339748926-4002-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/15/2012 9:28 AM, Lars-Peter Clausen wrote:
> The ADIS16300 uses the same address for the temperature register as the
> ADIS16350 and not the ADIS16400.
oops.
>
> Signed-off-by: Lars-Peter Clausen<lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   drivers/staging/iio/imu/adis16400_core.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
> index 1f6bd85..1c9931e 100644
> --- a/drivers/staging/iio/imu/adis16400_core.c
> +++ b/drivers/staging/iio/imu/adis16400_core.c
> @@ -946,7 +946,7 @@ static struct iio_chan_spec adis16300_channels[] = {
>   		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
>   		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
>   		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
> -		.address = temp,
> +		.address = temp0,
>   		.scan_index = ADIS16400_SCAN_TEMP,
>   		.scan_type = IIO_ST('s', 12, 16, 0),
>   	}, {

