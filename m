Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jkosina@suse.cz,
	jic23@kernel.org,
	a.zummo@towertech.it
Cc: linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org,
	holler@ahsoftware.de,
	rtc-linux@googlegroups.com,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 4/9] iio: hid-sensor-als: Adjust parameter for attribute read
Date: Wed,  7 Jan 2015 10:47:58 -0800
Message-Id: <1420656483-7093-5-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1420656483-7093-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1420656483-7093-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

The new API added a flag for sync/async mode. Added sync mode flag.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/light/hid-sensor-als.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index a5283d7..321862d 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -109,7 +109,8 @@ static int als_read_raw(struct iio_dev *indio_dev,
 			*val = sensor_hub_input_attr_get_raw_value(
 					als_state->common_attributes.hsdev,
 					HID_USAGE_SENSOR_ALS, address,
-					report_id);
+					report_id,
+					SENSOR_HUB_SYNC);
 			hid_sensor_power_state(&als_state->common_attributes,
 						false);
 		} else {
-- 
1.9.3
