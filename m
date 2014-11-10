Return-Path: <abrestic@google.com>
MIME-Version: 1.0
Sender: abrestic@google.com
In-Reply-To: <54611934.6050701@imgtec.com>
References: <1415224611-22096-1-git-send-email-ezequiel.garcia@imgtec.com>
	<1415224611-22096-3-git-send-email-ezequiel.garcia@imgtec.com>
	<545E1333.9010904@kernel.org>
	<5461170B.7070505@imgtec.com>
	<54611934.6050701@imgtec.com>
Date: Mon, 10 Nov 2014 13:28:33 -0800
Message-ID: <CAL1qeaHzp==jmTB8dJ1M3NuocwuSqsfbVSU4nuM50vrOyfJ3qA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] DT: iio: adc: Add CC_10001 binding documentation
From: Andrew Bresticker <abrestic@chromium.org>
To: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	James Hartley <james.hartley@imgtec.com>, Phani Movva <phani.movva@imgtec.com>,
	linux-iio@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Naidu Tellapati <Naidu.Tellapati@imgtec.com>,
	Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Ezequiel,

On Mon, Nov 10, 2014 at 11:59 AM, Ezequiel Garcia
<ezequiel.garcia@imgtec.com> wrote:
> On 11/10/2014 04:50 PM, Ezequiel Garcia wrote:
>> On 11/08/2014 09:57 AM, Jonathan Cameron wrote:
>>> On 05/11/14 21:56, Ezequiel Garcia wrote:
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/cc_10001_adc.txt b/Documentation/devicetree/bindings/iio/adc/cc_10001_adc.txt
>>>> new file mode 100644
>>>> index 0000000..6491839
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/iio/adc/cc_10001_adc.txt
>>>> @@ -0,0 +1,19 @@
>>>> +* Cosmic Circuits - Analog to Digital Converter (CC-10001-ADC)
>>>> +
>>>> +Required properties:
>>>> +  - compatible: Should be "cosmic,10001-adc"
>>>> +  - reg: Should contain adc registers location and length.
>>>> +  - cosmic,adc-available-channels: Bitmask of the channels currently enabled.
>>> I suspect there may be other preferred ways of doing this (child nodes perhaps
>>> for each enabled channel?)
>>
>> Hm, I'm not sure about this. As far I can recall, if a node has children
>> then it *must* be a bus, which is not the case. Of course, you'll find
>> examples doing this wrong.
>>
>
> On a second thought... I guess you meant something like this?
>
> adc: adc@18101600 {
>         compatible = "cosmic,10001-adc";
>         reg = <0x18101600 0x24>;
>         clocks = <&adc_clk>;
>         clock-names = "adc";
>         vref-supply = <&reg_1v8>;
>         cosmic,channels {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 channel@0 {
>                         reg = <0>;
>                 };
>                 channel@1 {
>                         reg = <1>;
>                 };
>         };
> };
>
> Might be better, but I don't have a strong opinion on it.

I actually don't think this is any better.  The point of the property
is to indicate which channels are available for use by the main CPU,
i.e. channels not used by the RPU co-processor.  The property is not
used to indicate the presence of certain channels in hardware, in
which case maybe a bus would be appropriate.

Also, perhaps it would be better to reverse the sense of the property
(maybe, "cosmic,reserved-adc-channels") and make it optional?  I did
something similar for the MIPS GIC binding:
http://patchwork.linux-mips.org/patch/8268/.
