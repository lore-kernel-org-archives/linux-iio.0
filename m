Return-Path: <SRS0=O0fK=BB=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	lorenzo.bianconi@st.com
Subject: [PATCH v2 2/4] iio: imu: st_lsm6dsx: split fifo mode and fifo odr configuration
Date: Mon,  2 Oct 2017 18:37:38 +0200
Message-Id: <20171002163740.13780-3-lorenzo.bianconi@st.com>
In-Reply-To: <20171002163740.13780-1-lorenzo.bianconi@st.com>
References: <20171002163740.13780-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Separate fifo mode and max fifo sample rate configuration.
That change will be necessary to reuse st_lsm6dsx_set_fifo_mode()
routine and to support more devices in st_lsm6dsx driver

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 32 ++++++++++++++------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index e2737dc71b67..26fb970aed15 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -139,23 +139,10 @@ static int st_lsm6dsx_update_decimators(struct st_lsm6dsx_hw *hw)
 int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
 			     enum st_lsm6dsx_fifo_mode fifo_mode)
 {
-	u8 data;
 	int err;
 
-	switch (fifo_mode) {
-	case ST_LSM6DSX_FIFO_BYPASS:
-		data = fifo_mode;
-		break;
-	case ST_LSM6DSX_FIFO_CONT:
-		data = (ST_LSM6DSX_MAX_FIFO_ODR_VAL <<
-			__ffs(ST_LSM6DSX_FIFO_ODR_MASK)) | fifo_mode;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	err = hw->tf->write(hw->dev, ST_LSM6DSX_REG_FIFO_MODE_ADDR,
-			    sizeof(data), &data);
+	err = st_lsm6dsx_write_with_mask(hw, ST_LSM6DSX_REG_FIFO_MODE_ADDR,
+					 ST_LSM6DSX_FIFO_MODE_MASK, fifo_mode);
 	if (err < 0)
 		return err;
 
@@ -164,6 +151,17 @@ int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
 	return 0;
 }
 
+static int st_lsm6dsx_set_fifo_odr(struct st_lsm6dsx_sensor *sensor,
+				   bool enable)
+{
+	struct st_lsm6dsx_hw *hw = sensor->hw;
+	u8 data;
+
+	data = hw->enable_mask ? ST_LSM6DSX_MAX_FIFO_ODR_VAL : 0;
+	return st_lsm6dsx_write_with_mask(hw, ST_LSM6DSX_REG_FIFO_MODE_ADDR,
+					  ST_LSM6DSX_FIFO_ODR_MASK, data);
+}
+
 int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor, u16 watermark)
 {
 	u16 fifo_watermark = ~0, cur_watermark, sip = 0;
@@ -345,6 +343,10 @@ static int st_lsm6dsx_update_fifo(struct iio_dev *iio_dev, bool enable)
 			return err;
 	}
 
+	err = st_lsm6dsx_set_fifo_odr(sensor, enable);
+	if (err < 0)
+		return err;
+
 	err = st_lsm6dsx_update_decimators(hw);
 	if (err < 0)
 		return err;
-- 
2.14.1
