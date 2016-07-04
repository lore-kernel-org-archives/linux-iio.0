Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	devicetree@vger.kernel.org,
	Samu Onkalo <samu.onkalo@intel.com>
Subject: [PATCH 1/2 v2] iio: magn: DT bindings for AK8974
Date: Mon,  4 Jul 2016 11:08:06 +0200
Message-Id: <1467623287-9877-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

This adds device tree bindings for the AK8974 magnetometer, similar
to those for the AK8975.

Cc: devicetree@vger.kernel.org
Cc: Samu Onkalo <samu.onkalo@intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- No changes, just reposting to keep together with the series
---
 .../bindings/iio/magnetometer/ak8974.txt           | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt b/Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt
new file mode 100644
index 000000000000..967f8e9b9319
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt
@@ -0,0 +1,28 @@
+* Asahi Kasei AK8974 magnetometer sensor
+
+Required properties:
+
+- compatible : should be "asahi-kasei,ak8974"
+- reg : the I2C address of the magnetometer
+
+Optional properties:
+
+- avdd-supply: regulator supply for the analog voltage
+  (see regulator/regulator.txt)
+- dvdd-supply: regulator supply for the digital voltage
+  (see regulator/regulator.txt)
+- interrupts: data ready (DRDY) and interrupt (INT1) lines
+  from the chip, the DRDY interrupt must be placed first.
+  The interrupts can be triggered on rising or falling
+  edges alike.
+
+Example:
+
+ak8974@0f {
+	compatible = "asahi-kasei,ak8974";
+	reg = <0x0f>;
+	avdd-supply = <&foo_reg>;
+	dvdd-supply = <&bar_reg>;
+	interrupts = <0 IRQ_TYPE_EDGE_RISING>,
+		     <1 IRQ_TYPE_EDGE_RISING>;
+};
-- 
2.4.11
