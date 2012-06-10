Return-Path: <srinivas.pandruvada@intel.com>
From: srinivas pandruvada <srinivas.pandruvada@intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Jiri Kosina <jkosina@suse.cz>,
	srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH 2/8] HID-Sensors: Add Intel HID sensor
Date: Sat,  9 Jun 2012 18:53:12 -0700
Message-Id: <1339293198-10404-3-git-send-email-srinivas.pandruvada@intel.com>
In-Reply-To: <1339293198-10404-1-git-send-email-srinivas.pandruvada@intel.com>
References: <1339293198-10404-1-git-send-email-srinivas.pandruvada@intel.com>
List-ID: <linux-iio@vger.kernel.org>

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
