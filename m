Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46364 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612Ab3JLKEK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Oct 2013 06:04:10 -0400
Message-ID: <52592CC9.4010504@kernel.org>
Date: Sat, 12 Oct 2013 12:04:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iio: Return -ENODEV for file operations if the
 device has been unregistered
References: <1380884822-17035-1-git-send-email-lars@metafoo.de> <1380884822-17035-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1380884822-17035-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/04/13 12:06, Lars-Peter Clausen wrote:
> If the IIO device has been unregistered return -ENODEV for any further file
> operations like read() and ioctl(). This avoids userspace being able to grab new
> references to the device.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks
> ---
> No changes since v1
> ---
>  drivers/iio/industrialio-buffer.c | 6 ++++++
>  drivers/iio/industrialio-core.c   | 3 +++
>  drivers/iio/industrialio-event.c  | 6 ++++++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 36c39dc..6c7a9c5 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -48,6 +48,9 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>  	struct iio_dev *indio_dev = filp->private_data;
>  	struct iio_buffer *rb = indio_dev->buffer;
>  
> +	if (!indio_dev->info)
> +		return -ENODEV;
> +
>  	if (!rb || !rb->access->read_first_n)
>  		return -EINVAL;
>  	return rb->access->read_first_n(rb, n, buf);
> @@ -62,6 +65,9 @@ unsigned int iio_buffer_poll(struct file *filp,
>  	struct iio_dev *indio_dev = filp->private_data;
>  	struct iio_buffer *rb = indio_dev->buffer;
>  
> +	if (!indio_dev->info)
> +		return -ENODEV;
> +
>  	poll_wait(filp, &rb->pollq, wait);
>  	if (rb->stufftoread)
>  		return POLLIN | POLLRDNORM;
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 0dfaf9e..c9c6558 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1041,6 +1041,9 @@ static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  	int __user *ip = (int __user *)arg;
>  	int fd;
>  
> +	if (!indio_dev->info)
> +		return -ENODEV;
> +
>  	if (cmd == IIO_GET_EVENT_FD_IOCTL) {
>  		fd = iio_event_getfd(indio_dev);
>  		if (copy_to_user(ip, &fd, sizeof(fd)))
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index 36f0c8e..837d450 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -76,6 +76,9 @@ static unsigned int iio_event_poll(struct file *filep,
>  	struct iio_event_interface *ev_int = indio_dev->event_interface;
>  	unsigned int events = 0;
>  
> +	if (!indio_dev->info)
> +		return -ENODEV;
> +
>  	poll_wait(filep, &ev_int->wait, wait);
>  
>  	spin_lock_irq(&ev_int->wait.lock);
> @@ -96,6 +99,9 @@ static ssize_t iio_event_chrdev_read(struct file *filep,
>  	unsigned int copied;
>  	int ret;
>  
> +	if (!indio_dev->info)
> +		return -ENODEV;
> +
>  	if (count < sizeof(struct iio_event_data))
>  		return -EINVAL;
>  
> 
