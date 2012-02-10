Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59336 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574Ab2BJVyc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 10 Feb 2012 16:54:32 -0500
Message-ID: <4F35924D.1000708@kernel.org>
Date: Fri, 10 Feb 2012 21:55:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] staging:iio: Remove noop calls to __iio_update_buffer
References: <1328898269-26197-1-git-send-email-lars@metafoo.de> <1328898269-26197-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1328898269-26197-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/10/2012 06:24 PM, Lars-Peter Clausen wrote:
> __iio_update_buffer updates the buffer's bytes_per_datum and length attributes.
> But in these two cases we indirectly just pass the existing values, so the call
> becomes a noop and can be removed.
That is novel.  I hope if I looked back at the history that would make
sense at somepoint and it's just gotten like this via refactoring...
Feel free to drop the function as the __ marks it as very much internal
only and it clearly isn't used internally for anything useful.

Good catch.  Ack is for version with function also removed.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
> We might as well also remove the function itself, since these are the only two
> users. What do you think?
> ---
>  drivers/staging/iio/kfifo_buf.c |    1 -
>  drivers/staging/iio/ring_sw.c   |    1 -
>  2 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/kfifo_buf.c b/drivers/staging/iio/kfifo_buf.c
> index 9f3bd59..468e202 100644
> --- a/drivers/staging/iio/kfifo_buf.c
> +++ b/drivers/staging/iio/kfifo_buf.c
> @@ -22,7 +22,6 @@ static inline int __iio_allocate_kfifo(struct iio_kfifo *buf,
>  	if ((length == 0) || (bytes_per_datum == 0))
>  		return -EINVAL;
>  
> -	__iio_update_buffer(&buf->buffer, bytes_per_datum, length);
>  	return kfifo_alloc(&buf->kf, bytes_per_datum*length, GFP_KERNEL);
>  }
>  
> diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.c
> index eeac0da..5664372 100644
> --- a/drivers/staging/iio/ring_sw.c
> +++ b/drivers/staging/iio/ring_sw.c
> @@ -46,7 +46,6 @@ static inline int __iio_allocate_sw_ring_buffer(struct iio_sw_ring_buffer *ring,
>  {
>  	if ((length == 0) || (bytes_per_datum == 0))
>  		return -EINVAL;
> -	__iio_update_buffer(&ring->buf, bytes_per_datum, length);
>  	ring->data = kmalloc(length*ring->buf.bytes_per_datum, GFP_ATOMIC);
>  	ring->read_p = NULL;
>  	ring->write_p = NULL;

