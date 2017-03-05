Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59524 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752392AbdCEKuA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Mar 2017 05:50:00 -0500
Subject: Re: [PATCH 0/4] iio: adc: Maxim max961x driver
To: jacopo mondi <jacopo@jmondi.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>, geert@linux-m68k.org,
        wsa+renesas@sang-engineering.com, magnus.damm@gmail.com,
        laurent.pinchart@ideasonboard.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com
References: <1487948756-25172-1-git-send-email-jacopo+renesas@jmondi.org>
 <f6b94b05-c0f8-239e-733d-dc93a7683184@kernel.org>
 <9a1d0108-8508-adc5-8985-d1133a3317fd@jmondi.org>
Cc: linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3e4b368b-102b-e626-3777-97e49bb5ae56@kernel.org>
Date: Sun, 5 Mar 2017 10:49:55 +0000
MIME-Version: 1.0
In-Reply-To: <9a1d0108-8508-adc5-8985-d1133a3317fd@jmondi.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/02/17 09:09, jacopo mondi wrote:
> Hi Jonathan,
> On 25/02/2017 17:09, Jonathan Cameron wrote:
>> On 24/02/17 15:05, Jacopo Mondi wrote:
>>> Hello!
>>>
>>> This series adds driver and documentation for Maxim max9611/max9612
>>> high-side current sense amplifier with 12-bit ADC and I2c interface.
>>> It also registers two devices installed on VDD_0.8V and DVFS_0.8V lines
>>> in Renesas r87796 Salvator-X board.
>>>
>>> The device provides several functionalities, and only some of them are
>>> currently supported by this driver.
>>> Particularly, the on-board op-amp and analog comparator are not currently
>>> supported.
>> More fun to come ;)
>>>
>>> A simplified integration schematic drawing is here reported:
>>>
>>>  ----o----/\/\/-----o-------|LOAD|---
>>>      |    shunt     |
>>>  ____|______________|___
>>>  |  RS+            RS-  |
>>>  |   |-----gain-----|   |
>>>  |          |           |
>>>  |          |           |
>>>  |max961x   |->| ADC |===== I2c
>>>  |______________________|
>>>
>>>
>>> The device provides though its 12-bits ADC the following informations:
>> information is it's own plural (silly English quirk of the day!)
>>
>>> - Common input voltage on RS+
>>> - Voltage drop between RS+ and RS- ends
>>> - Die temperature
>>>
>>> All of the above ones are exposed though IIO with _raw and _scale values
>>> (plus _input for milli degree Celsius die temperature).
>>>
>>> From the above values the driver calculates the current flowing between
>>> RS+ and RS- ends, using the shunt resistor value provided by device tree, and
>>> the power load. Again this values are exposed through _raw and _scale
>>> attributes, which I'm not completely sure it's acceptables as they are
>>> calculated values and not natively provided by the current sense amplifier.
>>> I would like to hear IIO people opinions on this, if they should be better
>>> exposed though some other attributes which are not _raw and _scale, or if
>>> their calculation should be completely left to userspace tools.
>> So one element of the implementation is a problem.
>> Because of the dynamic gain adjustment you are doing in the driver (which I
>> rather like BTW) there will be instabilities in the computed values that
>> userspace comes up with when we are near a transition for in the current
>> sense amplifier gain.  We can't do that as crazy outputs will result
>> (read offset and scale for possible different values of that gain then
>> read the actual ADC value for a possible 3rd choice resulting in complete
>> garbage).
>>
>> So there are two ways to avoid this:
>> 1. Move all that magic into the original reads and apply the gain and offset
>> before they get to userspace.
>> 2. Provide enough information for userspace to be able to compute everything
>> iff it is using buffered mode with a 'scan' covering all the channels in one
>> go.  Even then we'd have to explicitly allow reading of the PGA gain as a
>> channel, or make userspace responsible for doing your autogain stuff.
>>
>> 1 is probably easier but will make implementing 2 as a follow up will be tricky
>> and would be needed if you want to read this stuff faster than sysfs will
>> allow.
>>
>> It's a shame, but my gut feeling is you want to drop the autogain stuff
>> as then it all becomes straight forward.
>>
>> What do others think?
>>
> 
> Just to add the following element to the discussion.
> 
> The device supports cycling between channels by itself, sequentially cycling between them every 2 msec.
> At the same time, gain setting is not involved in this procedure, and last applied is used on current sense voltage channel.
> 
> Still this does not help with un-synchronized reads of gain-dependent values, as offset and scale are.
> 
> Also, removing auto-gain setting routine will simplify stuff, but I don't see how all becomes straight forward then. I mean, if we keep gain at a fixed value, yes everything's easier, but it will work under a much more limited pre-conditions set...

You'd be moving the issue to userspace.  This would be beneficial if you
were looking to use the buffered interfaces (through a kfifo).  In those
cases processed values are often a non starter as they don't have well
defined 'sizes' in the same way that a reading directly from the chip does.

So under those circumstances, your userspace code might elect to modify
the gain to get in the 'right' region only at startup, or after some initial
'calibration data capture'.  Then it could merily stream data out without
caring about it.  To run remotely fast and consistenty you'd have to stop
doing the multiple passes needed for autogain.

However, if that interface never makes sense for this device anyway then
it the approach of doing it all in kernel makes more sense.

With a 500sps device like this it's on the boundary to my mind...

Quick enough that using the chardev access makes sense, but the usecase
is perhaps such that we should leave this all in kernel space.

It's slightly horrible but there is a path forward eventually if we
were to add buffered support having gone with the do it all in the kernel:
* Add a 'autorange_enable' attribute to allow us to turn it off or implicitly
assume that it is turned off if we are doing buffered capture (which is a bit
nasty from a 'doing what you'd expect' viewpoint).
* Add scale attributes at that stage.

Now, if the auto range stuff was done on the actual chip we could figure
out how to export that as pseudo channels alongside the real ones but
that might get uggly and isn't the case here anyway.

Jonathan


> 
> Thanks
>    j
> 
> 
>> Jonathan
>>>
>>> Thanks
>>>    j
>>>
>>> Jacopo Mondi (4):
>>>   Documentation: dt-bindings: iio: Add max961x
>>>   iio: Documentation: Add max961x sysfs documentation
>>>   iio: adc: Add max9611/9612 ADC driver
>>>   arm64: dts: salvator-x: Add current sense amplifiers
>>>
>>>  .../ABI/testing/sysfs-bus-iio-adc-max961x          |   5 +
>>>  .../devicetree/bindings/iio/adc/max961x.txt        |  27 +
>>>  arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |  17 +
>>>  drivers/iio/adc/Kconfig                            |  10 +
>>>  drivers/iio/adc/Makefile                           |   1 +
>>>  drivers/iio/adc/max961x.c                          | 648 +++++++++++++++++++++
>>>  6 files changed, 708 insertions(+)
>>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-max961x
>>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/max961x.txt
>>>  create mode 100644 drivers/iio/adc/max961x.c
>>>
>>
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

