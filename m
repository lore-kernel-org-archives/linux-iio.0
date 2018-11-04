Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40747 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730005AbeKDXyh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Nov 2018 18:54:37 -0500
Received: by mail-wr1-f66.google.com with SMTP id i17-v6so6652379wre.7
        for <linux-iio@vger.kernel.org>; Sun, 04 Nov 2018 06:39:22 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 4/7] iio: imu: st_lsm6dsx: introduce ST_LSM6DSX_ID_EXT sensor ids
Date: Sun,  4 Nov 2018 15:39:03 +0100
Message-Id: <425182cdf3fc096dabe330788222a2d59457b7fd.1541341926.git.lorenzo.bianconi@redhat.com>
In-Reply-To: <cover.1541341926.git.lorenzo.bianconi@redhat.com>
References: <cover.1541341926.git.lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add ST_LSM6DSX_ID_EXT{0,1,2} sensor ids as reference for slave devices
connected to st_lsm6dsx i2c controller. Moreover introduce odr dependency
between accel and ext devices since accelerometer is used as trigger for
i2c master controller read/write operations

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |   9 +-
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |  27 +++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 101 ++++++++++++------
 3 files changed, 95 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index ac4cbbb0b3fb..2beb4f563892 100644
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
 
@@ -182,8 +185,8 @@ extern const struct dev_pm_ops st_lsm6dsx_pm_ops;
 
 int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
 		     struct regmap *regmap);
-int st_lsm6dsx_sensor_enable(struct st_lsm6dsx_sensor *sensor);
-int st_lsm6dsx_sensor_disable(struct st_lsm6dsx_sensor *sensor);
+int st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
+				 bool enable);
 int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw);
 int st_lsm6dsx_set_watermark(struct iio_dev *iio_dev, unsigned int val);
 int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor,
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 4b3ba0956b5a..96f7d56d3b6d 100644
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
@@ -562,15 +574,9 @@ static int st_lsm6dsx_update_fifo(struct iio_dev *iio_dev, bool enable)
 			goto out;
 	}
 
-	if (enable) {
-		err = st_lsm6dsx_sensor_enable(sensor);
-		if (err < 0)
-			goto out;
-	} else {
-		err = st_lsm6dsx_sensor_disable(sensor);
-		if (err < 0)
-			goto out;
-	}
+	err = st_lsm6dsx_sensor_set_enable(sensor, enable);
+	if (err < 0)
+		goto out;
 
 	err = st_lsm6dsx_set_fifo_odr(sensor, enable);
 	if (err < 0)
@@ -690,6 +696,9 @@ int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
 	}
 
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
+		if (!hw->iio_devs[i])
+			continue;
+
 		buffer = devm_iio_kfifo_allocate(hw->dev);
 		if (!buffer)
 			return -ENOMEM;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 3433a5b6bf4d..f2549ddfee20 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -450,7 +450,7 @@ int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u16 odr, u8 *val)
 	int i;
 
 	for (i = 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++)
-		if (st_lsm6dsx_odr_table[sensor->id].odr_avl[i].hz == odr)
+		if (st_lsm6dsx_odr_table[sensor->id].odr_avl[i].hz >= odr)
 			break;
 
 	if (i == ST_LSM6DSX_ODR_LIST_SIZE)
@@ -461,50 +461,82 @@ int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u16 odr, u8 *val)
 	return 0;
 }
 
-static int st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u16 odr)
+static u16 st_lsm6dsx_check_odr_dependency(struct st_lsm6dsx_hw *hw, u16 odr,
+					   enum st_lsm6dsx_sensor_id id)
 {
+	struct st_lsm6dsx_sensor *ref = iio_priv(hw->iio_devs[id]);
+	u16 ret;
+
+	if (odr > 0) {
+		if (hw->enable_mask & BIT(id))
+			ret = max_t(u16, ref->odr, odr);
+		else
+			ret = odr;
+	} else {
+		ret = (hw->enable_mask & BIT(id)) ? ref->odr : 0;
+	}
+	return ret;
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
+		/* use acc as trigger for ext devices */
+		ref_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
+		for (i = ST_LSM6DSX_ID_ACC; i < ST_LSM6DSX_ID_MAX; i++) {
+			if (!hw->iio_devs[i] || i == sensor->id)
+				continue;
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
+
+	if (req_odr > 0) {
+		err = st_lsm6dsx_check_odr(ref_sensor, req_odr, &val);
+		if (err < 0)
+			return err;
+	}
 
-	reg = &st_lsm6dsx_odr_table[sensor->id].reg;
+	reg = &st_lsm6dsx_odr_table[ref_sensor->id].reg;
 	data = ST_LSM6DSX_SHIFT_VAL(val, reg->mask);
 	return st_lsm6dsx_update_bits_locked(hw, reg->addr, reg->mask, data);
 }
 
-int st_lsm6dsx_sensor_enable(struct st_lsm6dsx_sensor *sensor)
-{
-	int err;
-
-	err = st_lsm6dsx_set_odr(sensor, sensor->odr);
-	if (err < 0)
-		return err;
-
-	sensor->hw->enable_mask |= BIT(sensor->id);
-
-	return 0;
-}
-
-int st_lsm6dsx_sensor_disable(struct st_lsm6dsx_sensor *sensor)
+int st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
+				 bool enable)
 {
 	struct st_lsm6dsx_hw *hw = sensor->hw;
-	const struct st_lsm6dsx_reg *reg;
-	unsigned int data;
+	u16 odr = enable ? sensor->odr : 0;
 	int err;
 
-	reg = &st_lsm6dsx_odr_table[sensor->id].reg;
-	data = ST_LSM6DSX_SHIFT_VAL(0, reg->mask);
-	err = st_lsm6dsx_update_bits_locked(hw, reg->addr, reg->mask, data);
+	err = st_lsm6dsx_set_odr(sensor, odr);
 	if (err < 0)
 		return err;
 
-	sensor->hw->enable_mask &= ~BIT(sensor->id);
+	if (enable)
+		hw->enable_mask |= BIT(sensor->id);
+	else
+		hw->enable_mask &= ~BIT(sensor->id);
 
 	return 0;
 }
@@ -516,7 +548,7 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
 	int err, delay;
 	__le16 data;
 
-	err = st_lsm6dsx_sensor_enable(sensor);
+	err = st_lsm6dsx_sensor_set_enable(sensor, true);
 	if (err < 0)
 		return err;
 
@@ -527,7 +559,7 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
 	if (err < 0)
 		return err;
 
-	st_lsm6dsx_sensor_disable(sensor);
+	st_lsm6dsx_sensor_set_enable(sensor, false);
 
 	*val = (s16)le16_to_cpu(data);
 
@@ -892,7 +924,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
 	if (err < 0)
 		return err;
 
-	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
+	for (i = 0; i < ST_LSM6DSX_ID_EXT0; i++) {
 		hw->iio_devs[i] = st_lsm6dsx_alloc_iiodev(hw, i, name);
 		if (!hw->iio_devs[i])
 			return -ENOMEM;
@@ -909,6 +941,9 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
 	}
 
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
+		if (!hw->iio_devs[i])
+			continue;
+
 		err = devm_iio_device_register(hw->dev, hw->iio_devs[i]);
 		if (err)
 			return err;
@@ -927,6 +962,9 @@ static int __maybe_unused st_lsm6dsx_suspend(struct device *dev)
 	int i, err = 0;
 
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
+		if (!hw->iio_devs[i])
+			continue;
+
 		sensor = iio_priv(hw->iio_devs[i]);
 		if (!(hw->enable_mask & BIT(sensor->id)))
 			continue;
@@ -952,6 +990,9 @@ static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
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
