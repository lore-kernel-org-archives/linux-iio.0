Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34122 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751324AbbKKNyQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Nov 2015 08:54:16 -0500
From: Giuseppe Barba <giuseppe.barba@st.com>
To: <denis.ciocca@st.com>, <linux-iio@vger.kernel.org>
CC: <jic23@kernel.org>, Giuseppe Barba <giuseppe.barba@st.com>
Subject: [V2] iio: st-accel: add support for lis2dh12
Date: Wed, 11 Nov 2015 14:52:54 +0100
Message-ID: <1447249974-27442-2-git-send-email-giuseppe.barba@st.com>
In-Reply-To: <1447249974-27442-1-git-send-email-giuseppe.barba@st.com>
References: <1447249974-27442-1-git-send-email-giuseppe.barba@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This commit add support for STMicroelectronics lis2dh12 accelerometer.

Signed-off-by: Giuseppe Barba <giuseppe.barba@st.com>
---
 Documentation/devicetree/bindings/iio/st-sensors.txt | 1 +
 drivers/iio/accel/st_accel.h                         | 1 +
 drivers/iio/accel/st_accel_core.c                    | 1 +
 drivers/iio/accel/st_accel_i2c.c                     | 5 +++++
 drivers/iio/accel/st_accel_spi.c                     | 1 +
 5 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
index d3ccdb1..d4b87cc 100644
--- a/Documentation/devicetree/bindings/iio/st-sensors.txt
+++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
@@ -36,6 +36,7 @@ Accelerometers:
 - st,lsm303dlm-accel
 - st,lsm330-accel
 - st,lsm303agr-accel
+- st,lis2dh12-accel
 
 Gyroscopes:
 - st,l3g4200d-gyro
diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
index 468f21f..5d4a189 100644
--- a/drivers/iio/accel/st_accel.h
+++ b/drivers/iio/accel/st_accel.h
@@ -27,6 +27,7 @@
 #define LSM303DLM_ACCEL_DEV_NAME	"lsm303dlm_accel"
 #define LSM330_ACCEL_DEV_NAME		"lsm330_accel"
 #define LSM303AGR_ACCEL_DEV_NAME	"lsm303agr_accel"
+#define LIS2DH12_ACCEL_DEV_NAME		"lis2dh12_accel"
 
 /**
 * struct st_sensors_platform_data - default accel platform data
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index dab8b76..9d973f1 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -234,6 +234,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 			[3] = LSM330DL_ACCEL_DEV_NAME,
 			[4] = LSM330DLC_ACCEL_DEV_NAME,
 			[5] = LSM303AGR_ACCEL_DEV_NAME,
+			[6] = LIS2DH12_ACCEL_DEV_NAME,
 		},
 		.ch = (struct iio_chan_spec *)st_accel_12bit_channels,
 		.odr = {
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index 8b9cc84..294a32f 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -72,6 +72,10 @@ static const struct of_device_id st_accel_of_match[] = {
 		.compatible = "st,lsm303agr-accel",
 		.data = LSM303AGR_ACCEL_DEV_NAME,
 	},
+	{
+		.compatible = "st,lis2dh12-accel",
+		.data = LIS2DH12_ACCEL_DEV_NAME,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_accel_of_match);
@@ -121,6 +125,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
 	{ LSM303DLM_ACCEL_DEV_NAME },
 	{ LSM330_ACCEL_DEV_NAME },
 	{ LSM303AGR_ACCEL_DEV_NAME },
+	{ LIS2DH12_ACCEL_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index 54b61a3..e82bedf 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -58,6 +58,7 @@ static const struct spi_device_id st_accel_id_table[] = {
 	{ LSM303DLM_ACCEL_DEV_NAME },
 	{ LSM330_ACCEL_DEV_NAME },
 	{ LSM303AGR_ACCEL_DEV_NAME },
+	{ LIS2DH12_ACCEL_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_accel_id_table);
-- 
1.9.1

