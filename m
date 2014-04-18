Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:55980 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754553AbaDRXTp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 18 Apr 2014 19:19:45 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 11/16] iio: hid-sensors: Gyro 3D: Raw read support
Date: Fri, 18 Apr 2014 16:22:31 -0700
Message-Id: <1397863356-2470-11-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1397863356-2470-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1397863356-2470-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added support for raw reading of channel. If the sensor is powered
off, it will turn on for reading value.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index 392c30b..40f4e49 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -22,6 +22,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 #include <linux/hid-sensor-hub.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -60,6 +61,7 @@ static const struct iio_chan_spec gyro_3d_channels[] = {
 		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
@@ -69,6 +71,7 @@ static const struct iio_chan_spec gyro_3d_channels[] = {
 		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Y,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
@@ -78,6 +81,7 @@ static const struct iio_chan_spec gyro_3d_channels[] = {
 		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
@@ -108,22 +112,33 @@ static int gyro_3d_read_raw(struct iio_dev *indio_dev,
 	u32 address;
 	int ret;
 	int ret_type;
+	s32 poll_value;
 
 	*val = 0;
 	*val2 = 0;
 	switch (mask) {
 	case 0:
+		poll_value = hid_sensor_read_poll_value(
+					&gyro_state->common_attributes);
+		if (poll_value < 0)
+			return -EINVAL;
+
+		hid_sensor_power_state(&gyro_state->common_attributes, true);
+		msleep_interruptible(poll_value * 2);
 		report_id = gyro_state->gyro[chan->scan_index].report_id;
 		address = gyro_3d_addresses[chan->scan_index];
 		if (report_id >= 0)
 			*val = sensor_hub_input_attr_get_raw_value(
-				gyro_state->common_attributes.hsdev,
-				HID_USAGE_SENSOR_GYRO_3D, address,
-				report_id);
+					gyro_state->common_attributes.hsdev,
+					HID_USAGE_SENSOR_GYRO_3D, address,
+					report_id);
 		else {
 			*val = 0;
+			hid_sensor_power_state(&gyro_state->common_attributes,
+						false);
 			return -EINVAL;
 		}
+		hid_sensor_power_state(&gyro_state->common_attributes, false);
 		ret_type = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_SCALE:
-- 
1.7.11.7

