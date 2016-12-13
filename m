Return-Path: <SRS0=zMLN=X4=linaro.org=benjamin.gaignard@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161212185943.ph7njaqb2lxtgdn4@rob-hp-laptop>
References: <1481292919-26587-1-git-send-email-benjamin.gaignard@st.com>
 <1481292919-26587-8-git-send-email-benjamin.gaignard@st.com> <20161212185943.ph7njaqb2lxtgdn4@rob-hp-laptop>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Tue, 13 Dec 2016 10:29:51 +0100
Message-ID: <CA+M3ks4EX2ONTraPC26MJFqsu9Kp7b1x5WOySpnfOH_xGLbTWw@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] ARM: dts: stm32: add Timers driver for stm32f429 MCU
To: Rob Herring <robh@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, alexandre.torgue@st.com,
	devicetree@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
	linux-pwm@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Fabrice Gasnier <fabrice.gasnier@st.com>, Gerald Baeza <gerald.baeza@st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@st.com>, Linus Walleij <linus.walleij@linaro.org>,
	Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

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
>>  arch/arm/boot/dts/stm32f429.dtsi | 275 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 275 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
>> index bca491d..d0fb9cc 100644
>> --- a/arch/arm/boot/dts/stm32f429.dtsi
>> +++ b/arch/arm/boot/dts/stm32f429.dtsi
>> @@ -355,6 +355,21 @@
>>                                       slew-rate = <2>;
>>                               };
>>                       };
>> +
>> +                     pwm1_pins: pwm@1 {
>
> No reg prop, so should not have a unit-address. Given the names in the
> define below, seems like "timer1" would be appropriate.
>

Here pins muxing is only targeting PWM part of the the MFD , that why I have
labeled it with "pwm".

>> +                             pins {
>> +                                     pinmux = <STM32F429_PA8_FUNC_TIM1_CH1>,
>> +                                              <STM32F429_PB13_FUNC_TIM1_CH1N>,
>> +                                              <STM32F429_PB12_FUNC_TIM1_BKIN>;
>> +                             };
>> +                     };
>> +
>> +                     pwm3_pins: pwm@3 {
>> +                             pins {
>> +                                     pinmux = <STM32F429_PB4_FUNC_TIM3_CH1>,
>> +                                              <STM32F429_PB5_FUNC_TIM3_CH2>;
>> +                             };
>> +                     };
>>               };
>>
>>               rcc: rcc@40023810 {
>> @@ -426,6 +441,266 @@
>>                       interrupts = <80>;
>>                       clocks = <&rcc 0 38>;
>>               };
>> +
>> +             timers2: timers@40000000 {
>
> timer@...
>
> It may be more than just a timer, there's not a better generic name.

"timer" is already used in DT for clocksource driver.
"timers" cover "advanced-control", "generic" and "basic" hardware timers IPs,
which share the same registers mapping (only the level of feature are different)

>
>> +                     #address-cells = <1>;
>> +                     #size-cells = <0>;
>> +                     compatible = "st,stm32-timers";
>> +                     reg = <0x40000000 0x400>;
>> +                     clocks = <&rcc 0 128>;
>> +                     clock-names = "clk_int";
>> +                     status = "disabled";
>> +
>> +                     pwm {
>> +                             compatible = "st,stm32-pwm";
>> +                             status = "disabled";
>> +                     };
>> +
>> +                     timer {
>> +                             compatible = "st,stm32-timer-trigger";
>> +                             reg = <1>;
>> +                             status = "disabled";
>> +                     };
>> +             };
>> +
>> +             timers3: timers@40000400 {
>
> ditto
>
>> +                     #address-cells = <1>;
>> +                     #size-cells = <0>;
>> +                     compatible = "st,stm32-timers";
>> +                     reg = <0x40000400 0x400>;
>> +                     clocks = <&rcc 0 129>;
>> +                     clock-names = "clk_int";
>> +                     status = "disabled";
>> +
>> +                     pwm {
>> +                             compatible = "st,stm32-pwm";
>> +                             status = "disabled";
>> +                     };
>> +
>> +                     timer {
>> +                             compatible = "st,stm32-timer-trigger";
>> +                             reg = <2>;
>> +                             status = "disabled";
>> +                     };
>> +             };
>> +
>> +             timers4: timers@40000800 {
>> +                     #address-cells = <1>;
>> +                     #size-cells = <0>;
>> +                     compatible = "st,stm32-timers";
>> +                     reg = <0x40000800 0x400>;
>> +                     clocks = <&rcc 0 130>;
>> +                     clock-names = "clk_int";
>> +                     status = "disabled";
>> +
>> +                     pwm {
>> +                             compatible = "st,stm32-pwm";
>> +                             status = "disabled";
>> +                     };
>> +
>> +                     timer {
>> +                             compatible = "st,stm32-timer-trigger";
>> +                             reg = <3>;
>> +                             status = "disabled";
>> +                     };
>> +             };
>> +
>> +             timers5: timers@40000C00 {
>
> timer@...
>
> And use lowercase hex.

ok

>
>> +                     #address-cells = <1>;
>> +                     #size-cells = <0>;
>> +                     compatible = "st,stm32-timers";
>> +                     reg = <0x40000C00 0x400>;
>
> ditto
>
>> +                     clocks = <&rcc 0 131>;
>> +                     clock-names = "clk_int";
>> +                     status = "disabled";
>> +
>> +                     pwm {
>> +                             compatible = "st,stm32-pwm";
>> +                             status = "disabled";
>> +                     };
>> +
>> +                     timer {
>> +                             compatible = "st,stm32-timer-trigger";
>> +                             reg = <4>;
>> +                             status = "disabled";
>> +                     };
>> +             };
>> +
>> +             timers6: timers@40001000 {
>> +                     #address-cells = <1>;
>> +                     #size-cells = <0>;
>> +                     compatible = "st,stm32-timers";
>> +                     reg = <0x40001000 0x400>;
>> +                     clocks = <&rcc 0 132>;
>> +                     clock-names = "clk_int";
>> +                     status = "disabled";
>> +
>> +                     timer {
>> +                             compatible = "st,stm32-timer-trigger";
>> +                             reg = <5>;
>> +                             status = "disabled";
>> +                     };
>> +             };
>> +
>> +             timers7: timers@40001400 {
>> +                     #address-cells = <1>;
>> +                     #size-cells = <0>;
>> +                     compatible = "st,stm32-timers";
>> +                     reg = <0x40001400 0x400>;
>> +                     clocks = <&rcc 0 133>;
>> +                     clock-names = "clk_int";
>> +                     status = "disabled";
>> +
>> +                     timer {
>> +                             compatible = "st,stm32-timer-trigger";
>> +                             reg = <6>;
>> +                             status = "disabled";
>> +                     };
>> +             };
>> +
>> +             timers12: timers@40001800 {
>> +                     #address-cells = <1>;
>> +                     #size-cells = <0>;
>> +                     compatible = "st,stm32-timers";
>> +                     reg = <0x40001800 0x400>;
>> +                     clocks = <&rcc 0 134>;
>> +                     clock-names = "clk_int";
>> +                     status = "disabled";
>> +
>> +                     pwm {
>> +                             compatible = "st,stm32-pwm";
>> +                             status = "disabled";
>> +                     };
>> +
>> +                     timer {
>> +                             compatible = "st,stm32-timer-trigger";
>> +                             reg = <9>;
>> +                             status = "disabled";
>> +                     };
>> +             };
>> +
>> +             timers13: timers@40001C00 {
>> +                     #address-cells = <1>;
>> +                     #size-cells = <0>;
>> +                     compatible = "st,stm32-timers";
>> +                     reg = <0x40001C00 0x400>;
>> +                     clocks = <&rcc 0 135>;
>> +                     clock-names = "clk_int";
>> +                     status = "disabled";
>> +
>> +                     pwm {
>> +                             compatible = "st,stm32-pwm";
>> +                             status = "disabled";
>> +                     };
>> +             };
>> +
>> +             timers14: timers@40002000 {
>> +                     #address-cells = <1>;
>> +                     #size-cells = <0>;
>> +                     compatible = "st,stm32-timers";
>> +                     reg = <0x40002000 0x400>;
>> +                     clocks = <&rcc 0 136>;
>> +                     clock-names = "clk_int";
>> +                     status = "disabled";
>> +
>> +                     pwm {
>> +                             compatible = "st,stm32-pwm";
>> +                             status = "disabled";
>> +                     };
>> +             };
>> +
>> +             timers1: timers@40010000 {
>> +                     #address-cells = <1>;
>> +                     #size-cells = <0>;
>> +                     compatible = "st,stm32-timers";
>> +                     reg = <0x40010000 0x400>;
>> +                     clocks = <&rcc 0 160>;
>> +                     clock-names = "clk_int";
>> +                     status = "disabled";
>> +
>> +                     pwm {
>> +                             compatible = "st,stm32-pwm";
>> +                             status = "disabled";
>> +                     };
>> +
>> +                     timer {
>> +                             compatible = "st,stm32-timer-trigger";
>> +                             reg = <0>;
>> +                             status = "disabled";
>> +                     };
>> +             };
>> +
>> +             timers8: timers@40010400 {
>> +                     #address-cells = <1>;
>> +                     #size-cells = <0>;
>> +                     compatible = "st,stm32-timers";
>> +                     reg = <0x40010400 0x400>;
>> +                     clocks = <&rcc 0 161>;
>> +                     clock-names = "clk_int";
>> +                     status = "disabled";
>> +
>> +                     pwm {
>> +                             compatible = "st,stm32-pwm";
>> +                             status = "disabled";
>> +                     };
>> +
>> +                     timer {
>> +                             compatible = "st,stm32-timer-trigger";
>> +                             reg = <7>;
>> +                             status = "disabled";
>> +                     };
>> +             };
>> +
>> +             timers9: timers@40014000 {
>> +                     #address-cells = <1>;
>> +                     #size-cells = <0>;
>> +                     compatible = "st,stm32-timers";
>> +                     reg = <0x40014000 0x400>;
>> +                     clocks = <&rcc 0 176>;
>> +                     clock-names = "clk_int";
>> +                     status = "disabled";
>> +
>> +                     pwm {
>> +                             compatible = "st,stm32-pwm";
>> +                             status = "disabled";
>> +                     };
>> +
>> +                     timer {
>> +                             compatible = "st,stm32-timer-trigger";
>> +                             reg = <8>;
>> +                             status = "disabled";
>> +                     };
>> +             };
>> +
>> +             timers10: timers@40014400 {
>> +                     #address-cells = <1>;
>> +                     #size-cells = <0>;
>> +                     compatible = "st,stm32-timers";
>> +                     reg = <0x40014400 0x400>;
>> +                     clocks = <&rcc 0 177>;
>> +                     clock-names = "clk_int";
>> +                     status = "disabled";
>> +
>> +                     pwm {
>> +                             compatible = "st,stm32-pwm";
>> +                             status = "disabled";
>> +                     };
>> +             };
>> +
>> +             timers11: timers@40014800 {
>> +                     #address-cells = <1>;
>> +                     #size-cells = <0>;
>> +                     compatible = "st,stm32-timers";
>> +                     reg = <0x40014800 0x400>;
>> +                     clocks = <&rcc 0 178>;
>> +                     clock-names = "clk_int";
>> +                     status = "disabled";
>> +
>> +                     pwm {
>> +                             compatible = "st,stm32-pwm";
>> +                             status = "disabled";
>> +                     };
>> +             };
>>       };
>>  };
>>
>> --
>> 1.9.1
>>
