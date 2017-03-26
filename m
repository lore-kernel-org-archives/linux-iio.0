Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49613 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbdCZLLe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Mar 2017 07:11:34 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mark.Rutland@arm.com, robh+dt@kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/2] iio:imu:mpu6050 add explicit mpu9250 support
Date: Sun, 26 Mar 2017 12:11:00 +0100
Message-Id: <20170326111100.2571-3-jic23@kernel.org>
In-Reply-To: <20170326111100.2571-1-jic23@kernel.org>
References: <20170326111100.2571-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The mpu9250 is a SIP containing an mpu6500 and an ak8975.  If this was all
there was too it there would be no need for explicit handling in the driver.
Arguably the bindings would also only reflect the presence of an mpu6500 with
the ak8975 hanging off it, as the kernel doesn't care that they are in one
package.

However, the WHOAMI value changes as well so best to add explicit support.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt | 2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c                | 6 ++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c                 | 5 +++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h                 | 2 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c                 | 1 +
 5 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
index e18e04f3c6f4..10c1abdcc34d 100644
--- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
+++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
@@ -4,7 +4,7 @@ http://www.invensense.com/mems/gyro/mpu6050.html
 
 Required properties:
  - compatible : should be "invensense,mpu6050", "invensense,mpu6500",
-   "invensense,mpu9150" or "invensense,icm20608"
+   "invensense,mpu9150", "invensense,mpu9250" or "invensense,icm20608"
  - reg : the I2C address of the sensor
  - interrupt-parent : should be the phandle for the interrupt controller
  - interrupts : interrupt mapping for GPIO IRQ
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index b9fcbf18aa99..96dabbd2f004 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -114,6 +114,12 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.config = &chip_config_6050,
 	},
 	{
+		.whoami = INV_MPU9250_WHOAMI_VALUE,
+		.name = "MPU9250",
+		.reg = &reg_set_6500,
+		.config = &chip_config_6050,
+	},
+	{
 		.whoami = INV_ICM20608_WHOAMI_VALUE,
 		.name = "ICM20608",
 		.reg = &reg_set_6500,
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index a8e6330cb906..64b5f5b92200 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -178,6 +178,7 @@ static const struct i2c_device_id inv_mpu_id[] = {
 	{"mpu6050", INV_MPU6050},
 	{"mpu6500", INV_MPU6500},
 	{"mpu9150", INV_MPU9150},
+	{"mpu9250", INV_MPU9250},
 	{"icm20608", INV_ICM20608},
 	{}
 };
@@ -198,6 +199,10 @@ static const struct of_device_id inv_of_match[] = {
 		.data = (void *)INV_MPU9150
 	},
 	{
+		.compatible = "invensense,mpu9250",
+		.data = (void *)INV_MPU9250
+	},
+	{
 		.compatible = "invensense,icm20608",
 		.data = (void *)INV_ICM20608
 	},
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index f0e8c5dd9fae..ef13de7a2c20 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -70,6 +70,7 @@ enum inv_devices {
 	INV_MPU6500,
 	INV_MPU6000,
 	INV_MPU9150,
+	INV_MPU9250,
 	INV_ICM20608,
 	INV_NUM_PARTS
 };
@@ -226,6 +227,7 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_WHOAMI_VALUE		0x68
 #define INV_MPU6500_WHOAMI_VALUE		0x70
 #define INV_MPU9150_WHOAMI_VALUE		0x68
+#define INV_MPU9250_WHOAMI_VALUE		0x71
 #define INV_ICM20608_WHOAMI_VALUE		0xAF
 
 /* scan element definition */
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
index 6e6476dfa188..74506e5ac0db 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -82,6 +82,7 @@ static const struct spi_device_id inv_mpu_id[] = {
 	{"mpu6000", INV_MPU6000},
 	{"mpu6500", INV_MPU6500},
 	{"mpu9150", INV_MPU9150},
+	{"mpu9250", INV_MPU9250},
 	{"icm20608", INV_ICM20608},
 	{}
 };
-- 
2.12.0

