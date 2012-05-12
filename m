Return-Path: <jic23@kernel.org>
Message-ID: <4FAE248D.6070009@kernel.org>
Date: Sat, 12 May 2012 09:51:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 24/24] iio: Free up drvdata for driver usage
References: <1336741127-29552-1-git-send-email-lars@metafoo.de> <1336741127-29552-24-git-send-email-lars@metafoo.de>
In-Reply-To: <1336741127-29552-24-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 05/11/2012 01:58 PM, Lars-Peter Clausen wrote:
> Now that all drivers have been converted to dev_to_iio_dev we do no longer have
> to set the device's drvdata to the iio device pointer. So remove it, this will
> allow drivers to use it for driver specific purposes.
> 

Good series.  Ideally fixup the case of those comments in the early
patches.  Thanks,

Jonathan

> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> 
> ---
> I intend to send this patch with a delay of maybe one release or so, so we don't
> randomly break drivers which are currently in development.
> ---
>  drivers/iio/industrialio-core.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index ae3f5ed..f5656a0 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -753,7 +753,6 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
>  		dev->dev.type = &iio_dev_type;
>  		dev->dev.bus = &iio_bus_type;
>  		device_initialize(&dev->dev);
> -		dev_set_drvdata(&dev->dev, (void *)dev);
>  		mutex_init(&dev->mlock);
>  		mutex_init(&dev->info_exist_lock);
>  
