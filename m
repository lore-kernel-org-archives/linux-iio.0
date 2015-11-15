Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45996 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbbKOK5H (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Nov 2015 05:57:07 -0500
Subject: Re: [PATCH v6 2/2] iio: ti-ads8688: Add DT binding documentation
To: Rob Herring <robh@kernel.org>,
	Sean Nyekjaer <sean.nyekjaer@prevas.dk>
References: <1447073580-17889-1-git-send-email-sean.nyekjaer@prevas.dk>
 <1447073580-17889-2-git-send-email-sean.nyekjaer@prevas.dk>
 <20151109155759.GA23092@rob-hp-laptop>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56486500.6040707@kernel.org>
Date: Sun, 15 Nov 2015 10:57:04 +0000
MIME-Version: 1.0
In-Reply-To: <20151109155759.GA23092@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/11/15 15:57, Rob Herring wrote:
> On Mon, Nov 09, 2015 at 01:53:00PM +0100, Sean Nyekjaer wrote:
>> Adding binding documentation for Texas Instruments ADS8688 ADC.
>>
>> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
>> Reviewed-by: Martin Hundebøll <martin.hundeboll@prevas.dk>
> 
> Acked-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git - initially pushed out
as testing to let the autobuilders work their magic.

Thanks and thanks Rob for reviewing these bindings!

Jonathan
> 
>> ---
>> Changes since v2:
>> - Moved vref-supply to Optional properties
>>
>>  .../devicetree/bindings/iio/adc/ti-ads8688.txt       | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads8688.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/ti-ads8688.txt b/Documentation/devicetree/bindings/iio/adc/ti-ads8688.txt
>> new file mode 100644
>> index 0000000..a02337d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/ti-ads8688.txt
>> @@ -0,0 +1,20 @@
>> +* Texas Instruments' ADS8684 and ADS8688 ADC chip
>> +
>> +Required properties:
>> + - compatible: Should be "ti,ads8684" or "ti,ads8688"
>> + - reg: spi chip select number for the device
>> +
>> +Recommended properties:
>> + - spi-max-frequency: Definition as per
>> +		Documentation/devicetree/bindings/spi/spi-bus.txt
>> +
>> +Optional properties:
>> + - vref-supply: The regulator supply for ADC reference voltage
>> +
>> +Example:
>> +adc@0 {
>> +	compatible = "ti,ads8688";
>> +	reg = <0>;
>> +	vref-supply = <&vdd_supply>;
>> +	spi-max-frequency = <1000000>;
>> +};
>> -- 
>> 2.6.2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

