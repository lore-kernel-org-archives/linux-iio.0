Return-Path: <jic23@kernel.org>
Message-ID: <4FF95490.6080803@kernel.org>
Date: Sun, 08 Jul 2012 10:36:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Fix inkern remove incorrect put of device
References: <1341060923-10311-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1341060923-10311-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 06/30/2012 01:55 PM, Jonathan Cameron wrote:
> The device_get is after this point so on error we should not be
> removing it.
> 
merged to fixes.
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/iio/inkern.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 9a46ca6..e2aded0 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -193,7 +193,6 @@ struct iio_channel *iio_channel_get_all(const char *name)
>  						c->map->adc_channel_label);
>  		if (chans[mapind].channel == NULL) {
>  			ret = -EINVAL;
> -			iio_device_put(chans[mapind].indio_dev);
>  			goto error_free_chans;
>  		}
>  		iio_device_get(chans[mapind].indio_dev);
> 
