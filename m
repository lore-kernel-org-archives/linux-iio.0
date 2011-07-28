Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:51020 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755311Ab1G1JoW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 28 Jul 2011 05:44:22 -0400
Message-ID: <4E313154.4010003@cam.ac.uk>
Date: Thu, 28 Jul 2011 10:52:20 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: "Hennerich, Michael" <Michael.Hennerich@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH 0/2] blue part 6: IIO abi rework
References: <1311600234-16128-1-git-send-email-jic23@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D59177143001196A7@LIMKCMBX1.ad.analog.com> <4E2E863C.2010706@cam.ac.uk> <4E2E9C77.9050506@analog.com> <4E2E9FC5.4030809@cam.ac.uk> <4E3023A3.80604@analog.com> <4E3117DD.9060904@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D5917714300119DD5@LIMKCMBX1.ad.analog.com> <4E311EDB.6020607@iis.fraunhofer.de>
In-Reply-To: <4E311EDB.6020607@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/28/11 09:33, Manuel Stahl wrote:
> Hi,
> 
> I had the time to read through the discussion recently, so just a few comments:
> 
> Am 28.07.2011 10:08, schrieb Hennerich, Michael:
>> Jonathan Cameron wrote on 2011-07-28:
>>> On 07/27/11 15:41, Michael Hennerich wrote:
>>>> On 07/26/2011 01:06 PM, Jonathan Cameron wrote:
>>>>> On 07/26/11 11:52, Michael Hennerich wrote:
>>>>>> On 07/26/2011 11:17 AM, Jonathan Cameron wrote:
>>>>>>> On 07/26/11 10:01, Hennerich, Michael wrote:
>>>>>>>> Jonathan Cameron wrote on 2011-07-25:
>>>>>>>>> Michael pointed out the issues that not having an explicit
>>>>>>>>> direction for channels was causing and the inconsistency of the
>>>>>>>>> inX and outX channel naming we got from hmwon.
>>>>>>>>>
>>>>>>>>> They are stuck with it, but we aren't, so lets fix this now.
>>>>>>>>>
>>>>>>>>> Interesting question is whether we reset the base units to be
>>>>>>>>> volts whilst we are at it? (for voltage channels obviously!)
>>>>>>>> What do you mean exactly volts versus milli volts?
>>>>>>> Make the in_voltage_scale correspond to conversion to volts instead
>>>>>>> of millivolts as now (I think). Err. Looking at it that isn't
>>>>>>> actually documented... oops.  I wonder which drivers actually do
>>>>>>> that and which don't.
>>>>>> The ones I wrote provide the scale for millivolts.
>>>>>> With the recent introduction of IIO_VAL_INT_PLUS_NANO we got the
>>>>>> scale accurate enough for the precession 24-bit converters.
>>>>>> If we move to the SI base unit volt, we lose this accuracy again.
>>>>> Yup, that's the principal counter argument to the change.
>>>> If we decide to leave the milli scale for volts... Do we also want to
>>>> stay with milli degrees Celsius, etc.? If we do it for one, probably
>>>> best to do it for them all..
>> Hi Jonathan,
>> 
>> So stick with the milli scale for all?
> If it's possible, I would like to have pure units. I didn't read the
> API with IIO_VAL_INT_PLUS_NANO completely so I don't understand the
> problem yet, but using milli just because the drivers we have in
> place can measure relatively low voltages make no sense for me.
The issue is we have two integers to play with.  The first is
used for the integer part.  The second is divided by either 10^6 or 10^9
and added on.

If we go to 10^12, then max value for the decimal bit should be:
 999,999,999,999.

Unfortunately we only have a 32 bit int (to avoid use of div64 in drivers).
It's signed as well to allow us to set the integer bit to 0.  Hence max
value is 2^31 = 2 147 483 648.

Hence not enough and the hole.

Next question is whether this is an issue.  I doubt it with _scale, _offset
_calibbias, but just possibly with _calibscale where very small adjustments
may occur (hence 0.999999999999 is possible.) 

Looking at our actual users, lis3l02dq outputs a raw register read, adis16260
outputs garbage and the other two are _input outputing only devices and hence
the calibscale value can be in whatever units we like (no concept of raw units
for those devices).

Ooops, on the adis16260 one, I'll fix that up. Should obviously be
*val = val16 & ((1 << bits) -1); not *val = (1 << bits) -1;


>> 
>>>> One other thing we should also address is the 
>>>> byte-ordering/endianess of the scan elements stored in the ring
>>>> buffers.
>>>> 
>>>> Right now the scan_element type details signs, bits, storage
>>>> bits and shifts. However it lacks to tell the endianess within
>>>> the storage bits. Good point. I'd completely forgotten about
>>>> that.
>>>> 
>>>> How about le:s16/32>>0 or be:s16/32>>0 for example?
>>> Yup, that works for me.  In cases where it doesn't matter they
>>> driver can pick one at random.
>> 
>> We need another case - Some drivers use the (be|le)(x)_to_cpu()
>> helpers, So in case these are used the endianess can be either or,
>> depending on the host. So maybe have le|be|cpu?
> I think we can drop the usage of the (be|le)(x)_to_cpu() helpers.
> It's easy to find out the current CPU endianess so we can always
> provide a correct term here. Especially important when we use the
> iiod, as the data might be processed on a different CPU.
Agreed.
