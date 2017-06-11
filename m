Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751649AbdFKLPo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Jun 2017 07:15:44 -0400
Date: Sun, 11 Jun 2017 12:15:38 +0100
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
Subject: Re: [PATCH 1/2] dt-bindings: mfd: update STM32 timers clock names
Message-ID: <20170611121538.0e7e757d@kernel.org>
In-Reply-To: <CA+M3ks7sQ_1kF_ZgQ1+mLwDVo2=CVmACFBvSuY+FyZ9WXY=5tw@mail.gmail.com>
References: <1496993874-9870-1-git-send-email-fabrice.gasnier@st.com>
        <1496993874-9870-2-git-send-email-fabrice.gasnier@st.com>
        <CA+M3ks7sQ_1kF_ZgQ1+mLwDVo2=CVmACFBvSuY+FyZ9WXY=5tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 9 Jun 2017 09:43:21 +0200
Benjamin Gaignard <benjamin.gaignard@linaro.org> wrote:

> 2017-06-09 9:37 GMT+02:00 Fabrice Gasnier <fabrice.gasnier@st.com>:
> > Clock name has been updated during driver/DT binding review:
> > https://lkml.org/lkml/2016/12/13/718
> > Update DT binding doc to reflect this.
> >
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Should have a fixes tag as we should probably be pushing this
to stable...  Rob / Mark - up to you guys on both of these for
the path they take (assuming Lee is happy with patch!)

Fixes: d0f949e220fd ("mfd: Add STM32 Timers driver")
I think...
> > ---
> >  Documentation/devicetree/bindings/mfd/stm32-timers.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/stm32-timers.txt b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
> > index bbd083f..1db6e00 100644
> > --- a/Documentation/devicetree/bindings/mfd/stm32-timers.txt
> > +++ b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
> > @@ -31,7 +31,7 @@ Example:
> >                 compatible = "st,stm32-timers";
> >                 reg = <0x40010000 0x400>;
> >                 clocks = <&rcc 0 160>;
> > -               clock-names = "clk_int";
> > +               clock-names = "int";
> >
> >                 pwm {
> >                         compatible = "st,stm32-pwm";
> > --
> > 1.9.1
> >  
> 
> Acked-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

