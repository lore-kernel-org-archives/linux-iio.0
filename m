Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46766 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754155AbcDTNPd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 20 Apr 2016 09:15:33 -0400
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [PATCH 2/5] iio: inv_mpu6050: Remove inv_mpu6050_hw.num_reg
Date: Wed, 20 Apr 2016 16:15:10 +0300
Message-Id: <a6476cd8bc1c6493e93a17174ff6339668130d48.1461156671.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1461156671.git.leonard.crestez@intel.com>
References: <cover.1461156671.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1461156671.git.leonard.crestez@intel.com>
References: <cover.1461156671.git.leonard.crestez@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This field was unused and incorrect for mpu6500.

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 3 ---
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 2 --
 2 files changed, 5 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 52e62b3..faccabafc 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -91,19 +91,16 @@ static const struct inv_mpu6050_chip_config chip_config_6050 = {
 /* Indexed by enum inv_devices */
 static const struct inv_mpu6050_hw hw_info[] = {
 	{
-		.num_reg = 117,
 		.name = "MPU6050",
 		.reg = &reg_set_6050,
 		.config = &chip_config_6050,
 	},
 	{
-		.num_reg = 117,
 		.name = "MPU6500",
 		.reg = &reg_set_6500,
 		.config = &chip_config_6050,
 	},
 	{
-		.num_reg = 117,
 		.name = "MPU6000",
 		.reg = &reg_set_6050,
 		.config = &chip_config_6050,
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index e302a49..c66dbfc 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -93,13 +93,11 @@ struct inv_mpu6050_chip_config {
 
 /**
  *  struct inv_mpu6050_hw - Other important hardware information.
- *  @num_reg:	Number of registers on device.
  *  @name:      name of the chip.
  *  @reg:   register map of the chip.
  *  @config:    configuration of the chip.
  */
 struct inv_mpu6050_hw {
-	u8 num_reg;
 	u8 *name;
 	const struct inv_mpu6050_reg_map *reg;
 	const struct inv_mpu6050_chip_config *config;
-- 
2.5.5

