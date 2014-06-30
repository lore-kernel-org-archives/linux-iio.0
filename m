Return-Path: <lars@metafoo.de>
Message-ID: <53B12E50.9080406@metafoo.de>
Date: Mon, 30 Jun 2014 11:30:56 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>,
 linux-iio@vger.kernel.org
CC: jic23@kernel.org, yannick.bedhomme@mobile-devices.fr
Subject: Re: [PATCH 2/2] iio: add watermark logic to iio read and poll
References: <1403886001-23354-1-git-send-email-josselin.costanzi@mobile-devices.fr> <1403886001-23354-3-git-send-email-josselin.costanzi@mobile-devices.fr>
In-Reply-To: <1403886001-23354-3-git-send-email-josselin.costanzi@mobile-devices.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 06/27/2014 06:20 PM, Josselin Costanzi wrote:
[...]
> +What:		/sys/bus/iio/devices/iio:deviceX/buffer/timeout
> +KernelVersion:	3.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		A single non-negative integer that represents an activity
> +		timeout in microseconds for which we wait during blocking read
> +		operation. The timer is reset each time a new sample is added
> +		to the buffer.
> +		By default its value is zero which indicates the read operation
> +		will not timeout.

I still don't buy the need for a the timeout property. There is already a 
way to do this in userspace with the existing API. We shouldn't have to add 
a different API which allows us to do the same thing.

> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 2952ee0..c8ee523 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -37,7 +37,7 @@ static bool iio_buffer_is_active(struct iio_buffer *buf)
>   	return !list_empty(&buf->buffer_list);
>   }
>
> -static bool iio_buffer_data_available(struct iio_buffer *buf)
> +static size_t iio_buffer_data_available(struct iio_buffer *buf)
>   {
>   	return buf->access->data_available(buf);
>   }
> @@ -53,6 +53,11 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>   {
>   	struct iio_dev *indio_dev = filp->private_data;
>   	struct iio_buffer *rb = indio_dev->buffer;
> +	size_t datum_size = rb->access->get_bytes_per_datum(rb);
> +	size_t to_read = min_t(size_t, n / datum_size, rb->low_watermark);
> +	size_t data_available;
> +	size_t count = 0;
> +	long timeout = -1;
>   	int ret;
>
>   	if (!indio_dev->info)
> @@ -62,25 +67,49 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>   		return -EINVAL;
>
>   	do {
> -		if (!iio_buffer_data_available(rb)) {
> -			if (filp->f_flags & O_NONBLOCK)
> -				return -EAGAIN;
> +		data_available = iio_buffer_data_available(rb);
>
> -			ret = wait_event_interruptible(rb->pollq,
> -					iio_buffer_data_available(rb) ||
> -					indio_dev->info == NULL);
> -			if (ret)
> -				return ret;
> -			if (indio_dev->info == NULL)
> -				return -ENODEV;
> +		if (filp->f_flags & O_NONBLOCK) {
> +			if (!data_available) {
> +				ret = -EAGAIN;
> +				break;
> +			}
> +		} else {
> +			if (data_available < to_read) {
> +				timeout = wait_event_interruptible_timeout(
> +					rb->pollq,
> +					iio_buffer_data_available(rb) >= to_read ||
> +					indio_dev->info == NULL,
> +					rb->timeout);
> +
> +				if (indio_dev->info == NULL) {
> +					ret = -ENODEV;
> +					break;
> +				}
> +
> +				if (timeout < 0) {
> +					ret = timeout;
> +					break;
> +				}
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
> +	 } while (to_read > 0 && timeout > 0);

Same comment as before. This function should return as soon as at least one 
byte has been read. In fact you shouldn't need to modify this function at all.

> +
> +	if (count)
> +		return count;
> +	if (ret < 0)
> +		return ret;
> +
> +	WARN_ON(timeout);
> +	return -EAGAIN;
>   }
>
>   /**
> @@ -96,9 +125,8 @@ unsigned int iio_buffer_poll(struct file *filp,
>   		return -ENODEV;
>
>   	poll_wait(filp, &rb->pollq, wait);
> -	if (iio_buffer_data_available(rb))
> +	if (iio_buffer_data_available(rb) >= rb->low_watermark)
>   		return POLLIN | POLLRDNORM;

You need to take into account whether the buffer is active or not here. If 
the buffer is not active the check should evaluate true if there is at least 
one sample in the buffer.

As I suggested in the last review, keep bool as the return type of 
iio_buffer_data_available() and move the check whether the number of samples 
is above the threshold as well as the check whether the buffer is active or 
not into iio_buffer_data_available().

[...]
>   /**
>    * iio_validate_scan_mask_onehot() - Validates that exactly one channel is selected
>    * @indio_dev: the iio device
> @@ -913,8 +1052,17 @@ static const void *iio_demux(struct iio_buffer *buffer,
>   static int iio_push_to_buffer(struct iio_buffer *buffer, const void *data)
>   {
>   	const void *dataout = iio_demux(buffer, data);
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

The whole point of this exercise is to only wake the waiter up when the 
amount of available samples is above the threshold. If the reader reads less 
samples than the threshold, that's fine. It just means that there will still 
be samples left in the FIFO after the read call.

Also I'd prefer to keep the wake_up call in the buffer implementation. That 
makes things more flexible.

>
[...]

- Lars
