Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:23109 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750976AbcBJOmz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 10 Feb 2016 09:42:55 -0500
From: Adriana Reus <adriana.reus@intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
	ggao@invensense.com, mwelling@ieee.org, lars@metafoo.de,
	lucas.de.marchi@gmail.com, daniel.baluta@intel.com,
	adi.reus@gmail.com, cmo@melexis.com,
	Adriana Reus <adriana.reus@intel.com>
Subject: [PATCH v4 2/4] iio: imu: inv_mpu6050: Use regmap instead of i2c specific functions
Date: Wed, 10 Feb 2016 16:41:41 +0200
Message-Id: <1455115303-16008-3-git-send-email-adriana.reus@intel.com>
In-Reply-To: <1455115303-16008-1-git-send-email-adriana.reus@intel.com>
References: <1455115303-16008-1-git-send-email-adriana.reus@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use regmap instead of i2c specific functions.
This is in preparation of splitting this driver into core and
i2c specific functionality.

Signed-off-by: Adriana Reus <adriana.reus@intel.com>
Acked-by: Crt Mori <cmo@melexis.com>
---
 * No changes since v3
 drivers/iio/imu/inv_mpu6050/Kconfig           |  1 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 71 ++++++++++++++-------------
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  2 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 30 ++++++-----
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  6 +--
 5 files changed, 57 insertions(+), 53 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
index 48fbc0b..f301f3a 100644
--- a/drivers/iio/imu/inv_mpu6050/Kconfig
+++ b/drivers/iio/imu/inv_mpu6050/Kconfig
@@ -8,6 +8,7 @@ config INV_MPU6050_IIO
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	select I2C_MUX
+	select REGMAP_I2C
 	help
 	  This driver supports the Invensense MPU6050 devices.
 	  This driver can also support MPU6500 in MPU6050 compatibility mode
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 1121f4e..151a378 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -27,6 +27,11 @@
 #include <linux/acpi.h>
 #include "inv_mpu_iio.h"
 
+static const struct regmap_config inv_mpu_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
 /*
  * this is the gyro scale translated from dynamic range plus/minus
  * {250, 500, 1000, 2000} to rad/s
@@ -75,11 +80,6 @@ static const struct inv_mpu6050_hw hw_info[INV_NUM_PARTS] = {
 	},
 };
 
-int inv_mpu6050_write_reg(struct inv_mpu6050_state *st, int reg, u8 d)
-{
-	return i2c_smbus_write_i2c_block_data(st->client, reg, 1, &d);
-}
-
 /*
  * The i2c read/write needs to happen in unlocked mode. As the parent
  * adapter is common. If we use locked versions, it will fail as
@@ -159,16 +159,15 @@ static int inv_mpu6050_deselect_bypass(struct i2c_adapter *adap,
 
 int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask)
 {
-	u8 d, mgmt_1;
+	unsigned int d, mgmt_1;
 	int result;
 
 	/* switch clock needs to be careful. Only when gyro is on, can
 	   clock source be switched to gyro. Otherwise, it must be set to
 	   internal clock */
 	if (INV_MPU6050_BIT_PWR_GYRO_STBY == mask) {
-		result = i2c_smbus_read_i2c_block_data(st->client,
-				       st->reg->pwr_mgmt_1, 1, &mgmt_1);
-		if (result != 1)
+		result = regmap_read(st->map, st->reg->pwr_mgmt_1, &mgmt_1);
+		if (result)
 			return result;
 
 		mgmt_1 &= ~INV_MPU6050_BIT_CLK_MASK;
@@ -178,20 +177,19 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask)
 		/* turning off gyro requires switch to internal clock first.
 		   Then turn off gyro engine */
 		mgmt_1 |= INV_CLK_INTERNAL;
-		result = inv_mpu6050_write_reg(st, st->reg->pwr_mgmt_1, mgmt_1);
+		result = regmap_write(st->map, st->reg->pwr_mgmt_1, mgmt_1);
 		if (result)
 			return result;
 	}
 
-	result = i2c_smbus_read_i2c_block_data(st->client,
-				       st->reg->pwr_mgmt_2, 1, &d);
-	if (result != 1)
+	result = regmap_read(st->map, st->reg->pwr_mgmt_2, &d);
+	if (result)
 		return result;
 	if (en)
 		d &= ~mask;
 	else
 		d |= mask;
-	result = inv_mpu6050_write_reg(st, st->reg->pwr_mgmt_2, d);
+	result = regmap_write(st->map, st->reg->pwr_mgmt_2, d);
 	if (result)
 		return result;
 
@@ -201,7 +199,7 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask)
 		if (INV_MPU6050_BIT_PWR_GYRO_STBY == mask) {
 			/* switch internal clock to PLL */
 			mgmt_1 |= INV_CLK_PLL;
-			result = inv_mpu6050_write_reg(st,
+			result = regmap_write(st->map,
 					st->reg->pwr_mgmt_1, mgmt_1);
 			if (result)
 				return result;
@@ -218,15 +216,14 @@ int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on)
 	if (power_on) {
 		/* Already under indio-dev->mlock mutex */
 		if (!st->powerup_count)
-			result = inv_mpu6050_write_reg(st, st->reg->pwr_mgmt_1,
-						       0);
+			result = regmap_write(st->map, st->reg->pwr_mgmt_1, 0);
 		if (!result)
 			st->powerup_count++;
 	} else {
 		st->powerup_count--;
 		if (!st->powerup_count)
-			result = inv_mpu6050_write_reg(st, st->reg->pwr_mgmt_1,
-						       INV_MPU6050_BIT_SLEEP);
+			result = regmap_write(st->map, st->reg->pwr_mgmt_1,
+					      INV_MPU6050_BIT_SLEEP);
 	}
 
 	if (result)
@@ -257,22 +254,22 @@ static int inv_mpu6050_init_config(struct iio_dev *indio_dev)
 	if (result)
 		return result;
 	d = (INV_MPU6050_FSR_2000DPS << INV_MPU6050_GYRO_CONFIG_FSR_SHIFT);
-	result = inv_mpu6050_write_reg(st, st->reg->gyro_config, d);
+	result = regmap_write(st->map, st->reg->gyro_config, d);
 	if (result)
 		return result;
 
 	d = INV_MPU6050_FILTER_20HZ;
-	result = inv_mpu6050_write_reg(st, st->reg->lpf, d);
+	result = regmap_write(st->map, st->reg->lpf, d);
 	if (result)
 		return result;
 
 	d = INV_MPU6050_ONE_K_HZ / INV_MPU6050_INIT_FIFO_RATE - 1;
-	result = inv_mpu6050_write_reg(st, st->reg->sample_rate_div, d);
+	result = regmap_write(st->map, st->reg->sample_rate_div, d);
 	if (result)
 		return result;
 
 	d = (INV_MPU6050_FS_02G << INV_MPU6050_ACCL_CONFIG_FSR_SHIFT);
-	result = inv_mpu6050_write_reg(st, st->reg->accl_config, d);
+	result = regmap_write(st->map, st->reg->accl_config, d);
 	if (result)
 		return result;
 
@@ -290,9 +287,8 @@ static int inv_mpu6050_sensor_show(struct inv_mpu6050_state  *st, int reg,
 	__be16 d;
 
 	ind = (axis - IIO_MOD_X) * 2;
-	result = i2c_smbus_read_i2c_block_data(st->client, reg + ind,  2,
-						(u8 *)&d);
-	if (result != 2)
+	result = regmap_bulk_read(st->map, reg + ind, (u8 *)&d, 2);
+	if (result)
 		return -EINVAL;
 	*val = (short)be16_to_cpup(&d);
 
@@ -418,8 +414,7 @@ static int inv_mpu6050_write_gyro_scale(struct inv_mpu6050_state *st, int val)
 	for (i = 0; i < ARRAY_SIZE(gyro_scale_6050); ++i) {
 		if (gyro_scale_6050[i] == val) {
 			d = (i << INV_MPU6050_GYRO_CONFIG_FSR_SHIFT);
-			result = inv_mpu6050_write_reg(st,
-					st->reg->gyro_config, d);
+			result = regmap_write(st->map, st->reg->gyro_config, d);
 			if (result)
 				return result;
 
@@ -456,8 +451,7 @@ static int inv_mpu6050_write_accel_scale(struct inv_mpu6050_state *st, int val)
 	for (i = 0; i < ARRAY_SIZE(accel_scale); ++i) {
 		if (accel_scale[i] == val) {
 			d = (i << INV_MPU6050_ACCL_CONFIG_FSR_SHIFT);
-			result = inv_mpu6050_write_reg(st,
-					st->reg->accl_config, d);
+			result = regmap_write(st->map, st->reg->accl_config, d);
 			if (result)
 				return result;
 
@@ -537,7 +531,7 @@ static int inv_mpu6050_set_lpf(struct inv_mpu6050_state *st, int rate)
 	while ((h < hz[i]) && (i < ARRAY_SIZE(d) - 1))
 		i++;
 	data = d[i];
-	result = inv_mpu6050_write_reg(st, st->reg->lpf, data);
+	result = regmap_write(st->map, st->reg->lpf, data);
 	if (result)
 		return result;
 	st->chip_config.lpf = data;
@@ -575,7 +569,7 @@ static ssize_t inv_mpu6050_fifo_rate_store(struct device *dev,
 		goto fifo_rate_fail;
 
 	d = INV_MPU6050_ONE_K_HZ / fifo_rate - 1;
-	result = inv_mpu6050_write_reg(st, st->reg->sample_rate_div, d);
+	result = regmap_write(st->map, st->reg->sample_rate_div, d);
 	if (result)
 		goto fifo_rate_fail;
 	st->chip_config.fifo_rate = fifo_rate;
@@ -736,8 +730,8 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
 	st->reg = hw_info[st->chip_type].reg;
 
 	/* reset to make sure previous state are not there */
-	result = inv_mpu6050_write_reg(st, st->reg->pwr_mgmt_1,
-					INV_MPU6050_BIT_H_RESET);
+	result = regmap_write(st->map, st->reg->pwr_mgmt_1,
+			      INV_MPU6050_BIT_H_RESET);
 	if (result)
 		return result;
 	msleep(INV_MPU6050_POWER_UP_TIME);
@@ -778,11 +772,19 @@ static int inv_mpu_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	struct inv_mpu6050_platform_data *pdata;
 	int result;
+	struct regmap *regmap;
 
 	if (!i2c_check_functionality(client->adapter,
 		I2C_FUNC_SMBUS_I2C_BLOCK))
 		return -ENOSYS;
 
+	regmap = devm_regmap_init_i2c(client, &inv_mpu_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
+			(int)PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -790,6 +792,7 @@ static int inv_mpu_probe(struct i2c_client *client,
 	st = iio_priv(indio_dev);
 	st->client = client;
 	st->powerup_count = 0;
+	st->map = regmap;
 	pdata = dev_get_platdata(&client->dev);
 	if (pdata)
 		st->plat_data = *pdata;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 455b99d..469cd1f 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -15,6 +15,7 @@
 #include <linux/spinlock.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
+#include <linux/regmap.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/trigger.h>
@@ -125,6 +126,7 @@ struct inv_mpu6050_state {
 	unsigned int powerup_count;
 	struct inv_mpu6050_platform_data plat_data;
 	DECLARE_KFIFO(timestamps, long long, TIMESTAMP_FIFO_SIZE);
+	struct regmap *map;
 };
 
 /*register and associated bit definition*/
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index ba27e27..eb19dae 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -13,7 +13,6 @@
 
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/i2c.h>
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/sysfs.h>
@@ -41,22 +40,22 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
 	struct inv_mpu6050_state  *st = iio_priv(indio_dev);
 
 	/* disable interrupt */
-	result = inv_mpu6050_write_reg(st, st->reg->int_enable, 0);
+	result = regmap_write(st->map, st->reg->int_enable, 0);
 	if (result) {
 		dev_err(&st->client->dev, "int_enable failed %d\n", result);
 		return result;
 	}
 	/* disable the sensor output to FIFO */
-	result = inv_mpu6050_write_reg(st, st->reg->fifo_en, 0);
+	result = regmap_write(st->map, st->reg->fifo_en, 0);
 	if (result)
 		goto reset_fifo_fail;
 	/* disable fifo reading */
-	result = inv_mpu6050_write_reg(st, st->reg->user_ctrl, 0);
+	result = regmap_write(st->map, st->reg->user_ctrl, 0);
 	if (result)
 		goto reset_fifo_fail;
 
 	/* reset FIFO*/
-	result = inv_mpu6050_write_reg(st, st->reg->user_ctrl,
+	result = regmap_write(st->map, st->reg->user_ctrl,
 					INV_MPU6050_BIT_FIFO_RST);
 	if (result)
 		goto reset_fifo_fail;
@@ -67,13 +66,13 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
 	/* enable interrupt */
 	if (st->chip_config.accl_fifo_enable ||
 	    st->chip_config.gyro_fifo_enable) {
-		result = inv_mpu6050_write_reg(st, st->reg->int_enable,
+		result = regmap_write(st->map, st->reg->int_enable,
 					INV_MPU6050_BIT_DATA_RDY_EN);
 		if (result)
 			return result;
 	}
 	/* enable FIFO reading and I2C master interface*/
-	result = inv_mpu6050_write_reg(st, st->reg->user_ctrl,
+	result = regmap_write(st->map, st->reg->user_ctrl,
 					INV_MPU6050_BIT_FIFO_EN);
 	if (result)
 		goto reset_fifo_fail;
@@ -83,7 +82,7 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
 		d |= INV_MPU6050_BITS_GYRO_OUT;
 	if (st->chip_config.accl_fifo_enable)
 		d |= INV_MPU6050_BIT_ACCEL_OUT;
-	result = inv_mpu6050_write_reg(st, st->reg->fifo_en, d);
+	result = regmap_write(st->map, st->reg->fifo_en, d);
 	if (result)
 		goto reset_fifo_fail;
 
@@ -91,7 +90,7 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
 
 reset_fifo_fail:
 	dev_err(&st->client->dev, "reset fifo failed %d\n", result);
-	result = inv_mpu6050_write_reg(st, st->reg->int_enable,
+	result = regmap_write(st->map, st->reg->int_enable,
 					INV_MPU6050_BIT_DATA_RDY_EN);
 
 	return result;
@@ -143,10 +142,10 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	 * read fifo_count register to know how many bytes inside FIFO
 	 * right now
 	 */
-	result = i2c_smbus_read_i2c_block_data(st->client,
+	result = regmap_bulk_read(st->map,
 				       st->reg->fifo_count_h,
-				       INV_MPU6050_FIFO_COUNT_BYTE, data);
-	if (result != INV_MPU6050_FIFO_COUNT_BYTE)
+				       data, INV_MPU6050_FIFO_COUNT_BYTE);
+	if (result)
 		goto end_session;
 	fifo_count = be16_to_cpup((__be16 *)(&data[0]));
 	if (fifo_count < bytes_per_datum)
@@ -161,10 +160,9 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 		fifo_count / bytes_per_datum + INV_MPU6050_TIME_STAMP_TOR)
 			goto flush_fifo;
 	while (fifo_count >= bytes_per_datum) {
-		result = i2c_smbus_read_i2c_block_data(st->client,
-						       st->reg->fifo_r_w,
-						       bytes_per_datum, data);
-		if (result != bytes_per_datum)
+		result = regmap_bulk_read(st->map, st->reg->fifo_r_w,
+					  data, bytes_per_datum);
+		if (result)
 			goto flush_fifo;
 
 		result = kfifo_out(&st->timestamps, &timestamp, 1);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index 844610c..ee9e66d 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -65,15 +65,15 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
 		if (result)
 			return result;
 	} else {
-		result = inv_mpu6050_write_reg(st, st->reg->fifo_en, 0);
+		result = regmap_write(st->map, st->reg->fifo_en, 0);
 		if (result)
 			return result;
 
-		result = inv_mpu6050_write_reg(st, st->reg->int_enable, 0);
+		result = regmap_write(st->map, st->reg->int_enable, 0);
 		if (result)
 			return result;
 
-		result = inv_mpu6050_write_reg(st, st->reg->user_ctrl, 0);
+		result = regmap_write(st->map, st->reg->user_ctrl, 0);
 		if (result)
 			return result;
 
-- 
1.9.1

