Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34013 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbbLESVZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Dec 2015 13:21:25 -0500
Subject: Re: [PATCH v2 1/2] Documentation: afe4404: Add DT bindings for the
 AFE4404 heart monitor
To: "Andrew F. Davis" <afd@ti.com>, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
References: <1449086240-13375-1-git-send-email-afd@ti.com>
 <1449086240-13375-2-git-send-email-afd@ti.com> <56632122.8040702@kernel.org>
 <56632499.9080708@ti.com>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56632B1E.1040907@kernel.org>
Date: Sat, 5 Dec 2015 18:21:18 +0000
MIME-Version: 1.0
In-Reply-To: <56632499.9080708@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/12/15 17:53, Andrew F. Davis wrote:
> On 12/05/2015 11:38 AM, Jonathan Cameron wrote:
>> On 02/12/15 19:57, Andrew F. Davis wrote:
>>> Add the TI afe4404 heart monitor DT bindings documentation.
>>> Create health directory created under iio.
>>>
>>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> One little point inline - otherwise this is straightforward and
>> looks good to me.
>>
>> Could add cross references to the interrupt and gpio docs.
>>
> 
> Will add.
> 
>> Jonathan
>>> ---
>>>   .../devicetree/bindings/iio/health/afe4404.txt     | 27 ++++++++++++++++++++++
>>>   1 file changed, 27 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/iio/health/afe4404.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/health/afe4404.txt b/Documentation/devicetree/bindings/iio/health/afe4404.txt
>>> new file mode 100644
>>> index 0000000..25b77a4
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/health/afe4404.txt
>>> @@ -0,0 +1,27 @@
>>> +* Texas Instruments AFE4404 Heart rate and Pulse Oximeter
>>> +
>>> +Required properties:
>>> + - compatible        : Should be "ti,afe4404".
>>> + - reg            : I2C address of the device.
>>> + - tx_sup-supply    : Regulator supply to LEDs.
>> If the sup bit is for supply I'd drop it and just have
>> tx-supply.
> 
> It is, the name of the pin in the datasheet is "tx_sup", so
> I went with that.
Drop it - I suspect the device tree guys would prefer it without
and it's not hard to make the connection with the datasheet name!
> 
>>> + - interrupt-parent    : Phandle to he parent interrupt controller.
>>> + - interrupts        : The interrupt line the device ADC_RDY pin is connected to.
>>> +
>>> +Optional properties:
>>> + - reset-gpios        : GPIO used to reset the device.
>>> +
>>> +Example:
>>> +
>>> +&i2c2 {
>>> +    heart_mon@58 {
>>> +        compatible = "ti,afe4404";
>>> +        reg = <0x58>;
>>> +
>>> +        tx_sup-supply = <&vbat>;
>>> +
>>> +        interrupt-parent = <&gpio1>;
>>> +        interrupts = <28 IRQ_TYPE_EDGE_RISING>;
>>> +
>>> +        reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
>>> +    };
>>> +};
>>>
>>

