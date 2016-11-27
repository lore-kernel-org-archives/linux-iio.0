Return-Path: <benjamin.gaignard@linaro.org>
MIME-Version: 1.0
In-Reply-To: <b2002a81-49fe-af2a-f13a-9f09831aa530@kernel.org>
References: <1480000463-9625-1-git-send-email-benjamin.gaignard@st.com>
 <1480000463-9625-6-git-send-email-benjamin.gaignard@st.com> <b2002a81-49fe-af2a-f13a-9f09831aa530@kernel.org>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Sun, 27 Nov 2016 16:45:34 +0100
Message-ID: <CA+M3ks6LC5M3B01nRWh-bO79OOE11QcsypDXGpFAPzZ7Goc=Fw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] IIO: add bindings for stm32 IIO timer driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, robh+dt@kernel.org,
	Mark Rutland <mark.rutland@arm.com>, alexandre.torgue@st.com, devicetree@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
	linux-pwm@vger.kernel.org, knaack.h@gmx.de,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Fabrice Gasnier <fabrice.gasnier@st.com>, Gerald Baeza <gerald.baeza@st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@st.com>, Linus Walleij <linus.walleij@linaro.org>,
	Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

2016-11-27 15:25 GMT+01:00 Jonathan Cameron <jic23@kernel.org>:
> On 24/11/16 15:14, Benjamin Gaignard wrote:
>> Define bindings for stm32 IIO timer
>>
>> version 2:
>> - only keep one compatible
>> - add DT parameters to set lists of the triggers:
>>   one list describe the triggers created by the device
>>   another one give the triggers accepted by the device
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>> ---
>>  .../bindings/iio/timer/stm32-iio-timer.txt         | 41 ++++++++++++++++++++++
>>  1 file changed, 41 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt b/Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt
>> new file mode 100644
>> index 0000000..840b417
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt
>> @@ -0,0 +1,41 @@
>> +timer IIO trigger bindings for STM32
>> +
>> +Must be a sub-node of STM32 general purpose timer driver
> Add a cross reference...

I will add it in v3

>> +
>> +Required parameters:
>> +- compatible:                must be "st,stm32-iio-timer"
> st,stm32-adc-timer or something like that.

I would prefer use st,stm32-timer-trigger because triggers can be used
for multiple other devices (dac, adc, timers)

>> +- interrupts:                Interrupt for this device
>> +                     See ../interrupt-controller/st,stm32-exti.txt
>> +
>> +Optional parameters:
>> +- st,input-triggers-names:   List of the possible input triggers for
>> +                             the device
>> +- st,output-triggers-names:  List of the possible output triggers for
>> +                             the device
> What are input / output triggers?

each hardware block can be the source of triggers (output triggers) or customer
of some other trigger (input triggers).That what I have tried to
describe in those two
parameters

>> +
>> +Possible triggers are defined in include/dt-bindings/iio/timer/st,stm32-iio-timer.h
>> +
>> +Example:
>> +     gptimer1: gptimer1@40010000 {
>> +             compatible = "st,stm32-gptimer";
>> +             reg = <0x40010000 0x400>;
>> +             clocks = <&rcc 0 160>;
>> +             clock-names = "clk_int";
>> +
>> +             pwm1@0 {
>> +                     compatible = "st,stm32-pwm";
>> +                     st,pwm-num-chan = <4>;
>> +                     st,breakinput;
>> +                     st,complementary;
>> +             };
>> +
>> +             iiotimer1@0 {
>> +                     compatible = "st,stm32-iio-timer";
>> +                     interrupts = <27>;
>> +                     st,input-triggers-names = TIM5_TRGO,
>> +                                               TIM2_TRGO,
>> +                                               TIM4_TRGO,
>> +                                               TIM3_TRGO;
>> +                     st,output-triggers-names = TIM1_TRGO;
>> +             };
>> +     };
>>
>
