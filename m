Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-sn1nam01on0080.outbound.protection.outlook.com ([104.47.32.80]:18380
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756353AbeEAR5H (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 1 May 2018 13:57:07 -0400
From: Martin Kelly <mkelly@xevo.com>
To: linux-iio@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Martin Kelly <mkelly@xevo.com>
Subject: [PATCH 1/2] iio: imu: inv_mpu6050: minor wording fixes
Date: Tue,  1 May 2018 10:56:41 -0700
Message-Id: <20180501175642.8551-2-mkelly@xevo.com>
In-Reply-To: <20180501175642.8551-1-mkelly@xevo.com>
References: <20180501175642.8551-1-mkelly@xevo.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Just some minor grammar/spelling fixes of things I noticed while reading
the code.

Signed-off-by: Martin Kelly <mkelly@xevo.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  | 2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index aafa77766b08..59dbdeb08da4 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -176,7 +176,7 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask)
 		return result;
 
 	if (en) {
-		/* Wait for output stabilize */
+		/* Wait for output to stabilize */
 		msleep(INV_MPU6050_TEMP_UP_TIME);
 		if (mask == INV_MPU6050_BIT_PWR_GYRO_STBY) {
 			/* switch internal clock to PLL */
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index 90fdc5eaef53..65dcb92be9f6 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -53,7 +53,7 @@ static int inv_mpu6050_deselect_bypass(struct i2c_mux_core *muxc, u32 chan_id)
 
 	mutex_lock(&st->lock);
 
-	/* It doesn't really mattter, if any of the calls fails */
+	/* It doesn't really matter if any of the calls fail */
 	regmap_write(st->map, st->reg->int_pin_cfg, st->irq_mask);
 	inv_mpu6050_set_power_itg(st, false);
 
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index e51404fdce97..0cb7c20100ca 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -155,7 +155,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 		bytes_per_datum += INV_MPU6050_BYTES_PER_3AXIS_SENSOR;
 
 	/*
-	 * read fifo_count register to know how many bytes inside FIFO
+	 * read fifo_count register to know how many bytes are inside the FIFO
 	 * right now
 	 */
 	result = regmap_bulk_read(st->map, st->reg->fifo_count_h, data,
@@ -165,7 +165,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	fifo_count = be16_to_cpup((__be16 *)(&data[0]));
 	if (fifo_count < bytes_per_datum)
 		goto end_session;
-	/* fifo count can't be odd number, if it is odd, reset fifo*/
+	/* fifo count can't be an odd number. If it is odd, reset the FIFO. */
 	if (fifo_count & 1)
 		goto flush_fifo;
 	if (fifo_count >  INV_MPU6050_FIFO_THRESHOLD)
-- 
2.11.0

