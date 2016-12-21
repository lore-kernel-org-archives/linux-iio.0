Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:50522 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934361AbcLUPZI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Dec 2016 10:25:08 -0500
Date: Wed, 21 Dec 2016 16:24:42 +0100
From: Andreas Klinger <ak@it-klinger.de>
To: devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, ak@it-klinger.de
Subject: [PATCH v4 1/2] iio: adc: hx711: Add DT binding for avia,hx711
Message-ID: <20161221152442.GA14543@andreas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add DT bindings for avia,hx711
Add vendor avia to vendor list

[PATCH v3 1/2] of this patch was Acked-by: Rob Herring <robh@kernel.org>
Sorry, but i had to add the regulator (avdd-supply) and therefore it 
needs to be acked once again.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../devicetree/bindings/iio/adc/avia-hx711.txt         | 18 ++++++++++++++++++
 Documentation/devicetree/bindings/vendor-prefixes.txt  |  1 +
 2 files changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/avia-hx711.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
new file mode 100644
index 000000000000..b3629405f568
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
@@ -0,0 +1,18 @@
+* AVIA HX711 ADC chip for weight cells
+  Bit-banging driver
+
+Required properties:
+ - compatible:	Should be "avia,hx711"
+ - sck-gpios:	Definition of the GPIO for the clock
+ - dout-gpios:	Definition of the GPIO for data-out
+		See Documentation/devicetree/bindings/gpio/gpio.txt
+ - avdd-supply:	Definition of the regulator used as analog supply
+
+Example:
+weight@0 {
+	compatible = "avia,hx711";
+	sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
+	dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
+	avdd-suppy = <&avdd>;
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

