Return-Path: <frank@zago.net>
Message-ID: <52841C2B.7080908@zago.net>
Date: Wed, 13 Nov 2013 18:41:15 -0600
From: Frank Zago <frank@zago.net>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
CC: lars@metafoo.de
Subject: Re: [PATCH V2] iio:accel:kxsd9 fix missing mutex unlock
References: <1384383231-7897-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1384383231-7897-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 11/13/2013 04:53 PM, Jonathan Cameron wrote:
> From: Frank Zago <frank@zago.net>
> 
> This will leave a lock held after reading from the device, preventing
> any further reads.
> 
> Signed-off-by: Frank Zago <frank@zago.net>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> ---
> 
> This is Frank's original patch.  As Lars-Peter pointed out, I really didn't
> think my way through my shortened (and incorrect version).
> 
> Oops!
> 
> Frank, just to check, are you fine signing off on this?

Yes. It's good.

Frank.

> 
>  drivers/iio/accel/kxsd9.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index d72118d1189c..98ba761cbb9c 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -112,9 +112,10 @@ static int kxsd9_read(struct iio_dev *indio_dev, u8 address)
>  	mutex_lock(&st->buf_lock);
>  	st->tx[0] = KXSD9_READ(address);
>  	ret = spi_sync_transfer(st->us, xfers, ARRAY_SIZE(xfers));
> -	if (ret)
> -		return ret;
> -	return (((u16)(st->rx[0])) << 8) | (st->rx[1] & 0xF0);
> +	if (!ret)
> +		ret = (((u16)(st->rx[0])) << 8) | (st->rx[1] & 0xF0);
> +	mutex_unlock(&st->buf_lock);
> +	return ret;
>  }
>  
>  static IIO_CONST_ATTR(accel_scale_available,
> 
