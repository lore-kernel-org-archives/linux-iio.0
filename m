Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42248 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbeKLAEf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Nov 2018 19:04:35 -0500
Received: by mail-wr1-f65.google.com with SMTP id u5-v6so1281328wrn.9
        for <linux-iio@vger.kernel.org>; Sun, 11 Nov 2018 06:15:53 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 4/9] iio: imu: st_lsm6dsx: introduce ST_LSM6DSX_ID_EXT sensor ids
Date: Sun, 11 Nov 2018 15:15:31 +0100
Message-Id: <4dcabac3f27cedfc236a26127f16084e94f3ca0b.1541945612.git.lorenzo.bianconi@redhat.com>
In-Reply-To: <cover.1541945612.git.lorenzo.bianconi@redhat.com>
References: <cover.1541945612.git.lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add ST_LSM6DSX_ID_EXT{0,1,2} sensor ids as reference for slave devices
connected to st_lsm6dsx i2c controller. Moreover introduce odr dependency
between accel and ext devices since i2c embedded controller relies on the
accelerometer sensor as bus read/write trigger so we need to enable accel
device at odr = max(accel_odr, ext_odr) in order to properly communicate
with i2c slave devices

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  5 +-
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 15 ++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 77 +++++++++++++++++--
 3 files changed, 88 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index ac4cbbb0b3fb..4c8385d19c78 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -105,8 +105,11 @@ struct st_lsm6dsx_settings {
 };
 
 enum st_lsm6dsx_sensor_id {
-	ST_LSM6DSX_ID_ACC,
 	ST_LSM6DSX_ID_GYRO,
+	ST_LSM6DSX_ID_ACC,
+	ST_LSM6DSX_ID_EXT0,
+	ST_LSM6DSX_ID_EXT1,
+	ST_LSM6DSX_ID_EXT2,
 	ST_LSM6DSX_ID_MAX,
 };
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 67cd36bce772..f4804008b585 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -102,6 +102,9 @@ static void st_lsm6dsx_get_max_min_odr(struct st_lsm6dsx_hw *hw,
 
 	*max_odr = 0, *min_odr = ~0;
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
+		if (!hw->iio_devs[i])
+			continue;
+
 		sensor = iio_priv(hw->iio_devs[i]);
 
 		if (!(hw->enable_mask & BIT(sensor->id)))
@@ -125,6 +128,9 @@ static int st_lsm6dsx_update_decimators(struct st_lsm6dsx_hw *hw)
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
 		const struct st_lsm6dsx_reg *dec_reg;
 
+		if (!hw->iio_devs[i])
+			continue;
+
 		sensor = iio_priv(hw->iio_devs[i]);
 		/* update fifo decimators and sample in pattern */
 		if (hw->enable_mask & BIT(sensor->id)) {
@@ -232,6 +238,9 @@ int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor, u16 watermark)
 		return 0;
 
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
+		if (!hw->iio_devs[i])
+			continue;
+
 		cur_sensor = iio_priv(hw->iio_devs[i]);
 
 		if (!(hw->enable_mask & BIT(cur_sensor->id)))
@@ -278,6 +287,9 @@ static int st_lsm6dsx_reset_hw_ts(struct st_lsm6dsx_hw *hw)
 		return err;
 
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
+		if (!hw->iio_devs[i])
+			continue;
+
 		sensor = iio_priv(hw->iio_devs[i]);
 		/*
 		 * store enable buffer timestamp as reference for
@@ -695,6 +707,9 @@ int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
 	}
 
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
+		if (!hw->iio_devs[i])
+			continue;
+
 		buffer = devm_iio_kfifo_allocate(hw->dev);
 		if (!buffer)
 			return -ENOMEM;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index d703fcd8706a..8885c9755456 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -450,7 +450,11 @@ int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u16 odr, u8 *val)
 	int i;
 
 	for (i = 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++)
-		if (st_lsm6dsx_odr_table[sensor->id].odr_avl[i].hz == odr)
+		/*
+		 * ext devices can run at different odr respect to
+		 * accel sensor
+		 */
+		if (st_lsm6dsx_odr_table[sensor->id].odr_avl[i].hz >= odr)
 			break;
 
 	if (i == ST_LSM6DSX_ODR_LIST_SIZE)
@@ -461,19 +465,67 @@ int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u16 odr, u8 *val)
 	return 0;
 }
 
-static int st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u16 odr)
+static u16 st_lsm6dsx_check_odr_dependency(struct st_lsm6dsx_hw *hw, u16 odr,
+					   enum st_lsm6dsx_sensor_id id)
 {
+	struct st_lsm6dsx_sensor *ref = iio_priv(hw->iio_devs[id]);
+
+	if (odr > 0) {
+		if (hw->enable_mask & BIT(id))
+			return max_t(u16, ref->odr, odr);
+		else
+			return odr;
+	} else {
+		return (hw->enable_mask & BIT(id)) ? ref->odr : 0;
+	}
+}
+
+static int st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u16 req_odr)
+{
+	struct st_lsm6dsx_sensor *ref_sensor = sensor;
 	struct st_lsm6dsx_hw *hw = sensor->hw;
 	const struct st_lsm6dsx_reg *reg;
 	unsigned int data;
+	u8 val = 0;
 	int err;
-	u8 val;
 
-	err = st_lsm6dsx_check_odr(sensor, odr, &val);
-	if (err < 0)
-		return err;
+	switch (sensor->id) {
+	case ST_LSM6DSX_ID_EXT0:
+	case ST_LSM6DSX_ID_EXT1:
+	case ST_LSM6DSX_ID_EXT2:
+	case ST_LSM6DSX_ID_ACC: {
+		u16 odr;
+		int i;
+
+		/*
+		 * i2c embedded controller relies on the accelerometer sensor as
+		 * bus read/write trigger so we need to enable accel device
+		 * at odr = max(accel_odr, ext_odr) in order to properly
+		 * communicate with i2c slave devices
+		 */
+		ref_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
+		for (i = ST_LSM6DSX_ID_ACC; i < ST_LSM6DSX_ID_MAX; i++) {
+			if (!hw->iio_devs[i] || i == sensor->id)
+				continue;
+
+			odr = st_lsm6dsx_check_odr_dependency(hw, req_odr, i);
+			if (odr != req_odr)
+				/* device already configured */
+				return 0;
+		}
+		break;
+	}
+	default:
+		break;
+	}
 
-	reg = &st_lsm6dsx_odr_table[sensor->id].reg;
+	if (req_odr > 0) {
+		err = st_lsm6dsx_check_odr(ref_sensor, req_odr, &val);
+		if (err < 0)
+			return err;
+	}
+
+	reg = &st_lsm6dsx_odr_table[ref_sensor->id].reg;
 	data = ST_LSM6DSX_SHIFT_VAL(val, reg->mask);
 	return st_lsm6dsx_update_bits_locked(hw, reg->addr, reg->mask, data);
 }
@@ -894,7 +946,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
 	if (err < 0)
 		return err;
 
-	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
+	for (i = 0; i < ST_LSM6DSX_ID_EXT0; i++) {
 		hw->iio_devs[i] = st_lsm6dsx_alloc_iiodev(hw, i, name);
 		if (!hw->iio_devs[i])
 			return -ENOMEM;
@@ -911,6 +963,9 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
 	}
 
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
+		if (!hw->iio_devs[i])
+			continue;
+
 		err = devm_iio_device_register(hw->dev, hw->iio_devs[i]);
 		if (err)
 			return err;
@@ -929,6 +984,9 @@ static int __maybe_unused st_lsm6dsx_suspend(struct device *dev)
 	int i, err = 0;
 
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
+		if (!hw->iio_devs[i])
+			continue;
+
 		sensor = iio_priv(hw->iio_devs[i]);
 		if (!(hw->enable_mask & BIT(sensor->id)))
 			continue;
@@ -954,6 +1012,9 @@ static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
 	int i, err = 0;
 
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
+		if (!hw->iio_devs[i])
+			continue;
+
 		sensor = iio_priv(hw->iio_devs[i]);
 		if (!(hw->enable_mask & BIT(sensor->id)))
 			continue;
-- 
2.19.1
