Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33462 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933053AbdCXCPR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Mar 2017 22:15:17 -0400
Date: Thu, 23 Mar 2017 21:15:10 -0500
From: Rob Herring <robh@kernel.org>
To: cl@rock-chips.com
Cc: heiko@sntech.de, mark.rutland@arm.com, zhengxing@rock-chips.com,
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
Subject: Re: [PATCH v2 6/6] dt-bindings: document rockchip rk3328-evb board
Message-ID: <20170324021510.obhfykuxlhyznozv@rob-hp-laptop>
References: <1489670244-13328-1-git-send-email-cl@rock-chips.com>
 <1489670586-16120-1-git-send-email-cl@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1489670586-16120-1-git-send-email-cl@rock-chips.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Mar 16, 2017 at 09:23:06PM +0800, cl@rock-chips.com wrote:
> From: Liang Chen <cl@rock-chips.com>
> 
> Use "rockchip,rk3328-evb" compatible string for Rockchip RK3328
> evaluation board.
> 
> Signed-off-by: Liang Chen <cl@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.txt | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
