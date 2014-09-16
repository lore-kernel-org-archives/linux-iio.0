Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:32615 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbaIPJDm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Sep 2014 05:03:42 -0400
From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-iio@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, cw00.choi@samsung.com,
	gregkh@linuxfoundation.org, naveenkrishna.ch@gmail.com,
	lars@metafoo.de, cpgs@samsung.com, grundler@chromium.org,
	jic23@kernel.org
Subject: [PATCH v2 2/3] Documentation: dt-bindings: update exynos-adc.txt with
 syscon handle
Date: Tue, 16 Sep 2014 14:28:50 +0530
Message-id: <1410857931-4980-3-git-send-email-ch.naveen@samsung.com>
In-reply-to: <1410857931-4980-1-git-send-email-ch.naveen@samsung.com>
References: <1410857931-4980-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch updates the DT bindings for ADC in exynos-adc.txt with the
syscon phandle to the ADC nodes.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: devicetree@vger.kernel.org
---
 .../devicetree/bindings/arm/samsung/exynos-adc.txt |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
index 709efaa..c368210 100644
--- a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
@@ -43,13 +43,16 @@ Required properties:
 				   compatible ADC block)
 - vdd-supply		VDD input supply.
 
+- samsung,syscon-phandle Contains the PMU system controller node
+			(To access the ADC_PHY register on Exynos5250/5420/5800/3250)
+
 Note: child nodes can be added for auto probing from device tree.
 
 Example: adding device info in dtsi file
 
 adc: adc@12D10000 {
 	compatible = "samsung,exynos-adc-v1";
-	reg = <0x12D10000 0x100>, <0x10040718 0x4>;
+	reg = <0x12D10000 0x100>;
 	interrupts = <0 106 0>;
 	#io-channel-cells = <1>;
 	io-channel-ranges;
@@ -58,13 +61,14 @@ adc: adc@12D10000 {
 	clock-names = "adc";
 
 	vdd-supply = <&buck5_reg>;
+	samsung,syscon-phandle = <&pmu_system_controller>;
 };
 
 Example: adding device info in dtsi file for Exynos3250 with additional sclk
 
 adc: adc@126C0000 {
 	compatible = "samsung,exynos3250-adc", "samsung,exynos-adc-v2;
-	reg = <0x126C0000 0x100>, <0x10020718 0x4>;
+	reg = <0x126C0000 0x100>;
 	interrupts = <0 137 0>;
 	#io-channel-cells = <1>;
 	io-channel-ranges;
@@ -73,6 +77,7 @@ adc: adc@126C0000 {
 	clock-names = "adc", "sclk";
 
 	vdd-supply = <&buck5_reg>;
+	samsung,syscon-phandle = <&pmu_system_controller>;
 };
 
 Example: Adding child nodes in dts file
-- 
1.7.9.5

