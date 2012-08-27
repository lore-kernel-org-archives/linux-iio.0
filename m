Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56345 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753797Ab2H0RvT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Aug 2012 13:51:19 -0400
Message-ID: <503BB396.1090200@kernel.org>
Date: Mon, 27 Aug 2012 18:51:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: KFiFo Poll support
References: <4FA419E87744DF4DAECD5BCE1214B7A9193ADCB4@ORSMSX104.amr.corp.intel.com>
In-Reply-To: <4FA419E87744DF4DAECD5BCE1214B7A9193ADCB4@ORSMSX104.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

As this just conviently came up,

I've merged a 3 patch variant of the original series this was in.
Patch 1 was broken in to two as I was originally naughty and handled
some unrelated error cases whilst I was doing the conversion to
fixed record size use of kfifo.

Partly this sat in my queue for a long time because of a lack
of explicit feedback. Lars-Peter was kind enough to give it a
test, but wasn't really interested in the support so didn't
hammer it.

I may be the maintainer but I'd still like people to review
my patches!

(speaking of which... the push buffer stuff is still out there
and hopefully I'll get a chance to do another rebase of that
sometime in the next few days!)

Anyhow, the kfifo improvements will be in my togreg branch
shortly on kernel.org.
> 
>  
> 
> You have circulated a patch to support polling on KFifo, but that was never merged.
> 
>  
> 
> I have used in my tree with your authorship:
> 
>  
> 
> commit ae09253bf19a607ea0614051ba0bdb04d5f23689
> 
> Author: Jonathan Cameron <jic23@kernel.org>
> 
> Date:   Fri Jun 8 13:08:53 2012 -0700
> 
>  
> 
>     KFiFO : Poll support
> 
>    
> 
>     Implements poll system call support on IIO Kfifo buffers.
> 
>    
> 
>     Change-Id: I6739382b7b81951e5b4498fc04356b3652941058
> 
>     Signed-off-by: srinivas pandruvada <srinivas.pandruvada@intel.com>
> 
>  
> 
> diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
> 
> index 6bf9d05..e8033a4 100644
> 
> --- a/drivers/iio/kfifo_buf.c
> 
> +++ b/drivers/iio/kfifo_buf.c
> 
> @@ -6,6 +6,7 @@
> 
> #include <linux/kfifo.h>
> 
> #include <linux/mutex.h>
> 
> #include <linux/iio/kfifo_buf.h>
> 
> +#include <linux/sched.h>
> 
>  struct iio_kfifo {
> 
>                struct iio_buffer buffer;
> 
> @@ -35,6 +36,7 @@ static int iio_request_update_kfifo(struct iio_buffer *r)
> 
>                kfifo_free(&buf->kf);
> 
>                ret = __iio_allocate_kfifo(buf, buf->buffer.bytes_per_datum,
> 
>                                                                   buf->buffer.length);
> 
> +             r->stufftoread = false;
> 
> error_ret:
> 
>                return ret;
> 
> }
> 
> @@ -97,6 +99,8 @@ static int iio_store_to_kfifo(struct iio_buffer *r,
> 
>                ret = kfifo_in(&kf->kf, data, r->bytes_per_datum);
> 
>                if (ret != r->bytes_per_datum)
> 
>                                return -EBUSY;
> 
> +             r->stufftoread = true;
> 
> +             wake_up_interruptible(&r->pollq);
> 
>                return 0;
> 
> }
> 
> @@ -111,6 +115,11 @@ static int iio_read_first_n_kfifo(struct iio_buffer *r,
> 
>                 n = rounddown(n, r->bytes_per_datum);
> 
>                ret = kfifo_to_user(&kf->kf, buf, n, &copied);
> 
> +             if (kfifo_is_empty(&kf->kf))
> 
> +                             r->stufftoread = false;
> 
> +             /* verify it is still empty to avoid race */
> 
> +             if (!kfifo_is_empty(&kf->kf))
> 
> +                             r->stufftoread = true;
> 
>                 return copied;
> 
> }
> 
>  
> 
> Thanks,
> 
> Srinivas
> 
