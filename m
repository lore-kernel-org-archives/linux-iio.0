Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40435 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbeJGDfa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Oct 2018 23:35:30 -0400
Received: by mail-ed1-f68.google.com with SMTP id j62-v6so14415731edd.7
        for <linux-iio@vger.kernel.org>; Sat, 06 Oct 2018 13:30:48 -0700 (PDT)
From: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
To: linux-iio@vger.kernel.org
Cc: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Subject: [PATCH 2/2] Add ad7949 device tree bindings in documentation
Date: Sat,  6 Oct 2018 22:30:36 +0200
Message-Id: <20181006203036.20338-2-charles-antoine.couret@essensium.com>
In-Reply-To: <20181006203036.20338-1-charles-antoine.couret@essensium.com>
References: <20181006203036.20338-1-charles-antoine.couret@essensium.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
---
 .../devicetree/bindings/iio/adc/ad7949.txt     | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ad7949.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/ad7949.txt b/Documentation/devicetree/bindings/iio/adc/ad7949.txt
new file mode 100644
index 000000000000..4dc921961df7
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ad7949.txt
@@ -0,0 +1,18 @@
+* Analog Devices AD7949/AD7682/AD7689
+
+Required properties:
+ - compatible: Should be one of
+	* "ad7949"
+	* "ad7682"
+	* "ad7689"
+ - reg: spi chip select number for the device
+ - vref-supply: The regulator supply for ADC reference voltage
+ - spi-max-frequency: Max SPI frequency to use (< 33000000)
+
+Example:
+adc@0 {
+	compatible = "ti,adc0832";
+	reg = <0>;
+	vref-supply = <&vdd_supply>;
+	spi-max-frequency = <200000>;
+};
-- 
2.17.1
