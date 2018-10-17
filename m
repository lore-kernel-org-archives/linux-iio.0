Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40559 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbeJREha (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Oct 2018 00:37:30 -0400
Received: by mail-ed1-f68.google.com with SMTP id r1-v6so26188658edd.7
        for <linux-iio@vger.kernel.org>; Wed, 17 Oct 2018 13:40:04 -0700 (PDT)
From: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
To: linux-iio@vger.kernel.org
Cc: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Subject: [PATCHv2 2/2] Add AD7949 device tree bindings in documentation
Date: Wed, 17 Oct 2018 22:39:54 +0200
Message-Id: <20181017203954.13744-2-charles-antoine.couret@essensium.com>
In-Reply-To: <20181017203954.13744-1-charles-antoine.couret@essensium.com>
References: <20181017203954.13744-1-charles-antoine.couret@essensium.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add AD7949 device tree bindings in documentation

Signed-off-by: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
---
 .../devicetree/bindings/iio/adc/ad7949.txt     | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ad7949.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/ad7949.txt b/Documentation/devicetree/bindings/iio/adc/ad7949.txt
new file mode 100644
index 000000000000..9ecb84188d83
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
+	compatible = "ad7949";
+	reg = <0>;
+	vref-supply = <&vdd_supply>;
+	spi-max-frequency = <200000>;
+};
-- 
2.17.2
