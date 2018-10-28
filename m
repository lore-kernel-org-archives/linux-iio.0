Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44469 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbeJ2BJQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Oct 2018 21:09:16 -0400
Received: by mail-ed1-f67.google.com with SMTP id z21-v6so5218977edb.11
        for <linux-iio@vger.kernel.org>; Sun, 28 Oct 2018 09:24:11 -0700 (PDT)
From: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
To: linux-iio@vger.kernel.org
Cc: Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        mark.rutland@arm.com, devicetree@vger.kernel.org
Subject: [PATCH v4 2/2] dt-bindings: iio: dac: Add ti,dac7311 device tree bindings in documentation
Date: Sun, 28 Oct 2018 17:24:02 +0100
Message-Id: <20181028162402.16182-2-charles-antoine.couret@essensium.com>
In-Reply-To: <20181028162402.16182-1-charles-antoine.couret@essensium.com>
References: <20181028162402.16182-1-charles-antoine.couret@essensium.com>
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Description how to invoke ti-dac7311 driver from device tree file.

Signed-off-by: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
---
 .../bindings/iio/dac/ti,dac7311.txt           | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt

diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt b/Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt
new file mode 100644
index 000000000000..1139e3b743cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt
@@ -0,0 +1,24 @@
+TI DAC7311 device tree bindings
+
+Required properties:
+- compatible: must be set to:
+	* "ti,dac7311"
+	* "ti,dac6311"
+	* "ti,dac5311"
+- reg: spi chip select number for the device
+- vref-supply: The regulator supply for ADC reference voltage
+
+Optional properties:
+- spi-max-frequency: Max SPI frequency to use
+
+Example:
+
+	spi_master {
+		dac@0 {
+			compatible = "ti,dac7311";
+			reg = <0>; /* CS0 */
+			spi-max-frequency = <1000000>;
+			vref-supply = <&vdd_supply>;
+		};
+	};
+
-- 
2.19.1
