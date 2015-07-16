Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:35358 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754169AbbGPJTD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2015 05:19:03 -0400
Received: from pps.filterd (m0046670.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.14.5/8.14.5) with SMTP id t6G9Elre018128
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2015 11:19:02 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com with ESMTP id 1vmbkf079j-1
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2015 11:19:02 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9A5CA38
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2015 09:19:00 +0000 (GMT)
Received: from Webmail-eu.st.com (safex1hubcas1.st.com [10.75.90.14])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 766F9F03
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2015 09:19:00 +0000 (GMT)
From: Giuseppe Barba <giuseppe.barba@st.com>
To: <linux-iio@vger.kernel.org>
CC: Giuseppe Barba <giuseppe.barba@st.com>
Subject: [PATCH 4/5] iio: st-accel: add support for lsm303agr accelerometer
Date: Thu, 16 Jul 2015 11:17:43 +0200
Message-ID: <1437038264-12936-5-git-send-email-giuseppe.barba@st.com>
In-Reply-To: <1437038264-12936-1-git-send-email-giuseppe.barba@st.com>
References: <1437038264-12936-1-git-send-email-giuseppe.barba@st.com>
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
index 207f6ef..3e55bf9 100644
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
index d4ad72c..7003542 100644
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

