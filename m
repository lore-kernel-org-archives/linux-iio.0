Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ua0-f169.google.com ([209.85.217.169]:34688 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754056AbcLKWXC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Dec 2016 17:23:02 -0500
Received: by mail-ua0-f169.google.com with SMTP id 51so66333737uai.1
        for <linux-iio@vger.kernel.org>; Sun, 11 Dec 2016 14:23:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <c028b2fc-7ed1-772c-82e3-b98a25f58ffb@kernel.org>
References: <1480432969-20913-1-git-send-email-bgolaszewski@baylibre.com>
 <44cce3d5-f65e-1a35-20a4-5eb9fda42312@metafoo.de> <CAMpxmJWDWk-mXUHHGEKm-VVwzqEGLDQjc274Xq+Qwc2eN=YbsQ@mail.gmail.com>
 <d4c7f1ca-49d4-7abe-bfc9-e1728f62a9fb@metafoo.de> <bf3dde7e-cee8-c54c-db93-447ffa063116@kernel.org>
 <CAMpxmJVJ+y9tRbRBsVg+i0EJO_6EFuvrypwC=ETnBWbMnxRFyg@mail.gmail.com> <c028b2fc-7ed1-772c-82e3-b98a25f58ffb@kernel.org>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Sun, 11 Dec 2016 23:23:00 +0100
Message-ID: <CAMpxmJVoOkwPwF3fdERtJXFjhFgR7cFmvQs88ybJScMAKxw6mg@mail.gmail.com>
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

2016-12-10 19:17 GMT+01:00 Jonathan Cameron <jic23@kernel.org>:
> On 06/12/16 11:12, Bartosz Golaszewski wrote:
>>
>> I wrote the initial patch quickly and didn't give it much of a
>> thought. Now I realized I completely missed the point and managed to
>> confuse everybody - myself included.
>>
>> So the problem we have is not power-cycling the adc - it's
>> power-cycling the device connected to a probe on which there's an adc.
>> What I was trying to do was adding support for the power-switch on
>> baylibre-acme[1] probes.
>>
>> For example: we have a USB probe on which the VBUS signal goes through
>> a power load switch and than through the adc. The adc (in this case
>> ina226) is always powered on, while the fixed regulator I wanted to
>> enable/disable actually drives the power switch to cut/restore power
>> to the connected USB device i.e. there's no real regulator - just a
>> GPIO driving the power switch.
>>
>> A typical use case is measuring the power consumption of development
>> boards[2]. Rebooting them remotely using acme probes is already done,
>> but we're using the obsolete /sys/class/gpio interface.
>>
>> We're already using libiio to read the measured data from the power
>> monitor, that's why we'd like to use the iio framework for
>> power-cycling the devices as well. My question is: would bridging the
>> regulator framework be the right solution? Should we look for
>> something else? Bridge the GPIO framework instead?
>
> Definitely doesn't fit inside standard scope of IIO - though I can see
> why you were thinking along these lines.
>

Well, it's industrial INPUT/output right? I guess we can consider
power-cycling input in this case. :)

In our particular use case, the main reason for using IIO is having a
single interface (libiio) instead of introducing a new one just for
that (in the form of random sysfs attributes for example), but I'm
sure such power switches could find application elsewhere too
(measuring temperature, while power-cycling some cooling mechanism is
the first thing that comes to mind).

> Mark Brown, any thoughts?
>
> Effectively we are are looking at something that (in general form) might
> be the equivalent of controlling a lab bench supply... So regulators
> at the edge of the known world, with no visibility of what lies beyond.
>

Please consider the two patches I just sent. Instead of regulators,
they add DT bindings for gpio power switches and introduce a simple
iio driver using the gpio consumer API.

Best regards,
Bartosz Golaszewski
