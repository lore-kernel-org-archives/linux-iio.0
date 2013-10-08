Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] iio: hid-sensors: Fix power and report state
Date: Tue,  8 Oct 2013 14:32:43 -0700
Message-Id: <1381267963-14669-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

In the original HID sensor specifications all Named array enums stated
to be 0-based. But the most commercial devices implemented as 1-based,
because of the implementation by one of the major OS vendor. To fix this
we added a quirk, which required module to be recompiled. Instead now
added a module parameter, so that it can be switched at runtime.
By default it will be 1-based to be compatible with majority of devices.
This is true for both power and report state usage id for hid sensors.
Also added defines for power on values for D0 to D4 and using it for
clarity.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/common/hid-sensors/Kconfig             |  9 --------
 .../iio/common/hid-sensors/hid-sensor-trigger.c    | 26 +++++++++++++++++-----
 include/linux/hid-sensor-ids.h                     | 12 ++++++++++
 3 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/Kconfig b/drivers/iio/common/hid-sensors/Kconfig
index 1178121..39188b7 100644
--- a/drivers/iio/common/hid-sensors/Kconfig
+++ b/drivers/iio/common/hid-sensors/Kconfig
@@ -25,13 +25,4 @@ config HID_SENSOR_IIO_TRIGGER
 	  If this driver is compiled as a module, it will be named
 	  hid-sensor-trigger.
 
-config HID_SENSOR_ENUM_BASE_QUIRKS
-	bool "ENUM base quirks for HID Sensor IIO drivers"
-	depends on HID_SENSOR_IIO_COMMON
-	help
-	  Say yes here to build support for sensor hub FW using
-	  enumeration, which is using 1 as base instead of 0.
-	  Since logical minimum is still set 0 instead of 1,
-	  there is no easy way to differentiate.
-
 endmenu
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index b6e77e0..dbc9141 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -28,21 +28,37 @@
 #include <linux/iio/sysfs.h>
 #include "hid-sensor-trigger.h"
 
+#define	HID_SENSOR_NAMED_ARRAY_BASE	1
+static int hid_sensor_named_array_base = HID_SENSOR_NAMED_ARRAY_BASE;
+module_param(hid_sensor_named_array_base, int, 0644);
+MODULE_PARM_DESC(hid_sensor_named_array_base,
+	"HID SENSOR NAMED ARRAY BASE (0 or 1).");
+
 static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
 						bool state)
 {
 	struct hid_sensor_common *st = iio_trigger_get_drvdata(trig);
 	int state_val;
+	int report_state;
 
 	if (state) {
 		if (sensor_hub_device_open(st->hsdev))
 			return -EIO;
-	} else
+		state_val =
+		HID_USAGE_SENSOR_PROP_POWER_STATE_D0_FULL_POWER_ENUM;
+		report_state =
+		HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM;
+	} else {
 		sensor_hub_device_close(st->hsdev);
-
-	state_val = state ? 1 : 0;
-	if (IS_ENABLED(CONFIG_HID_SENSOR_ENUM_BASE_QUIRKS))
+		state_val =
+		HID_USAGE_SENSOR_PROP_POWER_STATE_D4_POWER_OFF_ENUM;
+		report_state =
+		HID_USAGE_SENSOR_PROP_REPORTING_STATE_NO_EVENTS_ENUM;
+	}
+	if (hid_sensor_named_array_base) {
 		++state_val;
+		++report_state;
+	}
 	st->data_ready = state;
 	sensor_hub_set_feature(st->hsdev, st->power_state.report_id,
 					st->power_state.index,
@@ -50,7 +66,7 @@ static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
 
 	sensor_hub_set_feature(st->hsdev, st->report_state.report_id,
 					st->report_state.index,
-					(s32)state_val);
+					(s32)report_state);
 
 	return 0;
 }
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index 4f945d3..8323775 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -117,4 +117,16 @@
 #define HID_USAGE_SENSOR_PROP_REPORT_STATE			0x200316
 #define HID_USAGE_SENSOR_PROY_POWER_STATE			0x200319
 
+/* Power state enumerations */
+#define HID_USAGE_SENSOR_PROP_POWER_STATE_UNDEFINED_ENUM		0x00
+#define HID_USAGE_SENSOR_PROP_POWER_STATE_D0_FULL_POWER_ENUM		0x01
+#define HID_USAGE_SENSOR_PROP_POWER_STATE_D1_LOW_POWER_ENUM		0x02
+#define HID_USAGE_SENSOR_PROP_POWER_STATE_D2_STANDBY_WITH_WAKE_ENUM	0x03
+#define HID_USAGE_SENSOR_PROP_POWER_STATE_D3_SLEEP_WITH_WAKE_ENUM	0x04
+#define HID_USAGE_SENSOR_PROP_POWER_STATE_D4_POWER_OFF_ENUM		0x05
+
+/* Report State enumerations */
+#define HID_USAGE_SENSOR_PROP_REPORTING_STATE_NO_EVENTS_ENUM		0x00
+#define HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM		0x01
+
 #endif
-- 
1.8.3.1
