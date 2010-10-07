Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:37413 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760291Ab0JGLWh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 Oct 2010 07:22:37 -0400
Message-ID: <4CADAECD.8040504@cam.ac.uk>
Date: Thu, 07 Oct 2010 12:28:13 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com
Subject: Re: [PATCH] staging: iio: iio_ring_rip_outer return immediately if
 rip_lots returns <= 0
References: <1286448090-4792-1-git-send-email-michael.hennerich@analog.com> <1286448090-4792-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1286448090-4792-2-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/07/10 11:41, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> 
Diagnosis of the problem looks right.  Sorry about this one,
all my test cases only read from the buffer when they get an
event so I've never triggered this one. Guess I need another
test case!

I think freeing twice is going to cause trouble on any machine,
I've just never triggered the case.  I'll probably start
putting together a more comprehensive test program based
around the new generic_buffer program to hammer these
corner cases.

Thanks for your hard work.  You are nailing a
lot of bugs that have been there for quite a while.  

There is another issue somewhere in that code to do with
very small reads.  I triggered it due to a userspace bug
a while ago, but haven't had a chance to chase down the 
cause as yet.  Actually it seems fairly plausible that it
is another way of triggering the issue you have fixed here.

Great to get some eyes on that ring buffer code, it is a
fairly hideous mess!

> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/industrialio-ring.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/iio/industrialio-ring.c
> index edcf6be..d393ace 100644
> --- a/drivers/staging/iio/industrialio-ring.c
> +++ b/drivers/staging/iio/industrialio-ring.c
> @@ -105,7 +105,7 @@ static ssize_t iio_ring_rip_outer(struct file *filp, char __user *buf,
>  		return -EINVAL;
>  	copied = rb->access.rip_lots(rb, count, &data, &dead_offset);
>  
> -	if (copied < 0) {
> +	if (copied <= 0) {
>  		ret = copied;
>  		goto error_ret;
>  	}
