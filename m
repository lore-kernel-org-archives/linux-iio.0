Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:51162 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761059AbdAEIIV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Jan 2017 03:08:21 -0500
Subject: Re: [PATCH 05/22] ARM: dtsi: axp209: add AXP209 ADC subnode
To: Chen-Yu Tsai <wens@csie.org>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-6-quentin.schulz@free-electrons.com>
 <CAGb2v66dw=DECuHpLDzHnMP-O4UwZ+RkPsH0RofOGdBa7z7OHw@mail.gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        Lars-Peter Clausen <lars@metafoo.de>,
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
        =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <1ddf7012-3336-84c2-6392-353b01beea93@free-electrons.com>
Date: Thu, 5 Jan 2017 09:08:19 +0100
MIME-Version: 1.0
In-Reply-To: <CAGb2v66dw=DECuHpLDzHnMP-O4UwZ+RkPsH0RofOGdBa7z7OHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/01/2017 06:51, Chen-Yu Tsai wrote:
> On Tue, Jan 3, 2017 at 12:37 AM, Quentin Schulz
> <quentin.schulz@free-electrons.com> wrote:
>> X-Powers AXP209 PMIC has multiple ADCs, each one exposing data from the
>> different power supplies connected to the PMIC.
>>
>> This adds the ADC subnode for AXP20X PMIC.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> ---
>>  arch/arm/boot/dts/axp209.dtsi | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
>> index 675bb0f..2a4e8ee 100644
>> --- a/arch/arm/boot/dts/axp209.dtsi
>> +++ b/arch/arm/boot/dts/axp209.dtsi
>> @@ -53,6 +53,11 @@
>>         interrupt-controller;
>>         #interrupt-cells = <1>;
>>
>> +       axp209_adc: axp209_adc {
> 
> Node name should be generic. Please change it to "adc".
> 

OK, do I keep the label as is?

axp209_adc: adc {

Thanks,
Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
