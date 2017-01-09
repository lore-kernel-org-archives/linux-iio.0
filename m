Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:34790 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162922AbdAISaI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jan 2017 13:30:08 -0500
Received: by mail-it0-f65.google.com with SMTP id q186so10235777itb.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Jan 2017 10:30:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <6416e428-9e84-abb8-813a-591cfa6575e0@gmail.com>
References: <20170109000309.22511-1-marek.vasut@gmail.com> <CAMuHMdXtx3xufjnCmTXpY2YoW4u1acyP+w9tfx1aTAYogCHUKg@mail.gmail.com>
 <801f56bf-1947-bf21-1aae-ca9c044033e1@gmail.com> <CAMuHMdWiYziY5KrouzyywhVJXR9gVDuFnA-gVhWWmUicRC42Dw@mail.gmail.com>
 <6416e428-9e84-abb8-813a-591cfa6575e0@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Jan 2017 19:30:07 +0100
Message-ID: <CAMuHMdUG90GjQWeHvq10GhBvi6inp7HvOhDcRiVh=sxkMhcAJA@mail.gmail.com>
Subject: Re: [PATCH V2] iio: adc: Add Renesas GyroADC driver
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Marek,

On Mon, Jan 9, 2017 at 6:30 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> On Mon, Jan 9, 2017 at 3:16 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>>> On 01/09/2017 01:13 PM, Geert Uytterhoeven wrote:
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
>>>>> @@ -0,0 +1,52 @@
>>>>> +* Renesas RCar GyroADC device driver
>>>>> +
>>>>> +Required properties:
>>>>> +- compatible:  Should be "renesas,r8a7791-gyroadc" for regular GyroADC or
>>>>> +               "renesas,r8a7792-gyroadc" for a GyroADC without interrupt
>>>>> +               block found in R8A7792.
>>>>
>>>> I would have kept "renesas,rcar-gyroadc", too.
>>>
>>> Do we have some sort of standard practice here ? Ie. NXP SoCs use the
>>> oldest compatible SoC in the DT compat string (so the driver can bind
>>> to that) and another DT compat string with that particular SoC name
>>> encoded in it (so it's possible to discern it in the future in the
>>> driver, if there is some problem).
>>
>> On Renesas SoCs, we usually define family- and SoC-specific compatible
>> values, and match on the family-specific values if possible.
>>
>>>> Upon closer look, GyroADC in r8a7792 aka R-Car V2H has builtin interrupt
>>>> functionality, (SPI IRQ 18), while other variants use the interrupt
>>>> functionality of the Speed-pulse I/F (SPI IRQ 236), which is not present
>>>> on V2H.
>>>>
>>>> Hence I think we can distinguish between the two variants by looking at
>>>> the presence of an "interrupts" property, if we make that mandatory on
>>>> V2H. If/when the need arises later, non-V2H variants will need a phandle
>>>> to the Speed-pulse I/F to use its interrupt.
>>>
>>> Well, the interrupt is pretty much useless (it generates 100ms pulses),
>>> all we want to do it set the register to 0x0 to make sure the block
>>> doesn't generate any. Do we want to add interrupts property for just
>>> this purpose ?
>>
>> The alternative is to let the driver match against all of
>> "renesas,r8a77<n>-gyroadc" for n=78,79,90..96 (and more to come).
>
> I think this would be slightly better, since I can precisely support
> only the SoC which I have and which I can test. Then again, there's
> already "renesas,rcar-gen2-jpu" for example, which looks appealing to
> use, but I think it's not a good idea as there might be some bug found

The JPU bindings also mandate specifying e.g. "renesas,jpu-r8a7791".

> in the hardware later on and the DT wouldn't allow us to discern that
> block if it only has a "renesas,rcar-gyroadc" in it.
>
> I think using
> compatible = "renesas,r8a77<n>-gyroadc", "renesas,rcar-gyroadc";
> would work.

Yes, that's exactly what I meant.

> The driver could match on "renesas,rcar-gyroadc" and if a bug is ever
> found, the driver can match on "renesas,r8a77<n>-gyroadc"
> instead and handle the bug.

The driver still needs to know if it's running on V2H or not, because of
the interrupt registers.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
