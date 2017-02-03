Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:38254 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751366AbdBCTLf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Feb 2017 14:11:35 -0500
Received: by mail-it0-f47.google.com with SMTP id c7so18797880itd.1
        for <linux-iio@vger.kernel.org>; Fri, 03 Feb 2017 11:11:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485784663-19505-4-git-send-email-fabrice.gasnier@st.com>
References: <1485784663-19505-1-git-send-email-fabrice.gasnier@st.com> <1485784663-19505-4-git-send-email-fabrice.gasnier@st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 3 Feb 2017 20:11:33 +0100
Message-ID: <CACRpkdZLFKQbDjDXo+ir=8d8gEd=9dLicuVLEXAF2OoWefKJcA@mail.gmail.com>
Subject: Re: [PATCH 3/5] Documentation: dt: iio: document stm32 exti trigger
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jan 30, 2017 at 2:57 PM, Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Add dt documentation for st,stm32-exti-trigger.
> EXTi gpio signal can be routed internally as trigger source for various
> IPs (e.g. for ADC or DAC conversions).

And you say this is done using pin control, elsewhere in the conversation
if I understand it correctly?

> +Contents of a stm32 exti trigger root node:
> +-------------------------------------------
> +Required properties:
> +- compatible: Should be "st,stm32-exti-trigger"
> +- extiN-gpio: optional gpio line that may be used as external trigger source
> +  (e.g. N may be 0..15. For example, exti11-gpio can trig ADC on stm32f4).
> +
> +Example:
> +       triggers {
> +               compatible = "st,stm32-exti-trigger";
> +               exti11-gpio=<&gpioa 11 0>;
> +       };

So what I do not understand i if this has any stm32-specific behaviour at all,
so that compatible-string has any meaning.

Should we not rather define compatible = "gpio-trigger"; to be used by
everyone? Especially for the device tree?

If it's "mostly generic, a bit specific too" it should likely be:

compatible = "gpio-trigger", "st,stm32-exit-trigger";

Yours,
Linus Walleij
