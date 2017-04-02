Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47141 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbdDBIie (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2017 04:38:34 -0400
Subject: Re: [PATCH 1/3] staging: iio: accel: Remove useless type conversion
To: simran singhal <singhalsimran0@gmail.com>
References: <1490972930-15476-1-git-send-email-singhalsimran0@gmail.com>
 <1490972930-15476-2-git-send-email-singhalsimran0@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <42c3c1b6-16c4-7dba-14d8-5b982e191241@kernel.org>
Date: Sun, 2 Apr 2017 09:38:30 +0100
MIME-Version: 1.0
In-Reply-To: <1490972930-15476-2-git-send-email-singhalsimran0@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/03/17 16:08, simran singhal wrote:
> Some type conversions like casting a pointer to a pointer of same type,
> casting to the original type using addressof(&) operator etc. are not
> needed. Therefore, remove them. Done using coccinelle:
Please write a more specific commit message.  No where in here
for example is that particular case relevant as we aren't ever looking
at pointers.

More stuff below.  There's a better way of improving this code!
> 
> @@
> type t;
> t *p;
> t a;
> @@
> (
> - (t)(a)
> + a
> |
> - (t *)(p)
> + p
> |
> - (t *)(&a)
> + &a
> )
> 
> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
> ---
>  drivers/staging/iio/accel/adis16201.c | 2 +-
>  drivers/staging/iio/accel/adis16203.c | 2 +-
>  drivers/staging/iio/accel/adis16209.c | 2 +-
>  drivers/staging/iio/accel/adis16240.c | 6 +++---
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index fbc2406..b7381d3 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -228,7 +228,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
>  		if (ret)
>  			return ret;
>  		val16 &= (1 << bits) - 1;
> -		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> +		val16 = val16 << (16 - bits) >> (16 - bits);
hmm. bits is integer and val16 an s16
*looks up type promotion rules*

Hohum. I hope someone else will check I get this right.

Both instances of 16-bits will be signed integers.
val16 will get promoted to a signed integer as well.

Had it been a u16 value this would all have been necessary
to ensure that the final right shift was pulling in ones.

So all in all this looks like the cast is probably there to suppress
a warning if the compiler isn't clever enough to figure out it will never
truncate unecessarily.

However, the fun thing about this is to take a look at what it is
actually doing.  It's doing sign extension to an s16, then just below
assigns it to an int.

So how could you do that better?

search for sign_extend32 and see what you can do with it.

It's actually a more recent introduction to the kernel than this driver
(IIRC) so not surprising it isn't already being used here.
 
>  		*val = val16;
>  		return IIO_VAL_INT;
>  	}
> diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
> index b59755a..25e5e52 100644
> --- a/drivers/staging/iio/accel/adis16203.c
> +++ b/drivers/staging/iio/accel/adis16203.c
> @@ -211,7 +211,7 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
>  			return ret;
>  		}
>  		val16 &= (1 << bits) - 1;
> -		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> +		val16 = val16 << (16 - bits) >> (16 - bits);
>  		*val = val16;
>  		mutex_unlock(&indio_dev->mlock);
>  		return IIO_VAL_INT;
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index 52fa2e0..7aac310 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -259,7 +259,7 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
>  			return ret;
>  		}
>  		val16 &= (1 << bits) - 1;
> -		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> +		val16 = val16 << (16 - bits) >> (16 - bits);
>  		*val = val16;
>  		return IIO_VAL_INT;
>  	}
> diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
> index 6e3c95c..2c55b65 100644
> --- a/drivers/staging/iio/accel/adis16240.c
> +++ b/drivers/staging/iio/accel/adis16240.c
> @@ -220,7 +220,7 @@ static ssize_t adis16240_spi_read_signed(struct device *dev,
>  	if (val & ADIS16240_ERROR_ACTIVE)
>  		adis_check_status(st);
>  
> -	val = (s16)(val << shift) >> shift;
> +	val = val << shift >> shift;
>  	return sprintf(buf, "%d\n", val);
>  }
>  
> @@ -294,7 +294,7 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
>  			return ret;
>  		}
>  		val16 &= (1 << bits) - 1;
> -		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> +		val16 = val16 << (16 - bits) >> (16 - bits);
>  		*val = val16;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_PEAK:
> @@ -305,7 +305,7 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
>  			return ret;
>  		}
>  		val16 &= (1 << bits) - 1;
> -		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> +		val16 = val16 << (16 - bits) >> (16 - bits);
>  		*val = val16;
>  		return IIO_VAL_INT;
>  	}
> 

