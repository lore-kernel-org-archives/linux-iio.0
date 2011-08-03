Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:58349 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151Ab1HCN4D (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 3 Aug 2011 09:56:03 -0400
Message-ID: <4E395554.6020502@cam.ac.uk>
Date: Wed, 03 Aug 2011 15:04:04 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: IIO: Interface for capacitance inputs (and outputs)
References: <4E36E0B7.3070900@cam.ac.uk> <4E37B12E.3030206@analog.com> <4E37BE2B.80002@cam.ac.uk> <4E3810A3.4010508@analog.com> <4E38155D.1080103@cam.ac.uk> <4E3951BF.8000104@analog.com>
In-Reply-To: <4E3951BF.8000104@analog.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


>>>>>> Hi Michael / All,
>>>>>>
>>>>>> We have a quite a few capacitance drivers. They are all simple and so
>>>>>> would be easy to clean up, except for the fact that we don't have an abi
>>>>>> for them.
>>>>>>
>>>>>> So lets make one up. How about the following?  Main choice is the units...
>>>>>> Doing it with Farads leaves us with a lot of needed decimal places, but then
>>>>>> we need a lot anyway for these so what the heck.  We are going to need those
>>>>>> types with holes in them..
>>>>> Hi Jonathan,
>>>>>
>>>>> These devices typically feature an single digit pF input range(2..8 pF).
>>>>> Going with a scale in Farads is probably not going to work.
>>>>> What do you mean by types with holes in them?
>>>> IIO_VAL_INT_PLUS_FEMTO where FEMTO bit has maximum of 999999999  Thus there are quite a
>>>> few leading zeros.
>>> The part has a full range of +/- 4.096pf and it is a 24-bit converter.
>>> We like to store the conversion result as 3-byte direct readings from the device result register.
>>>
>>> Thus the Farad scale would need to be
>>> 8.192E-12 / 2^24 = 4.8828125E-19 = 0.00000000000000000048828125.
>>>
>>> I don't think this makes any sense?
>> It's certainly uggly.
>>>>> We need something scanf() and friends can eat...
>>>> Yup.
>>>>> In addition we have enough scale bits before the decimal point as well.
>>>> Please give an example why. Do we have a calibscale type attribute here?
>>> I don't understand, why calibscale would matter here?
>> Because it's the only item I can think of where a value of
>> 0.99999999999999999999999999999999999992 would make sense and that's the one
>> nasty case that requires a 'lot' of digits to represent currently).
>>> But sure we have a in_capacitanceY_scale.
>>> If we say the in_capacitanceY_scale targets pF.
>>>
>>> Then we still need enough fractional digits, due to the 24-bit nature of the device.
>> Sure, it's a large number of digits. I'm increasingly wondering if we move everything to
>> 64 bit just to give us the space. This stuff is all ready relatively slowly anyway.
>>> Now not talking about this part, maybe something that can measure ranges up to 1mF
>>> - which is quite a huge capacitance.
>>> If the scale targets pF, then we actually use the pre-decimal point positions we have.
>> Fair point and using that we can go up to very large capacitances if there is ever the need.
>>>
>>>>> I would make the scale targeting pF of uF.
>>>> I thought about that but then we are back to having a fairly illogical set of
>>>> units for the different types of devices.
>>> That's in the nature of these units.
>>> 1V, 1A is pretty common 1F is not.
>> I know, but despite that it would be nice to be consistent.
>>> Either move to an floating point exponential notation, or balance the scale somewhere in the middle.
>> We could do the exponential notation I suppose.
>>
>> Maybe picofarads is the right option.
>>>>>> What:           /sys/bus/iio/devices/iio:deviceX/in_capacitanceY_raw
>>>>>> What:           /sys/bus/iio/devices/iio:deviceX/out_capacitanceY_raw
>>>>>> What:           /sys/bus/iio/devices/iio:deviceX/in_capacitanceY-capacitanceZ_raw
>>>>>> KernelVersion:  3.1
>>>>>> Contact:        linux-iio@vger.kernel.org
>>>>>> Description:
>>>>>>                    Raw (unscaled no bias removal etc) capacitance value from/to
>>>>>>                    channel Y. After application of _offset and _scale, units will
>>>>>>                    be Farads.
>>>>>>
>>>>>> Additional entries for:
>>>>>>
>>>>>> What:           /sys/bus/iio/devices/iio:deviceX/in_capacitanceY_offset
>>>>>> What:           /sys/bus/iio/devices/iio:deviceX/in_capacitanceY_scale
>>>>>>
>>>>>>
>>>>>> With the ad7745 the capdac does seem to be available off chip.
>>>>> Why do you think the CAPDAC is off-chip on the AD7745?
>>>>> The CAPDAC can be seen as a negative capacitance connected internally
>>>>> to the Cin pin.
>>>> Oops. That was meant to be doesn't not does... Sorry for the confusion.
>>>>>>     If I understand
>>>>>> their use correctly it could just be treated as a _calibbias parameters?
>>>>> Yes - it can be seen as a bias - however why do you have out_capacitanceY_raw then?
>>>> :) Because I hadn't looked at the datasheet properly when I wrote that bit and forgot
>>>> to go back and edit it.  This really wasn't my most coherent email ever.  Google isn't
>>>> feeding me any digital to capacitance devices so looks like the output side of things
>>>> is irrelevant.
>>>>>> (the complexity being that there are two..)
>>>>> Yes - one for each Cin(+|-) pin.
>>>>> More tricky on the AD7746, since there are only two CAPDACs for two Cin(+|-) pin pairs.
>>>> As you state below that you tend to save and restore the zero offset, can we not do the
>>>> same with the capdac values?  If so they can be treated from a userspace point of view
>>>> as completely independent.
>>> Sure
>>>>>>      Naturally there is also a
>>>>>> calibration register so this gets somewhat tricky...
>>>>> The calibration register typically holds the zero-scale calibration coefficient.
>>>>> It's automatically updated following the capacitance offset calibration.
>>>>> Tricky here is that there is only one on the AD7746, so the values must be saved
>>>>> and restored when switching between the input pairs.
>>>>>
>>>>>> Is there an optimum
>>>>>> combination for a given desire measurement range?
>>>>>>
>>>>>>
>>>>> Yes there is - large offsets>   1 pF should be eliminated by the CAPDACs.
>>>> Fair enough.  So what is the conclusion for what interface elements we
>>>> actually need to control this?
>>> Let me think about this a bit more.
>> Will do.
> Hi Jonathan,
> 
> I don't think it's practical or fits the typical use case to just have _calibbias handling both.
> How about following -
> 
> The cap offset calibration register maps to _calibbias and handles the small calibration offsets.
> We also need a do calibrate attribute...
> 
> For the larger CAPDAC offsets, we introduce in_capacitanceY_bias.
> in_capacitanceY_offset would be nicer, but we already use it for other purposes.
> 
> Thoughts?
Works for me.  Will need to document this very clearly to stop people mixing up
_bias and _offset.
