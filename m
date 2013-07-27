Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53789 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab3G0K7X (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 27 Jul 2013 06:59:23 -0400
Message-ID: <51F3B61D.5020701@kernel.org>
Date: Sat, 27 Jul 2013 12:59:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 07/15] staging:iio:adis16260: Use sign_extend32() instead
 of open-coding it
References: <1374072279-7140-1-git-send-email-lars@metafoo.de> <1374072279-7140-7-git-send-email-lars@metafoo.de>
In-Reply-To: <1374072279-7140-7-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/17/13 15:44, Lars-Peter Clausen wrote:
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
I wonder how many more of these there are out there?

Anyhow, applied to the togreg branch of iio.git.
Thanks,

Jonathan
> ---
>  drivers/staging/iio/gyro/adis16260_core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
> index 55e6795..f060452 100644
> --- a/drivers/staging/iio/gyro/adis16260_core.c
> +++ b/drivers/staging/iio/gyro/adis16260_core.c
> @@ -277,9 +277,7 @@ static int adis16260_read_raw(struct iio_dev *indio_dev,
>  			mutex_unlock(&indio_dev->mlock);
>  			return ret;
>  		}
> -		val16 &= (1 << bits) - 1;
> -		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> -		*val = val16;
> +		*val = sign_extend32(val16, bits - 1);
>  		mutex_unlock(&indio_dev->mlock);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_CALIBSCALE:
> 
?
