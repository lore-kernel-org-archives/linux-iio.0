Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751565AbdFKLU1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Jun 2017 07:20:27 -0400
Date: Sun, 11 Jun 2017 12:20:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: iio: update STM32 timers clock names
Message-ID: <20170611122009.37ed409b@kernel.org>
In-Reply-To: <CA+M3ks4z46rPmjBt=pfJQBBjr5Hr7Oj4P=tv5wjo9WB_Ca_vsA@mail.gmail.com>
References: <1496993874-9870-1-git-send-email-fabrice.gasnier@st.com>
        <1496993874-9870-3-git-send-email-fabrice.gasnier@st.com>
        <CA+M3ks4z46rPmjBt=pfJQBBjr5Hr7Oj4P=tv5wjo9WB_Ca_vsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 9 Jun 2017 09:43:42 +0200
Benjamin Gaignard <benjamin.gaignard@linaro.org> wrote:

> 2017-06-09 9:37 GMT+02:00 Fabrice Gasnier <fabrice.gasnier@st.com>:
> > Clock name has been updated during driver/DT binding review:
> > https://lkml.org/lkml/2016/12/13/718
> > Update DT binding doc to reflect this.
> >
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Same fixes tag as previous as this is an example of the binding for the
mfd rather than actually part of the IIO binding.

Fixes: d0f949e220fd ("mfd: Add STM32 Timers driver")
Acked-by: Jonathan Cameron <jic23@kernel.org>

I'm assuming Rob / Mark or Lee will pick this up.  If people
do want it to go through the IIO tree let me know.

Jonathan
> > ---
> >  Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
> > index 55a653d..6abc755 100644
> > --- a/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
> > +++ b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
> > @@ -14,7 +14,7 @@ Example:
> >                 compatible = "st,stm32-timers";
> >                 reg = <0x40010000 0x400>;
> >                 clocks = <&rcc 0 160>;
> > -               clock-names = "clk_int";
> > +               clock-names = "int";
> >
> >                 timer@0 {
> >                         compatible = "st,stm32-timer-trigger";
> > --
> > 1.9.1
> >  
> Acked-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

