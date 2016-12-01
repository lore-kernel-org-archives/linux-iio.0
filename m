Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ua0-f180.google.com ([209.85.217.180]:36198 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754732AbcLAMHu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Dec 2016 07:07:50 -0500
Received: by mail-ua0-f180.google.com with SMTP id b35so244913426uaa.3
        for <linux-iio@vger.kernel.org>; Thu, 01 Dec 2016 04:07:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d4c7f1ca-49d4-7abe-bfc9-e1728f62a9fb@metafoo.de>
References: <1480432969-20913-1-git-send-email-bgolaszewski@baylibre.com>
 <44cce3d5-f65e-1a35-20a4-5eb9fda42312@metafoo.de> <CAMpxmJWDWk-mXUHHGEKm-VVwzqEGLDQjc274Xq+Qwc2eN=YbsQ@mail.gmail.com>
 <d4c7f1ca-49d4-7abe-bfc9-e1728f62a9fb@metafoo.de>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Thu, 1 Dec 2016 13:07:06 +0100
Message-ID: <CAMpxmJV=2xK4tDFfyVfWy7xhbAOcTxhG-hSVeKXW=eavdRmerA@mail.gmail.com>
Subject: Re: [PATCH] iio: misc: add a generic regulator driver
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Patrick Titiano <ptitiano@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2016-11-30 11:10 GMT+01:00 Lars-Peter Clausen <lars@metafoo.de>:
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
>
> - Lars
>

I missed the fact that - unlike hwmon - the iio version of the ina2xx
driver is not capable of detecting a bad state and re-initializing
itself. But you're right in general of course.

Still, it made me think: what if we implement the suspend/resume
callbacks in struct device_driver to store/resume the state when
power-cycling? The core iio module would then call the suspend
callback before disabling the regulator. We wouldn't need to duplicate
similar code and DT bindings in every iio driver.

Best regards,
Bartosz Golaszewski
