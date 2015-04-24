Return-Path: <varkabhadram@gmail.com>
From: Varka Bhadram <varkabhadram@gmail.com>
To: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Varka Bhadram <varkab@cdac.in>
Subject: [PATCH iio] imu: inv_mpu6050: adds device tree bindings
Date: Fri, 24 Apr 2015 14:53:07 +0530
Message-Id: <1429867387-10219-1-git-send-email-varkab@cdac.in>
List-ID: <linux-iio@vger.kernel.org>


Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 .../devicetree/bindings/iio/imu/inv_mpu6050.txt    |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt

diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
new file mode 100644
index 0000000..e4d8f1c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
@@ -0,0 +1,17 @@
+InvenSense MPU-6050 Six-Axis (Gyro + Accelerometer) MEMS MotionTracking Device
+
+http://www.invensense.com/mems/gyro/mpu6050.html
+
+Required properties:
+ - compatible : should be "invensense,mpu6050"
+ - reg : the I2C address of the sensor
+ - interrupt-parent : should be the phandle for the interrupt controller
+ - interrupts : interrupt mapping for GPIO IRQ
+
+Example:
+	mpu6050@68 {
+		compatible = "invensense,mpu6050";
+		reg = <0x68>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <18 1>;
+	};
-- 
1.7.9.5
