Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <52668EA9.3070209@linux.intel.com>
Date: Tue, 22 Oct 2013 07:41:45 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/9] iio: Fix crash in trigger unregister
References: <1382389277-7932-1-git-send-email-srinivas.pandruvada@linux.intel.com> <997f9af3-4265-483e-960e-9ee08051ba3c@email.android.com>
In-Reply-To: <997f9af3-4265-483e-960e-9ee08051ba3c@email.android.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 10/21/2013 02:35 PM, Jonathan Cameron wrote:
>
> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
>> User space can write a triger name via trigger/current_trigger.
>> But it is possible that it can't find this name. In this case
>> iio_trigger_find_by_name will return NULL. Even if it is NULL,
>> it sets indio_dev->trig to this NULL value. But when iio drivers
>> calls iio_trigger_unregister, it will crash because it will try
>> to dereference NULL pointer. So either every driver checks for
>> NULL before calling iio_trigger_unregister or make sure that
>> NULL is not assigned because of invalid trigger name. The later
>> is better and has less impact.
>>
>> Signed-off-by: Srinivas Pandruvada
>> <srinivas.pandruvada@linux.intel.com>
>   Sorry to say I missed this in review.
> Indio_dev->trig is a pointer to the trigger being used by the device NOT the trigger provided by the device.  If the device provides a trigger, the pointer to that is stored somewhere in iio_priv.
>
> Hence the bug is not in the core but in the sensor hub trigger creation and freeing code.
>
> Sorry again that I did not pick up on this before as this is not the first driver to confuse this. In mitigation it is clearly documented as intern (i.e. not for driver assignment) in iio.h
>
> When I get a few mins I will check if we have any other equivalent cases that have slipped through the net...
<Thanks for pointing this. I will fix in sensor hub driver and resubmit.>

Srinivas
> Jonathan
>> ---
>> drivers/iio/industrialio-trigger.c | 7 +++++--
>> 1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/industrialio-trigger.c
>> b/drivers/iio/industrialio-trigger.c
>> index bf5e70a..4dc4247 100644
>> --- a/drivers/iio/industrialio-trigger.c
>> +++ b/drivers/iio/industrialio-trigger.c
>> @@ -342,13 +342,16 @@ static ssize_t iio_trigger_write_current(struct
>> device *dev,
>> 	if (oldtrig == trig)
>> 		return len;
>>
>> -	if (trig && indio_dev->info->validate_trigger) {
>> +	if (!trig)
>> +		return -EINVAL;
>> +
>> +	if (indio_dev->info->validate_trigger) {
>> 		ret = indio_dev->info->validate_trigger(indio_dev, trig);
>> 		if (ret)
>> 			return ret;
>> 	}
>>
>> -	if (trig && trig->ops && trig->ops->validate_device) {
>> +	if (trig->ops && trig->ops->validate_device) {
>> 		ret = trig->ops->validate_device(trig, indio_dev);
>> 		if (ret)
>> 			return ret;
