Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-103.synserver.de ([212.40.185.103]:1079 "EHLO
	smtp-out-089.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756790Ab3CDSqq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Mar 2013 13:46:46 -0500
Message-ID: <5134EC79.5060004@metafoo.de>
Date: Mon, 04 Mar 2013 19:48:25 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 37/67] iio:imu:adis16400 move to info_mask_(shared_by_type/separate)
References: <1362241044-3534-1-git-send-email-jic23@kernel.org> <1362241044-3534-38-git-send-email-jic23@kernel.org>
In-Reply-To: <1362241044-3534-38-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/02/2013 05:16 PM, Jonathan Cameron wrote:
> The original info_mask is going away in favour of the broken out versions.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> cc: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/iio/imu/adis16400_core.c | 47 ++++++++++++++++++++--------------------
>  1 file changed, 23 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
> index b7f215e..2111068 100644
> --- a/drivers/iio/imu/adis16400_core.c
> +++ b/drivers/iio/imu/adis16400_core.c
> @@ -484,8 +484,7 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
>  	.indexed = 1, \
>  	.channel = 0, \
>  	.extend_name = name, \
> -	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
> -		IIO_CHAN_INFO_SCALE_SEPARATE_BIT, \
> +	.info_mask_separate = IIO_CHAN_INFO_RAW | IIO_CHAN_INFO_SCALE, \

BIT is missing.

> @@ -587,9 +587,8 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
>  	.type = IIO_TEMP, \
>  	.indexed = 1, \
>  	.channel = 0, \
> -	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
> -		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT | \
> -		IIO_CHAN_INFO_SCALE_SEPARATE_BIT, \
> +	.info_mask_separate = IIO_CHAN_INFO_RAW | IIO_CHAN_INFO_OFFSET | \
> +		IIO_CHAN_INFO_SCALE, \

BIT is missing.

