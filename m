Return-Path: <srinivas.pandruvada@intel.com>
From: srinivas pandruvada <srinivas.pandruvada@intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Jiri Kosina <jkosina@suse.cz>,
	srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH 1/8] HID-Sensors: Add ST Micro Sensor hub
Date: Sat,  9 Jun 2012 18:53:11 -0700
Message-Id: <1339293198-10404-2-git-send-email-srinivas.pandruvada@intel.com>
In-Reply-To: <1339293198-10404-1-git-send-email-srinivas.pandruvada@intel.com>
References: <1339293198-10404-1-git-send-email-srinivas.pandruvada@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Added senor hub present in Samsung XE700T Win8 demo slate PC.

Signed-off-by: srinivas pandruvada <srinivas.pandruvada@intel.com>
---
 drivers/hid/hid-core.c |    2 ++
 drivers/hid/hid-ids.h  |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index b7d758c..f160aab 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1548,6 +1548,8 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STANTUM_STM, USB_DEVICE_ID_MTP_STM) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STANTUM_SITRONIX, USB_DEVICE_ID_MTP_SITRONIX) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SUNPLUS, USB_DEVICE_ID_SUNPLUS_WDESKTOP) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STANTUM_STM,
+			 USB_DEVICE_ID_SENSOR_HUB_7014) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb300) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb304) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb323) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index e39aecb..7409750 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -664,6 +664,7 @@
 
 #define USB_VENDOR_ID_STANTUM_STM		0x0483
 #define USB_DEVICE_ID_MTP_STM		0x3261
+#define USB_DEVICE_ID_SENSOR_HUB_7014	0x7014
 
 #define USB_VENDOR_ID_STANTUM_SITRONIX		0x1403
 #define USB_DEVICE_ID_MTP_SITRONIX		0x5001
-- 
1.7.7.6
