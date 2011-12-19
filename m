Return-Path: <jic23@kernel.org>
Message-ID: <4EEFA546.5010204@kernel.org>
Date: Mon, 19 Dec 2011 20:57:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
 Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org,
 drivers@analog.com
Subject: Re: [PATCH v2 4/6] staging:iio:events: Use waitqueue lock to protect
 event queue
References: <1324290580-17511-1-git-send-email-lars@metafoo.de> <1324290580-17511-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1324290580-17511-4-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 12/19/2011 10:29 AM, Lars-Peter Clausen wrote:
> Use the waitqueue lock to protect the event queue instead of a custom mutex.
> This has the advantage that we can call the waitqueue operations with the lock
> held, which simplifies the code flow a bit.
> 
Unusual ordering of this.  usually your sign off first then everyone
elses whatever below.
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/staging/iio/industrialio-event.c |   45 ++++++++++++-----------------
>  1 files changed, 19 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/staging/iio/industrialio-event.c b/drivers/staging/iio/industrialio-event.c
> index d63aa0b..b5f7a2c 100644
> --- a/drivers/staging/iio/industrialio-event.c
> +++ b/drivers/staging/iio/industrialio-event.c
> @@ -34,8 +34,7 @@
>   * @group:		event interface sysfs attribute group
>   */
>  struct iio_event_interface {
> -	wait_queue_head_t	wait;
> -	struct mutex		event_list_lock;
> +	wait_queue_head_t			wait;
>  	DECLARE_KFIFO(det_events, struct iio_event_data, 16);
>  
>  	struct list_head	dev_attr_list;
> @@ -50,19 +49,17 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp)
>  	int copied;
>  
>  	/* Does anyone care? */
> -	mutex_lock(&ev_int->event_list_lock);
> +	spin_lock(&ev_int->wait.lock);
>  	if (test_bit(IIO_BUSY_BIT_POS, &ev_int->flags)) {
>  
>  		ev.id = ev_code;
>  		ev.timestamp = timestamp;
>  
>  		copied = kfifo_put(&ev_int->det_events, &ev);
> -
> -		mutex_unlock(&ev_int->event_list_lock);
>  		if (copied != 0)
> -			wake_up_interruptible(&ev_int->wait);
> -	} else
> -		mutex_unlock(&ev_int->event_list_lock);
> +			wake_up_locked(&ev_int->wait);
> +	}
> +	spin_unlock(&ev_int->wait.lock);
>  
>  	return 0;
>  }
> @@ -80,28 +77,25 @@ static ssize_t iio_event_chrdev_read(struct file *filep,
>  	if (count < sizeof(struct iio_event_data))
>  		return -EINVAL;
>  
> -	mutex_lock(&ev_int->event_list_lock);
> +	spin_lock(&ev_int->wait.lock);
>  	if (kfifo_is_empty(&ev_int->det_events)) {
>  		if (filep->f_flags & O_NONBLOCK) {
>  			ret = -EAGAIN;
> -			goto error_mutex_unlock;
> +			goto error_unlock;
>  		}
> -		mutex_unlock(&ev_int->event_list_lock);
>  		/* Blocking on device; waiting for something to be there */
> -		ret = wait_event_interruptible(ev_int->wait,
> +		ret = wait_event_interruptible_locked(ev_int->wait,
>  					!kfifo_is_empty(&ev_int->det_events));
>  		if (ret)
> -			goto error_ret;
> +			goto error_unlock;
>  		/* Single access device so no one else can get the data */
> -		mutex_lock(&ev_int->event_list_lock);
>  	}
>  
> -	mutex_unlock(&ev_int->event_list_lock);
>  	ret = kfifo_to_user(&ev_int->det_events, buf, count, &copied);
>  
> -error_mutex_unlock:
> -	mutex_unlock(&ev_int->event_list_lock);
> -error_ret:
> +error_unlock:
> +	spin_unlock(&ev_int->wait.lock);
> +
>  	return ret ? ret : copied;
>  }
>  
> @@ -109,7 +103,7 @@ static int iio_event_chrdev_release(struct inode *inode, struct file *filep)
>  {
>  	struct iio_event_interface *ev_int = filep->private_data;
>  
> -	mutex_lock(&ev_int->event_list_lock);
> +	spin_lock(&ev_int->wait.lock);
>  	clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
>  	/*
>  	 * In order to maintain a clean state for reopening,
> @@ -117,7 +111,7 @@ static int iio_event_chrdev_release(struct inode *inode, struct file *filep)
>  	 * any new __iio_push_event calls running.
>  	 */
>  	kfifo_reset_out(&ev_int->det_events);
> -	mutex_unlock(&ev_int->event_list_lock);
> +	spin_unlock(&ev_int->wait.lock);
>  
>  	return 0;
>  }
> @@ -137,18 +131,18 @@ int iio_event_getfd(struct iio_dev *indio_dev)
>  	if (ev_int == NULL)
>  		return -ENODEV;
>  
> -	mutex_lock(&ev_int->event_list_lock);
> +	spin_lock(&ev_int->wait.lock);
>  	if (test_and_set_bit(IIO_BUSY_BIT_POS, &ev_int->flags)) {
> -		mutex_unlock(&ev_int->event_list_lock);
> +		spin_unlock(&ev_int->wait.lock);
>  		return -EBUSY;
>  	}
> -	mutex_unlock(&ev_int->event_list_lock);
> +	spin_unlock(&ev_int->wait.lock);
>  	fd = anon_inode_getfd("iio:event",
>  				&iio_event_chrdev_fileops, ev_int, O_RDONLY);
>  	if (fd < 0) {
> -		mutex_lock(&ev_int->event_list_lock);
> +		spin_lock(&ev_int->wait.lock);
>  		clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
> -		mutex_unlock(&ev_int->event_list_lock);
> +		spin_unlock(&ev_int->wait.lock);
>  	}
>  	return fd;
>  }
> @@ -357,7 +351,6 @@ static bool iio_check_for_dynamic_events(struct iio_dev *indio_dev)
>  
>  static void iio_setup_ev_int(struct iio_event_interface *ev_int)
>  {
> -	mutex_init(&ev_int->event_list_lock);
>  	INIT_KFIFO(ev_int->det_events);
>  	init_waitqueue_head(&ev_int->wait);
>  }
