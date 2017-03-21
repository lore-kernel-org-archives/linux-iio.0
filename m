Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33028 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758181AbdCUWfS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 18:35:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11so5679849wma.0
        for <linux-iio@vger.kernel.org>; Tue, 21 Mar 2017 15:35:12 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
Subject: [PATCH] iio: imu: st_lsm6dsx: do not apply ODR configuration in write_raw handler
Date: Tue, 21 Mar 2017 23:27:47 +0100
Message-Id: <20170321222747.5863-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

introduce st_lsm6dsx_get_odr_val() routine to check ODR consistency in
write_raw hablder in order to apply frequency configuration just in
st_lsm6dsx_set_odr()

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 41 ++++++++++++++++++----------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index c433223..70096f4 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -308,32 +308,40 @@ static int st_lsm6dsx_set_full_scale(struct st_lsm6dsx_sensor *sensor,
 	return 0;
 }
 
-static int st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u16 odr)
+static int st_lsm6dsx_get_odr_val(struct st_lsm6dsx_sensor *sensor, u16 odr,
+				  u8 *val)
 {
-	enum st_lsm6dsx_sensor_id id = sensor->id;
-	int i, err;
-	u8 val;
+	int i;
 
 	for (i = 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++)
-		if (st_lsm6dsx_odr_table[id].odr_avl[i].hz == odr)
+		if (st_lsm6dsx_odr_table[sensor->id].odr_avl[i].hz == odr)
 			break;
 
 	if (i == ST_LSM6DSX_ODR_LIST_SIZE)
 		return -EINVAL;
 
-	val = st_lsm6dsx_odr_table[id].odr_avl[i].val;
-	err = st_lsm6dsx_write_with_mask(sensor->hw,
-					 st_lsm6dsx_odr_table[id].reg.addr,
-					 st_lsm6dsx_odr_table[id].reg.mask,
-					 val);
-	if (err < 0)
-		return err;
-
+	*val = st_lsm6dsx_odr_table[sensor->id].odr_avl[i].val;
 	sensor->odr = odr;
 
 	return 0;
 }
 
+static int st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u16 odr)
+{
+	enum st_lsm6dsx_sensor_id id = sensor->id;
+	int err;
+	u8 val;
+
+	err = st_lsm6dsx_get_odr_val(sensor, odr, &val);
+	if (err < 0)
+		return err;
+
+	return st_lsm6dsx_write_with_mask(sensor->hw,
+					  st_lsm6dsx_odr_table[id].reg.addr,
+					  st_lsm6dsx_odr_table[id].reg.mask,
+					  val);
+}
+
 int st_lsm6dsx_sensor_enable(struct st_lsm6dsx_sensor *sensor)
 {
 	int err;
@@ -436,9 +444,12 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		err = st_lsm6dsx_set_full_scale(sensor, val2);
 		break;
-	case IIO_CHAN_INFO_SAMP_FREQ:
-		err = st_lsm6dsx_set_odr(sensor, val);
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		u8 data;
+
+		err = st_lsm6dsx_get_odr_val(sensor, val, &data);
 		break;
+	}
 	default:
 		err = -EINVAL;
 		break;
-- 
2.9.3

