Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33432 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753362AbdKWW7O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Nov 2017 17:59:14 -0500
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: iio: light: add UVIS25 device bindings
Date: Thu, 23 Nov 2017 23:59:06 +0100
Message-Id: <20171123225906.31838-3-lorenzo.bianconi83@gmail.com>
In-Reply-To: <20171123225906.31838-1-lorenzo.bianconi83@gmail.com>
References: <20171123225906.31838-1-lorenzo.bianconi83@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
---
 .../devicetree/bindings/iio/light/uvis25.txt       | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/uvis25.txt

diff --git a/Documentation/devicetree/bindings/iio/light/uvis25.txt b/Documentation/devicetree/bindings/iio/light/uvis25.txt
new file mode 100644
index 000000000000..3041207e3f3c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/uvis25.txt
@@ -0,0 +1,23 @@
+* ST UVIS25 uv sensor
+
+Required properties:
+- compatible: should be "st,uvis25"
+- reg: i2c address of the sensor / spi cs line
+
+Optional properties:
+- interrupt-parent: should be the phandle for the interrupt controller
+- interrupts: interrupt mapping for IRQ. It should be configured with
+  flags IRQ_TYPE_LEVEL_HIGH, IRQ_TYPE_EDGE_RISING, IRQ_TYPE_LEVEL_LOW or
+  IRQ_TYPE_EDGE_FALLING.
+
+  Refer to interrupt-controller/interrupts.txt for generic interrupt
+  client node bindings.
+
+Example:
+
+uvis25@47 {
+	compatible = "st,uvis25";
+	reg = <0x47>;
+	interrupt-parent = <&gpio0>;
+	interrupts = <0 IRQ_TYPE_EDGE_RISING>;
+};
-- 
2.15.0

