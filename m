Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:44378 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753057AbcL3BAt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 29 Dec 2016 20:00:49 -0500
From: Song Hongyan <hongyan.song@intel.com>
To: linux-iio@vger.kernel.org
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@intel.com,
        Song Hongyan <hongyan.song@intel.com>
Subject: [PATCH 4/4] iio: hid: Expose sensors max_sample_frequency nodes
Date: Fri, 30 Dec 2016 17:23:12 +0800
Message-Id: <1483089792-11324-4-git-send-email-hongyan.song@intel.com>
In-Reply-To: <1483089792-11324-1-git-send-email-hongyan.song@intel.com>
References: <1483089792-11324-1-git-send-email-hongyan.song@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Each sensor has their own min_report_interval which means
has max_sample_frequency, expose this node/attribute.

Signed-off-by: Song Hongyan <hongyan.song@intel.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c       | 12 ++++++++++++
 drivers/iio/gyro/hid-sensor-gyro-3d.c         |  7 +++++++
 drivers/iio/light/hid-sensor-als.c            |  5 +++++
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 11 +++++++++++
 drivers/iio/orientation/hid-sensor-incl-3d.c  |  7 +++++++
 drivers/iio/orientation/hid-sensor-rotation.c |  5 +++++
 drivers/iio/pressure/hid-sensor-press.c       |  5 +++++
 7 files changed, 52 insertions(+)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 9edd574..cef3eb5 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -65,6 +65,7 @@ struct accel_3d_state {
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_MAX_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 		.scan_index = CHANNEL_SCAN_INDEX_X,
 	}, {
@@ -75,6 +76,7 @@ struct accel_3d_state {
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_MAX_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 		.scan_index = CHANNEL_SCAN_INDEX_Y,
 	}, {
@@ -85,6 +87,7 @@ struct accel_3d_state {
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_MAX_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 		.scan_index = CHANNEL_SCAN_INDEX_Z,
 	}
@@ -100,6 +103,7 @@ struct accel_3d_state {
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_MAX_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 		.scan_index = CHANNEL_SCAN_INDEX_X,
 	}, {
@@ -110,6 +114,7 @@ struct accel_3d_state {
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_MAX_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 		.scan_index = CHANNEL_SCAN_INDEX_Y,
 	}, {
@@ -120,6 +125,7 @@ struct accel_3d_state {
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_MAX_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 		.scan_index = CHANNEL_SCAN_INDEX_Z,
 	}
@@ -183,6 +189,12 @@ static int accel_3d_read_raw(struct iio_dev *indio_dev,
 		ret_type = hid_sensor_read_samp_freq_value(
 			&accel_state->common_attributes, val, val2);
 		break;
+
+	case IIO_CHAN_INFO_MAX_SAMP_FREQ:
+		ret_type = hid_sensor_read_max_samp_freq_value(
+			&accel_state->common_attributes, val, val2);
+		break;
+
 	case IIO_CHAN_INFO_HYSTERESIS:
 		ret_type = hid_sensor_read_raw_hyst_value(
 			&accel_state->common_attributes, val, val2);
diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index c67ce2a..f6c66ee 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -65,6 +65,7 @@ struct gyro_3d_state {
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_MAX_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 		.scan_index = CHANNEL_SCAN_INDEX_X,
 	}, {
@@ -75,6 +76,7 @@ struct gyro_3d_state {
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_MAX_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 		.scan_index = CHANNEL_SCAN_INDEX_Y,
 	}, {
@@ -85,6 +87,7 @@ struct gyro_3d_state {
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_MAX_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 		.scan_index = CHANNEL_SCAN_INDEX_Z,
 	}
@@ -147,6 +150,10 @@ static int gyro_3d_read_raw(struct iio_dev *indio_dev,
 		ret_type = hid_sensor_read_samp_freq_value(
 			&gyro_state->common_attributes, val, val2);
 		break;
+	case IIO_CHAN_INFO_MAX_SAMP_FREQ:
+		ret_type = hid_sensor_read_max_samp_freq_value(
+			&gyro_state->common_attributes, val, val2);
+		break;
 	case IIO_CHAN_INFO_HYSTERESIS:
 		ret_type = hid_sensor_read_raw_hyst_value(
 			&gyro_state->common_attributes, val, val2);
diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 8bb1f90..acce7cf4 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -54,6 +54,7 @@ struct als_state {
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_MAX_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 		.scan_index = CHANNEL_SCAN_INDEX_ILLUM,
 	}
@@ -124,6 +125,10 @@ static int als_read_raw(struct iio_dev *indio_dev,
 		ret_type = hid_sensor_read_samp_freq_value(
 				&als_state->common_attributes, val, val2);
 		break;
+	case IIO_CHAN_INFO_MAX_SAMP_FREQ:
+		ret_type = hid_sensor_read_max_samp_freq_value(
+			&als_state->common_attributes, val, val2);
+		break;
 	case IIO_CHAN_INFO_HYSTERESIS:
 		ret_type = hid_sensor_read_raw_hyst_value(
 				&als_state->common_attributes, val, val2);
diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index d8a0c8d..8b588ae 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -78,6 +78,7 @@ struct magn_3d_state {
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_MAX_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 	}, {
 		.type = IIO_MAGN,
@@ -87,6 +88,7 @@ struct magn_3d_state {
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_MAX_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 	}, {
 		.type = IIO_MAGN,
@@ -96,6 +98,7 @@ struct magn_3d_state {
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_MAX_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 	}, {
 		.type = IIO_ROT,
@@ -105,6 +108,7 @@ struct magn_3d_state {
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_MAX_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 	}, {
 		.type = IIO_ROT,
@@ -114,6 +118,7 @@ struct magn_3d_state {
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_MAX_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 	}, {
 		.type = IIO_ROT,
@@ -123,6 +128,7 @@ struct magn_3d_state {
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_MAX_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 	}, {
 		.type = IIO_ROT,
@@ -132,6 +138,7 @@ struct magn_3d_state {
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_MAX_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 	}
 };
@@ -194,6 +201,10 @@ static int magn_3d_read_raw(struct iio_dev *indio_dev,
 		ret_type = hid_sensor_read_samp_freq_value(
 			&magn_state->common_attributes, val, val2);
 		break;
+	case IIO_CHAN_INFO_MAX_SAMP_FREQ:
+		ret_type = hid_sensor_read_max_samp_freq_value(
+			&magn_state->common_attributes, val, val2);
+		break;
 	case IIO_CHAN_INFO_HYSTERESIS:
 		ret_type = hid_sensor_read_raw_hyst_value(
 			&magn_state->common_attributes, val, val2);
diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index fd1b369..d242cd2 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -65,6 +65,7 @@ struct incl_3d_state {
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_MAX_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 		.scan_index = CHANNEL_SCAN_INDEX_X,
 	}, {
@@ -75,6 +76,7 @@ struct incl_3d_state {
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_MAX_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 		.scan_index = CHANNEL_SCAN_INDEX_Y,
 	}, {
@@ -85,6 +87,7 @@ struct incl_3d_state {
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_MAX_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 		.scan_index = CHANNEL_SCAN_INDEX_Z,
 	}
@@ -147,6 +150,10 @@ static int incl_3d_read_raw(struct iio_dev *indio_dev,
 		ret_type = hid_sensor_read_samp_freq_value(
 			&incl_state->common_attributes, val, val2);
 		break;
+	case IIO_CHAN_INFO_MAX_SAMP_FREQ:
+		ret_type = hid_sensor_read_max_samp_freq_value(
+			&incl_state->common_attributes, val, val2);
+		break;
 	case IIO_CHAN_INFO_HYSTERESIS:
 		ret_type = hid_sensor_read_raw_hyst_value(
 			&incl_state->common_attributes, val, val2);
diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index a97e802c..d4f579c 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -41,6 +41,7 @@ struct dev_rot_state {
 		.channel2 = IIO_MOD_QUATERNION,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					BIT(IIO_CHAN_INFO_MAX_SAMP_FREQ) |
 					BIT(IIO_CHAN_INFO_HYSTERESIS)
 	}
 };
@@ -84,6 +85,10 @@ static int dev_rot_read_raw(struct iio_dev *indio_dev,
 		ret_type = hid_sensor_read_samp_freq_value(
 			&rot_state->common_attributes, &vals[0], &vals[1]);
 		break;
+	case IIO_CHAN_INFO_MAX_SAMP_FREQ:
+		ret_type = hid_sensor_read_max_samp_freq_value(
+			&rot_state->common_attributes, &vals[0], &vals[1]);
+		break;
 	case IIO_CHAN_INFO_HYSTERESIS:
 		ret_type = hid_sensor_read_raw_hyst_value(
 			&rot_state->common_attributes, &vals[0], &vals[1]);
diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 6848d8c..4e822d1 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -51,6 +51,7 @@ struct press_state {
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_MAX_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 		.scan_index = CHANNEL_SCAN_INDEX_PRESSURE,
 	}
@@ -121,6 +122,10 @@ static int press_read_raw(struct iio_dev *indio_dev,
 		ret_type = hid_sensor_read_samp_freq_value(
 				&press_state->common_attributes, val, val2);
 		break;
+	case IIO_CHAN_INFO_MAX_SAMP_FREQ:
+		ret_type = hid_sensor_read_max_samp_freq_value(
+				&press_state->common_attributes, val, val2);
+		break;
 	case IIO_CHAN_INFO_HYSTERESIS:
 		ret_type = hid_sensor_read_raw_hyst_value(
 				&press_state->common_attributes, val, val2);
-- 
1.9.1

