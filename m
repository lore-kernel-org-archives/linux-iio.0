Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38779 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752672AbcCCDSH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 2 Mar 2016 22:18:07 -0500
From: Matt Ranostay <matt.ranostay@intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, dan.carpenter@oracle.com,
	Matt Ranostay <matt.ranostay@intel.com>
Subject: [PATCH] iio: imu: mpu6050: fix possible NULL dereferences
Date: Wed,  2 Mar 2016 19:18:12 -0800
Message-Id: <1456975092-17992-1-git-send-email-matt.ranostay@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix possible null dereferencing of i2c and spi driver data.

Signed-off-by: Matt Ranostay <matt.ranostay@intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 3 ++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index f581256d9d4c..d0c0e20c7122 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -117,6 +117,7 @@ static int inv_mpu_probe(struct i2c_client *client,
 	struct inv_mpu6050_state *st;
 	int result;
 	const char *name = id ? id->name : NULL;
+	const int chip_type = id ? id->driver_data : 0;
 	struct regmap *regmap;
 
 	if (!i2c_check_functionality(client->adapter,
@@ -131,7 +132,7 @@ static int inv_mpu_probe(struct i2c_client *client,
 	}
 
 	result = inv_mpu_core_probe(regmap, client->irq, name,
-				    NULL, id->driver_data);
+				    NULL, chip_type);
 	if (result < 0)
 		return result;
 
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
index dea6c4361de0..7bcb8d839f05 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -46,6 +46,7 @@ static int inv_mpu_probe(struct spi_device *spi)
 	struct regmap *regmap;
 	const struct spi_device_id *id = spi_get_device_id(spi);
 	const char *name = id ? id->name : NULL;
+	const int chip_type = id ? id->driver_data : 0;
 
 	regmap = devm_regmap_init_spi(spi, &inv_mpu_regmap_config);
 	if (IS_ERR(regmap)) {
@@ -55,7 +56,7 @@ static int inv_mpu_probe(struct spi_device *spi)
 	}
 
 	return inv_mpu_core_probe(regmap, spi->irq, name,
-				  inv_mpu_i2c_disable, id->driver_data);
+				  inv_mpu_i2c_disable, chip_type);
 }
 
 static int inv_mpu_remove(struct spi_device *spi)
-- 
1.9.1

