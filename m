Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53705 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387Ab3G0KyJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 27 Jul 2013 06:54:09 -0400
Message-ID: <51F3B4E2.5010308@kernel.org>
Date: Sat, 27 Jul 2013 12:54:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 01/15] staging:iio:adis16260: Fix reading calibscale
References: <1374072279-7140-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1374072279-7140-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/17/13 15:44, Lars-Peter Clausen wrote:
> Return the actual value read from the device and not just the mask.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks,

> ---
>  drivers/staging/iio/gyro/adis16260_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
> index 620d63f..0b34492 100644
> --- a/drivers/staging/iio/gyro/adis16260_core.c
> +++ b/drivers/staging/iio/gyro/adis16260_core.c
> @@ -223,7 +223,7 @@ static int adis16260_read_raw(struct iio_dev *indio_dev,
>  			mutex_unlock(&indio_dev->mlock);
>  			return ret;
>  		}
> -		*val = (1 << bits) - 1;
> +		*val = val16;
>  		mutex_unlock(&indio_dev->mlock);
>  		return IIO_VAL_INT;
>  	}
> 
