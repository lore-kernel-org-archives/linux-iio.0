Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wj0-f176.google.com ([209.85.210.176]:32776 "EHLO
        mail-wj0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755247AbcLSMw2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Dec 2016 07:52:28 -0500
Received: by mail-wj0-f176.google.com with SMTP id xy5so148028251wjc.0
        for <linux-iio@vger.kernel.org>; Mon, 19 Dec 2016 04:52:27 -0800 (PST)
Date: Mon, 19 Dec 2016 12:55:52 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v6 3/8] PWM: add pwm-stm32 DT bindings
Message-ID: <20161219125552.GD23486@dell>
References: <1481292919-26587-1-git-send-email-benjamin.gaignard@st.com>
 <1481292919-26587-4-git-send-email-benjamin.gaignard@st.com>
 <20161212190205.b5t3x6i2o7igldlo@rob-hp-laptop>
 <20161213111137.GW3625@dell.home>
 <CAL_JsqL8pJSFb8LbABAYJOQ0URaMpyupbFryk_mS2ToN1kStdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAL_JsqL8pJSFb8LbABAYJOQ0URaMpyupbFryk_mS2ToN1kStdA@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 13 Dec 2016, Rob Herring wrote:
> On Tue, Dec 13, 2016 at 5:11 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Mon, 12 Dec 2016, Rob Herring wrote:
> >
> >> On Fri, Dec 09, 2016 at 03:15:14PM +0100, Benjamin Gaignard wrote:
> >> > Define bindings for pwm-stm32
> >> >
> >> > version 6:
> >> > - change st,breakinput parameter format to make it usuable on stm32f7 too.
> >> >
> >> > version 2:
> >> > - use parameters instead of compatible of handle the hardware configuration
> >> >
> >> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> >> > ---
> >> >  .../devicetree/bindings/pwm/pwm-stm32.txt          | 33 ++++++++++++++++++++++
> >> >  1 file changed, 33 insertions(+)
> >> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> >> > new file mode 100644
> >> > index 0000000..866f222
> >> > --- /dev/null
> >> > +++ b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> >> > @@ -0,0 +1,33 @@
> >> > +STMicroelectronics STM32 Timers PWM bindings
> >> > +
> >> > +Must be a sub-node of an STM32 Timers device tree node.
> >> > +See ../mfd/stm32-timers.txt for details about the parent node.
> >> > +
> >> > +Required parameters:
> >> > +- compatible:              Must be "st,stm32-pwm".
> >> > +- pinctrl-names:   Set to "default".
> >> > +- pinctrl-0:               List of phandles pointing to pin configuration nodes for PWM module.
> >> > +                   For Pinctrl properties see ../pinctrl/pinctrl-bindings.txt
> >> > +
> >> > +Optional parameters:
> >> > +- st,breakinput:   Arrays of three u32 <index level filter> to describe break input configurations.
> >> > +                   "index" indicates on which break input the configuration should be applied.
> >> > +                   "level" gives the active level (0=low or 1=high) for this configuration.
> >> > +                   "filter" gives the filtering value to be applied.
> >> > +
> >> > +Example:
> >> > +   timers@40010000 {
> >>
> >> timer@...
> >
> > No, it should be timers.
> 
> Read the spec. "timer" is a generic node name. "timers" is not. How
> many is not relevant.

It's not the amount of timers that there are, it's the different types
of timers which this one IP contains.

In MFD we usually list the part number or IP name, however in this
case its difficult because the same IP doesn't have a specific name
listed, and provides; advanced, general purpose and basic timers, as
well as PWM functionality.

This IP is not a timer (although one of its children is one).  It's
the parent device of many different types of timer.

timer {
      timer {
      };

      pwm {
      };
};

... looks weird.

"timer" is not right for the parent IP.  Happy for you to provide an
alternative to "timers" though?

> > The 's' is intentional, since this parent (MFD) device houses 3
> > different types of timers.  The "timer" node is a child of this one.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
