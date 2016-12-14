Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:56263 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755084AbcLNKAR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Dec 2016 05:00:17 -0500
Date: Wed, 14 Dec 2016 10:59:45 +0100
From: Andreas Klinger <ak@it-klinger.de>
To: devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, ak@it-klinger.de
Subject: [PATCH v2 1/2] iio: adc: hx711: Add DT binding for avia,hx711
Message-ID: <20161214095945.GA26511@andreas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add DT bindings for avia,hx711
Add vendor avia to vendor list

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../devicetree/bindings/iio/adc/avia-hx711.txt      | 21 +++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt         |  1 +
 2 files changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/avia-hx711.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
new file mode 100644
index 000000000000..6a4659fc7a4f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
@@ -0,0 +1,21 @@
+* AVIA HX711 ADC chip for weight cells
+  Bit-banging driver
+
+Required properties:
+ - compatible: Should be "avia,hx711"
+ - sck-gpios:	Definition of the GPIO for the clock
+ - dout-gpios:	Definition of the GPIO for data-out
+		See Documentation/devicetree/bindings/gpio/gpio.txt
+
+Recommended properties:
+ - gain:	Gain select, can be 32, 64 or 128
+		default is 128
+
+Example:
+weight@0 {
+	compatible = "avia,hx711";
+	sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
+	dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
+	gain = <32>
+};
+
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 44ddc980b085..4696bb5c2198 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -32,6 +32,7 @@ atlas	Atlas Scientific LLC
 atmel	Atmel Corporation
 auo	AU Optronics Corporation
 avago	Avago Technologies
+avia	avia semiconductor
 avic	Shanghai AVIC Optoelectronics Co., Ltd.
 axis	Axis Communications AB
 boe	BOE Technology Group Co., Ltd.
-- 
2.1.4

