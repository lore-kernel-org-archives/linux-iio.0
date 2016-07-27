Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53310 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142AbcG0OvP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Jul 2016 10:51:15 -0400
Subject: Re: [PATCH v3 2/4] arm64: dts: rockchip: add the saradc for rk3399
To: Caesar Wang <wxt@rock-chips.com>, jic23@kernel.org, heiko@sntech.de
References: <1469629447-544-1-git-send-email-wxt@rock-chips.com>
 <1469629447-544-2-git-send-email-wxt@rock-chips.com>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, dianders@chromium.org,
	linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
	john@metanate.com, linux-arm-kernel@lists.infradead.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5798CA4C.9030400@roeck-us.net>
Date: Wed, 27 Jul 2016 07:50:52 -0700
MIME-Version: 1.0
In-Reply-To: <1469629447-544-2-git-send-email-wxt@rock-chips.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/27/2016 07:24 AM, Caesar Wang wrote:
> This patch adds saradc needed information on rk3399 SoCs.
>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>
> Changes in v3: None
> Changes in v2: None
>
>   arch/arm64/boot/dts/rockchip/rk3399.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 4c84229..b81f84b 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -299,6 +299,18 @@
>   		};
>   	};
>
> +	saradc: saradc@ff100000 {
> +		compatible = "rockchip,rk3399-saradc";
> +		reg = <0x0 0xff100000 0x0 0x100>;
> +		interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> +		#io-channel-cells = <1>;
> +		clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
> +		clock-names = "saradc", "apb_pclk";
> +		resets = <&cru SRST_P_SARADC>;
> +		reset-names = "saradc-apb";
> +		status = "disabled";
> +	};
> +
>   	i2c1: i2c@ff110000 {
>   		compatible = "rockchip,rk3399-i2c";
>   		reg = <0x0 0xff110000 0x0 0x1000>;
>

