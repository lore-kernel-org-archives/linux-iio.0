Return-Path: <SRS0=zMLN=X4=linaro.org=benjamin.gaignard@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161212185149.rt3xqpn3mbaavb4l@rob-hp-laptop>
References: <1481292919-26587-1-git-send-email-benjamin.gaignard@st.com>
 <1481292919-26587-2-git-send-email-benjamin.gaignard@st.com> <20161212185149.rt3xqpn3mbaavb4l@rob-hp-laptop>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Tue, 13 Dec 2016 10:29:36 +0100
Message-ID: <CA+M3ks4ukP14YE5-6+gAzJBjEmjEyGyVbsVGOm8ehVm0EfzO-w@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] MFD: add bindings for STM32 Timers driver
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

2016-12-12 19:51 GMT+01:00 Rob Herring <robh@kernel.org>:
> On Fri, Dec 09, 2016 at 03:15:12PM +0100, Benjamin Gaignard wrote:
>> Add bindings information for STM32 Timers
>>
>> version 6:
>> - rename stm32-gtimer to stm32-timers
>> - change compatible
>> - add description about the IPs
>>
>> version 2:
>> - rename stm32-mfd-timer to stm32-gptimer
>> - only keep one compatible string
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>> ---
>>  .../devicetree/bindings/mfd/stm32-timers.txt       | 46 ++++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/stm32-timers.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/stm32-timers.txt b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
>> new file mode 100644
>> index 0000000..b30868e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
>> @@ -0,0 +1,46 @@
>> +STM32 Timers driver bindings
>> +
>> +This IP provides 3 types of timer along with PWM functionality:
>> +- advanced-control timers consist of a 16-bit auto-reload counter driven by a programmable
>> +  prescaler, break input feature, PWM outputs and complementary PWM ouputs channels.
>> +- general-purpose timers consist of a 16-bit or 32-bit auto-reload counter driven by a
>> +  programmable prescaler and PWM outputs.
>> +- basic timers consist of a 16-bit auto-reload counter driven by a programmable prescaler.
>> +
>> +Required parameters:
>> +- compatible: must be "st,stm32-timers"
>> +
>> +- reg:                       Physical base address and length of the controller's
>> +                     registers.
>> +- clock-names:               Set to "clk_int".
>
> 'clk' is redundant. Also, you don't really need -names when there is
> only one of them.

I use devm_regmap_init_mmio_clk() which get the clock by it name so
I have to define it in DT.

>> +- clocks:            Phandle to the clock used by the timer module.
>> +                     For Clk properties, please refer to ../clock/clock-bindings.txt
>> +
>> +Optional parameters:
>> +- resets:            Phandle to the parent reset controller.
>> +                     See ../reset/st,stm32-rcc.txt
>> +
>> +Optional subnodes:
>> +- pwm:                       See ../pwm/pwm-stm32.txt
>> +- timer:             See ../iio/timer/stm32-timer-trigger.txt
>> +
>> +Example:
>> +     timers@40010000 {
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>> +             compatible = "st,stm32-timers";
>> +             reg = <0x40010000 0x400>;
>> +             clocks = <&rcc 0 160>;
>> +             clock-names = "clk_int";
>> +
>> +             pwm {
>> +                     compatible = "st,stm32-pwm";
>> +                     pinctrl-0       = <&pwm1_pins>;
>> +                     pinctrl-names   = "default";
>> +             };
>> +
>> +             timer {
>> +                     compatible = "st,stm32-timer-trigger";
>> +                     reg = <0>;
>
> You don't need reg here as there is only one. In turn, you don't need
> #address-cells or #size-cells.

I use "reg" to set each timer configuration.
>From hardware point of view they are all the same except for which hardware
signals they could consume and/or send.
"reg" is used as index of the two tables in driver code.

>
>> +             };
>> +     };
>> --
>> 1.9.1
>>
