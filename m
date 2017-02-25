Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:34678 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751299AbdBYPe3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Feb 2017 10:34:29 -0500
MIME-Version: 1.0
In-Reply-To: <a0217564-0730-16f2-491f-86ea3561dc2e@kernel.org>
References: <1487948756-25172-1-git-send-email-jacopo+renesas@jmondi.org>
 <1487948756-25172-2-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdU9UL9ZyiPJqtTTNS=KOScu6M3c7jQgD1vZ+gTiTCAYMA@mail.gmail.com>
 <64ed3cde-7627-eb60-c507-b68447012502@metafoo.de> <a67f7cf1-b676-5306-9e3d-4768a6e53357@jmondi.org>
 <a0217564-0730-16f2-491f-86ea3561dc2e@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 25 Feb 2017 16:34:27 +0100
Message-ID: <CAMuHMdUzT5gSoXEyDeaKSdKBaT4jEVCKOSChxdR0bbniaz_qvA@mail.gmail.com>
Subject: Re: [PATCH 1/4] Documentation: dt-bindings: iio: Add max961x
To: Jonathan Cameron <jic23@kernel.org>
Cc: jacopo mondi <jacopo@jmondi.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hartmut Knaack <knaack.h@gmx.de>, meerw@pmeerw.net,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

On Sat, Feb 25, 2017 at 4:19 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 24/02/17 15:48, jacopo mondi wrote:
>> On 24/02/2017 16:33, Lars-Peter Clausen wrote:
>>> On 02/24/2017 04:22 PM, Geert Uytterhoeven wrote:
>>>> On Fri, Feb 24, 2017 at 4:05 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/iio/adc/max961x.txt
>>>>> @@ -0,0 +1,27 @@
>>>>> +* Maxim max9611/max9612 current sense amplifier with 12-bits ADC interface
>>>>> +
>>>>> +Maxim max9611/max9612 is an high-side current sense amplifier with integrated
>>>>> +12-bits ADC communicating over I2c bus.
>>>>> +The device node for this driver shall be a child of a I2c controller.
>>>>> +
>>>>> +Required properties
>>>>> +  - compatible: Should be "maxim,max961x"
>>>>> +  - reg: The 7-bits long I2c address of the device
>>>>> +  - shunt-resistor: Resistor value, in uOhm, of the current sense shunt
>>>>> +                   resistor.
>>>>
>>>> shunt-resistor-micro-ohms?
>>>
>>> I'll take this one further:
>>>
>>> maxim,shunt-resistor-micro-ohms?
>>>
>>> Although there is precedence for just 'shunt-resistor' in the ina2xx bindings.
>>>
>>
>> And that's where I took "inspiration" from :)
> Which raises another open question.  Why IIO rather than hwmon like the ina2xx?

Actually we have both drivers/hwmon/ina2xx.c and drivers/iio/adc/ina2xx-adc.c.

> Whether we are better going for the existing binding without units, or
> 'fixing' that is a question for the device tree maintainers.  I guess that
> one snuck through.

ltc4151 uses shunt-resistor-micro-ohms.
sgtl5000 uses micbias-resistor-k-ohms.

So there's precedence for everything ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
