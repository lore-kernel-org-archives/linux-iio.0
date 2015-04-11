Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41401 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754856AbbDKSjY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 11 Apr 2015 14:39:24 -0400
Message-ID: <55296A38.3000101@kernel.org>
Date: Sat, 11 Apr 2015 19:38:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: sathyanarayanan.kuppuswamy@linux.intel.com, pmeerw@pmeerw.net
CC: linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH v3 2/6] iio: documentation: Add ABI info for iio event
 persistence filter
References: <cover.1428537814.git.sathyanarayanan.kuppuswamy@linux.intel.com> <d6ed572de5978b1ab44f0bd72432b8eeeac0b321.1428537814.git.sathyanarayanan.kuppuswamy@linux.intel.com> <5526556A.1080609@kernel.org> <55270BAD.7030509@linux.intel.com> <89459E86-2FB9-4AC1-AF90-8C742C18D000@kernel.org> <55281BE4.4040208@linux.intel.com>
In-Reply-To: <55281BE4.4040208@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/04/15 19:52, sathyanarayanan kuppuswamy wrote:
> 
> Hi Jonathan,
> 
> Thanks for the comments. Comments inline.
Hi again,
> 
> On 04/09/2015 10:58 PM, Jonathan Cameron wrote:
>>
>> On 10 April 2015 00:30:53 BST, sathyanarayanan kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>>
>>> On 04/09/2015 03:33 AM, Jonathan Cameron wrote:
>>>> On 09/04/15 01:06, Kuppuswamy Sathyanarayanan wrote:
>>>>> Add ABI info for iio event persistence filter.
>>>>>
>>>>> Setting <n> to persistence filter would need atleast
>>>>> <n> data values outside the upper/lower threshold
>>>>> limits before generating an interrupt.
>>>>>
>>>>> Signed-off-by: Kuppuswamy Sathyanarayanan
>>> <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>>> ---
>>>>>    Documentation/ABI/testing/sysfs-bus-iio | 82
>>> +++++++++++++++++++++++++++++++++
>>>>>    1 file changed, 82 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio
>>> b/Documentation/ABI/testing/sysfs-bus-iio
>>>>> index 9a70c31..590b1d4 100644
>>>>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>>>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>>>>> @@ -856,6 +856,88 @@ Description:
>>>>>            met before an event is generated. If direction is not
>>>>>            specified then this period applies to both directions.
>>>>>    
>>>> Please don't mass document cases unless they are actually in use.
>>> These should
>>>> get added as and when they become so.  Often a particular type of
>>> event
>>>> characteristic is actually only implemented on a small subset of
>>> channel types
>>>> (where it makes sense).
>>> IMO, persistence filter can be applied for all these cases. But if you
>>> think its better to
>>> add ABI for what we currently use then I will leave only ALS/proxmity
>>> related ABI's here.
>>>
>>> +What:        /sys/.../events/in_intensity0_thresh_persistence
>>> +What:        /sys/.../events/in_proximity0_thresh_persistence
>>>
>>>>> +What:        /sys/.../events/in_accel_x_thresh_rising_persistence
>>>>> +What:        /sys/.../events/in_accel_x_thresh_falling_persistence
>>>>> +hat:        /sys/.../events/in_accel_x_roc_rising_persistence
>>>>> +What:        /sys/.../events/in_accel_x_roc_falling_persistence
>>>>> +What:        /sys/.../events/in_accel_y_thresh_rising_persistence
>>>>> +What:        /sys/.../events/in_accel_y_thresh_falling_persistence
>>>>> +What:        /sys/.../events/in_accel_y_roc_rising_persistence
>>>>> +What:        /sys/.../events/in_accel_y_roc_falling_persistence
>>>>> +What:        /sys/.../events/in_accel_z_thresh_rising_persistence
>>>>> +What:        /sys/.../events/in_accel_z_thresh_falling_persistence
>>>>> +What:        /sys/.../events/in_accel_z_roc_rising_persistence
>>>>> +What:        /sys/.../events/in_accel_z_roc_falling_persistence
>>>>> +What:        /sys/.../events/in_anglvel_x_thresh_rising_persistence
>>>>> +What:        /sys/.../events/in_anglvel_x_thresh_falling_persistence
>>>>> +What:        /sys/.../events/in_anglvel_x_roc_rising_persistence
>>>>> +What:        /sys/.../events/in_anglvel_x_roc_falling_persistence
>>>>> +What:        /sys/.../events/in_anglvel_y_thresh_rising_persistence
>>>>> +What:        /sys/.../events/in_anglvel_y_thresh_falling_persistence
>>>>> +What:        /sys/.../events/in_anglvel_y_roc_rising_persistence
>>>>> +What:        /sys/.../events/in_anglvel_y_roc_falling_persistence
>>>>> +What:        /sys/.../events/in_anglvel_z_thresh_rising_persistence
>>>>> +What:        /sys/.../events/in_anglvel_z_thresh_falling_persistence
>>>>> +What:        /sys/.../events/in_anglvel_z_roc_rising_persistence
>>>>> +What:        /sys/.../events/in_anglvel_z_roc_falling_persistence
>>>>> +What:        /sys/.../events/in_magn_x_thresh_rising_persistence
>>>>> +What:        /sys/.../events/in_magn_x_thresh_falling_persistence
>>>>> +What:        /sys/.../events/in_magn_x_roc_rising_persistence
>>>>> +What:        /sys/.../events/in_magn_x_roc_falling_persistence
>>>>> +What:        /sys/.../events/in_magn_y_thresh_rising_persistence
>>>>> +What:        /sys/.../events/in_magn_y_thresh_falling_persistence
>>>>> +What:        /sys/.../events/in_magn_y_roc_rising_persistence
>>>>> +What:        /sys/.../events/in_magn_y_roc_falling_persistence
>>>>> +What:        /sys/.../events/in_magn_z_thresh_rising_persistence
>>>>> +What:        /sys/.../events/in_magn_z_thresh_falling_persistence
>>>>> +What:        /sys/.../events/in_magn_z_roc_rising_persistence
>>>>> +What:        /sys/.../events/in_magn_z_roc_falling_persistence
>>>>>
>>> +What:        /sys/.../events/in_rot_from_north_magnetic_thresh_rising_persistence
>>> +What:        /sys/.../events/in_rot_from_north_magnetic_thresh_falling_persistence
>>> +What:        /sys/.../events/in_rot_from_north_magnetic_roc_rising_persistence
>>> +What:        /sys/.../events/in_rot_from_north_magnetic_roc_falling_persistence
>>> +What:        /sys/.../events/in_rot_from_north_true_thresh_rising_persistence
>>> +What:        /sys/.../events/in_rot_from_north_true_thresh_falling_persistence
>>> +What:        /sys/.../events/in_rot_from_north_true_roc_rising_persistence
>>> +What:        /sys/.../events/in_rot_from_north_true_roc_falling_persistence
>>> +What:        /sys/.../events/in_rot_from_north_magnetic_tilt_comp_thresh_rising_persistence
>>> +What:        /sys/.../events/in_rot_from_north_magnetic_tilt_comp_thresh_falling_persistence
>>> +What:        /sys/.../events/in_rot_from_north_magnetic_tilt_comp_roc_rising_persistence
>>> +What:        /sys/.../events/in_rot_from_north_magnetic_tilt_comp_roc_falling_persistence
>>> +What:        /sys/.../events/in_rot_from_north_true_tilt_comp_thresh_rising_persistence
>>> +What:        /sys/.../events/in_rot_from_north_true_tilt_comp_thresh_falling_persistence
>>> +What:        /sys/.../events/in_rot_from_north_true_tilt_comp_roc_rising_persistence
>>> +What:        /sys/.../events/in_rot_from_north_true_tilt_comp_roc_falling_persistence
>>>>> +What:        /sys/.../events/in_voltageY_supply_thresh_rising_persistence
>>>>>
>>> +What:        /sys/.../events/in_voltageY_supply_thresh_falling_persistence
>>>>> +What:        /sys/.../events/in_voltageY_supply_roc_rising_persistence
>>>>> +What:        /sys/.../events/in_voltageY_supply_roc_falling_persistence
>>>>> +What:        /sys/.../events/in_voltageY_thresh_rising_persistence
>>>>> +What:        /sys/.../events/in_voltageY_thresh_falling_persistence
>>>>> +What:        /sys/.../events/in_voltageY_roc_rising_persistence
>>>>> +What:        /sys/.../events/in_voltageY_roc_falling_persistence
>>>>> +What:        /sys/.../events/in_tempY_thresh_rising_persistence
>>>>> +What:        /sys/.../events/in_tempY_thresh_falling_persistence
>>>>> +What:        /sys/.../events/in_tempY_roc_rising_persistence
>>>>> +What:        /sys/.../events/in_tempY_roc_falling_persistence
>>>>> +What:        /sys/.../events/in_accel_x&y&z_mag_falling_persistence
>>>>> +What:        /sys/.../events/in_intensity0_thresh_persistence
>>>>> +What:        /sys/.../events/in_proximity0_thresh_persistence
>>>>> +What:        /sys/.../events/in_activity_still_thresh_rising_persistence
>>>>> +What:        /sys/.../events/in_activity_still_thresh_falling_persistence
>>>>>
>>> +What:        /sys/.../events/in_activity_walking_thresh_rising_persistence
>>> +What:        /sys/.../events/in_activity_walking_thresh_falling_persistence
>>> +What:        /sys/.../events/in_activity_jogging_thresh_rising_persistence
>>> +What:        /sys/.../events/in_activity_jogging_thresh_falling_persistence
>>> +What:        /sys/.../events/in_activity_running_thresh_rising_persistence
>>> +What:        /sys/.../events/in_activity_running_thresh_falling_persistence
>>>>> +KernelVersion:    4.0
>>>>> +Contact:    linux-iio@vger.kernel.org
>>>>> +Description:
>>>>> +        Number of times an event should occur before generating an
>>>>> +        interrupt. Persistence filter value can be applied for both
>>>>> +        rising/falling threshold based interrupts.
>>>> This still needs clarification as reading the discussion I'm still a
>>> little unsure
>>>> what the condition is.  I don't think Lars' original query ever got
>>> cleanly answered
>>> Sorry for being unclear. Even in this case, the use case is "number of
>>> consecutive" measurement data
>>> outside the range.
>>>> Taking just the upper threshold...
>>>> The interpretations I can think of are:
>>>>
>>>> 1) tsl2591 use case (maps directly to period with the sampling
>>> frequency taken into
>>>> account).
>>>>    - Too much light for N ALS cycling samples.  If it drops below the
>>> threshold
>>>>      the count is reset.
>>>> the tcs part that Daniel referenced is also this use case.
>>> I agree that it can be mapped to _period if you take the sampling
>>> frequency into account. But if you do that then it becomes dependent on
>>>
>>> integration time ( for ALS case). Since _period is calculated based on
>>> frequency, each time you change _integration_time then internally you
>>> need to change the _period value to keep the ratio constant. Also you
>>> need to consider what happens if your frequency > period. I think this
>>> makes is bit complicated.
>> Indeed. Such is life. This isn't the first such case and it won't be the last where
>>   the driver becomes more complex to conform to the existing ABI.
> If its just the driver complexity then I would completely agree with
> you. My concern is, we are expecting the user to consider these
> factors before changing the value on either frequency/period.
Think of likely usecases for persistence. It's about avoiding getting
too many events for light level changes.  Two reasons for this
1) Wastes power and time on processor handling them.
2) Userspace will end up doing dumb things like changing screen brightness
in response to ever event.

Conceptually both of these want a time / frequency based control, not
one that is dependent on the number of times the device happens to
sample the sensor.

So if you put your persistence measurement in and the integration time
is changing regularly, then all you have done is to move the problem
into userspace which will have to constant change the persistence value
instead.

The point I am trying to make is the complexity and predictability
argument swings both ways.
> 
> If this dependency is due to the hardware then it would make sense
> for expecting the user to follow them. But here we are creating a
> logical dependency between persistence and sampling frequency to
> avoid the software complexity.
It is due to hardware. The hardware could have exposed this as
a time based element.  It chose not to because of a hardware 
design decision. 

We have numerous cases of this - often devices have a sampling frequency
that is based on number of clock cycles of some supplied clock.  Or a
low pass filter that is based on the number of sampling cycles, just
like your persistence.  We define these in terms of time, because
we had to choose to either do it in samples, or in time and userspace
is far more interested (most of the time) in the time based one.
Honestly most users of sensors, couldn't care less what the sampling
frequency is, they care how often (in units of time) they get their update.

> 
> If you read the data sheet, there is no relation between persistence
> and sampling frequency. But when using the interfaces, the user
> should understand the ABI dependency created in software.
Exactly so we are calling it period.  It is related to the
datasheet defined persistence by being multiplied persistence
by the sampling frequency. 

What I don't want is a random mixture of period and persistence based
on the way it was documented in datasheets.  These are the same thing.
The only difference is the unit (at a given setting).
Honestly the term persistence is
well defined as being i
>From an ABI point of view, we couldn't care less what the underlying
hardware is doing, what we care about is not have two interfaces for
the same thing. Period is there, it is defined and in use, so that
is what we are going to stick with

Yes it's painful. I've written a good amount of code myself
to deal with unifying the different approaches different hardware
takes to a given problem. It's fiddly but what is the point of
a unified interface if we don't put the work in to keep it
consistent.

Sorry, this is one of the main roles of a maintainer:
Keeping expose ABI consistent and minimal.

Jonathan
>>
>>> Don't you think its better to add another representation instead of
>>> trying to fit it in existing ABI's ?
>> No
>> This is a common situation. All over the place we have cases where changing one
>>   abi element effects the value of another.
>> We cope with it to provide a consistent
>>   and minimal interface to userspace.
>> Where the sampling frequency is directly
>>   controlled it is perfectly acceptable to not automatically adjust the period.
>> We frequently rely on the rule that userspce must check all attrs if it changes any.
>>> Following are the persistence filter descriptions from data sheets of
>>> tsl2591 and ltr501.
>>>
>>> LTR501: " The INTERRUPT PERSIST register controls the N number of times
>>>
>>> the measurement data is outside the range defined by the upper and
>>> lower
>>> threshold limits before asserting the INT".
>>> TSL2591: " The Interrupt persistence filter sets the number of
>>> consecutive out-of-range ALS cycles necessary to generate an interrupt"
>>>
>>>> 2) A new option which doesn't take account of the signal dropping
>>> below the threshold.
>>>>      So a count of number of times above the threshold.
>>>>    i.e. On each cycle, if over threshold, increment N.
>>>>         Evaluate if N is greater than 'persistence' then trigger an
>>> event.
>>>>     Why this would ever make sense on a light sensor is beyond me ;)
>>> but there
>>>>     we are.  We have a related abi for in_steps_change_value, which
>>> fires
>>>>     an event, only every N steps.  It doesn't really adapt to this
>>> case though.
>>>>     The name persistence is definitely misleading if this is what the
>>> liteon parts
>>>>     do as that definitely implies case 1).
>>>>
>>>> Welcome to my life, bludgeoning what appears to new ABI into what we
>>> already have!
>>>> (not a lot of point in standardized ABI otherwise!)
>>>>
>>>> Jonathan
>>>>
>>>>
>>>>> +
>>>>>    What:        /sys/.../events/in_activity_still_thresh_rising_en
>>>>>    What:        /sys/.../events/in_activity_still_thresh_falling_en
>>>>>    What:        /sys/.../events/in_activity_walking_thresh_rising_en
>>>>>
> 

