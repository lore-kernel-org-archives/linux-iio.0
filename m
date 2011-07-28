Return-Path: <manuel.stahl9cd33xy531iis.fraunhofer.de@bounce.antispameurope.com>
Message-ID: <4E311EDB.6020607@iis.fraunhofer.de>
Date: Thu, 28 Jul 2011 10:33:31 +0200
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH 0/2] blue part 6: IIO abi rework
References: <1311600234-16128-1-git-send-email-jic23@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D59177143001196A7@LIMKCMBX1.ad.analog.com> <4E2E863C.2010706@cam.ac.uk> <4E2E9C77.9050506@analog.com> <4E2E9FC5.4030809@cam.ac.uk> <4E3023A3.80604@analog.com> <4E3117DD.9060904@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D5917714300119DD5@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917714300119DD5@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi,

I had the time to read through the discussion recently, so just a few=20
comments:

Am 28.07.2011 10:08, schrieb Hennerich, Michael:
> Jonathan Cameron wrote on 2011-07-28:
>> On 07/27/11 15:41, Michael Hennerich wrote:
>>> On 07/26/2011 01:06 PM, Jonathan Cameron wrote:
>>>> On 07/26/11 11:52, Michael Hennerich wrote:
>>>>> On 07/26/2011 11:17 AM, Jonathan Cameron wrote:
>>>>>> On 07/26/11 10:01, Hennerich, Michael wrote:
>>>>>>> Jonathan Cameron wrote on 2011-07-25:
>>>>>>>> Michael pointed out the issues that not having an explicit
>>>>>>>> direction for channels was causing and the inconsistency of the
>>>>>>>> inX and outX channel naming we got from hmwon.
>>>>>>>>
>>>>>>>> They are stuck with it, but we aren't, so lets fix this now.
>>>>>>>>
>>>>>>>> Interesting question is whether we reset the base units to be
>>>>>>>> volts whilst we are at it? (for voltage channels obviously!)
>>>>>>> What do you mean exactly volts versus milli volts?
>>>>>> Make the in_voltage_scale correspond to conversion to volts instea=
d
>>>>>> of millivolts as now (I think). Err. Looking at it that isn't
>>>>>> actually documented... oops.  I wonder which drivers actually do
>>>>>> that and which don't.
>>>>> The ones I wrote provide the scale for millivolts.
>>>>> With the recent introduction of IIO_VAL_INT_PLUS_NANO we got the
>>>>> scale accurate enough for the precession 24-bit converters.
>>>>> If we move to the SI base unit volt, we lose this accuracy again.
>>>> Yup, that's the principal counter argument to the change.
>>> If we decide to leave the milli scale for volts... Do we also want to=

>>> stay with milli degrees Celsius, etc.? If we do it for one, probably
>>> best to do it for them all..
> Hi Jonathan,
>
> So stick with the milli scale for all?
If it's possible, I would like to have pure units. I didn't read the API =

with IIO_VAL_INT_PLUS_NANO completely so I don't understand the problem=20
yet, but using milli just because the drivers we have in place can=20
measure relatively low voltages make no sense for me.
>
>>> One other thing we should also address is the
>>> byte-ordering/endianess of the scan elements stored in the ring buffe=
rs.
>>>
>>> Right now the scan_element type details signs, bits, storage bits and=

>>> shifts. However it lacks to tell the endianess within the storage bit=
s.
>>> Good point. I'd completely forgotten about that.
>>>
>>> How about le:s16/32>>0 or be:s16/32>>0 for example?
>> Yup, that works for me.  In cases where it doesn't matter they driver
>> can pick one at random.
>
> We need another case - Some drivers use the (be|le)(x)_to_cpu() helpers=
,
> So in case these are used the endianess can be either or, depending on =
the host.
> So maybe have le|be|cpu?
I think we can drop the usage of the (be|le)(x)_to_cpu() helpers. It's=20
easy to find out the current CPU endianess so we can always provide a=20
correct term here. Especially important when we use the iiod, as the=20
data might be processed on a different CPU.
>
>
> Greetings,
> Michael
>
> --
> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
> Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; G=
eschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Ma=
rgaret Seif
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in=

> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


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
