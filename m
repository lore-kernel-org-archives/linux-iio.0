Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36709 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab3CBQco (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:32:44 -0500
Message-ID: <513229AB.90700@kernel.org>
Date: Sat, 02 Mar 2013 16:32:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: Guenter Roeck <linux@roeck-us.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: Fix build error seen if IIO_TRIGGER is defined but
 IIO_BUFFER is not
References: <1362153448-16259-1-git-send-email-linux@roeck-us.net> <5130D43E.4010800@st.com>
In-Reply-To: <5130D43E.4010800@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/01/2013 04:15 PM, Denis CIOCCA wrote:
> Ok Thanks.
> 
> Acked-by: Denis Ciocca <denis.ciocca@st.com>
Applied to fixes-togreg branch of iio.git

Thanks,
> 
> 
> Denis
> 
> 
> On 03/01/2013 04:57 PM, Guenter Roeck wrote:
>> If CONFIG_IIO_TRIGGER is defined but CONFIG_IIO_BUFFER is not, the following
>> build error is seen.
>>
>> drivers/iio/common/st_sensors/st_sensors_trigger.c:21:5: error:
>> redefinition of ‘st_sensors_allocate_trigger’
>> In file included from
>> drivers/iio/common/st_sensors/st_sensors_trigger.c:18:0:
>> include/linux/iio/common/st_sensors.h:239:19: note: previous
>> definition of ‘st_sensors_allocate_trigger’ was here
>> drivers/iio/common/st_sensors/st_sensors_trigger.c:65:6: error:
>> redefinition of ‘st_sensors_deallocate_trigger’
>> In file included from
>> drivers/iio/common/st_sensors/st_sensors_trigger.c:18:0:
>> include/linux/iio/common/st_sensors.h:244:20: note: previous
>> definition of ‘st_sensors_deallocate_trigger’ was here
>>
>> This occurs because st_sensors_deallocate_trigger is built if CONFIG_IIO_TRIGGER
>> is defined, but the dummy function is compiled if CONFIG_IIO_BUFFER is defined.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   include/linux/iio/common/st_sensors.h |    9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
>> index 1f86a97..8bd12be 100644
>> --- a/include/linux/iio/common/st_sensors.h
>> +++ b/include/linux/iio/common/st_sensors.h
>> @@ -227,14 +227,17 @@ struct st_sensor_data {
>>   };
>>
>>   #ifdef CONFIG_IIO_BUFFER
>> +irqreturn_t st_sensors_trigger_handler(int irq, void *p);
>> +
>> +int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf);
>> +#endif
>> +
>> +#ifdef CONFIG_IIO_TRIGGER
>>   int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>>   				const struct iio_trigger_ops *trigger_ops);
>>
>>   void st_sensors_deallocate_trigger(struct iio_dev *indio_dev);
>>
>> -irqreturn_t st_sensors_trigger_handler(int irq, void *p);
>> -
>> -int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf);
>>   #else
>>   static inline int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>>   				const struct iio_trigger_ops *trigger_ops)
>>
> 
