Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:49119 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752232AbdBCKjB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Feb 2017 05:39:01 -0500
Subject: Re: [PATCH 3/5] Documentation: dt: iio: document stm32 exti trigger
To: Rob Herring <robh@kernel.org>
References: <1485784663-19505-1-git-send-email-fabrice.gasnier@st.com>
 <1485784663-19505-4-git-send-email-fabrice.gasnier@st.com>
 <20170201163500.ivxnxejurhzzoctl@rob-hp-laptop>
 <e814a2c6-f0de-cb56-eb3a-e22daed8990b@st.com>
 <CAL_JsqKgGuh5==Xfd6LKZe70G1NiuesW0_xE98CZQZ3=BCPvLg@mail.gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Linus Walleij <linus.walleij@linaro.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <9ef03374-9108-aec4-d2d8-58af17d62fef@st.com>
Date: Fri, 3 Feb 2017 11:37:37 +0100
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKgGuh5==Xfd6LKZe70G1NiuesW0_xE98CZQZ3=BCPvLg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/02/2017 04:45 PM, Rob Herring wrote:
> +Linus W
>
> On Thu, Feb 2, 2017 at 3:19 AM, Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
>> On 02/01/2017 05:35 PM, Rob Herring wrote:
>>>
>>> On Mon, Jan 30, 2017 at 02:57:41PM +0100, Fabrice Gasnier wrote:
>>>>
>>>> Add dt documentation for st,stm32-exti-trigger.
>>>> EXTi gpio signal can be routed internally as trigger source for various
>>>
>>>
>>> s/gpio/GPIO/
>>>
>>>> IPs (e.g. for ADC or DAC conversions).
>>>
>>>
>>> Please use "dt-bindings: iio:" for the subject prefix.
>>
>>
>> Hi Rob,
>>
>> I'll fix this in V2.
>>
>>>
>>>>
>>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>>>> ---
>>>>  .../bindings/iio/trigger/st,stm32-exti-trigger.txt      | 17
>>>> +++++++++++++++++
>>>>  1 file changed, 17 insertions(+)
>>>>  create mode 100644
>>>> Documentation/devicetree/bindings/iio/trigger/st,stm32-exti-trigger.txt
>>>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/iio/trigger/st,stm32-exti-trigger.txt
>>>> b/Documentation/devicetree/bindings/iio/trigger/st,stm32-exti-trigger.txt
>>>> new file mode 100644
>>>> index 0000000..ebf2645
>>>> --- /dev/null
>>>> +++
>>>> b/Documentation/devicetree/bindings/iio/trigger/st,stm32-exti-trigger.txt
>>>> @@ -0,0 +1,17 @@
>>>> +STMicroelectronics STM32 EXTI trigger bindings
>>>> +
>>>> +EXTi gpio signal can be routed internally as trigger source for various
>>>
>>>
>>> s/gpio/GPIO/
>>>
>>>> +IPs (e.g. for ADC or DAC conversions).
>>>> +
>>>> +Contents of a stm32 exti trigger root node:
>>>
>>>
>>> Drop "root"
>>
>> I'll fix these in V2.
>>
>>>
>>>> +-------------------------------------------
>>>> +Required properties:
>>>> +- compatible: Should be "st,stm32-exti-trigger"
>>>
>>>
>>> This whole binding looks a bit suspicious. Is this actually a h/w block?
>>> What makes it stm32 specific? Seems like the gpio properties should just
>>> be part of the ADC or DAC that they trigger.
>>
>>
>> Please let me explain in more details.
>> I think best is I add following documentation in binding. Something like:
>>
>> GPIO + EXTI controller side | ADC side (input trigger MUX, same for DAC)
>>                             |
>>        IIO trigger         --->         IIO device
>>                             |                  __________
>>                             |          inX  --|          \
>>                             |          ...  --|  SAR ADC  |-->
>>         __                  |         __      |__________/
>> PA11 --|  \                 | TIMx --|  \   trigger   ^
>> PB11 --|   |                  ...  --|   }----------->'
>> ...  --|   }---- EXTI11 ---------->--|__/
>>      --|   |                |
>> PJ11 --|__/                 |
>>
>> In fact, this driver configures GPIO and EXTI controllers (left side of
>> above scheme), and it registers corresponding trigger in IIO. Then it can be
>> used by other IPs registered as IIO devices.
>>
>> I think this should be outside of ADC or DAC IIO device drivers, to live in
>> separate IIO trigger driver. It will avoid duplicating code (e.g. PATCH 4)
>> into several IIO device drivers.
>>
>> Is it ok to declare this as separate IIO trigger driver?
>
> Drivers and DT nodes are not necessarily 1 to 1.
Hi Rob,

Sorry, I don't get it. Can you clarify ?

>
> What controls the GPIO line that is used for the trigger?

This can be anything connected to GPIO line, such as (on board)
push-button, external synchronization signal ...

>
>> Maybe Jonathan could also advise on this ?
>>
>> As I see it, this is stm32 specific, as any GPIO bank, (e.g. PA11,
>> PB11...) can be selected to generate (EXTI11) hardware trigger signal.
>
> This seems more like a pinmux'ing issue than a GPIO. This isn't really
> a GPIO if it is routed to a h/w control.

Sorry, muxing part (e.g. PA11, PB11...) isn't shown in above scheme.
GPIO is muxed via gpio/pinctrl driver.

>
> A -gpios property for a trigger would make sense if you had a driver
> handling GPIO interrupts to generate IIO triggers. This seems to be
> just mux control.

This is almost it, there are two stages.
- trigger starts conversion on device (e.g. ADC...) by hardware (no need 
for interrupt on 1st stage, data isn't ready anyway).
- 2nd stage, end of conversion polls the trigger.

Just to summarize, rephrase, in case push button is used to trigger 
conversions:
- 1st declare GPIO (to which push button is connected)
- GPIO is muxed into external interrupt (e.g. EXTI) by using pinctrl
and exti driver. This may be compared to a 'gpio_keys' up to this point.
- EXTI line is able to either generate an interrupt (not used here)
and/or start conversion as trigger line (that is used here).
- end of conversion does the actual trigger poll.

>
>>>> +- extiN-gpio: optional gpio line that may be used as external trigger
>>>> source
>>>
>>>
>>> -gpios is the preferred form.
>>
>>
>> I apologize, I didn't make it clear in the first place. Please let me
>> rephrase. Is bellow description more suitable ?
>
> What I mean is the property name is wrong. It should be "extiN-gpios".
Oh... got it, thanks.
I'll update this.

Best Regards,
Fabrice
>
>>
>> - extiN-gpio: One or several named GPIO lines that may be used as
>>   external trigger source by STM32 ADC, DAC. N may be 0..15.
>>   For example, on stm32f4, exti11-gpio can trig ADC, exti9-gpio can
>>   trig DAC.
>>
>>>
>>>> +  (e.g. N may be 0..15. For example, exti11-gpio can trig ADC on
>>>> stm32f4).
>>>> +
>>>> +Example:
>>>> +       triggers {
>>>> +               compatible = "st,stm32-exti-trigger";
>>>> +               exti11-gpio=<&gpioa 11 0>;
>>>
>>>
>>> spaces around the "=".
>>
>> I'll fix it in V2, and also add example for more that one EXTI trigger:
>>
>>         triggers {
>>                 compatible = "st,stm32-exti-trigger";
>>                 exti9-gpio = <&gpioa 9 0>;
>>                 exti11-gpio = <&gpioa 11 0>;
>>                 ...
>>         };
>>
>> Above binding can typically be used in board dt, in case on-board gpio is
>> connected/used as trigger source for IIO device (STM32 ADC/DAC).
>>
>> Please let me know if this clarifies, so I'll do necessary changes in V2.
>>
>> Many thanks for your review.
>> Best Regards,
>> Fabrice
>>
>>>
>>>> +       };
>>>> --
>>>> 1.9.1
>>>>
>>
