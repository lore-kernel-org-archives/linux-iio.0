Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41579 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbeHaA50 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Aug 2018 20:57:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id z96-v6so9266739wrb.8
        for <linux-iio@vger.kernel.org>; Thu, 30 Aug 2018 13:53:25 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 3/5] iio: imu: st_lsm6dsx: add addr/max_word_len to st_lsm6dsx_read_block()
Date: Thu, 30 Aug 2018 22:52:57 +0200
Message-Id: <20180830205259.7029-4-lorenzo.bianconi@redhat.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add reg addr and max_word_len parameters to st_lsm6dsx_read_block
since LSM6DSO will use a different register address to read samples
from the FIFO and a different sample len

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 7e02935a4250..2002ba4a1abd 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -255,18 +255,18 @@ static int st_lsm6dsx_reset_hw_ts(struct st_lsm6dsx_hw *hw)
  * Set max bulk read to ST_LSM6DSX_MAX_WORD_LEN in order to avoid
  * a kmalloc for each bus access
  */
-static inline int st_lsm6dsx_read_block(struct st_lsm6dsx_hw *hw, u8 *data,
-					unsigned int data_len)
+static inline int st_lsm6dsx_read_block(struct st_lsm6dsx_hw *hw, u8 addr,
+					u8 *data, unsigned int data_len,
+					unsigned int max_word_len)
 {
 	unsigned int word_len, read_len = 0;
 	int err;
 
 	while (read_len < data_len) {
 		word_len = min_t(unsigned int, data_len - read_len,
-				 ST_LSM6DSX_MAX_WORD_LEN);
-		err = regmap_bulk_read(hw->regmap,
-				       ST_LSM6DSX_REG_FIFO_OUTL_ADDR,
-				       data + read_len, word_len);
+				 max_word_len);
+		err = regmap_bulk_read(hw->regmap, addr, data + read_len,
+				       word_len);
 		if (err < 0)
 			return err;
 		read_len += word_len;
@@ -316,7 +316,9 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 	gyro_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_GYRO]);
 
 	for (read_len = 0; read_len < fifo_len; read_len += pattern_len) {
-		err = st_lsm6dsx_read_block(hw, hw->buff, pattern_len);
+		err = st_lsm6dsx_read_block(hw, ST_LSM6DSX_REG_FIFO_OUTL_ADDR,
+					    hw->buff, pattern_len,
+					    ST_LSM6DSX_MAX_WORD_LEN);
 		if (err < 0) {
 			dev_err(hw->dev,
 				"failed to read pattern from fifo (err=%d)\n",
-- 
2.18.0
