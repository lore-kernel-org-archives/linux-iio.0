Return-Path: <lars@metafoo.de>
Message-ID: <5259221C.4040309@metafoo.de>
Date: Sat, 12 Oct 2013 12:19:08 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio:buffer: Ignore noop requests for iio_update_buffers()
References: <1380884822-17035-1-git-send-email-lars@metafoo.de> <1380884822-17035-5-git-send-email-lars@metafoo.de> <52592E09.30507@kernel.org>
In-Reply-To: <52592E09.30507@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 10/12/2013 01:10 PM, Jonathan Cameron wrote:
> On 10/04/13 12:07, Lars-Peter Clausen wrote:
>> Since the kernel now disables all buffers when a device is unregistered it might
>> happen that a in-kernel consumer tries to disable that buffer again. So ignore
>> requests where the buffer already is in the desired state.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>> No changes since v1
>> ---
>>  drivers/iio/industrialio-buffer.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
>> index d6a5455..fd3f3af 100644
>> --- a/drivers/iio/industrialio-buffer.c
>> +++ b/drivers/iio/industrialio-buffer.c
>> @@ -681,9 +681,23 @@ int iio_update_buffers(struct iio_dev *indio_dev,
>>  {
>>  	int ret;
>>  
>> +	if (insert_buffer == remove_buffer)
>> +		return 0;
>> +
>>  	mutex_lock(&indio_dev->info_exist_lock);
>>  	mutex_lock(&indio_dev->mlock);
>>  
>> +	if (insert_buffer && iio_buffer_is_active(insert_buffer))
>> +		insert_buffer = NULL;
>> +
>> +	if (remove_buffer && !iio_buffer_is_active(remove_buffer))
>> +		remove_buffer = NULL;
>> +
> So this condition will occur iff insert_buffer = 0 and remove buffer = 0?
> 
> If so, then insert_buffer == remove_buffer and you'll have already returned 0 above??

This is to catch the case where we've set one (or both) of them to NULL
because it was already in the requested state.

> 
> Entirely possible I'm needing more coffee this morning...
>> +	if (!insert_buffer && !remove_buffer) {
>> +		ret = 0;
>> +		goto out_unlock;
>> +	}
>> +
>>  	if (indio_dev->info == NULL) {
>>  		ret = -ENODEV;
>>  		goto out_unlock;
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
