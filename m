Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:55980 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754506AbaDRXTq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 18 Apr 2014 19:19:46 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 15/16] iio: hid-sensors: Inclinometer 3D: Raw read support
Date: Fri, 18 Apr 2014 16:22:35 -0700
Message-Id: <1397863356-2470-15-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1397863356-2470-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1397863356-2470-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added support for raw reading of channel. If the sensor is powered
off, it will turn on for reading value.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/orientation/hid-sensor-incl-3d.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index bf11678..2478f6c 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -22,6 +22,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 #include <linux/hid-sensor-hub.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -110,11 +111,20 @@ static int incl_3d_read_raw(struct iio_dev *indio_dev,
 	int report_id = -1;
 	u32 address;
 	int ret_type;
+	s32 poll_value;
 
 	*val = 0;
 	*val2 = 0;
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		poll_value = hid_sensor_read_poll_value(
+					&incl_state->common_attributes);
+		if (poll_value < 0)
+			return -EINVAL;
+
+		hid_sensor_power_state(&incl_state->common_attributes, true);
+		msleep_interruptible(poll_value * 2);
+
 		report_id =
 			incl_state->incl[chan->scan_index].report_id;
 		address = incl_3d_addresses[chan->scan_index];
@@ -124,8 +134,11 @@ static int incl_3d_read_raw(struct iio_dev *indio_dev,
 				HID_USAGE_SENSOR_INCLINOMETER_3D, address,
 				report_id);
 		else {
+			hid_sensor_power_state(&incl_state->common_attributes,
+						false);
 			return -EINVAL;
 		}
+		hid_sensor_power_state(&incl_state->common_attributes, false);
 		ret_type = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_SCALE:
-- 
1.7.11.7

