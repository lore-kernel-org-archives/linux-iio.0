Return-Path: <SRS0=Dm1u=NP=redhat.com=lorenzo.bianconi@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 3/7] iio: imu: st_lsm6dsx: remove static from st_lsm6dsx_set_watermark
Date: Sun,  4 Nov 2018 15:39:02 +0100
Message-Id: <732b033d7ea91401e674da6de67316277826e96f.1541341926.git.lorenzo.bianconi@redhat.com>
In-Reply-To: <cover.1541341926.git.lorenzo.bianconi@redhat.com>
References: <cover.1541341926.git.lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

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
index e3ebd04d8078..3433a5b6bf4d 100644
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
