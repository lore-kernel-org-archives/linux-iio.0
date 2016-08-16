Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37526 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753434AbcHPNd4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Aug 2016 09:33:56 -0400
Received: by mail-wm0-f52.google.com with SMTP id i5so168270972wmg.0
        for <linux-iio@vger.kernel.org>; Tue, 16 Aug 2016 06:33:55 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	devicetree@vger.kernel.org
Subject: [PATCH 01/17] iio: accel: kxsd9: Add device tree bindings
Date: Tue, 16 Aug 2016 15:33:27 +0200
Message-Id: <1471354423-19186-2-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
References: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This accelerometer can be probed from the device tree, so it needs
to have proper documentation of it's device tree bindings.

Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/iio/accel/kionix,kxsd9.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.txt

diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.txt b/Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.txt
new file mode 100644
index 000000000000..b25bf3a77e0f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.txt
@@ -0,0 +1,22 @@
+Kionix KXSD9 Accelerometer device tree bindings
+
+Required properties:
+ - compatible: 		should be set to "kionix,kxsd9"
+ - reg:			i2c slave address
+
+Optional properties:
+ - vdd-supply:		The input supply for VDD
+ - iovdd-supply:	The input supply for IOVDD
+ - interrupts:		The movement detection interrupt
+ - mount-matrix:	See mount-matrix.txt
+
+Example:
+
+kxsd9@18 {
+	compatible = "kionix,kxsd9";
+	reg = <0x18>;
+	interrupt-parent = <&foo>;
+	interrupts = <57 IRQ_TYPE_EDGE_FALLING>;
+	iovdd-supply = <&bar>;
+	vdd-supply = <&baz>;
+};
-- 
2.7.4

