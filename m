Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934813AbdCVSJy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Mar 2017 14:09:54 -0400
Subject: Re: [PATCH v2 4/6] arm64: dts: rockchip: add core dtsi file for
 RK3328 SoCs
To: cl@rock-chips.com, heiko@sntech.de
References: <1489670244-13328-1-git-send-email-cl@rock-chips.com>
 <1489670244-13328-5-git-send-email-cl@rock-chips.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, mark.rutland@arm.com,
        wsa@the-dreams.de, linux-iio@vger.kernel.org,
        catalin.marinas@arm.com, shawn.lin@rock-chips.com,
        will.deacon@arm.com, kever.yang@rock-chips.com,
        dianders@chromium.org, yamada.masahiro@socionext.com,
        tony.xie@rock-chips.com, linux-i2c@vger.kernel.org,
        pmeerw@pmeerw.net, lars@metafoo.de, zhengxing@rock-chips.com,
        khilman@baylibre.com, linux-rockchip@lists.infradead.org,
        jay.xu@rock-chips.com, wxt@rock-chips.com, huangtao@rock-chips.com,
        devicetree@vger.kernel.org, zhangqing@rock-chips.com,
        paweljarosz3691@gmail.com, arnd@arndb.de, yhx@rock-chips.com,
        knaack.h@gmx.de, robh+dt@kernel.org, matthias.bgg@gmail.com,
        rocky.hao@rock-chips.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, david.wu@rock-chips.com,
        fabio.estevam@nxp.com, andy.yan@rock-chips.com,
        akpm@linux-foundation.org, shawnguo@kernel.org, afaerber@suse.de,
        jic23@kernel.org
From: Sudeep Holla <sudeep.holla@arm.com>
Message-ID: <7240249b-690a-5800-0b46-fb93a49e2af1@arm.com>
Date: Wed, 22 Mar 2017 18:09:42 +0000
MIME-Version: 1.0
In-Reply-To: <1489670244-13328-5-git-send-email-cl@rock-chips.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 16/03/17 13:17, cl@rock-chips.com wrote:
> From: Liang Chen <cl@rock-chips.com>
> 
> This patch adds core dtsi file for Rockchip RK3328 SoCs.
> 
> Signed-off-by: Liang Chen <cl@rock-chips.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi | 1362 ++++++++++++++++++++++++++++++
>  1 file changed, 1362 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3328.dtsi
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> new file mode 100644
> index 0000000..a92955c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi

[...]

> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +			clocks = <&cru ARMCLK>;

Why "clocks" property is present only for cpu0 ?

-- 
Regards,
Sudeep
