Return-Path: <lars@metafoo.de>
Message-ID: <523A165F.60709@metafoo.de>
Date: Wed, 18 Sep 2013 23:08:47 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 01/10] iio: Stop sampling when the device is removed
References: <1379534574-11213-1-git-send-email-lars@metafoo.de> <523A2299.3050101@kernel.org>
In-Reply-To: <523A2299.3050101@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 09/19/2013 12:00 AM, Jonathan Cameron wrote:
> On 09/18/13 21:02, Lars-Peter Clausen wrote:
>> Make sure to stop sampling when the device is removed, otherwise it will
>> continue to sample forever.
>
> The intent is that you can't remove a device if there is a buffer
> enabled. I thought we had the reference counting correct to prevent
> this happening.  Perhaps not!
>

You can't prevent a device from being removed, that's a basic property of the 
Linux device driver model. Device drivers and subsystems need to be able to 
deal with hot unplug.

- Lars

>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>>   drivers/iio/iio_core.h            |  4 ++++
>>   drivers/iio/industrialio-buffer.c | 19 +++++++++++++++++++
>>   drivers/iio/industrialio-core.c   |  6 +++++-
>>   3 files changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
>> index 6be5ab8..9209f47 100644
>> --- a/drivers/iio/iio_core.h
>> +++ b/drivers/iio/iio_core.h
>> @@ -49,11 +49,15 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>>   #define iio_buffer_poll_addr (&iio_buffer_poll)
>>   #define iio_buffer_read_first_n_outer_addr (&iio_buffer_read_first_n_outer)
>>
>> +void iio_disable_all_buffers(struct iio_dev *indio_dev);
>> +
>>   #else
>>
>>   #define iio_buffer_poll_addr NULL
>>   #define iio_buffer_read_first_n_outer_addr NULL
>>
>> +static inline void iio_disable_all_buffers(struct iio_dev *indio_dev) {}
>> +
>>   #endif
>>
>>   int iio_device_register_eventset(struct iio_dev *indio_dev);
>> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
>> index a7ac4b5..379721a 100644
>> --- a/drivers/iio/industrialio-buffer.c
>> +++ b/drivers/iio/industrialio-buffer.c
>> @@ -452,6 +452,25 @@ static int iio_compute_scan_bytes(struct iio_dev *indio_dev, const long *mask,
>>   	return bytes;
>>   }
>>
>> +void iio_disable_all_buffers(struct iio_dev *indio_dev)
>> +{
>> +	struct iio_buffer *buffer, *_buffer;
>> +
>> +	if (list_empty(&indio_dev->buffer_list))
>> +		return;
>> +
>> +	if (indio_dev->setup_ops->predisable)
>> +		indio_dev->setup_ops->predisable(indio_dev);
>> +
>> +	list_for_each_entry_safe(buffer, _buffer,
>> +			&indio_dev->buffer_list, buffer_list)
>> +		list_del_init(&buffer->buffer_list);
>> +
>> +	indio_dev->currentmode = INDIO_DIRECT_MODE;
>> +	if (indio_dev->setup_ops->postdisable)
>> +		indio_dev->setup_ops->postdisable(indio_dev);
>> +}
>> +
>>   int iio_update_buffers(struct iio_dev *indio_dev,
>>   		       struct iio_buffer *insert_buffer,
>>   		       struct iio_buffer *remove_buffer)
>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
>> index 24db185..96b35f0 100644
>> --- a/drivers/iio/industrialio-core.c
>> +++ b/drivers/iio/industrialio-core.c
>> @@ -1120,9 +1120,13 @@ EXPORT_SYMBOL(iio_device_register);
>>   void iio_device_unregister(struct iio_dev *indio_dev)
>>   {
>>   	mutex_lock(&indio_dev->info_exist_lock);
>> +
>> +	device_del(&indio_dev->dev);
>> +
>> +	iio_disable_all_buffers(indio_dev);
>> +
>>   	indio_dev->info = NULL;
>>   	mutex_unlock(&indio_dev->info_exist_lock);
>> -	device_del(&indio_dev->dev);
>>   }
>>   EXPORT_SYMBOL(iio_device_unregister);
>>   subsys_initcall(iio_init);
>>
