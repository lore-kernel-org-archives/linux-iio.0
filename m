Return-Path: <SRS0=XBWy=2X=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	lorenzo.bianconi@st.com
Subject: [PATCH] iio: imu: st_lsm6dsx: fix FIFO_CTRL2 overwrite during watermark configuration
Date: Tue, 14 Mar 2017 22:05:20 +0100
Message-Id: <20170314210520.28665-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Fixes: 290a6ce11d93 (iio: imu: add support to lsm6dsx driver)
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index e71ecce..e959825 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -194,8 +194,8 @@ int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor, u16 watermark)
 	if (err < 0)
 		goto out;
 
-	fifo_watermark = ((data & ~ST_LSM6DSX_FIFO_TH_MASK) << 8) |
-			  (fifo_watermark & ST_LSM6DSX_FIFO_TH_MASK);
+	fifo_watermark = ((data << 8) & ~ST_LSM6DSX_FIFO_TH_MASK) |
+			 (fifo_watermark & ST_LSM6DSX_FIFO_TH_MASK);
 
 	wdata = cpu_to_le16(fifo_watermark);
 	err = hw->tf->write(hw->dev, ST_LSM6DSX_REG_FIFO_THL_ADDR,
-- 
2.9.3
