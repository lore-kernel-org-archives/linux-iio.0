Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54195 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932474Ab3JNVHV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 14 Oct 2013 17:07:21 -0400
Message-ID: <525C6B3D.4010605@kernel.org>
Date: Mon, 14 Oct 2013 23:07:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio:kfifo: Set update_needed to false after allocating
 a new buffer
References: <1381763350-8930-1-git-send-email-lars@metafoo.de> <1381763350-8930-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1381763350-8930-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/14/13 16:09, Lars-Peter Clausen wrote:
> update_needed is used to decide whether the kfifo buffer needs to be
> re-allocated. It is set to true whenever the size of the buffer is changed. It
> is never set to false though, causing the buffer to always be re-allocated.
> Setting update_needed to false after the new buffer has been allocated fixes the
> problem.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
A big whoopsy on this one.  Well spotted ;)


> ---
>  drivers/iio/kfifo_buf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
> index a050b18..920e383 100644
> --- a/drivers/iio/kfifo_buf.c
> +++ b/drivers/iio/kfifo_buf.c
> @@ -40,6 +40,7 @@ static int iio_request_update_kfifo(struct iio_buffer *r)
>  		kfifo_free(&buf->kf);
>  		ret = __iio_allocate_kfifo(buf, buf->buffer.bytes_per_datum,
>  				   buf->buffer.length);
> +		buf->update_needed = false;
>  	}
>  	r->stufftoread = false;
>  	mutex_unlock(&buf->user_lock);
> 
