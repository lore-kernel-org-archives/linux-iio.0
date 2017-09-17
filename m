Return-Path: <SRS0=/wsa=AS=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	lorenzo.bianconi@st.com,
	devicetree@vger.kernel.org
Subject: [PATCH 3/4] iio: accel: add support to LIS3DHH
Date: Sun, 17 Sep 2017 18:17:11 +0200
Message-Id: <20170917161712.14645-4-lorenzo.bianconi@st.com>
In-Reply-To: <20170917161712.14645-1-lorenzo.bianconi@st.com>
References: <20170917161712.14645-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

add support to STMicroelectronics LIS3DHH accel sensor

http://www.st.com/resource/en/datasheet/lis3dhh.pdf
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/accel/st_accel.h      |  2 ++
 drivers/iio/accel/st_accel_core.c | 52 +++++++++++++++++++++++++++++++++++++++
 drivers/iio/accel/st_accel_spi.c  |  5 ++++
 3 files changed, 59 insertions(+)

diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
index 2ed0f60418c0..2f931e4837e5 100644
--- a/drivers/iio/accel/st_accel.h
+++ b/drivers/iio/accel/st_accel.h
@@ -33,6 +33,7 @@ enum st_accel_type {
 	LIS331DL,
 	LIS3LV02DL,
 	LIS2DW12,
+	LIS3DHH,
 	ST_ACCEL_MAX,
 };
 
@@ -54,6 +55,7 @@ enum st_accel_type {
 #define LIS3L02DQ_ACCEL_DEV_NAME	"lis3l02dq"
 #define LNG2DM_ACCEL_DEV_NAME		"lng2dm"
 #define LIS2DW12_ACCEL_DEV_NAME		"lis2dw12"
+#define LIS3DHH_ACCEL_DEV_NAME		"lis3dhh"
 
 /**
 * struct st_sensors_platform_data - default accel platform data
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index c88db25a1aff..460aa58e0159 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -777,6 +777,58 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 		.multi_read_bit = false,
 		.bootime = 2,
 	},
+	{
+		.wai = 0x11,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
+		.sensors_supported = {
+			[0] = LIS3DHH_ACCEL_DEV_NAME,
+		},
+		.ch = (struct iio_chan_spec *)st_accel_16bit_channels,
+		.odr = {
+			/* just ODR = 1100Hz available */
+			.odr_avl = {
+				{ .hz = 1100, .value = 0x00, },
+			},
+		},
+		.pw = {
+			.addr = 0x20,
+			.mask = 0x80,
+			.value_on = ST_SENSORS_DEFAULT_POWER_ON_VALUE,
+			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
+		},
+		.fs = {
+			.fs_avl = {
+				[0] = {
+					.num = ST_ACCEL_FS_AVL_2G,
+					.gain = IIO_G_TO_M_S_2(76),
+				},
+			},
+		},
+		.bdu = {
+			.addr = 0x20,
+			.mask = 0x01,
+		},
+		.drdy_irq = {
+			.int1 = {
+				.addr = 0x21,
+				.mask = 0x80,
+				.addr_od = 0x23,
+				.mask_od = 0x04,
+			},
+			.int2 = {
+				.addr = 0x22,
+				.mask = 0x80,
+				.addr_od = 0x23,
+				.mask_od = 0x08,
+			},
+			.stat_drdy = {
+				.addr = ST_SENSORS_DEFAULT_STAT_ADDR,
+				.mask = 0x07,
+			},
+		},
+		.multi_read_bit = false,
+		.bootime = 2,
+	},
 };
 
 static int st_accel_read_raw(struct iio_dev *indio_dev,
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index 7692da49e59f..dcc9bd243a52 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -86,6 +86,10 @@ static const struct of_device_id st_accel_of_match[] = {
 		.compatible = "st,lis2dw12",
 		.data = LIS2DW12_ACCEL_DEV_NAME,
 	},
+	{
+		.compatible = "st,lis3dhh",
+		.data = LIS3DHH_ACCEL_DEV_NAME,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, st_accel_of_match);
@@ -138,6 +142,7 @@ static const struct spi_device_id st_accel_id_table[] = {
 	{ LIS331DL_ACCEL_DEV_NAME },
 	{ LIS3LV02DL_ACCEL_DEV_NAME },
 	{ LIS2DW12_ACCEL_DEV_NAME },
+	{ LIS3DHH_ACCEL_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_accel_id_table);
-- 
2.14.1
