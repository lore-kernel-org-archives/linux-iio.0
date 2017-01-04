Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33531 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbdADQiy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Jan 2017 11:38:54 -0500
Subject: Re: [PATCH] iio: adc: Add Renesas GyroADC driver
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <20161230191800.2532-1-marek.vasut@gmail.com>
 <CAMuHMdX20kc8h4DiNLu0KwaA0FL6F-WXLnA3YXvu02VJTh_7fQ@mail.gmail.com>
Cc: linux-iio@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <f4bb8922-36dc-ff69-45fc-e1d9cba821ba@gmail.com>
Date: Wed, 4 Jan 2017 15:27:30 +0100
MIME-Version: 1.0
In-Reply-To: <CAMuHMdX20kc8h4DiNLu0KwaA0FL6F-WXLnA3YXvu02VJTh_7fQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/02/2017 11:01 AM, Geert Uytterhoeven wrote:
> Hi Marek,
> 
> On Fri, Dec 30, 2016 at 8:18 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> Add IIO driver for the Renesas RCar GyroADC block. This block is a
>> simple 4/8-channel ADC which samples 12/15/24 bits of data every
>> cycle from all channels.
> 
> Thanks for your patch!
> 
>> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Simon Horman <horms+renesas@verge.net.au>
>> ---
>>  .../bindings/iio/adc/renesas,gyroadc.txt           |  38 +++
>>  MAINTAINERS                                        |   6 +
>>  drivers/iio/adc/Kconfig                            |  10 +
>>  drivers/iio/adc/Makefile                           |   1 +
>>  drivers/iio/adc/rcar_gyro_adc.c                    | 379 +++++++++++++++++++++
>>  5 files changed, 434 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
>>  create mode 100644 drivers/iio/adc/rcar_gyro_adc.c
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt b/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
>> new file mode 100644
>> index 0000000..3fd5f57
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
>> @@ -0,0 +1,38 @@
>> +* Renesas RCar GyroADC device driver
>> +
>> +Required properties:
>> +- compatible:  Should be "renesas,rcar-gyroadc" for regular GyroADC or
>> +               "renesas,rcar-gyroadc-r8a7792" for GyroADC without interrupt
> 
> Please use "renesas,r8a7792-gyroadc" to match existing practices.

Actually, that should probably be gyroadc-r8a7791 if we want to match
the existing practice. Fixed.

> Unfortunately we cannot just look at the presence of an "interrupts" property
> to distinguish between the two variants, as the interrupt is handled
> by a different
> block (Speed Pulse IF).
> 
> Do you have a (future) use for the interrupt? If yes, we will need a phandle
> link to the Speed Pulse IF device node later...

Nope, I don't have any use for it yet and I doubt it'll come useful later.

> BTW, it's a good idea to always cater for SoC-specific differences that may
> be discovered later by adding SoC-specific compatible values.

Yep

> BTW, the same hardware block seems to be present in R-Car Gen1 and
> R-Car Gen3 SoCs.

OK

>> +               block found in R8A7792.
> 
>> +- renesas,gyroadc-vref:        Array of reference voltage values for each input to
>> +                       the GyroADC, in uV. Array must have 4 elemenets for
>> +                       mode 1 and 8 elements for mode 2 and 3.
> 
> Should this be an array of phandles to regulators instead?

That's a good idea, yeah.

>> --- /dev/null
>> +++ b/drivers/iio/adc/rcar_gyro_adc.c
>> @@ -0,0 +1,379 @@
>> +/*
>> + * Renesas RCar GyroADC driver
> 
> R-Car
> 
>> + *
>> + * Copyright 2016 Marek Vasut <marek.vasut@gmail.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
> 
> MODULE_LICENSE() says GPL V2 only?

Fixed to GPL.

>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/interrupt.h>
> 
> Do you need this include? There's no interrupt support.

Nope

>> +#include <linux/delay.h>
>> +#include <linux/kernel.h>
>> +#include <linux/slab.h>
>> +#include <linux/io.h>
>> +#include <linux/clk.h>
>> +#include <linux/of.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/regulator/consumer.h>
> 
> Do you need this include?
> Ah, you were already anticipating the array of phandles to regulators ;-)

Of course ... :)

>> +struct rcar_gyroadc {
>> +       struct device           *dev;
>> +       void __iomem            *regs;
>> +       struct clk              *fclk;
>> +       struct clk              *clk;
> 
> iclk?

OK

>> +static void rcar_gyroadc_hw_init(struct rcar_gyroadc *priv)
>> +{
>> +       unsigned long clk_mhz = clk_get_rate(priv->clk) / 1000000;
>> +
>> +       /* Stop the GyroADC. */
>> +       writel(0, priv->regs + RCAR_GYROADC_START_STOP);
>> +
>> +       /* Disable IRQ, except on V2H. */
>> +       if (priv->model != RCAR_GYROADC_MODEL_R8A7792)
>> +               writel(0, priv->regs + RCAR_GYROADC_INTENR);
>> +
>> +       /* Set mode and timing. */
>> +       writel(priv->mode, priv->regs + RCAR_GYROADC_MODE_SELECT);
>> +
>> +       if (priv->mode == RCAR_GYROADC_MODE_SELECT_1_MB88101A)
>> +               writel(clk_mhz * 10, priv->regs + RCAR_GYROADC_CLOCK_LENGTH);
>> +       else if (priv->mode == RCAR_GYROADC_MODE_SELECT_2_ADCS7476)
>> +               writel(clk_mhz * 5, priv->regs + RCAR_GYROADC_CLOCK_LENGTH);
>> +       else if (priv->mode == RCAR_GYROADC_MODE_SELECT_3_MAX1162)
>> +               writel(clk_mhz * 5, priv->regs + RCAR_GYROADC_CLOCK_LENGTH);
>> +       writel(clk_mhz * 1250, priv->regs + RCAR_GYROADC_1_25MS_LENGTH);
>> +
>> +       /*
>> +        * We can possibly turn the sampling on/off on-demand to reduce power
> 
> And the module clock, using runtime PM (see below).
> 
>> +        * consumption, but for the sake of quick availability of samples, we
>> +        * don't do it now.
>> +        */
>> +       writel(RCAR_GYROADC_START_STOP_START,
>> +              priv->regs + RCAR_GYROADC_START_STOP);
>> +
>> +       /* Wait for the first conversion to complete. */
>> +       udelay(1250);
>> +}
> 
>> +static const struct of_device_id rcar_gyroadc_match[] = {
>> +       {
>> +               /* RCar Gen2 compatible GyroADC */
> 
> R-Car
> 
>> +               .compatible     = "renesas,rcar-gyroadc",
>> +               .data           = (void *)RCAR_GYROADC_MODEL_DEFAULT,
>> +       }, {
>> +               /* RCar V2H specialty without interrupt registers. */
> 
> R-Car
> 
>> +               .compatible     = "renesas,rcar-gyroadc-r8a7792",
>> +               .data           = (void *)RCAR_GYROADC_MODEL_R8A7792,
>> +       }, {
>> +               /* sentinel */
>> +       }
>> +};
> 
>> +static int rcar_gyroadc_probe(struct platform_device *pdev)
>> +{
> 
>> +       priv->fclk = devm_clk_get(dev, "fck");
> 
> The module clock isn't used directly by this driver (you don't need
> e.g. its rate),
> so you can leave out all handling related to this clock iff you enable
> runtime PM:
> 
>     pm_runtime_enable(dev);
>     pm_runtime_get_sync(dev);
> 
> Then runtime PM will take care of enabling the module clock, as the
> GyroADC block is part of the CPG/MSSR clock domain.
> Doing that also means the driver keeps on working in future SoCs where
> the GyroADC block may be located in a power area.

So I won't even need the fclk phandle in DT, right ?

>> +       if (IS_ERR(priv->fclk)) {
>> +               ret = PTR_ERR(priv->fclk);
>> +               dev_err(dev, "Failed to get FCK clock (ret=%i)\n", ret);
> 
> Do you need this error message? It will add to the noise in case of
> deferred probing.
> Please either remove it, or make it depend on != -EPROBE_DEFER.

OK

>> +               return ret;
>> +       }
>> +
>> +       priv->clk = devm_clk_get(dev, "if");
>> +       if (IS_ERR(priv->clk)) {
>> +               ret = PTR_ERR(priv->clk);
>> +               dev_err(dev, "Failed to get IF clock (ret=%i)\n", ret);
> 
> Likewise.

OK

>> +               return ret;
>> +       }
>> +
>> +       ret = of_property_read_u32(pdev->dev.of_node, "renesas,gyroadc-mode",
>> +                                  &mode);
>> +       if (ret || (mode < 1) || (mode > 3)) {
>> +               dev_err(dev, "Failed to get GyroADC mode (ret=%i)\n", ret);
> 
> Note that this will print "ret=0" (no error?) if an invalid mode was specified.

Oh, nice.

>> +               return ret;
>> +       }
>> +
>> +       if (mode == 1)
>> +               priv->mode = RCAR_GYROADC_MODE_SELECT_1_MB88101A;
>> +       else if (mode == 2)
>> +               priv->mode = RCAR_GYROADC_MODE_SELECT_2_ADCS7476;
>> +       else if (mode == 3)
>> +               priv->mode = RCAR_GYROADC_MODE_SELECT_3_MAX1162;
> 
> switch()? And print the invalid mode message here?
> 
>> +
>> +       of_property_read_u32_array(pdev->dev.of_node, "renesas,gyroadc-vref",
>> +                                  priv->vref_uv, (mode == 1) ? 4 : 8);
> 
> This call may fail.

Both reworked, thanks for the review.

-- 
Best regards,
Marek Vasut
