Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-sn1nam01on0057.outbound.protection.outlook.com ([104.47.32.57]:43936
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752361AbeD3KOz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Apr 2018 06:14:55 -0400
From: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To: linux-iio@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        stable@vger.kernel.org
Subject: [PATCH 2/4] iio: imu: inv_mpu6050: fix possible deadlock between mutex and iio
Date: Mon, 30 Apr 2018 12:14:09 +0200
Message-Id: <1525083251-8368-2-git-send-email-jmaneyrol@invensense.com>
In-Reply-To: <1525083251-8368-1-git-send-email-jmaneyrol@invensense.com>
References: <1525083251-8368-1-git-send-email-jmaneyrol@invensense.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Detected by kernel circular locking dependency checker.

We are locking iio mutex (iio_device_claim_direct_mode) after
locking our internal mutex. But when the buffer starts, iio first
locks its mutex and then we lock our internal one.

To avoid possible deadlock, we need to use the same order
everwhere. So we change the ordering by locking first iio mutex,
then our internal mutex.

Fixes: 68cd6e5b206b ("iio: imu: inv_mpu6050: fix lock issues by using our own mutex")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 34 ++++++++++++++----------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index aafa777..7358935 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -340,12 +340,9 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
 	int result;
 	int ret;
 
-	result = iio_device_claim_direct_mode(indio_dev);
-	if (result)
-		return result;
 	result = inv_mpu6050_set_power_itg(st, true);
 	if (result)
-		goto error_release;
+		return result;
 
 	switch (chan->type) {
 	case IIO_ANGL_VEL:
@@ -386,14 +383,11 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
 	result = inv_mpu6050_set_power_itg(st, false);
 	if (result)
 		goto error_power_off;
-	iio_device_release_direct_mode(indio_dev);
 
 	return ret;
 
 error_power_off:
 	inv_mpu6050_set_power_itg(st, false);
-error_release:
-	iio_device_release_direct_mode(indio_dev);
 	return result;
 }
 
@@ -407,9 +401,13 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
 		mutex_lock(&st->lock);
 		ret = inv_mpu6050_read_channel_data(indio_dev, chan, val);
 		mutex_unlock(&st->lock);
+		iio_device_release_direct_mode(indio_dev);
 		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
@@ -532,17 +530,18 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
 	struct inv_mpu6050_state  *st = iio_priv(indio_dev);
 	int result;
 
-	mutex_lock(&st->lock);
 	/*
 	 * we should only update scale when the chip is disabled, i.e.
 	 * not running
 	 */
 	result = iio_device_claim_direct_mode(indio_dev);
 	if (result)
-		goto error_write_raw_unlock;
+		return result;
+
+	mutex_lock(&st->lock);
 	result = inv_mpu6050_set_power_itg(st, true);
 	if (result)
-		goto error_write_raw_release;
+		goto error_write_raw_unlock;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
@@ -581,10 +580,9 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
 	}
 
 	result |= inv_mpu6050_set_power_itg(st, false);
-error_write_raw_release:
-	iio_device_release_direct_mode(indio_dev);
 error_write_raw_unlock:
 	mutex_unlock(&st->lock);
+	iio_device_release_direct_mode(indio_dev);
 
 	return result;
 }
@@ -643,17 +641,18 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
 	    fifo_rate > INV_MPU6050_MAX_FIFO_RATE)
 		return -EINVAL;
 
+	result = iio_device_claim_direct_mode(indio_dev);
+	if (result)
+		return result;
+
 	mutex_lock(&st->lock);
 	if (fifo_rate == st->chip_config.fifo_rate) {
 		result = 0;
 		goto fifo_rate_fail_unlock;
 	}
-	result = iio_device_claim_direct_mode(indio_dev);
-	if (result)
-		goto fifo_rate_fail_unlock;
 	result = inv_mpu6050_set_power_itg(st, true);
 	if (result)
-		goto fifo_rate_fail_release;
+		goto fifo_rate_fail_unlock;
 
 	d = INV_MPU6050_ONE_K_HZ / fifo_rate - 1;
 	result = regmap_write(st->map, st->reg->sample_rate_div, d);
@@ -667,10 +666,9 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
 
 fifo_rate_fail_power_off:
 	result |= inv_mpu6050_set_power_itg(st, false);
-fifo_rate_fail_release:
-	iio_device_release_direct_mode(indio_dev);
 fifo_rate_fail_unlock:
 	mutex_unlock(&st->lock);
+	iio_device_release_direct_mode(indio_dev);
 	if (result)
 		return result;
 
-- 
2.7.4

