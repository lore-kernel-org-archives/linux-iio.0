Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jkosina@suse.cz,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 7/9] iio: hid-sensor-incl-3d: Adjust parameter for attribute read
Date: Tue,  6 Jan 2015 16:58:37 -0800
Message-Id: <1420592328-9942-14-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1420592328-9942-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1420592328-9942-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

The new API added a flag for sync/async mode. Added sync mode flag.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/orientation/hid-sensor-incl-3d.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index 1ff181b..45bed08 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -132,7 +132,8 @@ static int incl_3d_read_raw(struct iio_dev *indio_dev,
 			*val = sensor_hub_input_attr_get_raw_value(
 				incl_state->common_attributes.hsdev,
 				HID_USAGE_SENSOR_INCLINOMETER_3D, address,
-				report_id);
+				report_id,
+				SENSOR_HUB_SYNC);
 		else {
 			hid_sensor_power_state(&incl_state->common_attributes,
 						false);
-- 
1.9.1
