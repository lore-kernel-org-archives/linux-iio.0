Return-Path: <dmurphy@ti.com>
Message-ID: <556DDF1B.70204@ti.com>
Date: Tue, 2 Jun 2015 11:51:39 -0500
From: Dan Murphy <dmurphy@ti.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] iio: heart_monitors: Add an event for heart rate
 monitors
References: <1431374726-23383-1-git-send-email-dmurphy@ti.com> <1431374726-23383-2-git-send-email-dmurphy@ti.com> <55588F0B.8050607@kernel.org>
In-Reply-To: <55588F0B.8050607@kernel.org>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>

Jonathan

On 05/17/2015 07:52 AM, Jonathan Cameron wrote:
> On 11/05/15 21:05, Dan Murphy wrote:
>> Add an event for heart rate monitors to signal an event
>> once a heart rate measurement has been completed.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> Not needed by the current driver.

Sorry for the delayed response was working on another driver's comments.

This is actually used to announce that that heartrate event is ready to be read.
In patch 3/3 in the function call

afe4403_event_handler

The IIO_HEARTRATE event is pushed.
And having the heartrate name spec does not hurt.

Dan
>> ---
>>  drivers/iio/industrialio-core.c | 1 +
>>  include/uapi/linux/iio/types.h  | 1 +
>>  tools/iio/iio_event_monitor.c   | 2 ++
>>  3 files changed, 4 insertions(+)
>>
>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
>> index 4df97f6..b7b3817 100644
>> --- a/drivers/iio/industrialio-core.c
>> +++ b/drivers/iio/industrialio-core.c
>> @@ -75,6 +75,7 @@ static const char * const iio_chan_type_name_spec[] = {
>>  	[IIO_ENERGY] = "energy",
>>  	[IIO_DISTANCE] = "distance",
>>  	[IIO_VELOCITY] = "velocity",
>> +	[IIO_HEARTRATE] = "heartrate",
>>  };
>>  
>>  static const char * const iio_modifier_names[] = {
>> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
>> index 5c46019..b5e8c2f 100644
>> --- a/include/uapi/linux/iio/types.h
>> +++ b/include/uapi/linux/iio/types.h
>> @@ -35,6 +35,7 @@ enum iio_chan_type {
>>  	IIO_ENERGY,
>>  	IIO_DISTANCE,
>>  	IIO_VELOCITY,
>> +	IIO_HEARTRATE,
>>  };
>>  
>>  enum iio_modifier {
>> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
>> index 427c271..b2cc544 100644
>> --- a/tools/iio/iio_event_monitor.c
>> +++ b/tools/iio/iio_event_monitor.c
>> @@ -51,6 +51,7 @@ static const char * const iio_chan_type_name_spec[] = {
>>  	[IIO_HUMIDITYRELATIVE] = "humidityrelative",
>>  	[IIO_ACTIVITY] = "activity",
>>  	[IIO_STEPS] = "steps",
>> +	[IIO_HEARTRATE] = "heartrate",
>>  };
>>  
>>  static const char * const iio_ev_type_text[] = {
>> @@ -130,6 +131,7 @@ static bool event_is_known(struct iio_event_data *event)
>>  	case IIO_HUMIDITYRELATIVE:
>>  	case IIO_ACTIVITY:
>>  	case IIO_STEPS:
>> +	case IIO_HEARTRATE:
>>  		break;
>>  	default:
>>  		return false;
>>


-- 
------------------
Dan Murphy
