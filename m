Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bl2nam02on0057.outbound.protection.outlook.com ([104.47.38.57]:58912
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751085AbeDQHUR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Apr 2018 03:20:17 -0400
From: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To: linux-iio@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v4 2/2] iio: imu: inv_mpu6050: use set_power_itg function in i2c mux
Date: Tue, 17 Apr 2018 09:19:40 +0200
Message-Id: <1523949580-18016-2-git-send-email-jmaneyrol@invensense.com>
In-Reply-To: <1523949580-18016-1-git-send-email-jmaneyrol@invensense.com>
References: <1523949580-18016-1-git-send-email-jmaneyrol@invensense.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Set power function is rewritten manually inside i2c mux select.
Better use the already identical existing function.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 33 ++++++++++++-------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index f70e7b9..eca34b9 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -29,25 +29,19 @@ static int inv_mpu6050_select_bypass(struct i2c_mux_core *muxc, u32 chan_id)
 {
 	struct iio_dev *indio_dev = i2c_mux_priv(muxc);
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
-	int ret = 0;
+	int ret;
 
-	/* Use the same mutex which was used everywhere to protect power-op */
 	mutex_lock(&st->lock);
-	if (!st->powerup_count) {
-		ret = regmap_write(st->map, st->reg->pwr_mgmt_1, 0);
-		if (ret)
-			goto write_error;
 
-		usleep_range(INV_MPU6050_REG_UP_TIME_MIN,
-			     INV_MPU6050_REG_UP_TIME_MAX);
-	}
-	if (!ret) {
-		st->powerup_count++;
-		ret = regmap_write(st->map, st->reg->int_pin_cfg,
-				   INV_MPU6050_INT_PIN_CFG |
-				   INV_MPU6050_BIT_BYPASS_EN);
-	}
-write_error:
+	ret = inv_mpu6050_set_power_itg(st, true);
+	if (ret)
+		goto error_unlock;
+
+	ret = regmap_write(st->map, st->reg->int_pin_cfg,
+			   INV_MPU6050_INT_PIN_CFG |
+			   INV_MPU6050_BIT_BYPASS_EN);
+
+error_unlock:
 	mutex_unlock(&st->lock);
 
 	return ret;
@@ -59,12 +53,11 @@ static int inv_mpu6050_deselect_bypass(struct i2c_mux_core *muxc, u32 chan_id)
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->lock);
+
 	/* It doesn't really mattter, if any of the calls fails */
 	regmap_write(st->map, st->reg->int_pin_cfg, INV_MPU6050_INT_PIN_CFG);
-	st->powerup_count--;
-	if (!st->powerup_count)
-		regmap_write(st->map, st->reg->pwr_mgmt_1,
-			     INV_MPU6050_BIT_SLEEP);
+	inv_mpu6050_set_power_itg(st, false);
+
 	mutex_unlock(&st->lock);
 
 	return 0;
-- 
2.7.4

