Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:51966 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756398Ab2FOMkB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jun 2012 08:40:01 -0400
Message-ID: <4FDB2D20.3000502@cam.ac.uk>
Date: Fri, 15 Jun 2012 13:40:00 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/4] staging:iio:adis16400: Fix ADIS16334 temperature
 address
References: <1339748926-4002-1-git-send-email-lars@metafoo.de> <1339748926-4002-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1339748926-4002-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/15/2012 9:28 AM, Lars-Peter Clausen wrote:
> The channel spec for ADUS16334's temperature channel uses the address and scan
> index for the Z-axis acceleration channel. This patch fixes it to use the
> temperature channel address and scan index instead.
>
doh, that one is particularly bad (and obvious!)  Thanks,
> Signed-off-by: Lars-Peter Clausen<lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   drivers/staging/iio/imu/adis16400_core.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
> index 1c9931e..7aa3a9a 100644
> --- a/drivers/staging/iio/imu/adis16400_core.c
> +++ b/drivers/staging/iio/imu/adis16400_core.c
> @@ -1054,8 +1054,8 @@ static const struct iio_chan_spec adis16334_channels[] = {
>   		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
>   		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
>   		IIO_CHAN_INFO_SCALE_SHARED_BIT,
> -		.address = accel_z,
> -		.scan_index = ADIS16400_SCAN_ACC_Z,
> +		.address = temp0,
> +		.scan_index = ADIS16400_SCAN_TEMP,
>   		.scan_type = IIO_ST('s', 14, 16, 0),
>   	},
>   	IIO_CHAN_SOFT_TIMESTAMP(12)

