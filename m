Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56385 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834Ab2H0Rxa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Aug 2012 13:53:30 -0400
Message-ID: <503BB419.4020106@kernel.org>
Date: Mon, 27 Aug 2012 18:53:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: srinivas pandruvada <srinivas.pandruvada@intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] KFiFO : Poll support
References: <1346089129-839-1-git-send-email-srinivas.pandruvada@intel.com>
In-Reply-To: <1346089129-839-1-git-send-email-srinivas.pandruvada@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/27/2012 06:38 PM, srinivas pandruvada wrote:
> From: Jonathan Cameron <jic23@kernel.org>
> 
> Implements poll system call support on IIO Kfifo buffers.
> 
> Acked-by: srinivas pandruvada <srinivas.pandruvada@intel.com>
*laughs*
Delights of crossing emails.  Thanks this got to me before I pushed so
have added it :)
> ---
>  drivers/iio/kfifo_buf.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
> index 6bf9d05..e8033a4 100644
> --- a/drivers/iio/kfifo_buf.c
> +++ b/drivers/iio/kfifo_buf.c
> @@ -6,6 +6,7 @@
>  #include <linux/kfifo.h>
>  #include <linux/mutex.h>
>  #include <linux/iio/kfifo_buf.h>
> +#include <linux/sched.h>
>  
>  struct iio_kfifo {
>  	struct iio_buffer buffer;
> @@ -35,6 +36,7 @@ static int iio_request_update_kfifo(struct iio_buffer *r)
>  	kfifo_free(&buf->kf);
>  	ret = __iio_allocate_kfifo(buf, buf->buffer.bytes_per_datum,
>  				   buf->buffer.length);
> +	r->stufftoread = false;
>  error_ret:
>  	return ret;
>  }
> @@ -97,6 +99,8 @@ static int iio_store_to_kfifo(struct iio_buffer *r,
>  	ret = kfifo_in(&kf->kf, data, r->bytes_per_datum);
>  	if (ret != r->bytes_per_datum)
>  		return -EBUSY;
> +	r->stufftoread = true;
> +	wake_up_interruptible(&r->pollq);
>  	return 0;
>  }
>  
> @@ -111,6 +115,11 @@ static int iio_read_first_n_kfifo(struct iio_buffer *r,
>  
>  	n = rounddown(n, r->bytes_per_datum);
>  	ret = kfifo_to_user(&kf->kf, buf, n, &copied);
> +	if (kfifo_is_empty(&kf->kf))
> +		r->stufftoread = false;
> +	/* verify it is still empty to avoid race */
> +	if (!kfifo_is_empty(&kf->kf))
> +		r->stufftoread = true;
>  
>  	return copied;
>  }
> 
