Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56840 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbbLLRDH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Dec 2015 12:03:07 -0500
Subject: Re: [PATCH v9 2/8] ARM: dt: Binding documentation for imx25 GCQ
To: Rob Herring <robh@kernel.org>, Markus Pargmann <mpa@pengutronix.de>
References: <1449431542-1892-1-git-send-email-mpa@pengutronix.de>
 <1449431542-1892-3-git-send-email-mpa@pengutronix.de>
 <20151207173906.GA29656@rob-hp-laptop>
Cc: Shawn Guo <shawnguo@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee.jones@linaro.org>,
	Denis Carikli <denis@eukrea.com>,
	=?UTF-8?Q?Eric_B=c3=a9nard?= <eric@eukrea.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Fabio Estevam <festevam@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <566C5344.4090107@kernel.org>
Date: Sat, 12 Dec 2015 17:03:00 +0000
MIME-Version: 1.0
In-Reply-To: <20151207173906.GA29656@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/12/15 17:39, Rob Herring wrote:
> On Sun, Dec 06, 2015 at 08:52:15PM +0100, Markus Pargmann wrote:
>> The documentation describes the bindings for the imx25 GCQ unit which is
>> essentially a generic conversion queue using the imx25 ADC.
>>
>> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> 
> Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> 
>> ---
>>
>> Notes:
>>     Changes in v9:
>>      - Added the dt-bindings header to this patch instead of the driver
>>     
>>     Changes in v6:
>>      - Changed bindings to use adc-refp and adc-refn. Also a bit of cleanup in the
>>        setup routine.
>>     
>>     Changes in v5:
>>      - Fixed locking
>>      - Removed module owner
>>
>>  .../devicetree/bindings/iio/adc/fsl,imx25-gcq.txt  | 58 ++++++++++++++++++++++
>>  include/dt-bindings/iio/adc/fsl-imx25-gcq.h        | 18 +++++++
>>  2 files changed, 76 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
>>  create mode 100644 include/dt-bindings/iio/adc/fsl-imx25-gcq.h
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt b/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
>> new file mode 100644
>> index 000000000000..b0866d36a307
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
>> @@ -0,0 +1,58 @@
>> +Freescale i.MX25 ADC GCQ device
>> +
>> +This is a generic conversion queue device that can convert any of the
>> +analog inputs using the ADC unit of the i.MX25.
>> +
>> +Required properties:
>> + - compatible: Should be "fsl,imx25-gcq".
>> + - reg: Should be the register range of the module.
>> + - interrupts: Should be the interrupt number of the module.
>> +   Typically this is <1>.
>> + - interrupt-parent: phandle to the tsadc module of the i.MX25.
>> + - #address-cells: Should be <1> (setting for the subnodes)
>> + - #size-cells: Should be <0> (setting for the subnodes)
>> +
>> +Optional properties:
>> + - vref-ext-supply: The regulator supplying the ADC reference voltage.
>> +   Required when at least one subnode uses the this reference.
>> + - vref-xp-supply: The regulator supplying the ADC reference voltage on pin XP.
>> +   Required when at least one subnode uses this reference.
>> + - vref-yp-supply: The regulator supplying the ADC reference voltage on pin YP.
>> +   Required when at least one subnode uses this reference.
>> +
>> +Sub-nodes:
>> +Optionally you can define subnodes which define the reference voltage
>> +for the analog inputs.
>> +
>> +Required properties for subnodes:
>> + - reg: Should be the number of the analog input.
>> +     0: xp
>> +     1: yp
>> +     2: xn
>> +     3: yn
>> +     4: wiper
>> +     5: inaux0
>> +     6: inaux1
>> +     7: inaux2
>> +Optional properties for subnodes:
>> + - fsl,adc-refp: specifies the positive reference input as defined in
>> +     <dt-bindings/iio/adc/fsl-imx25-gcq.h>
>> + - fsl,adc-refn: specifies the negative reference input as defined in
>> +     <dt-bindings/iio/adc/fsl-imx25-gcq.h>
>> +
>> +Example:
>> +
>> +	adc: adc@50030800 {
>> +		compatible = "fsl,imx25-gcq";
>> +		reg = <0x50030800 0x60>;
>> +		interrupt-parent = <&tscadc>;
>> +		interrupts = <1>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		inaux@5 {
>> +			reg = <5>;
>> +			fsl,adc-refp = <MX25_ADC_REFP_INT>;
>> +			fsl,adc-refn = <MX25_ADC_REFN_NGND>;
>> +		};
>> +	};
>> diff --git a/include/dt-bindings/iio/adc/fsl-imx25-gcq.h b/include/dt-bindings/iio/adc/fsl-imx25-gcq.h
>> new file mode 100644
>> index 000000000000..87abdd4a7674
>> --- /dev/null
>> +++ b/include/dt-bindings/iio/adc/fsl-imx25-gcq.h
>> @@ -0,0 +1,18 @@
>> +/*
>> + * This header provides constants for configuring the I.MX25 ADC
>> + */
>> +
>> +#ifndef _DT_BINDINGS_IIO_ADC_FS_IMX25_GCQ_H
>> +#define _DT_BINDINGS_IIO_ADC_FS_IMX25_GCQ_H
>> +
>> +#define MX25_ADC_REFP_YP	0 /* YP voltage reference */
>> +#define MX25_ADC_REFP_XP	1 /* XP voltage reference */
>> +#define MX25_ADC_REFP_EXT	2 /* External voltage reference */
>> +#define MX25_ADC_REFP_INT	3 /* Internal voltage reference */
>> +
>> +#define MX25_ADC_REFN_XN	0 /* XN ground reference */
>> +#define MX25_ADC_REFN_YN	1 /* YN ground reference */
>> +#define MX25_ADC_REFN_NGND	2 /* Internal ground reference */
>> +#define MX25_ADC_REFN_NGND2	3 /* External ground reference */
>> +
>> +#endif
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

