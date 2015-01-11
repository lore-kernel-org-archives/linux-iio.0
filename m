Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <54B30286.7090106@linux.intel.com>
Date: Sun, 11 Jan 2015 15:08:54 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, jkosina@suse.cz,
 a.zummo@towertech.it
CC: linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
 holler@ahsoftware.de, rtc-linux@googlegroups.com
Subject: Re: [PATCH 2/9] iio: hid-sensor-accel-3d: Adjust parameter for attribute
 read
References: <1420656483-7093-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1420656483-7093-3-git-send-email-srinivas.pandruvada@linux.intel.com> <54B1AAD6.6070303@kernel.org>
In-Reply-To: <54B1AAD6.6070303@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>


On 01/10/2015 02:42 PM, Jonathan Cameron wrote:
> On 07/01/15 18:47, Srinivas Pandruvada wrote:
>> The new API added a flag for sync/async mode. Added sync mode flag.
>>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Again, please don't break the build between patches like this.
As we did in the past, the hid sensor hub patches involving hid sensor 
and IIO part goes through one tree, either via IIO or HID.
So once acked this needs to go through a single tree, as done in the past.
So the patches submitted in a series to avoid breaking build.

Thanks,
Srinivas
>
> If you want to do things in steps, you'll have to carry to versions of
> the function during the conversion and drop the unwanted one at the end.
>
>> ---
>>   drivers/iio/accel/hid-sensor-accel-3d.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
>> index d5d9531..0085c2f 100644
>> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
>> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
>> @@ -130,7 +130,8 @@ static int accel_3d_read_raw(struct iio_dev *indio_dev,
>>   			*val = sensor_hub_input_attr_get_raw_value(
>>   					accel_state->common_attributes.hsdev,
>>   					HID_USAGE_SENSOR_ACCEL_3D, address,
>> -					report_id);
>> +					report_id,
>> +					SENSOR_HUB_SYNC);
>>   		else {
>>   			*val = 0;
>>   			hid_sensor_power_state(&accel_state->common_attributes,
>>
>
