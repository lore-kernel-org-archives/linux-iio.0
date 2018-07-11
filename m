Return-Path: <SRS0=eKBR=J3=redhat.com=lorenzo.bianconi@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	jramirez@baylibre.com
Subject: [PATCH] iio: imu: st_lsm6dsx: add error logs to st_lsm6dsx_read_fifo()
Date: Thu, 12 Jul 2018 00:15:12 +0200
Message-Id: <20180711221512.20366-1-lorenzo.bianconi@redhat.com>
List-ID: <linux-iio@vger.kernel.org>

Add debug info to error conditions in st_lsm6dsx_read_fifo routine

Suggested-by: Jorge Ramirez-Ortiz <jramirez@baylibre.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 4994f920a836..7589f2ad1dae 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -298,8 +298,11 @@ static int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 	err = regmap_bulk_read(hw->regmap,
 			       hw->settings->fifo_ops.fifo_diff.addr,
 			       &fifo_status, sizeof(fifo_status));
-	if (err < 0)
+	if (err < 0) {
+		dev_err(hw->dev, "failed to read fifo status (err=%d)\n",
+			err);
 		return err;
+	}
 
 	if (fifo_status & cpu_to_le16(ST_LSM6DSX_FIFO_EMPTY_MASK))
 		return 0;
@@ -313,8 +316,12 @@ static int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 
 	for (read_len = 0; read_len < fifo_len; read_len += pattern_len) {
 		err = st_lsm6dsx_read_block(hw, hw->buff, pattern_len);
-		if (err < 0)
+		if (err < 0) {
+			dev_err(hw->dev,
+				"failed to read pattern from fifo (err=%d)\n",
+				err);
 			return err;
+		}
 
 		/*
 		 * Data are written to the FIFO with a specific pattern
@@ -385,8 +392,11 @@ static int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 
 	if (unlikely(reset_ts)) {
 		err = st_lsm6dsx_reset_hw_ts(hw);
-		if (err < 0)
+		if (err < 0) {
+			dev_err(hw->dev, "failed to reset hw ts (err=%d)\n",
+				err);
 			return err;
+		}
 	}
 	return read_len;
 }
-- 
2.18.0
