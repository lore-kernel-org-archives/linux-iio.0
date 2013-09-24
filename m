Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, lee.jones@linaro.org,
	Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH] iio:magnetometer: Bugfix magnetometer default output registers
Date: Tue, 24 Sep 2013 16:51:34 +0200
Message-Id: <1380034294-22887-2-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1380034294-22887-1-git-send-email-denis.ciocca@st.com>
References: <1380034294-22887-1-git-send-email-denis.ciocca@st.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/magnetometer/st_magn_core.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index e8d2849..cab3bc7 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -29,9 +29,9 @@
 #define ST_MAGN_NUMBER_DATA_CHANNELS		3
 
 /* DEFAULT VALUE FOR SENSORS */
-#define ST_MAGN_DEFAULT_OUT_X_L_ADDR		0X04
-#define ST_MAGN_DEFAULT_OUT_Y_L_ADDR		0X08
-#define ST_MAGN_DEFAULT_OUT_Z_L_ADDR		0X06
+#define ST_MAGN_DEFAULT_OUT_X_H_ADDR		0X03
+#define ST_MAGN_DEFAULT_OUT_Y_H_ADDR		0X07
+#define ST_MAGN_DEFAULT_OUT_Z_H_ADDR		0X05
 
 /* FULLSCALE */
 #define ST_MAGN_FS_AVL_1300MG			1300
@@ -117,16 +117,16 @@
 static const struct iio_chan_spec st_magn_16bit_channels[] = {
 	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
-			ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE, 16, 16,
-			ST_MAGN_DEFAULT_OUT_X_L_ADDR),
+			ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_BE, 16, 16,
+			ST_MAGN_DEFAULT_OUT_X_H_ADDR),
 	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
-			ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_LE, 16, 16,
-			ST_MAGN_DEFAULT_OUT_Y_L_ADDR),
+			ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_BE, 16, 16,
+			ST_MAGN_DEFAULT_OUT_Y_H_ADDR),
 	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
-			ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_LE, 16, 16,
-			ST_MAGN_DEFAULT_OUT_Z_L_ADDR),
+			ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_BE, 16, 16,
+			ST_MAGN_DEFAULT_OUT_Z_H_ADDR),
 	IIO_CHAN_SOFT_TIMESTAMP(3)
 };
 
-- 
1.7.9.5
