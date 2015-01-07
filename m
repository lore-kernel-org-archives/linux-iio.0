Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jkosina@suse.cz,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/4] iio: hid_sensor_hub: update parameters to get feature report
Date: Wed,  7 Jan 2015 10:31:46 -0800
Message-Id: <1420655508-6736-3-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1420655508-6736-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1420655508-6736-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

The new sensor_hub_get_feature can return multiple values, this
resulted in the change in API. Update the API usage here.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 13 +++++++------
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c    |  4 ++--
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index 25b01e1..e1435e9 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -153,8 +153,8 @@ s32 hid_sensor_read_poll_value(struct hid_sensor_common *st)
 	int ret;
 
 	ret = sensor_hub_get_feature(st->hsdev,
-		st->poll.report_id,
-		st->poll.index, &value);
+				     st->poll.report_id,
+				     st->poll.index, sizeof(value), &value);
 
 	if (ret < 0 || value < 0) {
 		return -EINVAL;
@@ -174,8 +174,8 @@ int hid_sensor_read_samp_freq_value(struct hid_sensor_common *st,
 	int ret;
 
 	ret = sensor_hub_get_feature(st->hsdev,
-		st->poll.report_id,
-		st->poll.index, &value);
+				     st->poll.report_id,
+				     st->poll.index, sizeof(value), &value);
 	if (ret < 0 || value < 0) {
 		*val1 = *val2 = 0;
 		return -EINVAL;
@@ -229,8 +229,9 @@ int hid_sensor_read_raw_hyst_value(struct hid_sensor_common *st,
 	int ret;
 
 	ret = sensor_hub_get_feature(st->hsdev,
-		st->sensitivity.report_id,
-		st->sensitivity.index, &value);
+				     st->sensitivity.report_id,
+				     st->sensitivity.index, sizeof(value),
+				     &value);
 	if (ret < 0 || value < 0) {
 		*val1 = *val2 = 0;
 		return -EINVAL;
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 92068cd..ef0c495 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -76,8 +76,8 @@ int hid_sensor_power_state(struct hid_sensor_common *st, bool state)
 	}
 
 	sensor_hub_get_feature(st->hsdev, st->power_state.report_id,
-					st->power_state.index,
-					&state_val);
+			       st->power_state.index,
+			       sizeof(state_val), &state_val);
 	return 0;
 }
 EXPORT_SYMBOL(hid_sensor_power_state);
-- 
1.9.3
