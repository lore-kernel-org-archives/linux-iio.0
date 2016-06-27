Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:35204 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbcF0Qal (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2016 12:30:41 -0400
Received: by mail-lf0-f49.google.com with SMTP id l188so158992212lfe.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Jun 2016 09:30:40 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Akinobu Mita <akinobu.mita@gmail.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Matt Ranostay <mranostay@gmail.com>
Cc: Christoph Mair <christoph.mair@gmail.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>,
	Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	devicetree@vger.kernel.org
Subject: [PATCH 01/10 v3] iio: pressure: bmp280: augment DT bindings
Date: Mon, 27 Jun 2016 18:30:11 +0200
Message-Id: <1467045020-2665-2-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1467045020-2665-1-git-send-email-linus.walleij@linaro.org>
References: <1467045020-2665-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds standard device tree bindings for a reset GPIO line, and
the VDDD and VDDA power regulators.

Cc: devicetree@vger.kernel.org
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLov v2->v3:
- None, just resending in case Jonathan prefers this binding doc
ChangeLog v1->v2:
- Order compatible string on single lines
- Add "bosch,bme280" for the new sensor from Matt
---
 Documentation/devicetree/bindings/iio/pressure/bmp085.txt | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.txt b/Documentation/devicetree/bindings/iio/pressure/bmp085.txt
index d7a6deb6b21e..c7198a03c906 100644
--- a/Documentation/devicetree/bindings/iio/pressure/bmp085.txt
+++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.txt
@@ -1,7 +1,11 @@
-BMP085/BMP18x digital pressure sensors
+BMP085/BMP18x/BMP28x digital pressure sensors
 
 Required properties:
-- compatible: bosch,bmp085
+- compatible: must be one of:
+  "bosch,bmp085"
+  "bosch,bmp180"
+  "bosch,bmp280"
+  "bosch,bme280"
 
 Optional properties:
 - chip-id: configurable chip id for non-default chip revisions
@@ -10,6 +14,10 @@ Optional properties:
   value range is 0-3 with rising sensitivity.
 - interrupt-parent: should be the phandle for the interrupt controller
 - interrupts: interrupt mapping for IRQ
+- reset-gpios: a GPIO line handling reset of the sensor: as the line is
+  active low, it should be marked GPIO_ACTIVE_LOW (see gpio/gpio.txt)
+- vddd-supply: digital voltage regulator (see regulator/regulator.txt)
+- vdda-supply: analog voltage regulator (see regulator/regulator.txt)
 
 Example:
 
@@ -21,4 +29,7 @@ pressure@77 {
 	default-oversampling = <2>;
 	interrupt-parent = <&gpio0>;
 	interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+	reset-gpios = <&gpio0 26 GPIO_ACTIVE_LOW>;
+	vddd-supply = <&foo>;
+	vdda-supply = <&bar>;
 };
-- 
2.4.11

