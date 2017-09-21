Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:14359 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751000AbdIUB1F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Sep 2017 21:27:05 -0400
From: Zhiyong Tao <zhiyong.tao@mediatek.com>
To: <robh+dt@kernel.org>, <jic23@kernel.org>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
CC: <srv_heupstream@mediatek.com>, <liguo.zhang@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <sean.wang@mediatek.com>,
        <yt.shen@mediatek.com>, <matthias.bgg@gmail.com>,
        <s.hauer@pengutronix.de>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
Subject: [PATCH 3/3] arm64: dts: mt2712: Add auxadc device node.
Date: Thu, 21 Sep 2017 09:26:52 +0800
Message-ID: <1505957212-13402-4-git-send-email-zhiyong.tao@mediatek.com>
In-Reply-To: <1505957212-13402-1-git-send-email-zhiyong.tao@mediatek.com>
References: <1505957212-13402-1-git-send-email-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add auxadc device node for MT2712.

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
---
This patch dependents on "Mediatek MT2712 clock and scpsys support"[1].
Please accept this patch together with [1].
[1]http://lists.infradead.org/pipermail/linux-mediatek/2017-September/010461.html
---
 arch/arm64/boot/dts/mediatek/mt2712-evb.dts |    4 ++++
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi   |    9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
index 14163b9..76cbf4a 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
@@ -28,6 +28,10 @@
 	};
 };
 
+&auxadc {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index 3232e4e..bf65c92 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -225,6 +225,15 @@
 			 (GIC_CPU_MASK_RAW(0x13) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	auxadc: adc@11001000 {
+		compatible = "mediatek,mt2712-auxadc";
+		reg = <0 0x11001000 0 0x1000>;
+		clocks = <&pericfg CLK_PERI_AUXADC>;
+		clock-names = "main";
+		#io-channel-cells = <1>;
+		status = "disabled";
+	};
+
 	uart0: serial@11002000 {
 		compatible = "mediatek,mt2712-uart",
 			     "mediatek,mt6577-uart";
-- 
1.7.9.5

