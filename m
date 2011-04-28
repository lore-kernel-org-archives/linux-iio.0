Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from am1ehsobe001.messaging.microsoft.com ([213.199.154.204]:18171
	"EHLO AM1EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754527Ab1D1PHq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 28 Apr 2011 11:07:46 -0400
Received: from mail3-am1 (localhost.localdomain [127.0.0.1])	by
 mail3-am1-R.bigfish.com (Postfix) with ESMTP id 6C57A16909BC	for
 <linux-iio@vger.kernel.org>; Thu, 28 Apr 2011 15:07:44 +0000 (UTC)
Received: from AM1EHSMHS004.bigfish.com (unknown [10.3.201.253])	by
 mail3-am1.bigfish.com (Postfix) with ESMTP id A6EEA10E804E	for
 <linux-iio@vger.kernel.org>; Thu, 28 Apr 2011 15:07:43 +0000 (UTC)
Message-ID: <4DB980A0.4040506@analog.com>
Date: Thu, 28 Apr 2011 16:58:40 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Jean Delvare <khali@linux-fr.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Drivers <Drivers@analog.com>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: [Device-drivers-devel] Oddities and how to handle them.
References: <4DB6EF2D.9090704@cam.ac.uk>	<4DB7FEE8.3080004@analog.com>	<4DB82B5C.5070900@cam.ac.uk>	<544AC56F16B56944AEC3BD4E3D5917713AAEE15859@LIMKCMBX1.ad.analog.com>	<4DB8322A.6050207@cam.ac.uk>	<544AC56F16B56944AEC3BD4E3D5917713AAEE15A62@LIMKCMBX1.ad.analog.com>	<4DB933E3.8070803@cam.ac.uk>	<20110428155118.041b84f2@endymion.delvare> <4DB977F2.7090002@cam.ac.uk>
In-Reply-To: <4DB977F2.7090002@cam.ac.uk>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/28/2011 04:21 PM, Jonathan Cameron wrote:
> On 04/28/11 14:51, Jean Delvare wrote:
>   
>> On Thu, 28 Apr 2011 10:31:15 +0100, Jonathan Cameron wrote:
>>     
>>> Guenter / Jean - cc'd you two because we have an sysfs interface naming question for
>>> AC sensors that touches on the edge of hwmon.
>>>
>>>       
>>>> For the metering parts I think we need to define a few more channel types.
>>>>
>>>> How about this ones
>>>>
>>>> inSX            S is the apparent power.
>>>> inPX            P is the active power.
>>>> inQX            Q is the reactive power.
>>>> inVX            V is the voltage. (only inX ?)
>>>> inVRMSX VRMS is the quadratic mean voltage.
>>>>         
>>> Call it 'root mean square' rather than quadratic in the docs. They have different
>>> meanings in English.
>>>       
>>>> inIX            I is the current.
>>>>         
>>> currX as per hwmon?  They also define a power attribute, but only 1 (as DC
>>> I guess). Cc'd Guenter and Jean to see if we can / want to share an interface...
>>>
>>> Guenter/ Jean, do you think hwmon will ever handle AC sensors?
>>>       
>> Well, never say never ;) While I've never heard of such sensors, I
>> guess it would make some sense for a computer PSU to include a sensor
>> chip monitoring both the AC input and the DC output to measure the
>> efficiency of the unit.
>>
>>     
>>> Maybe we want to be
>>> well clear of your interfaces just to avoid confusion? Or define a new set of shared
>>> names for the above that we will both use (when it becomes relevant?)
>>>       
>> It's hard to tell in advance what hwmon would implement, as we lack
>> actual examples. All I can say is that we would never use "in" prefixes
>> for power or current. The above power examples would most probably be
>> named powerX_apparent_input, powerX_active_input and
>> powerX_reactive_input, if we ever have to support these. And
>> inX_rms_input for the root mean square voltage input.
>>
>> But then again, I'm not sure if there is any point in sharing anything,
>> or forcing any difference, between hwmon and iio interfaces. They are
>> different by nature, and if we don't strictly enforce their relation,
>> they are bound to randomly diverge and converge anyway.
>>
>>     
> Agreed to a certain extent, but saying that there is no point in reinventing
> the wheel.  I think the naming you've just suggested is clearer anyway.
>
> Ultimately I don't insist on keeping to your interfaces when it really doesn't
> make sense, but when it does, it makes our life easier as we aren't starting from
> scratch. Also, politically it was suggested we do this by a few people I'd like
> to keep on side.
>
> Michael - howabout doing the rms values as done with peak_raw - as chan info parameters
> (directly derived from raw values anyway).
>   

I don't understand - why would the RMS value being a _raw value?
V and Vrms are calculated inside the metering IC.
And so far we use the _raw stuff only if the value needs to be scaled
somehow. 


> Then define two new (to us) channel types.
>
> IIO_CURRENT = "curr%d"
> IIO_POWER = "curr%d"
>   
power?
> Using the rfc I'm going to post after I send this email, we can add additional names to a channel.
> The only slight annoyance is the 3 power values will need to be different channels, so under that
> we will have:
>
> power0_apparent_raw           is the apparent power.
> power1_active_raw             is the active power.
> power2_reactive_raw           is the reactive power.
> in0                           is the voltage.
>   

If we want to be more verbose, why do we use 'in' for voltage and not
voltageX ?
It looks to me we're messing something up here. For DACs we use outX for
voltage!
I think we have to come up with something that allows us to specify
whether something is an output or input.
In addition we need to proper naming for what is input or output -
current, voltage, etc.

The three power values can't be three different channels.
They are alternatives all on the same physical input channel, and the
naming should express this.

> in0_rms_raw                   is the rms voltage.
> curr0_raw                     is the current.
>
> We may want to think about how to indicate which of these are measured on the same physical pin.
> If we were to have all the power measures as power0_* then we need another way of differentiating
> their event codes.  Could use modifiers I suppose... I've just sanity checked that there are no
> other issues, by modifying tsl2563 to claim both intensity readings are on the same channel.
>
> What do you think?
> _______________________________________________
> Device-drivers-devel mailing list
> Device-drivers-devel@blackfin.uclinux.org
> https://blackfin.uclinux.org/mailman/listinfo/device-drivers-devel
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


