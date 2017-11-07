Return-Path: <SRS0=cLh2=CF=googlemail.com=chf.fritz@kernel.org>
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: iio: add Intersil isl76683 light sensor bindings
Date: Tue,  7 Nov 2017 16:36:22 +0100
Message-Id: <1510068983-25769-3-git-send-email-chf.fritz@googlemail.com>
In-Reply-To: <1510068983-25769-1-git-send-email-chf.fritz@googlemail.com>
References: <1510068983-25769-1-git-send-email-chf.fritz@googlemail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch adds documentation of device tree bindings for Intersil
isl76683 light sensor.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 .../devicetree/bindings/iio/light/isl76683.txt     | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/isl76683.txt

diff --git a/Documentation/devicetree/bindings/iio/light/isl76683.txt b/Documentation/devicetree/bindings/iio/light/isl76683.txt
new file mode 100644
index 0000000..657f17d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/isl76683.txt
@@ -0,0 +1,26 @@
+* ISL76683 ambient light sensor
+
+http://www.intersil.com/content/dam/Intersil/documents/isl7/isl76683.pdf
+
+Required properties:
+
+  - compatible: must be "isil,isl76683"
+  - reg: the I2C address of the sensor
+  - interrupt-parent: should be the phandle for the interrupt controller
+  - interrupts: interrupt mapping for GPIO IRQ
+
+Optional properties:
+
+  - isil,external-resistor: integer in kOhm of external resistor R_ext.
+                            Valid values are from 1 to 1000.
+                            If not supplied, 100 kOhm will be assumed.
+
+Example:
+
+isl76683@44 {
+	compatible = "isil,isl76683";
+	reg = <0x44>;
+	interrupt-parent = <&gpio1>;
+	interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
+	isil,external-resistor = <50>;
+};
-- 
2.1.4
