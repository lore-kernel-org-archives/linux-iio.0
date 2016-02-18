Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32180 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1426605AbcBRPvb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 18 Feb 2016 10:51:31 -0500
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	wsa@the-dreams.de, linux-i2c@vger.kernel.org,
	lucas.demarchi@intel.com, daniel.baluta@intel.com,
	srinivas.pandruvada@linux.intel.com, ggao@invensense.com,
	adi.reus@gmail.com, cmo@melexis.com, mwelling@ieee.org
Subject: [RFC PATCH 9/9] iio: imu: inv_mpu6050: Fix deadlock between i2c adapter lock and mpu lock
Date: Thu, 18 Feb 2016 17:53:14 +0200
Message-Id: <1455810794-3188-10-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com>
References: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Adriana Reus <adriana.reus@intel.com>

This deadlock occurs if the accel/gyro and the sensor on the auxiliary
I2C (in my setup it's an ak8975) are working at the same time.

Scenario:

      T1					T2
     ====				       ====
inv_mpu6050_read_fifo                  aux sensor op (eg. ak8975_read_raw)
        |                                     |
mutex_lock(&indio_dev->mlock)           i2c_transfer
        |                                     |
i2c transaction                         i2c adapter lock
        |                                     |
i2c adapter lock                        i2c_mux_master_xfer
                                              |
                                        inv_mpu6050_select_bypass
                                              |
                                        mutex_lock(&indio_dev->mlock)

When we operate on an mpu sensor the order of locking is mpu lock
followed by the i2c adapter lock. However, when we operate the auxiliary
sensor the order of locking is the other way around.

In order to avoid this enable the bypass mux bit once in the beginning
and remove the select/deselect_bypass functions.

This patch moves the bypass enabling in a separate function
that is called once at probe and removes the functionality from
inv_mpu_select/deselect_bypass.

Another advantage of this approach is that power-wise the mpu chip isn't
powered up at each auxiliary sensor i2c transaction so if only the
compass is used this would be more power efficient.

Signed-off-by: Adriana Reus <adriana.reus@intel.com>
Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 88 ++++++-------------------------
 1 file changed, 15 insertions(+), 73 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index 71bdaa3..8065355 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -25,82 +25,25 @@ static const struct regmap_config inv_mpu_regmap_config = {
 	.val_bits = 8,
 };
 
-/*
- * The i2c read/write needs to happen in unlocked mode. As the parent
- * adapter is common. If we use locked versions, it will fail as
- * the mux adapter will lock the parent i2c adapter, while calling
- * select/deselect functions.
- */
-static int inv_mpu6050_write_reg_unlocked(struct i2c_client *client,
-					  u8 reg, u8 d)
+static int inv_mpu6050_bypass_en(struct iio_dev *indio_dev)
 {
-	int ret;
-	u8 buf[2] = {reg, d};
-	struct i2c_msg msg[1] = {
-		{
-			.addr = client->addr,
-			.flags = 0,
-			.len = sizeof(buf),
-			.buf = buf,
-		}
-	};
-
-	ret = __i2c_transfer(client->adapter, msg, 1);
-	if (ret != 1)
-		return ret;
-
-	return 0;
-}
-
-static int inv_mpu6050_select_bypass(struct i2c_adapter *adap, void *mux_priv,
-				     u32 chan_id)
-{
-	struct i2c_client *client = mux_priv;
-	struct iio_dev *indio_dev = dev_get_drvdata(&client->dev);
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
 	int ret = 0;
 
-	/* Use the same mutex which was used everywhere to protect power-op */
-	mutex_lock(&indio_dev->mlock);
-	if (!st->powerup_count) {
-		ret = inv_mpu6050_write_reg_unlocked(client,
-						     st->reg->pwr_mgmt_1, 0);
-		if (ret)
-			goto write_error;
+	ret = inv_mpu6050_set_power_itg(st, true);
+	if (ret)
+		return ret;
 
-		msleep(INV_MPU6050_REG_UP_TIME);
-	}
-	if (!ret) {
-		st->powerup_count++;
-		ret = inv_mpu6050_write_reg_unlocked(client,
-						     st->reg->int_pin_cfg,
-						     INV_MPU6050_INT_PIN_CFG |
-						     INV_MPU6050_BIT_BYPASS_EN);
+	ret = regmap_write(st->map,
+			   st->reg->int_pin_cfg,
+			   INV_MPU6050_INT_PIN_CFG |
+			   INV_MPU6050_BIT_BYPASS_EN);
+	if (ret) {
+		inv_mpu6050_set_power_itg(st, false);
+		return ret;
 	}
-write_error:
-	mutex_unlock(&indio_dev->mlock);
 
-	return ret;
-}
-
-static int inv_mpu6050_deselect_bypass(struct i2c_adapter *adap,
-				       void *mux_priv, u32 chan_id)
-{
-	struct i2c_client *client = mux_priv;
-	struct iio_dev *indio_dev = dev_get_drvdata(&client->dev);
-	struct inv_mpu6050_state *st = iio_priv(indio_dev);
-
-	mutex_lock(&indio_dev->mlock);
-	/* It doesn't really mattter, if any of the calls fails */
-	inv_mpu6050_write_reg_unlocked(client, st->reg->int_pin_cfg,
-				       INV_MPU6050_INT_PIN_CFG);
-	st->powerup_count--;
-	if (!st->powerup_count)
-		inv_mpu6050_write_reg_unlocked(client, st->reg->pwr_mgmt_1,
-					       INV_MPU6050_BIT_SLEEP);
-	mutex_unlock(&indio_dev->mlock);
-
-	return 0;
+	return inv_mpu6050_set_power_itg(st, false);
 }
 
 /**
@@ -129,7 +72,8 @@ static int inv_mpu_probe(struct i2c_client *client,
 		return PTR_ERR(regmap);
 	}
 
-	result = inv_mpu_core_probe(regmap, client->irq, name, NULL);
+	result = inv_mpu_core_probe(regmap, client->irq, name,
+				    inv_mpu6050_bypass_en);
 	if (result < 0)
 		return result;
 
@@ -137,9 +81,7 @@ static int inv_mpu_probe(struct i2c_client *client,
 	st->mux_adapter = i2c_add_mux_adapter(client->adapter,
 					      &client->dev,
 					      client,
-					      0, 0, 0,
-					      inv_mpu6050_select_bypass,
-					      inv_mpu6050_deselect_bypass);
+					      0, 0, 0, NULL, NULL);
 	if (!st->mux_adapter) {
 		result = -ENODEV;
 		goto out_unreg_device;
-- 
2.5.0

