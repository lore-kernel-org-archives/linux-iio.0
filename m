Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:32918 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932431AbcLMJPX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Dec 2016 04:15:23 -0500
Received: by mail-qk0-f180.google.com with SMTP id x190so110095327qkb.0
        for <linux-iio@vger.kernel.org>; Tue, 13 Dec 2016 01:15:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161212185943.ph7njaqb2lxtgdn4@rob-hp-laptop>
References: <1481292919-26587-1-git-send-email-benjamin.gaignard@st.com>
 <1481292919-26587-8-git-send-email-benjamin.gaignard@st.com> <20161212185943.ph7njaqb2lxtgdn4@rob-hp-laptop>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Tue, 13 Dec 2016 10:15:21 +0100
Message-ID: <CA+M3ks6hMDVqDkjn_vcu-d2YkJkiAmCS44Nc7rtfgAkD09LNFA@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] ARM: dts: stm32: add Timers driver for stm32f429 MCU
To: Rob Herring <robh@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, alexandre.torgue@st.com,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        knaack.h@gmx.de, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2016-12-12 19:59 GMT+01:00 Rob Herring <robh@kernel.org>:
> On Fri, Dec 09, 2016 at 03:15:18PM +0100, Benjamin Gaignard wrote:
>> Add Timers and it sub-nodes into DT for stm32f429 family.
>>
>> version 6:
>> - split patch in two: one for SoC family and one for stm32f469
>>   discovery board.
>>
>> version 5:
>> - rename gptimer node to timers
>> - re-order timers node par addresses
>>
>> version 4:
>> - remove unwanted indexing in pwm@ and timer@ node name
>> - use "reg" instead of additional parameters to set timer
>>   configuration
>>
>> version 3:
>> - use "st,stm32-timer-trigger" in DT
>>
>> version 2:
>> - use parameters to describe hardware capabilities
>> - do not use references for pwm and iio timer subnodes
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>> ---
>>  arch/arm/boot/dts/stm32f429.dtsi | 275 ++++++++++++++++++++++++++++++++=
+++++++
>>  1 file changed, 275 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f=
429.dtsi
>> index bca491d..d0fb9cc 100644
>> --- a/arch/arm/boot/dts/stm32f429.dtsi
>> +++ b/arch/arm/boot/dts/stm32f429.dtsi
>> @@ -355,6 +355,21 @@
>>                                       slew-rate =3D <2>;
>>                               };
>>                       };
>> +
>> +                     pwm1_pins: pwm@1 {
>
> No reg prop, so should not have a unit-address. Given the names in the
> define below, seems like "timer1" would be appropriate.
>
>> +                             pins {
>> +                                     pinmux =3D <STM32F429_PA8_FUNC_TIM=
1_CH1>,
>> +                                              <STM32F429_PB13_FUNC_TIM1=
_CH1N>,
>> +                                              <STM32F429_PB12_FUNC_TIM1=
_BKIN>;
>> +                             };
>> +                     };
>> +
>> +                     pwm3_pins: pwm@3 {
>> +                             pins {
>> +                                     pinmux =3D <STM32F429_PB4_FUNC_TIM=
3_CH1>,
>> +                                              <STM32F429_PB5_FUNC_TIM3_=
CH2>;
>> +                             };
>> +                     };
>>               };
>>
>>               rcc: rcc@40023810 {
>> @@ -426,6 +441,266 @@
>>                       interrupts =3D <80>;
>>                       clocks =3D <&rcc 0 38>;
>>               };
>> +
>> +             timers2: timers@40000000 {
>
> timer@...
>
> It may be more than just a timer, there's not a better generic name.
>
>> +                     #address-cells =3D <1>;
>> +                     #size-cells =3D <0>;
>> +                     compatible =3D "st,stm32-timers";
>> +                     reg =3D <0x40000000 0x400>;
>> +                     clocks =3D <&rcc 0 128>;
>> +                     clock-names =3D "clk_int";
>> +                     status =3D "disabled";
>> +
>> +                     pwm {
>> +                             compatible =3D "st,stm32-pwm";
>> +                             status =3D "disabled";
>> +                     };
>> +
>> +                     timer {
>> +                             compatible =3D "st,stm32-timer-trigger";
>> +                             reg =3D <1>;
>> +                             status =3D "disabled";
>> +                     };
>> +             };
>> +
>> +             timers3: timers@40000400 {
>
> ditto
>
>> +                     #address-cells =3D <1>;
>> +                     #size-cells =3D <0>;
>> +                     compatible =3D "st,stm32-timers";
>> +                     reg =3D <0x40000400 0x400>;
>> +                     clocks =3D <&rcc 0 129>;
>> +                     clock-names =3D "clk_int";
>> +                     status =3D "disabled";
>> +
>> +                     pwm {
>> +                             compatible =3D "st,stm32-pwm";
>> +                             status =3D "disabled";
>> +                     };
>> +
>> +                     timer {
>> +                             compatible =3D "st,stm32-timer-trigger";
>> +                             reg =3D <2>;
>> +                             status =3D "disabled";
>> +                     };
>> +             };
>> +
>> +             timers4: timers@40000800 {
>> +                     #address-cells =3D <1>;
>> +                     #size-cells =3D <0>;
>> +                     compatible =3D "st,stm32-timers";
>> +                     reg =3D <0x40000800 0x400>;
>> +                     clocks =3D <&rcc 0 130>;
>> +                     clock-names =3D "clk_int";
>> +                     status =3D "disabled";
>> +
>> +                     pwm {
>> +                             compatible =3D "st,stm32-pwm";
>> +                             status =3D "disabled";
>> +                     };
>> +
>> +                     timer {
>> +                             compatible =3D "st,stm32-timer-trigger";
>> +                             reg =3D <3>;
>> +                             status =3D "disabled";
>> +                     };
>> +             };
>> +
>> +             timers5: timers@40000C00 {
>
> timer@...
>
> And use lowercase hex.
>
>> +                     #address-cells =3D <1>;
>> +                     #size-cells =3D <0>;
>> +                     compatible =3D "st,stm32-timers";
>> +                     reg =3D <0x40000C00 0x400>;
>
> ditto
>
>> +                     clocks =3D <&rcc 0 131>;
>> +                     clock-names =3D "clk_int";
>> +                     status =3D "disabled";
>> +
>> +                     pwm {
>> +                             compatible =3D "st,stm32-pwm";
>> +                             status =3D "disabled";
>> +                     };
>> +
>> +                     timer {
>> +                             compatible =3D "st,stm32-timer-trigger";
>> +                             reg =3D <4>;
>> +                             status =3D "disabled";
>> +                     };
>> +             };
>> +
>> +             timers6: timers@40001000 {
>> +                     #address-cells =3D <1>;
>> +                     #size-cells =3D <0>;
>> +                     compatible =3D "st,stm32-timers";
>> +                     reg =3D <0x40001000 0x400>;
>> +                     clocks =3D <&rcc 0 132>;
>> +                     clock-names =3D "clk_int";
>> +                     status =3D "disabled";
>> +
>> +                     timer {
>> +                             compatible =3D "st,stm32-timer-trigger";
>> +                             reg =3D <5>;
>> +                             status =3D "disabled";
>> +                     };
>> +             };
>> +
>> +             timers7: timers@40001400 {
>> +                     #address-cells =3D <1>;
>> +                     #size-cells =3D <0>;
>> +                     compatible =3D "st,stm32-timers";
>> +                     reg =3D <0x40001400 0x400>;
>> +                     clocks =3D <&rcc 0 133>;
>> +                     clock-names =3D "clk_int";
>> +                     status =3D "disabled";
>> +
>> +                     timer {
>> +                             compatible =3D "st,stm32-timer-trigger";
>> +                             reg =3D <6>;
>> +                             status =3D "disabled";
>> +                     };
>> +             };
>> +
>> +             timers12: timers@40001800 {
>> +                     #address-cells =3D <1>;
>> +                     #size-cells =3D <0>;
>> +                     compatible =3D "st,stm32-timers";
>> +                     reg =3D <0x40001800 0x400>;
>> +                     clocks =3D <&rcc 0 134>;
>> +                     clock-names =3D "clk_int";
>> +                     status =3D "disabled";
>> +
>> +                     pwm {
>> +                             compatible =3D "st,stm32-pwm";
>> +                             status =3D "disabled";
>> +                     };
>> +
>> +                     timer {
>> +                             compatible =3D "st,stm32-timer-trigger";
>> +                             reg =3D <9>;
>> +                             status =3D "disabled";
>> +                     };
>> +             };
>> +
>> +             timers13: timers@40001C00 {
>> +                     #address-cells =3D <1>;
>> +                     #size-cells =3D <0>;
>> +                     compatible =3D "st,stm32-timers";
>> +                     reg =3D <0x40001C00 0x400>;
>> +                     clocks =3D <&rcc 0 135>;
>> +                     clock-names =3D "clk_int";
>> +                     status =3D "disabled";
>> +
>> +                     pwm {
>> +                             compatible =3D "st,stm32-pwm";
>> +                             status =3D "disabled";
>> +                     };
>> +             };
>> +
>> +             timers14: timers@40002000 {
>> +                     #address-cells =3D <1>;
>> +                     #size-cells =3D <0>;
>> +                     compatible =3D "st,stm32-timers";
>> +                     reg =3D <0x40002000 0x400>;
>> +                     clocks =3D <&rcc 0 136>;
>> +                     clock-names =3D "clk_int";
>> +                     status =3D "disabled";
>> +
>> +                     pwm {
>> +                             compatible =3D "st,stm32-pwm";
>> +                             status =3D "disabled";
>> +                     };
>> +             };
>> +
>> +             timers1: timers@40010000 {
>> +                     #address-cells =3D <1>;
>> +                     #size-cells =3D <0>;
>> +                     compatible =3D "st,stm32-timers";
>> +                     reg =3D <0x40010000 0x400>;
>> +                     clocks =3D <&rcc 0 160>;
>> +                     clock-names =3D "clk_int";
>> +                     status =3D "disabled";
>> +
>> +                     pwm {
>> +                             compatible =3D "st,stm32-pwm";
>> +                             status =3D "disabled";
>> +                     };
>> +
>> +                     timer {
>> +                             compatible =3D "st,stm32-timer-trigger";
>> +                             reg =3D <0>;
>> +                             status =3D "disabled";
>> +                     };
>> +             };
>> +
>> +             timers8: timers@40010400 {
>> +                     #address-cells =3D <1>;
>> +                     #size-cells =3D <0>;
>> +                     compatible =3D "st,stm32-timers";
>> +                     reg =3D <0x40010400 0x400>;
>> +                     clocks =3D <&rcc 0 161>;
>> +                     clock-names =3D "clk_int";
>> +                     status =3D "disabled";
>> +
>> +                     pwm {
>> +                             compatible =3D "st,stm32-pwm";
>> +                             status =3D "disabled";
>> +                     };
>> +
>> +                     timer {
>> +                             compatible =3D "st,stm32-timer-trigger";
>> +                             reg =3D <7>;
>> +                             status =3D "disabled";
>> +                     };
>> +             };
>> +
>> +             timers9: timers@40014000 {
>> +                     #address-cells =3D <1>;
>> +                     #size-cells =3D <0>;
>> +                     compatible =3D "st,stm32-timers";
>> +                     reg =3D <0x40014000 0x400>;
>> +                     clocks =3D <&rcc 0 176>;
>> +                     clock-names =3D "clk_int";
>> +                     status =3D "disabled";
>> +
>> +                     pwm {
>> +                             compatible =3D "st,stm32-pwm";
>> +                             status =3D "disabled";
>> +                     };
>> +
>> +                     timer {
>> +                             compatible =3D "st,stm32-timer-trigger";
>> +                             reg =3D <8>;
>> +                             status =3D "disabled";
>> +                     };
>> +             };
>> +
>> +             timers10: timers@40014400 {
>> +                     #address-cells =3D <1>;
>> +                     #size-cells =3D <0>;
>> +                     compatible =3D "st,stm32-timers";
>> +                     reg =3D <0x40014400 0x400>;
>> +                     clocks =3D <&rcc 0 177>;
>> +                     clock-names =3D "clk_int";
>> +                     status =3D "disabled";
>> +
>> +                     pwm {
>> +                             compatible =3D "st,stm32-pwm";
>> +                             status =3D "disabled";
>> +                     };
>> +             };
>> +
>> +             timers11: timers@40014800 {
>> +                     #address-cells =3D <1>;
>> +                     #size-cells =3D <0>;
>> +                     compatible =3D "st,stm32-timers";
>> +                     reg =3D <0x40014800 0x400>;
>> +                     clocks =3D <&rcc 0 178>;
>> +                     clock-names =3D "clk_int";
>> +                     status =3D "disabled";
>> +
>> +                     pwm {
>> +                             compatible =3D "st,stm32-pwm";
>> +                             status =3D "disabled";
>> +                     };
>> +             };
>>       };
>>  };
>>
>> --
>> 1.9.1
>>



--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
