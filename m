Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <525D8ABF.6000504@linux.intel.com>
Date: Tue, 15 Oct 2013 11:34:39 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: hid-sensors: Fix power and report state
References: <1381267963-14669-1-git-send-email-srinivas.pandruvada@linux.intel.com> <525C6ECA.4020404@kernel.org> <525C6FCE.9060909@linux.intel.com> <525D9047.6060902@kernel.org>
In-Reply-To: <525D9047.6060902@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 10/15/2013 11:58 AM, Jonathan Cameron wrote:
> On 10/14/13 23:27, Srinivas Pandruvada wrote:
>> On 10/14/2013 03:23 PM, Jonathan Cameron wrote:
>>> On 10/08/13 22:32, Srinivas Pandruvada wrote:
>>>> In the original HID sensor specifications all Named array enums stated
>>>> to be 0-based. But the most commercial devices implemented as 1-based,
>>>> because of the implementation by one of the major OS vendor. To fix this
>>>> we added a quirk, which required module to be recompiled. Instead now
>>>> added a module parameter, so that it can be switched at runtime.
>>>> By default it will be 1-based to be compatible with majority of devices.
>>>> This is true for both power and report state usage id for hid sensors.
>>>> Also added defines for power on values for D0 to D4 and using it for
>>>> clarity.
>>>>
>>>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>>> This looks fine but raises a few questions...
>>>
>>> What other options do we have for controlling this?  Are hid sensors
>>> chips identifiable? If so can we have a list of chips where it is 0 in
>>> the driver.  The module parameter might still be needed to deal with new
>>> devices but would be nice to have most work out of the box.
>> We could have quirk based on vendor id/pid. But the problem is that once they update FW to be compliant with WIN8, it
>> will not work.
>> So there is no way to distinguish. Since sensor hub is present in most of WIN8 convertible devices, the quirk became a
>> new normal.
> Yuck.  You have my sympathies!
>
>>> Got to love it when the quirk becomes the default ;)
>> Unfortunately they don't go back to specification update after such change.
> Just to check, is this quirk only hid-sensors related?  Named arrays are
> as far as I can see a part of HID in general.
Currently I have information about HID sensors implementation only as 
they are in new in the WIN8. I didn't hear any complaint about any other 
HID devices.

Thanks,
Srinivas
>
>>>> ---
>>>>    drivers/iio/common/hid-sensors/Kconfig             |  9 --------
>>>>    .../iio/common/hid-sensors/hid-sensor-trigger.c    | 26 +++++++++++++++++-----
>>>>    include/linux/hid-sensor-ids.h                     | 12 ++++++++++
>>>>    3 files changed, 33 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/common/hid-sensors/Kconfig b/drivers/iio/common/hid-sensors/Kconfig
>>>> index 1178121..39188b7 100644
>>>> --- a/drivers/iio/common/hid-sensors/Kconfig
>>>> +++ b/drivers/iio/common/hid-sensors/Kconfig
>>>> @@ -25,13 +25,4 @@ config HID_SENSOR_IIO_TRIGGER
>>>>          If this driver is compiled as a module, it will be named
>>>>          hid-sensor-trigger.
>>>>    -config HID_SENSOR_ENUM_BASE_QUIRKS
>>>> -    bool "ENUM base quirks for HID Sensor IIO drivers"
>>>> -    depends on HID_SENSOR_IIO_COMMON
>>>> -    help
>>>> -      Say yes here to build support for sensor hub FW using
>>>> -      enumeration, which is using 1 as base instead of 0.
>>>> -      Since logical minimum is still set 0 instead of 1,
>>>> -      there is no easy way to differentiate.
>>>> -
>>>>    endmenu
>>>> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>>>> index b6e77e0..dbc9141 100644
>>>> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>>>> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>>>> @@ -28,21 +28,37 @@
>>>>    #include <linux/iio/sysfs.h>
>>>>    #include "hid-sensor-trigger.h"
>>>>    +#define    HID_SENSOR_NAMED_ARRAY_BASE    1
>>>> +static int hid_sensor_named_array_base = HID_SENSOR_NAMED_ARRAY_BASE;
>>>> +module_param(hid_sensor_named_array_base, int, 0644);
>>>> +MODULE_PARM_DESC(hid_sensor_named_array_base,
>>>> +    "HID SENSOR NAMED ARRAY BASE (0 or 1).");
>>>> +
>>>>    static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
>>>>                            bool state)
>>>>    {
>>>>        struct hid_sensor_common *st = iio_trigger_get_drvdata(trig);
>>>>        int state_val;
>>>> +    int report_state;
>>>>          if (state) {
>>>>            if (sensor_hub_device_open(st->hsdev))
>>>>                return -EIO;
>>>> -    } else
>>>> +        state_val =
>>>> +        HID_USAGE_SENSOR_PROP_POWER_STATE_D0_FULL_POWER_ENUM;
>>>> +        report_state =
>>>> +        HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM;
>>>> +    } else {
>>>>            sensor_hub_device_close(st->hsdev);
>>>> -
>>>> -    state_val = state ? 1 : 0;
>>>> -    if (IS_ENABLED(CONFIG_HID_SENSOR_ENUM_BASE_QUIRKS))
>>>> +        state_val =
>>>> +        HID_USAGE_SENSOR_PROP_POWER_STATE_D4_POWER_OFF_ENUM;
>>>> +        report_state =
>>>> +        HID_USAGE_SENSOR_PROP_REPORTING_STATE_NO_EVENTS_ENUM;
>>>> +    }
>>>> +    if (hid_sensor_named_array_base) {
>>>>            ++state_val;
>>>> +        ++report_state;
>>>> +    }
>>>>        st->data_ready = state;
>>>>        sensor_hub_set_feature(st->hsdev, st->power_state.report_id,
>>>>                        st->power_state.index,
>>>> @@ -50,7 +66,7 @@ static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
>>>>          sensor_hub_set_feature(st->hsdev, st->report_state.report_id,
>>>>                        st->report_state.index,
>>>> -                    (s32)state_val);
>>>> +                    (s32)report_state);
>>>>          return 0;
>>>>    }
>>>> diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
>>>> index 4f945d3..8323775 100644
>>>> --- a/include/linux/hid-sensor-ids.h
>>>> +++ b/include/linux/hid-sensor-ids.h
>>>> @@ -117,4 +117,16 @@
>>>>    #define HID_USAGE_SENSOR_PROP_REPORT_STATE            0x200316
>>>>    #define HID_USAGE_SENSOR_PROY_POWER_STATE            0x200319
>>>>    +/* Power state enumerations */
>>>> +#define HID_USAGE_SENSOR_PROP_POWER_STATE_UNDEFINED_ENUM        0x00
>>>> +#define HID_USAGE_SENSOR_PROP_POWER_STATE_D0_FULL_POWER_ENUM        0x01
>>>> +#define HID_USAGE_SENSOR_PROP_POWER_STATE_D1_LOW_POWER_ENUM        0x02
>>>> +#define HID_USAGE_SENSOR_PROP_POWER_STATE_D2_STANDBY_WITH_WAKE_ENUM    0x03
>>>> +#define HID_USAGE_SENSOR_PROP_POWER_STATE_D3_SLEEP_WITH_WAKE_ENUM    0x04
>>>> +#define HID_USAGE_SENSOR_PROP_POWER_STATE_D4_POWER_OFF_ENUM        0x05
>>>> +
>>>> +/* Report State enumerations */
>>>> +#define HID_USAGE_SENSOR_PROP_REPORTING_STATE_NO_EVENTS_ENUM        0x00
>>>> +#define HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM        0x01
>>>> +
>>>>    #endif
>>>>
>> Thanks,
>> Srinivas
>>
