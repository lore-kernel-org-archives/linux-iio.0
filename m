Return-Path: <SRS0=PzOY=CQ=googlemail.com=chf.fritz@kernel.org>
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: iio: add Intersil isl76683 light sensor bindings
Date: Sun, 19 Nov 2017 00:20:29 +0100
Message-Id: <1511047230-7021-3-git-send-email-chf.fritz@googlemail.com>
In-Reply-To: <1511047230-7021-1-git-send-email-chf.fritz@googlemail.com>
References: <1511047230-7021-1-git-send-email-chf.fritz@googlemail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch adds documentation of device tree bindings for Intersil
isl76683 light sensor.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 .../devicetree/bindings/iio/light/isl76683.txt     | 26 ++++++++++++++++++++++
 .../devicetree/bindings/property-units.txt         |  1 +
 2 files changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/isl76683.txt

diff --git a/Documentation/devicetree/bindings/iio/light/isl76683.txt b/Documentation/devicetree/bindings/iio/light/isl76683.txt
new file mode 100644
index 0000000..b1a8a67
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
+  - isil,external-resistor-kilo-ohms: integer in kilo Ohms of external resistor
+    R_ext.  Valid values are from 1 to 1000.  If not supplied, 100 kilo Ohms
+    will be assumed.
+
+Example:
+
+isl76683@44 {
+	compatible = "isil,isl76683";
+	reg = <0x44>;
+	interrupt-parent = <&gpio1>;
+	interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
+	isil,external-resistor-kilo-ohms = <50>;
+};
diff --git a/Documentation/devicetree/bindings/property-units.txt b/Documentation/devicetree/bindings/property-units.txt
index 45ce054..5f9c71a 100644
--- a/Documentation/devicetree/bindings/property-units.txt
+++ b/Documentation/devicetree/bindings/property-units.txt
@@ -28,6 +28,7 @@ Electricity
 -microamp-hours : micro amp-hours
 -ohms		: Ohms
 -micro-ohms	: micro Ohms
+-kilo-ohms	: kilo Ohms
 -microwatt-hours: micro Watt-hours
 -microvolt	: micro volts
 -picofarads	: picofarads
-- 
2.1.4
