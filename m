Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-105.synserver.de ([212.40.185.105]:1096 "EHLO
	smtp-out-087.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754285Ab1JULqD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 21 Oct 2011 07:46:03 -0400
Message-ID: <4EA15B98.5050506@metafoo.de>
Date: Fri, 21 Oct 2011 13:46:32 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging:iio: core.  Allow for event chrdev obtaining
 ioctl if no buffer present.
References: <1319196865-22766-1-git-send-email-jic23@cam.ac.uk> <1319196865-22766-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1319196865-22766-2-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/21/2011 01:34 PM, Jonathan Cameron wrote:
> Logic bug meant the chrdev would fail to open if there was no buffer support
> in a driver or in the core. This meant the ioctl to get the event chrdev
> would fail and hence events were not available.
> 
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---

> I've tested this on the tsl2563 driver and it all seems fine.
> Lars-Peter - could you hammer this a little to see if I have
> missed any corner cases?

This is basically what I had locally for testing my tool, so it should work.
One minor comment though.


>  drivers/staging/iio/iio_core.h            |    2 +-
>  drivers/staging/iio/industrialio-buffer.c |    6 +++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/iio_core.h b/drivers/staging/iio/iio_core.h
> index 36159e0..ff27f13 100644
> --- a/drivers/staging/iio/iio_core.h
> +++ b/drivers/staging/iio/iio_core.h
> @@ -49,7 +49,7 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>  
>  static inline int iio_chrdev_buffer_open(struct iio_dev *indio_dev)
>  {
> -	return -EINVAL;
> +	return 0;
>  }
>  
>  static inline void iio_chrdev_buffer_release(struct iio_dev *indio_dev)
> diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
> index bac672d..1a71171 100644
> --- a/drivers/staging/iio/industrialio-buffer.c
> +++ b/drivers/staging/iio/industrialio-buffer.c
> @@ -42,6 +42,8 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>  	struct iio_dev *indio_dev = filp->private_data;
>  	struct iio_buffer *rb = indio_dev->buffer;
>  
> +	if (!rb)
> +		return -ENODEV;

I think -EINVAL would be a better return code here.
Quote from the read(3) manpage:
"EINVAL: fd is attached to an object which is unsuitable for reading;"

>  	if (!rb->access->read_first_n)
>  		return -EINVAL;
>  	return rb->access->read_first_n(rb, n, buf);
> @@ -67,7 +69,7 @@ int iio_chrdev_buffer_open(struct iio_dev *indio_dev)
>  {
>  	struct iio_buffer *rb = indio_dev->buffer;
>  	if (!rb)
> -		return -EINVAL;
> +		return 0;
>  	if (rb->access->mark_in_use)
>  		rb->access->mark_in_use(rb);
>  	return 0;


