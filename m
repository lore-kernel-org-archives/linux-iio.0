Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:59462 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751702AbdCPIDK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 16 Mar 2017 04:03:10 -0400
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
Subject: Re: [PATCH v1 1/7] include: dt-bindings: Add pin function index definition for rockchip pinctrl
Date: Thu, 16 Mar 2017 09:02:47 +0100
Message-ID: <3841077.a8qRkotiEM@diego>
In-Reply-To: <1489572237-6649-2-git-send-email-cl@rock-chips.com>
References: <1489572237-6649-1-git-send-email-cl@rock-chips.com> <1489572237-6649-2-git-send-email-cl@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

Am Mittwoch, 15. März 2017, 18:03:51 CET schrieb cl@rock-chips.com:
> From: Chen Liang <cl@rock-chips.com>
> 
> The rk3328 soc need more pin function index for pinctrl.
> 
> Signed-off-by: Chen Liang <cl@rock-chips.com>
> ---
>  include/dt-bindings/pinctrl/rockchip.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/dt-bindings/pinctrl/rockchip.h
> b/include/dt-bindings/pinctrl/rockchip.h index aaec8ba..bc2b6af 100644
> --- a/include/dt-bindings/pinctrl/rockchip.h
> +++ b/include/dt-bindings/pinctrl/rockchip.h
> @@ -63,5 +63,8 @@
>  #define RK_FUNC_2	2
>  #define RK_FUNC_3	3
>  #define RK_FUNC_4	4
> +#define RK_FUNC_5	5
> +#define RK_FUNC_6	6
> +#define RK_FUNC_7	7

please don't amend that function list anymore.

Only RK_FUNC_GPIO serves a real purpose but having constants FUNC_7 mapping 
simply to 7 does not help understand things better, so it's way easier to just 
have "7" as function in pinctrl entries in the devicetree.

That list is mainly a remnant to keep compatibility with old devicetrees and I 
guess I should add a deprecated notice at some point :-) .


Heiko
