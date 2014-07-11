Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:16778 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbaGKJKp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jul 2014 05:10:45 -0400
From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-iio@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, cw00.choi@samsung.com,
	gregkh@linuxfoundation.org, naveenkrishna.ch@gmail.com,
	lars@metafoo.de, cpgs@samsung.com, grundler@chromium.org
Subject: [PATCH 4/4] ARM: dts: exynos: Add sysreg phandle to ADC node
Date: Fri, 11 Jul 2014 14:36:29 +0530
Message-id: <1405069589-10388-5-git-send-email-ch.naveen@samsung.com>
In-reply-to: <1405069589-10388-1-git-send-email-ch.naveen@samsung.com>
References: <1405069589-10388-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Instead of using the ADC_PHY register base address, use sysreg phandle
in ADC node to control ADC_PHY configuration register.

This patch adds syscon node for Exynos3250, Exynos4x12, Exynos5250,
and Exynos5420, Exynos5800.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-samsung-soc@vger.kernel.org
---
 arch/arm/boot/dts/exynos3250.dtsi |    3 ++-
 arch/arm/boot/dts/exynos4x12.dtsi |    3 ++-
 arch/arm/boot/dts/exynos5250.dtsi |    3 ++-
 arch/arm/boot/dts/exynos5420.dtsi |    3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index c5e15db..51c9b0d 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -262,12 +262,13 @@
 
 		adc: adc@126C0000 {
 			compatible = "samsung,exynos3250-adc-v2";
-			reg = <0x126C0000 0x100>, <0x10020718 0x4>;
+			reg = <0x126C0000 0x100>;
 			interrupts = <0 137 0>;
 			clock-names = "adc", "sclk_adc";
 			clocks = <&cmu CLK_TSADC>, <&cmu CLK_SCLK_TSADC>;
 			#io-channel-cells = <1>;
 			io-channel-ranges;
+			samsung,syscon-phandle = <&pmu_system_controller>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index c5a943d..9a18d9b 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -114,13 +114,14 @@
 
 	adc: adc@126C0000 {
 		compatible = "samsung,exynos-adc-v1";
-		reg = <0x126C0000 0x100>, <0x10020718 0x4>;
+		reg = <0x126C0000 0x100>;
 		interrupt-parent = <&combiner>;
 		interrupts = <10 3>;
 		clocks = <&clock CLK_TSADC>;
 		clock-names = "adc";
 		#io-channel-cells = <1>;
 		io-channel-ranges;
+		samsung,syscon-phandle = <&pmu_system_controller>;
 		status = "disabled";
 	};
 
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 834fb5a..6003777 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -762,12 +762,13 @@
 
 	adc: adc@12D10000 {
 		compatible = "samsung,exynos-adc-v1";
-		reg = <0x12D10000 0x100>, <0x10040718 0x4>;
+		reg = <0x12D10000 0x100>
 		interrupts = <0 106 0>;
 		clocks = <&clock CLK_ADC>;
 		clock-names = "adc";
 		#io-channel-cells = <1>;
 		io-channel-ranges;
+		samsung,syscon-phandle = <&pmu_system_controller>;
 		status = "disabled";
 	};
 
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index e385322..6979da8 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -525,12 +525,13 @@
 
 	adc: adc@12D10000 {
 		compatible = "samsung,exynos-adc-v2";
-		reg = <0x12D10000 0x100>, <0x10040720 0x4>;
+		reg = <0x12D10000 0x100>;
 		interrupts = <0 106 0>;
 		clocks = <&clock CLK_TSADC>;
 		clock-names = "adc";
 		#io-channel-cells = <1>;
 		io-channel-ranges;
+		samsung,syscon-phandle = <&pmu_system_controller>;
 		status = "disabled";
 	};
 
-- 
1.7.9.5

