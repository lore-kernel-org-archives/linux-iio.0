Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:35870 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932962AbdDFS5T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Apr 2017 14:57:19 -0400
Received: by mail-wr0-f182.google.com with SMTP id c55so2851688wrc.3
        for <linux-iio@vger.kernel.org>; Thu, 06 Apr 2017 11:57:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170406011003.GP7065@codeaurora.org>
References: <20170323184136.7349-1-raltherr@google.com> <20170323184136.7349-2-raltherr@google.com>
 <20170405202744.GB7065@codeaurora.org> <CAPLgG=nYnVuwRZOdXuFCaFy9P0cx_zqfk0f9orBv+8+HxcnqKQ@mail.gmail.com>
 <20170406011003.GP7065@codeaurora.org>
From: Rick Altherr <raltherr@google.com>
Date: Thu, 6 Apr 2017 11:57:16 -0700
Message-ID: <CAPLgG=mVG1iayk-m5Bu4QRZbMDaxXRTM-mJPQzTwgbOjGKwDpQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: Aspeed ADC
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        David Lechner <david@lechnology.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-clk@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Alison Schofield <amsfield22@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Matt Ranostay <mranostay@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Apr 5, 2017 at 6:10 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 04/05, Rick Altherr wrote:
>> On Wed, Apr 5, 2017 at 1:27 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> > On 03/23, Rick Altherr wrote:
>> >> +
>> >> +static int aspeed_adc_probe(struct platform_device *pdev)
>> >> +{
>> >> +     struct iio_dev *indio_dev;
>> >> +     struct aspeed_adc_data *data;
>> >> +     const struct aspeed_adc_model_data *model_data;
>> >> +     struct resource *res;
>> >> +     const char *clk_parent_name;
>> >> +     int ret;
>> >> +     u32 adc_engine_control_reg_val;
>> >> +
>> >> +     indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*data));
>> >> +     if (!indio_dev)
>> >> +             return -ENOMEM;
>> >> +
>> >> +     data = iio_priv(indio_dev);
>> >> +     data->dev = &pdev->dev;
>> >> +
>> >> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> >> +     data->base = devm_ioremap_resource(&pdev->dev, res);
>> >> +     if (IS_ERR(data->base))
>> >> +             return PTR_ERR(data->base);
>> >> +
>> >> +     /* Register ADC clock prescaler with source specified by device tree. */
>> >> +     spin_lock_init(&data->clk_lock);
>> >> +     clk_parent_name = of_clk_get_parent_name(pdev->dev.of_node, 0);
>> >
>> > What if the parent clk is not registered yet? Or if we're not
>> > always using DT in this driver? Put another way, this code is
>> > fragile. But I guess it probably works well enough for now so no
>> > big deal, just pointing out my fear.
>>
>> I'm not terribly worried about not using DT for this driver as it is
>> for an ARM SoC's built-in ADC which is only supported via DT.  I take
>> your point though.  What's the right way to do this?  Use clk_get() to
>> request by name and clock-names in the DT?
>
> Yes that will work. When we add probe defer to clk_get() things
> will work better. Presumably the clocks property already exists
> for this device so that of_clk_get_parent_name() works so it's
> not a binding change?

The bindings include clocks but not clock-names.  In this case,
clk_register_divider() only has variants that take a parent clock
name.  I can't see what I'd do with the result of clk_get().  If the
bindings provide clock-names, I can provide a fixed string for the
parent name instead of relying on of_clk_get_parent_name().  The
removes an explicit driver dependency on DT.  I'm unclear if it
resolves your concerns about registration ordering.

>
>>
>> >
>> >> +
>> >> +     data->clk_prescaler = clk_hw_register_divider(
>> >> +                             &pdev->dev, "prescaler", clk_parent_name, 0,
>> >> +                             data->base + ASPEED_REG_CLOCK_CONTROL,
>> >> +                             17, 15, 0, &data->clk_lock);
>> >> +     if (IS_ERR(data->clk_prescaler))
>> >> +             return PTR_ERR(data->clk_prescaler);
>> >> +
>> >> +     /*
>> >> +      * Register ADC clock scaler downstream from the prescaler. Allow rate
>> >> +      * setting to adjust the prescaler as well.
>> >> +      */
>> >> +     data->clk_scaler = clk_hw_register_divider(
>> >> +                             &pdev->dev, "scaler", "prescaler",
>> >> +                             CLK_SET_RATE_PARENT,
>> >> +                             data->base + ASPEED_REG_CLOCK_CONTROL,
>> >> +                             0, 10, 0, &data->clk_lock);
>> >> +     if (IS_ERR(data->clk_scaler)) {
>> >> +             ret = PTR_ERR(data->clk_scaler);
>> >> +             goto scaler_error;
>> >> +     }
>> >> +
>> >> +     /* Start all channels in normal mode. */
>> >> +     clk_prepare_enable(data->clk_scaler->clk);
>> >
>> > Eventually we'd like to get rid of hw->clk pointer so that users
>> > have to call some sort of clk_get() API and then we get warm
>> > fuzzies from knowing who is consuming a clk structure. Can you
>> > change this to register a clk provider and call clk_get()? I
>> > think a device that references itself should be OK in DT still,
>> > and would properly reflect what's going on.
>>
>> Do you mean call of_clk_add_hw_provider with of_clk_hw_simple_get or
>> something else?  I'm still wrapping my head around the distinction
>> between clk, clk_hw, and a clk provider.
>>
>
> Yes. Unless you don't want to expose these details in DT because
> it's all internal to the device?
>

There's no reason to expose the scaler or prescaler in DT.  These are
clocks that internal to the ADC and have no way for other devices to
use them.  I only used the clock framework to avoid reinventing the
wheel on calculating divider values for a desired clock rate.

> In that case we need to go merge that patch on the clk list to
> have clk_hw_create_clk() or something like that, so we can turn a
> clk_hw structure into a clk pointer without directly referencing
> the clk member of clk_hw.

This makes the most sense to me.

>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
