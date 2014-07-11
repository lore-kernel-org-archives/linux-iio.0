Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:27452 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242AbaGKJKm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jul 2014 05:10:42 -0400
From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-iio@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, cw00.choi@samsung.com,
	gregkh@linuxfoundation.org, naveenkrishna.ch@gmail.com,
	lars@metafoo.de, cpgs@samsung.com, grundler@chromium.org
Subject: [PATCH 3/4] Documentation: dt-bindings: update exynos-adc.txt with
 syscon handle
Date: Fri, 11 Jul 2014 14:36:28 +0530
Message-id: <1405069589-10388-4-git-send-email-ch.naveen@samsung.com>
In-reply-to: <1405069589-10388-1-git-send-email-ch.naveen@samsung.com>
References: <1405069589-10388-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch updates the DT bindings in exynos-adc.txt with the
syscon phandle to the ADC nodes.

Also removes the 2nd "reg" property, which used to carry the
ADC_PHY regiser base from PMU.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: devicetree@vger.kernel.org
---
 .../devicetree/bindings/iio/adc/exynos-adc.txt     |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/exynos-adc.txt b/Documentation/devicetree/bindings/iio/adc/exynos-adc.txt
index b87749a..808bbfa 100644
--- a/Documentation/devicetree/bindings/iio/adc/exynos-adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/exynos-adc.txt
@@ -1,10 +1,11 @@
 Samsung Exynos Analog to Digital Converter bindings
 
 The devicetree bindings are for the new ADC driver written for
-Exynos4 and upward SoCs from Samsung.
+Exynos4 and Exynos5 series SoCs from Samsung.
+Now supports Exynos3250 too.
 
 New driver handles the following
-1. Supports ADC IF found on EXYNOS4412/EXYNOS5250
+1. Supports ADC IF found on Exynos3250/EXYNOS4412/EXYNOS5 series
    and future SoCs from Samsung
 2. Add ADC driver under iio/adc framework
 3. Also adds the Documentation for device tree bindings
@@ -18,7 +19,7 @@ Required properties:
 				for controllers compatible with ADC of
 				Exynos3250.
 - reg:			Contains ADC register address range (base address and
-			length) and the address of the phy enable register.
+			length)
 - interrupts: 		Contains the interrupt information for the timer. The
 			format is being dependent on which interrupt controller
 			the Samsung device uses.
@@ -31,6 +32,8 @@ Required properties:
 			- "sclk_adc" : ADC special clock (only for Exynos3250
 				       and compatible ADC block)
 - vdd-supply		VDD input supply.
+- samsung,syscon-phandle Contains the PMU system controller node
+			(To access the ADC_PHY register)
 
 Note: child nodes can be added for auto probing from device tree.
 
@@ -38,7 +41,7 @@ Example: adding device info in dtsi file
 
 adc: adc@12D10000 {
 	compatible = "samsung,exynos-adc-v1";
-	reg = <0x12D10000 0x100>, <0x10040718 0x4>;
+	reg = <0x12D10000 0x100>;
 	interrupts = <0 106 0>;
 	#io-channel-cells = <1>;
 	io-channel-ranges;
@@ -47,13 +50,14 @@ adc: adc@12D10000 {
 	clock-names = "adc";
 
 	vdd-supply = <&buck5_reg>;
+	samsung,syscon-phandle = <&pmu_system_controller>;
 };
 
 Example: adding device info in dtsi file for Exynos3250 with additional sclk
 
 adc: adc@126C0000 {
 	compatible = "samsung,exynos3250-adc-v2";
-	reg = <0x126C0000 0x100>, <0x10020718 0x4>;
+	reg = <0x126C0000 0x100>;
 	interrupts = <0 137 0>;
 	#io-channel-cells = <1>;
 	io-channel-ranges;
@@ -62,6 +66,7 @@ adc: adc@126C0000 {
 	clock-names = "adc", "sclk_adc";
 
 	vdd-supply = <&buck5_reg>;
+	samsung,syscon-phandle = <&pmu_system_controller>;
 };
 
 Example: Adding child nodes in dts file
-- 
1.7.9.5

