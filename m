Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40442 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbeJWFXU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Oct 2018 01:23:20 -0400
Received: by mail-ed1-f68.google.com with SMTP id r1-v6so39328639edd.7
        for <linux-iio@vger.kernel.org>; Mon, 22 Oct 2018 14:03:10 -0700 (PDT)
From: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
To: linux-iio@vger.kernel.org
Cc: Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: [PATCH V3 2/2] doc:devicetree: Add AD7949 device tree bindings in documentation
Date: Mon, 22 Oct 2018 23:02:43 +0200
Message-Id: <20181022210243.837-2-charles-antoine.couret@essensium.com>
In-Reply-To: <20181022210243.837-1-charles-antoine.couret@essensium.com>
References: <20181022210243.837-1-charles-antoine.couret@essensium.com>
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Description how to invoke ad7949 driver from device tree file.

Signed-off-by: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
---
V1 to V3:
* Add prefix vendor
* Improve patch description

 .../devicetree/bindings/iio/adc/ad7949.txt     | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ad7949.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/ad7949.txt b/Documentation/devicetree/bindings/iio/adc/ad7949.txt
new file mode 100644
index 000000000000..f1c3af53f5cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ad7949.txt
@@ -0,0 +1,18 @@
+* Analog Devices AD7949/AD7682/AD7689
+
+Required properties:
+ - compatible: Should be one of
+	* "adi,ad7949"
+	* "adi,ad7682"
+	* "adi,ad7689"
+ - reg: spi chip select number for the device
+ - vref-supply: The regulator supply for ADC reference voltage
+ - spi-max-frequency: Max SPI frequency to use (< 33000000)
+
+Example:
+adc@0 {
+	compatible = "adi,ad7949";
+	reg = <0>;
+	vref-supply = <&vdd_supply>;
+	spi-max-frequency = <200000>;
+};
-- 
2.19.1
