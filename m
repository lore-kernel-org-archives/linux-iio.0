Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34928 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750893AbdAUNdO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 08:33:14 -0500
Subject: Re: [PATCHv5 2/2] dt-bindings: iio: document MAX11100 ADC
To: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        wsa+renesas@sang-engineering.com, magnus.damm@gmail.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        marek.vasut@gmail.com, geert@linux-m68k.org, robh+dt@kernel.org,
        mark.rutland@arm.com
References: <1484757053-7102-1-git-send-email-jacopo+renesas@jmondi.org>
 <1484757053-7102-3-git-send-email-jacopo+renesas@jmondi.org>
 <ff915715-98c4-9792-eae7-9f466d5fa459@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8b5a8edf-b3d5-b979-d793-07615a6ae02b@kernel.org>
Date: Sat, 21 Jan 2017 13:33:11 +0000
MIME-Version: 1.0
In-Reply-To: <ff915715-98c4-9792-eae7-9f466d5fa459@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/01/17 13:22, Jonathan Cameron wrote:
> On 18/01/17 16:30, Jacopo Mondi wrote:
>> Add device tree bindings documentation for Maxim MAX11100 single-channel
>> ADC
>>
>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Simple enough I'm happy to take it without bothering Rob or Mark. 
> However, any device tree bindings at all should be cc'd to them and to the devicetree
> list.
> 
> Done in case anyone wants to comment.

Also applied to the togreg branch of iio.git which is pushed out as testing for
the autobuilders to play with everything in it.

Thanks,

Jonathan
>> ---
>>  .../devicetree/bindings/iio/adc/max11100.txt          | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/max11100.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/max11100.txt b/Documentation/devicetree/bindings/iio/adc/max11100.txt
>> new file mode 100644
>> index 0000000..ad0bc31
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/max11100.txt
>> @@ -0,0 +1,19 @@
>> +* Maxim max11100 Analog to Digital Converter (ADC)
>> +
>> +Required properties:
>> +  - compatible: Should be "maxim,max11100"
>> +  - reg: the adc unit address
>> +  - vref-supply: phandle to the regulator that provides reference voltage
>> +
>> +Optional properties:
>> +  - spi-max-frequency: SPI maximum frequency
>> +
>> +Example:
>> +
>> +max11100: adc@0 {
>> +        compatible = "maxim,max11100";
>> +        reg = <0>;
>> +        vref-supply = <&adc0_vref>;
>> +        spi-max-frequency = <240000>;
>> +};
>> +
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

