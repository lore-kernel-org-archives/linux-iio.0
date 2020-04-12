Return-Path: <SRS0=GqNd=54=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0BBC2BA2B
	for <linux-iio@archiver.kernel.org>; Sun, 12 Apr 2020 13:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452F3206B8
	for <linux-iio@archiver.kernel.org>; Sun, 12 Apr 2020 13:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586698213;
	bh=JCenLFN5beHsJI7hfY8pGkBETX594Vt2msukbcaD+m8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=sCcse53DzC9e4+B4BBo7RRVCEoQBAjDa3RlWrGka4uXGVAR4+c0N+0Xsfohr8j0iQ
	 04ZjORlCYhkm4ofz1r93Y3SVs/qsbUPpNEk4BRWKltKBD32KRyUtRO8YqqYys4M9or
	 9kMPL2YbUnBIrPyhKsNfOPKOObyZLgiNLzyo8IJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgDLNaM (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 12 Apr 2020 09:30:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgDLNaM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Apr 2020 09:30:12 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C5ED20673;
        Sun, 12 Apr 2020 13:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586698211;
        bh=JCenLFN5beHsJI7hfY8pGkBETX594Vt2msukbcaD+m8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AY42TAcq1YeUTaD/Tc+pfhNsfyzWdgz83t/0oQkAdF8RKbbNVLSOzLiNh1jlZxRo9
         XxtGcDe+D/vFVIyRzxmQj1+O2JzU1U01PeNXabOyUGQ6qz+1AuXf31xm31z6BctIhx
         Up2YaDlx8cmVWnjrBUcE4AGDZUIauyxNIm6qw61U=
Date:   Sun, 12 Apr 2020 14:30:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: buffer: remove null-checks for 'indio_dev->info'
Message-ID: <20200412143008.3fa722a9@archlinux>
In-Reply-To: <20200407145918.6833-1-alexandru.ardelean@analog.com>
References: <20200407145918.6833-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 7 Apr 2020 17:59:18 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Checking for 'indio_dev->info' is an impossible condition, since an IIO
> device should NOT be able to register without that information.
> The iio_device_register() function won't allow an IIO device to register if
> 'indio_dev->info' is NULL.
> 
> If that information somehow becomes NULL, then we're likely busted anyway
> and we should crash the system, if we haven't already.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
I'm glad there was a comment in there to remind me of what was going on here.

This is the result of an ancient set from (I think) Lars hardening IIO
against forced removal.

The indio_dev->info == NULL is deliberately set to true by the IIO core
during device remove in order to deal with any inflight data.

Reference counting should ensure the device doesn't go away but we need
to avoid actually doing anything if this occurs.  That pointer was a
convenient option to avoid having to add an explicit flag or 'going away'.

Now, it's possible we don't need this any more due to other changes but
I certainly don't want to remove it without that being very thoroughly
verified!

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-buffer.c | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index e6fa1a4e135d..c96071bfada8 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -54,10 +54,6 @@ static bool iio_buffer_ready(struct iio_dev *indio_dev, struct iio_buffer *buf,
>  	size_t avail;
>  	int flushed = 0;
>  
> -	/* wakeup if the device was unregistered */
This comment makes it clear this isn't as 'obvious' as it might at first seem ;)

> -	if (!indio_dev->info)
> -		return true;
> -
>  	/* drain the buffer if it was disabled */
>  	if (!iio_buffer_is_active(buf)) {
>  		to_wait = min_t(size_t, to_wait, 1);
> @@ -109,9 +105,6 @@ ssize_t iio_buffer_read_outer(struct file *filp, char __user *buf,
>  	size_t to_wait;
>  	int ret = 0;
>  
> -	if (!indio_dev->info)
> -		return -ENODEV;
> -
>  	if (!rb || !rb->access->read)
>  		return -EINVAL;
>  
> @@ -131,11 +124,6 @@ ssize_t iio_buffer_read_outer(struct file *filp, char __user *buf,
>  
>  	add_wait_queue(&rb->pollq, &wait);
>  	do {
> -		if (!indio_dev->info) {
> -			ret = -ENODEV;
> -			break;
> -		}
> -
>  		if (!iio_buffer_ready(indio_dev, rb, to_wait, n / datum_size)) {
>  			if (signal_pending(current)) {
>  				ret = -ERESTARTSYS;
> @@ -171,7 +159,7 @@ __poll_t iio_buffer_poll(struct file *filp,
>  	struct iio_dev *indio_dev = filp->private_data;
>  	struct iio_buffer *rb = indio_dev->buffer;
>  
> -	if (!indio_dev->info || rb == NULL)
> +	if (rb == NULL)
>  		return 0;
>  
>  	poll_wait(filp, &rb->pollq, wait);
> @@ -1100,11 +1088,6 @@ int iio_update_buffers(struct iio_dev *indio_dev,
>  		goto out_unlock;
>  	}
>  
> -	if (indio_dev->info == NULL) {
> -		ret = -ENODEV;
> -		goto out_unlock;
> -	}
> -
>  	ret = __iio_update_buffers(indio_dev, insert_buffer, remove_buffer);
>  
>  out_unlock:

