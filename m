Return-Path: <jic23@kernel.org>
Message-ID: <4F95BE39.9090005@kernel.org>
Date: Mon, 23 Apr 2012 21:40:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
 device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 1/8] staging:iio:dac:ad5446: Do not exit powerdown when
 writing a sample
References: <1335203497-11041-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1335203497-11041-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 04/23/2012 06:51 PM, Lars-Peter Clausen wrote:
> Both the powerdown mode bits and the sample value are stored in the same
> register, so writing a sample while the device is powered down will clear the
> power down bits. To avoid this only update the cached value when the device is
> powered down.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/dac/ad5446.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
> index ec6968b..0cfe445 100644
> --- a/drivers/staging/iio/dac/ad5446.c
> +++ b/drivers/staging/iio/dac/ad5446.c
> @@ -282,7 +282,8 @@ static int ad5446_write_raw(struct iio_dev *indio_dev,
>  		val <<= chan->scan_type.shift;
>  		mutex_lock(&indio_dev->mlock);
>  		st->cached_val = val;
> -		st->chip_info->store_sample(st, val);
> +		if (!st->pwr_down)
> +			st->chip_info->store_sample(st, val);
>  		ret = spi_sync(st->spi, &st->msg);
>  		mutex_unlock(&indio_dev->mlock);
>  		break;
