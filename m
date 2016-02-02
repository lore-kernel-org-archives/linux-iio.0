Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51430 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932583AbcBBPEh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 2 Feb 2016 10:04:37 -0500
From: Adriana Reus <adriana.reus@intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
	ggao@invensense.com, Adriana Reus <adriana.reus@intel.com>
Subject: [PATCH v1 1/4] iio: imu: inv-mpu6050: Fix interrupt pin configuration
Date: Tue,  2 Feb 2016 17:02:15 +0200
Message-Id: <1454425338-17674-2-git-send-email-adriana.reus@intel.com>
In-Reply-To: <1454425338-17674-1-git-send-email-adriana.reus@intel.com>
References: <1454425338-17674-1-git-send-email-adriana.reus@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The select/deselect_bypass duo writes the irq number into the interrupt
configuration register.
If there is a i2c slave device connected to the mpu (eg. a magnetometer)
then this can hinder interrupt delivery for the accelerometer and
gyroscope.
Set this register to the default configuration.

Signed-off-by: Adriana Reus <adriana.reus@intel.com>
---
 * No change since the previous submitted version

 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 4 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 0852b7f..1121f4e 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -129,7 +129,7 @@ static int inv_mpu6050_select_bypass(struct i2c_adapter *adap, void *mux_priv,
 	if (!ret) {
 		st->powerup_count++;
 		ret = inv_mpu6050_write_reg_unlocked(st, st->reg->int_pin_cfg,
-						     st->client->irq |
+						     INV_MPU6050_INT_PIN_CFG |
 						     INV_MPU6050_BIT_BYPASS_EN);
 	}
 write_error:
@@ -147,7 +147,7 @@ static int inv_mpu6050_deselect_bypass(struct i2c_adapter *adap,
 	mutex_lock(&indio_dev->mlock);
 	/* It doesn't really mattter, if any of the calls fails */
 	inv_mpu6050_write_reg_unlocked(st, st->reg->int_pin_cfg,
-				       st->client->irq);
+				       INV_MPU6050_INT_PIN_CFG);
 	st->powerup_count--;
 	if (!st->powerup_count)
 		inv_mpu6050_write_reg_unlocked(st, st->reg->pwr_mgmt_1,
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index db0a4a2..455b99d 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -185,6 +185,7 @@ struct inv_mpu6050_state {
 
 #define INV_MPU6050_REG_INT_PIN_CFG	0x37
 #define INV_MPU6050_BIT_BYPASS_EN	0x2
+#define INV_MPU6050_INT_PIN_CFG		0
 
 /* init parameters */
 #define INV_MPU6050_INIT_FIFO_RATE           50
-- 
1.9.1

