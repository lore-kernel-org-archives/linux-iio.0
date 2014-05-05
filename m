Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] iio: hid-sensors: Fix unit conversion
Date: Sun,  4 May 2014 18:02:00 -0700
Message-Id: <1399251720-8158-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

When no units are specified the default units are milli-gauss. So
need to divide by 1000 to get iio default of Gauss.
Similarly the default units conversion from degrees to radians.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index 29185a0..3729646 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -44,10 +44,10 @@ struct {
 	{HID_USAGE_SENSOR_GYRO_3D,
 		HID_USAGE_SENSOR_UNITS_DEGREES_PER_SECOND, 0, 17453},
 
-	{HID_USAGE_SENSOR_COMPASS_3D, 0, 1000, 0},
+	{HID_USAGE_SENSOR_COMPASS_3D, 0, 0, 1000},
 	{HID_USAGE_SENSOR_COMPASS_3D, HID_USAGE_SENSOR_UNITS_GAUSS, 1, 0},
 
-	{HID_USAGE_SENSOR_INCLINOMETER_3D, 0, 17453, 0},
+	{HID_USAGE_SENSOR_INCLINOMETER_3D, 0, 0, 17453},
 	{HID_USAGE_SENSOR_INCLINOMETER_3D,
 		HID_USAGE_SENSOR_UNITS_DEGREES, 0, 17453},
 	{HID_USAGE_SENSOR_INCLINOMETER_3D,
-- 
1.9.1
