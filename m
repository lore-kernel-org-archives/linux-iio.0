Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49611 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbbADPoQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Jan 2015 10:44:16 -0500
Message-ID: <54A95FCA.2020605@kernel.org>
Date: Sun, 04 Jan 2015 15:44:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Octavian Purdila <octavian.purdila@intel.com>,
	linux-iio@vger.kernel.org
CC: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 03/11] iio: add watermark logic to iio read and poll
References: <1419122556-8100-1-git-send-email-octavian.purdila@intel.com> <1419122556-8100-4-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1419122556-8100-4-git-send-email-octavian.purdila@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/12/14 00:42, Octavian Purdila wrote:
> From: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
> 
> Currently the IIO buffer blocking read only wait until at least one
> data element is available.
> This patch makes the reader sleep until enough data is collected before
> returning to userspace. This should limit the read() calls count when
> trying to get data in batches.
> 
> Co-author: Yannick Bedhomme <yannick.bedhomme@mobile-devices.fr>
> Signed-off-by: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
> [rebased and remove buffer timeout]
> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
Looks good. I think everyone was pretty much behind this patch in it's
original form (except for the bit you dropped).  Still I'd like confirmation
from Lars and others (if they want to!)

Jonathan
> ---
>  Documentation/ABI/testing/sysfs-bus-iio  |  10 +++
>  drivers/iio/industrialio-buffer.c        | 114 ++++++++++++++++++++++++++-----
>  drivers/iio/kfifo_buf.c                  |  11 ++-
>  drivers/staging/iio/accel/sca3000_ring.c |   4 +-
>  include/linux/iio/buffer.h               |   9 ++-
>  5 files changed, 118 insertions(+), 30 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index df5e69e..7260f1f 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1142,3 +1142,13 @@ Contact:	linux-iio@vger.kernel.org
>  Description:
>  		This attribute is used to read the number of steps taken by the user
>  		since the last reboot while activated.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/buffer/low_watermark
> +KernelVersion:	3.20
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		A single positive integer specifying the maximum number of scan
> +		elements to wait for.
> +		Poll will block until the watermark is reached.
> +		Blocking read will wait until the minimum between the requested
> +		read amount or the low water mark is available.
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index bc55434..7f74c7f 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -37,7 +37,7 @@ static bool iio_buffer_is_active(struct iio_buffer *buf)
>  	return !list_empty(&buf->buffer_list);
>  }
>  
> -static bool iio_buffer_data_available(struct iio_buffer *buf)
> +static size_t iio_buffer_data_available(struct iio_buffer *buf)
>  {
>  	return buf->access->data_available(buf);
>  }
> @@ -53,6 +53,9 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>  {
>  	struct iio_dev *indio_dev = filp->private_data;
>  	struct iio_buffer *rb = indio_dev->buffer;
> +	size_t datum_size = rb->bytes_per_datum;
> +	size_t to_read = min_t(size_t, n / datum_size, rb->low_watermark);
> +	size_t count = 0;
>  	int ret;
>  
>  	if (!indio_dev->info)
> @@ -62,25 +65,38 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>  		return -EINVAL;
>  
>  	do {
> -		if (!iio_buffer_data_available(rb)) {
> -			if (filp->f_flags & O_NONBLOCK)
> -				return -EAGAIN;
> -
> +		if (filp->f_flags & O_NONBLOCK) {
> +			if (!iio_buffer_data_available(rb)) {
> +				ret = -EAGAIN;
> +				break;
> +			}
> +		} else {
>  			ret = wait_event_interruptible(rb->pollq,
> -					iio_buffer_data_available(rb) ||
> -					indio_dev->info == NULL);
> +			       iio_buffer_data_available(rb) >= to_read ||
> +						       indio_dev->info == NULL);
>  			if (ret)
>  				return ret;
> -			if (indio_dev->info == NULL)
> -				return -ENODEV;
> +			if (indio_dev->info == NULL) {
> +				ret = -ENODEV;
> +				break;
> +			}
>  		}
>  
> -		ret = rb->access->read_first_n(rb, n, buf);
> -		if (ret == 0 && (filp->f_flags & O_NONBLOCK))
> -			ret = -EAGAIN;
> -	 } while (ret == 0);
> +		ret = rb->access->read_first_n(rb, n, buf + count);
> +		if (ret < 0)
> +			break;
>  
> -	return ret;
> +		count += ret;
> +		n -= ret;
> +		to_read -= ret / datum_size;
> +	 } while (to_read > 0);
> +
> +	if (count)
> +		return count;
> +	if (ret < 0)
> +		return ret;
> +
> +	return -EAGAIN;
>  }
>  
>  /**
> @@ -96,9 +112,8 @@ unsigned int iio_buffer_poll(struct file *filp,
>  		return -ENODEV;
>  
>  	poll_wait(filp, &rb->pollq, wait);
> -	if (iio_buffer_data_available(rb))
> +	if (iio_buffer_data_available(rb) >= rb->low_watermark)
>  		return POLLIN | POLLRDNORM;
> -	/* need a way of knowing if there may be enough data... */
>  	return 0;
>  }
>  
> @@ -123,6 +138,7 @@ void iio_buffer_init(struct iio_buffer *buffer)
>  	INIT_LIST_HEAD(&buffer->buffer_list);
>  	init_waitqueue_head(&buffer->pollq);
>  	kref_init(&buffer->ref);
> +	buffer->low_watermark = 1;
>  }
>  EXPORT_SYMBOL(iio_buffer_init);
>  
> @@ -418,7 +434,16 @@ static ssize_t iio_buffer_write_length(struct device *dev,
>  	}
>  	mutex_unlock(&indio_dev->mlock);
>  
> -	return ret ? ret : len;
> +	if (ret)
> +		return ret;
> +
> +	if (buffer->length)
> +		val = buffer->length;
> +
> +	if (val < buffer->low_watermark)
> +		buffer->low_watermark = val;
> +
> +	return len;
>  }
>  
>  static ssize_t iio_buffer_show_enable(struct device *dev,
> @@ -472,6 +497,7 @@ static void iio_buffer_activate(struct iio_dev *indio_dev,
>  static void iio_buffer_deactivate(struct iio_buffer *buffer)
>  {
>  	list_del_init(&buffer->buffer_list);
> +	wake_up_interruptible(&buffer->pollq);
>  	iio_buffer_put(buffer);
>  }
>  
> @@ -752,16 +778,59 @@ done:
>  
>  static const char * const iio_scan_elements_group_name = "scan_elements";
>  
> +static ssize_t iio_buffer_show_watermark(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct iio_buffer *buffer = indio_dev->buffer;
> +
> +	return sprintf(buf, "%u\n", buffer->low_watermark);
> +}
> +
> +static ssize_t iio_buffer_store_watermark(struct device *dev,
> +					  struct device_attribute *attr,
> +					  const char *buf,
> +					  size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct iio_buffer *buffer = indio_dev->buffer;
> +	unsigned int val;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val > buffer->length)
> +		return -EINVAL;
> +
> +	mutex_lock(&indio_dev->mlock);
> +	if (iio_buffer_is_active(indio_dev->buffer)) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	buffer->low_watermark = val;
> +	ret = 0;
> +out:
> +	mutex_unlock(&indio_dev->mlock);
> +	return ret ? ret : len;
> +}
> +
>  static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
>  		   iio_buffer_write_length);
>  static struct device_attribute dev_attr_length_ro = __ATTR(length,
>  	S_IRUGO, iio_buffer_read_length, NULL);
>  static DEVICE_ATTR(enable, S_IRUGO | S_IWUSR,
>  		   iio_buffer_show_enable, iio_buffer_store_enable);
> +static DEVICE_ATTR(low_watermark, S_IRUGO | S_IWUSR,
> +		   iio_buffer_show_watermark, iio_buffer_store_watermark);
>  
>  static struct attribute *iio_buffer_attrs[] = {
>  	&dev_attr_length.attr,
>  	&dev_attr_enable.attr,
> +	&dev_attr_low_watermark.attr,
>  };
>  
>  int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
> @@ -942,8 +1011,17 @@ static const void *iio_demux(struct iio_buffer *buffer,
>  static int iio_push_to_buffer(struct iio_buffer *buffer, const void *data)
>  {
>  	const void *dataout = iio_demux(buffer, data);
> +	int ret;
>  
> -	return buffer->access->store_to(buffer, dataout);
> +	ret = buffer->access->store_to(buffer, dataout);
> +	if (ret)
> +		return ret;
> +
> +	/* We can't just test for watermark to decide if we wake the poll queue
> +	 * because read may request less samples than the watermark
> +	 */
> +	wake_up_interruptible(&buffer->pollq);
> +	return 0;
>  }
>  
>  static void iio_buffer_demux_free(struct iio_buffer *buffer)
> diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
> index b20a9cf..30a9bfa 100644
> --- a/drivers/iio/kfifo_buf.c
> +++ b/drivers/iio/kfifo_buf.c
> @@ -83,9 +83,6 @@ static int iio_store_to_kfifo(struct iio_buffer *r,
>  	ret = kfifo_in(&kf->kf, data, 1);
>  	if (ret != 1)
>  		return -EBUSY;
> -
> -	wake_up_interruptible_poll(&r->pollq, POLLIN | POLLRDNORM);
> -
>  	return 0;
>  }
>  
> @@ -109,16 +106,16 @@ static int iio_read_first_n_kfifo(struct iio_buffer *r,
>  	return copied;
>  }
>  
> -static bool iio_kfifo_buf_data_available(struct iio_buffer *r)
> +static size_t iio_kfifo_buf_data_available(struct iio_buffer *r)
>  {
>  	struct iio_kfifo *kf = iio_to_kfifo(r);
> -	bool empty;
> +	size_t samples;
>  
>  	mutex_lock(&kf->user_lock);
> -	empty = kfifo_is_empty(&kf->kf);
> +	samples = kfifo_len(&kf->kf);
>  	mutex_unlock(&kf->user_lock);
>  
> -	return !empty;
> +	return samples;
>  }
>  
>  static void iio_kfifo_buffer_release(struct iio_buffer *buffer)
> diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
> index f76a268..1e65dea 100644
> --- a/drivers/staging/iio/accel/sca3000_ring.c
> +++ b/drivers/staging/iio/accel/sca3000_ring.c
> @@ -129,9 +129,9 @@ error_ret:
>  	return ret ? ret : num_read;
>  }
>  
> -static bool sca3000_ring_buf_data_available(struct iio_buffer *r)
> +static size_t sca3000_ring_buf_data_available(struct iio_buffer *r)
>  {
> -	return r->stufftoread;
> +	return r->stufftoread ? r->low_watermark : 0;
>  }
>  
>  /**
> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> index b65850a..768593c 100644
> --- a/include/linux/iio/buffer.h
> +++ b/include/linux/iio/buffer.h
> @@ -21,8 +21,8 @@ struct iio_buffer;
>   * struct iio_buffer_access_funcs - access functions for buffers.
>   * @store_to:		actually store stuff to the buffer
>   * @read_first_n:	try to get a specified number of bytes (must exist)
> - * @data_available:	indicates whether data for reading from the buffer is
> - *			available.
> + * @data_available:	indicates how much data is available for reading from
> + *			the buffer.
>   * @request_update:	if a parameter change has been marked, update underlying
>   *			storage.
>   * @set_bytes_per_datum:set number of bytes per datum
> @@ -43,7 +43,7 @@ struct iio_buffer_access_funcs {
>  	int (*read_first_n)(struct iio_buffer *buffer,
>  			    size_t n,
>  			    char __user *buf);
> -	bool (*data_available)(struct iio_buffer *buffer);
> +	size_t (*data_available)(struct iio_buffer *buffer);
>  
>  	int (*request_update)(struct iio_buffer *buffer);
>  
> @@ -72,6 +72,8 @@ struct iio_buffer_access_funcs {
>   * @demux_bounce:	[INTERN] buffer for doing gather from incoming scan.
>   * @buffer_list:	[INTERN] entry in the devices list of current buffers.
>   * @ref:		[INTERN] reference count of the buffer.
> + * @low_watermark:	[INTERN] number of datums for poll/blocking read to
> + * 			wait for.
>   */
>  struct iio_buffer {
>  	int					length;
> @@ -90,6 +92,7 @@ struct iio_buffer {
>  	void					*demux_bounce;
>  	struct list_head			buffer_list;
>  	struct kref				ref;
> +	unsigned int				low_watermark;
>  };
>  
>  /**
> 

