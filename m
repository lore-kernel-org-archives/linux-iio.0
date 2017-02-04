Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:35459 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbdBDUDQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Feb 2017 15:03:16 -0500
Received: by mail-it0-f42.google.com with SMTP id 203so32863997ith.0
        for <linux-iio@vger.kernel.org>; Sat, 04 Feb 2017 12:03:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1236cee4-41bf-b3b9-51e4-7e585234b0c7@kernel.org>
References: <1485786840-4557-1-git-send-email-fabrice.gasnier@st.com>
 <1485786840-4557-5-git-send-email-fabrice.gasnier@st.com> <CACRpkdZeiFYFdRWCEgYWDWh4Wn2gT29KAFao9mgj7sTi768kFQ@mail.gmail.com>
 <1236cee4-41bf-b3b9-51e4-7e585234b0c7@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 4 Feb 2017 21:03:14 +0100
Message-ID: <CACRpkdZ0BEFMBv6Gv23r62SC6wVF5su7XFGA8v8oUd7YsB6LNA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] iio: trigger: add support for STM32 EXTI triggers
To: Jonathan Cameron <jic23@kernel.org>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>,
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

On Sat, Feb 4, 2017 at 12:39 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 03/02/17 19:40, Linus Walleij wrote:

>>> +               if (ret) {
>>> +                       dev_err(&pdev->dev, "request IRQ %d failed\n", irq);
>>> +                       return ret;
>>> +               }
>>
>> Here you need some elaborate trigger edge handling.
>>
>> The flags that you define as "0" here, how do we say that we
>> want to handle rising or falling edges, for example?
>>
>> I think you might want to establish these DT properties for
>> GPIO triggers:
>>
>> gpio-trigger-rising-edge;
>> gpio-trigger-falling-edge;
>>
>> Then:
>>
>> int irq_flags = 0;
>>
>> if (of_property_read_bool(np, "gpio-trigger-rising-edge")
>>    irq_flags |= IRQF_TRIGGER_RISING;
>> else if (of_property_read_bool(np, "gpio-trigger-falling-edge")
>>    irq_flags |= IRQF_TRIGGER_FALLING;
>
> Should this not all be part of the interrupt specification rather
> than down here in the specific driver?

I might be thinking a bit too generic here actually.

I was thinking we need to support something that has
gpio-controller; so a consumer can get a GPIO line reference
but would not also be an interrupt-controller; so it can't
serve interrupts through the device tree bindings but
may still do so from the driver using gpiolibs .to_irq().

So the specifier would need to come in someplace else.

But I think that is maybe not at all realistic.

If there is an interrupt trigger, that can be used with
a gpio-controller that is also an interrupt-controller,
that should be fine, and then we can use the standard
DT bindings to specify the interrupt type.

Yours,
Linus Walleij
