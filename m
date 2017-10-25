Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:51719 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbdJYSQR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Oct 2017 14:16:17 -0400
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: [PATCH 2/2] dt-bindings: iio: light: add UVIS25 device bindings
Date: Wed, 25 Oct 2017 20:16:09 +0200
Message-Id: <20171025181609.3803-3-lorenzo.bianconi@st.com>
In-Reply-To: <20171025181609.3803-1-lorenzo.bianconi@st.com>
References: <20171025181609.3803-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 .../devicetree/bindings/iio/light/st_uvis25.txt    | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/st_uvis25.txt

diff --git a/Documentation/devicetree/bindings/iio/light/st_uvis25.txt b/Documentation/devicetree/bindings/iio/light/st_uvis25.txt
new file mode 100644
index 000000000000..3041207e3f3c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/st_uvis25.txt
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
2.14.2

