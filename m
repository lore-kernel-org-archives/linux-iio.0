Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:43458 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbaLQR7w (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Dec 2014 12:59:52 -0500
Received: by mail-wg0-f53.google.com with SMTP id l18so21059336wgh.12
        for <linux-iio@vger.kernel.org>; Wed, 17 Dec 2014 09:59:51 -0800 (PST)
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: [PATCH] iio: ti-adc128s052: Add DT binding documentation
Date: Wed, 17 Dec 2014 18:59:43 +0100
Message-Id: <1418839183-27819-1-git-send-email-angelo.compagnucci@gmail.com>
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
index 0000000..12132ef
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
@@ -0,0 +1,18 @@
+* Texas Instruments' ADC128S052 ADC chip
+
+Required properties:
+  - compatible: Should be "ti,adc128s052" 
+  - reg: spi chip select number for the device
+  - vref-supply: The regulator supply ADC reference voltage.
+
+Recommended properties:
+- spi-max-frequency: Definition as per
+                     Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Example:
+adc@0 {
+	compatible = "ti,adc128s052";
+	reg = <0>;
+        vref-supply = <&vdd_supply>;
+	spi-max-frequency = <1000000>;
+};
-- 
1.9.1

