Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <53C049A4.6050508@linux.intel.com>
Date: Fri, 11 Jul 2014 13:31:32 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: core : events ABI for specifying period
References: <1404858591-10061-1-git-send-email-srinivas.pandruvada@linux.intel.com> <53C0475C.3040603@kernel.org>
In-Reply-To: <53C0475C.3040603@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 07/11/2014 01:21 PM, Jonathan Cameron wrote:
> On 08/07/14 23:29, Srinivas Pandruvada wrote:
>> The iio sysfs ABI defines a way to specify period for roc and thresholds.
>> What:        /sys/.../events/in_accel_x_thresh_rising_period
>> What:        /sys/.../events/in_accel_x_thresh_falling_period
>> what:        /sys/.../events/in_accel_x_roc_rising_period
>> What:        /sys/.../events/in_accel_x_roc_falling_period
>>
>> But there is no way to add period with the current event info enum.
>>
>> Added IIO_EV_INFO_PERIOD and corresponding string.
>>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> One of several even related element that haven't gotten added yet but
> we'll do them as and when anyone cares.
Sure, I will submit a driver using this soon.

Thanks,
Srinivas
>
> Thanks,
>
> Jonathan
>> ---
>>   drivers/iio/industrialio-event.c | 1 +
>>   include/linux/iio/types.h        | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/drivers/iio/industrialio-event.c
>> b/drivers/iio/industrialio-event.c
>> index bfbf4d4..0c1e37e 100644
>> --- a/drivers/iio/industrialio-event.c
>> +++ b/drivers/iio/industrialio-event.c
>> @@ -209,6 +209,7 @@ static const char * const iio_ev_info_text[] = {
>>       [IIO_EV_INFO_ENABLE] = "en",
>>       [IIO_EV_INFO_VALUE] = "value",
>>       [IIO_EV_INFO_HYSTERESIS] = "hysteresis",
>> +    [IIO_EV_INFO_PERIOD] = "period",
>>   };
>>
>>   static enum iio_event_direction iio_ev_attr_dir(struct iio_dev_attr
>> *attr)
>> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
>> index d09c40d..4a2af8a 100644
>> --- a/include/linux/iio/types.h
>> +++ b/include/linux/iio/types.h
>> @@ -74,6 +74,7 @@ enum iio_event_info {
>>       IIO_EV_INFO_ENABLE,
>>       IIO_EV_INFO_VALUE,
>>       IIO_EV_INFO_HYSTERESIS,
>> +    IIO_EV_INFO_PERIOD,
>>   };
>>
>>   enum iio_event_direction {
>>
>
>
