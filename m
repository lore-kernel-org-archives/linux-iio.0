Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	devicetree@vger.kernel.org,
	Peter Rosin <peda@axentia.se>
Subject: [PATCH 1/2 v3] iio: gyro: Add MPU-3050 device tree bindings
Date: Fri, 26 Aug 2016 09:59:07 +0200
Message-Id: <1472198348-31201-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

This adds device tree bindings for the MPU-3050 gyroscope. Since it
is the first set of bindings for a gyroscope, the folder for it
is also created.

Cc: devicetree@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Augmented device tree bindings to reflect Peter Rosins now merged
  I2C gate bindings.
ChangeLog v1->v2:
- Not yet convered to use i2c-gate as I'm waiting for that
  patch set to stabilize.
---
 .../bindings/iio/gyroscope/invensense,mpu3050.txt  | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/invensense,mpu3050.txt

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/invensense,mpu3050.txt b/Documentation/devicetree/bindings/iio/gyroscope/invensense,mpu3050.txt
new file mode 100644
index 000000000000..b0d3b59966bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/gyroscope/invensense,mpu3050.txt
@@ -0,0 +1,46 @@
+Invensense MPU-3050 Gyroscope device tree bindings
+
+Required properties:
+  - compatible : should be "invensense,mpu3050"
+  - reg : the I2C address of the sensor
+
+Optional properties:
+  - interrupt-parent : should be the phandle for the interrupt controller
+  - interrupts : interrupt mapping for the trigger interrupt from the
+    internal oscillator. The following IRQ modes are supported:
+    IRQ_TYPE_EDGE_RISING, IRQ_TYPE_EDGE_FALLING, IRQ_TYPE_LEVEL_HIGH and
+    IRQ_TYPE_LEVEL_LOW. The driver should detect and configure the hardware
+    for the desired interrupt type.
+  - vdd-supply : supply regulator for the main power voltage.
+  - vlogic-supply : supply regulator for the signal voltage.
+  - mount-matrix : see iio/mount-matrix.txt
+
+Optional subnodes:
+  - The MPU-3050 will pass through and forward the I2C signals from the
+    incoming I2C bus, alternatively drive traffic to a slave device (usually
+    an accelerometer) on its own initiative. Therefore is supports a subnode
+    i2c gate node. For details see: i2c/i2c-gate.txt
+
+Example:
+
+mpu3050@68 {
+	compatible = "invensense,mpu3050";
+	reg = <0x68>;
+	interrupt-parent = <&foo>;
+	interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
+	vdd-supply = <&bar>;
+	vlogic-supply = <&baz>;
+
+	/* External I2C interface */
+	i2c-gate {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		fnord@18 {
+			compatible = "fnord";
+			reg = <0x18>;
+			interrupt-parent = <&foo>;
+			interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+		};
+	};
+};
-- 
2.7.4
