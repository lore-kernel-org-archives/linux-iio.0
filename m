Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:32825 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751488AbcLFLUg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Dec 2016 06:20:36 -0500
Received: by mail-vk0-f47.google.com with SMTP id 137so194221678vkl.0
        for <linux-iio@vger.kernel.org>; Tue, 06 Dec 2016 03:20:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <bf3dde7e-cee8-c54c-db93-447ffa063116@kernel.org>
References: <1480432969-20913-1-git-send-email-bgolaszewski@baylibre.com>
 <44cce3d5-f65e-1a35-20a4-5eb9fda42312@metafoo.de> <CAMpxmJWDWk-mXUHHGEKm-VVwzqEGLDQjc274Xq+Qwc2eN=YbsQ@mail.gmail.com>
 <d4c7f1ca-49d4-7abe-bfc9-e1728f62a9fb@metafoo.de> <bf3dde7e-cee8-c54c-db93-447ffa063116@kernel.org>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Tue, 6 Dec 2016 12:12:44 +0100
Message-ID: <CAMpxmJVJ+y9tRbRBsVg+i0EJO_6EFuvrypwC=ETnBWbMnxRFyg@mail.gmail.com>
Subject: Re: [PATCH] iio: misc: add a generic regulator driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Patrick Titiano <ptitiano@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2016-12-03 10:11 GMT+01:00 Jonathan Cameron <jic23@kernel.org>:
> On 30/11/16 10:10, Lars-Peter Clausen wrote:
>> On 11/29/2016 04:35 PM, Bartosz Golaszewski wrote:
>>> 2016-11-29 16:30 GMT+01:00 Lars-Peter Clausen <lars@metafoo.de>:
>>>> On 11/29/2016 04:22 PM, Bartosz Golaszewski wrote:
>>>> [...]
>>>>> diff --git a/Documentation/devicetree/bindings/iio/misc/iio-regulator.txt b/Documentation/devicetree/bindings/iio/misc/iio-regulator.txt
>>>>> new file mode 100644
>>>>> index 0000000..147458f
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/iio/misc/iio-regulator.txt
>>>>> @@ -0,0 +1,18 @@
>>>>> +Industrial IO regulator device driver
>>>>> +-------------------------------------
>>>>> +
>>>>> +This document describes the bindings for the iio-regulator - a dummy device
>>>>> +driver representing a physical regulator within the iio framework.
>>>>
>>>> No bindings for drivers, only for hardware. So this wont work.
>>>>
>>>
>>> What about exporting regulator attributes analogous to the one in this
>>> patch from the iio-core when a *-supply property is specified for a
>>> node?
>>
>> The problem with exposing direct control to the regulator is that it allows
>> to modify the hardware state without the drivers knowledge. If you
>> power-cycle a device all previous configuration that has been written to the
>> device is reset. The device driver needs to be aware of this otherwise its
>> assumed state and the actual device state can divert which will result in
>> undefined behavior. Also access to the device will fail unexpectedly when
>> the regulator is turned off. So I think generally the driver should
>> explicitly control the regulator, power-up when needed, power-down when not.
> I agree with what Lars has said.
>
> There 'may' be some argument to ultimately have a bridge driver from
> regulators to IIO.  That would be for cases where the divide between a regulator
> and a DAC is blurred.  However it would still have to play nicely with the
> regulator framework and any other devices registered on that regulator.
> Ultimately the ideal in that case would then be to describe what the DAC is
> actually being used to do but that's a more complex issue!
>
> That doesn't seem to be what you are targeting here.
>
> What it sounds like you need is to have the hardware well enough described that
> the standard runtime power management can disable the regulator just fine when
> it is not in use.  This may mean improving the power management in the relevant
> drivers.
>
> Jonathan
>
> p.s. If ever proposing to do something 'unusual' with a regulator you should
> bring in the regulator framework maintainers in the cc list.
>>
>> - Lars
>>
>

I wrote the initial patch quickly and didn't give it much of a
thought. Now I realized I completely missed the point and managed to
confuse everybody - myself included.

So the problem we have is not power-cycling the adc - it's
power-cycling the device connected to a probe on which there's an adc.
What I was trying to do was adding support for the power-switch on
baylibre-acme[1] probes.

For example: we have a USB probe on which the VBUS signal goes through
a power load switch and than through the adc. The adc (in this case
ina226) is always powered on, while the fixed regulator I wanted to
enable/disable actually drives the power switch to cut/restore power
to the connected USB device i.e. there's no real regulator - just a
GPIO driving the power switch.

A typical use case is measuring the power consumption of development
boards[2]. Rebooting them remotely using acme probes is already done,
but we're using the obsolete /sys/class/gpio interface.

We're already using libiio to read the measured data from the power
monitor, that's why we'd like to use the iio framework for
power-cycling the devices as well. My question is: would bridging the
regulator framework be the right solution? Should we look for
something else? Bridge the GPIO framework instead?

Best regards,
Bartosz Golaszewski

[1] http://baylibre.com/acme/
[2] https://github.com/BayLibre/POWERCI
