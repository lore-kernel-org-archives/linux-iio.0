Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:12691 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927AbaIPJDq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Sep 2014 05:03:46 -0400
From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-iio@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, cw00.choi@samsung.com,
	gregkh@linuxfoundation.org, naveenkrishna.ch@gmail.com,
	lars@metafoo.de, cpgs@samsung.com, grundler@chromium.org,
	jic23@kernel.org
Subject: [PATCH v2 3/3] ARM: dts: exynos: Add sysreg phandle to ADC node
Date: Tue, 16 Sep 2014 14:28:51 +0530
Message-id: <1410857931-4980-4-git-send-email-ch.naveen@samsung.com>
In-reply-to: <1410857931-4980-1-git-send-email-ch.naveen@samsung.com>
References: <1410857931-4980-1-git-send-email-ch.naveen@samsung.com>
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
index 1d52de6..b997a4c 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -272,12 +272,13 @@
 		adc: adc@126C0000 {
 			compatible = "samsung,exynos3250-adc",
 				     "samsung,exynos-adc-v2";
-			reg = <0x126C0000 0x100>, <0x10020718 0x4>;
+			reg = <0x126C0000 0x100>;
 			interrupts = <0 137 0>;
 			clock-names = "adc", "sclk";
 			clocks = <&cmu CLK_TSADC>, <&cmu CLK_SCLK_TSADC>;
 			#io-channel-cells = <1>;
 			io-channel-ranges;
+			samsung,syscon-phandle = <&pmu_system_controller>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 861bb91..9ee77d3 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -108,13 +108,14 @@
 
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
index 492e1ef..108adc5 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -765,12 +765,13 @@
 
 	adc: adc@12D10000 {
 		compatible = "samsung,exynos-adc-v1";
-		reg = <0x12D10000 0x100>, <0x10040718 0x4>;
+		reg = <0x12D10000 0x100>;
 		interrupts = <0 106 0>;
 		clocks = <&clock CLK_ADC>;
 		clock-names = "adc";
 		#io-channel-cells = <1>;
 		io-channel-ranges;
+		samsung,syscon-phandle = <&pmu_system_controller>;
 		status = "disabled";
 	};
 
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index bfe056d..5fd587a 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -541,12 +541,13 @@
 
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

