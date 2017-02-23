Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:37676 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751460AbdBWPKw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Feb 2017 10:10:52 -0500
Received: by mail-it0-f49.google.com with SMTP id 203so2555206ith.0
        for <linux-iio@vger.kernel.org>; Thu, 23 Feb 2017 07:10:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487347429-31761-4-git-send-email-fabrice.gasnier@st.com>
References: <1487347429-31761-1-git-send-email-fabrice.gasnier@st.com> <1487347429-31761-4-git-send-email-fabrice.gasnier@st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 23 Feb 2017 16:03:28 +0100
Message-ID: <CACRpkdaFLMDhYZJrO=-MuSG31aO5vOZ2KX3_c95jzze46pymmQ@mail.gmail.com>
Subject: Re: [RFC 3/4] dt-bindings: iio: add support for GPIO triggers
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Feb 17, 2017 at 5:03 PM, Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Document Industrial I/O GPIO trigger support.
>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
(...)
> +- gpio-trigger-rising-edge: A rising edge on GPIO will trigger.
> +- gpio-trigger-falling-edge: A falling edge on GPIO will trigger.
> +  Note: Both rising and falling edge may be used. In case none of
> +  rising or falling edge is selected, rising edge is selected by
> +  default.

We have GPIO_ACTIVE*_HIGH and GPIO_ACTIVE_LOW in the
gpios second cell already.

Can't we simply use that and specify that for this usecase, reading
that cell as GPIO_ACTIVE_HIGH == trigger on rising edge and
GPIO_ACTIVE_LOW == trigger on falling edge?

Yours,
Linus Walleij
