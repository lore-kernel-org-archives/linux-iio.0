Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:51861 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755864AbcCTPU2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 20 Mar 2016 11:20:28 -0400
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v2 2/3] iio: Add channel for UV index
Date: Sun, 20 Mar 2016 16:20:23 +0100
Message-Id: <1458487224-3872-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1458487224-3872-1-git-send-email-pmeerw@pmeerw.net>
References: <1458487224-3872-1-git-send-email-pmeerw@pmeerw.net>
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
index 6fb9180..f155eff 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1264,6 +1264,15 @@ Description:
 		components or just infrared light, respectively. Modifier uv indicates
 		that measurements contain ultraviolet light components.
 
+What:		/sys/.../iio:deviceX/in_uvindex_input
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
index 88353ae..190a593 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -79,6 +79,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_CONCENTRATION] = "concentration",
 	[IIO_RESISTANCE] = "resistance",
 	[IIO_PH] = "ph",
+	[IIO_UVINDEX] = "uvindex",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 9337ece..b0916fc 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -38,6 +38,7 @@ enum iio_chan_type {
 	IIO_CONCENTRATION,
 	IIO_RESISTANCE,
 	IIO_PH,
+	IIO_UVINDEX,
 };
 
 enum iio_modifier {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 8d7d979..d9b7e0f 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -56,6 +56,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_CONCENTRATION] = "concentration",
 	[IIO_RESISTANCE] = "resistance",
 	[IIO_PH] = "ph",
+	[IIO_UVINDEX] = "uvindex",
 };
 
 static const char * const iio_ev_type_text[] = {
@@ -147,6 +148,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_CONCENTRATION:
 	case IIO_RESISTANCE:
 	case IIO_PH:
+	case IIO_UVINDEX:
 		break;
 	default:
 		return false;
-- 
1.9.1

