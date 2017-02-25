Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46439 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751324AbdBYQJK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Feb 2017 11:09:10 -0500
Subject: Re: [PATCH 0/4] iio: adc: Maxim max961x driver
To: Jacopo Mondi <jacopo+renesas@jmondi.org>, geert@linux-m68k.org,
        wsa+renesas@sang-engineering.com, magnus.damm@gmail.com,
        laurent.pinchart@ideasonboard.com, knaack.h@gmx.de,
        lars@metafoo.de, meerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com
References: <1487948756-25172-1-git-send-email-jacopo+renesas@jmondi.org>
Cc: linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f6b94b05-c0f8-239e-733d-dc93a7683184@kernel.org>
Date: Sat, 25 Feb 2017 16:09:05 +0000
MIME-Version: 1.0
In-Reply-To: <1487948756-25172-1-git-send-email-jacopo+renesas@jmondi.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/02/17 15:05, Jacopo Mondi wrote:
> Hello!
> 
> This series adds driver and documentation for Maxim max9611/max9612
> high-side current sense amplifier with 12-bit ADC and I2c interface.
> It also registers two devices installed on VDD_0.8V and DVFS_0.8V lines
> in Renesas r87796 Salvator-X board.
> 
> The device provides several functionalities, and only some of them are
> currently supported by this driver.
> Particularly, the on-board op-amp and analog comparator are not currently
> supported.
More fun to come ;)
> 
> A simplified integration schematic drawing is here reported:
> 
>  ----o----/\/\/-----o-------|LOAD|---
>      |    shunt     |
>  ____|______________|___
>  |  RS+            RS-  |
>  |   |-----gain-----|   |
>  |          |           |
>  |          |           |
>  |max961x   |->| ADC |===== I2c
>  |______________________|
> 
> 
> The device provides though its 12-bits ADC the following informations:
information is it's own plural (silly English quirk of the day!)

> - Common input voltage on RS+
> - Voltage drop between RS+ and RS- ends
> - Die temperature
> 
> All of the above ones are exposed though IIO with _raw and _scale values
> (plus _input for milli degree Celsius die temperature).
> 
> From the above values the driver calculates the current flowing between
> RS+ and RS- ends, using the shunt resistor value provided by device tree, and
> the power load. Again this values are exposed through _raw and _scale
> attributes, which I'm not completely sure it's acceptables as they are
> calculated values and not natively provided by the current sense amplifier.
> I would like to hear IIO people opinions on this, if they should be better
> exposed though some other attributes which are not _raw and _scale, or if
> their calculation should be completely left to userspace tools.
So one element of the implementation is a problem.
Because of the dynamic gain adjustment you are doing in the driver (which I
rather like BTW) there will be instabilities in the computed values that
userspace comes up with when we are near a transition for in the current
sense amplifier gain.  We can't do that as crazy outputs will result
(read offset and scale for possible different values of that gain then
read the actual ADC value for a possible 3rd choice resulting in complete
garbage).

So there are two ways to avoid this:
1. Move all that magic into the original reads and apply the gain and offset
before they get to userspace.
2. Provide enough information for userspace to be able to compute everything
iff it is using buffered mode with a 'scan' covering all the channels in one
go.  Even then we'd have to explicitly allow reading of the PGA gain as a
channel, or make userspace responsible for doing your autogain stuff.

1 is probably easier but will make implementing 2 as a follow up will be tricky
and would be needed if you want to read this stuff faster than sysfs will
allow. 

It's a shame, but my gut feeling is you want to drop the autogain stuff
as then it all becomes straight forward.

What do others think?

Jonathan
> 
> Thanks
>    j
> 
> Jacopo Mondi (4):
>   Documentation: dt-bindings: iio: Add max961x
>   iio: Documentation: Add max961x sysfs documentation
>   iio: adc: Add max9611/9612 ADC driver
>   arm64: dts: salvator-x: Add current sense amplifiers
> 
>  .../ABI/testing/sysfs-bus-iio-adc-max961x          |   5 +
>  .../devicetree/bindings/iio/adc/max961x.txt        |  27 +
>  arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |  17 +
>  drivers/iio/adc/Kconfig                            |  10 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/max961x.c                          | 648 +++++++++++++++++++++
>  6 files changed, 708 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-max961x
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/max961x.txt
>  create mode 100644 drivers/iio/adc/max961x.c
> 

