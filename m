Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37057 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751377AbeAFWXn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Jan 2018 17:23:43 -0500
Received: by mail-wr0-f196.google.com with SMTP id f8so7328502wre.4
        for <linux-iio@vger.kernel.org>; Sat, 06 Jan 2018 14:23:43 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: [PATCH 2/2] iio: imu: st_lsm6dsx: remove st_lsm6dsx_write_with_mask() declaration
Date: Sat,  6 Jan 2018 23:23:25 +0100
Message-Id: <20180106222325.17442-3-lorenzo.bianconi@redhat.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Remove st_lsm6dsx_write_with_mask() declaration since it has been removed
in commit 6674bef628e6 ("iio: imu: st_lsm6dsx: add regmap API support")

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 35acb9c96745..8fdd723afa05 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -153,8 +153,6 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
 int st_lsm6dsx_sensor_enable(struct st_lsm6dsx_sensor *sensor);
 int st_lsm6dsx_sensor_disable(struct st_lsm6dsx_sensor *sensor);
 int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw);
-int st_lsm6dsx_write_with_mask(struct st_lsm6dsx_hw *hw, u8 addr, u8 mask,
-			       u8 val);
 int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor,
 				u16 watermark);
 int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw);
-- 
2.15.1

