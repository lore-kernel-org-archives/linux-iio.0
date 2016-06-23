Return-Path: <gregor.boirie@parrot.com>
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, Linus Walleij <linus.walleij@linaro.org>, Denis Ciocca
	<denis.ciocca@st.com>, Giuseppe Barba <giuseppe.barba@st.com>, Crestez Dan
 Leonard <leonard.crestez@intel.com>, Gregor Boirie
	<gregor.boirie@parrot.com>, <Stable@vger.kernel.org>
Subject: [PATCH v1 1/7] iio:st_pressure: fix sampling gains (bring inline with ABI)
Date: Thu, 23 Jun 2016 15:49:43 +0200
Message-ID: <dc54de9127f25a24332a115adcac92fd3659caea.1466687364.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1466687364.git.gregor.boirie@parrot.com>
References: <cover.1466687364.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Temperature channels report scaled samples in Celsius although expected as
milli degree Celsius in Documentation/ABI/testing/sysfs-bus-iio.
Gains are not implemented at all for LPS001WP pressure and temperature
channels.

This patch ensures that proper offsets and scales are exposed to userpace
for both pressure and temperature channels.
Also fix a NULL pointer exception when userspace reads content of sysfs
scale attribute when gains are not defined.

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/pressure/st_pressure_core.c | 80 ++++++++++++++++++++-------------
 1 file changed, 50 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 4d317af..79616e0 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -28,15 +28,21 @@
 #include <linux/iio/common/st_sensors.h>
 #include "st_pressure.h"
 
+#define MCELSIUS_PER_CELSIUS			1000
+
+/* Default pressure sensitivity */
 #define ST_PRESS_LSB_PER_MBAR			4096UL
 #define ST_PRESS_KPASCAL_NANO_SCALE		(100000000UL / \
 						 ST_PRESS_LSB_PER_MBAR)
+
+/* Default temperature sensitivity */
 #define ST_PRESS_LSB_PER_CELSIUS		480UL
-#define ST_PRESS_CELSIUS_NANO_SCALE		(1000000000UL / \
-						 ST_PRESS_LSB_PER_CELSIUS)
+#define ST_PRESS_MILLI_CELSIUS_OFFSET		42500UL
+
 #define ST_PRESS_NUMBER_DATA_CHANNELS		1
 
 /* FULLSCALE */
+#define ST_PRESS_FS_AVL_1100MB			1100
 #define ST_PRESS_FS_AVL_1260MB			1260
 
 #define ST_PRESS_1_OUT_XL_ADDR			0x28
@@ -54,9 +60,6 @@
 #define ST_PRESS_LPS331AP_PW_MASK		0x80
 #define ST_PRESS_LPS331AP_FS_ADDR		0x23
 #define ST_PRESS_LPS331AP_FS_MASK		0x30
-#define ST_PRESS_LPS331AP_FS_AVL_1260_VAL	0x00
-#define ST_PRESS_LPS331AP_FS_AVL_1260_GAIN	ST_PRESS_KPASCAL_NANO_SCALE
-#define ST_PRESS_LPS331AP_FS_AVL_TEMP_GAIN	ST_PRESS_CELSIUS_NANO_SCALE
 #define ST_PRESS_LPS331AP_BDU_ADDR		0x20
 #define ST_PRESS_LPS331AP_BDU_MASK		0x04
 #define ST_PRESS_LPS331AP_DRDY_IRQ_ADDR		0x22
@@ -67,9 +70,14 @@
 #define ST_PRESS_LPS331AP_OD_IRQ_ADDR		0x22
 #define ST_PRESS_LPS331AP_OD_IRQ_MASK		0x40
 #define ST_PRESS_LPS331AP_MULTIREAD_BIT		true
-#define ST_PRESS_LPS331AP_TEMP_OFFSET		42500
 
 /* CUSTOM VALUES FOR LPS001WP SENSOR */
+
+/* LPS001WP pressure resolution */
+#define ST_PRESS_LPS001WP_LSB_PER_MBAR		16UL
+/* LPS001WP temperature resolution */
+#define ST_PRESS_LPS001WP_LSB_PER_CELSIUS	64UL
+
 #define ST_PRESS_LPS001WP_WAI_EXP		0xba
 #define ST_PRESS_LPS001WP_ODR_ADDR		0x20
 #define ST_PRESS_LPS001WP_ODR_MASK		0x30
@@ -78,6 +86,8 @@
 #define ST_PRESS_LPS001WP_ODR_AVL_13HZ_VAL	0x03
 #define ST_PRESS_LPS001WP_PW_ADDR		0x20
 #define ST_PRESS_LPS001WP_PW_MASK		0x40
+#define ST_PRESS_LPS001WP_FS_AVL_PRESS_GAIN \
+	(100000000UL / ST_PRESS_LPS001WP_LSB_PER_MBAR)
 #define ST_PRESS_LPS001WP_BDU_ADDR		0x20
 #define ST_PRESS_LPS001WP_BDU_MASK		0x04
 #define ST_PRESS_LPS001WP_MULTIREAD_BIT		true
@@ -94,11 +104,6 @@
 #define ST_PRESS_LPS25H_ODR_AVL_25HZ_VAL	0x04
 #define ST_PRESS_LPS25H_PW_ADDR			0x20
 #define ST_PRESS_LPS25H_PW_MASK			0x80
-#define ST_PRESS_LPS25H_FS_ADDR			0x00
-#define ST_PRESS_LPS25H_FS_MASK			0x00
-#define ST_PRESS_LPS25H_FS_AVL_1260_VAL		0x00
-#define ST_PRESS_LPS25H_FS_AVL_1260_GAIN	ST_PRESS_KPASCAL_NANO_SCALE
-#define ST_PRESS_LPS25H_FS_AVL_TEMP_GAIN	ST_PRESS_CELSIUS_NANO_SCALE
 #define ST_PRESS_LPS25H_BDU_ADDR		0x20
 #define ST_PRESS_LPS25H_BDU_MASK		0x04
 #define ST_PRESS_LPS25H_DRDY_IRQ_ADDR		0x23
@@ -109,7 +114,6 @@
 #define ST_PRESS_LPS25H_OD_IRQ_ADDR		0x22
 #define ST_PRESS_LPS25H_OD_IRQ_MASK		0x40
 #define ST_PRESS_LPS25H_MULTIREAD_BIT		true
-#define ST_PRESS_LPS25H_TEMP_OFFSET		42500
 #define ST_PRESS_LPS25H_OUT_XL_ADDR		0x28
 #define ST_TEMP_LPS25H_OUT_L_ADDR		0x2b
 
@@ -181,7 +185,9 @@ static const struct iio_chan_spec st_press_lps001wp_channels[] = {
 			.storagebits = 16,
 			.endianness = IIO_LE,
 		},
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE),
 		.modified = 0,
 	},
 	{
@@ -197,7 +203,7 @@ static const struct iio_chan_spec st_press_lps001wp_channels[] = {
 		},
 		.info_mask_separate =
 			BIT(IIO_CHAN_INFO_RAW) |
-			BIT(IIO_CHAN_INFO_OFFSET),
+			BIT(IIO_CHAN_INFO_SCALE),
 		.modified = 0,
 	},
 	IIO_CHAN_SOFT_TIMESTAMP(1)
@@ -253,11 +259,14 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
 			.addr = ST_PRESS_LPS331AP_FS_ADDR,
 			.mask = ST_PRESS_LPS331AP_FS_MASK,
 			.fs_avl = {
+				/*
+				 * Pressure and temperature sensitivity values
+				 * as defined in table 3 of LPS331AP datasheet.
+				 */
 				[0] = {
 					.num = ST_PRESS_FS_AVL_1260MB,
-					.value = ST_PRESS_LPS331AP_FS_AVL_1260_VAL,
-					.gain = ST_PRESS_LPS331AP_FS_AVL_1260_GAIN,
-					.gain2 = ST_PRESS_LPS331AP_FS_AVL_TEMP_GAIN,
+					.gain = ST_PRESS_KPASCAL_NANO_SCALE,
+					.gain2 = ST_PRESS_LSB_PER_CELSIUS,
 				},
 			},
 		},
@@ -302,7 +311,17 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
 			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
 		},
 		.fs = {
-			.addr = 0,
+			.fs_avl = {
+				/*
+				 * Pressure and temperature resolution values
+				 * as defined in table 3 of LPS001WP datasheet.
+				 */
+				[0] = {
+					.num = ST_PRESS_FS_AVL_1100MB,
+					.gain = ST_PRESS_LPS001WP_FS_AVL_PRESS_GAIN,
+					.gain2 = ST_PRESS_LPS001WP_LSB_PER_CELSIUS,
+				},
+			},
 		},
 		.bdu = {
 			.addr = ST_PRESS_LPS001WP_BDU_ADDR,
@@ -339,14 +358,15 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
 			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
 		},
 		.fs = {
-			.addr = ST_PRESS_LPS25H_FS_ADDR,
-			.mask = ST_PRESS_LPS25H_FS_MASK,
 			.fs_avl = {
+				/*
+				 * Pressure and temperature sensitivity values
+				 * as defined in table 3 of LPS25H datasheet.
+				 */
 				[0] = {
 					.num = ST_PRESS_FS_AVL_1260MB,
-					.value = ST_PRESS_LPS25H_FS_AVL_1260_VAL,
-					.gain = ST_PRESS_LPS25H_FS_AVL_1260_GAIN,
-					.gain2 = ST_PRESS_LPS25H_FS_AVL_TEMP_GAIN,
+					.gain = ST_PRESS_KPASCAL_NANO_SCALE,
+					.gain2 = ST_PRESS_LSB_PER_CELSIUS,
 				},
 			},
 		},
@@ -450,26 +470,26 @@ static int st_press_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		*val = 0;
-
 		switch (ch->type) {
 		case IIO_PRESSURE:
+			*val = 0;
 			*val2 = press_data->current_fullscale->gain;
-			break;
+			return IIO_VAL_INT_PLUS_NANO;
 		case IIO_TEMP:
+			*val = MCELSIUS_PER_CELSIUS;
 			*val2 = press_data->current_fullscale->gain2;
-			break;
+			return IIO_VAL_FRACTIONAL;
 		default:
 			err = -EINVAL;
 			goto read_error;
 		}
 
-		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_CHAN_INFO_OFFSET:
 		switch (ch->type) {
 		case IIO_TEMP:
-			*val = 425;
-			*val2 = 10;
+			*val = ST_PRESS_MILLI_CELSIUS_OFFSET *
+			       press_data->current_fullscale->gain2;
+			*val2 = MCELSIUS_PER_CELSIUS;
 			break;
 		default:
 			err = -EINVAL;
-- 
2.1.4
