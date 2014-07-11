Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:27452 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbaGKJKr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jul 2014 05:10:47 -0400
From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-iio@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, cw00.choi@samsung.com,
	gregkh@linuxfoundation.org, naveenkrishna.ch@gmail.com,
	lars@metafoo.de, cpgs@samsung.com, grundler@chromium.org
Subject: [PATCH 2/4] Documentation: dt-bindings: move exynos-adc.txt to more
 iio/adc/
Date: Fri, 11 Jul 2014 14:36:27 +0530
Message-id: <1405069589-10388-3-git-send-email-ch.naveen@samsung.com>
In-reply-to: <1405069589-10388-1-git-send-email-ch.naveen@samsung.com>
References: <1405069589-10388-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The DT bindings in exynos-adc.txt applies to the ADC
driver (exynos-adc.c) developed based on IIO framework.

The bindings are more appropriate to be under
Documentation/devicetree/bindings/iio/adc/

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: devicetree@vger.kernel.org
---
 .../devicetree/bindings/arm/samsung/exynos-adc.txt |   82 --------------------
 .../devicetree/bindings/iio/adc/exynos-adc.txt     |   82 ++++++++++++++++++++
 2 files changed, 82 insertions(+), 82 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/exynos-adc.txt

diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
deleted file mode 100644
index b87749a..0000000
--- a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
+++ /dev/null
@@ -1,82 +0,0 @@
-Samsung Exynos Analog to Digital Converter bindings
-
-The devicetree bindings are for the new ADC driver written for
-Exynos4 and upward SoCs from Samsung.
-
-New driver handles the following
-1. Supports ADC IF found on EXYNOS4412/EXYNOS5250
-   and future SoCs from Samsung
-2. Add ADC driver under iio/adc framework
-3. Also adds the Documentation for device tree bindings
-
-Required properties:
-- compatible:		Must be "samsung,exynos-adc-v1"
-				for exynos4412/5250 controllers.
-			Must be "samsung,exynos-adc-v2" for
-				future controllers.
-			Must be "samsung,exynos3250-adc-v2" for
-				for controllers compatible with ADC of
-				Exynos3250.
-- reg:			Contains ADC register address range (base address and
-			length) and the address of the phy enable register.
-- interrupts: 		Contains the interrupt information for the timer. The
-			format is being dependent on which interrupt controller
-			the Samsung device uses.
-- #io-channel-cells = <1>; As ADC has multiple outputs
-- clocks		From common clock bindings: handles to clocks specified
-			in "clock-names" property, in the same order.
-- clock-names		From common clock bindings: list of clock input names
-			used by ADC block:
-			- "adc" : ADC bus clock
-			- "sclk_adc" : ADC special clock (only for Exynos3250
-				       and compatible ADC block)
-- vdd-supply		VDD input supply.
-
-Note: child nodes can be added for auto probing from device tree.
-
-Example: adding device info in dtsi file
-
-adc: adc@12D10000 {
-	compatible = "samsung,exynos-adc-v1";
-	reg = <0x12D10000 0x100>, <0x10040718 0x4>;
-	interrupts = <0 106 0>;
-	#io-channel-cells = <1>;
-	io-channel-ranges;
-
-	clocks = <&clock 303>;
-	clock-names = "adc";
-
-	vdd-supply = <&buck5_reg>;
-};
-
-Example: adding device info in dtsi file for Exynos3250 with additional sclk
-
-adc: adc@126C0000 {
-	compatible = "samsung,exynos3250-adc-v2";
-	reg = <0x126C0000 0x100>, <0x10020718 0x4>;
-	interrupts = <0 137 0>;
-	#io-channel-cells = <1>;
-	io-channel-ranges;
-
-	clocks = <&cmu CLK_TSADC>, <&cmu CLK_SCLK_TSADC>;
-	clock-names = "adc", "sclk_adc";
-
-	vdd-supply = <&buck5_reg>;
-};
-
-Example: Adding child nodes in dts file
-
-adc@12D10000 {
-
-	/* NTC thermistor is a hwmon device */
-	ncp15wb473@0 {
-		compatible = "ntc,ncp15wb473";
-		pullup-uv = <1800000>;
-		pullup-ohm = <47000>;
-		pulldown-ohm = <0>;
-		io-channels = <&adc 4>;
-	};
-};
-
-Note: Does not apply to ADC driver under arch/arm/plat-samsung/
-Note: The child node can be added under the adc node or separately.
diff --git a/Documentation/devicetree/bindings/iio/adc/exynos-adc.txt b/Documentation/devicetree/bindings/iio/adc/exynos-adc.txt
new file mode 100644
index 0000000..b87749a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/exynos-adc.txt
@@ -0,0 +1,82 @@
+Samsung Exynos Analog to Digital Converter bindings
+
+The devicetree bindings are for the new ADC driver written for
+Exynos4 and upward SoCs from Samsung.
+
+New driver handles the following
+1. Supports ADC IF found on EXYNOS4412/EXYNOS5250
+   and future SoCs from Samsung
+2. Add ADC driver under iio/adc framework
+3. Also adds the Documentation for device tree bindings
+
+Required properties:
+- compatible:		Must be "samsung,exynos-adc-v1"
+				for exynos4412/5250 controllers.
+			Must be "samsung,exynos-adc-v2" for
+				future controllers.
+			Must be "samsung,exynos3250-adc-v2" for
+				for controllers compatible with ADC of
+				Exynos3250.
+- reg:			Contains ADC register address range (base address and
+			length) and the address of the phy enable register.
+- interrupts: 		Contains the interrupt information for the timer. The
+			format is being dependent on which interrupt controller
+			the Samsung device uses.
+- #io-channel-cells = <1>; As ADC has multiple outputs
+- clocks		From common clock bindings: handles to clocks specified
+			in "clock-names" property, in the same order.
+- clock-names		From common clock bindings: list of clock input names
+			used by ADC block:
+			- "adc" : ADC bus clock
+			- "sclk_adc" : ADC special clock (only for Exynos3250
+				       and compatible ADC block)
+- vdd-supply		VDD input supply.
+
+Note: child nodes can be added for auto probing from device tree.
+
+Example: adding device info in dtsi file
+
+adc: adc@12D10000 {
+	compatible = "samsung,exynos-adc-v1";
+	reg = <0x12D10000 0x100>, <0x10040718 0x4>;
+	interrupts = <0 106 0>;
+	#io-channel-cells = <1>;
+	io-channel-ranges;
+
+	clocks = <&clock 303>;
+	clock-names = "adc";
+
+	vdd-supply = <&buck5_reg>;
+};
+
+Example: adding device info in dtsi file for Exynos3250 with additional sclk
+
+adc: adc@126C0000 {
+	compatible = "samsung,exynos3250-adc-v2";
+	reg = <0x126C0000 0x100>, <0x10020718 0x4>;
+	interrupts = <0 137 0>;
+	#io-channel-cells = <1>;
+	io-channel-ranges;
+
+	clocks = <&cmu CLK_TSADC>, <&cmu CLK_SCLK_TSADC>;
+	clock-names = "adc", "sclk_adc";
+
+	vdd-supply = <&buck5_reg>;
+};
+
+Example: Adding child nodes in dts file
+
+adc@12D10000 {
+
+	/* NTC thermistor is a hwmon device */
+	ncp15wb473@0 {
+		compatible = "ntc,ncp15wb473";
+		pullup-uv = <1800000>;
+		pullup-ohm = <47000>;
+		pulldown-ohm = <0>;
+		io-channels = <&adc 4>;
+	};
+};
+
+Note: Does not apply to ADC driver under arch/arm/plat-samsung/
+Note: The child node can be added under the adc node or separately.
-- 
1.7.9.5

