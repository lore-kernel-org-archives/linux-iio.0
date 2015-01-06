Return-Path: <robherring2@gmail.com>
MIME-Version: 1.0
In-Reply-To: <54AC146C.9030502@imgtec.com>
References: <1420558143-26276-1-git-send-email-ezequiel.garcia@imgtec.com>
 <1420558143-26276-3-git-send-email-ezequiel.garcia@imgtec.com>
 <CAL_Jsq+PwSjuqvfr6TfwwNzriRx9Nb1GHWWvWGFKK9zvOOORKA@mail.gmail.com> <54AC146C.9030502@imgtec.com>
From: Rob Herring <robherring2@gmail.com>
Date: Tue, 6 Jan 2015 11:19:06 -0600
Message-ID: <CAL_Jsq+y5t-c3OiMJyzyoKyusSWMX998b1PTZSz+RMtCO9Oh1w@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] DT: iio: adc: Add CC_10001 binding documentation
To: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc: Jonathan Cameron <jic23@kernel.org>, James Hartley <james.hartley@imgtec.com>,
	Andrew Bresticker <abrestic@chromium.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <Mark.Rutland@arm.com>, knaack.h@gmx.de,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Pawel Moll <Pawel.Moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
	Phani Movva <Phani.Movva@imgtec.com>, Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Jan 6, 2015 at 10:59 AM, Ezequiel Garcia
<ezequiel.garcia@imgtec.com> wrote:
> Hi Rob,
>
> Thanks a lot for the comments.
>
> On 01/06/2015 01:30 PM, Rob Herring wrote:
>> On Tue, Jan 6, 2015 at 9:29 AM, Ezequiel Garcia
>> <ezequiel.garcia@imgtec.com> wrote:
>>> From: Phani Movva <Phani.Movva@imgtec.com>
>>>
>>> Add the devicetree binding document for Cosmic Circuits 10001 ADC device.
>>>
>>> Signed-off-by: Phani Movva <Phani.Movva@imgtec.com>
>>> Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
>>> [Ezequiel: minor style cleaning]
>>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
>>> ---
>>>  .../devicetree/bindings/iio/adc/cc10001_adc.txt    | 22 ++++++++++++++++++++++
>>>  1 file changed, 22 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/cc10001_adc.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/cc10001_adc.txt b/Documentation/devicetree/bindings/iio/adc/cc10001_adc.txt
>>> new file mode 100644
>>> index 0000000..b7ba558
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/adc/cc10001_adc.txt
>>> @@ -0,0 +1,22 @@
>>> +* Cosmic Circuits - Analog to Digital Converter (CC-10001-ADC)
>>> +
>>> +Required properties:
>>> +  - compatible: Should be "cosmic,10001-adc"
>>> +  - reg: Should contain adc registers location and length.
>>> +  - clock-names: Should contain "adc".
>>> +  - clocks: Should contain a clock specifier for each entry in clock-names
>>> +  - vref-supply: The regulator supply ADC reference voltage.
>>> +
>>> +Optional properties:
>>> +  - cosmic,adc-reserved-channels: Bitmask of reserved channels,
>>> +    i.e. channels that cannot be used by the OS.
>>
>> Seems like this could be pretty common for any ADC as well as having
>> the number of channels, so you can drop the vendor prefix. Do we have
>> any similar properties already in other drivers?
>
> Well, it seems the AT91 ADC has a similar property called
> adc-channels-used. Not sure if it means the same as here. We are not
> using it to model a hardware availability but the channels being
> reserved for another core or OS. See [1].
>
>> I'd reverse the
>> polarity to be enabled channels, then the number of available channels
>> is the top set bit plus 1. You could count channels as is, but then
>> people have to remember to set the high bits on non-existent channels.
>
> Hm, isn't this too cumbersome? If we really need to pass the number of
> channels, shouldn't we have a separate property for that? Note that no
> driver currently needs it.

Okay.

>> Absence of the property could still mean you know how many channels
>> and all are enabled.
>>
>
> This property was originally proposed to be "called
> cosmic,adc-available-channels". Andrew suggested to reverse the
> polarity, and be explicit about absence of property meaning no reserved
> channels (also in [1]).

Okay, that's fine. I'd still suggest dropping cosmic. With that:

Acked-by: Rob Herring <robh@kernel.org>

Rob
