Return-Path: <SRS0=t/gf=34=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH] iio: inkern: fix a static checker error
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
References: <1492722117-19618-1-git-send-email-peda@axentia.se>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <9b2138e1-11a1-a923-4c9c-7091b3e54f99@metafoo.de>
Date: Thu, 20 Apr 2017 23:12:47 +0200
MIME-Version: 1.0
In-Reply-To: <1492722117-19618-1-git-send-email-peda@axentia.se>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 04/20/2017 11:01 PM, Peter Rosin wrote:
> Avoid this smatch error:
> drivers/iio/inkern.c:751 iio_read_avail_channel_raw() error: double unlock 'mutex:&chan->indio_dev->info_exist_lock'

Looks good, but it's not just the smatch error, this is a real issue. This
even seems to be a endless loop, always jumping back to err_unlock.

> 
> Fixes: 00c5f80c2fad ("iio: inkern: add helpers to query available values from channels")
> Signed-off-by: Peter Rosin <peda@axentia.se>

> ---
>  drivers/iio/inkern.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 7a13535dc3e9..a3941bade6a7 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -750,11 +750,9 @@ int iio_read_avail_channel_raw(struct iio_channel *chan,
>  err_unlock:
>  	mutex_unlock(&chan->indio_dev->info_exist_lock);
>  
> -	if (ret >= 0 && type != IIO_VAL_INT) {
> +	if (ret >= 0 && type != IIO_VAL_INT)
>  		/* raw values are assumed to be IIO_VAL_INT */
>  		ret = -EINVAL;
> -		goto err_unlock;
> -	}
>  
>  	return ret;
>  }
> 
