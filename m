Return-Path: <SRS0=J3Le=4A=axentia.se=peda@kernel.org>
Subject: Re: [PATCH v2] iio: inkern: fix endless loop in error path
To: Jonathan Cameron <jic23@kernel.org>, <linux-kernel@vger.kernel.org>
References: <1493024257-17378-1-git-send-email-peda@axentia.se>
CC: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <319cf4dc-b3ee-3b2a-6d92-a852d5508411@axentia.se>
Date: Mon, 24 Apr 2017 11:25:06 +0200
MIME-Version: 1.0
In-Reply-To: <1493024257-17378-1-git-send-email-peda@axentia.se>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>

Arrggggh!

Actually, this updated description is not at all accurate! It is still pretty
nasty to loop back and unlock the mutex again, but the loop isn't endless.
The code will only jump back once. That's of course bad enough, but there's
also the fact that the bug can only happen if type is not IIO_VAL_INT. And
IIUC, that really shouldn't be the case for raw values? Because inkern.c
iio_write_channel_raw() certainly implies it. If raw values really are
IIO_VAL_INT *always*, then the double unlock should never trigger.

And in that case the description of the original v1 patch is much more
accurate, since it really mostly is about a static checker issue.

So, please ignore this update and pick the original patch instead. I.e.
https://lkml.org/lkml/2017/4/20/887

Sorry for the noise.

Cheers,
peda


On 2017-04-24 10:57, Peter Rosin wrote:
> If ret ends up negative, mutex_unlock is called repeatedly in an infinite
> loop, which of course is pretty nasty...
> 
> Issue found by smatch:
> drivers/iio/inkern.c:751 iio_read_avail_channel_raw() error: double unlock 'mutex:&chan->indio_dev->info_exist_lock'
> 
> Fixes: 00c5f80c2fad ("iio: inkern: add helpers to query available values from channels")
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/iio/inkern.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> v1 -> v2 changes:
> - Be clear about that there is a real nasty issue and that it isn't only
>   about avoiding some insignificant static checker issue.
> 
> v1:  https://lkml.org/lkml/2017/4/20/887
> 
> Cheers,
> peda
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
