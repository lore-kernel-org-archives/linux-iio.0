Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33681 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754585AbaDRXTr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 18 Apr 2014 19:19:47 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 16/16] iio: hid-sensors: Pressure: Raw read support
Date: Fri, 18 Apr 2014 16:22:36 -0700
Message-Id: <1397863356-2470-16-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1397863356-2470-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1397863356-2470-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added support for raw reading of channel. If the sensor is powered
off, it will turn on for reading value.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/pressure/hid-sensor-press.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 39df50c..1cd190c 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 #include <linux/hid-sensor-hub.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -79,6 +80,7 @@ static int press_read_raw(struct iio_dev *indio_dev,
 	u32 address;
 	int ret;
 	int ret_type;
+	s32 poll_value;
 
 	*val = 0;
 	*val2 = 0;
@@ -94,12 +96,23 @@ static int press_read_raw(struct iio_dev *indio_dev,
 			report_id = -1;
 			break;
 		}
-		if (report_id >= 0)
+		if (report_id >= 0) {
+			poll_value = hid_sensor_read_poll_value(
+					&press_state->common_attributes);
+			if (poll_value < 0)
+				return -EINVAL;
+			hid_sensor_power_state(&press_state->common_attributes,
+						true);
+
+			msleep_interruptible(poll_value * 2);
+
 			*val = sensor_hub_input_attr_get_raw_value(
 				press_state->common_attributes.hsdev,
 				HID_USAGE_SENSOR_PRESSURE, address,
 				report_id);
-		else {
+			hid_sensor_power_state(&press_state->common_attributes,
+						false);
+		} else {
 			*val = 0;
 			return -EINVAL;
 		}
-- 
1.7.11.7

