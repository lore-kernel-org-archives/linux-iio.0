Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33638 "EHLO
	mx08-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753332AbbGUIPX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2015 04:15:23 -0400
From: Giuseppe Barba <giuseppe.barba@st.com>
To: <linux-iio@vger.kernel.org>
CC: <denis.ciocca@st.com>, <jic23@kernel.org>,
	Giuseppe Barba <giuseppe.barba@st.com>
Subject: [PATCH V3 1/5] iio: st-sensors: add configuration for WhoAmI address
Date: Tue, 21 Jul 2015 10:14:16 +0200
Message-ID: <1437466460-14412-2-git-send-email-giuseppe.barba@st.com>
In-Reply-To: <1437466460-14412-1-git-send-email-giuseppe.barba@st.com>
References: <1437466460-14412-1-git-send-email-giuseppe.barba@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch permits to configure the WhoAmI register address
because some device could have not a standard address for
this register.

Signed-off-by: Giuseppe Barba <giuseppe.barba@st.com>
---
 drivers/iio/accel/st_accel_core.c               |  5 +++
 drivers/iio/common/st_sensors/st_sensors_core.c | 49 ++++++++++++-------------
 drivers/iio/gyro/st_gyro_core.c                 |  3 ++
 drivers/iio/magnetometer/st_magn_core.c         |  3 ++
 drivers/iio/pressure/st_pressure_core.c         |  3 ++
 include/linux/iio/common/st_sensors.h           |  2 +
 6 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 4002e64..12b42f6 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -226,6 +226,7 @@ static const struct iio_chan_spec st_accel_16bit_channels[] = {
 static const struct st_sensor_settings st_accel_sensors_settings[] = {
 	{
 		.wai = ST_ACCEL_1_WAI_EXP,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
 		.sensors_supported = {
 			[0] = LIS3DH_ACCEL_DEV_NAME,
 			[1] = LSM303DLHC_ACCEL_DEV_NAME,
@@ -297,6 +298,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 	},
 	{
 		.wai = ST_ACCEL_2_WAI_EXP,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
 		.sensors_supported = {
 			[0] = LIS331DLH_ACCEL_DEV_NAME,
 			[1] = LSM303DL_ACCEL_DEV_NAME,
@@ -359,6 +361,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 	},
 	{
 		.wai = ST_ACCEL_3_WAI_EXP,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
 		.sensors_supported = {
 			[0] = LSM330_ACCEL_DEV_NAME,
 		},
@@ -437,6 +440,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 	},
 	{
 		.wai = ST_ACCEL_4_WAI_EXP,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
 		.sensors_supported = {
 			[0] = LIS3LV02DL_ACCEL_DEV_NAME,
 		},
@@ -494,6 +498,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 	},
 	{
 		.wai = ST_ACCEL_5_WAI_EXP,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
 		.sensors_supported = {
 			[0] = LIS331DL_ACCEL_DEV_NAME,
 		},
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 8086cbc..d44bf16 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -479,46 +479,43 @@ int st_sensors_check_device_support(struct iio_dev *indio_dev,
 			int num_sensors_list,
 			const struct st_sensor_settings *sensor_settings)
 {
-	u8 wai;
 	int i, n, err;
+	u8 wai;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
-	err = sdata->tf->read_byte(&sdata->tb, sdata->dev,
-					ST_SENSORS_DEFAULT_WAI_ADDRESS, &wai);
-	if (err < 0) {
-		dev_err(&indio_dev->dev, "failed to read Who-Am-I register.\n");
-		goto read_wai_error;
-	}
-
 	for (i = 0; i < num_sensors_list; i++) {
-		if (sensor_settings[i].wai == wai)
+		for (n = 0; n < ST_SENSORS_MAX_4WAI; n++) {
+			if (strcmp(indio_dev->name,
+				sensor_settings[i].sensors_supported[n]) == 0) {
+				break;
+			}
+		}
+		if (n < ST_SENSORS_MAX_4WAI)
 			break;
 	}
-	if (i == num_sensors_list)
-		goto device_not_supported;
+	if (i == num_sensors_list) {
+		dev_err(&indio_dev->dev, "device name %s not recognized.\n",
+							indio_dev->name);
+		return -ENODEV;
+	}
 
-	for (n = 0; n < ARRAY_SIZE(sensor_settings[i].sensors_supported); n++) {
-		if (strcmp(indio_dev->name,
-				&sensor_settings[i].sensors_supported[n][0]) == 0)
-			break;
+	err = sdata->tf->read_byte(&sdata->tb, sdata->dev,
+					sensor_settings[i].wai_addr, &wai);
+	if (err < 0) {
+		dev_err(&indio_dev->dev, "failed to read Who-Am-I register.\n");
+		return err;
 	}
-	if (n == ARRAY_SIZE(sensor_settings[i].sensors_supported)) {
-		dev_err(&indio_dev->dev, "device name \"%s\" and WhoAmI (0x%02x) mismatch",
-			indio_dev->name, wai);
-		goto sensor_name_mismatch;
+
+	if (sensor_settings[i].wai != wai) {
+		dev_err(&indio_dev->dev, "%s: WhoAmI mismatch (0x%x).\n",
+						indio_dev->name, wai);
+		return -EINVAL;
 	}
 
 	sdata->sensor_settings =
 			(struct st_sensor_settings *)&sensor_settings[i];
 
 	return i;
-
-device_not_supported:
-	dev_err(&indio_dev->dev, "device not supported: WhoAmI (0x%x).\n", wai);
-sensor_name_mismatch:
-	err = -ENODEV;
-read_wai_error:
-	return err;
 }
 EXPORT_SYMBOL(st_sensors_check_device_support);
 
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index ffe9664..4b993a5 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -131,6 +131,7 @@ static const struct iio_chan_spec st_gyro_16bit_channels[] = {
 static const struct st_sensor_settings st_gyro_sensors_settings[] = {
 	{
 		.wai = ST_GYRO_1_WAI_EXP,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
 		.sensors_supported = {
 			[0] = L3G4200D_GYRO_DEV_NAME,
 			[1] = LSM330DL_GYRO_DEV_NAME,
@@ -190,6 +191,7 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
 	},
 	{
 		.wai = ST_GYRO_2_WAI_EXP,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
 		.sensors_supported = {
 			[0] = L3GD20_GYRO_DEV_NAME,
 			[1] = LSM330D_GYRO_DEV_NAME,
@@ -252,6 +254,7 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
 	},
 	{
 		.wai = ST_GYRO_3_WAI_EXP,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
 		.sensors_supported = {
 			[0] = L3GD20_GYRO_DEV_NAME,
 		},
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index b4bcfb7..8d7d3a1 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -192,6 +192,7 @@ static const struct iio_chan_spec st_magn_2_16bit_channels[] = {
 static const struct st_sensor_settings st_magn_sensors_settings[] = {
 	{
 		.wai = 0, /* This sensor has no valid WhoAmI report 0 */
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
 		.sensors_supported = {
 			[0] = LSM303DLH_MAGN_DEV_NAME,
 		},
@@ -268,6 +269,7 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
 	},
 	{
 		.wai = ST_MAGN_1_WAI_EXP,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
 		.sensors_supported = {
 			[0] = LSM303DLHC_MAGN_DEV_NAME,
 			[1] = LSM303DLM_MAGN_DEV_NAME,
@@ -346,6 +348,7 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
 	},
 	{
 		.wai = ST_MAGN_2_WAI_EXP,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
 		.sensors_supported = {
 			[0] = LIS3MDL_MAGN_DEV_NAME,
 		},
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index e881fa6..eb41d2b 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -178,6 +178,7 @@ static const struct iio_chan_spec st_press_lps001wp_channels[] = {
 static const struct st_sensor_settings st_press_sensors_settings[] = {
 	{
 		.wai = ST_PRESS_LPS331AP_WAI_EXP,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
 		.sensors_supported = {
 			[0] = LPS331AP_PRESS_DEV_NAME,
 		},
@@ -225,6 +226,7 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
 	},
 	{
 		.wai = ST_PRESS_LPS001WP_WAI_EXP,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
 		.sensors_supported = {
 			[0] = LPS001WP_PRESS_DEV_NAME,
 		},
@@ -260,6 +262,7 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
 	},
 	{
 		.wai = ST_PRESS_LPS25H_WAI_EXP,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
 		.sensors_supported = {
 			[0] = LPS25H_PRESS_DEV_NAME,
 		},
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 2c476ac..3c17cd7 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -166,6 +166,7 @@ struct st_sensor_transfer_function {
 /**
  * struct st_sensor_settings - ST specific sensor settings
  * @wai: Contents of WhoAmI register.
+ * @wai_addr: The address of WhoAmI register.
  * @sensors_supported: List of supported sensors by struct itself.
  * @ch: IIO channels for the sensor.
  * @odr: Output data rate register and ODR list available.
@@ -179,6 +180,7 @@ struct st_sensor_transfer_function {
  */
 struct st_sensor_settings {
 	u8 wai;
+	u8 wai_addr;
 	char sensors_supported[ST_SENSORS_MAX_4WAI][ST_SENSORS_MAX_NAME];
 	struct iio_chan_spec *ch;
 	int num_ch;
-- 
1.9.1

