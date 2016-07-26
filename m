Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:32923 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbcGZMNj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jul 2016 08:13:39 -0400
From: Caesar Wang <wxt@rock-chips.com>
To: jic23@kernel.org, heiko@sntech.de
Cc: devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	john@metanate.com, dianders@chromium.org, linux@roeck-us.net,
	Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v2 4/4] arm: dts: rockchip: add reset node for the exist saradc SoCs
Date: Tue, 26 Jul 2016 20:13:15 +0800
Message-Id: <1469535195-5227-4-git-send-email-wxt@rock-chips.com>
In-Reply-To: <1469535195-5227-1-git-send-email-wxt@rock-chips.com>
References: <1469535195-5227-1-git-send-email-wxt@rock-chips.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

SARADC controller needs to be reset before programming it, otherwise
it will not function properly.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v2: None

 arch/arm/boot/dts/rk3066a.dtsi | 2 ++
 arch/arm/boot/dts/rk3288.dtsi  | 2 ++
 arch/arm/boot/dts/rk3xxx.dtsi  | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index c0ba86c..0d0dae3 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -197,6 +197,8 @@
 		clock-names = "saradc", "apb_pclk";
 		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 		#io-channel-cells = <1>;
+		resets = <&cru SRST_SARADC>;
+		reset-names = "saradc-apb";
 		status = "disabled";
 	};
 
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index cd33f01..91c4b3c 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -279,6 +279,8 @@
 		#io-channel-cells = <1>;
 		clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
 		clock-names = "saradc", "apb_pclk";
+		resets = <&cru SRST_SARADC>;
+		reset-names = "saradc-apb";
 		status = "disabled";
 	};
 
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 99bbcc2..e2cd683 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -399,6 +399,8 @@
 		#io-channel-cells = <1>;
 		clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
 		clock-names = "saradc", "apb_pclk";
+		resets = <&cru SRST_SARADC>;
+		reset-names = "saradc-apb";
 		status = "disabled";
 	};
 
-- 
1.9.1

