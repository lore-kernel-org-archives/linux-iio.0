Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-30.csi.cam.ac.uk ([131.111.8.130]:55726 "EHLO
	ppsw-30.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755801Ab0H3QC0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Aug 2010 12:02:26 -0400
Message-ID: <4C7BD734.7010309@cam.ac.uk>
Date: Mon, 30 Aug 2010 17:07:16 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] staging:iio sync drivers with current ABI
References: <1283165728-2231-2-git-send-email-manuel.stahl@iis.fraunhofer.de> <1283177032-7014-2-git-send-email-manuel.stahl@iis.fraunhofer.de> <4C7BC3C2.8090104@cam.ac.uk> <4C7BC78D.7030109@iis.fraunhofer.de> <4C7BD157.8020003@cam.ac.uk> <4C7BD2B0.20508@iis.fraunhofer.de>
In-Reply-To: <4C7BD2B0.20508@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/30/10 16:48, Manuel Stahl wrote:
> Am 30.08.2010 17:42, schrieb Jonathan Cameron:
>> On 08/30/10 16:00, Manuel Stahl wrote:
>>> Am 30.08.2010 16:44, schrieb Jonathan Cameron:
>>>> On 08/30/10 15:03, Manuel Stahl wrote:
>>>>
>>>> Youch, I hadn't registered just how far away this lot were from the abi.
>>>> Thanks for doing this.
>>>>
>>>> I sometimes wonder if it would be better to loose all the macros and move
>>>> over to abi doc based enforcement (like hwmon does).  What do people think?
>>>> As can be seen in this patch, it makes very little difference in the length of
>>>> code.  Disadvantage is that it does add a review burden.
>>>
>>> I think we should keep the macros. Then we can simply search for
>>> IIO_DEVICE_ATTR and IIO_CONST_ATTR in the drivers, as these are
>>> suspicious for declaring proprietary attributes. When the well known
>>> macros change they produce compile errors. Also good for finding
>>> broken drivers.
>> A good point.  As a general rule, lets say we don't introduce new ones into the
>> headers until either:
>>
>> 1) There are two drivers using them and they are something we are sure will stay in drivers
>>     (I'm still unconvinced by the reset attribute in many of Analog's drivers)
> 
> I think this is the case for supply, so we could add a macro for this one.
Indeed, that one is clearly a common case.
> 
>> 2) They are obviously general elements.  e.g. when we had the first magnetometer we
>>     introduced the magn parameters.  Let has also start being militant about the necessity to
>>     also document any new ones.  Either the first user updates the docs or someone else has
>>     to within a few days... I'll do them when I think pestering people about it will delay
>>     an otherwise good driver.
> 
> Good point.
> 
> 
>>>>>    static IIO_DEV_ATTR_ACCEL_X(adis16300_read_14bit_signed,
>>>>>            ADIS16300_XACCL_OUT);
>>>>> @@ -532,17 +537,17 @@ static IIO_DEV_ATTR_ACCEL_Y(adis16300_read_14bit_signed,
>>>>>            ADIS16300_YACCL_OUT);
>>>>>    static IIO_DEV_ATTR_ACCEL_Z(adis16300_read_14bit_signed,
>>>>>            ADIS16300_ZACCL_OUT);
>>>>> -static IIO_CONST_ATTR(accel_scale, "0.0006 g");
>>>>> +static IIO_CONST_ATTR_ACCEL_SCALE("0.0006 g");
>>>> Abi says that units should be m/s^2.  Also we shouldn't have units
>>>> in the attributes.   I've been meaning to clear them out.  They
>>>> just make userspace code more complex for no gain.
>>>
>>> Ups, you're right with m/s^2, nevertheless is worth an extra patch. Sure, the units don't need to be there, but parsing is the same with or without (scanf just ignores the chars).
>> Cool.  Can I leave this one to you?
> 
> Ok, guess I also introduced the mess here.
Thanks ;)  There are others sculling about, but an audit ought to
pick them up.
> 
>>>>>    static IIO_DEV_ATTR_INCLI_X(adis16300_read_13bit_signed,
>>>>>            ADIS16300_XINCLI_OUT);
>>>>>    static IIO_DEV_ATTR_INCLI_Y(adis16300_read_13bit_signed,
>>>>>            ADIS16300_YINCLI_OUT);
>>>>> -static IIO_CONST_ATTR(incli_scale, "0.044 d");
>>>>> +static IIO_CONST_ATTR_INCLI_SCALE("0.044 deg");
>>>>>
>>>>>    static IIO_DEV_ATTR_TEMP_RAW(adis16300_read_12bit_unsigned);
>>>>> -static IIO_CONST_ATTR(temp_offset, "198.16 K");
>>>>> -static IIO_CONST_ATTR(temp_scale, "0.14 K");
>>>>> +static IIO_CONST_ATTR_TEMP_OFFSET("198.16 K");
>>>>> +static IIO_CONST_ATTR_TEMP_SCALE("0.14 K");
>>>> These need to be suitable for conversion to milli degrees C to match
>>>> hwmon.
>>> I think scientific devices should stick to SI units.
>> I'd normally agree, but hwmon beat us in defining the interface and I
>> agree with Greg and Andrew Morton that the kernel is gaining too many
>> incompatible interfaces.  Hence for temp we follow them.  Same ought
>> to be true for in[m] and current measurements.  Guess I'll do an audit
>> of this sometime soon and make sure they are all the same.
> 
> We already have a major difference here, that is we allow floating
> point values as output. Also we have no _input postfix, which, I
> agree, should be compatible if it was there. Hwmon is tuned to fixed
> point values, but that it too limited for the range of devices we
> want to address with IIO. They simply don't care if they loose some
> bit of precision.
We do allow _input.  Only one user at the moment though.  illuminance0_input
in the tsl2563 driver.  The intent was always to extend their interface
but not to break comparability if we can easily avoid it.  I should probably
document the fact we allow this. It's useful for slow devices with non linear
mappings between their raw values and the measurement. (very common in light
sensors).  Things will get more 'interesting' when we have a fast device
with a non linear mapping.  We'll figure that out what to do about that
if / when some has such a device.

I agree that fixed point is overly limiting for our purposes. However, by
simply allowing ours to use floating point userspace can accommodate either.
Afterall in most cases a floating point read of an integer string will give
the right (or very close to it) result.

Basically my intent (supported by others in the abi discussions) is to match and extend
hwmon wherever possible.  I'm actively advocating this approach elsewhere in the
kernel as well.

Jonathan
