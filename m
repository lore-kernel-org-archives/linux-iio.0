Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37814 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbeKLAEe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Nov 2018 19:04:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id o15-v6so6543514wrv.4
        for <linux-iio@vger.kernel.org>; Sun, 11 Nov 2018 06:15:52 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 3/9] iio: imu: st_lsm6dsx: remove static from st_lsm6dsx_set_watermark
Date: Sun, 11 Nov 2018 15:15:30 +0100
Message-Id: <19b4dfa76bb6e06ccd7aa219d7867ccfca1e9c82.1541945612.git.lorenzo.bianconi@redhat.com>
In-Reply-To: <cover.1541945612.git.lorenzo.bianconi@redhat.com>
References: <cover.1541945612.git.lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Remove static qualifier from st_lsm6dsx_set_watermark routine in
order to be reused supporting st_lsm6dsx i2c controller

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      | 1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index ec204d3b4b1f..ac4cbbb0b3fb 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -185,6 +185,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
 int st_lsm6dsx_sensor_enable(struct st_lsm6dsx_sensor *sensor);
 int st_lsm6dsx_sensor_disable(struct st_lsm6dsx_sensor *sensor);
 int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw);
+int st_lsm6dsx_set_watermark(struct iio_dev *iio_dev, unsigned int val);
 int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor,
 				u16 watermark);
 int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 961ce9d65d82..d703fcd8706a 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -600,7 +600,7 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
 	return err;
 }
 
-static int st_lsm6dsx_set_watermark(struct iio_dev *iio_dev, unsigned int val)
+int st_lsm6dsx_set_watermark(struct iio_dev *iio_dev, unsigned int val)
 {
 	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
 	struct st_lsm6dsx_hw *hw = sensor->hw;
-- 
2.19.1
