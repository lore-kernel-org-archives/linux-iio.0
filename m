Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38690 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814AbaBRKxx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Feb 2014 05:53:53 -0500
Message-ID: <53033BE7.3040004@kernel.org>
Date: Tue, 18 Feb 2014 10:54:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:event: Fix and cleanup locking
References: <1392403786-22127-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1392403786-22127-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/02/14 18:49, Lars-Peter Clausen wrote:
> The event code currently holds a spinlock with IRQs disabled while calling
> kfifo_to_user(). kfifo_to_user() can generate a page fault though, which means
> we have to be able to sleep, which is not possible if the interrupts are
> disabled. The good thing is that kfifo handles concurrent read and write access
> just fine as long as there is only one reader and one writer, so we do not any
> locking to protect against concurrent access from the read and writer thread. It
> is possible though that userspace is trying to read from the event FIFO from
> multiple concurrent threads, so we need to add locking to protect against this.
> This is done using a mutex. The mutex will only protect the kfifo_to_user()
> call, it will not protect the waitqueue. This means that multiple threads can be
> waiting for new data and once a new event is added to the FIFO all waiting
> threads will be woken up. If one of those threads is unable to read any data
> (because another thread already read all the data) it will go back to sleep. The
> only remaining issue is that now that the clearing of the BUSY flag and the
> emptying of the FIFO does no longer happen in one atomic step it is possible
> that a event is added to the FIFO after it has been emptied and this sample will
> be visible the next time a new event file descriptor is created. To avoid this
> rather move the emptying of the FIFO from iio_event_chrdev_release to
> iio_event_getfd().
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
The patch looks fine.  I'm a little worried that's too involved for this stage
in the merge cycle.  So is this an issue observed in the wild (in which case
I probably want to get it upstream asap) or is it just a theoretical issue
at the moment? (e.g. can I leave it for the next merge window).

Actually without the spin lock in getfd, is there any path where it would allocate
two anon file descriptors?

Jonathan
> ---
>   drivers/iio/industrialio-event.c | 83 ++++++++++++++++++++--------------------
>   1 file changed, 41 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index c9c1419..0719443 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -40,6 +40,7 @@ struct iio_event_interface {
>   	struct list_head	dev_attr_list;
>   	unsigned long		flags;
>   	struct attribute_group	group;
> +	struct mutex		read_lock;
>   };
>
>   /**
> @@ -47,16 +48,17 @@ struct iio_event_interface {
>    * @indio_dev:		IIO device structure
>    * @ev_code:		What event
>    * @timestamp:		When the event occurred
> + *
> + * Note: The caller must make sure that this function is not running
> + * concurrently for the same indio_dev more than once.
>    **/
>   int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp)
>   {
>   	struct iio_event_interface *ev_int = indio_dev->event_interface;
>   	struct iio_event_data ev;
> -	unsigned long flags;
>   	int copied;
>
>   	/* Does anyone care? */
> -	spin_lock_irqsave(&ev_int->wait.lock, flags);
>   	if (test_bit(IIO_BUSY_BIT_POS, &ev_int->flags)) {
>
>   		ev.id = ev_code;
> @@ -64,9 +66,8 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp)
>
>   		copied = kfifo_put(&ev_int->det_events, ev);
>   		if (copied != 0)
> -			wake_up_locked_poll(&ev_int->wait, POLLIN);
> +			wake_up_poll(&ev_int->wait, POLLIN);
>   	}
> -	spin_unlock_irqrestore(&ev_int->wait.lock, flags);
>
>   	return 0;
>   }
> @@ -87,10 +88,8 @@ static unsigned int iio_event_poll(struct file *filep,
>
>   	poll_wait(filep, &ev_int->wait, wait);
>
> -	spin_lock_irq(&ev_int->wait.lock);
>   	if (!kfifo_is_empty(&ev_int->det_events))
>   		events = POLLIN | POLLRDNORM;
> -	spin_unlock_irq(&ev_int->wait.lock);
>
>   	return events;
>   }
> @@ -111,31 +110,40 @@ static ssize_t iio_event_chrdev_read(struct file *filep,
>   	if (count < sizeof(struct iio_event_data))
>   		return -EINVAL;
>
> -	spin_lock_irq(&ev_int->wait.lock);
> -	if (kfifo_is_empty(&ev_int->det_events)) {
> -		if (filep->f_flags & O_NONBLOCK) {
> -			ret = -EAGAIN;
> -			goto error_unlock;
> -		}
> -		/* Blocking on device; waiting for something to be there */
> -		ret = wait_event_interruptible_locked_irq(ev_int->wait,
> +	do {
> +		if (kfifo_is_empty(&ev_int->det_events)) {
> +			if (filep->f_flags & O_NONBLOCK)
> +				return -EAGAIN;
> +
> +			ret = wait_event_interruptible(ev_int->wait,
>   					!kfifo_is_empty(&ev_int->det_events) ||
>   					indio_dev->info == NULL);
> -		if (ret)
> -			goto error_unlock;
> -		if (indio_dev->info == NULL) {
> -			ret = -ENODEV;
> -			goto error_unlock;
> +			if (ret)
> +				return ret;
> +			if (indio_dev->info == NULL)
> +				return -ENODEV;
>   		}
> -		/* Single access device so no one else can get the data */
> -	}
>
> -	ret = kfifo_to_user(&ev_int->det_events, buf, count, &copied);
> +		if (mutex_lock_interruptible(&ev_int->read_lock))
> +			return -ERESTARTSYS;
> +		ret = kfifo_to_user(&ev_int->det_events, buf, count, &copied);
> +		mutex_unlock(&ev_int->read_lock);
> +
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * If we couldn't read anything from the fifo (a different
> +		 * thread might have been faster) we either return -EAGAIN if
> +		 * the file descriptor is non-blocking, otherwise we go back to
> +		 * sleep and wait for more data to arrive.
> +		 */
> +		if (copied == 0 && (filep->f_flags & O_NONBLOCK))
> +			return -EAGAIN;
>
> -error_unlock:
> -	spin_unlock_irq(&ev_int->wait.lock);
> +	} while (copied == 0);
>
> -	return ret ? ret : copied;
> +	return copied;
>   }
>
>   static int iio_event_chrdev_release(struct inode *inode, struct file *filep)
> @@ -143,15 +151,7 @@ static int iio_event_chrdev_release(struct inode *inode, struct file *filep)
>   	struct iio_dev *indio_dev = filep->private_data;
>   	struct iio_event_interface *ev_int = indio_dev->event_interface;
>
> -	spin_lock_irq(&ev_int->wait.lock);
> -	__clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
> -	/*
> -	 * In order to maintain a clean state for reopening,
> -	 * clear out any awaiting events. The mask will prevent
> -	 * any new __iio_push_event calls running.
> -	 */
> -	kfifo_reset_out(&ev_int->det_events);
> -	spin_unlock_irq(&ev_int->wait.lock);
> +	clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
>
>   	iio_device_put(indio_dev);
>
> @@ -174,22 +174,20 @@ int iio_event_getfd(struct iio_dev *indio_dev)
>   	if (ev_int == NULL)
>   		return -ENODEV;
>
> -	spin_lock_irq(&ev_int->wait.lock);
> -	if (__test_and_set_bit(IIO_BUSY_BIT_POS, &ev_int->flags)) {
> -		spin_unlock_irq(&ev_int->wait.lock);
> +	if (test_and_set_bit(IIO_BUSY_BIT_POS, &ev_int->flags))
>   		return -EBUSY;
> -	}
> -	spin_unlock_irq(&ev_int->wait.lock);
> +
>   	iio_device_get(indio_dev);
>
>   	fd = anon_inode_getfd("iio:event", &iio_event_chrdev_fileops,
>   				indio_dev, O_RDONLY | O_CLOEXEC);
>   	if (fd < 0) {
> -		spin_lock_irq(&ev_int->wait.lock);
> -		__clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
> -		spin_unlock_irq(&ev_int->wait.lock);
> +		clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
>   		iio_device_put(indio_dev);
> +	} else {
> +		kfifo_reset_out(&ev_int->det_events);
>   	}
> +
>   	return fd;
>   }
>
> @@ -425,6 +423,7 @@ static void iio_setup_ev_int(struct iio_event_interface *ev_int)
>   {
>   	INIT_KFIFO(ev_int->det_events);
>   	init_waitqueue_head(&ev_int->wait);
> +	mutex_init(&ev_int->read_lock);
>   }
>
>   static const char *iio_event_group_name = "events";
>

