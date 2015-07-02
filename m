Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45142 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbbGBW2r (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 2 Jul 2015 18:28:47 -0400
From: Andreas Dannenberg <dannenberg@ti.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Andreas Dannenberg <dannenberg@ti.com>
Subject: [PATCH v3 2/2] iio: light: opt3001: Add device tree binding documentation
Date: Thu, 2 Jul 2015 17:27:59 -0500
Message-ID: <1435876079-26287-3-git-send-email-dannenberg@ti.com>
In-Reply-To: <1435876079-26287-1-git-send-email-dannenberg@ti.com>
References: <1435876079-26287-1-git-send-email-dannenberg@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
---
 .../devicetree/bindings/iio/light/opt3001.txt          | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/opt3001.txt

diff --git a/Documentation/devicetree/bindings/iio/light/opt3001.txt b/Documentation/devicetree/bindings/iio/light/opt3001.txt
new file mode 100644
index 0000000..d5f0765
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/opt3001.txt
@@ -0,0 +1,18 @@
+* Texas Instruments OPT3001 Ambient Light Sensor
+
+http://www.ti.com/product/opt3001
+
+Required properties:
+  - compatible: should be "ti,opt3001"
+  - reg: the I2C address of the sensor
+  - interrupt-parent: should be the phandle for the interrupt controller
+  - interrupts: interrupt mapping for GPIO IRQ (configure for falling edge)
+
+Example:
+
+opt3001@44 {
+	compatible = "ti,opt3001";
+	reg = <0x44>;
+	interrupt-parent = <&gpio1>;
+	interrupts = <28 IRQ_TYPE_EDGE_FALLING>;
+};
-- 
1.9.1

