Return-Path: <gregor.boirie@parrot.com>
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, Linus Walleij <linus.walleij@linaro.org>, Denis Ciocca
	<denis.ciocca@st.com>, Giuseppe Barba <giuseppe.barba@st.com>, Crestez Dan
 Leonard <leonard.crestez@intel.com>, Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v2 4/7] iio:st_pressure: temperature triggered buffering
Date: Mon, 27 Jun 2016 12:38:55 +0200
Message-ID: <bc698636901bf2a39cb0f6f7d1a3405d36e83752.1467023672.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1467023672.git.gregor.boirie@parrot.com>
References: <cover.1467023672.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Enable support for triggered buffering of temperature samples.

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 drivers/iio/pressure/st_pressure_core.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 2ab1056..ea8241f 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -105,8 +105,6 @@
 #define ST_PRESS_LSB_PER_CELSIUS		480UL
 #define ST_PRESS_MILLI_CELSIUS_OFFSET		42500UL
 
-#define ST_PRESS_NUMBER_DATA_CHANNELS		1
-
 /* FULLSCALE */
 #define ST_PRESS_FS_AVL_1100MB			1100
 #define ST_PRESS_FS_AVL_1260MB			1260
@@ -222,7 +220,7 @@ static const struct iio_chan_spec st_press_1_channels[] = {
 		.type = IIO_PRESSURE,
 		.channel2 = IIO_NO_MOD,
 		.address = ST_PRESS_1_OUT_XL_ADDR,
-		.scan_index = ST_SENSORS_SCAN_X,
+		.scan_index = 0,
 		.scan_type = {
 			.sign = 'u',
 			.realbits = 24,
@@ -237,7 +235,7 @@ static const struct iio_chan_spec st_press_1_channels[] = {
 		.type = IIO_TEMP,
 		.channel2 = IIO_NO_MOD,
 		.address = ST_TEMP_1_OUT_L_ADDR,
-		.scan_index = -1,
+		.scan_index = 1,
 		.scan_type = {
 			.sign = 'u',
 			.realbits = 16,
@@ -250,7 +248,7 @@ static const struct iio_chan_spec st_press_1_channels[] = {
 			BIT(IIO_CHAN_INFO_OFFSET),
 		.modified = 0,
 	},
-	IIO_CHAN_SOFT_TIMESTAMP(1)
+	IIO_CHAN_SOFT_TIMESTAMP(2)
 };
 
 static const struct iio_chan_spec st_press_lps001wp_channels[] = {
@@ -258,7 +256,7 @@ static const struct iio_chan_spec st_press_lps001wp_channels[] = {
 		.type = IIO_PRESSURE,
 		.channel2 = IIO_NO_MOD,
 		.address = ST_PRESS_LPS001WP_OUT_L_ADDR,
-		.scan_index = ST_SENSORS_SCAN_X,
+		.scan_index = 0,
 		.scan_type = {
 			.sign = 'u',
 			.realbits = 16,
@@ -274,7 +272,7 @@ static const struct iio_chan_spec st_press_lps001wp_channels[] = {
 		.type = IIO_TEMP,
 		.channel2 = IIO_NO_MOD,
 		.address = ST_TEMP_LPS001WP_OUT_L_ADDR,
-		.scan_index = -1,
+		.scan_index = 1,
 		.scan_type = {
 			.sign = 'u',
 			.realbits = 16,
@@ -286,7 +284,7 @@ static const struct iio_chan_spec st_press_lps001wp_channels[] = {
 			BIT(IIO_CHAN_INFO_SCALE),
 		.modified = 0,
 	},
-	IIO_CHAN_SOFT_TIMESTAMP(1)
+	IIO_CHAN_SOFT_TIMESTAMP(2)
 };
 
 static const struct iio_chan_spec st_press_lps22hb_channels[] = {
@@ -642,7 +640,13 @@ int st_press_common_probe(struct iio_dev *indio_dev)
 	if (err < 0)
 		goto st_press_power_off;
 
-	press_data->num_data_channels = ST_PRESS_NUMBER_DATA_CHANNELS;
+	/*
+	 * Skip timestamping channel while declaring available channels to
+	 * common st_sensor layer. Look at st_sensors_get_buffer_element() to
+	 * see how timestamps are explicitly pushed as last samples block
+	 * element.
+	 */
+	press_data->num_data_channels = press_data->sensor_settings->num_ch - 1;
 	press_data->multiread_bit = press_data->sensor_settings->multi_read_bit;
 	indio_dev->channels = press_data->sensor_settings->ch;
 	indio_dev->num_channels = press_data->sensor_settings->num_ch;
-- 
2.1.4
