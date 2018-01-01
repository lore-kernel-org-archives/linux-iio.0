Return-Path: <SRS0=bAY2=D4=redhat.com=lorenzo.bianconi@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: [PATCH 1/3] iio: imu: st_lsm6dsx: fix endianness in st_lsm6dsx_read_oneshot()
Date: Mon,  1 Jan 2018 19:54:42 +0100
Message-Id: <20180101185444.22045-2-lorenzo.bianconi@redhat.com>
List-ID: <linux-iio@vger.kernel.org>

Apply le16_to_cpu() to data read from the sensor in order to take into
account architecture endianness

Fixes: 290a6ce11d93 (iio: imu: add support to lsm6dsx driver)
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 239c735242be..812cd25f284e 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -448,7 +448,7 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
 
 	st_lsm6dsx_sensor_disable(sensor);
 
-	*val = (s16)data;
+	*val = (s16)le16_to_cpu(data);
 
 	return IIO_VAL_INT;
 }
-- 
2.15.1
