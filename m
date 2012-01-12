Return-Path: <jic23@kernel.org>
Message-ID: <4F0F3552.7070303@kernel.org>
Date: Thu, 12 Jan 2012 19:32:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: linux-iio@vger.kernel.org, jic23@cam.ac.uk
Subject: Re: [PATCH 2/3] staging: iio: core: add missing spaces to error output
References: <1326124974-7288-1-git-send-email-manuel.stahl@iis.fraunhofer.de> <1326124974-7288-2-git-send-email-manuel.stahl@iis.fraunhofer.de>
In-Reply-To: <1326124974-7288-2-git-send-email-manuel.stahl@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Fine.  But while we are here, isn't conventionto have error strings on
one line even if they break the 80 character limit so that they can
be grepped for?  I guess we have two logical parts here, so not too
bad...
> Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/industrialio-buffer.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
> index a03a574..f5c4999 100644
> --- a/drivers/staging/iio/industrialio-buffer.c
> +++ b/drivers/staging/iio/industrialio-buffer.c
> @@ -430,7 +430,7 @@ ssize_t iio_buffer_store_enable(struct device *dev,
>  			ret = indio_dev->setup_ops->preenable(indio_dev);
>  			if (ret) {
>  				printk(KERN_ERR
> -				       "Buffer not started:"
> +				       "Buffer not started: "
>  				       "buffer preenable failed\n");
>  				goto error_ret;
>  			}
> @@ -439,7 +439,7 @@ ssize_t iio_buffer_store_enable(struct device *dev,
>  			ret = buffer->access->request_update(buffer);
>  			if (ret) {
>  				printk(KERN_INFO
> -				       "Buffer not started:"
> +				       "Buffer not started: "
>  				       "buffer parameter update failed\n");
>  				goto error_ret;
>  			}
> @@ -468,7 +468,7 @@ ssize_t iio_buffer_store_enable(struct device *dev,
>  			ret = indio_dev->setup_ops->postenable(indio_dev);
>  			if (ret) {
>  				printk(KERN_INFO
> -				       "Buffer not started:"
> +				       "Buffer not started: "
>  				       "postenable failed\n");
>  				if (buffer->access->unmark_in_use)
>  					buffer->access->unmark_in_use(buffer);
