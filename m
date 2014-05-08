Return-Path: <archana.patni@linux.intel.com>
From: Archana Patni <archana.patni@linux.intel.com>
To: jic23@kernel.org
Cc: jkosina@suse.cz,
	linux-iio@vger.kernel.org,
	srinivas.pandruvada@intel.com,
	Archana Patni <archana.patni@linux.intel.com>,
	Archana Patni <archana.patni@intel.com>,
	Subramony Sesha <subramony.sesha@intel.com>
Subject: [PATCH] iio: hid-sensors: Set default unit of measure for report interval
Date: Thu,  8 May 2014 09:36:09 -0400
Message-Id: <1399556169-10922-1-git-send-email-archana.patni@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

For PROP_REPORT_INTERVAL, the spec does not mandate the presence
of the report interval unit in the feature report and expects the
default unit of measure to be used as milliseconds.

Currently, when the unit is not present, it gets set as zero leading
to issues in sampling frequency.

This patch sets the unit of measure to the default unit if it
is not defined by firmware.

Signed-off-by: Archana Patni <archana.patni@intel.com>
Signed-off-by: Subramony Sesha <subramony.sesha@intel.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
---
 .../iio/common/hid-sensors/hid-sensor-attributes.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index 75b5473..55047af 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -209,15 +209,28 @@ int hid_sensor_write_raw_hyst_value(struct hid_sensor_common *st,
 }
 EXPORT_SYMBOL(hid_sensor_write_raw_hyst_value);
 
-int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
+int hid_sensor_get_reporting_interval(struct hid_sensor_hub_device *hsdev,
 					u32 usage_id,
 					struct hid_sensor_common *st)
 {
-
 	sensor_hub_input_get_attribute_info(hsdev,
 					HID_FEATURE_REPORT, usage_id,
 					HID_USAGE_SENSOR_PROP_REPORT_INTERVAL,
 					&st->poll);
+	/* Default unit of measure is milliseconds */
+	if (st->poll.units == 0)
+		st->poll.units = HID_USAGE_SENSOR_UNITS_MILLISECOND;
+	return 0;
+
+}
+
+int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
+					u32 usage_id,
+					struct hid_sensor_common *st)
+{
+
+
+	hid_sensor_get_reporting_interval(hsdev, usage_id, st);
 
 	sensor_hub_input_get_attribute_info(hsdev,
 					HID_FEATURE_REPORT, usage_id,
-- 
1.7.9.5
