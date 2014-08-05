Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:51950 "EHLO
	mx08-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754367AbaHEM7C (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 5 Aug 2014 08:59:02 -0400
From: Denis CIOCCA <denis.ciocca@st.com>
To: linux-iio@vger.kernel.org, jic23@kernel.org, lars@metafoo.de
Cc: Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 1/6] iio:common: changed structure name from st_sensors to st_sensors_list
Date: Tue,  5 Aug 2014 14:58:41 +0200
Message-Id: <1407243526-3645-1-git-send-email-denis.ciocca@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch change the sensors list structure name to avoid
misunderstanding.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/accel/st_accel_core.c               |  2 +-
 drivers/iio/common/st_sensors/st_sensors_core.c | 16 ++++++++--------
 drivers/iio/gyro/st_gyro_core.c                 |  2 +-
 drivers/iio/magnetometer/st_magn_core.c         |  2 +-
 drivers/iio/pressure/st_pressure_core.c         |  2 +-
 include/linux/iio/common/st_sensors.h           |  8 ++++----
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 0878648..8d0f880 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -161,7 +161,7 @@ static const struct iio_chan_spec st_accel_16bit_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(3)
 };
 
-static const struct st_sensors st_accel_sensors[] = {
+static const struct st_sensors_list st_accel_sensors[] = {
 	{
 		.wai = ST_ACCEL_1_WAI_EXP,
 		.sensors_supported = {
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 8a4ec00..2540531 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -44,7 +44,7 @@ st_sensors_write_data_with_mask_error:
 	return err;
 }
 
-static int st_sensors_match_odr(struct st_sensors *sensor,
+static int st_sensors_match_odr(struct st_sensors_list *sensor,
 			unsigned int odr, struct st_sensor_odr_avl *odr_out)
 {
 	int i, ret = -EINVAL;
@@ -98,7 +98,7 @@ st_sensors_match_odr_error:
 }
 EXPORT_SYMBOL(st_sensors_set_odr);
 
-static int st_sensors_match_fs(struct st_sensors *sensor,
+static int st_sensors_match_fs(struct st_sensors_list *sensor,
 					unsigned int fs, int *index_fs_avl)
 {
 	int i, ret = -EINVAL;
@@ -453,7 +453,7 @@ out:
 EXPORT_SYMBOL(st_sensors_read_info_raw);
 
 int st_sensors_check_device_support(struct iio_dev *indio_dev,
-			int num_sensors_list, const struct st_sensors *sensors)
+		int num_sensors_list, const struct st_sensors_list *slist)
 {
 	u8 wai;
 	int i, n, err;
@@ -467,23 +467,23 @@ int st_sensors_check_device_support(struct iio_dev *indio_dev,
 	}
 
 	for (i = 0; i < num_sensors_list; i++) {
-		if (sensors[i].wai == wai)
+		if (slist[i].wai == wai)
 			break;
 	}
 	if (i == num_sensors_list)
 		goto device_not_supported;
 
-	for (n = 0; n < ARRAY_SIZE(sensors[i].sensors_supported); n++) {
+	for (n = 0; n < ARRAY_SIZE(slist[i].sensors_supported); n++) {
 		if (strcmp(indio_dev->name,
-				&sensors[i].sensors_supported[n][0]) == 0)
+				&slist[i].sensors_supported[n][0]) == 0)
 			break;
 	}
-	if (n == ARRAY_SIZE(sensors[i].sensors_supported)) {
+	if (n == ARRAY_SIZE(slist[i].sensors_supported)) {
 		dev_err(&indio_dev->dev, "device name and WhoAmI mismatch.\n");
 		goto sensor_name_mismatch;
 	}
 
-	sdata->sensor = (struct st_sensors *)&sensors[i];
+	sdata->sensor = (struct st_sensors_list *)&slist[i];
 
 	return i;
 
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index f156fc6..d5c8eb7 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -103,7 +103,7 @@ static const struct iio_chan_spec st_gyro_16bit_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(3)
 };
 
-static const struct st_sensors st_gyro_sensors[] = {
+static const struct st_sensors_list st_gyro_sensors[] = {
 	{
 		.wai = ST_GYRO_1_WAI_EXP,
 		.sensors_supported = {
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index a4b6413..b82216a 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -146,7 +146,7 @@ static const struct iio_chan_spec st_magn_2_16bit_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(3)
 };
 
-static const struct st_sensors st_magn_sensors[] = {
+static const struct st_sensors_list st_magn_sensors[] = {
 	{
 		.wai = ST_MAGN_1_WAI_EXP,
 		.sensors_supported = {
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 473d914..408d149 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -175,7 +175,7 @@ static const struct iio_chan_spec st_press_lps001wp_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(1)
 };
 
-static const struct st_sensors st_press_sensors[] = {
+static const struct st_sensors_list st_press_sensors[] = {
 	{
 		.wai = ST_PRESS_LPS331AP_WAI_EXP,
 		.sensors_supported = {
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index d8257ab..e586e2b 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -164,7 +164,7 @@ struct st_sensor_transfer_function {
 };
 
 /**
- * struct st_sensors - ST sensors list
+ * struct st_sensors_list - ST sensors list
  * @wai: Contents of WhoAmI register.
  * @sensors_supported: List of supported sensors by struct itself.
  * @ch: IIO channels for the sensor.
@@ -177,7 +177,7 @@ struct st_sensor_transfer_function {
  * @multi_read_bit: Use or not particular bit for [I2C/SPI] multi-read.
  * @bootime: samples to discard when sensor passing from power-down to power-up.
  */
-struct st_sensors {
+struct st_sensors_list {
 	u8 wai;
 	char sensors_supported[ST_SENSORS_MAX_4WAI][ST_SENSORS_MAX_NAME];
 	struct iio_chan_spec *ch;
@@ -213,7 +213,7 @@ struct st_sensors {
 struct st_sensor_data {
 	struct device *dev;
 	struct iio_trigger *trig;
-	struct st_sensors *sensor;
+	struct st_sensors_list *sensor;
 	struct st_sensor_fullscale_avl *current_fullscale;
 	struct regulator *vdd;
 	struct regulator *vdd_io;
@@ -279,7 +279,7 @@ int st_sensors_read_info_raw(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *ch, int *val);
 
 int st_sensors_check_device_support(struct iio_dev *indio_dev,
-			int num_sensors_list, const struct st_sensors *sensors);
+		int num_sensors_list, const struct st_sensors_list *slist);
 
 ssize_t st_sensors_sysfs_sampling_frequency_avail(struct device *dev,
 				struct device_attribute *attr, char *buf);
-- 
1.9.1

