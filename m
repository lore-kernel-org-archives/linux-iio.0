Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:50488 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756175AbdCUI4R (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 21 Mar 2017 04:56:17 -0400
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: cl@rock-chips.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, zhengxing@rock-chips.com,
        andy.yan@rock-chips.com, jay.xu@rock-chips.com,
        matthias.bgg@gmail.com, paweljarosz3691@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsa@the-dreams.de, linux-i2c@vger.kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        wxt@rock-chips.com, david.wu@rock-chips.com,
        linux-iio@vger.kernel.org, shawn.lin@rock-chips.com,
        akpm@linux-foundation.org, dianders@chromium.org,
        yamada.masahiro@socionext.com, catalin.marinas@arm.com,
        will.deacon@arm.com, afaerber@suse.de, shawnguo@kernel.org,
        khilman@baylibre.com, arnd@arndb.de, fabio.estevam@nxp.com,
        zhangqing@rock-chips.com, kever.yang@rock-chips.com,
        tony.xie@rock-chips.com, huangtao@rock-chips.com,
        yhx@rock-chips.com, rocky.hao@rock-chips.com
Subject: Re: [PATCH v2 4/6] arm64: dts: rockchip: add core dtsi file for RK3328 SoCs
Date: Tue, 21 Mar 2017 09:55:56 +0100
Message-ID: <14610453.rKm3MBREMz@diego>
In-Reply-To: <1489670244-13328-5-git-send-email-cl@rock-chips.com>
References: <1489670244-13328-1-git-send-email-cl@rock-chips.com> <1489670244-13328-5-git-send-email-cl@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

Am Donnerstag, 16. März 2017, 21:17:22 CET schrieb cl@rock-chips.com:
> From: Liang Chen <cl@rock-chips.com>
> 
> This patch adds core dtsi file for Rockchip RK3328 SoCs.
> 
> Signed-off-by: Liang Chen <cl@rock-chips.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi | 1362
> ++++++++++++++++++++++++++++++ 1 file changed, 1362 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3328.dtsi
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3328.dtsi new file mode 100644
> index 0000000..a92955c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> @@ -0,0 +1,1362 @@
> +/*
> + * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This library is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This library is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#include <dt-bindings/clock/rk3328-cru.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/soc/rockchip,boot-mode.h>
> +#include <dt-bindings/power/rk3328-power.h>
> +
> +/ {
> +	compatible = "rockchip,rk3328";
> +
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
> +		i2c2 = &i2c2;
> +		i2c3 = &i2c3;
> +	};
> +
> +	cpus {
> +		#address-cells = <2>;

#address-cells = <1>? You most likely don't need the 2 field cpu regs?

> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +			clocks = <&cru ARMCLK>;
> +		};
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			reg = <0x0 0x1>;
> +			enable-method = "psci";
> +		};
> +		cpu2: cpu@2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			reg = <0x0 0x2>;
> +			enable-method = "psci";
> +		};
> +		cpu3: cpu@3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			reg = <0x0 0x3>;
> +			enable-method = "psci";
> +		};
> +	};

amba block here please

> +
> +	arm-pmu {
> +		compatible = "arm,cortex-a53-pmu";
> +		interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | 
IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +
> +	xin24m: xin24m {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <24000000>;
> +		clock-output-names = "xin24m";
> +	};
> +

[...]

> +	wdt: watchdog@ff1a0000 {
> +		compatible = "snps,dw-wdt";
> +		reg = <0x0 0xff1a0000 0x0 0x100>;
> +		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
> +		status = "disabled";
> +	};
> +
> +	amba {

amba block above arm-pmu please

> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		dmac: dmac@ff1f0000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x0 0xff1f0000 0x0 0x4000>;
> +			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cru ACLK_DMAC>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +		};
> +	};
> +
> +	saradc: saradc@ff280000 {
> +		compatible = "rockchip,rk3328-saradc", "rockchip,rk3399-saradc";
> +		reg = <0x0 0xff280000 0x0 0x100>;
> +		interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
> +		#io-channel-cells = <1>;
> +		clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
> +		clock-names = "saradc", "apb_pclk";
> +		resets = <&cru SRST_SARADC_P>;
> +		reset-names = "saradc-apb";
> +		status = "disabled";
> +	};
> +
> +	cru: clock-controller@ff440000 {
> +		compatible = "rockchip,rk3328-cru", "rockchip,cru", "syscon";
> +		reg = <0x0 0xff440000 0x0 0x1000>;
> +		rockchip,grf = <&grf>;
> +		#clock-cells = <1>;
> +		#reset-cells = <1>;
> +		assigned-clocks =
> +			<&cru DCLK_LCDC>, <&cru SCLK_PDM>,
> +			<&cru SCLK_RTC32K>, <&cru SCLK_UART0>,
> +			<&cru SCLK_UART1>, <&cru SCLK_UART2>,
> +			<&cru ACLK_BUS_PRE>, <&cru ACLK_PERI_PRE>,
> +			<&cru ACLK_VIO_PRE>, <&cru ACLK_RGA_PRE>,
> +			<&cru ACLK_VOP_PRE>, <&cru ACLK_RKVDEC_PRE>,
> +			<&cru ACLK_RKVENC>, <&cru ACLK_VPU_PRE>,
> +			<&cru SCLK_VDEC_CABAC>, <&cru SCLK_VDEC_CORE>,
> +			<&cru SCLK_VENC_CORE>, <&cru SCLK_VENC_DSP>,
> +			<&cru SCLK_SDIO>, <&cru SCLK_TSP>,
> +			<&cru SCLK_WIFI>, <&cru ARMCLK>,
> +			<&cru PLL_GPLL>, <&cru PLL_CPLL>,
> +			<&cru ACLK_BUS_PRE>, <&cru HCLK_BUS_PRE>,
> +			<&cru PCLK_BUS_PRE>, <&cru ACLK_PERI_PRE>,
> +			<&cru HCLK_PERI>, <&cru PCLK_PERI>,
> +			<&cru ACLK_VIO_PRE>, <&cru HCLK_VIO_PRE>,
> +			<&cru ACLK_RGA_PRE>, <&cru SCLK_RGA>,
> +			<&cru ACLK_VOP_PRE>, <&cru ACLK_RKVDEC_PRE>,
> +			<&cru ACLK_RKVENC>, <&cru ACLK_VPU_PRE>,
> +			<&cru SCLK_VDEC_CABAC>, <&cru SCLK_VDEC_CORE>,
> +			<&cru SCLK_VENC_CORE>, <&cru SCLK_VENC_DSP>,
> +			<&cru SCLK_EFUSE>, <&cru PCLK_DDR>,
> +			<&cru ACLK_GMAC>, <&cru PCLK_GMAC>,
> +			<&cru SCLK_RTC32K>, <&cru SCLK_USB3OTG_SUSPEND>;

that list is way to long.
Device-specific clocks should be inited in their respective device nodes.

Aka sdio clocks in the sdio controller node, video encoder/decoder in the 
encoder/decoder nodes, efuse, gmac etc etc.

Controllers for which you don't have bindings yet, also most likely won't need 
their clocks to get adjusted just now.

The cru assigned clocks are really only for system-wide shared clocks.

> +		assigned-clock-parents =
> +			<&cru HDMIPHY>, <&cru PLL_APLL>,
> +			<&cru PLL_GPLL>, <&xin24m>,
> +			<&xin24m>, <&xin24m>;
> +		assigned-clock-rates =
> +			<0>, <61440000>,
> +			<0>, <24000000>,
> +			<24000000>, <24000000>,
> +			<15000000>, <15000000>,
> +			<100000000>, <100000000>,
> +			<100000000>, <100000000>,
> +			<50000000>, <100000000>,
> +			<100000000>, <100000000>,
> +			<50000000>, <50000000>,
> +			<50000000>, <50000000>,
> +			<24000000>, <600000000>,
> +			<491520000>, <1200000000>,
> +			<150000000>, <75000000>,
> +			<75000000>, <150000000>,
> +			<75000000>, <75000000>,
> +			<300000000>, <100000000>,
> +			<300000000>, <200000000>,
> +			<400000000>, <500000000>,
> +			<200000000>, <300000000>,
> +			<300000000>, <250000000>,
> +			<200000000>, <100000000>,
> +			<24000000>, <100000000>,
> +			<150000000>, <50000000>,
> +			<32768>, <32768>;
> +	};
> +
> +	gmac2io: eth@ff540000 {

phandle should be gmac instead?
Node name, ethernet@ff540000

> +		compatible = "rockchip,rk3328-gmac";
> +		reg = <0x0 0xff540000 0x0 0x10000>;
> +		rockchip,grf = <&grf>;
> +		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "macirq";
> +		clocks = <&cru SCLK_MAC2IO>, <&cru SCLK_MAC2IO_RX>,
> +			 <&cru SCLK_MAC2IO_TX>, <&cru SCLK_MAC2IO_REF>,
> +			 <&cru SCLK_MAC2IO_REFOUT>, <&cru ACLK_MAC2IO>,
> +			 <&cru PCLK_MAC2IO>;
> +		clock-names = "stmmaceth", "mac_clk_rx",
> +			      "mac_clk_tx", "clk_mac_ref",
> +			      "clk_mac_refout", "aclk_mac",
> +			      "pclk_mac";
> +		resets = <&cru SRST_GMAC2IO_A>;
> +		reset-names = "stmmaceth";
> +		status = "disabled";
> +	};
> +
> +	gic: interrupt-controller@ff811000 {
> +		compatible = "arm,gic-400";
> +		#interrupt-cells = <3>;
> +		#address-cells = <0>;
> +		interrupt-controller;
> +		reg = <0x0 0xff811000 0 0x1000>,
> +		      <0x0 0xff812000 0 0x2000>,
> +		      <0x0 0xff814000 0 0x2000>,
> +		      <0x0 0xff816000 0 0x2000>;
> +		interrupts = <GIC_PPI 9
> +		      (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +	};
> +
> +	pinctrl: pinctrl {
> +		compatible = "rockchip,rk3328-pinctrl";
> +		rockchip,grf = <&grf>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		gpio0: gpio0@ff210000 {
> +			compatible = "rockchip,gpio-bank";
> +			reg = <0x0 0xff210000 0x0 0x100>;
> +			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cru PCLK_GPIO0>;
> +
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		gpio1: gpio1@ff220000 {
> +			compatible = "rockchip,gpio-bank";
> +			reg = <0x0 0xff220000 0x0 0x100>;
> +			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cru PCLK_GPIO1>;
> +
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		gpio2: gpio2@ff230000 {
> +			compatible = "rockchip,gpio-bank";
> +			reg = <0x0 0xff230000 0x0 0x100>;
> +			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cru PCLK_GPIO2>;
> +
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		gpio3: gpio3@ff240000 {
> +			compatible = "rockchip,gpio-bank";
> +			reg = <0x0 0xff240000 0x0 0x100>;
> +			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cru PCLK_GPIO3>;
> +
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		pcfg_pull_up: pcfg-pull-up {
> +			bias-pull-up;
> +		};
> +
> +		pcfg_pull_down: pcfg-pull-down {
> +			bias-pull-down;
> +		};
> +
> +		pcfg_pull_none: pcfg-pull-none {
> +			bias-disable;
> +		};
> +
> +		pcfg_pull_none_2ma: pcfg-pull-none-2ma {
> +			bias-disable;
> +			drive-strength = <2>;
> +		};
> +
> +		pcfg_pull_up_2ma: pcfg-pull-up-2ma {
> +			bias-pull-up;
> +			drive-strength = <2>;
> +		};
> +
> +		pcfg_pull_up_4ma: pcfg-pull-up-4ma {
> +			bias-pull-up;
> +			drive-strength = <4>;
> +		};
> +
> +		pcfg_pull_none_4ma: pcfg-pull-none-4ma {
> +			bias-disable;
> +			drive-strength = <4>;
> +		};
> +
> +		pcfg_pull_down_4ma: pcfg-pull-down-4ma {
> +			bias-pull-down;
> +			drive-strength = <4>;
> +		};
> +
> +		pcfg_pull_none_8ma: pcfg-pull-none-8ma {
> +			bias-disable;
> +			drive-strength = <8>;
> +		};
> +
> +		pcfg_pull_up_8ma: pcfg-pull-up-8ma {
> +			bias-pull-up;
> +			drive-strength = <8>;
> +		};
> +
> +		pcfg_pull_none_12ma: pcfg-pull-none-12ma {
> +			bias-disable;
> +			drive-strength = <12>;
> +		};
> +
> +		pcfg_pull_up_12ma: pcfg-pull-up-12ma {
> +			bias-pull-up;
> +			drive-strength = <12>;
> +		};
> +
> +		pcfg_output_high: pcfg-output-high {
> +			output-high;
> +		};
> +
> +		pcfg_output_low: pcfg-output-low {
> +			output-low;
> +		};
> +
> +		pcfg_input_high: pcfg-input-high {
> +			bias-pull-up;
> +			input-enable;
> +		};
> +
> +		pcfg_input: pcfg-input {
> +			input-enable;
> +		};
> +
> +		i2c0 {
> +			i2c0_xfer: i2c0-xfer {
> +				rockchip,pins =
> +					<2 RK_PD0 1 &pcfg_pull_none>,
> +					<2 RK_PD1 1 &pcfg_pull_none>;
> +			};
> +		};
> +
> +		i2c1 {
> +			i2c1_xfer: i2c1-xfer {
> +				rockchip,pins =
> +					<2 RK_PA4 2 &pcfg_pull_none>,
> +					<2 RK_PA5 2 &pcfg_pull_none>;
> +			};
> +		};
> +
> +		i2c2 {
> +			i2c2_xfer: i2c2-xfer {
> +				rockchip,pins =
> +					<2 RK_PB5 1 &pcfg_pull_none>,
> +					<2 RK_PB6 1 &pcfg_pull_none>;
> +			};
> +		};
> +
> +		i2c3 {
> +			i2c3_xfer: i2c3-xfer {
> +				rockchip,pins =
> +					<0 RK_PA5 2 &pcfg_pull_none>,
> +					<0 RK_PA6 2 &pcfg_pull_none>;
> +			};
> +			i2c3_gpio: i2c3-gpio {
> +				rockchip,pins =
> +					<0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>,
> +					<0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
> +			};
> +		};
> +
> +		hdmi_i2c {
> +			hdmii2c_xfer: hdmii2c-xfer {
> +				rockchip,pins =
> +					<0 RK_PA5 1 &pcfg_pull_none>,
> +					<0 RK_PA6 1 &pcfg_pull_none>;
> +			};
> +		};
> +
> +		tsadc {
> +			otp_gpio: otp-gpio {
> +				rockchip,pins =
> +					<2 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;

no need to line -break all these single-pin definitions, there are still enough 
characters below 80 left :-)

Same for all below

> +			};
> +
> +			otp_out: otp-out {
> +				rockchip,pins =
> +					<2 RK_PB5 1 &pcfg_pull_none>;
> +			};
> +		};
> +


Heiko
