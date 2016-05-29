Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:32807 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932187AbcE2N5X (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2016 09:57:23 -0400
Subject: Re: [PATCH v5 2/2] iio: ad5755: Add DT binding documentation
To: =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean.nyekjaer@prevas.dk>,
	linux-iio@vger.kernel.org
References: <1457705561-12253-1-git-send-email-sean.nyekjaer@prevas.dk>
 <1457705561-12253-2-git-send-email-sean.nyekjaer@prevas.dk>
 <56E3E121.9030400@kernel.org> <56F94A21.6070804@kernel.org>
 <8a7b1dcb-205a-8801-737f-6aa1c39f6605@prevas.dk>
Cc: devicetree@vger.kernel.org, Pawel Moll <Pawel.Moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Lars-Peter Clausen <lars@metafoo.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8e62350f-ec4c-cba4-fa46-95549a89e720@kernel.org>
Date: Sun, 29 May 2016 14:57:18 +0100
MIME-Version: 1.0
In-Reply-To: <8a7b1dcb-205a-8801-737f-6aa1c39f6605@prevas.dk>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/05/16 09:16, Sean Nyekjær wrote:
> 
> 
> On 2016-03-28 17:13, Jonathan Cameron wrote:
>> On 12/03/16 09:28, Jonathan Cameron wrote:
>>> On 11/03/16 14:12, Sean Nyekjaer wrote:
>>>> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
>>> Looks much better to me.
>>>
>>> Looking for Acks from Lars and a device tree binding maintainer
>>> on this one though.
>>> (added CCs)
>> Lars?
> No response...
> Is there anything wrong with this?
Given we are early in cycle there is no real rush for this...

Lars, let me know if you are going to a while getting to this / any other
patches I want responses on from you.

Thanks,

Jonathan

>>> As an aside Device Tree bindings maintainers, do you prefer a personal cc
>>> or just getting them directly from the devicetree list?
>>>
>>> Jonthan
>>>> ---
>>>> Changes since v4:
>>>> - Appended -hz to dc-dc-freq
>>>> - Added adi,dc-dc-max-microvolt
>>>> - Added reg property
>>>>
>>>> Changes since v3:
>>>> - replaced '_' with '-'
>>>> - Now used actual values instead of register values.
>>>>
>>>> Changes since v2:
>>>>   - Removed defines, alot easier to read
>>>>
>>>>   .../devicetree/bindings/iio/dac/ad5755.txt         | 124 +++++++++++++++++++++
>>>>   1 file changed, 124 insertions(+)
>>>>   create mode 100644 Documentation/devicetree/bindings/iio/dac/ad5755.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iio/dac/ad5755.txt b/Documentation/devicetree/bindings/iio/dac/ad5755.txt
>>>> new file mode 100644
>>>> index 0000000..f0bbd7e
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/iio/dac/ad5755.txt
>>>> @@ -0,0 +1,124 @@
>>>> +* Analog Device AD5755 IIO Multi-Channel DAC Linux Driver
>>>> +
>>>> +Required properties:
>>>> + - compatible: Has to contain one of the following:
>>>> +    adi,ad5755
>>>> +    adi,ad5755-1
>>>> +    adi,ad5757
>>>> +    adi,ad5735
>>>> +    adi,ad5737
>>>> +
>>>> + - reg: spi chip select number for the device
>>>> + - spi-cpha or spi-cpol: is the only modes that is supported
>>>> +
>>>> +Recommended properties:
>>>> + - spi-max-frequency: Definition as per
>>>> +        Documentation/devicetree/bindings/spi/spi-bus.txt
>>>> +
>>>> +Optional properties:
>>>> +See include/dt-bindings/iio/ad5755.h
>>>> + - adi,ext-dc-dc-compenstation-resistor: boolean set if the hardware have an
>>>> +                     external resistor and thereby bypasses
>>>> +                     the internal compensation resistor.
>>>> + - adi,dc-dc-phase:
>>>> +    Valid values for DC DC Phase control is:
>>>> +    0: All dc-to-dc converters clock on the same edge.
>>>> +    1: Channel A and Channel B clock on the same edge,
>>>> +       Channel C and Channel D clock on opposite edges.
>>>> +    2: Channel A and Channel C clock on the same edge,
>>>> +       Channel B and Channel D clock on opposite edges.
>>>> +    3: Channel A, Channel B, Channel C, and Channel D
>>>> +       clock 90 degrees out of phase from each other.
>>>> + - adi,dc-dc-freq-hz:
>>>> +    Valid values for DC DC frequency is [Hz]:
>>>> +    250000
>>>> +    410000
>>>> +    650000
>>>> + - adi,dc-dc-max-microvolt:
>>>> +    Valid values for the maximum allowed Vboost voltage supplied by
>>>> +    the dc-to-dc converter is:
>>>> +    23000000
>>>> +    24500000
>>>> +    27000000
>>>> +    29500000
>>>> +
>>>> +Optional for every channel:
>>>> + - adi,mode:
>>>> +    Valid values for DAC modes is:
>>>> +    0: 0 V to 5 V voltage range.
>>>> +    1: 0 V to 10 V voltage range.
>>>> +    2: Plus minus 5 V voltage range.
>>>> +    3: Plus minus 10 V voltage range.
>>>> +    4: 4 mA to 20 mA current range.
>>>> +    5: 0 mA to 20 mA current range.
>>>> +    6: 0 mA to 24 mA current range.
>>>> + - adi,ext-current-sense-resistor: boolean set if the hardware a external
>>>> +                   current sense resistor.
>>>> + - adi,enable-voltage-overrange: boolean enable voltage overrange
>>>> + - adi,slew: Array of slewrate settings should contain 3 fields:
>>>> +    1: Should be either 0 or 1 in order to enable or disable slewrate.
>>>> +    2: Slew rate settings:
>>>> +        Valid values for the slew rate update frequency:
>>>> +        64000
>>>> +        32000
>>>> +        16000
>>>> +        8000
>>>> +        4000
>>>> +        2000
>>>> +        1000
>>>> +        500
>>>> +        250
>>>> +        125
>>>> +        64
>>>> +        32
>>>> +        16
>>>> +        8
>>>> +        4
>>>> +        0
>>>> +    3: Slew step size:
>>>> +        Valid values for the step size LSBs:
>>>> +        1
>>>> +        2
>>>> +        4
>>>> +        16
>>>> +        32
>>>> +        64
>>>> +        128
>>>> +        256
>>>> +
>>>> +Example:
>>>> +dac@0 {
>>>> +    #address-cells = <1>;
>>>> +    #size-cells = <0>;
>>>> +    compatible = "adi,ad5755";
>>>> +    reg = <0>;
>>>> +    spi-max-frequency = <1000000>;
>>>> +    spi-cpha;
>>>> +    adi,dc-dc-phase = <0>;
>>>> +    adi,dc-dc-freq-hz = <410000>;
>>>> +    adi,dc-dc-max-microvolt = <23000000>;
>>>> +    channel@0 {
>>>> +        reg = <0>;
>>>> +        adi,mode = <4>;
>>>> +        adi,ext-current-sense-resistor;
>>>> +        adi,slew = <0 64000 1>;
>>>> +    };
>>>> +    channel@1 {
>>>> +        reg = <1>;
>>>> +        adi,mode = <4>;
>>>> +        adi,ext-current-sense-resistor;
>>>> +        adi,slew = <0 64000 1>;
>>>> +    };
>>>> +    channel@2 {
>>>> +        reg = <2>;
>>>> +        adi,mode = <4>;
>>>> +        adi,ext-current-sense-resistor;
>>>> +        adi,slew = <0 64000 1>;
>>>> +    };
>>>> +    channel@3 {
>>>> +        reg = <3>;
>>>> +        adi,mode = <4>;
>>>> +        adi,ext-current-sense-resistor;
>>>> +        adi,slew = <0 64000 1>;
>>>> +    };
>>>> +};
>>>>
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

