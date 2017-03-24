Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.139]:36069 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752789AbdCXLCx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Mar 2017 07:02:53 -0400
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
Subject: [PATCH v3 6/6] dt-bindings: document rockchip rk3328-evb board
Date: Fri, 24 Mar 2017 19:04:20 +0800
Message-Id: <1490353460-25231-1-git-send-email-cl@rock-chips.com>
In-Reply-To: <1490353287-25122-1-git-send-email-cl@rock-chips.com>
References: <1490353287-25122-1-git-send-email-cl@rock-chips.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Liang Chen <cl@rock-chips.com>

Use "rockchip,rk3328-evb" compatible string for Rockchip RK3328
evaluation board.

Signed-off-by: Liang Chen <cl@rock-chips.com>
---
 Documentation/devicetree/bindings/arm/rockchip.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index cc4ace6..17611cd 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -141,3 +141,7 @@ Rockchip platforms device tree bindings
 - Tronsmart Orion R68 Meta
     Required root node properties:
       - compatible = "tronsmart,orion-r68-meta", "rockchip,rk3368";
+
+- Rockchip RK3328 evb:
+    Required root node properties:
+      - compatible = "rockchip,rk3328-evb", "rockchip,rk3328";
-- 
1.9.1


