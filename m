Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:45720 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752623AbbCHNhJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Mar 2015 09:37:09 -0400
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
To: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: [PATCH] iio: ti-adc128s052: Add DT binding documentation
Date: Sun,  8 Mar 2015 14:36:58 +0100
Message-Id: <1425821818-28862-1-git-send-email-angelo.compagnucci@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Adding binding documentation for Texas Instruments' ADC128S052 ADC chip.

Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
---
 .../devicetree/bindings/iio/adc/ti-adc128s052.txt      | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt b/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
new file mode 100644
index 0000000..c8d682b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
@@ -0,0 +1,18 @@
+* Texas Instruments' ADC128S052 ADC chip
+
+Required properties:
+ - compatible: Should be "ti,adc128s052"
+ - reg: spi chip select number for the device
+ - vref-supply: The regulator supply for ADC reference voltage
+
+Recommended properties:
+ - spi-max-frequency: Definition as per
+		Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Example:
+adc@0 {
+	compatible = "ti,adc128s052";
+	reg = <0>;
+	vref-supply = <&vdd_supply>;
+	spi-max-frequency = <1000000>;
+};
-- 
1.9.1

