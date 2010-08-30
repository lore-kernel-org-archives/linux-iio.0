Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:33393 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab0H3PhZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Aug 2010 11:37:25 -0400
Message-ID: <4C7BD157.8020003@cam.ac.uk>
Date: Mon, 30 Aug 2010 16:42:15 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] staging:iio sync drivers with current ABI
References: <1283165728-2231-2-git-send-email-manuel.stahl@iis.fraunhofer.de> <1283177032-7014-2-git-send-email-manuel.stahl@iis.fraunhofer.de> <4C7BC3C2.8090104@cam.ac.uk> <4C7BC78D.7030109@iis.fraunhofer.de>
In-Reply-To: <4C7BC78D.7030109@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/30/10 16:00, Manuel Stahl wrote:
> Am 30.08.2010 16:44, schrieb Jonathan Cameron:
>> On 08/30/10 15:03, Manuel Stahl wrote:
>>
>> Youch, I hadn't registered just how far away this lot were from the abi.
>> Thanks for doing this.
>>
>> I sometimes wonder if it would be better to loose all the macros and move
>> over to abi doc based enforcement (like hwmon does).  What do people think?
>> As can be seen in this patch, it makes very little difference in the length of
>> code.  Disadvantage is that it does add a review burden.
> 
> I think we should keep the macros. Then we can simply search for
> IIO_DEVICE_ATTR and IIO_CONST_ATTR in the drivers, as these are
> suspicious for declaring proprietary attributes. When the well known
> macros change they produce compile errors. Also good for finding
> broken drivers.
A good point.  As a general rule, lets say we don't introduce new ones into the
headers until either:

1) There are two drivers using them and they are something we are sure will stay in drivers
   (I'm still unconvinced by the reset attribute in many of Analog's drivers)
2) They are obviously general elements.  e.g. when we had the first magnetometer we
   introduced the magn parameters.  Let has also start being militant about the necessity to
   also document any new ones.  Either the first user updates the docs or someone else has
   to within a few days... I'll do them when I think pestering people about it will delay
   an otherwise good driver.
> 
>> Let's merge this fix anyway and consider whether to loose some of the macros
>> at a later date.
>>
>> Quite a bit of this fixes naming of parameter that weren't correct under the
>> previous abi.  Clearly we (meaning mainly me :) ) need to review drivers
>> much more closely for abi breakage.
> 
> As I said before, some macros are suspicious and we can search for them.
> i.e. IIO_DEV_ATTR_ACCEL_X_OFFSET and IIO_DEV_ATTR_ACCEL_X_SCALE should be rarely used as they're constant for most devices.
There are actually numerous multirange accelerometers.  It is mere coincidence that
we don't have any in tree yet but I take your point.
> 
>> An excellent patch.  Thank you very much for doing this.
>>
>> One minor white space introduction that I'd like you to clean up before
>> sending on.
>>
>>
>>> Signed-off-by: Manuel Stahl<manuel.stahl@iis.fraunhofer.de>
>> Signed-off-by: Jonathan Cameron<jic23@cam.ac.uk>
>>
> 
> 
>>>   static IIO_DEV_ATTR_ACCEL_X(adis16300_read_14bit_signed,
>>>           ADIS16300_XACCL_OUT);
>>> @@ -532,17 +537,17 @@ static IIO_DEV_ATTR_ACCEL_Y(adis16300_read_14bit_signed,
>>>           ADIS16300_YACCL_OUT);
>>>   static IIO_DEV_ATTR_ACCEL_Z(adis16300_read_14bit_signed,
>>>           ADIS16300_ZACCL_OUT);
>>> -static IIO_CONST_ATTR(accel_scale, "0.0006 g");
>>> +static IIO_CONST_ATTR_ACCEL_SCALE("0.0006 g");
>> Abi says that units should be m/s^2.  Also we shouldn't have units
>> in the attributes.   I've been meaning to clear them out.  They
>> just make userspace code more complex for no gain.
> 
> Ups, you're right with m/s^2, nevertheless is worth an extra patch. Sure, the units don't need to be there, but parsing is the same with or without (scanf just ignores the chars).
Cool.  Can I leave this one to you?
> 
>>>   static IIO_DEV_ATTR_INCLI_X(adis16300_read_13bit_signed,
>>>           ADIS16300_XINCLI_OUT);
>>>   static IIO_DEV_ATTR_INCLI_Y(adis16300_read_13bit_signed,
>>>           ADIS16300_YINCLI_OUT);
>>> -static IIO_CONST_ATTR(incli_scale, "0.044 d");
>>> +static IIO_CONST_ATTR_INCLI_SCALE("0.044 deg");
>>>
>>>   static IIO_DEV_ATTR_TEMP_RAW(adis16300_read_12bit_unsigned);
>>> -static IIO_CONST_ATTR(temp_offset, "198.16 K");
>>> -static IIO_CONST_ATTR(temp_scale, "0.14 K");
>>> +static IIO_CONST_ATTR_TEMP_OFFSET("198.16 K");
>>> +static IIO_CONST_ATTR_TEMP_SCALE("0.14 K");
>> These need to be suitable for conversion to milli degrees C to match
>> hwmon.
> I think scientific devices should stick to SI units.
I'd normally agree, but hwmon beat us in defining the interface and I
agree with Greg and Andrew Morton that the kernel is gaining too many
incompatible interfaces.  Hence for temp we follow them.  Same ought
to be true for in[m] and current measurements.  Guess I'll do an audit
of this sometime soon and make sure they are all the same.

Jonathan
