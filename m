Return-Path: <shawn.guo@linaro.org>
Date: Sun, 16 Feb 2014 15:48:53 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Fugang Duan <B38611@freescale.com>
CC: <jic23@kernel.org>, <sachin.kamat@linaro.org>, <pmeerw@pmeerw.net>,
	<lars@metafoo.de>, <mark.rutland@arm.com>, <linux-iio@vger.kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Pawel
 Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 1/3] ARM: dts: vf610-twr: Add ADC support
Message-ID: <20140216074850.GA2946@S2101-09.ap.freescale.net>
References: <1390714773-23066-1-git-send-email-B38611@freescale.com>
 <1390714773-23066-2-git-send-email-B38611@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1390714773-23066-2-git-send-email-B38611@freescale.com>
List-ID: <linux-iio@vger.kernel.org>

Copy more DT folks and lists, as I want to make sure everyone agrees on
how the fixed regulators should organized in the device tree sources,
before I apply the patch.

On Sun, Jan 26, 2014 at 01:39:31PM +0800, Fugang Duan wrote:
> vf610 has two ADC controllers, and vf610-twr board ADC0_SE5 pin connect
> to sliding rheostat for ADC test, other ADC pins connect to connectors for
> future use.
> 
> Add support for ADC0_SE5.
> 
> CC: Shawn Guo <shawn.guo@linaro.org>
> CC: Jonathan Cameron <jic23@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: Otavio Salvador <otavio@ossystems.com.br>
> CC: Peter Meerwald <pmeerw@pmeerw.net>
> CC: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Fugang Duan <B38611@freescale.com>
> ---
>  arch/arm/boot/dts/vf610-twr.dts |   21 +++++++++++++++++++++
>  arch/arm/boot/dts/vf610.dtsi    |   26 ++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
> index c8047ca..d867be3 100644
> --- a/arch/arm/boot/dts/vf610-twr.dts
> +++ b/arch/arm/boot/dts/vf610-twr.dts
> @@ -34,6 +34,27 @@
>  		};
>  	};
>  
> +	regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		reg_vcc_3v3_mcu: regulator@0 {
> +			compatible = "regulator-fixed";
> +			reg = <0>;
> +			regulator-name = "vcc_3v3_mcu";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +		};
> +	};

Per discussion [1], Mark Rutland suggests that instead of organizing
the fixed regulator nodes in a simple-bus container, it should be put
under root node directly like below.

/ {
	reg_vcc_3v3_mcu: regulator_0 {
		compatible = "regulator-fixed";
		regulator-name = "vcc_3v3_mcu";
		regulator-min-microvolt = <3300000>;
		regulator-max-microvolt = <3300000>;
	};
};

Is this what all DT folks agree on?  At least the node name should be
'regulator-0' since it's more idiomatic to use '-' than '_' in node
name?

Shawn

[1] http://thread.gmane.org/gmane.linux.drivers.devicetree/61467/focus=300895

> +
> +};
> +
> +&adc0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_adc0_ad5>;
> +	vref-supply = <&reg_vcc_3v3_mcu>;
> +	status = "okay";
>  };
>  
>  &dspi0 {
> diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
> index d31ce1b..b5b21ea 100644
> --- a/arch/arm/boot/dts/vf610.dtsi
> +++ b/arch/arm/boot/dts/vf610.dtsi
> @@ -152,6 +152,15 @@
>  				clock-names = "pit";
>  			};
>  
> +			adc0: adc@4003b000 {
> +				compatible = "fsl,vf610-adc";
> +				reg = <0x4003b000 0x1000>;
> +				interrupts = <0 53 0x04>;
> +				clocks = <&clks VF610_CLK_ADC0>;
> +				clock-names = "adc";
> +				status = "disabled";
> +			};
> +
>  			wdog@4003e000 {
>  				compatible = "fsl,vf610-wdt", "fsl,imx21-wdt";
>  				reg = <0x4003e000 0x1000>;
> @@ -178,6 +187,14 @@
>  
>  				/* functions and groups pins */
>  
> +				adc0 {
> +					pinctrl_adc0_ad5: adc0_ad5 {
> +						fsl,pins = <
> +						VF610_PAD_PTC30__ADC0_SE5	0xa1
> +						>;
> +					};
> +				};
> +
>  				dcu0 {
>  					pinctrl_dcu0_1: dcu0grp_1 {
>  						fsl,pins = <
> @@ -450,6 +467,15 @@
>  				status = "disabled";
>  			};
>  
> +			adc1: adc@400bb000 {
> +				compatible = "fsl,vf610-adc";
> +				reg = <0x400bb000 0x1000>;
> +				interrupts = <0 54 0x04>;
> +				clocks = <&clks VF610_CLK_ADC1>;
> +				clock-names = "adc";
> +				status = "disabled";
> +			};
> +
>  			fec0: ethernet@400d0000 {
>  				compatible = "fsl,mvf600-fec";
>  				reg = <0x400d0000 0x1000>;
> -- 
> 1.7.2.rc3
> 
> 
