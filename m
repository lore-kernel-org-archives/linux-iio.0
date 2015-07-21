Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:59503 "EHLO
	mx08-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753499AbbGUIPY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2015 04:15:24 -0400
From: Giuseppe Barba <giuseppe.barba@st.com>
To: <linux-iio@vger.kernel.org>
CC: <denis.ciocca@st.com>, <jic23@kernel.org>,
	Giuseppe Barba <giuseppe.barba@st.com>
Subject: [PATCH V3 4/5] iio: st-accel: add support for lsm303agr accelerometer
Date: Tue, 21 Jul 2015 10:14:19 +0200
Message-ID: <1437466460-14412-5-git-send-email-giuseppe.barba@st.com>
In-Reply-To: <1437466460-14412-1-git-send-email-giuseppe.barba@st.com>
References: <1437466460-14412-1-git-send-email-giuseppe.barba@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds support for the lsm303agr accelerometer.

Signed-off-by: Giuseppe Barba <giuseppe.barba@st.com>
---
 Documentation/devicetree/bindings/iio/st-sensors.txt | 1 +
 drivers/iio/accel/st_accel.h                         | 1 +
 drivers/iio/accel/st_accel_core.c                    | 1 +
 drivers/iio/accel/st_accel_i2c.c                     | 5 +++++
 drivers/iio/accel/st_accel_spi.c                     | 1 +
 5 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
index 8a6be3b..d80bdaa 100644
--- a/Documentation/devicetree/bindings/iio/st-sensors.txt
+++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
@@ -35,6 +35,7 @@ Accelerometers:
 - st,lsm303dl-accel
 - st,lsm303dlm-accel
 - st,lsm330-accel
+- st,lsm303agr-accel
 
 Gyroscopes:
 - st,l3g4200d-gyro
diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
index aa10019..468f21f 100644
--- a/drivers/iio/accel/st_accel.h
+++ b/drivers/iio/accel/st_accel.h
@@ -26,6 +26,7 @@
 #define LSM303DLH_ACCEL_DEV_NAME	"lsm303dlh_accel"
 #define LSM303DLM_ACCEL_DEV_NAME	"lsm303dlm_accel"
 #define LSM330_ACCEL_DEV_NAME		"lsm330_accel"
+#define LSM303AGR_ACCEL_DEV_NAME	"lsm303agr_accel"
 
 /**
 * struct st_sensors_platform_data - default accel platform data
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 12b42f6..ff30f88 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -233,6 +233,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 			[2] = LSM330D_ACCEL_DEV_NAME,
 			[3] = LSM330DL_ACCEL_DEV_NAME,
 			[4] = LSM330DLC_ACCEL_DEV_NAME,
+			[5] = LSM303AGR_ACCEL_DEV_NAME,
 		},
 		.ch = (struct iio_chan_spec *)st_accel_12bit_channels,
 		.odr = {
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index a2f1c20..8b9cc84 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -68,6 +68,10 @@ static const struct of_device_id st_accel_of_match[] = {
 		.compatible = "st,lsm330-accel",
 		.data = LSM330_ACCEL_DEV_NAME,
 	},
+	{
+		.compatible = "st,lsm303agr-accel",
+		.data = LSM303AGR_ACCEL_DEV_NAME,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_accel_of_match);
@@ -116,6 +120,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
 	{ LSM303DL_ACCEL_DEV_NAME },
 	{ LSM303DLM_ACCEL_DEV_NAME },
 	{ LSM330_ACCEL_DEV_NAME },
+	{ LSM303AGR_ACCEL_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index 12ec293..54b61a3 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -57,6 +57,7 @@ static const struct spi_device_id st_accel_id_table[] = {
 	{ LSM303DL_ACCEL_DEV_NAME },
 	{ LSM303DLM_ACCEL_DEV_NAME },
 	{ LSM330_ACCEL_DEV_NAME },
+	{ LSM303AGR_ACCEL_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_accel_id_table);
-- 
1.9.1

