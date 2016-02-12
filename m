Return-Path: <adriana.reus@intel.com>
From: Adriana Reus <adriana.reus@intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com,
	ggao@invensense.com,
	lars@metafoo.de,
	daniel.baluta@intel.com,
	lucas.de.marchi@gmail.com,
	adi.reus@gmail.com,
	cmo@melexis.com,
	Adriana Reus <adriana.reus@intel.com>
Subject: [PATCH v6 1/4] iio: imu: inv-mpu6050: Fix interrupt pin configuration
Date: Fri, 12 Feb 2016 13:44:42 +0200
Message-Id: <1455277485-19101-2-git-send-email-adriana.reus@intel.com>
In-Reply-To: <1455277485-19101-1-git-send-email-adriana.reus@intel.com>
References: <1455277485-19101-1-git-send-email-adriana.reus@intel.com>
List-ID: <linux-iio@vger.kernel.org>

The select/deselect_bypass duo writes the irq number into the interrupt
configuration register.
If there is a i2c slave device connected to the mpu (eg. a magnetometer)
then this can hinder interrupt delivery for the accelerometer and
gyroscope.
Set this register to the default configuration.

Signed-off-by: Adriana Reus <adriana.reus@intel.com>
---
 No changes

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
