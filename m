Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:22398 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752341AbdAECDr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 4 Jan 2017 21:03:47 -0500
From: Song Hongyan <hongyan.song@intel.com>
To: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@intel.com,
        Song Hongyan <hongyan.song@intel.com>
Subject: [PATCH v3 1/2] iio: Add channel for Gravity
Date: Thu,  5 Jan 2017 18:24:03 +0800
Message-Id: <1483611844-7078-1-git-send-email-hongyan.song@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add new channel types support for gravity sensor.

Gravity sensor provides an application-level or physical collection that
identifies a device that measures exclusively the force of Earth's
gravity along any number of axes.

More information can be found in:
http://www.usb.org/developers/hidpage/HUTRR59_-_Usages_for_Wearables.pdf

Signed-off-by: Song Hongyan <hongyan.song@intel.com>
---
changes: patch rebase

 Documentation/ABI/testing/sysfs-bus-iio | 10 ++++++++++
 drivers/iio/industrialio-core.c         |  1 +
 include/uapi/linux/iio/types.h          |  1 +
 tools/iio/iio_event_monitor.c           |  2 ++
 4 files changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index b8f220f..ed5bc2b 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -170,6 +170,16 @@ Description:
 		Has all of the equivalent parameters as per voltageY. Units
 		after application of scale and offset are m/s^2.
 
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
index aaca428..c601698 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -83,6 +83,7 @@ struct bus_type iio_bus_type = {
 	[IIO_ELECTRICALCONDUCTIVITY] = "electricalconductivity",
 	[IIO_COUNT] = "count",
 	[IIO_INDEX] = "index",
+	[IIO_GRAVITY]  = "gravity",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index e54d14a..ffafd6c 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -42,6 +42,7 @@ enum iio_chan_type {
 	IIO_ELECTRICALCONDUCTIVITY,
 	IIO_COUNT,
 	IIO_INDEX,
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

