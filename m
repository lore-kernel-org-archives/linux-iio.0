Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34624 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbeJREfS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Oct 2018 00:35:18 -0400
Received: by mail-ed1-f68.google.com with SMTP id w19-v6so26159590eds.1
        for <linux-iio@vger.kernel.org>; Wed, 17 Oct 2018 13:37:53 -0700 (PDT)
From: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
To: linux-iio@vger.kernel.org
Cc: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Subject: [PATCH 2/2] Add ti,dac7311 device tree bindings in documentation
Date: Wed, 17 Oct 2018 22:37:38 +0200
Message-Id: <20181017203738.13477-2-charles-antoine.couret@essensium.com>
In-Reply-To: <20181017203738.13477-1-charles-antoine.couret@essensium.com>
References: <20181017203738.13477-1-charles-antoine.couret@essensium.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

---
 .../bindings/iio/dac/ti,dac7311.txt           | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt

diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt b/Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt
new file mode 100644
index 000000000000..771414024cd0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt
@@ -0,0 +1,20 @@
+TI DAC7311 device tree bindings
+
+Required properties:
+
+- compatible: Must be set to "ti,dac7311", "ti,dac6311" or "ti,dac5311"
+- reg: spi chip select number for the device
+- vref-supply: The regulator supply for ADC reference voltage
+- spi-max-frequency: Max SPI frequency to use (< 50000000)
+
+Example:
+
+	spi_master {
+		dac7311: dac7311@0 {
+			compatible = "ti,dac7311";
+			reg = <0>; /* CS0 */
+			spi-max-frequency = <1000000>;
+			vref-supply = <&vdd_supply>;
+		};
+	};
+
-- 
2.17.2
