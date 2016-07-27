Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34035 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755976AbcG0OYx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Jul 2016 10:24:53 -0400
From: Caesar Wang <wxt@rock-chips.com>
To: jic23@kernel.org, heiko@sntech.de
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, dianders@chromium.org,
	linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
	john@metanate.com, linux@roeck-us.net,
	linux-arm-kernel@lists.infradead.org,
	Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v3 4/4] arm: dts: rockchip: add reset node for the exist saradc SoCs
Date: Wed, 27 Jul 2016 22:24:07 +0800
Message-Id: <1469629447-544-4-git-send-email-wxt@rock-chips.com>
In-Reply-To: <1469629447-544-1-git-send-email-wxt@rock-chips.com>
References: <1469629447-544-1-git-send-email-wxt@rock-chips.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

SARADC controller needs to be reset before programming it, otherwise
it will not function properly.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v3: None
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

