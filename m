Return-Path: <robh@kernel.org>
MIME-Version: 1.0
In-Reply-To: <986a7404-e157-6a1b-0610-07d1e127465f@axentia.se>
References: <20180319170246.26830-1-peda@axentia.se> <20180319170246.26830-3-peda@axentia.se>
 <20180326222326.sxdeawy5x5bjkla4@rob-hp-laptop> <986a7404-e157-6a1b-0610-07d1e127465f@axentia.se>
From: Rob Herring <robh@kernel.org>
Date: Thu, 29 Mar 2018 08:55:34 -0500
Message-ID: <CAL_JsqJ3RZoMX+Q5boK-w3uHc=qgPCye7esXxJuwQcMM0HPLNw@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: iio: wrapper: add io-channel-unit-converter
To: Peter Rosin <peda@axentia.se>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Mark Rutland <mark.rutland@arm.com>,
	"David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Tue, Mar 27, 2018 at 3:01 AM, Peter Rosin <peda@axentia.se> wrote:
> On 2018-03-27 00:23, Rob Herring wrote:
>> On Mon, Mar 19, 2018 at 06:02:45PM +0100, Peter Rosin wrote:
>>> Allow linear scaling and modification of the type of an io-channel.
>>>
>>> When an ADC channel measures the midpoint of a voltage divider, the
>>> interesting voltage is often the voltage over the full resistance
>>> of the divider. Likewise, measuring the voltage over a resistor is
>>> often a way to get to the current through it.
>>>
>>> This binding allows description of such hardware which is external
>>> to the ADC.
>>>
>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>> ---
>>>  .../iio/wrapper/io-channel-unit-converter.txt      | 84 ++++++++++++++++++++++
>>>  MAINTAINERS                                        |  6 ++
>>>  2 files changed, 90 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt b/Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
>>> new file mode 100644
>>> index 000000000000..23af661abe32
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
>>> @@ -0,0 +1,84 @@
>>> +I/O channel unit converter bindings
>>> +
>>> +Allow linear scaling and modification of the type of an io-channel.
>>> +
>>> +When an ADC channel measures the midpoint of a voltage divider, the
>>> +interesting voltage is often the voltage over the full resistance
>>> +of the divider. Likewise, measuring the voltage over a resistor is
>>> +often a way to get to the current through it.
>>> +
>>> +Required properties:
>>> +- compatible : "io-channel-unit-converter"
>>
>> Would this apply to something besides ADCs?
>
> Not that I can think of. At the moment.
>
>>> +- io-channels : Channel node of the parent channel.
>>> +- io-channel-names : Should be "parent".
>>> +
>>> +Optional properties:
>>> +- numerator : The parent channel scale is multiplied by this value (default 1).
>>> +- denominator : The parent channel scale is divided by this value (default 1).
>>> +- type : The type of the wrapped channel is modified to this type. The default
>>> +     is to use the same type as the parent channel. Recognized types are:
>>> +            "voltage"
>>> +            "current"
>>
>> This seems overly complicated for just describing a couple of resistors
>> on an ADC. OTOH, keeping the ADC node and what's attached to the ADC
>> separate
>>
>> Perhaps the type should be part of the compatible. For example, if you
>> have a current measurement resistor/circuit, then the compatible should
>> be based on that.
>
> Is a compatible like "current-sense-circuit" too long(ish)?

No, that's fine.

> Is a vendor prefix absolutely required?

No, it can be common.

> Sure, I can use "axentia,"
> because we "implemented" the circuit this time, but it seems like
> the list can grow very long if we should add every vendor that
> may use something like this? Something more generic would be good
> for something as simple as this IMHO.
>
> I propose the compatible "voltage-divider" for the other example,
> but I have the same issue with the vendor prefix. Even more so
> in this case.

"voltage-divider" doesn't really say what the purpose is.
>
> Then the above type can be inferred from the compatible. I suppose
> I should write the above two bindings as two separate files?

One is fine if the only difference is the compatible.

>>> +
>>> +Example 1:
>>> +The system voltage is circa 12V, but divided down with a 22/200
>>> +voltage divider to adjust it to the ADC range.
>>> +
>>> +SYSV        ADC       GND
>>> +  +          +         +
>>> +  |  .-----. | .----.  |
>>> +  '--| 200 |-+-| 22 |--'
>>> +     '-----'   '----'
>>> +
>>> +sysv {
>>> +    compatible = "io-channel-unit-converter";
>>> +    io-channles = <&maxadc 1>;
>>> +    io-channel-names = "parent";
>>
>> parent doesn't seem to describe something about the h/w.
>
> Extrapolating from your first question, you are thinking "adc", right?

I don't really have any suggestion. With only 1 channel, there's not
really much point to having a name at all.

Rob
