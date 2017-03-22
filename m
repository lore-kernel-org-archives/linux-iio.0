Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:38670 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759033AbdCVLHK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Mar 2017 07:07:10 -0400
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: cl@rock-chips.com, robh+dt@kernel.org, mark.rutland@arm.com,
        zhengxing@rock-chips.com, andy.yan@rock-chips.com,
        jay.xu@rock-chips.com, matthias.bgg@gmail.com,
        paweljarosz3691@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsa@the-dreams.de, linux-i2c@vger.kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        wxt@rock-chips.com, david.wu@rock-chips.com,
        linux-iio@vger.kernel.org, shawn.lin@rock-chips.com,
        akpm@linux-foundation.org, dianders@chromium.org,
        yamada.masahiro@socionext.com, catalin.marinas@arm.com,
        will.deacon@arm.com, afaerber@suse.de, shawnguo@kernel.org,
        khilman@baylibre.com, arnd@arndb.de, fabio.estevam@nxp.com,
        kever.yang@rock-chips.com, tony.xie@rock-chips.com,
        huangtao@rock-chips.com, yhx@rock-chips.com,
        rocky.hao@rock-chips.com
Subject: Re: [PATCH v2 4/6] arm64: dts: rockchip: add core dtsi file for RK3328 SoCs
Date: Wed, 22 Mar 2017 12:06:46 +0100
Message-ID: <1536448.abPucmTQ1N@diego>
In-Reply-To: <58D250BC.4040609@rock-chips.com>
References: <1489670244-13328-1-git-send-email-cl@rock-chips.com> <14610453.rKm3MBREMz@diego> <58D250BC.4040609@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am Mittwoch, 22. März 2017, 18:23:56 CET schrieb Elaine Zhang:
> On 03/21/2017 04:55 PM, Heiko Stübner wrote:
> > Am Donnerstag, 16. März 2017, 21:17:22 CET schrieb cl@rock-chips.com:
> >> +	cru: clock-controller@ff440000 {
> >> +		compatible = "rockchip,rk3328-cru", "rockchip,cru", "syscon";
> >> +		reg = <0x0 0xff440000 0x0 0x1000>;
> >> +		rockchip,grf = <&grf>;
> >> +		#clock-cells = <1>;
> >> +		#reset-cells = <1>;
> >> +		assigned-clocks =
> >> +			<&cru DCLK_LCDC>, <&cru SCLK_PDM>,
> >> +			<&cru SCLK_RTC32K>, <&cru SCLK_UART0>,
> >> +			<&cru SCLK_UART1>, <&cru SCLK_UART2>,
> >> +			<&cru ACLK_BUS_PRE>, <&cru ACLK_PERI_PRE>,
> >> +			<&cru ACLK_VIO_PRE>, <&cru ACLK_RGA_PRE>,
> >> +			<&cru ACLK_VOP_PRE>, <&cru ACLK_RKVDEC_PRE>,
> >> +			<&cru ACLK_RKVENC>, <&cru ACLK_VPU_PRE>,
> >> +			<&cru SCLK_VDEC_CABAC>, <&cru SCLK_VDEC_CORE>,
> >> +			<&cru SCLK_VENC_CORE>, <&cru SCLK_VENC_DSP>,
> >> +			<&cru SCLK_SDIO>, <&cru SCLK_TSP>,
> >> +			<&cru SCLK_WIFI>, <&cru ARMCLK>,
> >> +			<&cru PLL_GPLL>, <&cru PLL_CPLL>,
> >> +			<&cru ACLK_BUS_PRE>, <&cru HCLK_BUS_PRE>,
> >> +			<&cru PCLK_BUS_PRE>, <&cru ACLK_PERI_PRE>,
> >> +			<&cru HCLK_PERI>, <&cru PCLK_PERI>,
> >> +			<&cru ACLK_VIO_PRE>, <&cru HCLK_VIO_PRE>,
> >> +			<&cru ACLK_RGA_PRE>, <&cru SCLK_RGA>,
> >> +			<&cru ACLK_VOP_PRE>, <&cru ACLK_RKVDEC_PRE>,
> >> +			<&cru ACLK_RKVENC>, <&cru ACLK_VPU_PRE>,
> >> +			<&cru SCLK_VDEC_CABAC>, <&cru SCLK_VDEC_CORE>,
> >> +			<&cru SCLK_VENC_CORE>, <&cru SCLK_VENC_DSP>,
> >> +			<&cru SCLK_EFUSE>, <&cru PCLK_DDR>,
> >> +			<&cru ACLK_GMAC>, <&cru PCLK_GMAC>,
> >> +			<&cru SCLK_RTC32K>, <&cru SCLK_USB3OTG_SUSPEND>;
> > 
> > that list is way to long.
> > Device-specific clocks should be inited in their respective device nodes.
> 
> Cpll init freq is 1200M, is too high. we need set cpll child clk div
> first,and then set cpll freq.
> After pll init, others clk init freq can inited in their device node.

thanks, that is a nice explanation. Please put it into a comment above the 
assigned-clocks property, so that we can keep that knowledge around for later 
times :-) .


Thanks
Heiko
