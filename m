Return-Path: <SRS0=PE8Z=A4=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	lorenzo.bianconi@st.com
Subject: [PATCH 4/4] iio: imu: st_lsm6dsx: add FIFO ops data structure
Date: Wed, 27 Sep 2017 21:29:28 +0200
Message-Id: <20170927192928.16160-5-lorenzo.bianconi@st.com>
In-Reply-To: <20170927192928.16160-1-lorenzo.bianconi@st.com>
References: <20170927192928.16160-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Introduce FIFO ops data structure to contain FIFO related parameter
in order to properly support more devices in st_lsm6dsx driver

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        | 23 ++++++++++++++++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 23 ++++++++----------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 33 ++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 052db1fbb46e..57c7e8e1f915 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -29,8 +29,6 @@ enum st_lsm6dsx_hw_id {
 
 #define ST_LSM6DSX_CHAN_SIZE		2
 #define ST_LSM6DSX_SAMPLE_SIZE		6
-#define ST_LSM6DSX_SAMPLE_DEPTH		(ST_LSM6DSX_SAMPLE_SIZE / \
-					 ST_LSM6DSX_CHAN_SIZE)
 
 #if defined(CONFIG_SPI_MASTER)
 #define ST_LSM6DSX_RX_MAX_LENGTH	256
@@ -52,18 +50,39 @@ struct st_lsm6dsx_reg {
 	u8 mask;
 };
 
+/**
+ * struct st_lsm6dsx_fifo_ops - ST IMU FIFO settings
+ * @fifo_th: FIFO threshold register info (addr + mask).
+ * @fifo_diff: FIFO diff status register info (addr + mask).
+ * @th_wl: FIFO threshold word length.
+ *
+ */
+struct st_lsm6dsx_fifo_ops {
+	struct {
+		u8 addr;
+		u16 mask;
+	} fifo_th;
+	struct {
+		u8 addr;
+		u16 mask;
+	} fifo_diff;
+	u8 th_wl;
+};
+
 /**
  * struct st_lsm6dsx_settings - ST IMU sensor settings
  * @wai: Sensor WhoAmI default value.
  * @max_fifo_size: Sensor max fifo length in FIFO words.
  * @id: List of hw id supported by the driver configuration.
  * @decimator: List of decimator register info (addr + mask).
+ * @fifo_ops: Sensor hw FIFO parameters.
  */
 struct st_lsm6dsx_settings {
 	u8 wai;
 	u16 max_fifo_size;
 	enum st_lsm6dsx_hw_id id[ST_LSM6DSX_MAX_ID];
 	struct st_lsm6dsx_reg decimator[ST_LSM6DSX_MAX_ID];
+	struct st_lsm6dsx_fifo_ops fifo_ops;
 };
 
 enum st_lsm6dsx_sensor_id {
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index cb4f8558a98f..755c472e8a05 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -35,9 +35,6 @@
 
 #include "st_lsm6dsx.h"
 
-#define ST_LSM6DSX_REG_FIFO_THL_ADDR		0x06
-#define ST_LSM6DSX_REG_FIFO_THH_ADDR		0x07
-#define ST_LSM6DSX_FIFO_TH_MASK			GENMASK(11, 0)
 #define ST_LSM6DSX_REG_HLACTIVE_ADDR		0x12
 #define ST_LSM6DSX_REG_HLACTIVE_MASK		BIT(5)
 #define ST_LSM6DSX_REG_PP_OD_ADDR		0x12
@@ -45,8 +42,6 @@
 #define ST_LSM6DSX_REG_FIFO_MODE_ADDR		0x0a
 #define ST_LSM6DSX_FIFO_MODE_MASK		GENMASK(2, 0)
 #define ST_LSM6DSX_FIFO_ODR_MASK		GENMASK(6, 3)
-#define ST_LSM6DSX_REG_FIFO_DIFFL_ADDR		0x3a
-#define ST_LSM6DSX_FIFO_DIFF_MASK		GENMASK(11, 0)
 #define ST_LSM6DSX_FIFO_EMPTY_MASK		BIT(12)
 #define ST_LSM6DSX_REG_FIFO_OUTL_ADDR		0x3e
 
@@ -165,7 +160,7 @@ static int st_lsm6dsx_set_fifo_odr(struct st_lsm6dsx_sensor *sensor,
 
 int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor, u16 watermark)
 {
-	u16 fifo_watermark = ~0, cur_watermark, sip = 0;
+	u16 fifo_watermark = ~0, cur_watermark, sip = 0, fifo_th_mask;
 	struct st_lsm6dsx_hw *hw = sensor->hw;
 	struct st_lsm6dsx_sensor *cur_sensor;
 	__le16 wdata;
@@ -190,20 +185,21 @@ int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor, u16 watermark)
 
 	fifo_watermark = max_t(u16, fifo_watermark, sip);
 	fifo_watermark = (fifo_watermark / sip) * sip;
-	fifo_watermark = fifo_watermark * ST_LSM6DSX_SAMPLE_DEPTH;
+	fifo_watermark = fifo_watermark * hw->settings->fifo_ops.th_wl;
 
 	mutex_lock(&hw->lock);
 
-	err = hw->tf->read(hw->dev, ST_LSM6DSX_REG_FIFO_THH_ADDR,
+	err = hw->tf->read(hw->dev, hw->settings->fifo_ops.fifo_th.addr + 1,
 			   sizeof(data), &data);
 	if (err < 0)
 		goto out;
 
-	fifo_watermark = ((data << 8) & ~ST_LSM6DSX_FIFO_TH_MASK) |
-			 (fifo_watermark & ST_LSM6DSX_FIFO_TH_MASK);
+	fifo_th_mask = hw->settings->fifo_ops.fifo_th.mask;
+	fifo_watermark = ((data << 8) & ~fifo_th_mask) |
+			 (fifo_watermark & fifo_th_mask);
 
 	wdata = cpu_to_le16(fifo_watermark);
-	err = hw->tf->write(hw->dev, ST_LSM6DSX_REG_FIFO_THL_ADDR,
+	err = hw->tf->write(hw->dev, hw->settings->fifo_ops.fifo_th.addr,
 			    sizeof(wdata), (u8 *)&wdata);
 out:
 	mutex_unlock(&hw->lock);
@@ -222,6 +218,7 @@ int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor, u16 watermark)
 static int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 {
 	u16 fifo_len, pattern_len = hw->sip * ST_LSM6DSX_SAMPLE_SIZE;
+	u16 fifo_diff_mask = hw->settings->fifo_ops.fifo_diff.mask;
 	int err, acc_sip, gyro_sip, read_len, samples, offset;
 	struct st_lsm6dsx_sensor *acc_sensor, *gyro_sensor;
 	s64 acc_ts, acc_delta_ts, gyro_ts, gyro_delta_ts;
@@ -229,7 +226,7 @@ static int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 	u8 buff[pattern_len];
 	__le16 fifo_status;
 
-	err = hw->tf->read(hw->dev, ST_LSM6DSX_REG_FIFO_DIFFL_ADDR,
+	err = hw->tf->read(hw->dev, hw->settings->fifo_ops.fifo_diff.addr,
 			   sizeof(fifo_status), (u8 *)&fifo_status);
 	if (err < 0)
 		return err;
@@ -237,7 +234,7 @@ static int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 	if (fifo_status & cpu_to_le16(ST_LSM6DSX_FIFO_EMPTY_MASK))
 		return 0;
 
-	fifo_len = (le16_to_cpu(fifo_status) & ST_LSM6DSX_FIFO_DIFF_MASK) *
+	fifo_len = (le16_to_cpu(fifo_status) & fifo_diff_mask) *
 		   ST_LSM6DSX_CHAN_SIZE;
 	samples = fifo_len / ST_LSM6DSX_SAMPLE_SIZE;
 	fifo_len = (fifo_len / pattern_len) * pattern_len;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 4532671df1be..239c735242be 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -168,6 +168,17 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = GENMASK(5, 3),
 			},
 		},
+		.fifo_ops = {
+			.fifo_th = {
+				.addr = 0x06,
+				.mask = GENMASK(11, 0),
+			},
+			.fifo_diff = {
+				.addr = 0x3a,
+				.mask = GENMASK(11, 0),
+			},
+			.th_wl = 3, /* 1LSB = 2B */
+		},
 	},
 	{
 		.wai = 0x69,
@@ -185,6 +196,17 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = GENMASK(5, 3),
 			},
 		},
+		.fifo_ops = {
+			.fifo_th = {
+				.addr = 0x06,
+				.mask = GENMASK(11, 0),
+			},
+			.fifo_diff = {
+				.addr = 0x3a,
+				.mask = GENMASK(11, 0),
+			},
+			.th_wl = 3, /* 1LSB = 2B */
+		},
 	},
 	{
 		.wai = 0x6a,
@@ -203,6 +225,17 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = GENMASK(5, 3),
 			},
 		},
+		.fifo_ops = {
+			.fifo_th = {
+				.addr = 0x06,
+				.mask = GENMASK(11, 0),
+			},
+			.fifo_diff = {
+				.addr = 0x3a,
+				.mask = GENMASK(11, 0),
+			},
+			.th_wl = 3, /* 1LSB = 2B */
+		},
 	},
 };
 
-- 
2.14.1
