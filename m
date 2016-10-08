Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35900 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754730AbcJHHp7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Oct 2016 03:45:59 -0400
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: [PATCH v3 2/2] Documentation: dt: iio: humidity: add hts221 sensor device binding
Date: Sat,  8 Oct 2016 09:45:52 +0200
Message-Id: <1475912752-6444-3-git-send-email-lorenzo.bianconi@st.com>
In-Reply-To: <1475912752-6444-1-git-send-email-lorenzo.bianconi@st.com>
References: <1475912752-6444-1-git-send-email-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 .../devicetree/bindings/iio/humidity/hts221.txt       | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/humidity/hts221.txt

diff --git a/Documentation/devicetree/bindings/iio/humidity/hts221.txt b/Documentation/devicetree/bindings/iio/humidity/hts221.txt
new file mode 100644
index 0000000..46a152c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/humidity/hts221.txt
@@ -0,0 +1,19 @@
+* HTS221 STM humidity + temperature sensor
+
+Required properties:
+- compatible: should be "st,hts221"
+- reg: i2c address of the sensor / spi cs line
+
+Optional properties:
+- interrupts: interrupt mapping for GPIO IRQ. It should be configured with
+	      flags IRQ_TYPE_LEVEL_HIGH or IRQ_TYPE_EDGE_RISING
+- interrupt-parent: should be the phandle for the interrupt controller
+
+Example:
+
+hts221@5f {
+	compatible = "st,hts221";
+	reg = <0x5f>;
+	interrupt-parent = <&gpio0>;
+	interrupts = <0 IRQ_TYPE_EDGE_RISING>;
+};
-- 
2.7.4

