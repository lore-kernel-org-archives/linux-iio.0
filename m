Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:60427 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597Ab1D1KQ4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 28 Apr 2011 06:16:56 -0400
Message-ID: <4DB93F1D.2090908@cam.ac.uk>
Date: Thu, 28 Apr 2011 11:19:09 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Drivers <Drivers@analog.com>,
	Guenter Roeck <guenter.roeck@ericsson.com>,
	Jean Delvare <khali@linux-fr.org>
Subject: Re: Oddities and how to handle them.
References: <4DB6EF2D.9090704@cam.ac.uk> <4DB7FEE8.3080004@analog.com> <4DB82B5C.5070900@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D5917713AAEE15859@LIMKCMBX1.ad.analog.com> <4DB8322A.6050207@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D5917713AAEE15A62@LIMKCMBX1.ad.analog.com> <4DB933E3.8070803@cam.ac.uk> <4DB93B9A.6050500@analog.com>
In-Reply-To: <4DB93B9A.6050500@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/28/11 11:04, Michael Hennerich wrote:
> On 04/28/2011 11:31 AM, Jonathan Cameron wrote:
>> Guenter / Jean - cc'd you two because we have an sysfs interface naming question for
>> AC sensors that touches on the edge of hwmon.
>>
>>   
>>>>>>>> Hi Michael,
>>>>>>>>
>>>>>>>> ade7758 - Complex driver I'm not that keen on touching without a lot
>>>>>>>> of testing support. Don't suppose you want to take this one Michael?
>>>>>>>> (*looks hopeful*) At lease blugeoning it into more or less current
>>>>>>>> interfaces would be a great help. I can do it, but then I suspect
>>>>>>>> I'll break it in a few exciting ways :(
>>>>>>>>
>>>>>>>>               
>>>>>>> I can fix building on this one. However I currently don't have
>>>>>>> enough time to fix and document the API.
>>>>>>>             
>>>>>> That's fine.  We won't be pushing any of the energy meter drivers out
>>>>>> of staging for a while yet anyway!
>>>>>>           
>>>>>>> The buffer scan attribute naming is a bit complicated on this one.
>>>>>>> Do you think we can stick with wform?
>>>>>>> There is some interaction with the WAVEFORM MODE Register. Ideally
>>>>>>> we have enable files for all possible waveform selection
>>>>>>> possibilities, which are numerous, 3 sources (phases)  * 5
>>>>>>> measurement options (Current, Voltage, Active Power, Reactive
>>>>>>> Power and VA). Only one combination can be enabled at a given
>>>>>>> time, since they are exclusive
>>>>>>>             
>>>>>> or.
>>>>>>           
>>> Hi Jonathan,
>>>
>>> For the metering parts I think we need to define a few more channel types.
>>>
>>> How about this ones
>>>
>>> inSX            S is the apparent power.
>>> inPX            P is the active power.
>>> inQX            Q is the reactive power.
>>> inVX            V is the voltage. (only inX ?)
>>> inVRMSX VRMS is the quadratic mean voltage.
>>>     
>> Call it 'root mean square' rather than quadratic in the docs. They have different
>> meanings in English.
>>   
>>> inIX            I is the current.
>>>     
>> currX as per hwmon?  They also define a power attribute, but only 1 (as DC
>> I guess). Cc'd Guenter and Jean to see if we can / want to share an interface...
>>   
> Honestly I don't like 'curr' - In my opinion we should use SI until
> symbols (as well as standardized derived SI units where applicable).
> In this particular case current is a SI unit.
> For everything further we should use symbols commonly used in
> Anglo-American EE and Physics literature. (NIST, IEEE, ...)
Agreed, but it's an interface that is in place so best to match where
we can. That way far fewer argument lie (we can always blame someone
else :)
>  
>> Guenter/ Jean, do you think hwmon will ever handle AC sensors? Maybe we want to be
>> well clear of your interfaces just to avoid confusion? Or define a new set of shared
>> names for the above that we will both use (when it becomes relevant?)
>>   
>>> inIRMSX IRMS is the quadratic mean current.
>>>
>>> Since they won't be really popular
>>>
>>> How about using a string in iio_chan_type_name_spec
>>>
>>>         [IIO_IN_GENERIC] = "in%s",
>>>     
>> Firstly, perhaps, IIO_IN_MOD will correspond better with naming?
>>   
>> Been thinking about exactly this question for the light sensors...
>> Initially strings seemed like the obvious thing to do, but then I thought
>> some more.  For all of these we will need to have matching event codes.
>> The easiest there would be to do them as IIO_EV_MOD_POWER_APPARENT etc.
>> Once we have those defines, we might as well roll the names into the core
>> as a string table referenced by value stored in channel2.
>> Actually, arguably we shouldn't be doing the same for 'x','y','z' as well
>> for consistency. Right now we allow for directions without corresponding event
>> codes. That way lies doom!
>>
>> I know there aren't likely to be hundreds of these devices any time soon,
>> but we don't really want to set a precedence for allowing free naming.
>> That was part of the justification for moving to chan_spec in the first
>> place!
>>
>> Jonathan
>>
>>   
> 
> 

