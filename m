Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <528EB575.7070700@linux.intel.com>
Date: Thu, 21 Nov 2013 17:37:57 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Jiri Kosina <jkosina@suse.cz>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: hid-sensors: Fix power and report state
References: <1381267963-14669-1-git-send-email-srinivas.pandruvada@linux.intel.com> <525C6ECA.4020404@kernel.org> <525C6FCE.9060909@linux.intel.com> <525D9047.6060902@kernel.org> <525D8ABF.6000504@linux.intel.com> <525D9AB1.6070709@kernel.org> <alpine.LNX.2.00.1311211023190.22082@pobox.suse.cz> <0c3f994c-174c-41c9-8cb7-c6dd26ec125e@email.android.com>
In-Reply-To: <0c3f994c-174c-41c9-8cb7-c6dd26ec125e@email.android.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 11/21/2013 12:06 PM, Jonathan Cameron wrote:
>
> Jiri Kosina <jkosina@suse.cz> wrote:
>> On Tue, 15 Oct 2013, Jonathan Cameron wrote:
>>
>>>>>>>> In the original HID sensor specifications all Named array enums
>>>>>>>> stated to be 0-based. But the most commercial devices
>> implemented
>>>>>>>> as 1-based, because of the implementation by one of the major
>> OS
>>>>>>>> vendor. To fix this we added a quirk, which required module to
>> be
>>>>>>>> recompiled. Instead now added a module parameter, so that it
>> can
>>>>>>>> be switched at runtime. By default it will be 1-based to be
>>>>>>>> compatible with majority of devices. This is true for both
>> power
>>>>>>>> and report state usage id for hid sensors. Also added defines
>> for
>>>>>>>> power on values for D0 to D4 and using it for clarity.
>>>>>>>>
>>>>>>>> Signed-off-by: Srinivas Pandruvada
>> <srinivas.pandruvada@linux.intel.com>
>>>>>>> This looks fine but raises a few questions...
>>>>>>>
>>>>>>> What other options do we have for controlling this?  Are hid
>> sensors
>>>>>>> chips identifiable? If so can we have a list of chips where it
>> is 0 in
>>>>>>> the driver.  The module parameter might still be needed to deal
>> with new
>>>>>>> devices but would be nice to have most work out of the box.
>>>>>> We could have quirk based on vendor id/pid. But the problem is
>> that once they update FW to be compliant with WIN8, it
>>>>>> will not work.
>>>>>> So there is no way to distinguish. Since sensor hub is present in
>> most of WIN8 convertible devices, the quirk became a
>>>>>> new normal.
>>>>> Yuck.  You have my sympathies!
>>>>>
>>>>>>> Got to love it when the quirk becomes the default ;)
>>>>>> Unfortunately they don't go back to specification update after
>> such change.
>>>>> Just to check, is this quirk only hid-sensors related?  Named
>> arrays are
>>>>> as far as I can see a part of HID in general.
>>>> Currently I have information about HID sensors implementation only
>> as they are in new in the WIN8. I didn't hear any
>>>> complaint about any other HID devices.
>>> Jiri, have you seen anything similar to this before.
>>>
>>> I am just trying to work out if it should be a Hid quirk or should be
>>> handled only in the hid-sensors module.
>> Sorry for super-late response from me, I have been drowned in other
>> things.
>>
>> This looks indeed pretty bad. I don't have a strong objection to having
>>
>> this as a generic HID quirk; the argument being, if this was made
>> de-facto
>> Win8-mandated standard, odds are that we'd start seeing a lot of
>> devices
>> with this behavior.
>>
>> So if you decide to take this way, please send the patch to me, I'll
>> apply
>> it.
> Thanks for the reply Jiri. That was pretty much what I was expecting.
>
> Srinivas, please rework this as a generic his quirk.

The problem I have is identify NAry data if we implement as a common hid 
quirk. If I can identify, then in hid_set_field,
I can increment the requested value by 1 if the hid_device->quirk is set 
for enum base quirk.

But from the report descriptor there is no way to tell it is a named 
array. For example for the following
report descriptor for setting power state, which by spec is a named 
array with selectors.

 From report descriptor:

HID_USAGE_SENSOR_PROPERTY_POWER_STATE, // NAry
HID_LOGICAL_MIN_8(0),
HID_LOGICAL_MAX_8(5),
HID_REPORT_SIZE(8),
HID_REPORT_COUNT(1),
HID_COLLECTION(Logical),
     HID_USAGE_SENSOR_PROPERTY_POWER_STATE_UNDEFINED,
     HID_USAGE_SENSOR_PROPERTY_POWER_STATE_D0_FULL_POWER,
     HID_USAGE_SENSOR_PROPERTY_POWER_STATE_D1_LOW_POWER,
     HID_USAGE_SENSOR_PROPERTY_POWER_STATE_D2_STANDBY_WITH_WAKE,
     HID_USAGE_SENSOR_PROPERTY_POWER_STATE_D3_SLEEP_WITH_WAKE,
     HID_USAGE_SENSOR_PROPERTY_POWER_STATE_D4_POWER_OFF,
     HID_FEATURE(Data_Arr_Abs),
HID_END_COLLECTION,

The HID core spec allows only collection to be typed as named arrays. 
But as
you can see the report descriptor still names this as COLLECTION(Logical).
If it is collection defined as HID_COLLECTION(NAMED_ARRAY), it is very 
easy to implement a
quirk at HID level. Unfortunately the logical minimum and maximum also 
don't really
show correct values accommodating the enum base.

One way to do this is by adding a quirk field in hid_field structure 
also. This way, quirk can be
enabled on a per field basis. Then we can have a common hid quirk at a 
device level and also individual field level.

Jiri, Do you have some suggestion?

Thanks,
Srinivas




>> Thanks,
