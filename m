Return-Path: <archive@jic23.retrosnub.co.uk>
References: <1324055542-31272-1-git-send-email-lars@metafoo.de>
            <1324055542-31272-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1324055542-31272-4-git-send-email-lars@metafoo.de>
From: jic23@kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, Michael Hennerich
  <michael.hennerich@analog.com>, linux-iio@vger.kernel.org,
  device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 4/4] staging:iio:events: Add poll support
Date: Mon, 19 Dec 2011 08:46:41 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Message-Id: <20111219084641.3AA2B40382@saturn.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>

Lars-Peter Clausen writes: 

> Add poll support to the event queue. This will allow us to check for pending
> events in a application's event loop using poll() or similar. Since we already
> have support for blocking reads adding poll support as well is trivial. 
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org> 

Some corners here I'm not particularly familiar with, but is fine
as far as I can see! 

Thanks for these cleanups / functionality improvements. 

Jonathan
> ---
>  drivers/staging/iio/industrialio-event.c |   22 +++++++++++++++++++++-
>  1 files changed, 21 insertions(+), 1 deletions(-) 
> 
> diff --git a/drivers/staging/iio/industrialio-event.c b/drivers/staging/iio/industrialio-event.c
> index ef4943a..2263269 100644
> --- a/drivers/staging/iio/industrialio-event.c
> +++ b/drivers/staging/iio/industrialio-event.c
> @@ -56,7 +56,7 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp)
>  
>  		ret = kfifo_put(&ev_int->det_events, &ev);
>  		if (ret != 0)
> -			wake_up_locked(&ev_int->wait);
> +			wake_up_locked_poll(&ev_int->wait, POLLIN);
>  	}
>  	spin_unlock(&ev_int->wait.lock);
>  
> @@ -64,6 +64,25 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp)
>  }
>  EXPORT_SYMBOL(iio_push_event);
>  
> +/**
> + * iio_event_poll() - poll the event queue to find out if it has data
> + */
> +static unsigned int iio_event_poll(struct file *filep,
> +			     struct poll_table_struct *wait)
> +{
> +	struct iio_event_interface *ev_int = filep->private_data;
> +	unsigned int events = 0;
> +
> +	poll_wait(filep, &ev_int->wait, wait);
> +
> +	spin_lock(&ev_int->wait.lock);
> +	if (!kfifo_is_empty(&ev_int->det_events))
> +		events = POLLIN | POLLRDNORM;
> +	spin_unlock(&ev_int->wait.lock);
> +
> +	return events;
> +}
> +
>  static ssize_t iio_event_chrdev_read(struct file *filep,
>  				     char __user *buf,
>  				     size_t count,
> @@ -112,6 +131,7 @@ static int iio_event_chrdev_release(struct inode *inode, struct file *filep)
>  
>  static const struct file_operations iio_event_chrdev_fileops = {
>  	.read =  iio_event_chrdev_read,
> +	.poll =  iio_event_poll,
>  	.release = iio_event_chrdev_release,
>  	.owner = THIS_MODULE,
>  	.llseek = noop_llseek,
> -- 
> 1.7.7.3 
> 
> 
