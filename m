Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:51859 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755523AbcCTPU2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 20 Mar 2016 11:20:28 -0400
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v2 1/3] iio: Add modifier for UV light
Date: Sun, 20 Mar 2016 16:20:22 +0100
Message-Id: <1458487224-3872-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1458487224-3872-1-git-send-email-pmeerw@pmeerw.net>
References: <1458487224-3872-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
---
 Documentation/ABI/testing/sysfs-bus-iio | 4 +++-
 drivers/iio/industrialio-core.c         | 1 +
 include/uapi/linux/iio/types.h          | 1 +
 tools/iio/iio_event_monitor.c           | 2 ++
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 17a9210..6fb9180 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1255,12 +1255,14 @@ Description:
 What:		/sys/.../iio:deviceX/in_intensityY_raw
 What:		/sys/.../iio:deviceX/in_intensityY_ir_raw
 What:		/sys/.../iio:deviceX/in_intensityY_both_raw
+What:		/sys/.../iio:deviceX/in_intensityY_uv_raw
 KernelVersion:	3.4
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Unit-less light intensity. Modifiers both and ir indicate
 		that measurements contains visible and infrared light
-		components or just infrared light, respectively.
+		components or just infrared light, respectively. Modifier uv indicates
+		that measurements contain ultraviolet light components.
 
 What:		/sys/.../iio:deviceX/in_intensity_red_integration_time
 What:		/sys/.../iio:deviceX/in_intensity_green_integration_time
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 2e768bc..88353ae 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -101,6 +101,7 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_LIGHT_RED] = "red",
 	[IIO_MOD_LIGHT_GREEN] = "green",
 	[IIO_MOD_LIGHT_BLUE] = "blue",
+	[IIO_MOD_LIGHT_UV] = "uv",
 	[IIO_MOD_QUATERNION] = "quaternion",
 	[IIO_MOD_TEMP_AMBIENT] = "ambient",
 	[IIO_MOD_TEMP_OBJECT] = "object",
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index c077617..9337ece 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -77,6 +77,7 @@ enum iio_modifier {
 	IIO_MOD_Q,
 	IIO_MOD_CO2,
 	IIO_MOD_VOC,
+	IIO_MOD_LIGHT_UV,
 };
 
 enum iio_event_type {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 90980f5..8d7d979 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -93,6 +93,7 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_LIGHT_RED] = "red",
 	[IIO_MOD_LIGHT_GREEN] = "green",
 	[IIO_MOD_LIGHT_BLUE] = "blue",
+	[IIO_MOD_LIGHT_UV] = "uv",
 	[IIO_MOD_QUATERNION] = "quaternion",
 	[IIO_MOD_TEMP_AMBIENT] = "ambient",
 	[IIO_MOD_TEMP_OBJECT] = "object",
@@ -172,6 +173,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_MOD_LIGHT_RED:
 	case IIO_MOD_LIGHT_GREEN:
 	case IIO_MOD_LIGHT_BLUE:
+	case IIO_MOD_LIGHT_UV:
 	case IIO_MOD_QUATERNION:
 	case IIO_MOD_TEMP_AMBIENT:
 	case IIO_MOD_TEMP_OBJECT:
-- 
1.9.1

