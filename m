Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36135 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752811AbdAJSxK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Jan 2017 13:53:10 -0500
Received: by mail-wm0-f68.google.com with SMTP id r126so11543504wmr.3
        for <linux-iio@vger.kernel.org>; Tue, 10 Jan 2017 10:53:09 -0800 (PST)
Subject: Re: [PATCH V2] iio: adc: Add Renesas GyroADC driver
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <20170109000309.22511-1-marek.vasut@gmail.com>
 <CAMuHMdXtx3xufjnCmTXpY2YoW4u1acyP+w9tfx1aTAYogCHUKg@mail.gmail.com>
 <801f56bf-1947-bf21-1aae-ca9c044033e1@gmail.com>
 <CAMuHMdWiYziY5KrouzyywhVJXR9gVDuFnA-gVhWWmUicRC42Dw@mail.gmail.com>
 <6416e428-9e84-abb8-813a-591cfa6575e0@gmail.com>
 <CAMuHMdUG90GjQWeHvq10GhBvi6inp7HvOhDcRiVh=sxkMhcAJA@mail.gmail.com>
Cc: linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <cde93407-6963-f201-c384-6f7c01242f44@gmail.com>
Date: Tue, 10 Jan 2017 19:20:06 +0100
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUG90GjQWeHvq10GhBvi6inp7HvOhDcRiVh=sxkMhcAJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/09/2017 07:30 PM, Geert Uytterhoeven wrote:
> Hi Marek,
> 
> On Mon, Jan 9, 2017 at 6:30 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>>> On Mon, Jan 9, 2017 at 3:16 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>>>> On 01/09/2017 01:13 PM, Geert Uytterhoeven wrote:
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
>>>>>> @@ -0,0 +1,52 @@
>>>>>> +* Renesas RCar GyroADC device driver
>>>>>> +
>>>>>> +Required properties:
>>>>>> +- compatible:  Should be "renesas,r8a7791-gyroadc" for regular GyroADC or
>>>>>> +               "renesas,r8a7792-gyroadc" for a GyroADC without interrupt
>>>>>> +               block found in R8A7792.
>>>>>
>>>>> I would have kept "renesas,rcar-gyroadc", too.
>>>>
>>>> Do we have some sort of standard practice here ? Ie. NXP SoCs use the
>>>> oldest compatible SoC in the DT compat string (so the driver can bind
>>>> to that) and another DT compat string with that particular SoC name
>>>> encoded in it (so it's possible to discern it in the future in the
>>>> driver, if there is some problem).
>>>
>>> On Renesas SoCs, we usually define family- and SoC-specific compatible
>>> values, and match on the family-specific values if possible.
>>>
>>>>> Upon closer look, GyroADC in r8a7792 aka R-Car V2H has builtin interrupt
>>>>> functionality, (SPI IRQ 18), while other variants use the interrupt
>>>>> functionality of the Speed-pulse I/F (SPI IRQ 236), which is not present
>>>>> on V2H.
>>>>>
>>>>> Hence I think we can distinguish between the two variants by looking at
>>>>> the presence of an "interrupts" property, if we make that mandatory on
>>>>> V2H. If/when the need arises later, non-V2H variants will need a phandle
>>>>> to the Speed-pulse I/F to use its interrupt.
>>>>
>>>> Well, the interrupt is pretty much useless (it generates 100ms pulses),
>>>> all we want to do it set the register to 0x0 to make sure the block
>>>> doesn't generate any. Do we want to add interrupts property for just
>>>> this purpose ?
>>>
>>> The alternative is to let the driver match against all of
>>> "renesas,r8a77<n>-gyroadc" for n=78,79,90..96 (and more to come).
>>
>> I think this would be slightly better, since I can precisely support
>> only the SoC which I have and which I can test. Then again, there's
>> already "renesas,rcar-gen2-jpu" for example, which looks appealing to
>> use, but I think it's not a good idea as there might be some bug found
> 
> The JPU bindings also mandate specifying e.g. "renesas,jpu-r8a7791".
> 
>> in the hardware later on and the DT wouldn't allow us to discern that
>> block if it only has a "renesas,rcar-gyroadc" in it.
>>
>> I think using
>> compatible = "renesas,r8a77<n>-gyroadc", "renesas,rcar-gyroadc";
>> would work.
> 
> Yes, that's exactly what I meant.

Great :-)

>> The driver could match on "renesas,rcar-gyroadc" and if a bug is ever
>> found, the driver can match on "renesas,r8a77<n>-gyroadc"
>> instead and handle the bug.
> 
> The driver still needs to know if it's running on V2H or not, because of
> the interrupt registers.

Exactly, which is why "renesas,r8a7792-gyroadc" compatible is handled
and treated specially.

-- 
Best regards,
Marek Vasut
