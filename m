Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34657 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1035078AbcIZTzu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Sep 2016 15:55:50 -0400
Received: by mail-lf0-f67.google.com with SMTP id b71so9844709lfg.1
        for <linux-iio@vger.kernel.org>; Mon, 26 Sep 2016 12:55:49 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
Subject: [PATCH 2/2] Documentation: dt: iio: humidity: add hts221 sensor device binding
Date: Mon, 26 Sep 2016 21:55:41 +0200
Message-Id: <1474919741-21316-3-git-send-email-lorenzo.bianconi@st.com>
In-Reply-To: <1474919741-21316-1-git-send-email-lorenzo.bianconi@st.com>
References: <1474919741-21316-1-git-send-email-lorenzo.bianconi@st.com>
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

