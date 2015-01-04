Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49705 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647AbbADQHG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Jan 2015 11:07:06 -0500
Message-ID: <54A96525.2030200@kernel.org>
Date: Sun, 04 Jan 2015 16:07:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Octavian Purdila <octavian.purdila@intel.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 04/11] iio: add support for hardware fifo
References: <1419122556-8100-1-git-send-email-octavian.purdila@intel.com> <1419122556-8100-5-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1419122556-8100-5-git-send-email-octavian.purdila@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/12/14 00:42, Octavian Purdila wrote:

Thanks for taking this on!

This all looks fairly sensible, though a few comments inline.
One big semantic change I'd suggest is to allow the watermark
level passed to the hardware to be a 'hint' rather than a hard
and fast rull.  A lot of these hardware buffers are fairly small
(perhaps 32 entries) and the devices can run fast so whilst
we will obviously have to handle an interrupt often, we may well
want to have a much larger software front end buffer with a
much larger watermark.  For example, a 8192Hz accelerometer
with 32 entry fifo (watermark at 16).  Will fire an interrupt 512 times
a second.  Userspace might be only interested in getting data 32 times
a second and hence want a watermark of 256 entries and probably have
a buffer that is 512 entries long or more.

> Some devices have hardware buffers that can store a number of samples
> for later consumption. Hardware usually provides interrupts to notify
> the processor when the fifo is full or when it has reached a certain
> threshold. This helps with reducing the number of interrupts to the
> host processor and thus it helps decreasing the power consumption.
> 
> This patch adds support for hardware fifo to IIO by allowing the
> drivers to register operations for flushing the hadware fifo and
> setting the watermark level.

Perhaps put something in here to observe that this is a different approach
to the straight hardware buffer stuff we already have - of most interest
for hybrid buffering rather than a pure hardware buffer.

> 
> A driver implementing hardware fifo support must also provide a
> watermark trigger which must contain "watermark" in its name.
> 
> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 22 +++++++++++++++++
>  drivers/iio/industrialio-buffer.c       | 44 ++++++++++++++++++++++++++++-----
>  include/linux/iio/iio.h                 | 17 +++++++++++++
>  3 files changed, 77 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 7260f1f..6bb67ac 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1152,3 +1152,25 @@ Description:
>  		Poll will block until the watermark is reached.
>  		Blocking read will wait until the minimum between the requested
>  		read amount or the low water mark is available.
> +		If the device has a hardware fifo this value is going to be used
> +		for the hardware fifo watermark as well.

I'd make this a litle vaguer (deliberately ;).   Perhaps used as a 'hint'
for the hardware fifo watermark as well.  The reason being that if we set
the software watermark at say 20 and the hardware only has 15 fifo entries,
then we might want to be clever and say set the hardware fifo watershed to 10.
For now that would be a decision of the hardware driver rather than one for
the core.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/buffer/hwfifo-length
> +KernelVersion:	3.20
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		A single positive integer specifying the maximum number of
> +		samples that the hardware fifo has. If the device does not
> +		support hardware fifo this is zero.
> +		When a device supports hardware fifo it will expose a trigger
> +		with the name that contains "watermark"
> +		(e.g. i2c-BMC150A:00-watermark-dev0).
> +		To use the hardware fifo the user must set an appropriate value
> +		in the buffer/length and buffer/low_watermark entries and select
> +		the watermark trigger. At that poin the hardware fifo will be
point
> +		enabled and the samples will be collected in a hardware buffer.
Hmm. I wonder to a degree if the trigger approach really makes sense for
fifo equiped devices.  We've deliberately not added one in a few existing
cases.

Otherwise, is there a reason to run this separately from a trigger not using
the fifo.  Surely that's just the same as a watermark of 1?

Anyhow, a point for discussion!

> +		When the number of samples in the hardware fifo reaches the
> +		watermark level the watermark trigger is issued and data is
> +		flushed to the devices buffer.
> +		A hardware buffer flush will also be triggered when reading from
> +		the device buffer and there is not enough data available.
> \ No newline at end of file
Fix this..
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 7f74c7f..3da6d07 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -37,9 +37,17 @@ static bool iio_buffer_is_active(struct iio_buffer *buf)
>  	return !list_empty(&buf->buffer_list);
>  }
>  
> -static size_t iio_buffer_data_available(struct iio_buffer *buf)
> +static bool iio_buffer_data_available(struct iio_dev *indio_dev,
> +				      struct iio_buffer *buf, size_t required)
>  {
> -	return buf->access->data_available(buf);
> +	size_t avail = buf->access->data_available(buf);
> +
> +	if (avail < required && indio_dev->hwfifo) {
> +		indio_dev->hwfifo->flush(indio_dev);
> +		avail = buf->access->data_available(buf);
> +	}
> +
> +	return avail >= required;
Does it make sense to move the decision in here?  Could just as easily
have left this as returning the length and done the logic outside...
I don't mind that much... However, we probably want to rename the function
now that it is doing more than strictly querying availability.

Could also have flush take a parameter for what is desired and only read
that many?  On relatively slow buses might make sense...
>  }
>  
>  /**
> @@ -66,13 +74,13 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>  
>  	do {
>  		if (filp->f_flags & O_NONBLOCK) {
> -			if (!iio_buffer_data_available(rb)) {
> +			if (!iio_buffer_data_available(indio_dev, rb, 1)) {
>  				ret = -EAGAIN;
>  				break;
>  			}
>  		} else {
>  			ret = wait_event_interruptible(rb->pollq,
> -			       iio_buffer_data_available(rb) >= to_read ||
> +		            iio_buffer_data_available(indio_dev, rb, to_read) ||
>  						       indio_dev->info == NULL);
>  			if (ret)
>  				return ret;
> @@ -112,7 +120,7 @@ unsigned int iio_buffer_poll(struct file *filp,
>  		return -ENODEV;
>  
>  	poll_wait(filp, &rb->pollq, wait);
> -	if (iio_buffer_data_available(rb) >= rb->low_watermark)
> +	if (iio_buffer_data_available(indio_dev, rb, rb->low_watermark))
>  		return POLLIN | POLLRDNORM;
>  	return 0;
>  }
> @@ -440,8 +448,14 @@ static ssize_t iio_buffer_write_length(struct device *dev,
>  	if (buffer->length)
>  		val = buffer->length;
>  
> -	if (val < buffer->low_watermark)
> +	if (val < buffer->low_watermark) {
> +		if (indio_dev->hwfifo) {
> +			ret = indio_dev->hwfifo->set_watermark(indio_dev, val);
> +			if (ret)
> +				return ret;
> +		}
>  		buffer->low_watermark = val;
> +	}
>  
>  	return len;
>  }
> @@ -811,6 +825,12 @@ static ssize_t iio_buffer_store_watermark(struct device *dev,
>  		goto out;
>  	}
>  
> +	if (indio_dev->hwfifo) {
> +		ret = indio_dev->hwfifo->set_watermark(indio_dev, val);
> +		if (ret)
> +			goto out;
> +	}
> +
>  	buffer->low_watermark = val;
>  	ret = 0;
>  out:
> @@ -818,6 +838,16 @@ out:
>  	return ret ? ret : len;
>  }
>  
> +ssize_t iio_buffer_hwfifo_read_length(struct device *dev,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	const struct iio_hwfifo *hwfifo = indio_dev->hwfifo;
> +
> +	return sprintf(buf, "%u\n", hwfifo ? hwfifo->length : 0);
> +}
> +
>  static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
>  		   iio_buffer_write_length);
>  static struct device_attribute dev_attr_length_ro = __ATTR(length,
> @@ -826,11 +856,13 @@ static DEVICE_ATTR(enable, S_IRUGO | S_IWUSR,
>  		   iio_buffer_show_enable, iio_buffer_store_enable);
>  static DEVICE_ATTR(low_watermark, S_IRUGO | S_IWUSR,
>  		   iio_buffer_show_watermark, iio_buffer_store_watermark);
> +static DEVICE_ATTR(hwfifo_length, S_IRUGO, iio_buffer_hwfifo_read_length, NULL);
>  
>  static struct attribute *iio_buffer_attrs[] = {
>  	&dev_attr_length.attr,
>  	&dev_attr_enable.attr,
>  	&dev_attr_low_watermark.attr,
> +	&dev_attr_hwfifo_length.attr,
>  };
>  
>  int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 878d861..f64a05f 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -417,6 +417,22 @@ struct iio_buffer_setup_ops {
>  };
>  
>  /**
> + * struct iio_buffer_hwfifo_ops - hardware fifo operations
> + *
> + * @length:		[DRIVER] the hardware fifo length
> + * @set_watermark:	[DRIVER] setups the watermark level
> + * @flush:		[DRIVER] copies data from the hardware buffer to the
> + *		 	device buffer
> + * @watermark_trig:	[DRIVER] an allocated and registered trigger containing
> + *			"watermark" in its name
err. This last one isn't actually in the structure...
> + */
> +struct iio_hwfifo {
> +	int length;
> +	int (*set_watermark)(struct iio_dev *, unsigned int);
> +	int (*flush)(struct iio_dev *);
> +};
> +
> +/**
>   * struct iio_dev - industrial I/O device
>   * @id:			[INTERN] used to identify device internally
>   * @modes:		[DRIVER] operating modes supported by device
> @@ -491,6 +507,7 @@ struct iio_dev {
>  	int				groupcounter;
>  
>  	unsigned long			flags;
> +	const struct iio_hwfifo		*hwfifo;
>  #if defined(CONFIG_DEBUG_FS)
>  	struct dentry			*debugfs_dentry;
>  	unsigned			cached_reg_addr;
> 

