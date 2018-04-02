Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36396 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754516AbeDBWma (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Apr 2018 18:42:30 -0400
Received: by mail-qk0-f196.google.com with SMTP id o205so16723528qke.3
        for <linux-iio@vger.kernel.org>; Mon, 02 Apr 2018 15:42:29 -0700 (PDT)
Date: Mon, 2 Apr 2018 18:42:00 -0400
From: Douglas Fischer <fischerdouglasc@gmail.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Subject: [PATCH] iio: imu: Add mpu9255 support to mpu6050 driver
Message-ID: <20180402184200.0aa65204@Constantine>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added support for the mpu9255 IMU to the mpu6050 driver. The
register map is the same as the other chips; the only driver
difference is the compatible string and the WHOAMI register
value.

Signed-off-by: Douglas Fischer <fischerdouglasc@gmail.com>
---

diff -uprN linux-4.16.orig/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt linux-4.16/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
--- linux-4.16.orig/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt	2018-04-01 17:20:27.000000000 -0400
+++ linux-4.16/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt	2018-04-02 18:31:38.342464417 -0400
@@ -8,6 +8,7 @@ Required properties:
  		"invensense,mpu6500"
 		"invensense,mpu9150"
 		"invensense,mpu9250"
+		"invensense,mpu9255"
 		"invensense,icm20608"
  - reg : the I2C address of the sensor
  - interrupt-parent : should be the phandle for the interrupt controller
diff -uprN linux-4.16.orig/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c linux-4.16/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
--- linux-4.16.orig/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c	2018-04-01 17:20:27.000000000 -0400
+++ linux-4.16/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c	2018-04-02 18:31:38.345464417 -0400
@@ -121,6 +121,12 @@ static const struct inv_mpu6050_hw hw_in
 		.config = &chip_config_6050,
 	},
 	{
+		.whoami = INV_MPU9255_WHOAMI_VALUE,
+		.name = "MPU9255",
+		.reg = &reg_set_6500,
+		.config = &chip_config_6050,
+	},
+	{
 		.whoami = INV_ICM20608_WHOAMI_VALUE,
 		.name = "ICM20608",
 		.reg = &reg_set_6500,
diff -uprN linux-4.16.orig/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c linux-4.16/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
--- linux-4.16.orig/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c	2018-04-01 17:20:27.000000000 -0400
+++ linux-4.16/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c	2018-04-02 18:31:38.348464417 -0400
@@ -179,6 +179,7 @@ static const struct i2c_device_id inv_mp
 	{"mpu6500", INV_MPU6500},
 	{"mpu9150", INV_MPU9150},
 	{"mpu9250", INV_MPU9250},
+	{"mpu9255", INV_MPU9255},
 	{"icm20608", INV_ICM20608},
 	{}
 };
@@ -203,6 +204,10 @@ static const struct of_device_id inv_of_
 		.data = (void *)INV_MPU9250
 	},
 	{
+		.compatible = "invensense,mpu9255",
+		.data = (void *)INV_MPU9255
+	},
+	{
 		.compatible = "invensense,icm20608",
 		.data = (void *)INV_ICM20608
 	},
diff -uprN linux-4.16.orig/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h linux-4.16/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
--- linux-4.16.orig/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h	2018-04-01 17:20:27.000000000 -0400
+++ linux-4.16/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h	2018-04-02 18:31:38.351464416 -0400
@@ -74,6 +74,7 @@ enum inv_devices {
 	INV_MPU6000,
 	INV_MPU9150,
 	INV_MPU9250,
+	INV_MPU9255,
 	INV_ICM20608,
 	INV_NUM_PARTS
 };
@@ -232,6 +233,7 @@ struct inv_mpu6050_state {
 #define INV_MPU6500_WHOAMI_VALUE		0x70
 #define INV_MPU9150_WHOAMI_VALUE		0x68
 #define INV_MPU9250_WHOAMI_VALUE		0x71
+#define INV_MPU9255_WHOAMI_VALUE		0x73
 #define INV_ICM20608_WHOAMI_VALUE		0xAF
 
 /* scan element definition */
diff -uprN linux-4.16.orig/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c linux-4.16/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
--- linux-4.16.orig/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c	2018-04-01 17:20:27.000000000 -0400
+++ linux-4.16/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c	2018-04-02 18:31:38.356464416 -0400
@@ -83,6 +83,7 @@ static const struct spi_device_id inv_mp
 	{"mpu6500", INV_MPU6500},
 	{"mpu9150", INV_MPU9150},
 	{"mpu9250", INV_MPU9250},
+	{"mpu9255", INV_MPU9255},
 	{"icm20608", INV_ICM20608},
 	{}
 };
