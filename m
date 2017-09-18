Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33781 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755299AbdIRRuB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Sep 2017 13:50:01 -0400
Received: by mail-wm0-f68.google.com with SMTP id m127so1631779wmm.0
        for <linux-iio@vger.kernel.org>; Mon, 18 Sep 2017 10:50:00 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
Subject: [PATCH] iio: imu: st_lsm6dsx: set sensor->odr value just in st_lsm6dsx_write_raw()
Date: Mon, 18 Sep 2017 19:49:57 +0200
Message-Id: <20170918174957.12533-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Update odr value in st_lsm6dsx_sensor data structure just in
st_lsm6dsx_write_raw() in order to avoid to set the same value
multiple times

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index d45d714acdd3..c68cc7c91928 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -322,7 +322,6 @@ static int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u16 odr,
 		return -EINVAL;
 
 	*val = st_lsm6dsx_odr_table[sensor->id].odr_avl[i].val;
-	sensor->odr = odr;
 
 	return 0;
 }
@@ -449,6 +448,8 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
 		u8 data;
 
 		err = st_lsm6dsx_check_odr(sensor, val, &data);
+		if (!err)
+			sensor->odr = val;
 		break;
 	}
 	default:
-- 
2.14.1

