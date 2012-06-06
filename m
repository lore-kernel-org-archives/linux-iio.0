Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:10646 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755972Ab2FFPuc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 6 Jun 2012 11:50:32 -0400
From: srinivas pandruvada <srinivas.pandruvada@intel.com>
To: linux-input@vger.kernel.org
Cc: linux-iio@vger.kernel.org,
	srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH, 1/7] HID-Sensors: Add Intel HID sensor
Date: Wed,  6 Jun 2012 08:39:18 -0700
Message-Id: <1338997164-5077-2-git-send-email-srinivas.pandruvada@intel.com>
In-Reply-To: <1338997164-5077-1-git-send-email-srinivas.pandruvada@intel.com>
References: <1338997164-5077-1-git-send-email-srinivas.pandruvada@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added Intel vendor id/product id and added in the list
for ignoring Intel vendor id/product id for HID.

Signed-off-by: srinivas pandruvada <srinivas.pandruvada@intel.com>
---
 drivers/hid/hid-core.c |    6 ++++++
 drivers/hid/hid-ids.h  |    5 +++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index f160aab..fad31c5 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1444,6 +1444,12 @@ static const struct hid_device_id hid_have_special_driver[] = {
  	{ HID_USB_DEVICE(USB_VENDOR_ID_IDEACOM, USB_DEVICE_ID_IDEACOM_IDC6650) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK, USB_DEVICE_ID_HOLTEK_ON_LINE_GRIP) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ILITEK, USB_DEVICE_ID_ILITEK_MULTITOUCH) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_INTEL_8086,
+					USB_DEVICE_ID_SENSOR_HUB_1020) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_INTEL_8087,
+					USB_DEVICE_ID_SENSOR_HUB_09FA) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_INTEL_8087,
+					USB_DEVICE_ID_SENSOR_HUB_09FA) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_IRTOUCHSYSTEMS, USB_DEVICE_ID_IRTOUCH_INFRARED_USB) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KENSINGTON, USB_DEVICE_ID_KS_SLIMBLADE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KEYTOUCH, USB_DEVICE_ID_KEYTOUCH_IEC) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 7409750..928fe57 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -401,6 +401,11 @@
 #define USB_VENDOR_ID_IMATION		0x0718
 #define USB_DEVICE_ID_DISC_STAKKA	0xd000
 
+#define USB_VENDOR_ID_INTEL_8086	0x8086
+#define USB_VENDOR_ID_INTEL_8087	0x8087
+#define USB_DEVICE_ID_SENSOR_HUB_1020	0x1020
+#define USB_DEVICE_ID_SENSOR_HUB_09FA	0x09FA
+
 #define USB_VENDOR_ID_IRTOUCHSYSTEMS	0x6615
 #define USB_DEVICE_ID_IRTOUCH_INFRARED_USB	0x0070
 
-- 
1.7.7.6

