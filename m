Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39736 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932317Ab3JORUH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Oct 2013 13:20:07 -0400
Message-ID: <525D877C.5080805@kernel.org>
Date: Tue, 15 Oct 2013 19:20:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio:kfifo: Set update_needed to false after allocating
 a new buffer
References: <1381825830-25581-1-git-send-email-lars@metafoo.de> <1381825830-25581-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1381825830-25581-4-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/15/13 09:30, Lars-Peter Clausen wrote:
> update_needed is used to decide whether the kfifo buffer needs to be
> re-allocated. It is set to true whenever the size of the buffer is changed. It
> is never set to false though, causing the buffer to always be re-allocated.
> Setting update_needed to false after the new buffer has been allocated fixes the
> problem.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks for you hard work chasing down these 'naughty corners'

> ---
> No changes in v2
> ---
>  drivers/iio/kfifo_buf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
> index d654f42..95c6fc8 100644
> --- a/drivers/iio/kfifo_buf.c
> +++ b/drivers/iio/kfifo_buf.c
> @@ -38,6 +38,7 @@ static int iio_request_update_kfifo(struct iio_buffer *r)
>  		kfifo_free(&buf->kf);
>  		ret = __iio_allocate_kfifo(buf, buf->buffer.bytes_per_datum,
>  				   buf->buffer.length);
> +		buf->update_needed = false;
>  	} else {
>  		kfifo_reset_out(&buf->kf);
>  	}
> 
