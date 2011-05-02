Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4DBE652E.2040800@analog.com>
Date: Mon, 2 May 2011 10:02:54 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Jean Delvare <khali@linux-fr.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, Drivers <Drivers@analog.com>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>, Guenter Roeck
	<guenter.roeck@ericsson.com>
Subject: Re: [Device-drivers-devel] Oddities and how to handle them.
References: <4DB6EF2D.9090704@cam.ac.uk>	<4DB7FEE8.3080004@analog.com>	<4DB82B5C.5070900@cam.ac.uk>	<544AC56F16B56944AEC3BD4E3D5917713AAEE15859@LIMKCMBX1.ad.analog.com>	<4DB8322A.6050207@cam.ac.uk>	<544AC56F16B56944AEC3BD4E3D5917713AAEE15A62@LIMKCMBX1.ad.analog.com>	<4DB933E3.8070803@cam.ac.uk>	<20110428155118.041b84f2@endymion.delvare> <4DB977F2.7090002@cam.ac.uk> <4DB980A0.4040506@analog.com> <4DB98BE8.9060301@cam.ac.uk> <4DBAC97E.1090901@analog.com> <4DBAD336.3080006@cam.ac.uk>
In-Reply-To: <4DBAD336.3080006@cam.ac.uk>
Content-Type: text/plain; charset="ISO-8859-1"
List-ID: <linux-iio@vger.kernel.org>

On 04/29/2011 05:03 PM, Jonathan Cameron wrote:
> On 04/29/11 15:21, Michael Hennerich wrote:
>   
>> On 04/28/2011 05:46 PM, Jonathan Cameron wrote:
>>     
>>> On 04/28/11 15:58, Michael Hennerich wrote:
>>>
>>>       
>>>> On 04/28/2011 04:21 PM, Jonathan Cameron wrote:
>>>>
>>>>         
>>>>> On 04/28/11 14:51, Jean Delvare wrote:
>>>>>
>>>>>
>>>>>           
>>>>>> On Thu, 28 Apr 2011 10:31:15 +0100, Jonathan Cameron wrote:
>>>>>>
>>>>>>
>>>>>>             
>>>>>>> Guenter / Jean - cc'd you two because we have an sysfs interface naming question for
>>>>>>> AC sensors that touches on the edge of hwmon.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>               
>>>>>>>> For the metering parts I think we need to define a few more channel types.
>>>>>>>>
>>>>>>>> How about this ones
>>>>>>>>
>>>>>>>> inSX            S is the apparent power.
>>>>>>>> inPX            P is the active power.
>>>>>>>> inQX            Q is the reactive power.
>>>>>>>> inVX            V is the voltage. (only inX ?)
>>>>>>>> inVRMSX VRMS is the quadratic mean voltage.
>>>>>>>>
>>>>>>>>
>>>>>>>>                 
>>>>>>> Call it 'root mean square' rather than quadratic in the docs. They have different
>>>>>>> meanings in English.
>>>>>>>
>>>>>>>
>>>>>>>               
>>>>>>>> inIX            I is the current.
>>>>>>>>
>>>>>>>>
>>>>>>>>                 
>>>>>>> currX as per hwmon?  They also define a power attribute, but only 1 (as DC
>>>>>>> I guess). Cc'd Guenter and Jean to see if we can / want to share an interface...
>>>>>>>
>>>>>>> Guenter/ Jean, do you think hwmon will ever handle AC sensors?
>>>>>>>
>>>>>>>
>>>>>>>               
>>>>>> Well, never say never ;) While I've never heard of such sensors, I
>>>>>> guess it would make some sense for a computer PSU to include a sensor
>>>>>> chip monitoring both the AC input and the DC output to measure the
>>>>>> efficiency of the unit.
>>>>>>
>>>>>>
>>>>>>
>>>>>>             
>>>>>>> Maybe we want to be
>>>>>>> well clear of your interfaces just to avoid confusion? Or define a new set of shared
>>>>>>> names for the above that we will both use (when it becomes relevant?)
>>>>>>>
>>>>>>>
>>>>>>>               
>>>>>> It's hard to tell in advance what hwmon would implement, as we lack
>>>>>> actual examples. All I can say is that we would never use "in" prefixes
>>>>>> for power or current. The above power examples would most probably be
>>>>>> named powerX_apparent_input, powerX_active_input and
>>>>>> powerX_reactive_input, if we ever have to support these. And
>>>>>> inX_rms_input for the root mean square voltage input.
>>>>>>
>>>>>> But then again, I'm not sure if there is any point in sharing anything,
>>>>>> or forcing any difference, between hwmon and iio interfaces. They are
>>>>>> different by nature, and if we don't strictly enforce their relation,
>>>>>> they are bound to randomly diverge and converge anyway.
>>>>>>
>>>>>>
>>>>>>
>>>>>>             
>>>>> Agreed to a certain extent, but saying that there is no point in reinventing
>>>>> the wheel.  I think the naming you've just suggested is clearer anyway.
>>>>>
>>>>> Ultimately I don't insist on keeping to your interfaces when it really doesn't
>>>>> make sense, but when it does, it makes our life easier as we aren't starting from
>>>>> scratch. Also, politically it was suggested we do this by a few people I'd like
>>>>> to keep on side.
>>>>>
>>>>> Michael - howabout doing the rms values as done with peak_raw - as chan info parameters
>>>>> (directly derived from raw values anyway).
>>>>>
>>>>>
>>>>>           
>>>> I don't understand - why would the RMS value being a _raw value?
>>>> V and Vrms are calculated inside the metering IC.
>>>> And so far we use the _raw stuff only if the value needs to be scaled
>>>> somehow.
>>>>
>>>>         
>>> So these are already in Volts? (or I guess millivolts?)
>>>
>>>       
>> Need to check the exact data representation.
>> There are offset and gain control registers associated. Ideally they are
>> properly set and then we get the voltage in millivolts.
>> The none RMS values are the absolute voltages that get sampled into the
>> ring buffer.
>> The RMS voltages are calculated inside the part and provided to the user
>> as sysfs attributes files.
>>     
> Cool. In that case we don't need the raw.  However, we do perhaps need to make it
> clear it is processed and put _input at the end instead...
>   
>>     
>>> Surely they need the same scaling as in0_raw?
>>>
>>>       
>>>>
>>>>         
>>>>> Then define two new (to us) channel types.
>>>>>
>>>>> IIO_CURRENT = "curr%d"
>>>>> IIO_POWER = "curr%d"
>>>>>
>>>>>
>>>>>           
>>>> power?
>>>>
>>>>         
>>> Oopsy.
>>>
>>>       
>>>>> Using the rfc I'm going to post after I send this email, we can add additional names to a channel.
>>>>> The only slight annoyance is the 3 power values will need to be different channels, so under that
>>>>> we will have:
>>>>>
>>>>> power0_apparent_raw           is the apparent power.
>>>>> power1_active_raw             is the active power.
>>>>> power2_reactive_raw           is the reactive power.
>>>>> in0                           is the voltage.
>>>>>
>>>>>
>>>>>           
>>>> If we want to be more verbose, why do we use 'in' for voltage and not
>>>> voltageX ?
>>>>
>>>>         
>>> Matching hwmon, Greg KH and others pushed for this early on. I didn't care
>>> really as long as it didn't get in the way.  So when you get down to
>>> it combination of trying to limit variation of interfaces in kernel
>>> and politics.  Jean has always argued (as here) that it probably isn't
>>> going to work anyway!
>>>
>>>       
>> IIO and HWMON servers different purposes. I think we already got to the
>> point of divergent interfaces.
>>     
> True.  But so far it is only for things where we really have to do so,
> such as threshold interrupts.  Hwmon's alarms are fine for their usecases
> but only cover a fraction of what we have on inertial sensors for starters.
> (as you'd expect)
>   
>>     
>>>       
>>>> It looks to me we're messing something up here. For DACs we use outX for
>>>> voltage!
>>>> I think we have to come up with something that allows us to specify
>>>> whether something is an output or input.
>>>>
>>>>         
>>> We could prefix all inputs with in and all outputs with out, assuming
>>> we move voltages out of the way. Ultimately we didn't have any output
>>> devices when we started hammering the interfaces into shape.
>>>
>>>       
>> That sounds right to me.
>>     
> We may need to do this gradually, or on the move from staging out into the
> main tree.  Whilst we are in staging, I know there are mainstream users
> of a few drivers.  Perhaps we just support old interface for them on a
> case by case basis.
>
> This will want a full proposal to lkml.
>   
>>>       
>>>> In addition we need to proper naming for what is input or output -
>>>> current, voltage, etc.
>>>>
>>>> The three power values can't be three different channels.
>>>> They are alternatives all on the same physical input channel, and the
>>>> naming should express this.
>>>>
>>>>         
>>> Then it will have to be as modifiers.  Right now we tend to use them to
>>> group things.  So for accelerometers we can in theory have:
>>>
>>> accel0_x,
>>> accel0_y,
>>> accel1_x, etc. for chips implementing more than one sensor in a given
>>> direction.
>>>
>>> If we insist on same number meaning same physical ping then for typical
>>> inertial sensor the channel number would have to be unique.
>>> Thus take adis16400 we would need.
>>>
>>> in0_supply_raw
>>> gyro1_x_raw
>>> gyro2_y_raw
>>> gyro3_z_raw
>>> accel4_x_raw
>>> etc...
>>> which, whilst looking odd, wouldn't be a fundamental problem.
>>>
>>>       
>> Agreed - that looks odd. And yes modifiers should work as well.
>> So we get to -
>>
>> in_powerX_Y_apparent_raw
>>
>> in_volatgeX_Y_rms_raw
>>
>> or
>>
>> inX_powerY_apparent_raw
>> inX_volatgeY_rms_raw
>> outX_volatgeY_raw
>>
>>     
> I'm a little confused on what the Y is?  I would imagine we can only have
> one apparent power measure per channel.  The modifier will be into an enum
> associated with that 'apparent' label, much as we have 'x'
> for axis in devices where that makes sense.  We may want to move away from
> the passing a character approach for those modifiers as well so we have
> just one path.
>   

Hi Jonathan,

I'm now getting confused as well.
Yes one apparent power measure per channel is enough.
Didn't you say that the 3 power values will need to be different channels?
My point was that we need a modifier that identifies the physical
input/output channel.

>> ?
>>     
>>>>         
>>>>> in0_rms_raw                   is the rms voltage.
>>>>> curr0_raw                     is the current.
>>>>>
>>>>> We may want to think about how to indicate which of these are measured on the same physical pin.
>>>>> If we were to have all the power measures as power0_* then we need another way of differentiating
>>>>> their event codes.  Could use modifiers I suppose... I've just sanity checked that there are no
>>>>> other issues, by modifying tsl2563 to claim both intensity readings are on the same channel.
>>>>>
>>>>> What do you think?
>>>>> _______________________________________________
>>>>> Device-drivers-devel mailing list
>>>>> Device-drivers-devel@blackfin.uclinux.org
>>>>> https://blackfin.uclinux.org/mailman/listinfo/device-drivers-devel
>>>>>
>>>>>
>>>>>
>>>>>           
>>>>
>>>>         
>>>
>>>       
>>
>>     
>
>   


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
