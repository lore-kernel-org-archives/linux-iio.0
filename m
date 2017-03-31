Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:33295 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754747AbdCaI2K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Mar 2017 04:28:10 -0400
Subject: Re: [PATCH v4 4/6] arm64: dts: rockchip: add core dtsi file for
 RK3328 SoCs
To: cl@rock-chips.com
References: <1490607650-18650-1-git-send-email-cl@rock-chips.com>
 <1490607650-18650-4-git-send-email-cl@rock-chips.com>
Cc: heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com,
        zhengxing@rock-chips.com, andy.yan@rock-chips.com,
        jay.xu@rock-chips.com, matthias.bgg@gmail.com,
        paweljarosz3691@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsa@the-dreams.de, linux-i2c@vger.kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        wxt@rock-chips.com, david.wu@rock-chips.com,
        linux-iio@vger.kernel.org, akpm@linux-foundation.org,
        dianders@chromium.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, will.deacon@arm.com, afaerber@suse.de,
        shawnguo@kernel.org, khilman@baylibre.com, arnd@arndb.de,
        fabio.estevam@nxp.com, zhangqing@rock-chips.com,
        kever.yang@rock-chips.com, tony.xie@rock-chips.com,
        huangtao@rock-chips.com, yhx@rock-chips.com,
        rocky.hao@rock-chips.com
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <2def4338-fe73-c0a7-62bc-d770bee22569@rock-chips.com>
Date: Fri, 31 Mar 2017 16:27:59 +0800
MIME-Version: 1.0
In-Reply-To: <1490607650-18650-4-git-send-email-cl@rock-chips.com>
Content-Type: text/plain; charset=gbk; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Liang,

On 2017/3/27 17:40, cl@rock-chips.com wrote:
> From: Liang Chen <cl@rock-chips.com>
>
> This patch adds core dtsi file for Rockchip RK3328 SoCs.
>
> Signed-off-by: Liang Chen <cl@rock-chips.com>
> ---

----8<------

> +
> +		sdmmc1 {
> +			sdmmc1_clk: sdmmc1-clk {
> +				rockchip,pins =
> +					<1 RK_PB4 1 &pcfg_pull_none_8ma>;
> +			};
> +
> +			sdmmc1_cmd: sdmmc1-cmd {
> +				rockchip,pins = <1 RK_PB5 1 &pcfg_pull_up_8ma>;
> +			};
> +
> +			sdmmc1_pwren: sdmmc1-pwren {
> +				rockchip,pins = <1 RK_PC2 1 &pcfg_pull_up_8ma>;
> +			};
> +
> +			sdmmc1_wrprt: sdmmc1-wrprt {
> +				rockchip,pins = <1 RK_PC4 1 &pcfg_pull_up_8ma>;
> +			};
> +
> +			sdmmc1_dectn: sdmmc1-dectn {
> +				rockchip,pins = <1 RK_PC3 1 &pcfg_pull_up_8ma>;
> +			};
> +
> +			sdmmc1_bus1: sdmmc1-bus1 {
> +				rockchip,pins = <1 RK_PB6 1 &pcfg_pull_up_8ma>;
> +			};
> +
> +			sdmmc1_bus4: sdmmc1-bus4 {
> +				rockchip,pins = <1 RK_PB4 1 &pcfg_pull_up_8ma>,
> +						<1 RK_PB5 1 &pcfg_pull_up_8ma>,


I'm pretty sure this isn't correct as sdmmc1_bus1 even doesn't contain
one same pinctrl(data0) as sdmmc1_bus4. So, the first two pins should be
"1 RK_PB6" and "1 RK_PB7".....


> +						<1 RK_PC0 1 &pcfg_pull_up_8ma>,
> +						<1 RK_PC1 1 &pcfg_pull_up_8ma>;
> +			};
> +
> +			sdmmc1_gpio: sdmmc1-gpio {
> +				rockchip,pins =
> +					<1 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
> +					<1 RK_PB5 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
> +					<1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
> +					<1 RK_PB7 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
> +					<1 RK_PC0 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
> +					<1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
> +					<1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
> +					<1 RK_PC3 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
> +					<1 RK_PC4 RK_FUNC_GPIO &pcfg_pull_up_4ma>;
> +			};
> +		};
> +
> +		emmc {
> +			emmc_clk: emmc-clk {
> +				rockchip,pins =
> +					<3 RK_PC5 2 &pcfg_pull_none_12ma>;
> +			};
> +
> +			emmc_cmd: emmc-cmd {
> +				rockchip,pins =
> +					<3 RK_PC3 2 &pcfg_pull_up_12ma>;
> +			};
> +
> +			emmc_pwren: emmc-pwren {
> +				rockchip,pins = <3 RK_PC6 2 &pcfg_pull_none>;
> +			};
> +
> +			emmc_rstnout: emmc-rstnout {
> +				rockchip,pins = <3 RK_PC4 2 &pcfg_pull_none>;
> +			};
> +
> +			emmc_bus1: emmc-bus1 {
> +				rockchip,pins =
> +					<0 RK_PA7 2 &pcfg_pull_up_12ma>;
> +			};
> +
> +			emmc_bus4: emmc-bus4 {
> +				rockchip,pins =
> +					<0 RK_PA7 2 &pcfg_pull_up_12ma>,
> +					<2 RK_PD4 2 &pcfg_pull_up_12ma>,
> +					<2 RK_PD5 2 &pcfg_pull_up_12ma>,
> +					<2 RK_PD6 2 &pcfg_pull_up_12ma>;
> +			};
> +
> +			emmc_bus8: emmc-bus8 {
> +				rockchip,pins =
> +					<0 RK_PA7 2 &pcfg_pull_up_12ma>,
> +					<2 RK_PD4 2 &pcfg_pull_up_12ma>,
> +					<2 RK_PD5 2 &pcfg_pull_up_12ma>,
> +					<2 RK_PD6 2 &pcfg_pull_up_12ma>,
> +					<2 RK_PD7 2 &pcfg_pull_up_12ma>,
> +					<3 RK_PC0 2 &pcfg_pull_up_12ma>,
> +					<3 RK_PC1 2 &pcfg_pull_up_12ma>,
> +					<3 RK_PC2 2 &pcfg_pull_up_12ma>;
> +			};
> +		};
> +
> +		pwm0 {
> +			pwm0_pin: pwm0-pin {
> +				rockchip,pins = <2 RK_PA4 1 &pcfg_pull_none>;
> +			};
> +		};
> +
> +		pwm1 {
> +			pwm1_pin: pwm1-pin {
> +				rockchip,pins = <2 RK_PA5 1 &pcfg_pull_none>;
> +			};
> +		};
> +
> +		pwm2 {
> +			pwm2_pin: pwm2-pin {
> +				rockchip,pins = <2 RK_PA6 1 &pcfg_pull_none>;
> +			};
> +		};
> +
> +		pwmir {
> +			pwmir_pin: pwmir-pin {
> +				rockchip,pins = <2 RK_PA2 1 &pcfg_pull_none>;
> +			};
> +		};
> +
> +		gmac-1 {
> +			rgmiim1_pins: rgmiim1-pins {
> +				rockchip,pins =
> +					/* mac_txclk */
> +					<1 RK_PB4 2 &pcfg_pull_none_12ma>,
> +					/* mac_rxclk */
> +					<1 RK_PB5 2 &pcfg_pull_none_2ma>,
> +					/* mac_mdio */
> +					<1 RK_PC3 2 &pcfg_pull_none_2ma>,
> +					/* mac_txen */
> +					<1 RK_PD1 2 &pcfg_pull_none_12ma>,
> +					/* mac_clk */
> +					<1 RK_PC5 2 &pcfg_pull_none_2ma>,
> +					/* mac_rxdv */
> +					<1 RK_PC6 2 &pcfg_pull_none_2ma>,
> +					/* mac_mdc */
> +					<1 RK_PC7 2 &pcfg_pull_none_2ma>,
> +					/* mac_rxd1 */
> +					<1 RK_PB2 2 &pcfg_pull_none_2ma>,
> +					/* mac_rxd0 */
> +					<1 RK_PB3 2 &pcfg_pull_none_2ma>,
> +					/* mac_txd1 */
> +					<1 RK_PB0 2 &pcfg_pull_none_12ma>,
> +					/* mac_txd0 */
> +					<1 RK_PB1 2 &pcfg_pull_none_12ma>,
> +					/* mac_rxd3 */
> +					<1 RK_PB6 2 &pcfg_pull_none_2ma>,
> +					/* mac_rxd2 */
> +					<1 RK_PB7 2 &pcfg_pull_none_2ma>,
> +					/* mac_txd3 */
> +					<1 RK_PC0 2 &pcfg_pull_none_12ma>,
> +					/* mac_txd2 */
> +					<1 RK_PC1 2 &pcfg_pull_none_12ma>,
> +
> +					/* mac_txclk */
> +					<0 RK_PB0 1 &pcfg_pull_none>,
> +					/* mac_txen */
> +					<0 RK_PB4 1 &pcfg_pull_none>,
> +					/* mac_clk */
> +					<0 RK_PD0 1 &pcfg_pull_none>,
> +					/* mac_txd1 */
> +					<0 RK_PC0 1 &pcfg_pull_none>,
> +					/* mac_txd0 */
> +					<0 RK_PC1 1 &pcfg_pull_none>,
> +					/* mac_txd3 */
> +					<0 RK_PC7 1 &pcfg_pull_none>,
> +					/* mac_txd2 */
> +					<0 RK_PC6 1 &pcfg_pull_none>;
> +			};
> +
> +			rmiim1_pins: rmiim1-pins {
> +				rockchip,pins =
> +					/* mac_mdio */
> +					<1 RK_PC3 2 &pcfg_pull_none_2ma>,
> +					/* mac_txen */
> +					<1 RK_PD1 2 &pcfg_pull_none_12ma>,
> +					/* mac_clk */
> +					<1 RK_PC5 2 &pcfg_pull_none_2ma>,
> +					/* mac_rxer */
> +					<1 RK_PD0 2 &pcfg_pull_none_2ma>,
> +					/* mac_rxdv */
> +					<1 RK_PC6 2 &pcfg_pull_none_2ma>,
> +					/* mac_mdc */
> +					<1 RK_PC7 2 &pcfg_pull_none_2ma>,
> +					/* mac_rxd1 */
> +					<1 RK_PB2 2 &pcfg_pull_none_2ma>,
> +					/* mac_rxd0 */
> +					<1 RK_PB3 2 &pcfg_pull_none_2ma>,
> +					/* mac_txd1 */
> +					<1 RK_PB0 2 &pcfg_pull_none_12ma>,
> +					/* mac_txd0 */
> +					<1 RK_PB1 2 &pcfg_pull_none_12ma>,
> +
> +					/* mac_mdio */
> +					<0 RK_PB3 1 &pcfg_pull_none>,
> +					/* mac_txen */
> +					<0 RK_PB4 1 &pcfg_pull_none>,
> +					/* mac_clk */
> +					<0 RK_PD0 1 &pcfg_pull_none>,
> +					/* mac_mdc */
> +					<0 RK_PC3 1 &pcfg_pull_none>,
> +					/* mac_txd1 */
> +					<0 RK_PC0 1 &pcfg_pull_none>,
> +					/* mac_txd0 */
> +					<0 RK_PC1 1 &pcfg_pull_none>;
> +			};
> +		};
> +
> +		gmac2phy {
> +			fephyled_speed100: fephyled-speed100 {
> +				rockchip,pins = <0 RK_PD7 1 &pcfg_pull_none>;
> +			};
> +
> +			fephyled_speed10: fephyled-speed10 {
> +				rockchip,pins = <0 RK_PD6 1 &pcfg_pull_none>;
> +			};
> +
> +			fephyled_duplex: fephyled-duplex {
> +				rockchip,pins = <0 RK_PD6 2 &pcfg_pull_none>;
> +			};
> +
> +			fephyled_rxm0: fephyled-rxm0 {
> +				rockchip,pins = <0 RK_PD5 1 &pcfg_pull_none>;
> +			};
> +
> +			fephyled_txm0: fephyled-txm0 {
> +				rockchip,pins = <0 RK_PD5 2 &pcfg_pull_none>;
> +			};
> +
> +			fephyled_linkm0: fephyled-linkm0 {
> +				rockchip,pins = <0 RK_PD4 1 &pcfg_pull_none>;
> +			};
> +
> +			fephyled_rxm1: fephyled-rxm1 {
> +				rockchip,pins = <2 RK_PD1 2 &pcfg_pull_none>;
> +			};
> +
> +			fephyled_txm1: fephyled-txm1 {
> +				rockchip,pins = <2 RK_PD1 3 &pcfg_pull_none>;
> +			};
> +
> +			fephyled_linkm1: fephyled-linkm1 {
> +				rockchip,pins = <2 RK_PD0 2 &pcfg_pull_none>;
> +			};
> +		};
> +
> +		tsadc_pin {
> +			tsadc_int: tsadc-int {
> +				rockchip,pins = <2 RK_PB5 2 &pcfg_pull_none>;
> +			};
> +			tsadc_gpio: tsadc-gpio {
> +				rockchip,pins =
> +					<2 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
> +			};
> +		};
> +
> +		hdmi_pin {
> +			hdmi_cec: hdmi-cec {
> +				rockchip,pins = <0 RK_PA3 1 &pcfg_pull_none>;
> +			};
> +
> +			hdmi_hpd: hdmi-hpd {
> +				rockchip,pins = <0 RK_PA4 1 &pcfg_pull_down>;
> +			};
> +		};
> +
> +		cif-0 {
> +			dvp_d2d9_m0:dvp-d2d9-m0 {
> +				rockchip,pins =
> +					/* cif_d0 */
> +					<3 RK_PA4 2 &pcfg_pull_none>,
> +					/* cif_d1 */
> +					<3 RK_PA5 2 &pcfg_pull_none>,
> +					/* cif_d2 */
> +					<3 RK_PA6 2 &pcfg_pull_none>,
> +					/* cif_d3 */
> +					<3 RK_PA7 2 &pcfg_pull_none>,
> +					/* cif_d4 */
> +					<3 RK_PB0 2 &pcfg_pull_none>,
> +					/* cif_d5m0 */
> +					<3 RK_PB1 2 &pcfg_pull_none>,
> +					/* cif_d6m0 */
> +					<3 RK_PB2 2 &pcfg_pull_none>,
> +					/* cif_d7m0 */
> +					<3 RK_PB3 2 &pcfg_pull_none>,
> +					/* cif_href */
> +					<3 RK_PA1 2 &pcfg_pull_none>,
> +					/* cif_vsync */
> +					<3 RK_PA0 2 &pcfg_pull_none>,
> +					/* cif_clkoutm0 */
> +					<3 RK_PA3 2 &pcfg_pull_none>,
> +					/* cif_clkin */
> +					<3 RK_PA2 2 &pcfg_pull_none>;
> +			};
> +		};
> +
> +		cif-1 {
> +			dvp_d2d9_m1:dvp-d2d9-m1 {
> +				rockchip,pins =
> +					/* cif_d0 */
> +					<3 RK_PA4 2 &pcfg_pull_none>,
> +					/* cif_d1 */
> +					<3 RK_PA5 2 &pcfg_pull_none>,
> +					/* cif_d2 */
> +					<3 RK_PA6 2 &pcfg_pull_none>,
> +					/* cif_d3 */
> +					<3 RK_PA7 2 &pcfg_pull_none>,
> +					/* cif_d4 */
> +					<3 RK_PB0 2 &pcfg_pull_none>,
> +					/* cif_d5m1 */
> +					<2 RK_PC0 4 &pcfg_pull_none>,
> +					/* cif_d6m1 */
> +					<2 RK_PC1 4 &pcfg_pull_none>,
> +					/* cif_d7m1 */
> +					<2 RK_PC2 4 &pcfg_pull_none>,
> +					/* cif_href */
> +					<3 RK_PA1 2 &pcfg_pull_none>,
> +					/* cif_vsync */
> +					<3 RK_PA0 2 &pcfg_pull_none>,
> +					/* cif_clkoutm1 */
> +					<2 RK_PB7 4 &pcfg_pull_none>,
> +					/* cif_clkin */
> +					<3 RK_PA2 2 &pcfg_pull_none>;
> +			};
> +		};
> +	};
> +};
>

