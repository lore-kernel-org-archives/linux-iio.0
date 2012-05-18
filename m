Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:33366 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674Ab2ERRa2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 18 May 2012 13:30:28 -0400
Message-ID: <4FB68736.7040303@cam.ac.uk>
Date: Fri, 18 May 2012 18:30:30 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Ge Gao <ggao@invensense.com>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: sw_ring.c poll problem
References: <6e6a0f27b1900226df5350cc320f25bb@mail.gmail.com> <9d0339d0-2cde-4605-a8b0-99f568d05eb8@email.android.com> <4FB35420.4020001@cam.ac.uk> <0a0072f9cc413b7489544b461684c953@mail.gmail.com>
In-Reply-To: <0a0072f9cc413b7489544b461684c953@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 05/18/2012 02:08 AM, Ge Gao wrote:
> Dear Jonathan,
> 	I check the kfifo buffer implementation under IIO directory. However, I
> didn't find the "pollq" is released anywhere as sw_ring does.  Without it,
> how can kfifo be polled if it is used by industrial-buffer.c? Thanks.
Sorry for not getting back to you sooner.  Totally manic at the day job
today tracking two delightful bugs.

Anyhow, looks like I'd imagined we'd actually added poll support to
kfifo when it never got implemented.  Should be easy enough though.

diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
index 6bf9d05..e69d6ce 100644
--- a/drivers/iio/kfifo_buf.c
+++ b/drivers/iio/kfifo_buf.c
@@ -6,6 +6,7 @@
 #include <linux/kfifo.h>
 #include <linux/mutex.h>
 #include <linux/iio/kfifo_buf.h>
+#include <linux/sched.h>

 struct iio_kfifo {
 	struct iio_buffer buffer;
@@ -35,6 +36,7 @@ static int iio_request_update_kfifo(struct iio_buffer *r)
 	kfifo_free(&buf->kf);
 	ret = __iio_allocate_kfifo(buf, buf->buffer.bytes_per_datum,
 				   buf->buffer.length);
+	r->stufftoread = false;
 error_ret:
 	return ret;
 }
@@ -97,6 +99,10 @@ static int iio_store_to_kfifo(struct iio_buffer *r,
 	ret = kfifo_in(&kf->kf, data, r->bytes_per_datum);
 	if (ret != r->bytes_per_datum)
 		return -EBUSY;
+	
+	r->stufftoread = true;
+	wake_up_interruptible(&r->pollq);
+
 	return 0;
 }

@@ -112,6 +118,12 @@ static int iio_read_first_n_kfifo(struct iio_buffer *r,
 	n = rounddown(n, r->bytes_per_datum);
 	ret = kfifo_to_user(&kf->kf, buf, n, &copied);

+	if (kfifo_is_empty(&kf->kf))
+		r->stufftoread = false;
+	/* verify it is still empty to avoid race */
+	if (!kfifo_is_empty(&kf->kf))
+		r->stufftoread = true;
+
 	return copied;
 }

.. is a totally untested patch to add poll support to it.
The little dance at the end is to avoid a write having
occured between the kfifo_is_empty and setting the
flag false as that could wipe out the existence of some
data in the buffer. Given we only ever have one writer and
one reader that should work I think.

Jonathan

> 
> Hi Ge,
> 
> I realised after sending that message that I was being rather dismissive of
> your query.  Got up far too early this morning (as every morning ;)
> 
> Anyhow, to give more details. sw_ring is probably never going to make it out
> of staging, hence the move to kfifo_buf. At somepoint we need to work out
> how to do equivalent functionality of sw_ring but I've not had time to more
> than start looking into this.
> 
> As you saw, poll on sw_ring is a watershead signal indicating (in theory and
> last I checked it worked) that the ring is more than half full.
> Any read that takes the fill level below half (test code just reads half the
> size of the buffer), should allow a new passing of the watershead to
> resignal poll. It's entirely possible there is a bug in there though I know
> it is been getting a fair bit of testing with some other drivers so could be
> todo with the precise way you are reading it hitting some corner case? (I'm
> stretching...)
> 
> Right now I'd just move over to kfifo_buf if I were you. It's much more
> 'standard' in that it's a fifo and poll indicates if there is anything there
> at all.
>>> 	Thanks.
>>>
>>> Best regards,
>>>
>>> Ge GAO
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio"
>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>> info at  http://vger.kernel.org/majordomo-info.html
>>

