Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:36157 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751522AbdBXPyI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Feb 2017 10:54:08 -0500
MIME-Version: 1.0
In-Reply-To: <a489f2fc-4d15-42cc-fdcc-b41f60b4638a@jmondi.org>
References: <1487948756-25172-1-git-send-email-jacopo+renesas@jmondi.org>
 <1487948756-25172-2-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdWjtRZpjGi8BPkDGKGPr5uBr5jsjLi80COUDruZLuTXfQ@mail.gmail.com> <a489f2fc-4d15-42cc-fdcc-b41f60b4638a@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Feb 2017 16:54:06 +0100
Message-ID: <CAMuHMdU+omAOc6Z-0pG1EZx9wLP=+LnyWTHMzBSn_OPpqF-GNQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] Documentation: dt-bindings: iio: Add max961x
To: jacopo mondi <jacopo@jmondi.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jacopo,

On Fri, Feb 24, 2017 at 4:50 PM, jacopo mondi <jacopo@jmondi.org> wrote:
> On 24/02/2017 16:29, Geert Uytterhoeven wrote:
>> On Fri, Feb 24, 2017 at 4:05 PM, Jacopo Mondi <jacopo+renesas@jmondi.org>
>> wrote:
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/adc/max961x.txt
>>> @@ -0,0 +1,27 @@
>>> +* Maxim max9611/max9612 current sense amplifier with 12-bits ADC
>>> interface
>>> +
>>> +Maxim max9611/max9612 is an high-side current sense amplifier with
>>> integrated
>>> +12-bits ADC communicating over I2c bus.
>>> +The device node for this driver shall be a child of a I2c controller.
>>> +
>>> +Required properties
>>> +  - compatible: Should be "maxim,max961x"
>>
>>
>> I'ts not a good idea to use wildcards in compatible values.
>> Ask yourself: is this valid for any (future) value of "x"?
>
> I suspect you already know the answer here :)
>
>> Hence please use "maxim,max9611" or "maxim,max9612".
>> The only difference between these two is a noninverting vs. inverting
>> input-to-output configuration. Does the driver need to care?
>
> No, not right now, as the inverting/non-inverting output is on the
> op-amp/comparator side, which is currently not supported by this driver.
>
> Instead of using one or the other, should we use both, as long as it does
> not makes any difference from driver perspective?

DT describes the hardware, not current software limitations.
So yes, we want both (in the bindings/drivers, not in the same *.dts file ;-).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
