Return-Path: <SRS0=3aYw=ZD=suse.de=afaerber@kernel.org>
Subject: Re: [PATCH v3 4/4] ARM64: dts: meson: meson-gx: add the SAR ADC
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 robh+dt@kernel.org, mark.rutland@arm.com, khilman@baylibre.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
References: <20170115224221.15510-1-martin.blumenstingl@googlemail.com>
 <20170119145822.26239-1-martin.blumenstingl@googlemail.com>
 <20170119145822.26239-5-martin.blumenstingl@googlemail.com>
Cc: narmstrong@baylibre.com, catalin.marinas@arm.com,
 mturquette@baylibre.com, will.deacon@arm.com, carlo@caione.org,
 sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <a1c759fb-691c-50a7-f1c4-fd51ad27fa52@suse.de>
Date: Sat, 21 Jan 2017 14:28:48 +0100
MIME-Version: 1.0
In-Reply-To: <20170119145822.26239-5-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

Am 19.01.2017 um 15:58 schrieb Martin Blumenstingl:
> Add the SAR ADC to meson-gxbb.dtsi and meson-gxl.dtsi. GXBB provides a
> 10-bit ADC while GXL (and GXM, which uses the same ADC as GXL) provides
> a 12-bit ADC.
> Some boards use resistor ladder buttons connected through one of the ADC
> channels. On newer devices (GXL and GXM) some boards use pull-ups/downs
> to change the resistance (and thus the ADC value) on of the ADC channels

"on one of"?

> to indicate the board revision.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Tested-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi   |  8 ++++++++
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 10 ++++++++++
>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 10 ++++++++++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> index 99e6a8d5cb9e..55abfb74aab2 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> @@ -255,6 +255,14 @@
>  				status = "disabled";
>  			};
>  
> +			saradc: adc@8680 {
> +				compatible = "amlogic,meson-saradc";
> +				#io-channel-cells = <1>;

Personally I think it makes more sense to keep reg after compatible for
consistency (same in example) and any #... "output" properties last.

> +				status = "disabled";
> +				reg = <0x0 0x8680 0x0 0x34>;
> +				interrupts = <GIC_SPI 73 IRQ_TYPE_EDGE_RISING>;
> +			};
> +
>  			pwm_ef: pwm@86c0 {
>  				compatible = "amlogic,meson-gx-pwm", "amlogic,meson-gxbb-pwm";
>  				reg = <0x0 0x086c0 0x0 0x10>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> index 39a774ad83ce..04b3324bc132 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> @@ -490,6 +490,16 @@
>  	clocks = <&clkc CLKID_I2C>;
>  };
>  
> +&saradc {
> +	compatible = "amlogic,meson-gxbb-saradc", "amlogic,meson-saradc";
> +	clocks = <&xtal>,
> +		 <&clkc CLKID_SAR_ADC>,
> +		 <&clkc CLKID_SANA>,
> +		 <&clkc CLKID_SAR_ADC_CLK>,
> +		 <&clkc CLKID_SAR_ADC_SEL>;
> +	clock-names = "clkin", "core", "sana", "adc_clk", "adc_sel";
> +};
> +
>  &sd_emmc_a {
>  	clocks = <&clkc CLKID_SD_EMMC_A>,
>  		 <&xtal>,
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> index bdf2305a2e25..7c72dbcef1ba 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> @@ -340,6 +340,16 @@
>  	clocks = <&clkc CLKID_I2C>;
>  };
>  
> +&saradc {
> +	compatible = "amlogic,meson-gxl-saradc", "amlogic,meson-saradc";
> +	clocks = <&xtal>,
> +		 <&clkc CLKID_SAR_ADC>,
> +		 <&clkc CLKID_SANA>,
> +		 <&clkc CLKID_SAR_ADC_CLK>,
> +		 <&clkc CLKID_SAR_ADC_SEL>;
> +	clock-names = "clkin", "core", "sana", "adc_clk", "adc_sel";
> +};
> +
>  &sd_emmc_a {
>  	clocks = <&clkc CLKID_SD_EMMC_A>,
>  		 <&xtal>,

Anyway, saradc before sd_emmc_a looks fine,

Reviewed-by: Andreas Färber <afaerber@suse.de>

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
