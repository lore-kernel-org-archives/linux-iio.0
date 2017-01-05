Return-Path: <SRS0=7SkH=YT=intel.com=hongyan.song@kernel.org>
From: Song Hongyan <hongyan.song@intel.com>
To: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@intel.com,
	Song Hongyan <hongyan.song@intel.com>
Subject: [PATCH v2 1/2] iio: Add support for linear accel
Date: Thu,  5 Jan 2017 19:03:03 +0800
Message-Id: <1483614184-1038-1-git-send-email-hongyan.song@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Add new channel types support for linear accel sensor.
Linear acceleration differs from a standard accelerometor,
its value depends on standard accel sensor and gravity sensor.
Conceptually, this three sensors have following relationship:
linear acceleration = acceleration - acceleration due to gravity

At rest, standard accelerometer displays 1g due to earth’s
gravitational pull while a liner accelerometer will show 0g.

More information can be found in:
http://www.usb.org/developers/hidpage/HUTRR59_-_Usages_for_Wearables.pdf

Signed-off-by: Song Hongyan <hongyan.song@intel.com>
---
changes: unify the name not use underline as separator.

 Documentation/ABI/testing/sysfs-bus-iio | 13 +++++++++++++
 drivers/iio/industrialio-core.c         |  1 +
 include/uapi/linux/iio/types.h          |  1 +
 tools/iio/iio_event_monitor.c           |  2 ++
 4 files changed, 17 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index ed5bc2b..0204473 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -170,6 +170,19 @@ Description:
 		Has all of the equivalent parameters as per voltageY. Units
 		after application of scale and offset are m/s^2.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_linearaccel_x_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_linearaccel_y_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_linearaccel_z_raw
+KernelVersion:	4.11
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Linear Acceleration in direction x, y or z (may be arbitrarily
+		assigned but should match other such assignments on device).
+		The sensor data is derives from standard accelerometer device
+		by filtering out the acceleration which is caused by the force
+		of Earth’s gravity.Units after application of scale and offset
+		are m/s^2.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_gravity_x_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_gravity_y_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_gravity_z_raw
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index c601698..a1fc446 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -84,6 +84,7 @@ struct bus_type iio_bus_type = {
 	[IIO_COUNT] = "count",
 	[IIO_INDEX] = "index",
 	[IIO_GRAVITY]  = "gravity",
+	[IIO_LINEARACCEL] = "linearaccel",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index ffafd6c..41d8465 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -43,6 +43,7 @@ enum iio_chan_type {
 	IIO_COUNT,
 	IIO_INDEX,
 	IIO_GRAVITY,
+	IIO_LINEARACCEL,
 };
 
 enum iio_modifier {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index b61245e..a8e7896 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -58,6 +58,7 @@
 	[IIO_PH] = "ph",
 	[IIO_UVINDEX] = "uvindex",
 	[IIO_GRAVITY] = "gravity",
+	[IIO_LINEARACCEL] = "linearaccel",
 };
 
 static const char * const iio_ev_type_text[] = {
@@ -151,6 +152,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_PH:
 	case IIO_UVINDEX:
 	case IIO_GRAVITY:
+	case IIO_LINEARACCEL:
 		break;
 	default:
 		return false;
-- 
1.9.1
