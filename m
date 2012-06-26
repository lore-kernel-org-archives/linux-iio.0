Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24029 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755767Ab2FZBEo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 25 Jun 2012 21:04:44 -0400
From: srinivas pandruvada <srinivas.pandruvada@intel.com>
To: linux-iio@vger.kernel.org
Cc: jic23.cam.ac.uk@vger.kernel.org, jkosina@suse.cz,
	linux-input@vger.kernel.org,
	srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH, 1/6] HID Sensors: Add to special driver list
Date: Mon, 25 Jun 2012 17:54:09 -0700
Message-Id: <1340672054-16591-2-git-send-email-srinivas.pandruvada@intel.com>
In-Reply-To: <1340672054-16591-1-git-send-email-srinivas.pandruvada@intel.com>
References: <1340672054-16591-1-git-send-email-srinivas.pandruvada@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Adding Intel and STM sensor hub in the list of drivers with
specialized driver.

Change-Id: I91591b663f62a29ac4823f3c6f282d9da22a141a
Signed-off-by: srinivas pandruvada <srinivas.pandruvada@intel.com>
---
 drivers/hid/hid-core.c |   10 ++++++++++
 drivers/hid/hid-ids.h  |    6 ++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index b7d758c..5eb3faa 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1444,6 +1444,14 @@ static const struct hid_device_id hid_have_special_driver[] = {
  	{ HID_USB_DEVICE(USB_VENDOR_ID_IDEACOM, USB_DEVICE_ID_IDEACOM_IDC6650) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK, USB_DEVICE_ID_HOLTEK_ON_LINE_GRIP) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ILITEK, USB_DEVICE_ID_ILITEK_MULTITOUCH) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_INTEL_8086,
+					USB_DEVICE_ID_SENSOR_HUB_1020) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_INTEL_8086,
+					USB_DEVICE_ID_SENSOR_HUB_09FA) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_INTEL_8087,
+					USB_DEVICE_ID_SENSOR_HUB_1020) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_INTEL_8087,
+					USB_DEVICE_ID_SENSOR_HUB_09FA) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_IRTOUCHSYSTEMS, USB_DEVICE_ID_IRTOUCH_INFRARED_USB) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KENSINGTON, USB_DEVICE_ID_KS_SLIMBLADE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KEYTOUCH, USB_DEVICE_ID_KEYTOUCH_IEC) },
@@ -1548,6 +1556,8 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STANTUM_STM, USB_DEVICE_ID_MTP_STM) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STANTUM_SITRONIX, USB_DEVICE_ID_MTP_SITRONIX) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SUNPLUS, USB_DEVICE_ID_SUNPLUS_WDESKTOP) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STANTUM_STM,
+			 USB_DEVICE_ID_SENSOR_HUB_7014) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb300) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb304) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb323) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index e39aecb..928fe57 100644
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
 
@@ -664,6 +669,7 @@
 
 #define USB_VENDOR_ID_STANTUM_STM		0x0483
 #define USB_DEVICE_ID_MTP_STM		0x3261
+#define USB_DEVICE_ID_SENSOR_HUB_7014	0x7014
 
 #define USB_VENDOR_ID_STANTUM_SITRONIX		0x1403
 #define USB_DEVICE_ID_MTP_SITRONIX		0x5001
-- 
1.7.7.6

