Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.132]:45003 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752382AbdC0Jkp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Mar 2017 05:40:45 -0400
From: <cl@rock-chips.com>
To: heiko@sntech.de
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
        yhx@rock-chips.com, rocky.hao@rock-chips.com,
        Liang Chen <cl@rock-chips.com>
Subject: [PATCH v4 3/6] dt-bindings: soc: rockchip: grf: add support for rk3328
Date: Mon, 27 Mar 2017 17:40:47 +0800
Message-Id: <1490607650-18650-3-git-send-email-cl@rock-chips.com>
In-Reply-To: <1490607650-18650-1-git-send-email-cl@rock-chips.com>
References: <1490607650-18650-1-git-send-email-cl@rock-chips.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Liang Chen <cl@rock-chips.com>

Signed-off-by: Liang Chen <cl@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.txt b/Documentation/devicetree/bindings/soc/rockchip/grf.txt
index a0685c2..de8b983 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.txt
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.txt
@@ -16,6 +16,7 @@ Required Properties:
    - "rockchip,rk3188-grf", "syscon": for rk3188
    - "rockchip,rk3228-grf", "syscon": for rk3228
    - "rockchip,rk3288-grf", "syscon": for rk3288
+   - "rockchip,rk3328-grf", "syscon": for rk3328
    - "rockchip,rk3368-grf", "syscon": for rk3368
    - "rockchip,rk3399-grf", "syscon": for rk3399
 - compatible: PMUGRF should be one of the following:
-- 
1.9.1


