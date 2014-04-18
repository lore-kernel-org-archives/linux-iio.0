Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33681 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754564AbaDRXTp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 18 Apr 2014 19:19:45 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 12/16] iio: hid-sensors: ALS: Raw read support
Date: Fri, 18 Apr 2014 16:22:32 -0700
Message-Id: <1397863356-2470-12-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1397863356-2470-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1397863356-2470-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added support for raw reading of channel. If the sensor is powered
off, it will turn on for reading value.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/light/hid-sensor-als.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index e124b39..f34c943 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -22,6 +22,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 #include <linux/hid-sensor-hub.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -49,6 +50,7 @@ static const struct iio_chan_spec als_channels[] = {
 		.type = IIO_INTENSITY,
 		.modified = 1,
 		.channel2 = IIO_MOD_LIGHT_BOTH,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
@@ -79,6 +81,7 @@ static int als_read_raw(struct iio_dev *indio_dev,
 	u32 address;
 	int ret;
 	int ret_type;
+	s32 poll_value;
 
 	*val = 0;
 	*val2 = 0;
@@ -94,12 +97,23 @@ static int als_read_raw(struct iio_dev *indio_dev,
 			report_id = -1;
 			break;
 		}
-		if (report_id >= 0)
+		if (report_id >= 0) {
+			poll_value = hid_sensor_read_poll_value(
+						&als_state->common_attributes);
+			if (poll_value < 0)
+				return -EINVAL;
+
+			hid_sensor_power_state(&als_state->common_attributes,
+						true);
+			msleep_interruptible(poll_value * 2);
+
 			*val = sensor_hub_input_attr_get_raw_value(
-				als_state->common_attributes.hsdev,
-				HID_USAGE_SENSOR_ALS, address,
-				report_id);
-		else {
+					als_state->common_attributes.hsdev,
+					HID_USAGE_SENSOR_ALS, address,
+					report_id);
+			hid_sensor_power_state(&als_state->common_attributes,
+						false);
+		} else {
 			*val = 0;
 			return -EINVAL;
 		}
-- 
1.7.11.7

