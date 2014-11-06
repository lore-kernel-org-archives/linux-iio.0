Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42722 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbaKFPSi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Nov 2014 10:18:38 -0500
From: Dan Murphy <dmurphy@ti.com>
To: <linux-iio@vger.kernel.org>, <jic23@kernel.org>
CC: <pmeerw@pmeerw.net>, <daniel.baluta@intel.com>,
	<k.wrona@samsung.com>, Dan Murphy <dmurphy@ti.com>
Subject: [RFC v2 1/3] iio: heart_monitors: Add support for heart rate monitors
Date: Thu, 6 Nov 2014 09:18:24 -0600
Message-ID: <1415287106-13491-1-git-send-email-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add a type for heart rate monitors
Add the modifier name in beats per minute.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v2 - Updated per v1 comments - http://marc.info/?l=linux-iio&m=141331404232216&w=2

 Documentation/ABI/testing/sysfs-bus-iio               | 7 +++++++
 drivers/iio/industrialio-core.c                       | 1 +
 drivers/staging/iio/Documentation/iio_event_monitor.c | 2 ++
 include/linux/iio/types.h                             | 3 ++-
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d760b02..bf95808 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1028,3 +1028,10 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Raw value of rotation from true/magnetic north measured with
 		or without compensation from tilt sensors.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_rot_from_north_magnetic_tilt_comp_raw
+KernelVersion:	3.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw value of rotation from true/magnetic north measured with
+		or without compensation from tilt sensors.
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index af3e76d..e332a18 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -70,6 +70,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_CCT] = "cct",
 	[IIO_PRESSURE] = "pressure",
 	[IIO_HUMIDITYRELATIVE] = "humidityrelative",
+	[IIO_HEARTRATE] = "heartrate",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/drivers/staging/iio/Documentation/iio_event_monitor.c b/drivers/staging/iio/Documentation/iio_event_monitor.c
index 569d6f8..90a655d 100644
--- a/drivers/staging/iio/Documentation/iio_event_monitor.c
+++ b/drivers/staging/iio/Documentation/iio_event_monitor.c
@@ -49,6 +49,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_CCT] = "cct",
 	[IIO_PRESSURE] = "pressure",
 	[IIO_HUMIDITYRELATIVE] = "humidityrelative",
+	[IIO_HEARTRATE] = "heartrate"
 };
 
 static const char * const iio_ev_type_text[] = {
@@ -108,6 +109,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_CCT:
 	case IIO_PRESSURE:
 	case IIO_HUMIDITYRELATIVE:
+	case IIO_HEARTRATE:
 		break;
 	default:
 		return false;
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 4a2af8a..f22b9d6 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -30,6 +30,7 @@ enum iio_chan_type {
 	IIO_CCT,
 	IIO_PRESSURE,
 	IIO_HUMIDITYRELATIVE,
+	IIO_HEARTRATE,
 };
 
 enum iio_modifier {
@@ -59,7 +60,7 @@ enum iio_modifier {
 	IIO_MOD_NORTH_MAGN,
 	IIO_MOD_NORTH_TRUE,
 	IIO_MOD_NORTH_MAGN_TILT_COMP,
-	IIO_MOD_NORTH_TRUE_TILT_COMP
+	IIO_MOD_NORTH_TRUE_TILT_COMP,
 };
 
 enum iio_event_type {
-- 
1.9.1

