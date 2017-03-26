Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49610 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751271AbdCZLLd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Mar 2017 07:11:33 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mark.Rutland@arm.com, robh+dt@kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 1/2] iio:imu:mpu6050 update i2c bindings to reflect i2c-gate and supported parts
Date: Sun, 26 Mar 2017 12:10:59 +0100
Message-Id: <20170326111100.2571-2-jic23@kernel.org>
In-Reply-To: <20170326111100.2571-1-jic23@kernel.org>
References: <20170326111100.2571-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These bindings are somewhat lagging the state of the driver.  The i2c-gate
bindings are documented elsewhere, but it seems sensible to at least have
an example and cross reference in here.  SPI bindings will need to be the
subject of a future patch.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 .../devicetree/bindings/iio/imu/inv_mpu6050.txt    | 23 ++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
index a9fc11e43b45..e18e04f3c6f4 100644
--- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
+++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
@@ -3,14 +3,17 @@ InvenSense MPU-6050 Six-Axis (Gyro + Accelerometer) MEMS MotionTracking Device
 http://www.invensense.com/mems/gyro/mpu6050.html
 
 Required properties:
- - compatible : should be "invensense,mpu6050"
+ - compatible : should be "invensense,mpu6050", "invensense,mpu6500",
+   "invensense,mpu9150" or "invensense,icm20608"
  - reg : the I2C address of the sensor
  - interrupt-parent : should be the phandle for the interrupt controller
  - interrupts : interrupt mapping for GPIO IRQ
 
 Optional properties:
  - mount-matrix: an optional 3x3 mounting rotation matrix
-
+ - i2c-gate node.  These devices also support an auxiliary i2c bus.  This is
+   simple enough to be described using the i2c-gate binding. See
+   i2c/i2c-gate.txt for more details.
 
 Example:
 	mpu6050@68 {
@@ -28,3 +31,19 @@ Example:
 		               "0",                   /* y2 */
 		               "0.984807753012208";   /* z2 */
 	};
+
+
+	mpu9250@68 {
+		compatible = "invensense,mpu9250";
+		reg = <0x68>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <21 1>;
+		i2c-gate {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ax8975@c {
+				compatible = "ak,ak8975";
+				reg = <0x0c>;
+			};
+		};
+	};
-- 
2.12.0

