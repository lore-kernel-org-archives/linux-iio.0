Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34612 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbdC0Vm5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Mar 2017 17:42:57 -0400
Received: by mail-wr0-f195.google.com with SMTP id w43so14296181wrb.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Mar 2017 14:42:12 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
Subject: [PATCH v2] iio: imu: st_lsm6dsx: do not apply ODR configuration in write_raw handler
Date: Mon, 27 Mar 2017 23:42:07 +0200
Message-Id: <20170327214207.30966-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch allows to avoid a transitory that occurs when a given sensor
has been already enabled (e.g. gyroscope) and the user is configuring
the sample frequency of the other one (e.g. accelerometer).
Until the accelerometer is enabled gyroscope ODR is modified as well.
Fix it introducing st_lsm6dsx_check_odr() routine to check ODR consistency
in write_raw handler in order to apply frequency configuration just
in st_lsm6dsx_set_odr()

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
Changes since v1:
- Rename st_lsm6dsx_get_odr_val() in st_lsm6dsx_check_odr()
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 41 ++++++++++++++++++----------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index c433223..f80a3d4 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -308,32 +308,40 @@ static int st_lsm6dsx_set_full_scale(struct st_lsm6dsx_sensor *sensor,
 	return 0;
 }
 
-static int st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u16 odr)
+static int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u16 odr,
+				u8 *val)
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
+	err = st_lsm6dsx_check_odr(sensor, odr, &val);
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
+		err = st_lsm6dsx_check_odr(sensor, val, &data);
 		break;
+	}
 	default:
 		err = -EINVAL;
 		break;
-- 
2.9.3

