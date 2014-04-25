Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54446 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbaDZIwp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 26 Apr 2014 04:52:45 -0400
Message-ID: <535AAAC4.9050708@kernel.org>
Date: Fri, 25 Apr 2014 19:34:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 01/16] iio: hid-sensors: Convert units and exponent
References: <1397863356-2470-1-git-send-email-srinivas.pandruvada@linux.intel.com> <53582945.7020300@kernel.org> <53582DDF.6060005@linux.intel.com>
In-Reply-To: <53582DDF.6060005@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/04/14 22:17, Srinivas Pandruvada wrote:
>
> On 04/23/2014 01:57 PM, Jonathan Cameron wrote:
>> On 19/04/14 00:22, Srinivas Pandruvada wrote:
>>> HID sensor hub specify a default unit and alternative units. This
>>> along with unit exponent can be used adjust scale. This change
>>> change HID sensor data units to IIO defined units for each
>>> sensor type. So in this way user space can use a simply use:
>>> "(data + offset) * scale" to get final result.
>>>
>>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>>
>> Hi Srinivas,
>>
>> What 'grief' is this abi change likely to cause us?
>>
> Hi Jonathan,
>
> Since the products are just released with the hubs, I don't think there is much impact.
> I have notified few users I knew, who pointed me about this disparity.
>
>
> Thanks,
> Srinivas
Cool. I'll attach a health warning to the pull request that this 'might cause'
grief, but the view is that it is unlikely and we are simply bringing the driver
in line with the API that existed at the time.  I'll also add that we have users
noticing and querying the disrepency.
  
>> I know I effectively asked you to fix this, but I'd like to get
>> a handle on just how many people are likely to shout.
>>
>> The original code is a gross breaking of the published ABI so
>> it probably is reasonable to change it...
>>
>> I'm too tired to review this properly right now so only the most
>> superficial comments in line.
>>> ---
>>>   .../iio/common/hid-sensors/hid-sensor-attributes.c | 114 +++++++++++++++++++++
>>>   include/linux/hid-sensor-hub.h                     |   4 +
>>>   2 files changed, 118 insertions(+)
>>>
>>> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
>>> index 75b5473..451a95b 100644
>>> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
>>> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
>>> @@ -26,6 +26,40 @@
>>>   #include <linux/iio/iio.h>
>>>   #include <linux/iio/sysfs.h>
>>>
>>> +struct {
>>> +    u32 usage_id;
>>> +    int unit; /* 0 for default others from HID sensor spec */
>>> +    int scale_val0; /* scale, whole number */
>>> +    int scale_val1; /* scale, fraction in micros */
>>> +} unit_conversion[] = {
>>> +    {HID_USAGE_SENSOR_ACCEL_3D, 0, 9, 806650},
>>> +    {HID_USAGE_SENSOR_ACCEL_3D,
>>> +        HID_USAGE_SENSOR_UNITS_METERS_PER_SEC_SQRD, 1, 0},
>>> +    {HID_USAGE_SENSOR_ACCEL_3D,
>>> +        HID_USAGE_SENSOR_UNITS_G, 9, 806650},
>>> +
>>> +    {HID_USAGE_SENSOR_GYRO_3D, 0, 0, 17453},
>>> +    {HID_USAGE_SENSOR_GYRO_3D,
>>> +        HID_USAGE_SENSOR_UNITS_RADIANS_PER_SECOND, 1, 0},
>>> +    {HID_USAGE_SENSOR_GYRO_3D,
>>> +        HID_USAGE_SENSOR_UNITS_DEGREES_PER_SECOND, 0, 17453},
>>> +
>>> +    {HID_USAGE_SENSOR_COMPASS_3D, 0, 1000, 0},
>>> +    {HID_USAGE_SENSOR_COMPASS_3D, HID_USAGE_SENSOR_UNITS_GAUSS, 1, 0},
>>> +
>>> +    {HID_USAGE_SENSOR_INCLINOMETER_3D, 0, 17453, 0},
>>> +    {HID_USAGE_SENSOR_INCLINOMETER_3D,
>>> +        HID_USAGE_SENSOR_UNITS_DEGREES, 0, 17453},
>>> +    {HID_USAGE_SENSOR_INCLINOMETER_3D,
>>> +        HID_USAGE_SENSOR_UNITS_RADIANS, 1, 0},
>>> +
>>> +    {HID_USAGE_SENSOR_ALS, 0, 1, 0},
>>> +    {HID_USAGE_SENSOR_ALS, HID_USAGE_SENSOR_UNITS_LUX, 1, 0},
>>> +
>>> +    {HID_USAGE_SENSOR_PRESSURE, 0, 100000, 0},
>>> +    {HID_USAGE_SENSOR_PRESSURE, HID_USAGE_SENSOR_UNITS_PASCAL, 1, 0},
>>> +};
>>> +
>>>   static int pow_10(unsigned power)
>>>   {
>>>       int i;
>>> @@ -209,6 +243,86 @@ int hid_sensor_write_raw_hyst_value(struct hid_sensor_common *st,
>>>   }
>>>   EXPORT_SYMBOL(hid_sensor_write_raw_hyst_value);
>>>
>>> +/*
>>> + * This fuction applies the unit exponent to the scale.
>> function.
>>
>> Good examples btw.
>>> + * For example:
>>> + * 9.806650 ->exp:2-> val0[980]val1[6650]
>>> + * 9.000806 ->exp:2-> val0[900]val1[806]
>>> + * 0.174535 ->exp:2-> val0[17]val1[4535]
>>> + * 1.001745 ->exp:0-> val0[1]val1[1745]
>>> + * 1.001745 ->exp:2-> val0[100]val1[1745]
>>> + * 1.001745 ->exp:4-> val0[10017]val1[45]
>>> + * 9.806650 ->exp:-2-> val0[0]val1[98066]
>>> + */
>>> +static void adjust_exponent_micro(int *val0, int *val1, int scale0,
>>> +                  int scale1, int exp)
>>> +{
>>> +    int i;
>>> +    int x;
>>> +    int res;
>>> +    int rem;
>>> +
>>> +    if (exp > 0) {
>>> +        *val0 = scale0 * pow_10(exp);
>>> +        res = 0;
>>> +        if (exp > 6) {
>>> +            *val1 = 0;
>>> +            return;
>>> +        }
>>> +        for (i = 0; i < exp; ++i) {
>>> +            x = scale1 / pow_10(5 - i);
>>> +            res += (pow_10(exp - 1 - i) * x);
>>> +            scale1 = scale1 % pow_10(5 - i);
>>> +        }
>>> +        *val0 += res;
>>> +            *val1 = scale1 * pow_10(exp);
>>> +    } else if (exp < 0) {
>>> +        exp = abs(exp);
>>> +        if (exp > 6) {
>>> +            *val0 = *val1 = 0;
>>> +            return;
>>> +        }
>>> +        *val0 = scale0 / pow_10(exp);
>>> +        rem = scale0 % pow_10(exp);
>>> +        res = 0;
>>> +        for (i = 0; i < (6 - exp); ++i) {
>>> +            x = scale1 / pow_10(5 - i);
>>> +            res += (pow_10(5 - exp - i) * x);
>>> +            scale1 = scale1 % pow_10(5 - i);
>>> +        }
>>> +        *val1 = rem * pow_10(6 - exp) + res;
>>> +    } else {
>>> +        *val0 = scale0;
>>> +        *val1 = scale1;
>>> +    }
>>> +}
>>> +
>>> +int hid_sensor_format_scale(u32 usage_id,
>>> +            struct hid_sensor_hub_attribute_info *attr_info,
>>> +            int *val0, int *val1)
>>> +{
>>> +    int i;
>>> +    int exp;
>>> +
>>> +    *val0 = 1;
>>> +    *val1 = 0;
>>> +
>>> +    for (i = 0; ARRAY_SIZE(unit_conversion); ++i) {
>>> +        if (unit_conversion[i].usage_id == usage_id &&
>>> +            unit_conversion[i].unit == attr_info->units) {
>>> +            exp  = hid_sensor_convert_exponent(
>>> +                        attr_info->unit_expo);
>>> +            adjust_exponent_micro(val0, val1,
>>> +                    unit_conversion[i].scale_val0,
>>> +                    unit_conversion[i].scale_val1, exp);
>>> +            break;
>>> +        }
>>> +    }
>>> +
>>> +    return IIO_VAL_INT_PLUS_MICRO;
>>> +}
>>> +EXPORT_SYMBOL(hid_sensor_format_scale);
>>> +
>>>   int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
>>>                       u32 usage_id,
>>>                       struct hid_sensor_common *st)
>>> diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
>>> index b70cfd7..89626b2 100644
>>> --- a/include/linux/hid-sensor-hub.h
>>> +++ b/include/linux/hid-sensor-hub.h
>>> @@ -223,4 +223,8 @@ int hid_sensor_read_samp_freq_value(struct hid_sensor_common *st,
>>>   int hid_sensor_get_usage_index(struct hid_sensor_hub_device *hsdev,
>>>                   u32 report_id, int field_index, u32 usage_id);
>>>
>>> +int hid_sensor_format_scale(u32 usage_id,
>>> +                struct hid_sensor_hub_attribute_info *attr_info,
>>> +                int *val0, int *val1);
>>> +
>>>   #endif
>>>
>>
>>
>

