Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: jic23@kernel.org, j.anaszewski@samsung.com,
	linux-iio@vger.kernel.org
Cc: Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 4/5] iio:magn: channel definition update and added get_buffer_element function pointer
Date: Tue, 14 May 2013 16:22:02 +0200
Message-Id: <1368541323-27423-5-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1368541323-27423-1-git-send-email-denis.ciocca@st.com>
References: <1368541323-27423-1-git-send-email-denis.ciocca@st.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/magnetometer/st_magn_core.c |   37 +++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 16f0d6d..3208ba8 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -113,22 +113,34 @@
 #define ST_MAGN_2_OUT_Z_L_ADDR			0x2c
 
 static const struct iio_chan_spec st_magn_16bit_channels[] = {
-	ST_SENSORS_LSM_CHANNELS(IIO_MAGN, ST_SENSORS_SCAN_X, IIO_MOD_X, IIO_LE,
-		ST_SENSORS_DEFAULT_16_REALBITS, ST_MAGN_DEFAULT_OUT_X_L_ADDR),
-	ST_SENSORS_LSM_CHANNELS(IIO_MAGN, ST_SENSORS_SCAN_Y, IIO_MOD_Y, IIO_LE,
-		ST_SENSORS_DEFAULT_16_REALBITS, ST_MAGN_DEFAULT_OUT_Y_L_ADDR),
-	ST_SENSORS_LSM_CHANNELS(IIO_MAGN, ST_SENSORS_SCAN_Z, IIO_MOD_Z, IIO_LE,
-		ST_SENSORS_DEFAULT_16_REALBITS, ST_MAGN_DEFAULT_OUT_Z_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE, 16, 16,
+			ST_MAGN_DEFAULT_OUT_X_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_LE, 16, 16,
+			ST_MAGN_DEFAULT_OUT_Y_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_LE, 16, 16,
+			ST_MAGN_DEFAULT_OUT_Z_L_ADDR),
 	IIO_CHAN_SOFT_TIMESTAMP(3)
 };
 
 static const struct iio_chan_spec st_magn_2_16bit_channels[] = {
-	ST_SENSORS_LSM_CHANNELS(IIO_MAGN, ST_SENSORS_SCAN_X, IIO_MOD_X, IIO_LE,
-		ST_SENSORS_DEFAULT_16_REALBITS, ST_MAGN_2_OUT_X_L_ADDR),
-	ST_SENSORS_LSM_CHANNELS(IIO_MAGN, ST_SENSORS_SCAN_Y, IIO_MOD_Y, IIO_LE,
-		ST_SENSORS_DEFAULT_16_REALBITS, ST_MAGN_2_OUT_Y_L_ADDR),
-	ST_SENSORS_LSM_CHANNELS(IIO_MAGN, ST_SENSORS_SCAN_Z, IIO_MOD_Z, IIO_LE,
-		ST_SENSORS_DEFAULT_16_REALBITS, ST_MAGN_2_OUT_Z_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE, 16, 16,
+			ST_MAGN_2_OUT_X_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_LE, 16, 16,
+			ST_MAGN_2_OUT_Y_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_LE, 16, 16,
+			ST_MAGN_2_OUT_Z_L_ADDR),
 	IIO_CHAN_SOFT_TIMESTAMP(3)
 };
 
@@ -344,6 +356,7 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
 	if (err < 0)
 		goto st_magn_common_probe_error;
 
+	mdata->get_buffer_element = &st_sensors_get_buffer_element;
 	mdata->multiread_bit = mdata->sensor->multi_read_bit;
 	indio_dev->channels = mdata->sensor->ch;
 	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
-- 
1.7.9.5
