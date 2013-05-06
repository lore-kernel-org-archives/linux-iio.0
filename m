Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42457 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754274Ab3EFQOA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 6 May 2013 12:14:00 -0400
Message-ID: <5187D6C9.7040406@kernel.org>
Date: Mon, 06 May 2013 17:14:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: buffer: cleanup messages in iio_update_buffers()
References: <79b3b255142a0ec0ab891d0b4bb0dbc9a2532e74.1367671597.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <79b3b255142a0ec0ab891d0b4bb0dbc9a2532e74.1367671597.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/04/2013 02:19 PM, Michał Mirosław wrote:
> 1. make messages grepable (in one line)
> 2. include returned errno in them
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Thanks,

Applied to the togreg branch of iio.git.
> ---
> Please ignore checkpatch long lines warning.
> 
>  drivers/iio/industrialio-buffer.c |   10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index aaadd32..e73033f 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -542,8 +542,7 @@ int iio_update_buffers(struct iio_dev *indio_dev,
>  		ret = indio_dev->setup_ops->preenable(indio_dev);
>  		if (ret) {
>  			printk(KERN_ERR
> -			       "Buffer not started:"
> -			       "buffer preenable failed\n");
> +			       "Buffer not started: buffer preenable failed (%d)\n", ret);
>  			goto error_remove_inserted;
>  		}
>  	}
> @@ -556,8 +555,7 @@ int iio_update_buffers(struct iio_dev *indio_dev,
>  			ret = buffer->access->request_update(buffer);
>  			if (ret) {
>  				printk(KERN_INFO
> -				       "Buffer not started:"
> -				       "buffer parameter update failed\n");
> +				       "Buffer not started: buffer parameter update failed (%d)\n", ret);
>  				goto error_run_postdisable;
>  			}
>  		}
> @@ -566,7 +564,7 @@ int iio_update_buffers(struct iio_dev *indio_dev,
>  			->update_scan_mode(indio_dev,
>  					   indio_dev->active_scan_mask);
>  		if (ret < 0) {
> -			printk(KERN_INFO "update scan mode failed\n");
> +			printk(KERN_INFO "Buffer not started: update scan mode failed (%d)\n", ret);
>  			goto error_run_postdisable;
>  		}
>  	}
> @@ -590,7 +588,7 @@ int iio_update_buffers(struct iio_dev *indio_dev,
>  		ret = indio_dev->setup_ops->postenable(indio_dev);
>  		if (ret) {
>  			printk(KERN_INFO
> -			       "Buffer not started: postenable failed\n");
> +			       "Buffer not started: postenable failed (%d)\n", ret);
>  			indio_dev->currentmode = INDIO_DIRECT_MODE;
>  			if (indio_dev->setup_ops->postdisable)
>  				indio_dev->setup_ops->postdisable(indio_dev);
> 
