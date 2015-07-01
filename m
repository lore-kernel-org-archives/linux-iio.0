Return-Path: <martink@posteo.de>
From: Martin Kepplinger <martink@posteo.de>
To: pmeerw@pmeerw.net,
	jic23@kernel.org,
	christoph.muellner@theobroma-systems.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Martin Kepplinger <martink@posteo.de>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: [PATCH 5/8] iio: mma8452: add devicetree documentation
Date: Wed,  1 Jul 2015 10:21:59 +0200
Message-Id: <1435738922-12580-6-git-send-email-martink@posteo.de>
In-Reply-To: <1435738922-12580-1-git-send-email-martink@posteo.de>
References: <1435738922-12580-1-git-send-email-martink@posteo.de>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 .../devicetree/bindings/iio/accel/mma8452.txt       | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/mma8452.txt

diff --git a/Documentation/devicetree/bindings/iio/accel/mma8452.txt b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
new file mode 100644
index 0000000..8d98e05
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
@@ -0,0 +1,21 @@
+Freescale MMA8452Q, MMA8453Q, MMA8652FC or MMA8653FC triaxial accelerometer
+
+Required properties:
+
+  - compatible: should be "fsl,mma8653", "fsl,mma8652", "fsl,mma8453" or
+    "fsl,mma8452" respectively.
+  - reg: the I2C address of the chip
+
+Optional properties:
+
+  - interrupt-parent: should be the phandle for the interrupt controller
+  - interrupts: interrupt mapping for GPIO IRQ
+
+Example:
+
+	mma8653fc@1d {
+		compatible = "fsl,mma8653";
+		reg = <0x1d>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <5 0>;
+	};
-- 
2.1.4
