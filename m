Return-Path: <fabrice.gasnier@st.com>
Subject: Re: [PATCH v2 5/8] dt-bindings: iio: Add STM32 LPTimer trigger
 binding
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        Rob Herring
	<robh@kernel.org>
CC: <lee.jones@linaro.org>, <benjamin.gaignard@linaro.org>, <jic23@kernel.org>,
        <thierry.reding@gmail.com>, <mark.rutland@arm.com>,
        <alexandre.torgue@st.com>, <mcoquelin.stm32@gmail.com>,
        <benjamin.gaignard@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
References: <1498055415-31513-1-git-send-email-fabrice.gasnier@st.com>
 <1498055415-31513-6-git-send-email-fabrice.gasnier@st.com>
 <20170626181416.b7wr6wswuzeasuks@rob-hp-laptop>
 <3D30F4CE-048C-4E5E-BDE1-48660B295066@jic23.retrosnub.co.uk>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <21a2d75f-8fbe-d3d2-4326-8e506a312d9a@st.com>
Date: Tue, 27 Jun 2017 11:04:22 +0200
MIME-Version: 1.0
In-Reply-To: <3D30F4CE-048C-4E5E-BDE1-48660B295066@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

On 06/26/2017 10:38 PM, Jonathan Cameron wrote:
> 
> 
> On 26 June 2017 19:14:16 BST, Rob Herring <robh@kernel.org> wrote:
>> On Wed, Jun 21, 2017 at 04:30:12PM +0200, Fabrice Gasnier wrote:
>>> Add documentation for STMicroelectronics STM32 Low-Power Timer
>> Trigger
>>> binding.
>>>
>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>>> ---
>>> Changes in v2:
>>> - s/Low Power/Low-Power
>>> - remove leading 0x in example (parent node)
>>> - improve reg property description
>>> ---
>>>  .../bindings/iio/timer/stm32-lptimer-trigger.txt   | 23
>> ++++++++++++++++++++++
>>>  1 file changed, 23 insertions(+)
>>>  create mode 100644
>> Documentation/devicetree/bindings/iio/timer/stm32-lptimer-trigger.txt
>>>
>>> diff --git
>> a/Documentation/devicetree/bindings/iio/timer/stm32-lptimer-trigger.txt
>> b/Documentation/devicetree/bindings/iio/timer/stm32-lptimer-trigger.txt
>>> new file mode 100644
>>> index 0000000..466d99f
>>> --- /dev/null
>>> +++
>> b/Documentation/devicetree/bindings/iio/timer/stm32-lptimer-trigger.txt
>>> @@ -0,0 +1,23 @@
>>> +STMicroelectronics STM32 Low-Power Timer Trigger
>>> +
>>> +STM32 Low-Power Timer provides trigger source (LPTIM output) that
>> can be used
>>> +by STM32 internal ADC and/or DAC.
>>> +
>>> +Must be a sub-node of an STM32 Low-Power Timer device tree node.
>>> +See ../mfd/stm32-lptimer.txt for details about the parent node.
>>> +
>>> +Required properties:
>>> +- compatible:		Must be "st,stm32-lptimer-trigger".
>>> +- reg:			Selects trigger hardware block. Must be 0, 1 or 2
>>> +			respectively for lptimer1, lptimer2 or lptimer3
>>> +			trigger output.
>>
>> I guess this answers my question. However, this seems like abuse of the
>>
>> reg prop. This should not be how you select a trigger. The DT should 
>> describe all the h/w blocks and then the adc connection is a separate 
>> property.
> I think this is miss described. Reg is labelling instances of the hardware block which is providing the trigger.

Hi Rob, Jonathan,

yes, reg identifies trigger hardware block.
I'll better describe in v3:
- reg:         Identify trigger hardware block.

Best regards,
Fabrice

> 
> The connection to an ADC etc is done from userspace.
> 
> 
>>
>> Rob
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
