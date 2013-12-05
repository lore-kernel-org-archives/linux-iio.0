Return-Path: <fugang.duan@freescale.com>
From: Fugang Duan <fugang.duan@freescale.com>
To: Mark Rutland <mark.rutland@arm.com>
CC: "jic23@kernel.org" <jic23@kernel.org>, "shawn.guo@linaro.org"
	<shawn.guo@linaro.org>, Frank Li <Frank.Li@freescale.com>,
	"otavio@ossystems.com.br" <otavio@ossystems.com.br>, "pmeerw@pmeerw.net"
	<pmeerw@pmeerw.net>, "lars@metafoo.de" <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v4 3/3] Documentation: add the binding file for
 Freescale vf610 ADC driver
Date: Thu, 5 Dec 2013 05:10:15 +0000
Message-ID: <9848F2DB572E5649BA045B288BE08FBE018BF745@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1386151203-29728-1-git-send-email-B38611@freescale.com>
 <1386151203-29728-4-git-send-email-B38611@freescale.com>
 <20131204113816.GI16025@e106331-lin.cambridge.arm.com>
In-Reply-To: <20131204113816.GI16025@e106331-lin.cambridge.arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

From: Mark Rutland <mark.rutland@arm.com>
Data: Wednesday, December 04, 2013 7:38 PM

>To: Duan Fugang-B38611
>Cc: jic23@kernel.org; shawn.guo@linaro.org; Li Frank-B20596;
>otavio@ossystems.com.br; pmeerw@pmeerw.net; lars@metafoo.de; linux-
>iio@vger.kernel.org
>Subject: Re: [PATCH v4 3/3] Documentation: add the binding file for Freesc=
ale
>vf610 ADC driver
>
>On Wed, Dec 04, 2013 at 10:00:03AM +0000, Fugang Duan wrote:
>> The patch adds the binding file for Freescale vf610 ADC driver.
>>
>> CC: Shawn Guo <shawn.guo@linaro.org>
>> CC: Jonathan Cameron <jic23@kernel.org>
>> CC: Mark Rutland <mark.rutland@arm.com>
>> CC: Otavio Salvador <otavio@ossystems.com.br>
>> CC: Peter Meerwald <pmeerw@pmeerw.net>
>> CC: Lars-Peter Clausen <lars@metafoo.de>
>> Signed-off-by: Fugang Duan <B38611@freescale.com>
>> ---
>>  .../devicetree/bindings/iio/adc/vf610-adc.txt      |   42
>++++++++++++++++++++
>>  1 files changed, 42 insertions(+), 0 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
>> b/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
>> new file mode 100644
>> index 0000000..32ae3bc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
>> @@ -0,0 +1,42 @@
>> +Freescale vf610 Analog to Digital Converter bindings
>> +
>> +The devicetree bindings are for the new ADC driver written for
>> +vf610/i.MX6slx and upward SoCs from Freescale.
>> +
>> +Required properties:
>> +- compatible: Should contain "fsl,vf610-adc"
>> +- reg: Offset and length of the register set for the device
>> +- interrupts: Should contain the interrupt for the device
>> +- clocks: The clock is needed by the ADC controller, ADC clock source i=
s ipg
>clock.
>
>The driver acquires the clock by name, and thus _requires_ clock-names.
>Please list the valid clock-names, and describe clocks property in terms o=
f it.
>
>> +- vref-supply: The regulator supply ADC refrence voltage.
>> +
>> +Optional properties:
>> +- fsl,adc-io-pinctl: Enable field for the I/O port control of MCU pins =
used
>as analog inputs.
>> +		     Bit[23:0] correspond to 23 I/O ports, set the relative bit
>for pointed port.
>> +
>> +Example:
>> +adc0: adc@4003b000 {
>> +	compatible =3D "fsl,vf610-adc";
>> +	reg =3D <0x4003b000 0x1000>;
>> +	interrupts =3D <0 53 0x04>;
>> +	clocks =3D <&clks VF610_CLK_ADC0>;
>> +	clock-names =3D "adc";
>> +	status =3D "disabled";
>> +};
>> +
>> +adc1: adc@400bb000 {
>> +	compatible =3D "fsl,vf610-adc";
>> +	reg =3D <0x400bb000 0x1000>;
>> +	interrupts =3D <0 54 0x04>;
>> +	clocks =3D <&clks VF610_CLK_ADC1>;
>> +	clock-names =3D "adc";
>> +	status =3D "disabled";
>> +};
>
>This is missing vref-supply, and it's never overriden. If this is not a fu=
ll
>example, remove it.
>
>> +
>> +&adc0 {
>> +	pinctrl-names =3D "default";
>> +	pinctrl-0 =3D <&pinctrl_adc0_ad5>;
>> +	fsl,adc-io-pinctl =3D <0x20>;
>> +	vref-supply =3D <&reg_vcc_3v3_mcu>;
>> +	status =3D "okay";
>
>Why is adc0 split? The example should be simple.
>
Thanks for your review. I will simplify it.

Thanks,
Andy
