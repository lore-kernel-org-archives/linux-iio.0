Return-Path: <SRS0=/D7J=2M=st.com=fabrice.gasnier@kernel.org>
Subject: Re: [PATCH v3 1/6] dt-bindings: iio: introduce trigger providers,
 consumers
To: Rob Herring <robh@kernel.org>
References: <1488300679-3259-1-git-send-email-fabrice.gasnier@st.com>
 <1488300679-3259-2-git-send-email-fabrice.gasnier@st.com>
 <20170303062126.5bewa5u6o7wu7sy4@rob-hp-laptop>
CC: <jic23@kernel.org>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>, <linus.walleij@linaro.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <df84b9b2-dc93-287a-1ed2-52c818a64a01@st.com>
Date: Fri, 3 Mar 2017 10:32:47 +0100
MIME-Version: 1.0
In-Reply-To: <20170303062126.5bewa5u6o7wu7sy4@rob-hp-laptop>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 03/03/2017 07:21 AM, Rob Herring wrote:
> On Tue, Feb 28, 2017 at 05:51:14PM +0100, Fabrice Gasnier wrote:
>> Document iio provider and consumer bindings.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> ---
>>  .../devicetree/bindings/iio/iio-bindings.txt       | 38 ++++++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/iio-bindings.txt b/Documentation/devicetree/bindings/iio/iio-bindings.txt
>> index 68d6f8c..01765e9 100644
>> --- a/Documentation/devicetree/bindings/iio/iio-bindings.txt
>> +++ b/Documentation/devicetree/bindings/iio/iio-bindings.txt
>> @@ -95,3 +95,41 @@ vdd channel is connected to output 0 of the &ref device.
>>  		io-channels = <&adc 10>, <&adc 11>;
>>  		io-channel-names = "adc1", "adc2";
>>  	};
>> +
>> +==IIO trigger providers==
>> +Sources of IIO triggers can be represented by any node in the device
>> +tree. Those nodes are designated as IIO trigger providers. IIO trigger
>> +consumer uses a phandle and an IIO trigger specifier to connect to an
>> +IIO trigger provider.
>> +An IIO trigger specifier is an array of one or more cells identifying
>> +the IIO trigger output on a device. The length of an IIO trigger
>> +specifier is defined by the value of a #io-trigger-cells property in
>> +the IIO trigger provider node.
>> +
>> +Required properties:
>> +#io-trigger-cells:
>> +		Number of cells in an IIO trigger specifier; Typically
>> +		0 for nodes with a simple IIO trigger output.
>> +
>> +Example:
>> +	trig0: interrupt-trigger0 {
>> +		#io-trigger-cells = <0>;
>> +		compatible = "interrupt-trigger";
>> +		interrupts = <11 0>;
>> +		interrupt-parent = <&gpioa>;
>> +	}
>> +
>> +==IIO trigger consumers==
>> +Required properties:
>> +- io-triggers:	List of phandle representing the IIO trigger specifier.
>> +
>> +Optional properties:
>> +- io-trigger-names :
>> +		List of IIO trigger name strings that matches elements
>> +		in 'io-triggers' list property.
>> +
>> +Example:
>> +	some_trigger_consumer {
>> +		io-triggers = <&trig0>;
>> +		io-trigger-names = "mytrig";
>> +	}
>
> I have some reservations about this. We could just as easily add the
> interrupt directly to the consumer node and use "trigger" for a standard
Hi Rob,

Thanks for reviewing.

I hope I don't miss your point here... However, if I correctly
understand it:
Yes, this can be one way to get interrupt(s) directly from consumer 
node. Then, I understand consumer has to do exact same as what is being 
done in "iio_interrupt_trigger" for instance, basically:
- request irq, alloc and register trigger, do irq handling to call
trigger poll routine.

With current patchset, consumer is able to use standard trigger like
"interrupt-trigger" from DT. Please note I propose to add OF support
for it in current patchset (e.g. PATCHs 2 & 3). Currently only platform
data is supported.

-> And, please refer to PATCHs 5 & 6, I need to have some way to 
identify interrupt line (connected in HW to STM32 ADC IP). Currently,
this is best I came up with, trying to re-use, be generic, and to 
describe this HW in DT.

Of course, the other way is still valid. Also, I want to highlight,
STM32 has other IP, e.g. DAC, where same can be re-used then. This
will avoid having duplicates.

> interrupt name. So the question is whether this extra level of
> indirection is needed?

Purpose is to be able to get one or more named trigger(s) on consumer
side. Idea is to adopt similar 'philosophy' as in other bindings like
pinctrl, clk... where consumer has possibility to get them by name.
I hope this clarifies.

Please advise,
Best Regards,
Fabrice

>
> Rob
>
