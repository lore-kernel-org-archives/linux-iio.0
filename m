Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39779 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729402AbeKDXya (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Nov 2018 18:54:30 -0500
Received: by mail-wm1-f65.google.com with SMTP id u13-v6so5646405wmc.4
        for <linux-iio@vger.kernel.org>; Sun, 04 Nov 2018 06:39:15 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/7] iio: imu: st_lsm6dsx: introduce locked read/write utility routines
Date: Sun,  4 Nov 2018 15:39:00 +0100
Message-Id: <31af70f2f7b832b984b3f1bd122ce1c9cf98582b.1541341926.git.lorenzo.bianconi@redhat.com>
In-Reply-To: <cover.1541341926.git.lorenzo.bianconi@redhat.com>
References: <cover.1541341926.git.lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add st_lsm6dsx_update_bits_locked, st_lsm6dsx_read_locked and
st_lsm6dsx_write_locked utility routines in order to guarantee
the bus access is atomic respect to reg page configuration.
This is a preliminary patch to add i2c sensor hub support since
i2c master registers are accessed through a reg page multiplexer

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       | 41 +++++++++++
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 70 +++++++++----------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 24 ++++---
 3 files changed, 91 insertions(+), 44 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index ef73519a0fb6..ec204d3b4b1f 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -148,6 +148,7 @@ struct st_lsm6dsx_sensor {
  * @irq: Device interrupt line (I2C or SPI).
  * @fifo_lock: Mutex to prevent concurrent access to the hw FIFO.
  * @conf_lock: Mutex to prevent concurrent FIFO configuration update.
+ * @page_lock: Mutex to prevent concurrent memory page configuration.
  * @fifo_mode: FIFO operating mode supported by the device.
  * @enable_mask: Enabled sensor bitmask.
  * @ts_sip: Total number of timestamp samples in a given pattern.
@@ -163,6 +164,7 @@ struct st_lsm6dsx_hw {
 
 	struct mutex fifo_lock;
 	struct mutex conf_lock;
+	struct mutex page_lock;
 
 	enum st_lsm6dsx_fifo_mode fifo_mode;
 	u8 enable_mask;
@@ -192,4 +194,43 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw);
 int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw);
 int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u16 odr, u8 *val);
 
+static inline int
+st_lsm6dsx_update_bits_locked(struct st_lsm6dsx_hw *hw, unsigned int addr,
+			      unsigned int mask, unsigned int val)
+{
+	int err;
+
+	mutex_lock(&hw->page_lock);
+	err = regmap_update_bits(hw->regmap, addr, mask, val);
+	mutex_unlock(&hw->page_lock);
+
+	return err;
+}
+
+static inline int
+st_lsm6dsx_read_locked(struct st_lsm6dsx_hw *hw, unsigned int addr,
+		       void *val, unsigned int len)
+{
+	int err;
+
+	mutex_lock(&hw->page_lock);
+	err = regmap_bulk_read(hw->regmap, addr, val, len);
+	mutex_unlock(&hw->page_lock);
+
+	return err;
+}
+
+static inline int
+st_lsm6dsx_write_locked(struct st_lsm6dsx_hw *hw, unsigned int addr,
+			unsigned int val)
+{
+	int err;
+
+	mutex_lock(&hw->page_lock);
+	err = regmap_write(hw->regmap, addr, val);
+	mutex_unlock(&hw->page_lock);
+
+	return err;
+}
+
 #endif /* ST_LSM6DSX_H */
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index b5263fc522ca..4b3ba0956b5a 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -142,8 +142,9 @@ static int st_lsm6dsx_update_decimators(struct st_lsm6dsx_hw *hw)
 		if (dec_reg->addr) {
 			int val = ST_LSM6DSX_SHIFT_VAL(data, dec_reg->mask);
 
-			err = regmap_update_bits(hw->regmap, dec_reg->addr,
-						 dec_reg->mask, val);
+			err = st_lsm6dsx_update_bits_locked(hw, dec_reg->addr,
+							    dec_reg->mask,
+							    val);
 			if (err < 0)
 				return err;
 		}
@@ -162,8 +163,8 @@ static int st_lsm6dsx_update_decimators(struct st_lsm6dsx_hw *hw)
 		int val, ts_dec = !!hw->ts_sip;
 
 		val = ST_LSM6DSX_SHIFT_VAL(ts_dec, ts_dec_reg->mask);
-		err = regmap_update_bits(hw->regmap, ts_dec_reg->addr,
-					 ts_dec_reg->mask, val);
+		err = st_lsm6dsx_update_bits_locked(hw, ts_dec_reg->addr,
+						    ts_dec_reg->mask, val);
 	}
 	return err;
 }
@@ -171,12 +172,12 @@ static int st_lsm6dsx_update_decimators(struct st_lsm6dsx_hw *hw)
 int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
 			     enum st_lsm6dsx_fifo_mode fifo_mode)
 {
+	unsigned int data;
 	int err;
 
-	err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_FIFO_MODE_ADDR,
-				 ST_LSM6DSX_FIFO_MODE_MASK,
-				 FIELD_PREP(ST_LSM6DSX_FIFO_MODE_MASK,
-					    fifo_mode));
+	data = FIELD_PREP(ST_LSM6DSX_FIFO_MODE_MASK, fifo_mode);
+	err = st_lsm6dsx_update_bits_locked(hw, ST_LSM6DSX_REG_FIFO_MODE_ADDR,
+					    ST_LSM6DSX_FIFO_MODE_MASK, data);
 	if (err < 0)
 		return err;
 
@@ -207,15 +208,15 @@ static int st_lsm6dsx_set_fifo_odr(struct st_lsm6dsx_sensor *sensor,
 			data = 0;
 		}
 		val = ST_LSM6DSX_SHIFT_VAL(data, batch_reg->mask);
-		return regmap_update_bits(hw->regmap, batch_reg->addr,
-					  batch_reg->mask, val);
+		return st_lsm6dsx_update_bits_locked(hw, batch_reg->addr,
+						     batch_reg->mask, val);
 	} else {
 		data = hw->enable_mask ? ST_LSM6DSX_MAX_FIFO_ODR_VAL : 0;
-		return regmap_update_bits(hw->regmap,
-					  ST_LSM6DSX_REG_FIFO_MODE_ADDR,
-					  ST_LSM6DSX_FIFO_ODR_MASK,
-					  FIELD_PREP(ST_LSM6DSX_FIFO_ODR_MASK,
-						     data));
+		return st_lsm6dsx_update_bits_locked(hw,
+					ST_LSM6DSX_REG_FIFO_MODE_ADDR,
+					ST_LSM6DSX_FIFO_ODR_MASK,
+					FIELD_PREP(ST_LSM6DSX_FIFO_ODR_MASK,
+						   data));
 	}
 }
 
@@ -246,19 +247,23 @@ int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor, u16 watermark)
 	fifo_watermark = (fifo_watermark / hw->sip) * hw->sip;
 	fifo_watermark = fifo_watermark * hw->settings->fifo_ops.th_wl;
 
+	mutex_lock(&hw->page_lock);
 	err = regmap_read(hw->regmap, hw->settings->fifo_ops.fifo_th.addr + 1,
 			  &data);
 	if (err < 0)
-		return err;
+		goto out;
 
 	fifo_th_mask = hw->settings->fifo_ops.fifo_th.mask;
 	fifo_watermark = ((data << 8) & ~fifo_th_mask) |
 			 (fifo_watermark & fifo_th_mask);
 
 	wdata = cpu_to_le16(fifo_watermark);
-	return regmap_bulk_write(hw->regmap,
-				 hw->settings->fifo_ops.fifo_th.addr,
-				 &wdata, sizeof(wdata));
+	err = regmap_bulk_write(hw->regmap,
+				hw->settings->fifo_ops.fifo_th.addr,
+				&wdata, sizeof(wdata));
+out:
+	mutex_unlock(&hw->page_lock);
+	return err;
 }
 
 static int st_lsm6dsx_reset_hw_ts(struct st_lsm6dsx_hw *hw)
@@ -267,8 +272,8 @@ static int st_lsm6dsx_reset_hw_ts(struct st_lsm6dsx_hw *hw)
 	int i, err;
 
 	/* reset hw ts counter */
-	err = regmap_write(hw->regmap, ST_LSM6DSX_REG_TS_RESET_ADDR,
-			   ST_LSM6DSX_TS_RESET_VAL);
+	err = st_lsm6dsx_write_locked(hw, ST_LSM6DSX_REG_TS_RESET_ADDR,
+				      ST_LSM6DSX_TS_RESET_VAL);
 	if (err < 0)
 		return err;
 
@@ -297,8 +302,8 @@ static inline int st_lsm6dsx_read_block(struct st_lsm6dsx_hw *hw, u8 addr,
 	while (read_len < data_len) {
 		word_len = min_t(unsigned int, data_len - read_len,
 				 max_word_len);
-		err = regmap_bulk_read(hw->regmap, addr, data + read_len,
-				       word_len);
+		err = st_lsm6dsx_read_locked(hw, addr, data + read_len,
+					     word_len);
 		if (err < 0)
 			return err;
 		read_len += word_len;
@@ -328,9 +333,9 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 	__le16 fifo_status;
 	s64 ts = 0;
 
-	err = regmap_bulk_read(hw->regmap,
-			       hw->settings->fifo_ops.fifo_diff.addr,
-			       &fifo_status, sizeof(fifo_status));
+	err = st_lsm6dsx_read_locked(hw,
+				     hw->settings->fifo_ops.fifo_diff.addr,
+				     &fifo_status, sizeof(fifo_status));
 	if (err < 0) {
 		dev_err(hw->dev, "failed to read fifo status (err=%d)\n",
 			err);
@@ -455,9 +460,9 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
 	__le16 fifo_status;
 	s64 ts = 0;
 
-	err = regmap_bulk_read(hw->regmap,
-			       hw->settings->fifo_ops.fifo_diff.addr,
-			       &fifo_status, sizeof(fifo_status));
+	err = st_lsm6dsx_read_locked(hw,
+				     hw->settings->fifo_ops.fifo_diff.addr,
+				     &fifo_status, sizeof(fifo_status));
 	if (err < 0) {
 		dev_err(hw->dev, "failed to read fifo status (err=%d)\n",
 			err);
@@ -536,16 +541,11 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
 
 int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw)
 {
-	int err;
-
 	mutex_lock(&hw->fifo_lock);
-
 	hw->settings->fifo_ops.read_fifo(hw);
-	err = st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_BYPASS);
-
 	mutex_unlock(&hw->fifo_lock);
 
-	return err;
+	return st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_BYPASS);
 }
 
 static int st_lsm6dsx_update_fifo(struct iio_dev *iio_dev, bool enable)
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 2ad3c610e4b6..c8b993bea757 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -421,6 +421,7 @@ static int st_lsm6dsx_set_full_scale(struct st_lsm6dsx_sensor *sensor,
 {
 	struct st_lsm6dsx_hw *hw = sensor->hw;
 	const struct st_lsm6dsx_reg *reg;
+	unsigned int data;
 	int i, err;
 	u8 val;
 
@@ -433,8 +434,8 @@ static int st_lsm6dsx_set_full_scale(struct st_lsm6dsx_sensor *sensor,
 
 	val = st_lsm6dsx_fs_table[sensor->id].fs_avl[i].val;
 	reg = &st_lsm6dsx_fs_table[sensor->id].reg;
-	err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
-				 ST_LSM6DSX_SHIFT_VAL(val, reg->mask));
+	data = ST_LSM6DSX_SHIFT_VAL(val, reg->mask);
+	err = st_lsm6dsx_update_bits_locked(hw, reg->addr, reg->mask, data);
 	if (err < 0)
 		return err;
 
@@ -463,6 +464,7 @@ static int st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u16 odr)
 {
 	struct st_lsm6dsx_hw *hw = sensor->hw;
 	const struct st_lsm6dsx_reg *reg;
+	unsigned int data;
 	int err;
 	u8 val;
 
@@ -471,8 +473,8 @@ static int st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u16 odr)
 		return err;
 
 	reg = &st_lsm6dsx_odr_table[sensor->id].reg;
-	return regmap_update_bits(hw->regmap, reg->addr, reg->mask,
-				  ST_LSM6DSX_SHIFT_VAL(val, reg->mask));
+	data = ST_LSM6DSX_SHIFT_VAL(val, reg->mask);
+	return st_lsm6dsx_update_bits_locked(hw, reg->addr, reg->mask, data);
 }
 
 int st_lsm6dsx_sensor_enable(struct st_lsm6dsx_sensor *sensor)
@@ -492,11 +494,12 @@ int st_lsm6dsx_sensor_disable(struct st_lsm6dsx_sensor *sensor)
 {
 	struct st_lsm6dsx_hw *hw = sensor->hw;
 	const struct st_lsm6dsx_reg *reg;
+	unsigned int data;
 	int err;
 
 	reg = &st_lsm6dsx_odr_table[sensor->id].reg;
-	err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
-				 ST_LSM6DSX_SHIFT_VAL(0, reg->mask));
+	data = ST_LSM6DSX_SHIFT_VAL(0, reg->mask);
+	err = st_lsm6dsx_update_bits_locked(hw, reg->addr, reg->mask, data);
 	if (err < 0)
 		return err;
 
@@ -519,7 +522,7 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
 	delay = 1000000 / sensor->odr;
 	usleep_range(delay, 2 * delay);
 
-	err = regmap_bulk_read(hw->regmap, addr, &data, sizeof(data));
+	err = st_lsm6dsx_read_locked(hw, addr, &data, sizeof(data));
 	if (err < 0)
 		return err;
 
@@ -865,6 +868,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
 
 	mutex_init(&hw->fifo_lock);
 	mutex_init(&hw->conf_lock);
+	mutex_init(&hw->page_lock);
 
 	hw->buff = devm_kzalloc(dev, ST_LSM6DSX_BUFF_SIZE, GFP_KERNEL);
 	if (!hw->buff)
@@ -909,6 +913,7 @@ static int __maybe_unused st_lsm6dsx_suspend(struct device *dev)
 	struct st_lsm6dsx_hw *hw = dev_get_drvdata(dev);
 	struct st_lsm6dsx_sensor *sensor;
 	const struct st_lsm6dsx_reg *reg;
+	unsigned int data;
 	int i, err = 0;
 
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
@@ -917,8 +922,9 @@ static int __maybe_unused st_lsm6dsx_suspend(struct device *dev)
 			continue;
 
 		reg = &st_lsm6dsx_odr_table[sensor->id].reg;
-		err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
-					 ST_LSM6DSX_SHIFT_VAL(0, reg->mask));
+		data = ST_LSM6DSX_SHIFT_VAL(0, reg->mask);
+		err = st_lsm6dsx_update_bits_locked(hw, reg->addr, reg->mask,
+						    data);
 		if (err < 0)
 			return err;
 	}
-- 
2.19.1
