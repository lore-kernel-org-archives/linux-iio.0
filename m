Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56473 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266Ab3IUKsE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 06:48:04 -0400
Message-ID: <523D8787.2010402@kernel.org>
Date: Sat, 21 Sep 2013 12:48:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 02/10] iio: Keep a reference to the IIO device for open
 file descriptors
References: <1379534574-11213-1-git-send-email-lars@metafoo.de> <1379534574-11213-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1379534574-11213-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/18/13 21:02, Lars-Peter Clausen wrote:
> Make sure that the IIO device is not freed while we still have file descriptors
> for it.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/industrialio-core.c  |  4 ++++
>  drivers/iio/industrialio-event.c | 19 ++++++++++++++-----
>  2 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 96b35f0..5ea741c 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1012,6 +1012,8 @@ static int iio_chrdev_open(struct inode *inode, struct file *filp)
>  	if (test_and_set_bit(IIO_BUSY_BIT_POS, &indio_dev->flags))
>  		return -EBUSY;
>  
> +	iio_device_get(indio_dev);
> +
>  	filp->private_data = indio_dev;
>  
>  	return 0;
> @@ -1025,6 +1027,8 @@ static int iio_chrdev_release(struct inode *inode, struct file *filp)
>  	struct iio_dev *indio_dev = container_of(inode->i_cdev,
>  						struct iio_dev, chrdev);
>  	clear_bit(IIO_BUSY_BIT_POS, &indio_dev->flags);
> +	iio_device_put(indio_dev);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index 2390e3d..f89843b 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -72,7 +72,8 @@ EXPORT_SYMBOL(iio_push_event);
>  static unsigned int iio_event_poll(struct file *filep,
>  			     struct poll_table_struct *wait)
>  {
> -	struct iio_event_interface *ev_int = filep->private_data;
> +	struct iio_dev *indio_dev = filep->private_data;
> +	struct iio_event_interface *ev_int = indio_dev->event_interface;
>  	unsigned int events = 0;
>  
>  	poll_wait(filep, &ev_int->wait, wait);
> @@ -90,7 +91,8 @@ static ssize_t iio_event_chrdev_read(struct file *filep,
>  				     size_t count,
>  				     loff_t *f_ps)
>  {
> -	struct iio_event_interface *ev_int = filep->private_data;
> +	struct iio_dev *indio_dev = filep->private_data;
> +	struct iio_event_interface *ev_int = indio_dev->event_interface;
>  	unsigned int copied;
>  	int ret;
>  
> @@ -121,7 +123,8 @@ error_unlock:
>  
>  static int iio_event_chrdev_release(struct inode *inode, struct file *filep)
>  {
> -	struct iio_event_interface *ev_int = filep->private_data;
> +	struct iio_dev *indio_dev = filep->private_data;
> +	struct iio_event_interface *ev_int = indio_dev->event_interface;
>  
>  	spin_lock_irq(&ev_int->wait.lock);
>  	__clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
> @@ -133,6 +136,8 @@ static int iio_event_chrdev_release(struct inode *inode, struct file *filep)
>  	kfifo_reset_out(&ev_int->det_events);
>  	spin_unlock_irq(&ev_int->wait.lock);
>  
> +	iio_device_put(indio_dev);
> +
>  	return 0;
>  }
>  
> @@ -158,12 +163,16 @@ int iio_event_getfd(struct iio_dev *indio_dev)
>  		return -EBUSY;
>  	}
>  	spin_unlock_irq(&ev_int->wait.lock);
> -	fd = anon_inode_getfd("iio:event",
> -				&iio_event_chrdev_fileops, ev_int, O_RDONLY | O_CLOEXEC);
> +
> +	iio_device_get(indio_dev);
> +
> +	fd = anon_inode_getfd("iio:event", &iio_event_chrdev_fileops,
> +				indio_dev, O_RDONLY | O_CLOEXEC);
>  	if (fd < 0) {
>  		spin_lock_irq(&ev_int->wait.lock);
>  		__clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
>  		spin_unlock_irq(&ev_int->wait.lock);
> +		iio_device_put(indio_dev);
>  	}
>  	return fd;
>  }
> 
