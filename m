Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:44211 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754038AbcCPBGU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 15 Mar 2016 21:06:20 -0400
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 2/3] iio: Add modifier for UV index
Date: Wed, 16 Mar 2016 02:06:15 +0100
Message-Id: <1458090376-26729-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1458090376-26729-1-git-send-email-pmeerw@pmeerw.net>
References: <1458090376-26729-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

UV index indicating strength of sunburn-producing ultraviolet (UV) radiation

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
---
 Documentation/ABI/testing/sysfs-bus-iio | 9 +++++++++
 drivers/iio/industrialio-core.c         | 1 +
 include/uapi/linux/iio/types.h          | 1 +
 tools/iio/iio_event_monitor.c           | 2 ++
 4 files changed, 13 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 6fb9180..26da49b 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1264,6 +1264,15 @@ Description:
 		components or just infrared light, respectively. Modifier uv indicates
 		that measurements contain ultraviolet light components.
 
+What:		/sys/.../iio:deviceX/in_intensityY_uv_index_input
+KernelVersion:	4.6
+Contact:	linux-iio@vger.kernel.org
+Description:
+		UV light intensity index measuring the human skin's response to
+		different wavelength of sunlight weighted according to the
+		standardised CIE Erythemal Action Spectrum. UV index values range
+		from 0 (low) to >=11 (extreme).
+
 What:		/sys/.../iio:deviceX/in_intensity_red_integration_time
 What:		/sys/.../iio:deviceX/in_intensity_green_integration_time
 What:		/sys/.../iio:deviceX/in_intensity_blue_integration_time
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 88353ae..420aa06 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -102,6 +102,7 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_LIGHT_GREEN] = "green",
 	[IIO_MOD_LIGHT_BLUE] = "blue",
 	[IIO_MOD_LIGHT_UV] = "uv",
+	[IIO_MOD_LIGHT_UV_INDEX] = "uv_index",
 	[IIO_MOD_QUATERNION] = "quaternion",
 	[IIO_MOD_TEMP_AMBIENT] = "ambient",
 	[IIO_MOD_TEMP_OBJECT] = "object",
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 9337ece..0946c3e 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -78,6 +78,7 @@ enum iio_modifier {
 	IIO_MOD_CO2,
 	IIO_MOD_VOC,
 	IIO_MOD_LIGHT_UV,
+	IIO_MOD_LIGHT_UV_INDEX,
 };
 
 enum iio_event_type {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 8d7d979..0965349 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -94,6 +94,7 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_LIGHT_GREEN] = "green",
 	[IIO_MOD_LIGHT_BLUE] = "blue",
 	[IIO_MOD_LIGHT_UV] = "uv",
+	[IIO_MOD_LIGHT_UV_INDEX] = "uv_index",
 	[IIO_MOD_QUATERNION] = "quaternion",
 	[IIO_MOD_TEMP_AMBIENT] = "ambient",
 	[IIO_MOD_TEMP_OBJECT] = "object",
@@ -174,6 +175,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_MOD_LIGHT_GREEN:
 	case IIO_MOD_LIGHT_BLUE:
 	case IIO_MOD_LIGHT_UV:
+	case IIO_MOD_LIGHT_UV_INDEX:
 	case IIO_MOD_QUATERNION:
 	case IIO_MOD_TEMP_AMBIENT:
 	case IIO_MOD_TEMP_OBJECT:
-- 
1.9.1

