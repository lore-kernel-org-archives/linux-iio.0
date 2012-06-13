Return-Path: <lars@metafoo.de>
Message-ID: <4FD85174.3080706@metafoo.de>
Date: Wed, 13 Jun 2012 10:38:12 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Leed Aguilar <leed.aguilar@ti.com>
CC: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] staging:iio:gyro:adis16080: remove sparse warnings
References: <1339532721-2903-1-git-send-email-leed.aguilar@ti.com>
In-Reply-To: <1339532721-2903-1-git-send-email-leed.aguilar@ti.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 06/12/2012 10:25 PM, Leed Aguilar wrote:
> Removed the following sparse warning:
> 
> In function 'adis16080_read_raw':
> warning: 'ut' may be used uninitialized in this function
> 
> Signed-off-by: Leed Aguilar <leed.aguilar@ti.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks

>
> ---
>  drivers/staging/iio/gyro/adis16080_core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/staging/iio/gyro/adis16080_core.c
> index 11f1dcc..345e4fa 100644
> --- a/drivers/staging/iio/gyro/adis16080_core.c
> +++ b/drivers/staging/iio/gyro/adis16080_core.c
> @@ -82,7 +82,7 @@ static int adis16080_read_raw(struct iio_dev *indio_dev,
>  			     long mask)
>  {
>  	int ret = -EINVAL;
> -	u16 ut;
> +	u16 ut = 0;
>  	/* Take the iio_dev status lock */
>  
>  	mutex_lock(&indio_dev->mlock);
