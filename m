Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:35303 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754007AbbGPJTC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2015 05:19:02 -0400
Received: from pps.filterd (m0046670.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.14.5/8.14.5) with SMTP id t6G9Elrd018128
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2015 11:19:00 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com with ESMTP id 1vmbkf079f-1
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2015 11:19:00 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3091043
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2015 09:18:58 +0000 (GMT)
Received: from Webmail-eu.st.com (safex1hubcas1.st.com [10.75.90.14])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1488C14E7
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2015 09:18:58 +0000 (GMT)
From: Giuseppe Barba <giuseppe.barba@st.com>
To: <linux-iio@vger.kernel.org>
CC: Giuseppe Barba <giuseppe.barba@st.com>
Subject: [PATCH 2/5] iio: st-sensors: add full scale counter field
Date: Thu, 16 Jul 2015 11:17:41 +0200
Message-ID: <1437038264-12936-3-git-send-email-giuseppe.barba@st.com>
In-Reply-To: <1437038264-12936-1-git-send-email-giuseppe.barba@st.com>
References: <1437038264-12936-1-git-send-email-giuseppe.barba@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch add the full scale list size variable. This is
needed for code clenup and to enable device with a single
full scale value.

Signed-off-by: Giuseppe Barba <giuseppe.barba@st.com>
---
 drivers/iio/accel/st_accel_core.c               |  4 ++++
 drivers/iio/common/st_sensors/st_sensors_core.c | 10 +++++-----
 drivers/iio/gyro/st_gyro_core.c                 |  3 +++
 drivers/iio/magnetometer/st_magn_core.c         |  2 ++
 include/linux/iio/common/st_sensors.h           |  1 +
 5 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 7ce027b..207f6ef 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -283,6 +283,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 					.gain = ST_ACCEL_1_FS_AVL_16_GAIN,
 				},
 			},
+			.fs_avl_cnt = 4,
 		},
 		.bdu = {
 			.addr = ST_ACCEL_1_BDU_ADDR,
@@ -346,6 +347,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 					.gain = ST_ACCEL_2_FS_AVL_8_GAIN,
 				},
 			},
+			.fs_avl_cnt = 3,
 		},
 		.bdu = {
 			.addr = ST_ACCEL_2_BDU_ADDR,
@@ -421,6 +423,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 					.gain = ST_ACCEL_3_FS_AVL_16_GAIN,
 				},
 			},
+			.fs_avl_cnt = 5,
 		},
 		.bdu = {
 			.addr = ST_ACCEL_3_BDU_ADDR,
@@ -480,6 +483,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 					.gain = ST_ACCEL_4_FS_AVL_6_GAIN,
 				},
 			},
+			.fs_avl_cnt = 2,
 		},
 		.bdu = {
 			.addr = ST_ACCEL_4_BDU_ADDR,
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index c0a611e..d9845a6 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -106,7 +106,7 @@ static int st_sensors_match_fs(struct st_sensor_settings *sensor_settings,
 {
 	int i, ret = -EINVAL;
 
-	for (i = 0; i < ST_SENSORS_FULLSCALE_AVL_MAX; i++) {
+	for (i = 0; i < sensor_settings->fs.fs_avl_cnt; i++) {
 		if (sensor_settings->fs.fs_avl[i].num == 0)
 			goto st_sensors_match_odr_error;
 
@@ -126,6 +126,9 @@ static int st_sensors_set_fullscale(struct iio_dev *indio_dev, unsigned int fs)
 	int err, i = 0;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
+	if (sdata->sensor_settings->fs.fs_avl_cnt < 2)
+		return 0;
+
 	err = st_sensors_match_fs(sdata->sensor_settings, fs, &i);
 	if (err < 0)
 		goto st_accel_set_fullscale_error;
@@ -560,10 +563,7 @@ ssize_t st_sensors_sysfs_scale_avail(struct device *dev,
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
 	mutex_lock(&indio_dev->mlock);
-	for (i = 0; i < ST_SENSORS_FULLSCALE_AVL_MAX; i++) {
-		if (sdata->sensor_settings->fs.fs_avl[i].num == 0)
-			break;
-
+	for (i = 0; i < sdata->sensor_settings->fs.fs_avl_cnt; i++) {
 		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%06u ",
 				sdata->sensor_settings->fs.fs_avl[i].gain);
 	}
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index 4b993a5..c06e8f7 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -177,6 +177,7 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
 					.gain = ST_GYRO_1_FS_AVL_2000_GAIN,
 				},
 			},
+			.fs_avl_cnt = 3,
 		},
 		.bdu = {
 			.addr = ST_GYRO_1_BDU_ADDR,
@@ -240,6 +241,7 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
 					.gain = ST_GYRO_2_FS_AVL_2000_GAIN,
 				},
 			},
+			.fs_avl_cnt = 3,
 		},
 		.bdu = {
 			.addr = ST_GYRO_2_BDU_ADDR,
@@ -299,6 +301,7 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
 					.gain = ST_GYRO_3_FS_AVL_2000_GAIN,
 				},
 			},
+			.fs_avl_cnt = 3,
 		},
 		.bdu = {
 			.addr = ST_GYRO_3_BDU_ADDR,
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 63da293..4c0335b 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -341,6 +341,7 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
 					.gain2 = ST_MAGN_1_FS_AVL_8100_GAIN_Z,
 				},
 			},
+			.fs_avl_cnt = 7,
 		},
 		.multi_read_bit = ST_MAGN_1_MULTIREAD_BIT,
 		.bootime = 2,
@@ -397,6 +398,7 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
 					.gain = ST_MAGN_2_FS_AVL_16000_GAIN,
 				},
 			},
+			.fs_avl_cnt = 4,
 		},
 		.multi_read_bit = ST_MAGN_2_MULTIREAD_BIT,
 		.bootime = 2,
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index f7c77b4..0d7d5bb 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -101,6 +101,7 @@ struct st_sensor_fullscale_avl {
 struct st_sensor_fullscale {
 	u8 addr;
 	u8 mask;
+	u8 fs_avl_cnt;
 	struct st_sensor_fullscale_avl fs_avl[ST_SENSORS_FULLSCALE_AVL_MAX];
 };
 
-- 
1.9.1

