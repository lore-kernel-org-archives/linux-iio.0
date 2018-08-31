Return-Path: <SRS0=HIwy=LO=redhat.com=lorenzo.bianconi@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: [PATCH v2] iio: imu: st_lsm6dsx: take into account ts samples in wm configuration
Date: Fri, 31 Aug 2018 10:51:14 +0200
Message-Id: <d653e806f0aa1904bc0290b095837e13d6561a23.1535705166.git.lorenzo.bianconi@redhat.com>
In-Reply-To: <cover.1535705166.git.lorenzo.bianconi@redhat.com>
References: <cover.1535705166.git.lorenzo.bianconi@redhat.com>
List-ID: <linux-iio@vger.kernel.org>

Take into account hw timer samples in pattern length computation done
in st_lsm6dsx_update_watermark routine for watermark configuration.
Moreover use samples in pattern (sip) already computed in
st_lsm6dsx_update_decimators routine

Fixes: 213451076bd3 ("iio: imu: st_lsm6dsx: add hw timestamp support")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
---
Changes since v1:
- use samples in pattern already computed in st_lsm6dsx_update_decimators
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 7589f2ad1dae..631360b14ca7 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -187,12 +187,15 @@ static int st_lsm6dsx_set_fifo_odr(struct st_lsm6dsx_sensor *sensor,
 
 int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor, u16 watermark)
 {
-	u16 fifo_watermark = ~0, cur_watermark, sip = 0, fifo_th_mask;
+	u16 fifo_watermark = ~0, cur_watermark, fifo_th_mask;
 	struct st_lsm6dsx_hw *hw = sensor->hw;
 	struct st_lsm6dsx_sensor *cur_sensor;
 	int i, err, data;
 	__le16 wdata;
 
+	if (!hw->sip)
+		return 0;
+
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
 		cur_sensor = iio_priv(hw->iio_devs[i]);
 
@@ -203,14 +206,10 @@ int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor, u16 watermark)
 						       : cur_sensor->watermark;
 
 		fifo_watermark = min_t(u16, fifo_watermark, cur_watermark);
-		sip += cur_sensor->sip;
 	}
 
-	if (!sip)
-		return 0;
-
-	fifo_watermark = max_t(u16, fifo_watermark, sip);
-	fifo_watermark = (fifo_watermark / sip) * sip;
+	fifo_watermark = max_t(u16, fifo_watermark, hw->sip);
+	fifo_watermark = (fifo_watermark / hw->sip) * hw->sip;
 	fifo_watermark = fifo_watermark * hw->settings->fifo_ops.th_wl;
 
 	err = regmap_read(hw->regmap, hw->settings->fifo_ops.fifo_th.addr + 1,
-- 
2.17.1
