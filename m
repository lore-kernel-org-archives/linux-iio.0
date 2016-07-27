Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:43763 "EHLO
	mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755217AbcG0KDZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Jul 2016 06:03:25 -0400
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
	<robh@kernel.org>, Zhiyong Tao <zhiyong.tao@mediatek.com>
Subject: [PATCH v6 3/3] arm: dts: mt2701: Add auxadc node.
Date: Wed, 27 Jul 2016 18:03:01 +0800
Message-ID: <1469613781-1296-4-git-send-email-zhiyong.tao@mediatek.com>
In-Reply-To: <1469613781-1296-1-git-send-email-zhiyong.tao@mediatek.com>
References: <1469613781-1296-1-git-send-email-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The commit adds auxadc nodes to the Mediatek MT2701 dtsi file.

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
---
This patch dependents on "Add clock support for Mediatek MT2701"[1].
Please accept this patch together with [1].
[1]http://lists.infradead.org/pipermail/linux-mediatek/2016-June/005969.html
---
 arch/arm/boot/dts/mt2701.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index 42d5a37..c0a2644 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -187,6 +187,15 @@
 		      <0 0x10216000 0 0x2000>;
 	};
 
+	auxadc: adc@11001000 {
+		compatible = "mediatek,mt2701-auxadc";
+		reg = <0 0x11001000 0 0x1000>;
+		clocks = <&pericfg CLK_PERI_AUXADC>;
+		clock-names = "main";
+		#io-channel-cells = <1>;
+		status = "disabled";
+	};
+
 	uart0: serial@11002000 {
 		compatible = "mediatek,mt2701-uart",
 			     "mediatek,mt6577-uart";
-- 
1.7.9.5

