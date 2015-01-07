Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jkosina@suse.cz,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/9] iio: hid-sensor-accel-3d: Adjust parameter for attribute read
Date: Tue,  6 Jan 2015 16:58:32 -0800
Message-Id: <1420592328-9942-9-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1420592328-9942-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1420592328-9942-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

The new API added a flag for sync/async mode. Added sync mode flag.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index d5d9531..0085c2f 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -130,7 +130,8 @@ static int accel_3d_read_raw(struct iio_dev *indio_dev,
 			*val = sensor_hub_input_attr_get_raw_value(
 					accel_state->common_attributes.hsdev,
 					HID_USAGE_SENSOR_ACCEL_3D, address,
-					report_id);
+					report_id,
+					SENSOR_HUB_SYNC);
 		else {
 			*val = 0;
 			hid_sensor_power_state(&accel_state->common_attributes,
-- 
1.9.1
