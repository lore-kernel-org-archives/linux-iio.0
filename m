Return-Path: <Michael.Hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
Subject: Re: [PATCH v3] iio: dac: Add support for the AD5592R/AD5593R
 ADCs/DACs
References: <1457009883-4017-1-git-send-email-michael.hennerich@analog.com>
 <20160305042952.GA13525@rob-hp-laptop>
To: Rob Herring <robh@kernel.org>
CC: <jic23@kernel.org>, <linus.walleij@linaro.org>, <gnurou@gmail.com>,
	<lars@metafoo.de>, <knaack.h@gmx.de>, <paul.cercueil@analog.com>,
	<pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>
From: Michael Hennerich <michael.hennerich@analog.com>
Message-ID: <56DD7393.5070207@analog.com>
Date: Mon, 7 Mar 2016 13:26:59 +0100
MIME-Version: 1.0
In-Reply-To: <20160305042952.GA13525@rob-hp-laptop>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 03/05/2016 05:29 AM, Rob Herring wrote:
> On Thu, Mar 03, 2016 at 01:58:03PM +0100, michael.hennerich@analog.com wrote:
>> From: Paul Cercueil <paul.cercueil@analog.com>
>>
>> This patch adds support for the AD5592R (spi) and AD5593R (i2c)
>> ADC/DAC devices.
>>
>> Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>
> [...]
>
>> +AD5592R Example:
>> +
>> +	#include <dt-bindings/iio/adi,ad5592r.h>
>> +
>> +	vref: regulator-vref {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vref-ad559x";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-always-on;
>> +	};
>> +
>> +	ad5592r@0 {
>> +		#size-cells = <0>;
>> +		#address-cells = <1>;
>> +		compatible = "adi,ad5592r";
>> +		reg = <0>;
>> +		spi-max-frequency = <1000000>;
>> +		spi-cpol;
>> +
>> +		vref-supply = <&vref>; /* optional */
>> +		reset-gpios = <&gpio0 86 0>;  /* optional */
>> +
>> +		channel@0 {
>> +			reg = <0>;
>> +			mode = <CH_MODE_DAC>;
>
> You are missing the vendor prefixes thoughout.
>

Thanks

Right - I'll fix this ASAP.


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
