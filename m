Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:36950 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754976AbaFPKKz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 16 Jun 2014 06:10:55 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-iio@m.gmane.org>)
	id 1WwTsL-0004AJ-AV
	for linux-iio@vger.kernel.org; Mon, 16 Jun 2014 12:10:53 +0200
Received: from 146.187.3.109.rev.sfr.net ([109.3.187.146])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Mon, 16 Jun 2014 12:10:53 +0200
Received: from josselin.costanzi by 146.187.3.109.rev.sfr.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Mon, 16 Jun 2014 12:10:53 +0200
To: linux-iio@vger.kernel.org
From: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
Subject: Re: [PATCH v2] iio: make blocking read wait for data
Date: Mon, 16 Jun 2014 12:10:35 +0200
Message-ID: <lnmfqs$n26$1@ger.gmane.org>
References: <1402417591-32536-1-git-send-email-josselin.costanzi@mobile-devices.fr> <539C8194.6010002@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron wrote:

> On 10/06/14 17:26, Josselin Costanzi wrote:
>> Currently the IIO buffer blocking read only wait until at least one
>> data element is available.
>> This patch adds the possibility for the userspace to to blocking calls
>> for multiple elements. This should limit the read() calls count when
>> trying to get data in batches.
>> This commit also fix a bug where data is lost if an error happens
>> after some data is already read.
>>
>> Signed-off-by: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
> Hi Josselin,
> 
> Thanks for taking this on. Definitely a useful little bit of functionality.
> I'll take a close look once all the bits Lars picked up on are sorted.
> 
> Right now, why watermark_low?  (rather than simply watermark?).
It was to match the SO_RCVLOWAT socket option wich I understand as
"socket_receive_low_watermark".

> And you know what comes with adding new ABI.  Documentation please :)
Yes, I'll have to work on that! Once we all agree on the interface we want 
to provide.

>> ---
>>   drivers/iio/industrialio-buffer.c | 138 ++++++++++++++++++++++++++++++++++----
>>   drivers/iio/kfifo_buf.c           |   4 ++
>>   include/linux/iio/buffer.h        |  40 +++++++++++
>>   3 files changed, 169 insertions(+), 13 deletions(-)
>>
>> Changelog:
>> v2: thanks to Lars-Peter Clausen and Jonathan Cameron
>> - Avoid breaking default ABI
>> - Add watermark and timeout properties to buffers
>>
>> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
>> index 36b1ae9..1fe0116 100644
>> --- a/drivers/iio/industrialio-buffer.c
>> +++ b/drivers/iio/industrialio-buffer.c
>> @@ -56,6 +56,10 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>>   {
>>   	struct iio_dev *indio_dev = filp->private_data;
>>   	struct iio_buffer *rb = indio_dev->buffer;
>> +	size_t datum_size = rb->access->get_bytes_per_datum(rb);
>> +	size_t watermark_bytes = rb->low_watermark * datum_size;
>> +	size_t count = 0;
>> +	long timeout = rb->timeout;
>>   	int ret;
>>
>>   	if (!indio_dev->info)
>> @@ -66,24 +70,35 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>>
>>   	do {
>>   		if (!iio_buffer_data_available(rb)) {
>> -			if (filp->f_flags & O_NONBLOCK)
>> -				return -EAGAIN;
>> +			if (filp->f_flags & O_NONBLOCK) {
>> +				ret = -EAGAIN;
>> +				break;
>> +			}
>>
>> -			ret = wait_event_interruptible(rb->pollq,
>> +			timeout = wait_event_interruptible_timeout(rb->pollq,
>>   					iio_buffer_data_available(rb) ||
>> -					indio_dev->info == NULL);
>> -			if (ret)
>> -				return ret;
>> -			if (indio_dev->info == NULL)
>> -				return -ENODEV;
>> +					indio_dev->info == NULL,
>> +					timeout);
>> +			if (timeout <= 0) {
>> +				ret = timeout;
>> +				break;
>> +			}
>> +
>> +			if (indio_dev->info == NULL) {
>> +				ret = -ENODEV;
>> +				break;
>> +			}
>>   		}
>>
>> -		ret = rb->access->read_first_n(rb, n, buf);
>> -		if (ret == 0 && (filp->f_flags & O_NONBLOCK))
>> -			ret = -EAGAIN;
>> -	 } while (ret == 0);
>> +		ret = rb->access->read_first_n(rb, n, buf + count);
>> +		if (ret < 0)
>> +			break;
>>
>> -	return ret;
>> +		n -= ret;
>> +		count += ret;
>> +	 } while (n > 0 && count < watermark_bytes);
>> +
>> +	return count ? count : ret;
>>   }
>>
>>   /**
>> @@ -126,6 +141,8 @@ void iio_buffer_init(struct iio_buffer *buffer)
>>   	INIT_LIST_HEAD(&buffer->buffer_list);
>>   	init_waitqueue_head(&buffer->pollq);
>>   	kref_init(&buffer->ref);
>> +	buffer->low_watermark = 1;
>> +	buffer->timeout = MAX_SCHEDULE_TIMEOUT;
>>   }
>>   EXPORT_SYMBOL(iio_buffer_init);
>>
>> @@ -795,6 +812,101 @@ done:
>>   }
>>   EXPORT_SYMBOL(iio_buffer_store_enable);
>>
>> +ssize_t iio_buffer_show_watermark(struct device *dev,
>> +				   struct device_attribute *attr,
>> +				   char *buf)
>> +{
>> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>> +	struct iio_buffer *buffer = indio_dev->buffer;
>> +
>> +	return sprintf(buf, "%u\n", buffer->low_watermark);
>> +}
>> +EXPORT_SYMBOL(iio_buffer_show_watermark);
>> +
>> +ssize_t iio_buffer_store_watermark(struct device *dev,
>> +				struct device_attribute *attr,
>> +				const char *buf,
>> +				size_t len)
>> +{
>> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>> +	struct iio_buffer *buffer = indio_dev->buffer;
>> +	unsigned int val;
>> +	int ret;
>> +
>> +	ret = kstrtouint(buf, 10, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	mutex_lock(&indio_dev->mlock);
>> +	if (iio_buffer_is_active(indio_dev->buffer)) {
>> +		ret = -EBUSY;
>> +		goto out;
>> +	}
>> +
>> +	buffer->low_watermark = val;
>> +	ret = 0;
>> +out:
>> +	mutex_unlock(&indio_dev->mlock);
>> +	return ret ? ret : len;
>> +}
>> +EXPORT_SYMBOL(iio_buffer_store_watermark);
>> +
>> +static int iio_buffer_timeout_set(struct iio_buffer *buffer, long timeout_us)
>> +{
>> +	if (timeout_us >= 0) {
>> +		buffer->timeout = usecs_to_jiffies(timeout_us);
>> +	} else if (timeout_us == -1){
>> +		buffer->timeout = MAX_SCHEDULE_TIMEOUT;
>> +	} else {
>> +		return -EINVAL;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static long iio_buffer_timeout_get(struct iio_buffer *buffer)
>> +{
>> +	if (buffer->timeout != MAX_SCHEDULE_TIMEOUT)
>> +		return jiffies_to_usecs(buffer->timeout);
>> +	return -1;
>> +}
>> +
>> +ssize_t iio_buffer_show_timeout(struct device *dev,
>> +				   struct device_attribute *attr,
>> +				   char *buf)
>> +{
>> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>> +	struct iio_buffer *buffer = indio_dev->buffer;
>> +
>> +	return sprintf(buf, "%ld\n", iio_buffer_timeout_get(buffer));
>> +}
>> +EXPORT_SYMBOL(iio_buffer_show_timeout);
>> +
>> +ssize_t iio_buffer_store_timeout(struct device *dev,
>> +				struct device_attribute *attr,
>> +				const char *buf,
>> +				size_t len)
>> +{
>> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>> +	struct iio_buffer *buffer = indio_dev->buffer;
>> +	long val;
>> +	int ret;
>> +
>> +	ret = kstrtol(buf, 10, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	mutex_lock(&indio_dev->mlock);
>> +	if (iio_buffer_is_active(indio_dev->buffer)) {
>> +		ret = -EBUSY;
>> +		goto out;
>> +	}
>> +	ret = iio_buffer_timeout_set(buffer, val);
>> +out:
>> +	mutex_unlock(&indio_dev->mlock);
>> +	return ret ? ret : len;
>> +}
>> +EXPORT_SYMBOL(iio_buffer_store_timeout);
>> +
>>   /**
>>    * iio_validate_scan_mask_onehot() - Validates that exactly one channel is selected
>>    * @indio_dev: the iio device
>> diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
>> index 7134e8a..ab7ea54 100644
>> --- a/drivers/iio/kfifo_buf.c
>> +++ b/drivers/iio/kfifo_buf.c
>> @@ -54,10 +54,14 @@ static int iio_get_length_kfifo(struct iio_buffer *r)
>>
>>   static IIO_BUFFER_ENABLE_ATTR;
>>   static IIO_BUFFER_LENGTH_ATTR;
>> +static IIO_BUFFER_WATERMARK_ATTR;
>> +static IIO_BUFFER_TIMEOUT_ATTR;
>>
>>   static struct attribute *iio_kfifo_attributes[] = {
>>   	&dev_attr_length.attr,
>>   	&dev_attr_enable.attr,
>> +	&dev_attr_low_watermark.attr,
>> +	&dev_attr_timeout.attr,
>>   	NULL,
>>   };
>>
>> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
>> index 5193927..41c8f11 100644
>> --- a/include/linux/iio/buffer.h
>> +++ b/include/linux/iio/buffer.h
>> @@ -61,6 +61,8 @@ struct iio_buffer_access_funcs {
>>    * struct iio_buffer - general buffer structure
>>    * @length:		[DEVICE] number of datums in buffer
>>    * @bytes_per_datum:	[DEVICE] size of individual datum including timestamp
>> + * @low_watermark:	[DEVICE] blocking read granularity in datums
>> + * @timeout:		[DEVICE] blocking read timeout in jiffies
>>    * @scan_el_attrs:	[DRIVER] control of scan elements if that scan mode
>>    *			control method is used
>>    * @scan_mask:		[INTERN] bitmask used in masking scan mode elements
>> @@ -80,6 +82,8 @@ struct iio_buffer_access_funcs {
>>   struct iio_buffer {
>>   	int					length;
>>   	int					bytes_per_datum;
>> +	unsigned int				low_watermark;
>> +	long					timeout;
>>   	struct attribute_group			*scan_el_attrs;
>>   	long					*scan_mask;
>>   	bool					scan_timestamp;
>> @@ -201,6 +205,34 @@ ssize_t iio_buffer_store_enable(struct device *dev,
>>   ssize_t iio_buffer_show_enable(struct device *dev,
>>   			       struct device_attribute *attr,
>>   			       char *buf);
>> +/**
>> + * iio_buffer_show_watermark() - attr to see the read watermark
>> + **/
>> +ssize_t iio_buffer_show_watermark(struct device *dev,
>> +				struct device_attribute *attr,
>> +				char *buf);
>> +/**
>> + * iio_buffer_store_watermark() - attr to configure the read watermark
>> + **/
>> +ssize_t iio_buffer_store_watermark(struct device *dev,
>> +				struct device_attribute *attr,
>> +				const char *buf,
>> +				size_t len);
>> +/**
>> + * iio_buffer_show_timeout() - attr to see the read timeout (microseconds)
>> + * Note: if no timeout is set, returns -1
>> + **/
>> +ssize_t iio_buffer_show_timeout(struct device *dev,
>> +				struct device_attribute *attr,
>> +				char *buf);
>> +/**
>> + * iio_buffer_store_timeout() - attr to configure read timeout (microseconds)
>> + * Note: to disable the timeout, write -1
>> + **/
>> +ssize_t iio_buffer_store_timeout(struct device *dev,
>> +				struct device_attribute *attr,
>> +				const char *buf,
>> +				size_t len);
>>   #define IIO_BUFFER_LENGTH_ATTR DEVICE_ATTR(length, S_IRUGO | S_IWUSR,	\
>>   					   iio_buffer_read_length,	\
>>   					   iio_buffer_write_length)
>> @@ -209,6 +241,14 @@ ssize_t iio_buffer_show_enable(struct device *dev,
>>   					   iio_buffer_show_enable,	\
>>   					   iio_buffer_store_enable)
>>
>> +#define IIO_BUFFER_WATERMARK_ATTR DEVICE_ATTR(low_watermark, S_IRUGO | S_IWUSR,	\
>> +					   iio_buffer_show_watermark,	\
>> +					   iio_buffer_store_watermark)
>> +
>> +#define IIO_BUFFER_TIMEOUT_ATTR DEVICE_ATTR(timeout, S_IRUGO | S_IWUSR,	\
>> +					   iio_buffer_show_timeout,	\
>> +					   iio_buffer_store_timeout)
>> +
>>   bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
>>   	const unsigned long *mask);
>>
>>


