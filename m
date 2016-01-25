Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35731 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933130AbcAYUYM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 25 Jan 2016 15:24:12 -0500
Subject: Re: [PATCH v4 1/4] Documentation: afe4404: Add DT bindings for the
 AFE4404 heart monitor
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1453742941-12086-1-git-send-email-afd@ti.com>
 <1453742941-12086-2-git-send-email-afd@ti.com>
 <alpine.DEB.2.02.1601252105090.14521@pmeerw.net>
CC: <linux-iio@vger.kernel.org>
From: "Andrew F. Davis" <afd@ti.com>
Message-ID: <56A68468.7050608@ti.com>
Date: Mon, 25 Jan 2016 14:24:08 -0600
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1601252105090.14521@pmeerw.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/25/2016 02:06 PM, Peter Meerwald-Stadler wrote:
> On Mon, 25 Jan 2016, Andrew F. Davis wrote:
>
>> Add the TI afe4404 heart monitor DT bindings documentation.
>> Create health directory created under iio.
>
> comment below
>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> ---
>>   .../devicetree/bindings/iio/health/afe4404.txt     | 30 ++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/health/afe4404.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/health/afe4404.txt b/Documentation/devicetree/bindings/iio/health/afe4404.txt
>> new file mode 100644
>> index 0000000..de69f20
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/health/afe4404.txt
>> @@ -0,0 +1,30 @@
>> +Texas Instruments AFE4404 Heart rate and Pulse Oximeter
>> +
>> +Required properties:
>> + - compatible		: Should be "ti,afe4404".
>> + - reg			: I2C address of the device.
>> + - tx-supply		: Regulator supply to transmitting LEDs.
>> + - interrupt-parent	: Phandle to he parent interrupt controller.
>> + - interrupts		: The interrupt line the device ADC_RDY pin is
>> +			  connected to. For details refer to,
>> +			  ../interrupt-controller/interrupts.txt.
>> +
>> +Optional properties:
>> + - reset-gpios		: GPIO used to reset the device.
>> +			  For details refer to, ../gpio/gpio.txt.
>
> remove ',' after 'to'
>

Hmm, looks like I did that above too, maybe I meant ':'?

>> +
>> +Example:
>> +
>> +&i2c2 {
>> +	heart_mon@58 {
>> +		compatible = "ti,afe4404";
>> +		reg = <0x58>;
>> +
>> +		tx-supply = <&vbat>;
>> +
>> +		interrupt-parent = <&gpio1>;
>> +		interrupts = <28 IRQ_TYPE_EDGE_RISING>;
>> +
>> +		reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
>> +	};
>> +};
>>
>
