Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36060 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753455AbdCPQRL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 16 Mar 2017 12:17:11 -0400
Subject: Re: [PATCH v1 6/7] arm64: dts: rockchip: add dts file for RK3328
 evaluation board
To: cl@rock-chips.com, heiko@sntech.de
References: <1489572237-6649-1-git-send-email-cl@rock-chips.com>
 <1489628711-31271-1-git-send-email-cl@rock-chips.com>
Cc: mark.rutland@arm.com, wsa@the-dreams.de, linux-iio@vger.kernel.org,
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
From: Andre Przywara <andre.przywara@arm.com>
Message-ID: <63969127-3fcd-658c-2986-8ded6d93c433@arm.com>
Date: Thu, 16 Mar 2017 16:18:40 +0000
MIME-Version: 1.0
In-Reply-To: <1489628711-31271-1-git-send-email-cl@rock-chips.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Chen,

On 16/03/17 01:45, cl@rock-chips.com wrote:
> From: Chen Liang <cl@rock-chips.com>
> 
> This patch add rk3328-evb.dts for RK3328 evaluation board.
> Tested on RK3328 evb.
> 
> Signed-off-by: Chen Liang <cl@rock-chips.com>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile       |  1 +
>  arch/arm64/boot/dts/rockchip/rk3328-evb.dts | 57 +++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-evb.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 3a86289..853fc7d 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -4,6 +4,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-orion-r68-meta.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-px5-evb.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-r88.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-evb.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-evb.dtb
>  
>  always		:= $(dtb-y)
>  subdir-y	:= $(dts-dirs)
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
> new file mode 100644
> index 0000000..cf27239
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
> @@ -0,0 +1,57 @@
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
> +/dts-v1/;
> +#include "rk3328.dtsi"
> +
> +/ {
> +	model = "Rockchip RK3328 EVB";
> +	compatible = "rockchip,rk3328-evb", "rockchip,rk3328";
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";

Is that really 1.5MBit/s?

> +	};
> +};
> +
> +&uart2 {
> +	status = "okay";
> +};

I don't have the board, but would expect to see more peripherals
mentioned in the .dtsi enabled here.
For sure the board has an (micro)SD card slot, possibly even Ethernet?

Cheers,
Andre.
