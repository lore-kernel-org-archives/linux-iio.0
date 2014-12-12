Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47110 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965528AbaLLLGS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Dec 2014 06:06:18 -0500
Message-ID: <548ACC25.7050908@kernel.org>
Date: Fri, 12 Dec 2014 11:06:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 09/11] iio: buffer: Allocate standard attributes in the
 core
References: <1417024517-7564-1-git-send-email-lars@metafoo.de> <1417024517-7564-10-git-send-email-lars@metafoo.de> <5488CC69.2020102@gmx.de>
In-Reply-To: <5488CC69.2020102@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/12/14 22:42, Hartmut Knaack wrote:
> Lars-Peter Clausen schrieb am 26.11.2014 um 18:55:
>> All buffers want at least the length and the enable attribute. Move the
>> creation of those attributes to the core instead of having to do this in
>> each individual buffer implementation. This allows us to get rid of some
>> boiler-plate code.
>>
> There are some indentation issues in here, as well. I'll point them out.
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Adjusted the alignment as suggested and applied to the togreg branch of iio.git.
As ever pushed out sometime later today as testing.  If you could check I
haven't fouled anything up that would be great.

Thanks.


Jonathan
>> ---
>>  drivers/iio/industrialio-buffer.c        | 55 +++++++++++++++++++++-----------
>>  drivers/iio/kfifo_buf.c                  | 15 ---------
>>  drivers/staging/iio/accel/sca3000_ring.c | 14 ++------
>>  include/linux/iio/buffer.h               | 37 ++-------------------
>>  4 files changed, 40 insertions(+), 81 deletions(-)
>>
>> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
>> index cdc2482..a4d3ff6 100644
>> --- a/drivers/iio/industrialio-buffer.c
>> +++ b/drivers/iio/industrialio-buffer.c
>> @@ -383,10 +383,8 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
>>  	return ret;
>>  }
>>  
>> -
>> -ssize_t iio_buffer_read_length(struct device *dev,
>> -			       struct device_attribute *attr,
>> -			       char *buf)
>> +static ssize_t iio_buffer_read_length(struct device *dev,
>> +	struct device_attribute *attr, char *buf)
> Here.
>>  {
>>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>  	struct iio_buffer *buffer = indio_dev->buffer;
>> @@ -397,12 +395,9 @@ ssize_t iio_buffer_read_length(struct device *dev,
>>  
>>  	return 0;
>>  }
>> -EXPORT_SYMBOL(iio_buffer_read_length);
>>  
>> -ssize_t iio_buffer_write_length(struct device *dev,
>> -				struct device_attribute *attr,
>> -				const char *buf,
>> -				size_t len)
>> +static ssize_t iio_buffer_write_length(struct device *dev,
>> +	struct device_attribute *attr, const char *buf, size_t len)
> Here.
>>  {
>>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>  	struct iio_buffer *buffer = indio_dev->buffer;
>> @@ -429,16 +424,13 @@ ssize_t iio_buffer_write_length(struct device *dev,
>>  
>>  	return ret ? ret : len;
>>  }
>> -EXPORT_SYMBOL(iio_buffer_write_length);
>>  
>> -ssize_t iio_buffer_show_enable(struct device *dev,
>> -			       struct device_attribute *attr,
>> -			       char *buf)
>> +static ssize_t iio_buffer_show_enable(struct device *dev,
>> +	struct device_attribute *attr, char *buf)
> Here.
>>  {
>>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>  	return sprintf(buf, "%d\n", iio_buffer_is_active(indio_dev->buffer));
>>  }
>> -EXPORT_SYMBOL(iio_buffer_show_enable);
>>  
>>  static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
>>  				const unsigned long *mask, bool timestamp)
>> @@ -725,10 +717,8 @@ out_unlock:
>>  }
>>  EXPORT_SYMBOL_GPL(iio_update_buffers);
>>  
>> -ssize_t iio_buffer_store_enable(struct device *dev,
>> -				struct device_attribute *attr,
>> -				const char *buf,
>> -				size_t len)
>> +static ssize_t iio_buffer_store_enable(struct device *dev,
>> +	struct device_attribute *attr, const char *buf, size_t len)
> Here.
>>  {
>>  	int ret;
>>  	bool requested_state;
>> @@ -760,10 +750,14 @@ done:
>>  	mutex_unlock(&indio_dev->mlock);
>>  	return (ret < 0) ? ret : len;
>>  }
>> -EXPORT_SYMBOL(iio_buffer_store_enable);
>>  
>>  static const char * const iio_scan_elements_group_name = "scan_elements";
>>  
>> +static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
>> +	iio_buffer_write_length);
>> +static DEVICE_ATTR(enable, S_IRUGO | S_IWUSR,
>> +	iio_buffer_show_enable, iio_buffer_store_enable);
>> +
> And these two here.
>>  int iio_buffer_alloc_sysfs(struct iio_dev *indio_dev)
>>  {
>>  	struct iio_dev_attr *p;
>> @@ -775,6 +769,27 @@ int iio_buffer_alloc_sysfs(struct iio_dev *indio_dev)
>>  	if (!buffer)
>>  		return 0;
>>  
>> +	attrcount = 0;
>> +	if (buffer->attrs) {
>> +		while (buffer->attrs[attrcount] != NULL)
>> +			attrcount++;
>> +	}
>> +
>> +	buffer->buffer_group.name = "buffer";
>> +	buffer->buffer_group.attrs = kcalloc(attrcount + 3,
>> +			sizeof(*buffer->buffer_group.attrs), GFP_KERNEL);
>> +	if (!buffer->buffer_group.attrs)
>> +		return -ENOMEM;
>> +
>> +	buffer->buffer_group.attrs[0] = &dev_attr_length.attr;
>> +	buffer->buffer_group.attrs[1] = &dev_attr_enable.attr;
>> +	if (buffer->attrs)
>> +		memcpy(&buffer->buffer_group.attrs[2], buffer->attrs,
>> +			sizeof(*&buffer->buffer_group.attrs) * (attrcount - 2));
>> +	buffer->buffer_group.attrs[attrcount+2] = NULL;
>> +
>> +	indio_dev->groups[indio_dev->groupcounter++] = &buffer->buffer_group;
>> +
>>  	if (buffer->scan_el_attrs != NULL) {
>>  		attr = buffer->scan_el_attrs->attrs;
>>  		while (*attr++ != NULL)
>> @@ -839,6 +854,7 @@ error_free_scan_mask:
>>  	kfree(buffer->scan_mask);
>>  error_cleanup_dynamic:
>>  	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
>> +	kfree(indio_dev->buffer->buffer_group.attrs);
>>  
>>  	return ret;
>>  }
>> @@ -849,6 +865,7 @@ void iio_buffer_free_sysfs(struct iio_dev *indio_dev)
>>  		return;
>>  
>>  	kfree(indio_dev->buffer->scan_mask);
>> +	kfree(indio_dev->buffer->buffer_group.attrs);
>>  	kfree(indio_dev->buffer->scan_el_group.attrs);
>>  	iio_free_chan_devattr_list(&indio_dev->buffer->scan_el_dev_attr_list);
>>  }
>> diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
>> index 1258b4e..3b0a3bc 100644
>> --- a/drivers/iio/kfifo_buf.c
>> +++ b/drivers/iio/kfifo_buf.c
>> @@ -52,20 +52,6 @@ static int iio_get_length_kfifo(struct iio_buffer *r)
>>  	return r->length;
>>  }
>>  
>> -static IIO_BUFFER_ENABLE_ATTR;
>> -static IIO_BUFFER_LENGTH_ATTR;
>> -
>> -static struct attribute *iio_kfifo_attributes[] = {
>> -	&dev_attr_length.attr,
>> -	&dev_attr_enable.attr,
>> -	NULL,
>> -};
>> -
>> -static struct attribute_group iio_kfifo_attribute_group = {
>> -	.attrs = iio_kfifo_attributes,
>> -	.name = "buffer",
>> -};
>> -
>>  static int iio_mark_update_needed_kfifo(struct iio_buffer *r)
>>  {
>>  	struct iio_kfifo *kf = iio_to_kfifo(r);
>> @@ -169,7 +155,6 @@ struct iio_buffer *iio_kfifo_allocate(struct iio_dev *indio_dev)
>>  		return NULL;
>>  	kf->update_needed = true;
>>  	iio_buffer_init(&kf->buffer);
>> -	kf->buffer.attrs = &iio_kfifo_attribute_group;
>>  	kf->buffer.access = &kfifo_access_funcs;
>>  	kf->buffer.length = 2;
>>  	mutex_init(&kf->user_lock);
>> diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
>> index aa0e5d8..f2f260e 100644
>> --- a/drivers/staging/iio/accel/sca3000_ring.c
>> +++ b/drivers/staging/iio/accel/sca3000_ring.c
>> @@ -140,9 +140,6 @@ static bool sca3000_ring_buf_data_available(struct iio_buffer *r)
>>  	return r->stufftoread;
>>  }
>>  
>> -static IIO_BUFFER_ENABLE_ATTR;
>> -static IIO_BUFFER_LENGTH_ATTR;
>> -
>>  /**
>>   * sca3000_query_ring_int() is the hardware ring status interrupt enabled
>>   **/
>> @@ -232,20 +229,13 @@ static IIO_DEVICE_ATTR(in_accel_scale,
>>   * only apply to the ring buffer.  At all times full rate and accuracy
>>   * is available via direct reading from registers.
>>   */
>> -static struct attribute *sca3000_ring_attributes[] = {
>> -	&dev_attr_length.attr,
>> -	&dev_attr_enable.attr,
>> +static const struct attribute *sca3000_ring_attributes[] = {
>>  	&iio_dev_attr_50_percent.dev_attr.attr,
>>  	&iio_dev_attr_75_percent.dev_attr.attr,
>>  	&iio_dev_attr_in_accel_scale.dev_attr.attr,
>>  	NULL,
>>  };
>>  
>> -static struct attribute_group sca3000_ring_attr = {
>> -	.attrs = sca3000_ring_attributes,
>> -	.name = "buffer",
>> -};
>> -
>>  static struct iio_buffer *sca3000_rb_allocate(struct iio_dev *indio_dev)
>>  {
>>  	struct iio_buffer *buf;
>> @@ -258,7 +248,7 @@ static struct iio_buffer *sca3000_rb_allocate(struct iio_dev *indio_dev)
>>  	ring->private = indio_dev;
>>  	buf = &ring->buf;
>>  	buf->stufftoread = 0;
>> -	buf->attrs = &sca3000_ring_attr;
>> +	buf->attrs = sca3000_ring_attributes;
>>  	iio_buffer_init(buf);
>>  
>>  	return buf;
>> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
>> index 79cdb3d..16b7663 100644
>> --- a/include/linux/iio/buffer.h
>> +++ b/include/linux/iio/buffer.h
>> @@ -83,10 +83,11 @@ struct iio_buffer {
>>  	bool					scan_timestamp;
>>  	const struct iio_buffer_access_funcs	*access;
>>  	struct list_head			scan_el_dev_attr_list;
>> +	struct attribute_group			buffer_group;
>>  	struct attribute_group			scan_el_group;
>>  	wait_queue_head_t			pollq;
>>  	bool					stufftoread;
>> -	const struct attribute_group *attrs;
>> +	const struct attribute			**attrs;
>>  	struct list_head			demux_list;
>>  	void					*demux_bounce;
>>  	struct list_head			buffer_list;
>> @@ -148,40 +149,6 @@ static inline int iio_push_to_buffers_with_timestamp(struct iio_dev *indio_dev,
>>  
>>  int iio_update_demux(struct iio_dev *indio_dev);
>>  
>> -/**
>> - * iio_buffer_read_length() - attr func to get number of datums in the buffer
>> - **/
>> -ssize_t iio_buffer_read_length(struct device *dev,
>> -			       struct device_attribute *attr,
>> -			       char *buf);
>> -/**
>> - * iio_buffer_write_length() - attr func to set number of datums in the buffer
>> - **/
>> -ssize_t iio_buffer_write_length(struct device *dev,
>> -			      struct device_attribute *attr,
>> -			      const char *buf,
>> -			      size_t len);
>> -/**
>> - * iio_buffer_store_enable() - attr to turn the buffer on
>> - **/
>> -ssize_t iio_buffer_store_enable(struct device *dev,
>> -				struct device_attribute *attr,
>> -				const char *buf,
>> -				size_t len);
>> -/**
>> - * iio_buffer_show_enable() - attr to see if the buffer is on
>> - **/
>> -ssize_t iio_buffer_show_enable(struct device *dev,
>> -			       struct device_attribute *attr,
>> -			       char *buf);
>> -#define IIO_BUFFER_LENGTH_ATTR DEVICE_ATTR(length, S_IRUGO | S_IWUSR,	\
>> -					   iio_buffer_read_length,	\
>> -					   iio_buffer_write_length)
>> -
>> -#define IIO_BUFFER_ENABLE_ATTR DEVICE_ATTR(enable, S_IRUGO | S_IWUSR,	\
>> -					   iio_buffer_show_enable,	\
>> -					   iio_buffer_store_enable)
>> -
>>  bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
>>  	const unsigned long *mask);
>>  
>>
> 

