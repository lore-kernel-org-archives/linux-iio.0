Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:35389 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754169AbbGPJTG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2015 05:19:06 -0400
Received: from pps.filterd (m0046670.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.14.5/8.14.5) with SMTP id t6G9EWkr017979
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2015 11:19:04 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com with ESMTP id 1vmbkf079r-1
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2015 11:19:04 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C254C3F
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2015 09:19:01 +0000 (GMT)
Received: from Webmail-eu.st.com (safex1hubcas1.st.com [10.75.90.14])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A85C415BC
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2015 09:19:01 +0000 (GMT)
From: Giuseppe Barba <giuseppe.barba@st.com>
To: <linux-iio@vger.kernel.org>
CC: Giuseppe Barba <giuseppe.barba@st.com>
Subject: [PATCH 5/5] iio: st-magn: add support for lsm303agr magnetometer
Date: Thu, 16 Jul 2015 11:17:44 +0200
Message-ID: <1437038264-12936-6-git-send-email-giuseppe.barba@st.com>
In-Reply-To: <1437038264-12936-1-git-send-email-giuseppe.barba@st.com>
References: <1437038264-12936-1-git-send-email-giuseppe.barba@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds support for the lsm303agr magnetometer.

Signed-off-by: Giuseppe Barba <giuseppe.barba@st.com>
---
 .../devicetree/bindings/iio/st-sensors.txt         |  1 +
 drivers/iio/magnetometer/st_magn.h                 |  1 +
 drivers/iio/magnetometer/st_magn_core.c            | 83 ++++++++++++++++++++++
 drivers/iio/magnetometer/st_magn_i2c.c             |  5 ++
 drivers/iio/magnetometer/st_magn_spi.c             |  1 +
 5 files changed, 91 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
index d80bdaa..d3ccdb1 100644
--- a/Documentation/devicetree/bindings/iio/st-sensors.txt
+++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
@@ -47,6 +47,7 @@ Gyroscopes:
 - st,lsm330-gyro
 
 Magnetometers:
+- st,lsm303agr-magn
 - st,lsm303dlh-magn
 - st,lsm303dlhc-magn
 - st,lsm303dlm-magn
diff --git a/drivers/iio/magnetometer/st_magn.h b/drivers/iio/magnetometer/st_magn.h
index 60441023..06a4d9c 100644
--- a/drivers/iio/magnetometer/st_magn.h
+++ b/drivers/iio/magnetometer/st_magn.h
@@ -18,6 +18,7 @@
 #define LSM303DLHC_MAGN_DEV_NAME	"lsm303dlhc_magn"
 #define LSM303DLM_MAGN_DEV_NAME		"lsm303dlm_magn"
 #define LIS3MDL_MAGN_DEV_NAME		"lis3mdl"
+#define LSM303AGR_MAGN_DEV_NAME		"lsm303agr_magn"
 
 int st_magn_common_probe(struct iio_dev *indio_dev);
 void st_magn_common_remove(struct iio_dev *indio_dev);
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 4948185..8259e02 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -43,6 +43,7 @@
 #define ST_MAGN_FS_AVL_8000MG			8000
 #define ST_MAGN_FS_AVL_8100MG			8100
 #define ST_MAGN_FS_AVL_12000MG			12000
+#define ST_MAGN_FS_AVL_15000MG			15000
 #define ST_MAGN_FS_AVL_16000MG			16000
 
 /* CUSTOM VALUES FOR SENSOR 0 */
@@ -157,6 +158,29 @@
 #define ST_MAGN_2_OUT_Y_L_ADDR			0x2a
 #define ST_MAGN_2_OUT_Z_L_ADDR			0x2c
 
+/* CUSTOM VALUES FOR SENSOR 3 */
+#define ST_MAGN_3_WAI_ADDR			0x4f
+#define ST_MAGN_3_WAI_EXP			0x40
+#define ST_MAGN_3_ODR_ADDR			0x60
+#define ST_MAGN_3_ODR_MASK			0x0c
+#define ST_MAGN_3_ODR_AVL_10HZ_VAL		0x00
+#define ST_MAGN_3_ODR_AVL_20HZ_VAL		0x01
+#define ST_MAGN_3_ODR_AVL_50HZ_VAL		0x02
+#define ST_MAGN_3_ODR_AVL_100HZ_VAL		0x03
+#define ST_MAGN_3_PW_ADDR			0x60
+#define ST_MAGN_3_PW_MASK			0x03
+#define ST_MAGN_3_PW_ON				0x00
+#define ST_MAGN_3_PW_OFF			0x03
+#define ST_MAGN_3_BDU_ADDR			0x62
+#define ST_MAGN_3_BDU_MASK			0x10
+#define ST_MAGN_3_DRDY_IRQ_ADDR			0x62
+#define ST_MAGN_3_DRDY_INT_MASK			0x01
+#define ST_MAGN_3_FS_AVL_15000_GAIN		1500
+#define ST_MAGN_3_MULTIREAD_BIT			false
+#define ST_MAGN_3_OUT_X_L_ADDR			0x68
+#define ST_MAGN_3_OUT_Y_L_ADDR			0x6a
+#define ST_MAGN_3_OUT_Z_L_ADDR			0x6c
+
 static const struct iio_chan_spec st_magn_16bit_channels[] = {
 	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
@@ -189,6 +213,22 @@ static const struct iio_chan_spec st_magn_2_16bit_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(3)
 };
 
+static const struct iio_chan_spec st_magn_3_16bit_channels[] = {
+	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE, 16, 16,
+			ST_MAGN_3_OUT_X_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_LE, 16, 16,
+			ST_MAGN_3_OUT_Y_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_LE, 16, 16,
+			ST_MAGN_3_OUT_Z_L_ADDR),
+	IIO_CHAN_SOFT_TIMESTAMP(3)
+};
+
 static const struct st_sensor_settings st_magn_sensors_settings[] = {
 	{
 		.wai = 0, /* This sensor has no valid WhoAmI report 0 */
@@ -403,6 +443,49 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
 		.multi_read_bit = ST_MAGN_2_MULTIREAD_BIT,
 		.bootime = 2,
 	},
+	{
+		.wai = ST_MAGN_3_WAI_EXP,
+		.wai_addr = ST_MAGN_3_WAI_ADDR,
+		.sensors_supported = {
+			[0] = LSM303AGR_MAGN_DEV_NAME,
+		},
+		.ch = (struct iio_chan_spec *)st_magn_3_16bit_channels,
+		.odr = {
+			.addr = ST_MAGN_3_ODR_ADDR,
+			.mask = ST_MAGN_3_ODR_MASK,
+			.odr_avl = {
+				{ 10, ST_MAGN_3_ODR_AVL_10HZ_VAL, },
+				{ 20, ST_MAGN_3_ODR_AVL_20HZ_VAL, },
+				{ 50, ST_MAGN_3_ODR_AVL_50HZ_VAL, },
+				{ 100, ST_MAGN_3_ODR_AVL_100HZ_VAL, },
+			},
+		},
+		.pw = {
+			.addr = ST_MAGN_3_PW_ADDR,
+			.mask = ST_MAGN_3_PW_MASK,
+			.value_on = ST_MAGN_3_PW_ON,
+			.value_off = ST_MAGN_3_PW_OFF,
+		},
+		.fs = {
+			.fs_avl = {
+				[0] = {
+					.num = ST_MAGN_FS_AVL_15000MG,
+					.gain = ST_MAGN_3_FS_AVL_15000_GAIN,
+				},
+			},
+			.fs_avl_cnt = 1,
+		},
+		.bdu = {
+			.addr = ST_MAGN_3_BDU_ADDR,
+			.mask = ST_MAGN_3_BDU_MASK,
+		},
+		.drdy_irq = {
+			.addr = ST_MAGN_3_DRDY_IRQ_ADDR,
+			.mask_int1 = ST_MAGN_3_DRDY_INT_MASK,
+		},
+		.multi_read_bit = ST_MAGN_3_MULTIREAD_BIT,
+		.bootime = 2,
+	},
 };
 
 static int st_magn_read_raw(struct iio_dev *indio_dev,
diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
index 5311d8a..afe955b 100644
--- a/drivers/iio/magnetometer/st_magn_i2c.c
+++ b/drivers/iio/magnetometer/st_magn_i2c.c
@@ -36,6 +36,10 @@ static const struct of_device_id st_magn_of_match[] = {
 		.compatible = "st,lis3mdl-magn",
 		.data = LIS3MDL_MAGN_DEV_NAME,
 	},
+	{
+		.compatible = "st,lsm303agr-magn",
+		.data = LSM303AGR_MAGN_DEV_NAME,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_magn_of_match);
@@ -79,6 +83,7 @@ static const struct i2c_device_id st_magn_id_table[] = {
 	{ LSM303DLHC_MAGN_DEV_NAME },
 	{ LSM303DLM_MAGN_DEV_NAME },
 	{ LIS3MDL_MAGN_DEV_NAME },
+	{ LSM303AGR_MAGN_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_magn_id_table);
diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
index 7adacf1..0abca2c 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -51,6 +51,7 @@ static const struct spi_device_id st_magn_id_table[] = {
 	{ LSM303DLHC_MAGN_DEV_NAME },
 	{ LSM303DLM_MAGN_DEV_NAME },
 	{ LIS3MDL_MAGN_DEV_NAME },
+	{ LSM303AGR_MAGN_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_magn_id_table);
-- 
1.9.1

