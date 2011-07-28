Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:57514 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754481Ab1G1LuZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 28 Jul 2011 07:50:25 -0400
Message-ID: <4E314EE1.40307@cam.ac.uk>
Date: Thu, 28 Jul 2011 12:58:25 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH 0/2] blue part 6: IIO abi rework
References: <1311600234-16128-1-git-send-email-jic23@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D59177143001196A7@LIMKCMBX1.ad.analog.com> <4E2E863C.2010706@cam.ac.uk> <4E2E9C77.9050506@analog.com> <4E2E9FC5.4030809@cam.ac.uk> <4E3023A3.80604@analog.com> <4E3117DD.9060904@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D5917714300119DD5@LIMKCMBX1.ad.analog.com> <4E311FA7.2000200@cam.ac.uk> <4E311F78.6080008@analog.com> <4E312E83.1020509@cam.ac.uk> <4E313181.6000306@analog.com>
In-Reply-To: <4E313181.6000306@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/28/11 10:53, Michael Hennerich wrote:
> On 07/28/2011 11:40 AM, Jonathan Cameron wrote:
>> On 07/28/11 09:36, Michael Hennerich wrote:
>>> On 07/28/2011 10:36 AM, Jonathan Cameron wrote:
>>>> On 07/28/11 09:08, Hennerich, Michael wrote:
>>>>> Jonathan Cameron wrote on 2011-07-28:
>>>>>> On 07/27/11 15:41, Michael Hennerich wrote:
>>>>>>> On 07/26/2011 01:06 PM, Jonathan Cameron wrote:
>>>>>>>> On 07/26/11 11:52, Michael Hennerich wrote:
>>>>>>>>> On 07/26/2011 11:17 AM, Jonathan Cameron wrote:
>>>>>>>>>> On 07/26/11 10:01, Hennerich, Michael wrote:
>>>>>>>>>>> Jonathan Cameron wrote on 2011-07-25:
>>>>>>>>>>>> Michael pointed out the issues that not having an explicit
>>>>>>>>>>>> direction for channels was causing and the inconsistency of the
>>>>>>>>>>>> inX and outX channel naming we got from hmwon.
>>>>>>>>>>>>
>>>>>>>>>>>> They are stuck with it, but we aren't, so lets fix this now.
>>>>>>>>>>>>
>>>>>>>>>>>> Interesting question is whether we reset the base units to be
>>>>>>>>>>>> volts whilst we are at it? (for voltage channels obviously!)
>>>>>>>>>>> What do you mean exactly volts versus milli volts?
>>>>>>>>>> Make the in_voltage_scale correspond to conversion to volts instead
>>>>>>>>>> of millivolts as now (I think). Err. Looking at it that isn't
>>>>>>>>>> actually documented... oops.  I wonder which drivers actually do
>>>>>>>>>> that and which don't.
>>>>>>>>> The ones I wrote provide the scale for millivolts.
>>>>>>>>> With the recent introduction of IIO_VAL_INT_PLUS_NANO we got the
>>>>>>>>> scale accurate enough for the precession 24-bit converters.
>>>>>>>>> If we move to the SI base unit volt, we lose this accuracy again.
>>>>>>>> Yup, that's the principal counter argument to the change.
>>>>>>> If we decide to leave the milli scale for volts... Do we also want to
>>>>>>> stay with milli degrees Celsius, etc.? If we do it for one, probably
>>>>>>> best to do it for them all..
>>>>> Hi Jonathan,
>>>>>
>>>>> So stick with the milli scale for all?
>>>> Yes.
>>>>>>> One other thing we should also address is the
>>>>>>> byte-ordering/endianess of the scan elements stored in the ring buffers.
>>>>>>>
>>>>>>> Right now the scan_element type details signs, bits, storage bits and
>>>>>>> shifts. However it lacks to tell the endianess within the storage bits.
>>>>>>> Good point. I'd completely forgotten about that.
>>>>>>>
>>>>>>> How about le:s16/32>>0 or be:s16/32>>0 for example?
>>>>>> Yup, that works for me.  In cases where it doesn't matter they driver
>>>>>> can pick one at random.
>>>>> We need another case - Some drivers use the (be|le)(x)_to_cpu() helpers,
>>>>> So in case these are used the endianess can be either or, depending on the host.
>>>>> So maybe have le|be|cpu?
>>>> I thought about that, but am inclined to say we just stop drivers doing the conversion.
>>>> Better to leave it up to userspace?
>>> Well - we have and definitely will have more drivers where the conversion may be
>>> to time consuming to do in kernel space.
>>> I really don't have a strong preference here - but the important thing is that we need
>>> to tell user space what format is placed into the buffers.
>> Agreed. Do it during move out of staging or do a mass push to the drivers now?
>>
> 
> removing the endianess conversion on the buffers needs to come along with the
> scan_element type update.
Not actually true.   We can assume all current drivers are converting to cpu endianness
so if it isn't specified output the local cpu endianess.  Then we can move drivers over
whenever we like.  We'll squash the cpu option on move out of staging though as don't
want that hanging around for ever more.
> On one hand side its important information that
> we currently missing, and should be fixed sooner than later.
> On the other side it may require also some datasheet research.
> But it shouldn't be to much, since all SPI devices typically use MSB first, so for
> multiple bytes read sequentially we end up with BE.

