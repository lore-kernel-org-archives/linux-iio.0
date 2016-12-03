Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57103 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752843AbcLCOkS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Dec 2016 09:40:18 -0500
Subject: Re: [PATCH] iio: misc: add a generic regulator driver
To: Lars-Peter Clausen <lars@metafoo.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <1480432969-20913-1-git-send-email-bgolaszewski@baylibre.com>
 <44cce3d5-f65e-1a35-20a4-5eb9fda42312@metafoo.de>
 <CAMpxmJWDWk-mXUHHGEKm-VVwzqEGLDQjc274Xq+Qwc2eN=YbsQ@mail.gmail.com>
 <d4c7f1ca-49d4-7abe-bfc9-e1728f62a9fb@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
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
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <bf3dde7e-cee8-c54c-db93-447ffa063116@kernel.org>
Date: Sat, 3 Dec 2016 09:11:05 +0000
MIME-Version: 1.0
In-Reply-To: <d4c7f1ca-49d4-7abe-bfc9-e1728f62a9fb@metafoo.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/11/16 10:10, Lars-Peter Clausen wrote:
> On 11/29/2016 04:35 PM, Bartosz Golaszewski wrote:
>> 2016-11-29 16:30 GMT+01:00 Lars-Peter Clausen <lars@metafoo.de>:
>>> On 11/29/2016 04:22 PM, Bartosz Golaszewski wrote:
>>> [...]
>>>> diff --git a/Documentation/devicetree/bindings/iio/misc/iio-regulator.txt b/Documentation/devicetree/bindings/iio/misc/iio-regulator.txt
>>>> new file mode 100644
>>>> index 0000000..147458f
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/iio/misc/iio-regulator.txt
>>>> @@ -0,0 +1,18 @@
>>>> +Industrial IO regulator device driver
>>>> +-------------------------------------
>>>> +
>>>> +This document describes the bindings for the iio-regulator - a dummy device
>>>> +driver representing a physical regulator within the iio framework.
>>>
>>> No bindings for drivers, only for hardware. So this wont work.
>>>
>>
>> What about exporting regulator attributes analogous to the one in this
>> patch from the iio-core when a *-supply property is specified for a
>> node?
> 
> The problem with exposing direct control to the regulator is that it allows
> to modify the hardware state without the drivers knowledge. If you
> power-cycle a device all previous configuration that has been written to the
> device is reset. The device driver needs to be aware of this otherwise its
> assumed state and the actual device state can divert which will result in
> undefined behavior. Also access to the device will fail unexpectedly when
> the regulator is turned off. So I think generally the driver should
> explicitly control the regulator, power-up when needed, power-down when not.
I agree with what Lars has said.

There 'may' be some argument to ultimately have a bridge driver from
regulators to IIO.  That would be for cases where the divide between a regulator
and a DAC is blurred.  However it would still have to play nicely with the
regulator framework and any other devices registered on that regulator.
Ultimately the ideal in that case would then be to describe what the DAC is
actually being used to do but that's a more complex issue!

That doesn't seem to be what you are targeting here.

What it sounds like you need is to have the hardware well enough described that
the standard runtime power management can disable the regulator just fine when
it is not in use.  This may mean improving the power management in the relevant
drivers.

Jonathan

p.s. If ever proposing to do something 'unusual' with a regulator you should
bring in the regulator framework maintainers in the cc list.
> 
> - Lars
> 

