Return-Path: <shawn.guo@linaro.org>
Date: Mon, 9 Dec 2013 10:35:05 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Fugang Duan <B38611@freescale.com>
CC: <jic23@kernel.org>, <b20596@freescale.com>, <mark.rutland@arm.com>,
	<otavio@ossystems.com.br>, <pmeerw@pmeerw.net>, <lars@metafoo.de>,
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] ARM: dts: vf610-twr: Add ADC support
Message-ID: <20131209023503.GB825@S2101-09.ap.freescale.net>
References: <1386151203-29728-1-git-send-email-B38611@freescale.com>
 <1386151203-29728-2-git-send-email-B38611@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1386151203-29728-2-git-send-email-B38611@freescale.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Dec 04, 2013 at 06:00:01PM +0800, Fugang Duan wrote:
> vf610 have two ADC controllers, and vf610-twr board ADC0_SE5 pin connect
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
>  arch/arm/boot/dts/vf610-twr.dts |   19 +++++++++++++++++++
>  arch/arm/boot/dts/vf610.dtsi    |   26 ++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
> index c8047ca..8bf37d4 100644
> --- a/arch/arm/boot/dts/vf610-twr.dts
> +++ b/arch/arm/boot/dts/vf610-twr.dts
> @@ -34,6 +34,25 @@
>  		};
>  	};
>  
> +	regulators {
> +		compatible = "simple-bus";
> +
> +		reg_vcc_3v3_mcu: vcc_3v3_mcu_supply {

Please be aware of the patch below and use generic node name in
regulator@num form.

https://git.linaro.org/people/shawn.guo/linux-2.6.git/commitdiff/2e95ed8ec5911e71f6ccf6f4a1869e2501e5df73

Shawn

> +			compatible = "regulator-fixed";
> +			regulator-name = "vcc_3v3_mcu";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +		};
> +	};
> +
> +};
> +
> +&adc0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_adc0_ad5>;
> +	fsl,adc-io-pinctl = <0x20>;
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
