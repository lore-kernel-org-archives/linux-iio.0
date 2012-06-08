Return-Path: <lars@metafoo.de>
Message-ID: <4FD216B2.7080504@metafoo.de>
Date: Fri, 08 Jun 2012 17:13:54 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/4] staging:iio: Add support for multiple buffers
References: <1338406594-14550-1-git-send-email-jic23@kernel.org> <1338406594-14550-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1338406594-14550-2-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 05/30/2012 09:36 PM, Jonathan Cameron wrote:
> Route all buffer writes through the demux.
> Addition or removal of a buffer results in tear down and
> setup of all the buffers for a given device.
> 

My test platform is currently broken in staging-next, so just some comments
based on code review for now.

> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/iio/industrialio-buffer.c               |  335 +++++++++++++++--------
>  drivers/iio/industrialio-core.c                 |    1 +
>  drivers/staging/iio/accel/adis16201_ring.c      |    4 +-
>  drivers/staging/iio/accel/adis16203_ring.c      |    6 +-
>  drivers/staging/iio/accel/adis16204_ring.c      |    3 +-
>  drivers/staging/iio/accel/adis16209_ring.c      |    3 +-
>  drivers/staging/iio/accel/adis16240_ring.c      |    4 +-
>  drivers/staging/iio/accel/lis3l02dq_ring.c      |    3 +-
>  drivers/staging/iio/adc/ad7192.c                |    3 +-
>  drivers/staging/iio/adc/ad7298_ring.c           |    5 +-
>  drivers/staging/iio/adc/ad7476_ring.c           |    2 +-
>  drivers/staging/iio/adc/ad7606_ring.c           |    3 +-
>  drivers/staging/iio/adc/ad7793.c                |    3 +-
>  drivers/staging/iio/adc/ad7887_ring.c           |    2 +-
>  drivers/staging/iio/adc/ad799x_ring.c           |    3 +-
>  drivers/staging/iio/adc/max1363_ring.c          |    2 +-
>  drivers/staging/iio/gyro/adis16260_ring.c       |    3 +-
>  drivers/staging/iio/iio_simple_dummy_buffer.c   |    5 +-
>  drivers/staging/iio/impedance-analyzer/ad5933.c |    3 +-
>  drivers/staging/iio/imu/adis16400_ring.c        |    2 +-
>  drivers/staging/iio/meter/ade7758_ring.c        |    3 +-
>  include/linux/iio/buffer.h                      |   24 +-
>  include/linux/iio/iio.h                         |    2 +

The at91_adc driver is not handled by this patch

>  23 files changed, 267 insertions(+), 157 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index ac185b8..b04b543 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -31,6 +31,16 @@ static const char * const iio_endian_prefix[] = {
>  	[IIO_LE] = "le",
>  };
>  
> +static bool iio_buffer_is_primary_active(struct iio_dev *indio_dev)
> +{
> +	struct list_head *p;
> +
> +	list_for_each(p, &indio_dev->buffer_list)
> +		if (p == &indio_dev->buffer->buffer_list)
> +			return true;

More or less the same code is used below. I think it makes sense to have a
generic iio_buffer_is_active(indio_dev, buffer)

> +	return false;
> +}

> [...]
> @@ -534,31 +453,186 @@ static int iio_compute_scan_bytes(struct iio_dev *indio_dev, const long *mask,
>  	return bytes;
>  }
>  
> -int iio_sw_buffer_preenable(struct iio_dev *indio_dev)
> +int iio_update_buffers(struct iio_dev *indio_dev,
> +		       struct iio_buffer *insert_buffer,
> +		       struct iio_buffer *remove_buffer)
>  {
> -	struct iio_buffer *buffer = indio_dev->buffer;
> -	dev_dbg(&indio_dev->dev, "%s\n", __func__);
> +	int ret;

drivers/iio/industrialio-buffer.c: In function ‘iio_update_buffers’:
drivers/iio/industrialio-buffer.c:460: warning: ‘ret’ may be used
uninitialized in this function

I think there a missing 'return 0', before the error handling. Right now the
code always sets active_scan_mask to NULL.


> +	struct iio_buffer *buffer;
> +	unsigned long *compound_mask;
>  
> -	/* How much space will the demuxed element take? */
> -	indio_dev->scan_bytes =
> -		iio_compute_scan_bytes(indio_dev, buffer->scan_mask,
> -				       buffer->scan_timestamp);
> -	buffer->access->set_bytes_per_datum(buffer, indio_dev->scan_bytes);
> +	/* Wind down existing buffers - iff there are any */
> +	if (!list_empty(&indio_dev->buffer_list)) {
> +		if (indio_dev->setup_ops->predisable) {
> +			ret = indio_dev->setup_ops->predisable(indio_dev);
> +			if (ret)
> +				goto error_ret;
> +		}
> +		indio_dev->currentmode = INDIO_DIRECT_MODE;
> +		if (indio_dev->setup_ops->postdisable) {
> +			ret = indio_dev->setup_ops->postdisable(indio_dev);
> +			if (ret)
> +				goto error_ret;
> +		}
> +	}
> +	if (!indio_dev->available_scan_masks)
> +		kfree(indio_dev->active_scan_mask);

If the code errors out before reassigning active_scan_mask we'll leave a
dangling pointer to the old scan mask, which will cause access after free or
a double free.

> +
> +	if (insert_buffer)
> +		list_add(&insert_buffer->buffer_list, &indio_dev->buffer_list);
> +	if (remove_buffer)
> +		list_del(&remove_buffer->buffer_list);

I'd do the remove before the insert, makes this more robust, if the function
is ever going to be called with both set to the same buffer.

> +
> +	/* If no buffers in list, we are done */
> +	if (list_empty(&indio_dev->buffer_list))
> +		return 0;
>  
>  	/* What scan mask do we actually have ?*/
> +	compound_mask = kzalloc(BITS_TO_LONGS(indio_dev->masklength)
> +				*sizeof(long), GFP_KERNEL);
> +	if (compound_mask == NULL)
> +		return -ENOMEM;
> +	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
> +		bitmap_or(compound_mask, compound_mask, buffer->scan_mask,
> +			  indio_dev->masklength);
> +		indio_dev->scan_timestamp |= buffer->scan_timestamp;
> +	}
>  	if (indio_dev->available_scan_masks)
>  		indio_dev->active_scan_mask =
>  			iio_scan_mask_match(indio_dev->available_scan_masks,
>  					    indio_dev->masklength,
> -					    buffer->scan_mask);
> +					    compound_mask);

active_scan_mask may be NULL if the device isn't able to handle the compound
mask.

Btw. if it is not possible to add the new buffer to the list, e.g. because
the compound scan mask is not supported, do we to do a rollback to the
previous working configuration? I think this might be a better option,
rather than leaving things broken.

>  	else
> -		indio_dev->active_scan_mask = buffer->scan_mask;
> +		indio_dev->active_scan_mask = compound_mask;
> +
>  	iio_update_demux(indio_dev);
>  
> -	if (indio_dev->info->update_scan_mode)
> -		return indio_dev->info
> +	/* Wind up again */
> +	if (indio_dev->setup_ops->preenable) {
> +		ret = indio_dev->setup_ops->preenable(indio_dev);
> +		if (ret) {
> +			printk(KERN_ERR
> +			       "Buffer not started:"
> +			       "buffer preenable failed\n");
> +			goto error_free_compound_mask;
> +		}
> +	}
> +	indio_dev->scan_bytes =
> +		iio_compute_scan_bytes(indio_dev,
> +				       indio_dev->active_scan_mask,
> +				       indio_dev->scan_timestamp);
> +	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list)
> +		if (buffer->access->request_update) {
> +			ret = buffer->access->request_update(buffer);
> +			if (ret) {
> +				printk(KERN_INFO
> +				       "Buffer not started:"
> +				       "buffer parameter update failed\n");
> +				goto error_ret;
> +			}
> +		}
> +	if (indio_dev->info->update_scan_mode) {
> +		ret = indio_dev->info
>  			->update_scan_mode(indio_dev,
>  					   indio_dev->active_scan_mask);
> +		if (ret < 0)
> +			goto error_free_compound_mask;
> +	}
> +	/* Definitely possible for devices to support both of these.*/
> +	if (indio_dev->modes & INDIO_BUFFER_TRIGGERED) {
> +		if (!indio_dev->trig) {
> +			printk(KERN_INFO "Buffer not started: no trigger\n");
> +			ret = -EINVAL;
> +			goto error_free_compound_mask;
> +		}
> +		indio_dev->currentmode = INDIO_BUFFER_TRIGGERED;
> +	} else if (indio_dev->modes & INDIO_BUFFER_HARDWARE) {
> +		indio_dev->currentmode = INDIO_BUFFER_HARDWARE;
> +	} else { /* should never be reached */
> +		ret = -EINVAL;
> +		goto error_free_compound_mask;
> +	}
> +
> +	if (indio_dev->setup_ops->postenable) {
> +		ret = indio_dev->setup_ops->postenable(indio_dev);
> +		if (ret) {
> +			printk(KERN_INFO
> +			       "Buffer not started: postenable failed\n");
> +			indio_dev->currentmode = INDIO_DIRECT_MODE;
> +			if (indio_dev->setup_ops->postdisable)
> +				indio_dev->setup_ops->postdisable(indio_dev);
> +			goto error_free_compound_mask;
> +		}
> +	}
> +error_free_compound_mask:
> +	indio_dev->active_scan_mask = NULL;
> +	kfree(compound_mask);
> +error_ret:
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iio_update_buffers);
> +
> +ssize_t iio_buffer_store_enable(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf,
> +				size_t len)
> +{
> +	int ret;
> +	bool requested_state;
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct iio_buffer *pbuf = indio_dev->buffer;
> +	struct list_head *p;
> +	bool inlist = false;
> +
> +	ret = strtobool(buf, &requested_state);
> +	if (ret < 0)
> +		return ret;
> +
> +	mutex_lock(&indio_dev->mlock);
> +
> +	/* Find out if it is in the list */
> +	list_for_each(p, &indio_dev->buffer_list)
> +		if (p == &pbuf->buffer_list) {
> +			inlist = true;
> +			break;
> +		}
> +	/* Already enabled */
> +	if (inlist && requested_state)
> +		goto done;
> +	/* Already disabled */
> +	if (!inlist && !requested_state)
> +		goto done;

        if (inlist == requested_state)
		goto done;

> +
> +	if (requested_state)
> +		ret = iio_update_buffers(indio_dev,
> +					 indio_dev->buffer, NULL);
> +	else
> +		ret = iio_update_buffers(indio_dev,
> +					 NULL, indio_dev->buffer);
> +
> +	if (ret < 0)
> +		goto done;
> +done:
> +	mutex_unlock(&indio_dev->mlock);
> +	return (ret < 0) ? ret : len;
> +}
> +EXPORT_SYMBOL(iio_buffer_store_enable);
> +
[...]
> @@ -567,7 +641,11 @@ EXPORT_SYMBOL(iio_sw_buffer_preenable);
>   * iio_scan_mask_set() - set particular bit in the scan mask
>   * @buffer: the buffer whose scan mask we are interested in
>   * @bit: the bit to be set.
> - **/
> + *
> + * Note that at this point we have no way of knowing what other
> + * buffers might request, hence this code only verifies that the
> + * individual buffers request is plausible.
> + */
>  int iio_scan_mask_set(struct iio_dev *indio_dev,
>  		      struct iio_buffer *buffer, int bit)
>  {
> @@ -597,7 +675,7 @@ int iio_scan_mask_set(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  		}
>  	}
> -	bitmap_copy(buffer->scan_mask, trialmask, indio_dev->masklength);
> +	set_bit(bit, buffer->scan_mask);

Is this a unrelated fix?

>  
>  	kfree(trialmask);
>  
[...]
> diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
> index fdfc873..5931cbb 100644
> --- a/drivers/staging/iio/iio_simple_dummy_buffer.c
> +++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
> @@ -46,7 +46,6 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
> -	struct iio_buffer *buffer = indio_dev->buffer;
>  	int len = 0;
>  	u16 *data;
>  
> @@ -76,7 +75,7 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
>  		     i < bitmap_weight(indio_dev->active_scan_mask,
>  				       indio_dev->masklength);
>  		     i++) {
> -			j = find_next_bit(buffer->scan_mask,
> +			j = find_next_bit(indio_dev->buffer->scan_mask,

should this be indio_dev->active_scan_mask?

>  					  indio_dev->masklength, j + 1);
>  			/* random access read form the 'device' */
>  			data[i] = fakedata[j];
