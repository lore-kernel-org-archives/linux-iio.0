Return-Path: <jic23@cam.ac.uk>
Message-ID: <4FA92081.9060205@cam.ac.uk>
Date: Tue, 08 May 2012 14:32:49 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: Jonathan Cameron <jic23@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>,
 Drivers <Drivers@analog.com>,
 Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] iio: amplifiers: New driver for AD8366 Dual-Digital Variable
 Gain Amplifier
References: <1329914182-5428-1-git-send-email-michael.hennerich@analog.com> <4F6A2D2B.9050400@kernel.org> <4F6AE844.7020102@analog.com> <4F6AEC83.8010009@cam.ac.uk> <4FA7E373.2080704@analog.com> <4FA7E78E.6050406@analog.com> <4FA9175B.6010206@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D5917714E797B56F9@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917714E797B56F9@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 5/8/2012 2:26 PM, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2012-05-08:
>> On 5/7/2012 4:17 PM, Michael Hennerich wrote:
>>> On 05/07/2012 05:00 PM, Michael Hennerich wrote:
>>>> On 03/22/2012 10:10 AM, Jonathan Cameron wrote:
>>>>> On 3/22/2012 8:52 AM, Michael Hennerich wrote:
>>>>>> On 03/21/2012 08:34 PM, Jonathan Cameron wrote:
>>>>>>> On 02/22/2012 12:36 PM, michael.hennerich@analog.com wrote:
>>>>>>>> From: Michael Hennerich<michael.hennerich@analog.com>
>>>>>>> Sorry for the slow response on this one. Been off sick...
>>>>>>>
>>>>>>> Anyhow, I'm still not sure what the right interface for this type
>>>>>>> of device is.
>>>>>>>
>>>>>>> The obvious options are:
>>>>>>>
>>>>>>> 1) Make gain an IIO type (doesn't make much sense as gain is only
>>>>>>> going
>>>>>>> to be of one particular existing type).
>>>>>>> 2) Have it as an IIO_ALTVOLTAGE channel as you have here and use
>>>>>>> extend
>>>>>>> name.  Any real reason for picking altvoltage rather than
>> voltage?
>>>>>> I'm open for advice. Since I made the amplifier being an OUT type
>>>>>> device
>>>>>> I chose IIO_ALTVOLTAGE analogous to our DDS/PLL drivers.
>>>>>> Some VGAs/PGAs work from DC, but typically VGAs are HF devices.
>>>>> Hmm.. Don't suppose it really matters but we ought to aim for
>>>>> consistency
>>>>> (by review) at least.  This particular part is DC through to
>> 600MHz.
>>>>>>> Clearly gain has the same meaning in either case (assuming it's
>>>>>>> linear). 3) Make a change to core to allow a channel to have
>>>>>>> elements in info_mask but not actually to have a raw access.  Not
>>>>>>> entirely sure how we will do that cleanly.  Also it's not clear
>>>>>>> whether the gain would be an IN or an OUT channel type!
>>>>>> Well - having the ability for channels without raw access element
>>>>>> would be of interest.
>>>>> True enough.  Cleanest way to do this that I can think of is to make
>>>>> a tree wide change to add the raw element to the info_mask.  We could
>>>>> allow for a zero info_mask value actually being the equivalent of
>>>>> having only a raw channel.  It's invasive but if we agreee it should
>>>>> be done now is probably the best time to do it (just post merge
>>>>> window etc).
>>>> Hi Jonathan,
>>>>
>>>> Thanks for getting this in place.
>>>>
>>>>> Whilst here, we clearly need way of destinguishing values in DB from
>>>>> linear gains.  Could add a new return type for read_raw callbacks?
>>>> Does something like this work for you?
>>>> Also wondering if we should introduce IIO_CHAN_INFO_GAIN
>>>> for amplifier type devices?
>>> Thinking about it a bit more - why not have iio_chan_type:IIO_GAIN?
>> Lack of consistency with other devices.  If we have a pga on the front
>> of an adc then the type is voltage and control is done via relevant info
>> element. How is this any different?
> Well there can be several types of amplifiers voltage, current or none-electronic
> such as optical amplifiers.
Quite.  But a given amplier only does one type.  Hence arguement still 
stands...  The only
exception is an analog device such as an accelerometer wired up to a 
conventional adc,
but then we don't handle that anyway...
>
> The key element GAIN of an amplifier is only the ratio between input and output.
> The unit cancels out, so why bother with voltage or current?
Far as I know you can't use a voltage amplifier for current 
amplificiation or the other way around,
so still makes sence to keep them alongside the type.  The voltage vs 
altvoltage is a bit of
a pain but I guess no cunning plan is perfect..
> That's why I proposed IIO_GAIN.
> Anyways I'm fine with IIO_VOLTAGE for now, but I would like to use IIO_CHAN_INFO_GAIN
> and not IIO_CHAN_INFO_SCALE?
Its internally applied so actually IIO_CHAN_INFO_CALIBSCALE is the 
relevant one.
I'm really keen to stick to the existing ones purely because this does 
look exactly like a
pga front end as found on numerous adcs.  Why treat it differently just 
because it is
in a different package?  We may need to be clever about routing between 
parts sometime
in the future but would be best to keep it simple for now?
>
> Greetings,
> Michael
>
> --
> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
> Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
> Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif
>
>
>
