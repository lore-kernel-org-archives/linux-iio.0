Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47146 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964797AbaLLLLl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Dec 2014 06:11:41 -0500
Message-ID: <548ACD6B.30608@kernel.org>
Date: Fri, 12 Dec 2014 11:11:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 10/11] iio: buffer: Make length attribute read only for
 buffers without set_length
References: <1417024517-7564-1-git-send-email-lars@metafoo.de> <1417024517-7564-11-git-send-email-lars@metafoo.de> <548ACCA7.7080706@kernel.org>
In-Reply-To: <548ACCA7.7080706@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/12/14 11:08, Jonathan Cameron wrote:
> On 26/11/14 17:55, Lars-Peter Clausen wrote:
>> If a buffer implementation does not implement the set_length() callback the
>> length will be static and can not be changed by userspace. Mark the length
>> attribute as a read only property in this case so userspace is aware of this
>> rather than just silently accepting any length value.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Nice little change.
> 
Having said that I doubt that longterm this will apply to many devices
as we'll be routing more and more hardware buffers through a software
front end and that front end will be variable size...

Anyhow, applied to the togreg branch of iio.git with fuzz etc
from my earlier patch tweaking.

> Thanks
> Jonathan
>> ---
>>  drivers/iio/industrialio-buffer.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
>> index a4d3ff6..3e0c3a9 100644
>> --- a/drivers/iio/industrialio-buffer.c
>> +++ b/drivers/iio/industrialio-buffer.c
>> @@ -416,8 +416,7 @@ static ssize_t iio_buffer_write_length(struct device *dev,
>>  	if (iio_buffer_is_active(indio_dev->buffer)) {
>>  		ret = -EBUSY;
>>  	} else {
>> -		if (buffer->access->set_length)
>> -			buffer->access->set_length(buffer, val);
>> +		buffer->access->set_length(buffer, val);
>>  		ret = 0;
>>  	}
>>  	mutex_unlock(&indio_dev->mlock);
>> @@ -755,6 +754,8 @@ static const char * const iio_scan_elements_group_name = "scan_elements";
>>  
>>  static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
>>  	iio_buffer_write_length);
>> +static struct device_attribute dev_attr_length_ro = __ATTR(length,
>> +	S_IRUGO, iio_buffer_read_length, NULL);
>>  static DEVICE_ATTR(enable, S_IRUGO | S_IWUSR,
>>  	iio_buffer_show_enable, iio_buffer_store_enable);
>>  
>> @@ -781,7 +782,10 @@ int iio_buffer_alloc_sysfs(struct iio_dev *indio_dev)
>>  	if (!buffer->buffer_group.attrs)
>>  		return -ENOMEM;
>>  
>> -	buffer->buffer_group.attrs[0] = &dev_attr_length.attr;
>> +	if (buffer->access->set_length)
>> +		buffer->buffer_group.attrs[0] = &dev_attr_length.attr;
>> +	else
>> +		buffer->buffer_group.attrs[0] = &dev_attr_length_ro.attr;
>>  	buffer->buffer_group.attrs[1] = &dev_attr_enable.attr;
>>  	if (buffer->attrs)
>>  		memcpy(&buffer->buffer_group.attrs[2], buffer->attrs,
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

