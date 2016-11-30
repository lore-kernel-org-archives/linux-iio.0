Return-Path: <lars@metafoo.de>
Subject: Re: [PATCH] iio: misc: add a generic regulator driver
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <1480432969-20913-1-git-send-email-bgolaszewski@baylibre.com>
 <44cce3d5-f65e-1a35-20a4-5eb9fda42312@metafoo.de>
 <CAMpxmJWDWk-mXUHHGEKm-VVwzqEGLDQjc274Xq+Qwc2eN=YbsQ@mail.gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-iio@vger.kernel.org, linux-devicetree <devicetree@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Patrick Titiano <ptitiano@baylibre.com>,
 Neil Armstrong <narmstrong@baylibre.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <d4c7f1ca-49d4-7abe-bfc9-e1728f62a9fb@metafoo.de>
Date: Wed, 30 Nov 2016 11:10:36 +0100
MIME-Version: 1.0
In-Reply-To: <CAMpxmJWDWk-mXUHHGEKm-VVwzqEGLDQjc274Xq+Qwc2eN=YbsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 11/29/2016 04:35 PM, Bartosz Golaszewski wrote:
> 2016-11-29 16:30 GMT+01:00 Lars-Peter Clausen <lars@metafoo.de>:
>> On 11/29/2016 04:22 PM, Bartosz Golaszewski wrote:
>> [...]
>>> diff --git a/Documentation/devicetree/bindings/iio/misc/iio-regulator.txt b/Documentation/devicetree/bindings/iio/misc/iio-regulator.txt
>>> new file mode 100644
>>> index 0000000..147458f
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/misc/iio-regulator.txt
>>> @@ -0,0 +1,18 @@
>>> +Industrial IO regulator device driver
>>> +-------------------------------------
>>> +
>>> +This document describes the bindings for the iio-regulator - a dummy device
>>> +driver representing a physical regulator within the iio framework.
>>
>> No bindings for drivers, only for hardware. So this wont work.
>>
> 
> What about exporting regulator attributes analogous to the one in this
> patch from the iio-core when a *-supply property is specified for a
> node?

The problem with exposing direct control to the regulator is that it allows
to modify the hardware state without the drivers knowledge. If you
power-cycle a device all previous configuration that has been written to the
device is reset. The device driver needs to be aware of this otherwise its
assumed state and the actual device state can divert which will result in
undefined behavior. Also access to the device will fail unexpectedly when
the regulator is turned off. So I think generally the driver should
explicitly control the regulator, power-up when needed, power-down when not.

- Lars
