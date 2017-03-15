Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:45152 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753626AbdCOLMk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 15 Mar 2017 07:12:40 -0400
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org
Cc: cl@rock-chips.com, mark.rutland@arm.com, wsa@the-dreams.de,
        linux-iio@vger.kernel.org, catalin.marinas@arm.com,
        shawn.lin@rock-chips.com, will.deacon@arm.com,
        kever.yang@rock-chips.com, dianders@chromium.org,
        yamada.masahiro@socionext.com, tony.xie@rock-chips.com,
        linux-i2c@vger.kernel.org, pmeerw@pmeerw.net, lars@metafoo.de,
        zhengxing@rock-chips.com, khilman@baylibre.com,
        jay.xu@rock-chips.com, wxt@rock-chips.com, huangtao@rock-chips.com,
        devicetree@vger.kernel.org, zhangqing@rock-chips.com,
        paweljarosz3691@gmail.com, arnd@arndb.de, yhx@rock-chips.com,
        knaack.h@gmx.de, robh+dt@kernel.org, matthias.bgg@gmail.com,
        rocky.hao@rock-chips.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, david.wu@rock-chips.com,
        fabio.estevam@nxp.com, andy.yan@rock-chips.com,
        akpm@linux-foundation.org, shawnguo@kernel.org, afaerber@suse.de,
        jic23@kernel.org
Subject: Re: [PATCH v1 0/7] initialize dtsi file and dts file for RK3328 SoCs
Date: Wed, 15 Mar 2017 12:11:54 +0100
Message-ID: <2592337.TJConaiLTi@diego>
In-Reply-To: <1489572237-6649-1-git-send-email-cl@rock-chips.com>
References: <1489572237-6649-1-git-send-email-cl@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Liang,

Am Mittwoch, 15. März 2017, 18:03:50 CET schrieb cl@rock-chips.com:
> From: Liang Chen <cl@rock-chips.com>
> 
> These patchs depend on pinctrl patchs as below:
> 
> https://patchwork.kernel.org/patch/9566427/
> https://patchwork.kernel.org/patch/9566425/
> https://patchwork.kernel.org/patch/9566431/
> 
> Chen Liang (7):
>   include: dt-bindings: Add pin function index definition for rockchip
>     pinctrl
>   dt-bindings: iio: rockchip-saradc: add support for rk3328
>   dt-bindings: i2c: rk3x: add support for rk3328
>   dt-bindings: soc: rockchip: grf: add support for rk3328

both my inbox as well as the linux-rockchip list did only get patches 1-4 it 
seems?

>   arm64: dts: rockchip: add core dtsi file for RK3328 SoCs
>   arm64: dts: rockchip: add dts file for RK3328 evaluation board
>   dt-bindings: document rockchip rk3328-evb board

So right now I'm missing these next 3. Did something go wrong when sending?


Heiko

