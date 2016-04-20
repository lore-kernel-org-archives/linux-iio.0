Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46766 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932304AbcDTNPk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 20 Apr 2016 09:15:40 -0400
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [PATCH 5/5] iio: inv_mpu6050: Add explicit support for MPU9150
Date: Wed, 20 Apr 2016 16:15:13 +0300
Message-Id: <cb9b1ec69032c501a4c74d6554c25d336d65ac8e.1461156671.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1461156671.git.leonard.crestez@intel.com>
References: <cover.1461156671.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1461156671.git.leonard.crestez@intel.com>
References: <cover.1461156671.git.leonard.crestez@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This device is a package containing a MPU6050-like sensor and an AK8975
magnetometer. The magnetometer component is supported by the existing
ak8975 driver.

This patch also rephrases the Kconfig descriptions.

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 drivers/iio/imu/inv_mpu6050/Kconfig        | 10 ++++------
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  6 ++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  |  1 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  2 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  |  1 +
 5 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
index a7f557a..c05d474 100644
--- a/drivers/iio/imu/inv_mpu6050/Kconfig
+++ b/drivers/iio/imu/inv_mpu6050/Kconfig
@@ -14,10 +14,8 @@ config INV_MPU6050_I2C
 	select I2C_MUX
 	select REGMAP_I2C
 	help
-	  This driver supports the Invensense MPU6050 devices.
-	  This driver can also support MPU6500 in MPU6050 compatibility mode
-	  and also in MPU6500 mode with some limitations.
-	  It is a gyroscope/accelerometer combo device.
+	  This driver supports the Invensense MPU6050/6500/9150 motion tracking
+	  devices over I2C.
 	  This driver can be built as a module. The module will be called
 	  inv-mpu6050-i2c.
 
@@ -27,7 +25,7 @@ config INV_MPU6050_SPI
 	select INV_MPU6050_IIO
 	select REGMAP_SPI
 	help
-	  This driver supports the Invensense MPU6050 devices.
-	  It is a gyroscope/accelerometer combo device.
+	  This driver supports the Invensense MPU6000/6500/9150 motion tracking
+	  devices over SPI.
 	  This driver can be built as a module. The module will be called
 	  inv-mpu6050-spi.
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 273b7fa7..3a82a49 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -108,6 +108,12 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.reg = &reg_set_6050,
 		.config = &chip_config_6050,
 	},
+	{
+		.whoami = INV_MPU9150_WHOAMI_VALUE,
+		.name = "MPU9150",
+		.reg = &reg_set_6050,
+		.config = &chip_config_6050,
+	},
 };
 
 int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask)
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index bb1a7b1..1a424a6 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -202,6 +202,7 @@ static int inv_mpu_remove(struct i2c_client *client)
 static const struct i2c_device_id inv_mpu_id[] = {
 	{"mpu6050", INV_MPU6050},
 	{"mpu6500", INV_MPU6500},
+	{"mpu9150", INV_MPU9150},
 	{}
 };
 
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 564cabd..38d6a09 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -68,6 +68,7 @@ enum inv_devices {
 	INV_MPU6050,
 	INV_MPU6500,
 	INV_MPU6000,
+	INV_MPU9150,
 	INV_NUM_PARTS
 };
 
@@ -220,6 +221,7 @@ struct inv_mpu6050_state {
 #define INV_MPU6000_WHOAMI_VALUE		0x68
 #define INV_MPU6050_WHOAMI_VALUE		0x68
 #define INV_MPU6500_WHOAMI_VALUE		0x70
+#define INV_MPU9150_WHOAMI_VALUE		0x68
 
 /* scan element definition */
 enum inv_mpu6050_scan {
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
index a0f8df2..190a4a5 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -81,6 +81,7 @@ static int inv_mpu_remove(struct spi_device *spi)
 static const struct spi_device_id inv_mpu_id[] = {
 	{"mpu6000", INV_MPU6000},
 	{"mpu6500", INV_MPU6500},
+	{"mpu9150", INV_MPU9150},
 	{}
 };
 
-- 
2.5.5

