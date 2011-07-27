Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4E3023A3.80604@analog.com>
Date: Wed, 27 Jul 2011 16:41:39 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH 0/2] blue part 6: IIO abi rework
References: <1311600234-16128-1-git-send-email-jic23@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D59177143001196A7@LIMKCMBX1.ad.analog.com> <4E2E863C.2010706@cam.ac.uk> <4E2E9C77.9050506@analog.com> <4E2E9FC5.4030809@cam.ac.uk>
In-Reply-To: <4E2E9FC5.4030809@cam.ac.uk>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 07/26/2011 01:06 PM, Jonathan Cameron wrote:
> On 07/26/11 11:52, Michael Hennerich wrote:
>> On 07/26/2011 11:17 AM, Jonathan Cameron wrote:
>>> On 07/26/11 10:01, Hennerich, Michael wrote:
>>>> Jonathan Cameron wrote on 2011-07-25:
>>>>> Michael pointed out the issues that not having an explicit direction
>>>>> for channels was causing and the inconsistency of the inX and outX
>>>>> channel naming we got from hmwon.
>>>>>
>>>>> They are stuck with it, but we aren't, so lets fix this now.
>>>>>
>>>>> Interesting question is whether we reset the base units to be volts
>>>>> whilst we are at it? (for voltage channels obviously!)
>>>> What do you mean exactly volts versus milli volts?
>>> Make the in_voltage_scale correspond to conversion to volts instead of
>>> millivolts as now (I think). Err. Looking at it that isn't actually documented...
>>> oops.  I wonder which drivers actually do that and which don't.
>> The ones I wrote provide the scale for millivolts.
>> With the recent introduction of IIO_VAL_INT_PLUS_NANO we got
>> the scale accurate enough for the precession 24-bit converters.
>> If we move to the SI base unit volt, we lose this accuracy again.
> Yup, that's the principal counter argument to the change.
If we decide to leave the milli scale for volts...
Do we also want to stay with milli degrees Celsius, etc.?

One other thing we should also address is the byte-ordering/endianess of
the scan elements stored in the ring buffers.

Right now the scan_element type details signs, bits, storage bits and 
shifts.
However it lacks to tell the endianess within the storage bits.

How about le:s16/32>>0 or be:s16/32>>0 for example?


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
