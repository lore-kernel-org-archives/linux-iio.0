Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39715 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759525Ab3JORT3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Oct 2013 13:19:29 -0400
Message-ID: <525D8756.9080500@kernel.org>
Date: Tue, 15 Oct 2013 19:20:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio:kfifo: Empty buffer on update
References: <1381825830-25581-1-git-send-email-lars@metafoo.de> <1381825830-25581-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1381825830-25581-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/15/13 09:30, Lars-Peter Clausen wrote:
> The kfifo's request_update callback will free the current buffer and allocate a
> new one if the size has changed. This will remove any samples that might still
> be left in the buffer. If the size has not changed the buffer content is
> left untouched though. This is a bit inconsistent and might cause an application
> to see data from a previous capture. This patch inserts a call to
> kfifo_reset_out() when the size did not change. This makes sure that any pending
> samples are removed from the buffer.
> 
> Note, due to a different bug the buffer is currently always re-allocated, even
> if the size did not change. So this patch will not change the behavior. In the
> next patch the bug will be fixed and this patch makes sure that the current
> behavior is kept.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks,
> ---
> Changes since v1:
> 	* Do re-allocation in the if branch, reset in the else branch
> ---
>  drivers/iio/kfifo_buf.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
> index c95b61f..d654f42 100644
> --- a/drivers/iio/kfifo_buf.c
> +++ b/drivers/iio/kfifo_buf.c
> @@ -33,15 +33,17 @@ static int iio_request_update_kfifo(struct iio_buffer *r)
>  	int ret = 0;
>  	struct iio_kfifo *buf = iio_to_kfifo(r);
>  
> -	if (!buf->update_needed)
> -		goto error_ret;
>  	mutex_lock(&buf->user_lock);
> -	kfifo_free(&buf->kf);
> -	ret = __iio_allocate_kfifo(buf, buf->buffer.bytes_per_datum,
> +	if (buf->update_needed) {
> +		kfifo_free(&buf->kf);
> +		ret = __iio_allocate_kfifo(buf, buf->buffer.bytes_per_datum,
>  				   buf->buffer.length);
> +	} else {
> +		kfifo_reset_out(&buf->kf);
> +	}
>  	r->stufftoread = false;
>  	mutex_unlock(&buf->user_lock);
> -error_ret:
> +
>  	return ret;
>  }
>  
> 
