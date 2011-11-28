Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-216.synserver.de ([212.40.185.216]:1036 "HELO
	smtp-out-211.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1751070Ab1K1Ji6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Nov 2011 04:38:58 -0500
Message-ID: <4ED356EA.40001@metafoo.de>
Date: Mon, 28 Nov 2011 10:39:54 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 5/7] staging:iio: add demux optionally to path from device
 to buffer
References: <1322399412-21622-1-git-send-email-jic23@kernel.org> <1322399412-21622-6-git-send-email-jic23@kernel.org>
In-Reply-To: <1322399412-21622-6-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/27/2011 02:10 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <jic23@cam.ac.uk>
> 
> This gives you only what you ask for which is handy
> for some devices with weird scan combinations.
> 
> Routes all data flow through a core utility function.
> That and this demuxing support will be needed to do
> demuxing to multiple destinations in kernel.
> 
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/buffer.h              |   15 +++
>  drivers/staging/iio/industrialio-buffer.c |  148 ++++++++++++++++++++++++++++-
>  2 files changed, 159 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/buffer.h b/drivers/staging/iio/buffer.h
> index 4b8f619..5282441 100644
> --- a/drivers/staging/iio/buffer.h
> +++ b/drivers/staging/iio/buffer.h
> @@ -95,6 +95,8 @@ struct iio_buffer_setup_ops {
>   * @access:		[DRIVER] buffer access functions associated with the
>   *			implementation.
>   * @flags:		[INTERN] file ops related flags including busy flag.
> + * @demux_list:		[INTERN] list of operations required to demux the scan.
> + * @demux_bounce:	[INTERN] buffer for doing gather from incoming scan.
>   **/
>  struct iio_buffer {
>  	struct iio_dev				*indio_dev;
> @@ -115,6 +117,8 @@ struct iio_buffer {
>  	bool					stufftoread;
>  	unsigned long				flags;
>  	const struct attribute_group *attrs;
> +	struct list_head			demux_list;
> +	unsigned char				*demux_bounce;
>  };
>  
>  /**
> @@ -153,6 +157,17 @@ int iio_scan_mask_set(struct iio_buffer *buffer, int bit);
>  	container_of(d, struct iio_buffer, dev)
>  
>  /**
> + * iio_push_to_buffer() - push to a registered buffer.
> + * @buffer:		IIO buffer structure for device
> + * @scan:		Full scan.
> + * @timestamp:
> + */
> +int iio_push_to_buffer(struct iio_buffer *buffer, unsigned char *data,
> +		       s64 timestamp);
> +
> +int iio_update_demux(struct iio_dev *indio_dev);
> +
> +/**
>   * iio_buffer_register() - register the buffer with IIO core
>   * @indio_dev: device with the buffer to be registered
>   **/
> diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
> index fb14e37..352f9f1 100644
> --- a/drivers/staging/iio/industrialio-buffer.c
> +++ b/drivers/staging/iio/industrialio-buffer.c
> @@ -87,6 +87,7 @@ void iio_chrdev_buffer_release(struct iio_dev *indio_dev)
>  
>  void iio_buffer_init(struct iio_buffer *buffer, struct iio_dev *indio_dev)
>  {
> +	INIT_LIST_HEAD(&buffer->demux_list);
>  	buffer->indio_dev = indio_dev;
>  	init_waitqueue_head(&buffer->pollq);
>  }
> @@ -128,10 +129,9 @@ static ssize_t iio_scan_el_show(struct device *dev,
>  	int ret;
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  
> -	ret = iio_scan_mask_query(indio_dev->buffer,
> -				  to_iio_dev_attr(attr)->address);
> -	if (ret < 0)
> -		return ret;
> +	ret = test_bit(to_iio_dev_attr(attr)->address,
> +		       indio_dev->buffer->scan_mask);
> +
>  	return sprintf(buf, "%d\n", ret);
>  }
>  
> @@ -583,6 +583,12 @@ int iio_sw_buffer_preenable(struct iio_dev *indio_dev)
>  					    buffer->scan_mask);
>  	else
>  		indio_dev->active_scan_mask = buffer->scan_mask;
> +	iio_update_demux(indio_dev);
> +
> +	if (indio_dev->info->update_scan_mode)
> +		return indio_dev->info
> +			->update_scan_mode(indio_dev,
> +					   indio_dev->active_scan_mask);
>  	return 0;
>  }
>  EXPORT_SYMBOL(iio_sw_buffer_preenable);
> @@ -652,3 +658,137 @@ int iio_scan_mask_query(struct iio_buffer *buffer, int bit)
>  	return test_bit(bit, mask);
>  };
>  EXPORT_SYMBOL_GPL(iio_scan_mask_query);
> +
> +/**
> + * struct iio_demux_table() - table describing demux memcpy ops
> + * @from:	index to copy from
> + * @to:	index to copy to
> + * @length:	how many bytes to copy
> + * @l:		list head used for management
> + */
> +struct iio_demux_table {
> +	unsigned from;
> +	unsigned to;
> +	unsigned length;
> +	struct list_head l;
> +};
> +
> +static unsigned char *iio_demux(struct iio_buffer *buffer,
> +				 unsigned char *datain)
> +{
> +	struct iio_demux_table *t;
> +
> +	if (list_empty(&buffer->demux_list))
> +		return datain;
> +	list_for_each_entry(t, &buffer->demux_list, l)
> +		memcpy(buffer->demux_bounce + t->to,
> +		       datain + t->from, t->length);
> +
> +	return buffer->demux_bounce;
> +}
> +
> +int iio_push_to_buffer(struct iio_buffer *buffer, unsigned char *data,
> +		       s64 timestamp)
> +{
> +	unsigned char *dataout = iio_demux(buffer, data);
> +
> +	return buffer->access->store_to(buffer, dataout, timestamp);
> +}
> +EXPORT_SYMBOL_GPL(iio_push_to_buffer);

I wonder if we want to integrate the demuxing into the store_to callbacks of
the buffer, this would avoid the need for the bounce buffer and reduce the
number of memcpys. But maybe we can just add it later.


> +
> +int iio_update_demux(struct iio_dev *indio_dev)
> +{
> +	const struct iio_chan_spec *ch;
> +	struct iio_buffer *buffer = indio_dev->buffer;
> +	int ret, in_ind = -1, out_ind, length;
> +	unsigned in_loc = 0, out_loc = 0;
> +	struct iio_demux_table *p, *q;
> +
> +	/* Clear out any old demux */
> +	list_for_each_entry_safe(p, q, &buffer->demux_list, l) {
> +		list_del(&p->l);
> +		kfree(p);
> +	}
> +	kfree(buffer->demux_bounce);
> +	buffer->demux_bounce = NULL;
> +
> +	/* First work out which scan mode we will actually have */
> +	if (bitmap_equal(indio_dev->active_scan_mask,
> +			 buffer->scan_mask,
> +			 indio_dev->masklength))
> +		return 0;
> +
> +	out_ind = find_first_bit(buffer->scan_mask, indio_dev->masklength);
> +	/* Now we have the two masks, work from least sig and build up sizes */
> +	while (out_ind != indio_dev->masklength) {

	This looks a bit like an open-coded for_each_set_bit

> +		in_ind = find_next_bit(indio_dev->active_scan_mask,
> +				       indio_dev->masklength,
> +				       in_ind + 1);
> +		while (in_ind != out_ind) {
> +			in_ind = find_next_bit(indio_dev->active_scan_mask,
> +					       indio_dev->masklength,
> +					       in_ind + 1);

same here for_each_set_bit(in_ind, indio->active_scan_mask, out_ind)

> +			ch = iio_find_channel_from_si(indio_dev, in_ind);
> +			length = ch->scan_type.storagebits/8;
> +			/* Make sure we are aligned */
> +			in_loc += length;
> +			if (in_loc % length)
> +				in_loc += length - in_loc % length;
> +		}
> +		p = kmalloc(sizeof(*p), GFP_KERNEL);
> +		if (p == NULL) {
> +			ret = -ENOMEM;
> +			goto error_clear_mux_table;
> +		}
> +		ch = iio_find_channel_from_si(indio_dev, in_ind);
> +		length = ch->scan_type.storagebits/8;
> +		if (out_loc % length)
> +			out_loc += length - out_loc % length;
> +		if (in_loc % length)
> +			in_loc += length - in_loc % length;
> +		p->from = in_loc;
> +		p->to = out_loc;
> +		p->length = length;
> +		list_add_tail(&p->l, &buffer->demux_list);
> +		out_loc += length;
> +		in_loc += length;
> +		out_ind = find_next_bit(buffer->scan_mask,
> +					indio_dev->masklength,
> +					out_ind + 1);
> +	}
> +	/* Relies on scan_timestamp being last */
> +	if (buffer->scan_timestamp) {
> +		p = kmalloc(sizeof(*p), GFP_KERNEL);
> +		if (p == NULL) {
> +			ret = -ENOMEM;
> +			goto error_clear_mux_table;
> +		}
> +		ch = iio_find_channel_from_si(indio_dev,
> +			buffer->scan_index_timestamp);
> +		length = ch->scan_type.storagebits/8;
> +		if (out_loc % length)
> +			out_loc += length - out_loc % length;
> +		if (in_loc % length)
> +			in_loc += length - in_loc % length;
> +		p->from = in_loc;
> +		p->to = out_loc;
> +		p->length = length;
> +		list_add_tail(&p->l, &buffer->demux_list);
> +		out_loc += length;
> +		in_loc += length;
> +	}
> +	buffer->demux_bounce = kzalloc(out_loc, GFP_KERNEL);
> +	if (buffer->demux_bounce == NULL) {
> +		ret = -ENOMEM;
> +		goto error_clear_mux_table;
> +	}
> +	return 0;
> +
> +error_clear_mux_table:
> +	list_for_each_entry_safe(p, q, &buffer->demux_list, l) {
> +		list_del(&p->l);
> +		kfree(p);
> +	}
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iio_update_demux);

