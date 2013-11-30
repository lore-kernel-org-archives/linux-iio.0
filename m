Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49196 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384Ab3K3MN0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Nov 2013 07:13:26 -0500
Message-ID: <5299D660.3060507@kernel.org>
Date: Sat, 30 Nov 2013 12:13:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: Add support for blocking IO on buffers
References: <1385391404-3112-1-git-send-email-lars@metafoo.de> <1385391404-3112-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1385391404-3112-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/25/13 14:56, Lars-Peter Clausen wrote:
> Currently the IIO buffer interface only allows non-blocking reads. This patch
> adds support for blocking IO. In blocking mode the thread will go to sleep if no
> data is available and will wait for the buffer implementation to signal that new
> data is available by waking up the buffers waitqueue.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Nice little bit of functionality. Thanks.

Jonathan
> ---
>  drivers/iio/industrialio-buffer.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 4dcc3a0..c67d83b 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -56,13 +56,34 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>  {
>  	struct iio_dev *indio_dev = filp->private_data;
>  	struct iio_buffer *rb = indio_dev->buffer;
> +	int ret;
>  
>  	if (!indio_dev->info)
>  		return -ENODEV;
>  
>  	if (!rb || !rb->access->read_first_n)
>  		return -EINVAL;
> -	return rb->access->read_first_n(rb, n, buf);
> +
> +	do {
> +		if (!iio_buffer_data_available(rb)) {
> +			if (filp->f_flags & O_NONBLOCK)
> +				return -EAGAIN;
> +
> +			ret = wait_event_interruptible(rb->pollq,
> +					iio_buffer_data_available(rb) ||
> +					indio_dev->info == NULL);
> +			if (ret)
> +				return ret;
> +			if (indio_dev->info == NULL)
> +				return -ENODEV;
> +		}
> +
> +		ret = rb->access->read_first_n(rb, n, buf);
> +		if (ret == 0 && (filp->f_flags & O_NONBLOCK))
> +			ret = -EAGAIN;
> +	 } while (ret == 0);
> +
> +	return ret;
>  }
>  
>  /**
> 
