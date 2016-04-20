Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46766 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753910AbcDTNPa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 20 Apr 2016 09:15:30 -0400
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [PATCH 1/5] iio: inv_mpu6050: Cleanup hw_info mapping
Date: Wed, 20 Apr 2016 16:15:09 +0300
Message-Id: <d5a4a668fae77d35cd8567570651f7c57e8bb2df.1461156671.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1461156671.git.leonard.crestez@intel.com>
References: <cover.1461156671.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1461156671.git.leonard.crestez@intel.com>
References: <cover.1461156671.git.leonard.crestez@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The hw_info array was indexed by enum inv_devices chip_type despite the
fact that the enumeration had more members than the array and was
ordered differently.

The patch cleans this up and adds explicit chip_types to i2c/spi/acpi
IDs. It also adds some stricter checks inside the driver core.

This happened to work so far because the differences between the
supported models are very minor.

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 15 ++++++++++++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  |  2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  | 18 ++++++++++++++----
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index d192953..52e62b3 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -88,16 +88,23 @@ static const struct inv_mpu6050_chip_config chip_config_6050 = {
 	.accl_fs = INV_MPU6050_FS_02G,
 };
 
+/* Indexed by enum inv_devices */
 static const struct inv_mpu6050_hw hw_info[] = {
 	{
 		.num_reg = 117,
+		.name = "MPU6050",
+		.reg = &reg_set_6050,
+		.config = &chip_config_6050,
+	},
+	{
+		.num_reg = 117,
 		.name = "MPU6500",
 		.reg = &reg_set_6500,
 		.config = &chip_config_6050,
 	},
 	{
 		.num_reg = 117,
-		.name = "MPU6050",
+		.name = "MPU6000",
 		.reg = &reg_set_6050,
 		.config = &chip_config_6050,
 	},
@@ -774,6 +781,12 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 	if (!indio_dev)
 		return -ENOMEM;
 
+	BUILD_BUG_ON(ARRAY_SIZE(hw_info) != INV_NUM_PARTS);
+	if (chip_type < 0 || chip_type >= INV_NUM_PARTS) {
+		dev_err(dev, "Bad invensense chip_type=%d name=%s\n",
+				chip_type, name);
+		return -ENODEV;
+	}
 	st = iio_priv(indio_dev);
 	st->chip_type = chip_type;
 	st->powerup_count = 0;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index 5ee4e0d..bb1a7b1 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -208,7 +208,7 @@ static const struct i2c_device_id inv_mpu_id[] = {
 MODULE_DEVICE_TABLE(i2c, inv_mpu_id);
 
 static const struct acpi_device_id inv_acpi_match[] = {
-	{"INVN6500", 0},
+	{"INVN6500", INV_MPU6500},
 	{ },
 };
 
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
index 7bcb8d8..3972a46 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -44,9 +44,19 @@ static int inv_mpu_i2c_disable(struct iio_dev *indio_dev)
 static int inv_mpu_probe(struct spi_device *spi)
 {
 	struct regmap *regmap;
-	const struct spi_device_id *id = spi_get_device_id(spi);
-	const char *name = id ? id->name : NULL;
-	const int chip_type = id ? id->driver_data : 0;
+	const struct spi_device_id *spi_id;
+	const struct acpi_device_id *acpi_id;
+	const char *name = NULL;
+	enum inv_devices chip_type;
+
+	if ((spi_id = spi_get_device_id(spi))) {
+		chip_type = (enum inv_devices)spi_id->driver_data;
+		name = spi_id->name;
+	} else if ((acpi_id = acpi_match_device(spi->dev.driver->acpi_match_table, &spi->dev))) {
+		chip_type = (enum inv_devices)acpi_id->driver_data;
+	} else {
+		return -ENODEV;
+	}
 
 	regmap = devm_regmap_init_spi(spi, &inv_mpu_regmap_config);
 	if (IS_ERR(regmap)) {
@@ -76,7 +86,7 @@ static const struct spi_device_id inv_mpu_id[] = {
 MODULE_DEVICE_TABLE(spi, inv_mpu_id);
 
 static const struct acpi_device_id inv_acpi_match[] = {
-	{"INVN6000", 0},
+	{"INVN6000", INV_MPU6000},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, inv_acpi_match);
-- 
2.5.5

