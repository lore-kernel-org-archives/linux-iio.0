Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33403 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933614AbcFQPMf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jun 2016 11:12:35 -0400
Received: by mail-lf0-f50.google.com with SMTP id f6so620547lfg.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Jun 2016 08:12:34 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	devicetree@vger.kernel.org
Subject: [PATCH 1/4] iio: pressure: bmp280: augment DT bindings
Date: Fri, 17 Jun 2016 17:12:18 +0200
Message-Id: <1466176341-17442-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds standard device tree bindings for a reset GPIO line, and
the VDDD and VDDA power regulators.

Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/iio/pressure/bmp085.txt | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.txt b/Documentation/devicetree/bindings/iio/pressure/bmp085.txt
index d7a6deb6b21e..06ad5feaea28 100644
--- a/Documentation/devicetree/bindings/iio/pressure/bmp085.txt
+++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.txt
@@ -1,7 +1,7 @@
-BMP085/BMP18x digital pressure sensors
+BMP085/BMP18x/BMP28x digital pressure sensors
 
 Required properties:
-- compatible: bosch,bmp085
+- compatible: "bosch,bmp085" or "bosch,bmp180" or "bosch,bmp280"
 
 Optional properties:
 - chip-id: configurable chip id for non-default chip revisions
@@ -10,6 +10,10 @@ Optional properties:
   value range is 0-3 with rising sensitivity.
 - interrupt-parent: should be the phandle for the interrupt controller
 - interrupts: interrupt mapping for IRQ
+- reset-gpios: a GPIO line handling reset of the sensor: as the line is
+  active low, it should be marked GPIO_ACTIVE_LOW (see gpio/gpio.txt)
+- vddd-supply: digital voltage regulator (see regulator/regulator.txt)
+- vdda-supply: analog voltage regulator (see regulator/regulator.txt)
 
 Example:
 
@@ -21,4 +25,7 @@ pressure@77 {
 	default-oversampling = <2>;
 	interrupt-parent = <&gpio0>;
 	interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+	reset-gpios = <&gpio0 26 GPIO_ACTIVE_LOW>;
+	vddd-supply = <&foo>;
+	vdda-supply = <&bar>;
 };
-- 
2.4.11

