Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:36192 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936427AbdAEIQd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Jan 2017 03:16:33 -0500
MIME-Version: 1.0
In-Reply-To: <1ddf7012-3336-84c2-6392-353b01beea93@free-electrons.com>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-6-quentin.schulz@free-electrons.com> <CAGb2v66dw=DECuHpLDzHnMP-O4UwZ+RkPsH0RofOGdBa7z7OHw@mail.gmail.com>
 <1ddf7012-3336-84c2-6392-353b01beea93@free-electrons.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 5 Jan 2017 16:16:07 +0800
Message-ID: <CAGb2v67zHf9maNvTVKBZWUTAZFP++PsJt+e3_Mt=Mv4FQ-6FZQ@mail.gmail.com>
Subject: Re: [PATCH 05/22] ARM: dtsi: axp209: add AXP209 ADC subnode
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Jonathan Cameron <jic23@kernel.org>,
        knaack.h@gmx.de, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sebastian Reichel <sre@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Jan 5, 2017 at 4:08 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> On 05/01/2017 06:51, Chen-Yu Tsai wrote:
>> On Tue, Jan 3, 2017 at 12:37 AM, Quentin Schulz
>> <quentin.schulz@free-electrons.com> wrote:
>>> X-Powers AXP209 PMIC has multiple ADCs, each one exposing data from the
>>> different power supplies connected to the PMIC.
>>>
>>> This adds the ADC subnode for AXP20X PMIC.
>>>
>>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>>> ---
>>>  arch/arm/boot/dts/axp209.dtsi | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
>>> index 675bb0f..2a4e8ee 100644
>>> --- a/arch/arm/boot/dts/axp209.dtsi
>>> +++ b/arch/arm/boot/dts/axp209.dtsi
>>> @@ -53,6 +53,11 @@
>>>         interrupt-controller;
>>>         #interrupt-cells = <1>;
>>>
>>> +       axp209_adc: axp209_adc {
>>
>> Node name should be generic. Please change it to "adc".
>>
>
> OK, do I keep the label as is?
>
> axp209_adc: adc {

Yup. The label is for dereferencing and stuff, and exists in a global scope.
You wouldn't want 2 label names clashing.

ChenYu

>
> Thanks,
> Quentin
>
> --
> Quentin Schulz, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
