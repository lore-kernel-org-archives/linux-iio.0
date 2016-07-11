Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:6184 "EHLO
	mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757464AbcGKDKI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Jul 2016 23:10:08 -0400
From: Zhiyong Tao <zhiyong.tao@mediatek.com>
To: <robh+dt@kernel.org>, <jic23@kernel.org>, <knaack.h@gmx.de>,
	<lars@metafoo.de>, <pmeerw@pmeerw.net>
CC: <srv_heupstream@mediatek.com>, <liguo.zhang@mediatek.com>,
	<yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
	<erin.lo@mediatek.com>, <dawei.chien@mediatek.com>,
	<matthias.bgg@gmail.com>, <s.hauer@pengutronix.de>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-iio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	Zhiyong Tao <zhiyong.tao@mediatek.com>
Subject: [PATCH v3 1/2] dt-bindings: auxadc: Add binding document for Mediatek auxadc.
Date: Mon, 11 Jul 2016 11:09:55 +0800
Message-ID: <1468206596-13792-2-git-send-email-zhiyong.tao@mediatek.com>
In-Reply-To: <1468206596-13792-1-git-send-email-zhiyong.tao@mediatek.com>
References: <1468206596-13792-1-git-send-email-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The commit adds the device tree binding documentation for the mediatek
auxadc found on Mediatek MT2701.
Thermal gets auxadc sample data by iio device.
So the commit changes auxadc device tree binding documentation from
/soc/mediatek/auxadc.txt to /iio/adc/mt65xx_auxadc.txt.

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
---
 .../devicetree/bindings/iio/adc/mt65xx_auxadc.txt  |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/mt65xx_auxadc.txt b/Documentation/devicetree/bindings/iio/adc/mt65xx_auxadc.txt
index 47fcd1b..bc23792 100644
--- a/Documentation/devicetree/bindings/iio/adc/mt65xx_auxadc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/mt65xx_auxadc.txt
@@ -14,11 +14,11 @@ Required properties:
   - reg: Address range of the AUXADC unit.
   - clocks: Should contain a clock specifier for each entry in clock-names
   - clock-names: Should contain "main".
-  - io-channel-cells: Should be 1, see ../iio-bindings.txt
+  - #io-channel-cells: Should be 1, see ../iio-bindings.txt
 
 Example:
 
-auxadc: auxadc@11001000 {
+auxadc: adc@11001000 {
 	compatible = "mediatek,mt2701-auxadc";
 	reg = <0 0x11001000 0 0x1000>;
 	clocks = <&pericfg CLK_PERI_AUXADC>;
-- 
1.7.9.5

