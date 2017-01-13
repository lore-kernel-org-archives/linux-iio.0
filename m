Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36390 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750958AbdAMTgN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Jan 2017 14:36:13 -0500
Received: by mail-wm0-f66.google.com with SMTP id r126so13925355wmr.3
        for <linux-iio@vger.kernel.org>; Fri, 13 Jan 2017 11:36:12 -0800 (PST)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: RE: [PATCH 4/4] ARM64: dts: meson: meson-gx: add the SAR ADC
To: martin.blumenstingl@googlemail.com
Cc: Neil Armstrong <narmstrong@baylibre.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>, linux-iio@vger.kernel.org
Message-ID: <2c7996a6-9c55-4cee-75a1-01be8732c42a@gmail.com>
Date: Fri, 13 Jan 2017 20:32:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Sorry, I'm not subscribed to the two mailing lists, therefore my reply
is outside the thread.

I'm currently experimenting with an own rudimentary driver for SAR ADC
on a Odroid C2 (S905GXBB). So I have some remarks based on my experience.

Rgds, Heiner

> Add the SAR ADC to meson-gxbb.dtsi and meson-gxl.dtsi. GXBB provides a
> 10-bit ADC while GXL (and GXM, which uses the same ADC as GXL) provides
> a 12-bit ADC.
> Some boards use resistor ladder buttons connected through one of the ADC
> channels. On newer devices (GXL and GXM) some boards use pull-ups/downs
> to change the resistance (and thus the ADC value) on of the ADC channels
> to indicate the board revision.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@xxxxxxxxxxxxxx>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi   |  8 ++++++++
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 10 ++++++++++
>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 10 ++++++++++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> index cddad8c795ec..ed3bf29eb76a 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> @@ -237,6 +237,14 @@
>  				status = "disabled";
>  			};
>  
> +			saradc: adc@8680 {
> +				compatible = "amlogic,meson-saradc";
> +				#io-channel-cells = <1>;
> +				status = "disabled";
> +				reg = <0x0 0x8680 0x0 0x34>;
> +				interrupts = <GIC_SPI 9 IRQ_TYPE_EDGE_RISING>;
IRQ 9 dosn't work for me, where does this number come from?
With IRQ 73 interrupt mode is working fine here.
Of course I can't speak for all other Meson variants.

> +			};
> +
>  			pwm_ef: pwm@86c0 {
>  				compatible = "amlogic,meson-gx-pwm", "amlogic,meson-gxbb-pwm";
>  				reg = <0x0 0x086c0 0x0 0x10>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> index 5d686334f692..114d7e1c9fc0 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> @@ -429,6 +429,16 @@
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
> index bb2842f8a08f..6b63296b6c60 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> @@ -273,6 +273,16 @@
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
> 

