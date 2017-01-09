Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33602 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762630AbdAIRak (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jan 2017 12:30:40 -0500
Received: by mail-wm0-f65.google.com with SMTP id r144so14972910wme.0
        for <linux-iio@vger.kernel.org>; Mon, 09 Jan 2017 09:30:39 -0800 (PST)
Subject: Re: [PATCH V2] iio: adc: Add Renesas GyroADC driver
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <20170109000309.22511-1-marek.vasut@gmail.com>
 <CAMuHMdXtx3xufjnCmTXpY2YoW4u1acyP+w9tfx1aTAYogCHUKg@mail.gmail.com>
 <801f56bf-1947-bf21-1aae-ca9c044033e1@gmail.com>
 <CAMuHMdWiYziY5KrouzyywhVJXR9gVDuFnA-gVhWWmUicRC42Dw@mail.gmail.com>
Cc: linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <6416e428-9e84-abb8-813a-591cfa6575e0@gmail.com>
Date: Mon, 9 Jan 2017 18:30:29 +0100
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWiYziY5KrouzyywhVJXR9gVDuFnA-gVhWWmUicRC42Dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/09/2017 03:32 PM, Geert Uytterhoeven wrote:
> Hi Marek,

Hi!

> On Mon, Jan 9, 2017 at 3:16 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> On 01/09/2017 01:13 PM, Geert Uytterhoeven wrote:
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
>>>> @@ -0,0 +1,52 @@
>>>> +* Renesas RCar GyroADC device driver
>>>> +
>>>> +Required properties:
>>>> +- compatible:  Should be "renesas,r8a7791-gyroadc" for regular GyroADC or
>>>> +               "renesas,r8a7792-gyroadc" for a GyroADC without interrupt
>>>> +               block found in R8A7792.
>>>
>>> I would have kept "renesas,rcar-gyroadc", too.
>>
>> Do we have some sort of standard practice here ? Ie. NXP SoCs use the
>> oldest compatible SoC in the DT compat string (so the driver can bind
>> to that) and another DT compat string with that particular SoC name
>> encoded in it (so it's possible to discern it in the future in the
>> driver, if there is some problem).
> 
> On Renesas SoCs, we usually define family- and SoC-specific compatible
> values, and match on the family-specific values if possible.
> 
>>> Upon closer look, GyroADC in r8a7792 aka R-Car V2H has builtin interrupt
>>> functionality, (SPI IRQ 18), while other variants use the interrupt
>>> functionality of the Speed-pulse I/F (SPI IRQ 236), which is not present
>>> on V2H.
>>>
>>> Hence I think we can distinguish between the two variants by looking at
>>> the presence of an "interrupts" property, if we make that mandatory on
>>> V2H. If/when the need arises later, non-V2H variants will need a phandle
>>> to the Speed-pulse I/F to use its interrupt.
>>
>> Well, the interrupt is pretty much useless (it generates 100ms pulses),
>> all we want to do it set the register to 0x0 to make sure the block
>> doesn't generate any. Do we want to add interrupts property for just
>> this purpose ?
> 
> The alternative is to let the driver match against all of
> "renesas,r8a77<n>-gyroadc" for n=78,79,90..96 (and more to come).

I think this would be slightly better, since I can precisely support
only the SoC which I have and which I can test. Then again, there's
already "renesas,rcar-gen2-jpu" for example, which looks appealing to
use, but I think it's not a good idea as there might be some bug found
in the hardware later on and the DT wouldn't allow us to discern that
block if it only has a "renesas,rcar-gyroadc" in it.

I think using
compatible = "renesas,r8a77<n>-gyroadc", "renesas,rcar-gyroadc";
would work.

The driver could match on "renesas,rcar-gyroadc" and if a bug is ever
found, the driver can match on "renesas,r8a77<n>-gyroadc"
instead and handle the bug.

>>> Then the driver can just match on "renesas,rcar-gyroadc", instead of any
>>> other single version (all R-Car Gen1, 2, and 3 SoCs) in existence.
> 
>>>> +Optional properties:
>>>> +- renesas,gyroadc-vref-ch0-supply: Phandle to channel 0 voltage reference regulator.
>>>> +- renesas,gyroadc-vref-ch1-supply: Phandle to channel 1 voltage reference regulator.
>>>> +- renesas,gyroadc-vref-ch2-supply: Phandle to channel 2 voltage reference regulator.
>>>> +- renesas,gyroadc-vref-ch3-supply: Phandle to channel 3 voltage reference regulator.
>>>> +- renesas,gyroadc-vref-ch4-supply: Phandle to channel 4 voltage reference regulator.
>>>> +- renesas,gyroadc-vref-ch5-supply: Phandle to channel 5 voltage reference regulator.
>>>> +- renesas,gyroadc-vref-ch6-supply: Phandle to channel 6 voltage reference regulator.
>>>> +- renesas,gyroadc-vref-ch7-supply: Phandle to channel 7 voltage reference regulator.
>>>
>>> Why not an array of phandles? That would simplify parsing.
>>
>> Because if you connect ADC only to ie. channel 0 and 3 , specifying that
>> in an array would be a hassle .
> 
> IIRC, you can have zeroes ("NULL pointers") in phandle arrays.
> 
>>> Also, "vref-supply" seems a fairly standard property name already in wide use.
>>
>> The above would thus make this vref-chX-supply ?
> 
> vref-supply = <&vref1 0 0 &vref3>;

Not sure how I feel about this one, also it's the first time I saw such
method of describing regulator set.

>>>> +
>>>> +static void rcar_gyroadc_hw_init(struct rcar_gyroadc *priv)
>>>> +{
> 
>>>> +       if (priv->mode == RCAR_GYROADC_MODE_SELECT_1_MB88101A)
>>>> +               writel(clk_mhz * 10, priv->regs + RCAR_GYROADC_CLOCK_LENGTH);
>>>> +       else if (priv->mode == RCAR_GYROADC_MODE_SELECT_2_ADCS7476)
>>>> +               writel(clk_mhz * 5, priv->regs + RCAR_GYROADC_CLOCK_LENGTH);
>>>> +       else if (priv->mode == RCAR_GYROADC_MODE_SELECT_3_MAX1162)
>>>> +               writel(clk_mhz * 5, priv->regs + RCAR_GYROADC_CLOCK_LENGTH);
>>>
>>> switch(priv->mode)?
>>
>> That's actually make the code longer.
> 
> Oh, you looked at the compiler output :-)
> 
> Having a switch means you can combine the last two cases.
> 
> Actually, as mode is always a valid value here, you can just
> have if (<mode1>) { ... } else { ...}.

In fact, you can do
clk_mul = (priv->mode == ...) ? 10 : 5;
...
writel(clk_mhz * clk_mul, ....);

Done.

>>>> +static int rcar_gyroadc_read_raw(struct iio_dev *indio_dev,
>>>> +                                struct iio_chan_spec const *chan,
>>>> +                                int *val, int *val2, long mask)
>>>> +{
> 
>>>> +               *val2 = (vref * 1000) / 0x10000;
>>>
>>> DIV_ROUND_CLOSEST()?
>>
>> Why exactly ?
> 
> Because the end result is closer to the actual value.

Fixed.

-- 
Best regards,
Marek Vasut
