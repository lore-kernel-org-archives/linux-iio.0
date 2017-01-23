Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34573 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751102AbdAWT55 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Jan 2017 14:57:57 -0500
Subject: Re: [PATCH 1/2] iio: adc: Add Renesas GyroADC bindings
To: Rob Herring <robh@kernel.org>
References: <20170121144212.8858-1-marek.vasut@gmail.com>
 <20170123170827.tkatb2aizjhbfifo@rob-hp-laptop>
Cc: linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <63b3660b-6ce0-134c-ef79-c06430c735c5@gmail.com>
Date: Mon, 23 Jan 2017 20:56:51 +0100
MIME-Version: 1.0
In-Reply-To: <20170123170827.tkatb2aizjhbfifo@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/23/2017 06:08 PM, Rob Herring wrote:
> On Sat, Jan 21, 2017 at 03:42:11PM +0100, Marek Vasut wrote:
>> Add DT bindings for the Renesas RCar GyroADC block. This block is
>> a simple 4/8-channel ADC which samples 12/15/24 bits of data every
>> cycle from all channels.
> 
> Isn't this v7?

Technically yes, it was part of the 2/2 until now.

>> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Simon Horman <horms+renesas@verge.net.au>
>> Cc: Jonathan Cameron <jic23@kernel.org>
>> Cc: linux-renesas-soc@vger.kernel.org
>> Cc: Wolfram Sang <wsa@the-dreams.de>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: devicetree@vger.kernel.org
>> ---
>>  .../bindings/iio/adc/renesas,gyroadc.txt           | 93 ++++++++++++++++++++++
>>  1 file changed, 93 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt b/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
>> new file mode 100644
>> index 000000000000..081947367135
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
>> @@ -0,0 +1,93 @@
>> +* Renesas RCar GyroADC device driver
> 
> What's a GyroADC?

The GyroADC block is a reduced SPI block with up to 8 chipselect lines,
which supports the SPI protocol of a selected few SPI ADCs. The SPI ADCs
are sampled by the GyroADC block in a round-robin fashion and the result
presented in the GyroADC registers.

Good ?

>> +
>> +Required properties:
>> +- compatible:	Should be "renesas,<chip>-gyroadc", "renesas,rcar-gyroadc".
> 
> Need to enumerate <chip>.

It's enumerated below , the only special-case we handle at this point is
the r8a7792 , which has extra interrupt block which we don't use anyway,
but the driver disables those interrupts.

>> +		Use "renesas,r8a7792-gyroadc" for a GyroADC with interrupt
>> +		block found in R8A7792.

I can add .... otherwise use the matching SoC model in <chip> field.

>> +- reg:		Address and length of the register set for the device
>> +- clocks:	References to all the clocks specified in the clock-names
>> +		property as specified in
>> +		Documentation/devicetree/bindings/clock/clock-bindings.txt.
>> +- clock-names:	Shall contain "fck" and "if". The "fck" is the GyroADC block
>> +		clock, the "if" is the interface clock.
>> +- power-domains: Must contain a reference to the PM domain, if available.
>> +- #address-cells: Should be <1> (setting for the subnodes) for all ADCs
>> +		except for "fujitsu,mb88101a". Should be <0> (setting for
>> +		only subnode) for "fujitsu,mb88101a".
>> +- #size-cells:	Should be <0> (setting for the subnodes)
>> +
>> +Sub-nodes:
>> +Optionally you can define subnodes which select the connected ADC type and
>> +reference voltage for the GyroADC channels.
> 
> Seems strange to be optional. How many nodes are possible?

1, up-to 4 or up-to 8, depending on the ADC you connect.

I guess it can be made mandatory as not having any ADC attached would
make it pretty pointless to enable this block in the first place ...

>> +
>> +Required properties for subnodes:
>> +- compatible:	Should be either of:
>> +		"fujitsu,mb88101a"
>> +			- Fujitsu MB88101A compatible mode,
>> +			  12bit sampling, up to 4 channels can be sampled in
>> +			  round-robin fashion. One Fujitsu chip supplies four
>> +			  GyroADC channels with data as it contains four ADCs
>> +			  on the chip and thus for 4-channel operation, single
>> +			  MB88101A is required. The Cx chipselect lines of the
>> +			  MB88101A connect directly to two CHS lines of the
>> +			  GyroADC, no demuxer is required. The data out line
>> +			  of each MB88101A connects to a shared input pin of
>> +			  the GyroADC.
>> +		"ti,adcs7476" or "ti,adc121" or "adi,ad7476"
>> +			- TI ADCS7476 / TI ADC121 / ADI AD7476 compatible mode,
>> +			  15bit sampling, up to 8 channels can be sampled in
>> +			  round-robin fashion. One TI/ADI chip supplies single
>> +			  ADC channel with data, thus for 8-channel operation,
>> +			  8 chips are required. A 3:8 chipselect demuxer is
>> +			  required to connect the nCS line of the TI/ADI chips
>> +			  to the GyroADC, while MISO line of each TI/ADI ADC
>> +			  connects to a shared input pin of the GyroADC.
>> +		"maxim,max1162" or "maxim,max11100"
>> +			- Maxim MAX1162 / Maxim MAX11100 compatible mode,
>> +			  16bit sampling, up to 8 channels can be sampled in
>> +			  round-robin fashion. One Maxim chip supplies single
>> +			  ADC channel with data, thus for 8-channel operation,
>> +			  8 chips are required. A 3:8 chipselect demuxer is
>> +			  required to connect the nCS line of the MAX chips
>> +			  to the GyroADC, while MISO line of each Maxim ADC
>> +			  connects to a shared input pin of the GyroADC.
>> +- reg:		Should be the number of the analog input. Should be present
>> +		for all ADCs except "fujitsu,mb88101a".
>> +- vref-supply:	Reference to the channel reference voltage regulator.
>> +
>> +Example:
>> +	vref_max1162: regulator-vref-max1162 {
>> +		compatible = "regulator-fixed";
>> +
>> +		regulator-name = "MAX1162 Vref";
>> +		regulator-min-microvolt = <4096000>;
>> +		regulator-max-microvolt = <4096000>;
>> +	};
>> +
>> +	&adc {
>> +		compatible = "renesas,r8a7791-gyroadc", "renesas,rcar-gyroadc";
>> +		reg = <0 0xe6e54000 0 64>;
>> +		clocks = <&mstp9_clks R8A7791_CLK_GYROADC>, <&clk_65m>;
>> +		clock-names = "fck", "if";
>> +		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
>> +
>> +		pinctrl-0 = <&adc_pins>;
>> +		pinctrl-names = "default";
>> +
>> +		status = "okay";
> 
> Drop status from examples.

Dropped.

>> +
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		adc@0 {
>> +			reg = <0>;
>> +			compatible = "maxim,max1162";
>> +			vref-supply = <&vref_max1162>;
>> +		};
>> +
>> +		adc@1 {
>> +			reg = <1>;
>> +			compatible = "maxim,max1162";
>> +			vref-supply = <&vref_max1162>;
>> +		};
>> +	};
>> -- 
>> 2.11.0
>>


-- 
Best regards,
Marek Vasut
