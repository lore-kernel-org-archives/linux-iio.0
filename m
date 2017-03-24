Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:36757 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751235AbdCXCNx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Mar 2017 22:13:53 -0400
Date: Thu, 23 Mar 2017 21:13:50 -0500
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
Subject: Re: [PATCH v2 1/6] dt-bindings: iio: rockchip-saradc: add support
 for rk3328
Message-ID: <20170324021350.ije6w42ihlpdvi2c@rob-hp-laptop>
References: <1489670244-13328-1-git-send-email-cl@rock-chips.com>
 <1489670244-13328-2-git-send-email-cl@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1489670244-13328-2-git-send-email-cl@rock-chips.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Mar 16, 2017 at 09:17:19PM +0800, cl@rock-chips.com wrote:
> From: Liang Chen <cl@rock-chips.com>
> 
> The rk3328 saradc is the same as rk3399.
> 
> Signed-off-by: Liang Chen <cl@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
