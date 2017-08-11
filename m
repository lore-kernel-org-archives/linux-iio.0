Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.141]:42706 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751550AbdHKDrJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Aug 2017 23:47:09 -0400
From: Andy Yan <andy.yan@rock-chips.com>
To: heiko@sntech.de
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v3 10/13] ARM: dts: rockchip: add saradc support for rv1108
Date: Fri, 11 Aug 2017 11:46:51 +0800
Message-Id: <1502423211-31216-1-git-send-email-andy.yan@rock-chips.com>
In-Reply-To: <1502422578-30611-1-git-send-email-andy.yan@rock-chips.com>
References: <1502422578-30611-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add saradc device tree node for rv1108 soc

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v3: None
Changes in v2:
- add compatible string "rockchip,rv1108-saradc"

 arch/arm/boot/dts/rv1108.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 75a0b1e..92b6005 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -275,6 +275,18 @@
 		status = "disabled";
 	};
 
+	adc: adc@1038c000 {
+		compatible = "rockchip,rv1108-saradc", "rockchip,rk3399-saradc";
+		reg = <0x1038c000 0x100>;
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+		#io-channel-cells = <1>;
+		io-channel-ranges;
+		clock-frequency = <1000000>;
+		clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
+		clock-names = "saradc", "apb_pclk";
+		status = "disabled";
+	};
+
 	i2c0: i2c@20000000 {
 		compatible = "rockchip,rv1108-i2c";
 		reg = <0x20000000 0x1000>;
-- 
2.7.4


