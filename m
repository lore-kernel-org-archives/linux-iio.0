Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48396 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751124AbcA2TEG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 29 Jan 2016 14:04:06 -0500
From: Andreas Dannenberg <dannenberg@ti.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<jic23@kernel.org>
CC: Alexander Koch <mail@alexanderkoch.net>, <knaack.h@gmx.de>,
	<lars@metafoo.de>, <pmeerw@pmeerw.ne>, <mhornung.linux@gmail.com>,
	<fengguang.wu@intel.com>, Andreas Dannenberg <dannenberg@ti.com>
Subject: [PATCH] iio: light: opt3001: Add device tree binding documentation
Date: Fri, 29 Jan 2016 13:03:00 -0600
Message-ID: <1454094180-2688-1-git-send-email-dannenberg@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
---
 .../devicetree/bindings/iio/light/opt3001.txt      | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/opt3001.txt

diff --git a/Documentation/devicetree/bindings/iio/light/opt3001.txt b/Documentation/devicetree/bindings/iio/light/opt3001.txt
new file mode 100644
index 0000000..55b9cb3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/opt3001.txt
@@ -0,0 +1,26 @@
+* Texas Instruments OPT3001 Ambient Light Sensor
+
+The driver supports interrupt-driven and interrupt-less operation, depending
+on whether an interrupt property has been populated into the DT. Note that
+the optional generation of IIO events on rising/falling light threshold changes
+requires the use of interrupts. Without interrupts, only the simple reading
+of the current light value is supported through the IIO API.
+
+http://www.ti.com/product/opt3001
+
+Required properties:
+  - compatible: should be "ti,opt3001"
+  - reg: the I2C address of the sensor
+  
+Optional properties:
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
2.6.4

