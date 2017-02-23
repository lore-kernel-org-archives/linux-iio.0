Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:4095 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751202AbdBWPqN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Feb 2017 10:46:13 -0500
Subject: Re: [RFC 3/4] dt-bindings: iio: add support for GPIO triggers
To: Linus Walleij <linus.walleij@linaro.org>
References: <1487347429-31761-1-git-send-email-fabrice.gasnier@st.com>
 <1487347429-31761-4-git-send-email-fabrice.gasnier@st.com>
 <CACRpkdaFLMDhYZJrO=-MuSG31aO5vOZ2KX3_c95jzze46pymmQ@mail.gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>,
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
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <a1064b5a-4258-795b-996b-50ece1c1ee6c@st.com>
Date: Thu, 23 Feb 2017 16:45:09 +0100
MIME-Version: 1.0
In-Reply-To: <CACRpkdaFLMDhYZJrO=-MuSG31aO5vOZ2KX3_c95jzze46pymmQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/23/2017 04:03 PM, Linus Walleij wrote:
> On Fri, Feb 17, 2017 at 5:03 PM, Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
>
>> Document Industrial I/O GPIO trigger support.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> (...)
>> +- gpio-trigger-rising-edge: A rising edge on GPIO will trigger.
>> +- gpio-trigger-falling-edge: A falling edge on GPIO will trigger.
>> +  Note: Both rising and falling edge may be used. In case none of
>> +  rising or falling edge is selected, rising edge is selected by
>> +  default.
>
> We have GPIO_ACTIVE*_HIGH and GPIO_ACTIVE_LOW in the
> gpios second cell already.
>
> Can't we simply use that and specify that for this usecase, reading
> that cell as GPIO_ACTIVE_HIGH == trigger on rising edge and
> GPIO_ACTIVE_LOW == trigger on falling edge?

Hi Linus,

Thanks for reviewing,

I think I'll simply drop patch 3 & 4, as suggested by Lars and Jonathan,
on patch 4, to use interrupt binding directly. Then standard interrupt
binding can be used instead.
Only thing is to add OF support for iio_interrupt_trigger.

BR,
Fabrice
>
> Yours,
> Linus Walleij
>
