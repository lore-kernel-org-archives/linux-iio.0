Return-Path: <SRS0=WIgL=XW=intel.com=hongyan.song@kernel.org>
From: Song Hongyan <hongyan.song@intel.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	jikos@kernel.org,
	srinivas.pandruvada@intel.com,
	Song Hongyan <hongyan.song@intel.com>
Subject: [RFC PATCH 1/2] iio: Add channel for Gravity
Date: Wed,  7 Dec 2016 18:14:34 +0800
Message-Id: <1481105675-27431-1-git-send-email-hongyan.song@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Add new channel types support for gravity sensor.

Signed-off-by: Song Hongyan <hongyan.song@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 11 +++++++++++
 drivers/iio/industrialio-core.c         |  1 +
 include/uapi/linux/iio/types.h          |  1 +
 tools/iio/iio_event_monitor.c           |  2 ++
 4 files changed, 15 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index fee35c0..60b7406 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -170,6 +170,17 @@ Description:
 		Has all of the equivalent parameters as per voltageY. Units
 		after application of scale and offset are m/s^2.
 
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_gravity_x_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_gravity_y_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_gravity_z_raw
+KernelVersion:	4.11
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Gravity in direction x, y or z (may be arbitrarily assigned
+		but should match other such assignments on device).
+		Units after application of scale and offset are m/s^2.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_x_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_raw
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index fc340ed..72fc96a 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -81,6 +81,7 @@ struct bus_type iio_bus_type = {
 	[IIO_PH] = "ph",
 	[IIO_UVINDEX] = "uvindex",
 	[IIO_ELECTRICALCONDUCTIVITY] = "electricalconductivity",
+	[IIO_GRAVITY]  = "gravity",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 22e5e58..d3f7ba7 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -40,6 +40,7 @@ enum iio_chan_type {
 	IIO_PH,
 	IIO_UVINDEX,
 	IIO_ELECTRICALCONDUCTIVITY,
+	IIO_GRAVITY,
 };
 
 enum iio_modifier {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index d9b7e0f..b61245e 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -57,6 +57,7 @@
 	[IIO_RESISTANCE] = "resistance",
 	[IIO_PH] = "ph",
 	[IIO_UVINDEX] = "uvindex",
+	[IIO_GRAVITY] = "gravity",
 };
 
 static const char * const iio_ev_type_text[] = {
@@ -149,6 +150,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_RESISTANCE:
 	case IIO_PH:
 	case IIO_UVINDEX:
+	case IIO_GRAVITY:
 		break;
 	default:
 		return false;
-- 
1.9.1
