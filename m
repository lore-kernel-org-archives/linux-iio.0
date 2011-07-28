Return-Path: <manuel.stahl9cd33xy531iis.fraunhofer.de@bounce.antispameurope.com>
Message-ID: <4E315A79.9080209@iis.fraunhofer.de>
Date: Thu, 28 Jul 2011 14:47:53 +0200
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH 0/2] blue part 6: IIO abi rework
References: <1311600234-16128-1-git-send-email-jic23@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D59177143001196A7@LIMKCMBX1.ad.analog.com> <4E2E863C.2010706@cam.ac.uk> <4E2E9C77.9050506@analog.com> <4E2E9FC5.4030809@cam.ac.uk> <4E3023A3.80604@analog.com> <4E3117DD.9060904@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D5917714300119DD5@LIMKCMBX1.ad.analog.com> <4E311EDB.6020607@iis.fraunhofer.de> <4E313154.4010003@cam.ac.uk>
In-Reply-To: <4E313154.4010003@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Am 28.07.2011 11:52, schrieb Jonathan Cameron:
> On 07/28/11 09:33, Manuel Stahl wrote:
>> Hi,
>>
>> I had the time to read through the discussion recently, so just a few =
comments:
>>
>> Am 28.07.2011 10:08, schrieb Hennerich, Michael:
>>> Jonathan Cameron wrote on 2011-07-28:
>>>> On 07/27/11 15:41, Michael Hennerich wrote:
>>>>> On 07/26/2011 01:06 PM, Jonathan Cameron wrote:
>>>>>> On 07/26/11 11:52, Michael Hennerich wrote:
>>>>>>> On 07/26/2011 11:17 AM, Jonathan Cameron wrote:
>>>>>>>> On 07/26/11 10:01, Hennerich, Michael wrote:
>>>>>>>>> Jonathan Cameron wrote on 2011-07-25:
>>>>>>>>>> Michael pointed out the issues that not having an explicit
>>>>>>>>>> direction for channels was causing and the inconsistency of th=
e
>>>>>>>>>> inX and outX channel naming we got from hmwon.
>>>>>>>>>>
>>>>>>>>>> They are stuck with it, but we aren't, so lets fix this now.
>>>>>>>>>>
>>>>>>>>>> Interesting question is whether we reset the base units to be
>>>>>>>>>> volts whilst we are at it? (for voltage channels obviously!)
>>>>>>>>> What do you mean exactly volts versus milli volts?
>>>>>>>> Make the in_voltage_scale correspond to conversion to volts inst=
ead
>>>>>>>> of millivolts as now (I think). Err. Looking at it that isn't
>>>>>>>> actually documented... oops.  I wonder which drivers actually do=

>>>>>>>> that and which don't.
>>>>>>> The ones I wrote provide the scale for millivolts.
>>>>>>> With the recent introduction of IIO_VAL_INT_PLUS_NANO we got the
>>>>>>> scale accurate enough for the precession 24-bit converters.
>>>>>>> If we move to the SI base unit volt, we lose this accuracy again.=

>>>>>> Yup, that's the principal counter argument to the change.
>>>>> If we decide to leave the milli scale for volts... Do we also want =
to
>>>>> stay with milli degrees Celsius, etc.? If we do it for one, probabl=
y
>>>>> best to do it for them all..
>>> Hi Jonathan,
>>>
>>> So stick with the milli scale for all?
>> If it's possible, I would like to have pure units. I didn't read the
>> API with IIO_VAL_INT_PLUS_NANO completely so I don't understand the
>> problem yet, but using milli just because the drivers we have in
>> place can measure relatively low voltages make no sense for me.
> The issue is we have two integers to play with.  The first is
> used for the integer part.  The second is divided by either 10^6 or 10^=
9
> and added on.
>
> If we go to 10^12, then max value for the decimal bit should be:
>   999,999,999,999.
>
> Unfortunately we only have a 32 bit int (to avoid use of div64 in drive=
rs).
> It's signed as well to allow us to set the integer bit to 0.  Hence max=

> value is 2^31 =3D 2 147 483 648.
>
> Hence not enough and the hole.
>
> Next question is whether this is an issue.  I doubt it with _scale, _of=
fset
> _calibbias, but just possibly with _calibscale where very small adjustm=
ents
> may occur (hence 0.999999999999 is possible.)
Does it help to support exponential formats like 999999.9999999e-10?

--=20
Manuel Stahl
Fraunhofer-Institut IIS
Leistungsoptimierte Systeme

Nordostpark 93
D90411 N=FCrnberg
Telefon  +49 (0)911/58061-6419
Fax      +49 (0)911/58061-6398
E-Mail   manuel.stahl@iis.fraunhofer.de

http://www.iis.fraunhofer.de
http://www.smart-power.fraunhofer.de
