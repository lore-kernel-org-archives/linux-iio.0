Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:56756 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750903AbdBBJUk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Feb 2017 04:20:40 -0500
Subject: Re: [PATCH 3/5] Documentation: dt: iio: document stm32 exti trigger
To: Rob Herring <robh@kernel.org>
References: <1485784663-19505-1-git-send-email-fabrice.gasnier@st.com>
 <1485784663-19505-4-git-send-email-fabrice.gasnier@st.com>
 <20170201163500.ivxnxejurhzzoctl@rob-hp-laptop>
CC: <jic23@kernel.org>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <benjamin.gaignard@linaro.org>, <benjamin.gaignard@st.com>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <e814a2c6-f0de-cb56-eb3a-e22daed8990b@st.com>
Date: Thu, 2 Feb 2017 10:19:33 +0100
MIME-Version: 1.0
In-Reply-To: <20170201163500.ivxnxejurhzzoctl@rob-hp-laptop>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/01/2017 05:35 PM, Rob Herring wrote:
> On Mon, Jan 30, 2017 at 02:57:41PM +0100, Fabrice Gasnier wrote:
>> Add dt documentation for st,stm32-exti-trigger.
>> EXTi gpio signal can be routed internally as trigger source for various
>
> s/gpio/GPIO/
>
>> IPs (e.g. for ADC or DAC conversions).
>
> Please use "dt-bindings: iio:" for the subject prefix.

Hi Rob,

I'll fix this in V2.

>
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> ---
>>  .../bindings/iio/trigger/st,stm32-exti-trigger.txt      | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/trigger/st,stm32-exti-trigger.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/trigger/st,stm32-exti-trigger.txt b/Documentation/devicetree/bindings/iio/trigger/st,stm32-exti-trigger.txt
>> new file mode 100644
>> index 0000000..ebf2645
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/trigger/st,stm32-exti-trigger.txt
>> @@ -0,0 +1,17 @@
>> +STMicroelectronics STM32 EXTI trigger bindings
>> +
>> +EXTi gpio signal can be routed internally as trigger source for various
>
> s/gpio/GPIO/
>
>> +IPs (e.g. for ADC or DAC conversions).
>> +
>> +Contents of a stm32 exti trigger root node:
>
> Drop "root"
I'll fix these in V2.

>
>> +-------------------------------------------
>> +Required properties:
>> +- compatible: Should be "st,stm32-exti-trigger"
>
> This whole binding looks a bit suspicious. Is this actually a h/w block?
> What makes it stm32 specific? Seems like the gpio properties should just
> be part of the ADC or DAC that they trigger.

Please let me explain in more details.
I think best is I add following documentation in binding. Something like:

GPIO + EXTI controller side | ADC side (input trigger MUX, same for DAC)
                             |
        IIO trigger         --->         IIO device
                             |                  __________
                             |          inX  --|          \
                             |          ...  --|  SAR ADC  |-->
         __                  |         __      |__________/
PA11 --|  \                 | TIMx --|  \   trigger   ^
PB11 --|   |                  ...  --|   }----------->'
...  --|   }---- EXTI11 ---------->--|__/
      --|   |                |
PJ11 --|__/                 |

In fact, this driver configures GPIO and EXTI controllers (left side of
above scheme), and it registers corresponding trigger in IIO. Then it 
can be used by other IPs registered as IIO devices.

I think this should be outside of ADC or DAC IIO device drivers, to live 
in separate IIO trigger driver. It will avoid duplicating code (e.g. 
PATCH 4) into several IIO device drivers.

Is it ok to declare this as separate IIO trigger driver?
Maybe Jonathan could also advise on this ?

As I see it, this is stm32 specific, as any GPIO bank, (e.g. PA11,
PB11...) can be selected to generate (EXTI11) hardware trigger signal.

>
>> +- extiN-gpio: optional gpio line that may be used as external trigger source
>
> -gpios is the preferred form.

I apologize, I didn't make it clear in the first place. Please let me 
rephrase. Is bellow description more suitable ?

- extiN-gpio: One or several named GPIO lines that may be used as
   external trigger source by STM32 ADC, DAC. N may be 0..15.
   For example, on stm32f4, exti11-gpio can trig ADC, exti9-gpio can
   trig DAC.

>
>> +  (e.g. N may be 0..15. For example, exti11-gpio can trig ADC on stm32f4).
>> +
>> +Example:
>> +	triggers {
>> +		compatible = "st,stm32-exti-trigger";
>> +		exti11-gpio=<&gpioa 11 0>;
>
> spaces around the "=".
I'll fix it in V2, and also add example for more that one EXTI trigger:

	triggers {
		compatible = "st,stm32-exti-trigger";
		exti9-gpio = <&gpioa 9 0>;
		exti11-gpio = <&gpioa 11 0>;
		...
	};

Above binding can typically be used in board dt, in case on-board gpio 
is connected/used as trigger source for IIO device (STM32 ADC/DAC).

Please let me know if this clarifies, so I'll do necessary changes in V2.

Many thanks for your review.
Best Regards,
Fabrice

>
>> +	};
>> --
>> 1.9.1
>>
