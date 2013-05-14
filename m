Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: jic23@kernel.org, j.anaszewski@samsung.com,
	linux-iio@vger.kernel.org
Cc: Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 3/5] iio:gyro: channel definition update and added get_buffer_element function pointer
Date: Tue, 14 May 2013 16:22:01 +0200
Message-Id: <1368541323-27423-4-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1368541323-27423-1-git-send-email-denis.ciocca@st.com>
References: <1368541323-27423-1-git-send-email-denis.ciocca@st.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/gyro/st_gyro_core.c |   22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index fa9b242..56e9253 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -86,15 +86,18 @@
 #define ST_GYRO_2_MULTIREAD_BIT			true
 
 static const struct iio_chan_spec st_gyro_16bit_channels[] = {
-	ST_SENSORS_LSM_CHANNELS(IIO_ANGL_VEL, ST_SENSORS_SCAN_X,
-		IIO_MOD_X, IIO_LE, ST_SENSORS_DEFAULT_16_REALBITS,
-						ST_GYRO_DEFAULT_OUT_X_L_ADDR),
-	ST_SENSORS_LSM_CHANNELS(IIO_ANGL_VEL, ST_SENSORS_SCAN_Y,
-		IIO_MOD_Y, IIO_LE, ST_SENSORS_DEFAULT_16_REALBITS,
-						ST_GYRO_DEFAULT_OUT_Y_L_ADDR),
-	ST_SENSORS_LSM_CHANNELS(IIO_ANGL_VEL, ST_SENSORS_SCAN_Z,
-		IIO_MOD_Z, IIO_LE, ST_SENSORS_DEFAULT_16_REALBITS,
-						ST_GYRO_DEFAULT_OUT_Z_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_ANGL_VEL,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE, 16, 16,
+			ST_GYRO_DEFAULT_OUT_X_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_ANGL_VEL,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_LE, 16, 16,
+			ST_GYRO_DEFAULT_OUT_Y_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_ANGL_VEL,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_LE, 16, 16,
+			ST_GYRO_DEFAULT_OUT_Z_L_ADDR),
 	IIO_CHAN_SOFT_TIMESTAMP(3)
 };
 
@@ -310,6 +313,7 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
 	if (err < 0)
 		goto st_gyro_common_probe_error;
 
+	gdata->get_buffer_element = &st_sensors_get_buffer_element;
 	gdata->multiread_bit = gdata->sensor->multi_read_bit;
 	indio_dev->channels = gdata->sensor->ch;
 	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
-- 
1.7.9.5
