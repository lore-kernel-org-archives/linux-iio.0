Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37462 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbeHaAnU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Aug 2018 20:43:20 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11-v6so3289186wmc.2
        for <linux-iio@vger.kernel.org>; Thu, 30 Aug 2018 13:39:22 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: [PATCH] iio: imu: st_lsm6dsx: take into account ts samples in wm configuration
Date: Thu, 30 Aug 2018 22:38:59 +0200
Message-Id: <20180830203859.6527-1-lorenzo.bianconi@redhat.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Take into account hw timer samples in pattern length computation used
in st_lsm6dsx_update_watermark routine for watermark configuration

Fixes: 213451076bd3 ("iio: imu: st_lsm6dsx: add hw timestamp support")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 7589f2ad1dae..2b49d928f4c0 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -187,9 +187,10 @@ static int st_lsm6dsx_set_fifo_odr(struct st_lsm6dsx_sensor *sensor,
 
 int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor, u16 watermark)
 {
-	u16 fifo_watermark = ~0, cur_watermark, sip = 0, fifo_th_mask;
+	u16 fifo_watermark = ~0, cur_watermark, fifo_th_mask;
 	struct st_lsm6dsx_hw *hw = sensor->hw;
 	struct st_lsm6dsx_sensor *cur_sensor;
+	u16 sip = hw->ts_sip;
 	int i, err, data;
 	__le16 wdata;
 
-- 
2.18.0
