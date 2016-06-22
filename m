Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:59584 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752177AbcFUWl6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 21 Jun 2016 18:41:58 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jikos@kernel.org, jic23@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 6/6] hid: hid-sensor-hub: Add ISH quirk
Date: Tue, 21 Jun 2016 22:40:38 -0700
Message-Id: <1466574038-20613-7-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1466574038-20613-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1466574038-20613-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Need enum quirk to change the base of enums to 1 for
power and report descriptors.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-hub.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 3d5ba5b..658a607 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -16,6 +16,7 @@
  * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
  *
  */
+
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
@@ -798,6 +799,9 @@ static const struct hid_device_id sensor_hub_devices[] = {
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_ITE,
 			USB_DEVICE_ID_ITE_LENOVO_YOGA900),
 			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
+	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_INTEL_0,
+			0x22D8),
+			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, HID_ANY_ID,
 		     HID_ANY_ID) },
 	{ }
-- 
2.5.5

