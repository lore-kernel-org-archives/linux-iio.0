Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:55480 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752501AbeGAWYh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Jul 2018 18:24:37 -0400
Subject: Re: [PATCH] iio: add channel type for frequency
To: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
References: <20180701025953.3561-1-david@lechnology.com>
 <308015e8-d203-c4d1-ba80-3c2adf4b377a@metafoo.de>
From: David Lechner <david@lechnology.com>
Message-ID: <74c98fdc-b498-c593-e0b1-6aeb7057398a@lechnology.com>
Date: Sun, 1 Jul 2018 17:24:34 -0500
MIME-Version: 1.0
In-Reply-To: <308015e8-d203-c4d1-ba80-3c2adf4b377a@metafoo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/01/2018 02:18 AM, Lars-Peter Clausen wrote:
> On 07/01/2018 04:59 AM, David Lechner wrote:
>> This adds a new type for frequency to the IIO channel type enumeration.
>>
>> Units are in Hz.
>>
> 
> Documentation?

I take it that you mean Documentation/ABI/testing/sysfs-bus-iio? Or
somewhere else too?

> 
> We already have the altvoltage channel type with the frequency attribute.
> Difficult to say if there are any overlaps without documentation on how this
> new attribute is supposed to be used.

I'm basically trying to implement a quadrature encoder in iio. I want to be
able to use it in-kernel to get a rotational speed value for a motor.

The motors (and encoder wheels) are hot-swapable, so we don't know how many
counts from the quadrature encoder equals one rotation because it depends on
which motor is being used. So using IIO_ANGL_VEL doesn't work for this case.

It seems to me that the proper generic unit for "speed" from the quadrature
encoder would be counts per second, hence the suggestion of a frequency unit.
I'm not sure if voltage frequency works here since a "count" on a quadrature
encoder is derived from two different voltage signals (and may vary depending
on how the encoder determines what one count it).

Also, unrelated to my quadrature encoder project, I was thinking that
frequency counters would use this unit as well (although the voltage alt
makes more sense for this case).

There are also sound sensors that measure frequency that could use this unit.

> 
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>>   drivers/iio/industrialio-core.c | 1 +
>>   include/uapi/linux/iio/types.h  | 1 +
>>   tools/iio/iio_event_monitor.c   | 1 +
>>   3 files changed, 3 insertions(+)
>>
>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
>> index 19bdf3d2962a..f3c2c9e4b997 100644
>> --- a/drivers/iio/industrialio-core.c
>> +++ b/drivers/iio/industrialio-core.c
>> @@ -85,6 +85,7 @@ static const char * const iio_chan_type_name_spec[] = {
>>   	[IIO_COUNT] = "count",
>>   	[IIO_INDEX] = "index",
>>   	[IIO_GRAVITY]  = "gravity",
>> +	[IIO_FREQUENCY] = "frequency",
>>   };
>>   
>>   static const char * const iio_modifier_names[] = {
>> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
>> index 4213cdf88e3c..9fee86e2046f 100644
>> --- a/include/uapi/linux/iio/types.h
>> +++ b/include/uapi/linux/iio/types.h
>> @@ -44,6 +44,7 @@ enum iio_chan_type {
>>   	IIO_COUNT,
>>   	IIO_INDEX,
>>   	IIO_GRAVITY,
>> +	IIO_FREQUENCY,
>>   };
>>   
>>   enum iio_modifier {
>> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
>> index b61245e1181d..c3ef20057d52 100644
>> --- a/tools/iio/iio_event_monitor.c
>> +++ b/tools/iio/iio_event_monitor.c
>> @@ -58,6 +58,7 @@ static const char * const iio_chan_type_name_spec[] = {
>>   	[IIO_PH] = "ph",
>>   	[IIO_UVINDEX] = "uvindex",
>>   	[IIO_GRAVITY] = "gravity",
>> +	[IIO_FREQUENCY] = "frequency",
>>   };
>>   
>>   static const char * const iio_ev_type_text[] = {
>>
> 

