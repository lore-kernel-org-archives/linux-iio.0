Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: linux-iio@vger.kernel.org
Cc: lee.jones@linaro.org, jic23@kernel.org,
	Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH] iio:pressure: Add support for LPS25H pressure sensor
Date: Thu, 20 Feb 2014 18:49:27 +0100
Message-Id: <1392918567-2195-1-git-send-email-denis.ciocca@st.com>
List-ID: <linux-iio@vger.kernel.org>

This patch adds support for the new barometer sensor: LPS25H.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/pressure/Kconfig            |  2 +-
 drivers/iio/pressure/st_pressure.h      |  1 +
 drivers/iio/pressure/st_pressure_core.c | 87 ++++++++++++++++++++++++++++++---
 drivers/iio/pressure/st_pressure_i2c.c  |  1 +
 drivers/iio/pressure/st_pressure_spi.c  |  1 +
 5 files changed, 84 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index a8b9cae..9949533 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -26,7 +26,7 @@ config IIO_ST_PRESS
 	select IIO_TRIGGERED_BUFFER if (IIO_BUFFER)
 	help
 	  Say yes here to build support for STMicroelectronics pressure
-	  sensors: LPS001WP, LPS331AP.
+	  sensors: LPS001WP, LPS25H, LPS331AP.
 
 	  This driver can also be built as a module. If so, these modules
 	  will be created:
diff --git a/drivers/iio/pressure/st_pressure.h b/drivers/iio/pressure/st_pressure.h
index 049c21a..242943c 100644
--- a/drivers/iio/pressure/st_pressure.h
+++ b/drivers/iio/pressure/st_pressure.h
@@ -15,6 +15,7 @@
 #include <linux/iio/common/st_sensors.h>
 
 #define LPS001WP_PRESS_DEV_NAME		"lps001wp"
+#define LPS25H_PRESS_DEV_NAME		"lps25h"
 #define LPS331AP_PRESS_DEV_NAME		"lps331ap"
 
 /**
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 58083f9..7418768 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -40,6 +40,9 @@
 /* FULLSCALE */
 #define ST_PRESS_FS_AVL_1260MB			1260
 
+#define ST_PRESS_1_OUT_XL_ADDR			0x28
+#define ST_TEMP_1_OUT_L_ADDR			0x2b
+
 /* CUSTOM VALUES FOR LPS331AP SENSOR */
 #define ST_PRESS_LPS331AP_WAI_EXP		0xbb
 #define ST_PRESS_LPS331AP_ODR_ADDR		0x20
@@ -62,8 +65,6 @@
 #define ST_PRESS_LPS331AP_DRDY_IRQ_INT2_MASK	0x20
 #define ST_PRESS_LPS331AP_MULTIREAD_BIT		true
 #define ST_PRESS_LPS331AP_TEMP_OFFSET		42500
-#define ST_PRESS_LPS331AP_OUT_XL_ADDR		0x28
-#define ST_TEMP_LPS331AP_OUT_L_ADDR		0x2b
 
 /* CUSTOM VALUES FOR LPS001WP SENSOR */
 #define ST_PRESS_LPS001WP_WAI_EXP		0xba
@@ -80,11 +81,36 @@
 #define ST_PRESS_LPS001WP_OUT_L_ADDR		0x28
 #define ST_TEMP_LPS001WP_OUT_L_ADDR		0x2a
 
-static const struct iio_chan_spec st_press_lps331ap_channels[] = {
+/* CUSTOM VALUES FOR LPS25H SENSOR */
+#define ST_PRESS_LPS25H_WAI_EXP			0xbd
+#define ST_PRESS_LPS25H_ODR_ADDR		0x20
+#define ST_PRESS_LPS25H_ODR_MASK		0x70
+#define ST_PRESS_LPS25H_ODR_AVL_1HZ_VAL		0x01
+#define ST_PRESS_LPS25H_ODR_AVL_7HZ_VAL		0x02
+#define ST_PRESS_LPS25H_ODR_AVL_13HZ_VAL	0x03
+#define ST_PRESS_LPS25H_ODR_AVL_25HZ_VAL	0x04
+#define ST_PRESS_LPS25H_PW_ADDR			0x20
+#define ST_PRESS_LPS25H_PW_MASK			0x80
+#define ST_PRESS_LPS25H_FS_ADDR			0x00
+#define ST_PRESS_LPS25H_FS_MASK			0x00
+#define ST_PRESS_LPS25H_FS_AVL_1260_VAL		0x00
+#define ST_PRESS_LPS25H_FS_AVL_1260_GAIN	ST_PRESS_KPASCAL_NANO_SCALE
+#define ST_PRESS_LPS25H_FS_AVL_TEMP_GAIN	ST_PRESS_CELSIUS_NANO_SCALE
+#define ST_PRESS_LPS25H_BDU_ADDR		0x20
+#define ST_PRESS_LPS25H_BDU_MASK		0x04
+#define ST_PRESS_LPS25H_DRDY_IRQ_ADDR		0x23
+#define ST_PRESS_LPS25H_DRDY_IRQ_INT1_MASK	0x01
+#define ST_PRESS_LPS25H_DRDY_IRQ_INT2_MASK	0x10
+#define ST_PRESS_LPS25H_MULTIREAD_BIT		true
+#define ST_PRESS_LPS25H_TEMP_OFFSET		42500
+#define ST_PRESS_LPS25H_OUT_XL_ADDR		0x28
+#define ST_TEMP_LPS25H_OUT_L_ADDR		0x2b
+
+static const struct iio_chan_spec st_press_1_channels[] = {
 	{
 		.type = IIO_PRESSURE,
 		.channel2 = IIO_NO_MOD,
-		.address = ST_PRESS_LPS331AP_OUT_XL_ADDR,
+		.address = ST_PRESS_1_OUT_XL_ADDR,
 		.scan_index = ST_SENSORS_SCAN_X,
 		.scan_type = {
 			.sign = 'u',
@@ -99,7 +125,7 @@ static const struct iio_chan_spec st_press_lps331ap_channels[] = {
 	{
 		.type = IIO_TEMP,
 		.channel2 = IIO_NO_MOD,
-		.address = ST_TEMP_LPS331AP_OUT_L_ADDR,
+		.address = ST_TEMP_1_OUT_L_ADDR,
 		.scan_index = -1,
 		.scan_type = {
 			.sign = 'u',
@@ -156,8 +182,8 @@ static const struct st_sensors st_press_sensors[] = {
 		.sensors_supported = {
 			[0] = LPS331AP_PRESS_DEV_NAME,
 		},
-		.ch = (struct iio_chan_spec *)st_press_lps331ap_channels,
-		.num_ch = ARRAY_SIZE(st_press_lps331ap_channels),
+		.ch = (struct iio_chan_spec *)st_press_1_channels,
+		.num_ch = ARRAY_SIZE(st_press_1_channels),
 		.odr = {
 			.addr = ST_PRESS_LPS331AP_ODR_ADDR,
 			.mask = ST_PRESS_LPS331AP_ODR_MASK,
@@ -233,6 +259,53 @@ static const struct st_sensors st_press_sensors[] = {
 		.multi_read_bit = ST_PRESS_LPS001WP_MULTIREAD_BIT,
 		.bootime = 2,
 	},
+	{
+		.wai = ST_PRESS_LPS25H_WAI_EXP,
+		.sensors_supported = {
+			[0] = LPS25H_PRESS_DEV_NAME,
+		},
+		.ch = (struct iio_chan_spec *)st_press_1_channels,
+		.num_ch = ARRAY_SIZE(st_press_1_channels),
+		.odr = {
+			.addr = ST_PRESS_LPS25H_ODR_ADDR,
+			.mask = ST_PRESS_LPS25H_ODR_MASK,
+			.odr_avl = {
+				{ 1, ST_PRESS_LPS25H_ODR_AVL_1HZ_VAL, },
+				{ 7, ST_PRESS_LPS25H_ODR_AVL_7HZ_VAL, },
+				{ 13, ST_PRESS_LPS25H_ODR_AVL_13HZ_VAL, },
+				{ 25, ST_PRESS_LPS25H_ODR_AVL_25HZ_VAL, },
+			},
+		},
+		.pw = {
+			.addr = ST_PRESS_LPS25H_PW_ADDR,
+			.mask = ST_PRESS_LPS25H_PW_MASK,
+			.value_on = ST_SENSORS_DEFAULT_POWER_ON_VALUE,
+			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
+		},
+		.fs = {
+			.addr = ST_PRESS_LPS25H_FS_ADDR,
+			.mask = ST_PRESS_LPS25H_FS_MASK,
+			.fs_avl = {
+				[0] = {
+					.num = ST_PRESS_FS_AVL_1260MB,
+					.value = ST_PRESS_LPS25H_FS_AVL_1260_VAL,
+					.gain = ST_PRESS_LPS25H_FS_AVL_1260_GAIN,
+					.gain2 = ST_PRESS_LPS25H_FS_AVL_TEMP_GAIN,
+				},
+			},
+		},
+		.bdu = {
+			.addr = ST_PRESS_LPS25H_BDU_ADDR,
+			.mask = ST_PRESS_LPS25H_BDU_MASK,
+		},
+		.drdy_irq = {
+			.addr = ST_PRESS_LPS25H_DRDY_IRQ_ADDR,
+			.mask_int1 = ST_PRESS_LPS25H_DRDY_IRQ_INT1_MASK,
+			.mask_int2 = ST_PRESS_LPS25H_DRDY_IRQ_INT2_MASK,
+		},
+		.multi_read_bit = ST_PRESS_LPS25H_MULTIREAD_BIT,
+		.bootime = 2,
+	},
 };
 
 static int st_press_read_raw(struct iio_dev *indio_dev,
diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index 51eab7f..3cd73e3 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -50,6 +50,7 @@ static int st_press_i2c_remove(struct i2c_client *client)
 
 static const struct i2c_device_id st_press_id_table[] = {
 	{ LPS001WP_PRESS_DEV_NAME },
+	{ LPS25H_PRESS_DEV_NAME },
 	{ LPS331AP_PRESS_DEV_NAME },
 	{},
 };
diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
index 27322af..f45d430 100644
--- a/drivers/iio/pressure/st_pressure_spi.c
+++ b/drivers/iio/pressure/st_pressure_spi.c
@@ -49,6 +49,7 @@ static int st_press_spi_remove(struct spi_device *spi)
 
 static const struct spi_device_id st_press_id_table[] = {
 	{ LPS001WP_PRESS_DEV_NAME },
+	{ LPS25H_PRESS_DEV_NAME },
 	{ LPS331AP_PRESS_DEV_NAME },
 	{},
 };
-- 
1.9.0
