Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-115.synserver.de ([212.40.185.115]:1103 "EHLO
	smtp-out-115.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755156Ab2JQIgA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Oct 2012 04:36:00 -0400
Message-ID: <507E6E38.3090505@metafoo.de>
Date: Wed, 17 Oct 2012 10:37:12 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, Michael.Hennerich@analog.com,
	srinivas.pandruvada@intel.com
Subject: Re: [PATCH 1/4] staging:iio: Add support for multiple buffers
References: <1350120278-26929-1-git-send-email-jic23@kernel.org> <1350120278-26929-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1350120278-26929-2-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/13/2012 11:24 AM, Jonathan Cameron wrote:
> Route all buffer writes through the demux.
> Addition or removal of a buffer results in tear down and
> setup of all the buffers for a given device.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> ---
> [...]
>  /* Callback handler to send event after all samples are received and captured */
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index d4ad374..8caa0d7 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -31,6 +31,18 @@ static const char * const iio_endian_prefix[] = {
>  	[IIO_LE] = "le",
>  };
>  
> +static bool iio_buffer_is_active(struct iio_dev *indio_dev,
> +				 struct iio_buffer *buf)
> +{
> +	struct list_head *p;
> +
> +	list_for_each(p, &indio_dev->buffer_list)
> +		if (p == &buf->buffer_list)
> +			return true;
> +
> +	return false;
> +}
> +
>  /**
>   * iio_buffer_read_first_n_outer() - chrdev read for buffer access
>   *
> @@ -134,7 +146,7 @@ static ssize_t iio_scan_el_store(struct device *dev,
>  	if (ret < 0)
>  		return ret;
>  	mutex_lock(&indio_dev->mlock);
> -	if (iio_buffer_enabled(indio_dev)) {
> +	if (iio_buffer_is_active(indio_dev, indio_dev->buffer)) {
>  		ret = -EBUSY;
>  		goto error_ret;
>  	}
> @@ -180,12 +192,11 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
>  		return ret;
>  
>  	mutex_lock(&indio_dev->mlock);
> -	if (iio_buffer_enabled(indio_dev)) {
> +	if (iio_buffer_is_active(indio_dev, indio_dev->buffer)) {
>  		ret = -EBUSY;
>  		goto error_ret;
>  	}
>  	indio_dev->buffer->scan_timestamp = state;
> -	indio_dev->scan_timestamp = state;
>  error_ret:
>  	mutex_unlock(&indio_dev->mlock);
>  
> @@ -385,7 +396,7 @@ ssize_t iio_buffer_write_length(struct device *dev,
>  			return len;
>  
>  	mutex_lock(&indio_dev->mlock);
> -	if (iio_buffer_enabled(indio_dev)) {
> +	if (iio_buffer_is_active(indio_dev, indio_dev->buffer)) {
>  		ret = -EBUSY;
>  	} else {
>  		if (buffer->access->set_length)
> @@ -398,102 +409,14 @@ ssize_t iio_buffer_write_length(struct device *dev,
>  }
>  EXPORT_SYMBOL(iio_buffer_write_length);
>  
> -ssize_t iio_buffer_store_enable(struct device *dev,
> -				struct device_attribute *attr,
> -				const char *buf,
> -				size_t len)
> -{
> -	int ret;
> -	bool requested_state, current_state;
> -	int previous_mode;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct iio_buffer *buffer = indio_dev->buffer;
> -
> -	mutex_lock(&indio_dev->mlock);
> -	previous_mode = indio_dev->currentmode;
> -	requested_state = !(buf[0] == '0');
> -	current_state = iio_buffer_enabled(indio_dev);
> -	if (current_state == requested_state) {
> -		printk(KERN_INFO "iio-buffer, current state requested again\n");
> -		goto done;
> -	}
> -	if (requested_state) {
> -		if (indio_dev->setup_ops->preenable) {
> -			ret = indio_dev->setup_ops->preenable(indio_dev);
> -			if (ret) {
> -				printk(KERN_ERR
> -				       "Buffer not started: "
> -				       "buffer preenable failed\n");
> -				goto error_ret;
> -			}
> -		}
> -		if (buffer->access->request_update) {
> -			ret = buffer->access->request_update(buffer);
> -			if (ret) {
> -				printk(KERN_INFO
> -				       "Buffer not started: "
> -				       "buffer parameter update failed\n");
> -				goto error_ret;
> -			}
> -		}
> -		/* Definitely possible for devices to support both of these. */
> -		if (indio_dev->modes & INDIO_BUFFER_TRIGGERED) {
> -			if (!indio_dev->trig) {
> -				printk(KERN_INFO
> -				       "Buffer not started: no trigger\n");
> -				ret = -EINVAL;
> -				goto error_ret;
> -			}
> -			indio_dev->currentmode = INDIO_BUFFER_TRIGGERED;
> -		} else if (indio_dev->modes & INDIO_BUFFER_HARDWARE)
> -			indio_dev->currentmode = INDIO_BUFFER_HARDWARE;
> -		else { /* should never be reached */
> -			ret = -EINVAL;
> -			goto error_ret;
> -		}
> -
> -		if (indio_dev->setup_ops->postenable) {
> -			ret = indio_dev->setup_ops->postenable(indio_dev);
> -			if (ret) {
> -				printk(KERN_INFO
> -				       "Buffer not started: "
> -				       "postenable failed\n");
> -				indio_dev->currentmode = previous_mode;
> -				if (indio_dev->setup_ops->postdisable)
> -					indio_dev->setup_ops->
> -						postdisable(indio_dev);
> -				goto error_ret;
> -			}
> -		}
> -	} else {
> -		if (indio_dev->setup_ops->predisable) {
> -			ret = indio_dev->setup_ops->predisable(indio_dev);
> -			if (ret)
> -				goto error_ret;
> -		}
> -		indio_dev->currentmode = INDIO_DIRECT_MODE;
> -		if (indio_dev->setup_ops->postdisable) {
> -			ret = indio_dev->setup_ops->postdisable(indio_dev);
> -			if (ret)
> -				goto error_ret;
> -		}
> -	}
> -done:
> -	mutex_unlock(&indio_dev->mlock);
> -	return len;
> -
> -error_ret:
> -	mutex_unlock(&indio_dev->mlock);
> -	return ret;
> -}
> -EXPORT_SYMBOL(iio_buffer_store_enable);
> -
>  ssize_t iio_buffer_show_enable(struct device *dev,
>  			       struct device_attribute *attr,
>  			       char *buf)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	return sprintf(buf, "%d\n", iio_buffer_enabled(indio_dev));
> +	return sprintf(buf, "%d\n",
> +		       iio_buffer_is_active(indio_dev,
> +					    indio_dev->buffer));
>  }
>  EXPORT_SYMBOL(iio_buffer_show_enable);
>  
> @@ -537,35 +460,217 @@ static int iio_compute_scan_bytes(struct iio_dev *indio_dev, const long *mask,
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
> +	int success = 0;
> +	struct iio_buffer *buffer;
> +	unsigned long *compound_mask;
> +	const unsigned long *old_mask;
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
> +	/* Keep a copy of current setup to allow roll back */
> +	old_mask = indio_dev->active_scan_mask;
> +	if (!indio_dev->available_scan_masks)
> +		indio_dev->active_scan_mask = NULL;
> +
> +	if (remove_buffer)
> +		list_del(&remove_buffer->buffer_list);
> +	if (insert_buffer)
> +		list_add(&insert_buffer->buffer_list, &indio_dev->buffer_list);
> +
> +	/* If no buffers in list, we are done */
> +	if (list_empty(&indio_dev->buffer_list)) {
> +		indio_dev->currentmode = INDIO_DIRECT_MODE;
> +		return 0;

You leak old mask here, if indio_dev->available_scan_masks == NULL

> +	}
>  
>  	/* What scan mask do we actually have ?*/
> -	if (indio_dev->available_scan_masks)
> +	compound_mask = kzalloc(BITS_TO_LONGS(indio_dev->masklength)
> +				*sizeof(long), GFP_KERNEL);

kcalloc

> +	if (compound_mask == NULL)
> +		return -ENOMEM;

Also leaks oldmask

> +
> +	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
> +		bitmap_or(compound_mask, compound_mask, buffer->scan_mask,
> +			  indio_dev->masklength);
> +		indio_dev->scan_timestamp |= buffer->scan_timestamp;

As far as I can see indio_dev->scan_timestamp is never set to 0, so once
enabled it stays enabled.

> +	}
> +	if (indio_dev->available_scan_masks) {
>  		indio_dev->active_scan_mask =
>  			iio_scan_mask_match(indio_dev->available_scan_masks,
>  					    indio_dev->masklength,
> -					    buffer->scan_mask);
> -	else
> -		indio_dev->active_scan_mask = buffer->scan_mask;
> -
> -	if (indio_dev->active_scan_mask == NULL)
> -		return -EINVAL;
> +					    compound_mask);
> +		if (indio_dev->active_scan_mask == NULL) {
> +			/*
> +			 * Roll back.
> +			 * Note can only occur when adding a buffer.
> +			 */
> +			list_del(&insert_buffer->buffer_list);

What if insert buffer is NULL? Is it possible that we end up in this path if
it is NULL?

> +			indio_dev->active_scan_mask = old_mask;
> +			success = -EINVAL;
> +		}
> +	} else {
> +		indio_dev->active_scan_mask = compound_mask;
> +	}
>  
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
> +			goto error_remove_inserted;
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
> +				goto error_run_postdisable;
> +			}
> +		}
> +	if (indio_dev->info->update_scan_mode) {
> +		ret = indio_dev->info
>  			->update_scan_mode(indio_dev,
>  					   indio_dev->active_scan_mask);
> +		if (ret < 0) {
> +			printk(KERN_INFO "update scan mode failed\n");
> +			goto error_run_postdisable;
> +		}
> +	}
> +	/* Definitely possible for devices to support both of these.*/
> +	if (indio_dev->modes & INDIO_BUFFER_TRIGGERED) {
> +		if (!indio_dev->trig) {
> +			printk(KERN_INFO "Buffer not started: no trigger\n");
> +			ret = -EINVAL;
> +			/* Can only occur on first buffer */
> +			goto error_run_postdisable;
> +		}
> +		indio_dev->currentmode = INDIO_BUFFER_TRIGGERED;
> +	} else if (indio_dev->modes & INDIO_BUFFER_HARDWARE) {
> +		indio_dev->currentmode = INDIO_BUFFER_HARDWARE;
> +	} else { /* should never be reached */
> +		ret = -EINVAL;
> +		goto error_run_postdisable;
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
> +			goto error_disable_all_buffers;
> +		}
> +	}
> +
> +	if (indio_dev->available_scan_masks)
> +		kfree(compound_mask);
> +	else
> +		kfree(old_mask);
> +
> +	return success;
> +
> +error_disable_all_buffers:
> +	indio_dev->currentmode = INDIO_DIRECT_MODE;
> +error_run_postdisable:
> +	if (indio_dev->setup_ops->postdisable)
> +		indio_dev->setup_ops->postdisable(indio_dev);
> +error_remove_inserted:
> +
> +	if (insert_buffer)
> +		list_del(&insert_buffer->buffer_list);
> +	indio_dev->active_scan_mask = old_mask;
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

dev_to_iio_dev

I don't think dev_get_drvdata works anymore

> +	struct iio_buffer *pbuf = indio_dev->buffer;
> +	bool inlist;
> +
> +	ret = strtobool(buf, &requested_state);
> +	if (ret < 0)
> +		return ret;
> +
> +	mutex_lock(&indio_dev->mlock);
> +
> +	/* Find out if it is in the list */
> +	inlist = iio_buffer_is_active(indio_dev, pbuf);
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
> +int iio_sw_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct iio_buffer *buffer;
> +	unsigned bytes;
> +	dev_dbg(&indio_dev->dev, "%s\n", __func__);
> +
> +	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list)
> +		if (buffer->access->set_bytes_per_datum) {
> +			bytes = iio_compute_scan_bytes(indio_dev,
> +						       buffer->scan_mask,
> +						       buffer->scan_timestamp);
> +
> +			buffer->access->set_bytes_per_datum(buffer, bytes);
> +		}
>  	return 0;
>  }
>  EXPORT_SYMBOL(iio_sw_buffer_preenable);
> [...]
>  
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index c0ae76a..0ff0e66 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -410,6 +410,7 @@ struct iio_buffer_setup_ops {
>   *			and owner
>   * @event_interface:	[INTERN] event chrdevs associated with interrupt lines
>   * @buffer:		[DRIVER] any buffer present
> + * @buffer_list:	[INTERN] list of all buffers currently attached
>   * @scan_bytes:		[INTERN] num bytes captured to be fed to buffer demux
>   * @mlock:		[INTERN] lock used to prevent simultaneous device state
>   *			changes
> @@ -448,6 +449,7 @@ struct iio_dev {
>  	struct iio_event_interface	*event_interface;
>  
>  	struct iio_buffer		*buffer;
> +	struct list_head		buffer_list;
>  	int				scan_bytes;
>  	struct mutex			mlock;
>  

