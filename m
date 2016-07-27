Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53898 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbcG0Ovq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Jul 2016 10:51:46 -0400
Subject: Re: [PATCH v3 3/4] arm64: dts: rockchip: add reset saradc node for
 rk3368 SoCs
To: Caesar Wang <wxt@rock-chips.com>, jic23@kernel.org, heiko@sntech.de
References: <1469629447-544-1-git-send-email-wxt@rock-chips.com>
 <1469629447-544-3-git-send-email-wxt@rock-chips.com>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, dianders@chromium.org,
	linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
	john@metanate.com, linux-arm-kernel@lists.infradead.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5798CA75.3010202@roeck-us.net>
Date: Wed, 27 Jul 2016 07:51:33 -0700
MIME-Version: 1.0
In-Reply-To: <1469629447-544-3-git-send-email-wxt@rock-chips.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/27/2016 07:24 AM, Caesar Wang wrote:
> SARADC controller needs to be reset before programming it, otherwise
> it will not function properly.
>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>
> Changes in v3:
> - add Doug's reviewed tag.
>
Not to this patch ?

> Changes in v2: None
>
>   arch/arm64/boot/dts/rockchip/rk3368.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> index d02a9003..4f44d11 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> @@ -270,6 +270,8 @@
>   		#io-channel-cells = <1>;
>   		clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
>   		clock-names = "saradc", "apb_pclk";
> +		resets = <&cru SRST_SARADC>;
> +		reset-names = "saradc-apb";
>   		status = "disabled";
>   	};
>
>

