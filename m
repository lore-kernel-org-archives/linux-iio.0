Return-Path: <martink@posteo.de>
From: Martin Kepplinger <martink@posteo.de>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	mfuzzey@parkeon.com,
	roberta.dobrescu@gmail.com,
	robh+dt@kernel.org,
	pawel.moll@arm.com,
	mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org
Cc: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christoph.muellner@theobroma-systems.com,
	Martin Kepplinger <martink@posteo.de>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: [PATCH 5/8] iio: mma8452: add devicetree binding document
Date: Mon,  6 Jul 2015 14:34:19 +0200
Message-Id: <1436186062-5766-6-git-send-email-martink@posteo.de>
In-Reply-To: <1436186062-5766-1-git-send-email-martink@posteo.de>
References: <1436186062-5766-1-git-send-email-martink@posteo.de>
List-ID: <linux-iio@vger.kernel.org>

As we support more chips now, add a binding document and remove it from
i2c trivial-devices.txt list.

The binding document is further extended in a later patch of this series.

Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 .../devicetree/bindings/i2c/trivial-devices.txt     |  1 -
 .../devicetree/bindings/iio/accel/mma8452.txt       | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/mma8452.txt

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index 00f8652..094238a 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -54,7 +54,6 @@ epson,rx8581		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
 fsl,mag3110		MAG3110: Xtrinsic High Accuracy, 3D Magnetometer
 fsl,mc13892		MC13892: Power Management Integrated Circuit (PMIC) for i.MX35/51
 fsl,mma8450		MMA8450Q: Xtrinsic Low-power, 3-axis Xtrinsic Accelerometer
-fsl,mma8452		MMA8452Q: 3-axis 12-bit / 8-bit Digital Accelerometer
 fsl,mpr121		MPR121: Proximity Capacitive Touch Sensor Controller
 fsl,sgtl5000		SGTL5000: Ultra Low-Power Audio Codec
 gmt,g751		G751: Digital Temperature Sensor and Thermal Watchdog with Two-Wire Interface
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
