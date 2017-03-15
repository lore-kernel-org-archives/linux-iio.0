Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.136]:42774 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753285AbdCOKDP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Mar 2017 06:03:15 -0400
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
        Chen Liang <cl@rock-chips.com>
Subject: [PATCH v1 3/7] dt-bindings: i2c: rk3x: add support for rk3328
Date: Wed, 15 Mar 2017 18:03:53 +0800
Message-Id: <1489572237-6649-4-git-send-email-cl@rock-chips.com>
In-Reply-To: <1489572237-6649-1-git-send-email-cl@rock-chips.com>
References: <1489572237-6649-1-git-send-email-cl@rock-chips.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Chen Liang <cl@rock-chips.com>

The rk3328 i2c is the same as rk3399

Signed-off-by: Chen Liang <cl@rock-chips.com>
---
 Documentation/devicetree/bindings/i2c/i2c-rk3x.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
index bbc5a1e..abfdefd 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
@@ -12,6 +12,7 @@ Required properties :
    - "rockchip,rk3228-i2c": for rk3228
    - "rockchip,rk3288-i2c": for rk3288
    - "rockchip,rk3399-i2c": for rk3399
+   - "rockchip,rk3328-i2c", "rockchip,rk3399-i2c": for rk3328
  - interrupts : interrupt number
  - clocks: See ../clock/clock-bindings.txt
    - For older hardware (rk3066, rk3188, rk3228, rk3288):
-- 
1.9.1


