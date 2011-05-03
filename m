Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:35399
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751765Ab1ECJfO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2011 05:35:14 -0400
Received: from mail29-ch1 (localhost.localdomain [127.0.0.1])	by
 mail29-ch1-R.bigfish.com (Postfix) with ESMTP id 2F4DA12A8784	for
 <linux-iio@vger.kernel.org>; Tue,  3 May 2011 09:35:13 +0000 (UTC)
Received: from CH1EHSMHS026.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.243])	by mail29-ch1.bigfish.com (Postfix) with ESMTP id C74E039004D
	for <linux-iio@vger.kernel.org>; Tue,  3 May 2011 09:35:12 +0000 (UTC)
Message-ID: <4DBFCA2D.3080105@analog.com>
Date: Tue, 3 May 2011 11:26:05 +0200
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
References: <4DB6EF2D.9090704@cam.ac.uk>	<4DB7FEE8.3080004@analog.com>	<4DB82B5C.5070900@cam.ac.uk>	<544AC56F16B56944AEC3BD4E3D5917713AAEE15859@LIMKCMBX1.ad.analog.com>	<4DB8322A.6050207@cam.ac.uk>	<544AC56F16B56944AEC3BD4E3D5917713AAEE15A62@LIMKCMBX1.ad.analog.com>	<4DB933E3.8070803@cam.ac.uk>	<20110428155118.041b84f2@endymion.delvare> <4DB977F2.7090002@cam.ac.uk> <4DB980A0.4040506@analog.com> <4DB98BE8.9060301@cam.ac.uk> <4DBAC97E.1090901@analog.com> <4DBAD336.3080006@cam.ac.uk> <4DBE652E.2040800@analog <4DBEC4C1.3070009@cam.ac.uk>
In-Reply-To: <4DBEC4C1.3070009@cam.ac.uk>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/02/2011 04:50 PM, Jonathan Cameron wrote:
>   
>>>>>>             
>>>>> We could prefix all inputs with in and all outputs with out, assuming
>>>>> we move voltages out of the way. Ultimately we didn't have any output
>>>>> devices when we started hammering the interfaces into shape.
>>>>>
>>>>>
>>>>>           
>>>> That sounds right to me.
>>>>
>>>>         
>>> We may need to do this gradually, or on the move from staging out into the
>>> main tree.  Whilst we are in staging, I know there are mainstream users
>>> of a few drivers.  Perhaps we just support old interface for them on a
>>> case by case basis.
>>>
>>> This will want a full proposal to lkml.
>>>
>>>       
>>>>>           
>>>>>> In addition we need to proper naming for what is input or output -
>>>>>> current, voltage, etc.
>>>>>>
>>>>>> The three power values can't be three different channels.
>>>>>> They are alternatives all on the same physical input channel, and the
>>>>>> naming should express this.
>>>>>>
>>>>>>
>>>>>>             
>>>>> Then it will have to be as modifiers.  Right now we tend to use them to
>>>>> group things.  So for accelerometers we can in theory have:
>>>>>
>>>>> accel0_x,
>>>>> accel0_y,
>>>>> accel1_x, etc. for chips implementing more than one sensor in a given
>>>>> direction.
>>>>>
>>>>> If we insist on same number meaning same physical ping then for typical
>>>>> inertial sensor the channel number would have to be unique.
>>>>> Thus take adis16400 we would need.
>>>>>
>>>>> in0_supply_raw
>>>>> gyro1_x_raw
>>>>> gyro2_y_raw
>>>>> gyro3_z_raw
>>>>> accel4_x_raw
>>>>> etc...
>>>>> which, whilst looking odd, wouldn't be a fundamental problem.
>>>>>
>>>>>
>>>>>           
>>>> Agreed - that looks odd. And yes modifiers should work as well.
>>>> So we get to -
>>>>
>>>> in_powerX_Y_apparent_raw
>>>>
>>>> in_volatgeX_Y_rms_raw
>>>>
>>>> or
>>>>
>>>> inX_powerY_apparent_raw
>>>> inX_volatgeY_rms_raw
>>>> outX_volatgeY_raw
>>>>
>>>>
>>>>         
>>> I'm a little confused on what the Y is?  I would imagine we can only have
>>> one apparent power measure per channel.  The modifier will be into an enum
>>> associated with that 'apparent' label, much as we have 'x'
>>> for axis in devices where that makes sense.  We may want to move away from
>>> the passing a character approach for those modifiers as well so we have
>>> just one path.
>>>
>>>       
>> Hi Jonathan,
>>
>> I'm now getting confused as well.
>> Yes one apparent power measure per channel is enough.
>> Didn't you say that the 3 power values will need to be different channels?
>> My point was that we need a modifier that identifies the physical
>> input/output channel.
>>     
> I was thinking of this other way around. We have perfectly good channel
> numbers. Lets use them for the physical channel, then use the modifiers
> to distinguish what we are dealing with.  Thus, here we have:
>
> Channel types
> Power,
> Voltage,
> Current,
> (for now keep voltage as inX as it will easier to do a separate series converting
> all drivers to new naming)
>
> for power, we define modifiers, apparent, active, reactive.
>
> for voltage and current we will define the modifier rms
>
> (this is a change to what I proposed earlier so as to allow for
> events on RMS values. For consistency we will probably want to move
> the existing channel info element peak_raw over to be a modifier
> as well - what we currently do with that is a dirty hack that will
> bite us at some point)
>
> We then define channel numbering, to be an 'indicator' of shared physical
> channel (i.e. pin).  I only say indicator so as to avoid a mass change of
> the tree in this driver patch. As with the channel renames, that wants
> to be a separate series.  It actually effects only a few channels on a few
> devices so isn't a big problem.
>
> By saying channel numbers indicate physical channels iff they are present
> we get around having to assign the to axes on the IMU's and accelerometers.
>
> So we end up with here (I've gone for raw everywhere to avoid reading the
> datasheet thoroughly!)
>
> power0_apparent_raw
> power0_active_raw
> power0_reactive_raw
> in0_raw (probably become voltage0_raw at a later date, from waveform register?)
>   
Not sure if we need voltage0_raw and current0_raw as a none buffer channel.
These actual values are only interesting when they are sampled at a
fixed frequency. 
> in0_rms_raw
> in0_peak_raw (max value from set number of wave cycles - probably needs in0_peak_cycles as well?)
> curr0_raw (from waveform register?)
> curr0_rms_raw
> curr0_peak_raw (max value from set number of wave cycles..)
>
> Would this cover your requirements?  It generalizes well (I think) so I'm quite
> keen on doing it roughly like this...
>   
Thanks, this covers things - and makes a lot of sense.
> As a follow up series, I'll (or some one else) also move the accelerometers etc
> to not specify their modifiers with 'x' as channel but rather the modifier
> code in channel2 of iio_chan_spec.
>
>  Thanks for knocking this driver into shape!
>
> Hope it doesn't prove too painful.
>
> Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
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


