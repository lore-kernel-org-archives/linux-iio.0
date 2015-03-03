Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-076.synserver.de ([212.40.185.76]:1065 "EHLO
	smtp-out-067.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756918AbbCCRqq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 Mar 2015 12:46:46 -0500
Message-ID: <54F5F380.7030509@metafoo.de>
Date: Tue, 03 Mar 2015 18:46:40 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Octavian Purdila <octavian.purdila@intel.com>,
	linux-iio@vger.kernel.org
CC: srinivas.pandruvada@linux.intel.com,
	Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
Subject: Re: [PATCH v4 1/3] iio: add watermark logic to iio read and poll
References: <1425399662-5539-1-git-send-email-octavian.purdila@intel.com> <1425399662-5539-2-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1425399662-5539-2-git-send-email-octavian.purdila@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/03/2015 05:21 PM, Octavian Purdila wrote:
[...]
> @@ -61,26 +64,48 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>   	if (!rb || !rb->access->read_first_n)
>   		return -EINVAL;
>
> -	do {
> -		if (!iio_buffer_data_available(rb)) {
> -			if (filp->f_flags & O_NONBLOCK)
> -				return -EAGAIN;
> +	/*
> +	 * If datum_size is 0 there will never be anything to read from the
> +	 * buffer, so signal end of file now.
> +	 */
> +	if (!datum_size)
> +		return 0;
>
> +	to_read = min_t(size_t, n / datum_size, rb->watermark);

I'd maybe call it wakeup_threshold.

> +
> +	do {
> +		if (filp->f_flags & O_NONBLOCK) {
> +			if (!iio_buffer_data_available(rb)) {
> +				ret = -EAGAIN;
> +				break;
> +			}
> +		} else {
>   			ret = wait_event_interruptible(rb->pollq,
> -					iio_buffer_data_available(rb) ||
> -					indio_dev->info == NULL);
> +			       iio_buffer_data_available(rb) >= to_read ||
> +						       indio_dev->info == NULL);

This needs also to evaluate to true if the buffer is disabled so we have a 
chance to read any amount residue sample that are less than watermark.

>   			if (ret)
>   				return ret;
> -			if (indio_dev->info == NULL)
> -				return -ENODEV;
> +			if (indio_dev->info == NULL) {
> +				ret = -ENODEV;
> +				break;
> +			}
>   		}
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


This will underflow if there are more than watermark sample in the buffer 
and and more than watermark samples have been requested by userspace...


> +	 } while (to_read > 0);

... and then we get trapped in a very long loop.

In my opinion there is no need to change the loop at all, only update the 
wakeup condition.

> +
> +	if (count)
> +		return count;
> +	if (ret < 0)
> +		return ret;
> +
> +	return -EAGAIN;
>   }
>
>   /**
> @@ -96,9 +121,8 @@ unsigned int iio_buffer_poll(struct file *filp,
>   		return -ENODEV;
>
>   	poll_wait(filp, &rb->pollq, wait);
> -	if (iio_buffer_data_available(rb))
> +	if (iio_buffer_data_available(rb) >= rb->watermark)

Same here needs to wakeup if the buffer is disabled and there is at least 
one sample.

>   		return POLLIN | POLLRDNORM;
> -	/* need a way of knowing if there may be enough data... */
>   	return 0;
>   }
>
[...]
> @@ -418,7 +443,16 @@ static ssize_t iio_buffer_write_length(struct device *dev,
>   	}
>   	mutex_unlock(&indio_dev->mlock);
>
> -	return ret ? ret : len;
> +	if (ret)
> +		return ret;
> +
> +	if (buffer->length)
> +		val = buffer->length;
> +
> +	if (val < buffer->watermark)
> +		buffer->watermark = val;

Needs to be inside the locked section.

> +
> +	return len;
>   }
[...]
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

Same here.

> +		return -EINVAL;
> +
> +	mutex_lock(&indio_dev->mlock);
> +	if (iio_buffer_is_active(indio_dev->buffer)) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	buffer->watermark = val;

We should probably reject 0.

> +	ret = 0;
> +out:
> +	mutex_unlock(&indio_dev->mlock);
> +	return ret ? ret : len;
> +}
> +
[...]
>   int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
> @@ -944,8 +1022,18 @@ static const void *iio_demux(struct iio_buffer *buffer,
>   static int iio_push_to_buffer(struct iio_buffer *buffer, const void *data)
>   {
>   	const void *dataout = iio_demux(buffer, data);
> +	int ret;
> +
> +	ret = buffer->access->store_to(buffer, dataout);
> +	if (ret)
> +		return ret;
>
> -	return buffer->access->store_to(buffer, dataout);
> +	/*
> +	 * We can't just test for watermark to decide if we wake the poll queue
> +	 * because read may request less samples than the watermark.
> +	 */
> +	wake_up_interruptible(&buffer->pollq);

What happened to poll parameters?

> +	return 0;
>   }
>

