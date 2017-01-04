Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:33493 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbdADUgq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Jan 2017 15:36:46 -0500
MIME-Version: 1.0
In-Reply-To: <f4bb8922-36dc-ff69-45fc-e1d9cba821ba@gmail.com>
References: <20161230191800.2532-1-marek.vasut@gmail.com> <CAMuHMdX20kc8h4DiNLu0KwaA0FL6F-WXLnA3YXvu02VJTh_7fQ@mail.gmail.com>
 <f4bb8922-36dc-ff69-45fc-e1d9cba821ba@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 4 Jan 2017 21:36:45 +0100
Message-ID: <CAMuHMdVgaAD5EaK0aMS3HEXUeNQaz_ZiwG4cTtpDMMma_YWBbg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: Add Renesas GyroADC driver
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-iio@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Marek,

On Wed, Jan 4, 2017 at 3:27 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> On 01/02/2017 11:01 AM, Geert Uytterhoeven wrote:
>> On Fri, Dec 30, 2016 at 8:18 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
>>> @@ -0,0 +1,38 @@
>>> +* Renesas RCar GyroADC device driver
>>> +
>>> +Required properties:
>>> +- compatible:  Should be "renesas,rcar-gyroadc" for regular GyroADC or
>>> +               "renesas,rcar-gyroadc-r8a7792" for GyroADC without interrupt
>>
>> Please use "renesas,r8a7792-gyroadc" to match existing practices.
>
> Actually, that should probably be gyroadc-r8a7791 if we want to match
> the existing practice. Fixed.

No, "renesas,r8a7791-gyroadc" ("<vendor>,<family>-<block>").

>>> +static void rcar_gyroadc_hw_init(struct rcar_gyroadc *priv)
>>> +{
>>> +       unsigned long clk_mhz = clk_get_rate(priv->clk) / 1000000;
>>> +
>>> +       /* Stop the GyroADC. */
>>> +       writel(0, priv->regs + RCAR_GYROADC_START_STOP);
>>> +
>>> +       /* Disable IRQ, except on V2H. */
>>> +       if (priv->model != RCAR_GYROADC_MODEL_R8A7792)
>>> +               writel(0, priv->regs + RCAR_GYROADC_INTENR);
>>> +
>>> +       /* Set mode and timing. */
>>> +       writel(priv->mode, priv->regs + RCAR_GYROADC_MODE_SELECT);
>>> +
>>> +       if (priv->mode == RCAR_GYROADC_MODE_SELECT_1_MB88101A)
>>> +               writel(clk_mhz * 10, priv->regs + RCAR_GYROADC_CLOCK_LENGTH);
>>> +       else if (priv->mode == RCAR_GYROADC_MODE_SELECT_2_ADCS7476)
>>> +               writel(clk_mhz * 5, priv->regs + RCAR_GYROADC_CLOCK_LENGTH);
>>> +       else if (priv->mode == RCAR_GYROADC_MODE_SELECT_3_MAX1162)
>>> +               writel(clk_mhz * 5, priv->regs + RCAR_GYROADC_CLOCK_LENGTH);
>>> +       writel(clk_mhz * 1250, priv->regs + RCAR_GYROADC_1_25MS_LENGTH);
>>> +
>>> +       /*
>>> +        * We can possibly turn the sampling on/off on-demand to reduce power
>>
>> And the module clock, using runtime PM (see below).

>>> +static int rcar_gyroadc_probe(struct platform_device *pdev)
>>> +{
>>
>>> +       priv->fclk = devm_clk_get(dev, "fck");
>>
>> The module clock isn't used directly by this driver (you don't need
>> e.g. its rate),
>> so you can leave out all handling related to this clock iff you enable
>> runtime PM:
>>
>>     pm_runtime_enable(dev);
>>     pm_runtime_get_sync(dev);
>>
>> Then runtime PM will take care of enabling the module clock, as the
>> GyroADC block is part of the CPG/MSSR clock domain.
>> Doing that also means the driver keeps on working in future SoCs where
>> the GyroADC block may be located in a power area.
>
> So I won't even need the fclk phandle in DT, right ?

You still need the fclk phandle in DT, so the PM domain code can find out
which clock to use for PM.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
