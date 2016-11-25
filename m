Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752415AbcKYKLn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 25 Nov 2016 05:11:43 -0500
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jiri Kosina <jikos@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] HID: sensor-hub: add quirk for Microchip MM7150
Date: Fri, 25 Nov 2016 11:03:44 +0100
Message-Id: <1480068224-32224-3-git-send-email-benjamin.tissoires@redhat.com>
In-Reply-To: <1480068224-32224-1-git-send-email-benjamin.tissoires@redhat.com>
References: <1480068224-32224-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

One more device requiring a quirk :/

Reported-by: Christian-Nils Boda <christian-nils.boda@gadz.org>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-sensor-hub.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index f9440b6..9a1c5db 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -786,6 +786,9 @@ static const struct hid_device_id sensor_hub_devices[] = {
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_INTEL_1,
 			USB_DEVICE_ID_INTEL_HID_SENSOR_1),
 			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
+	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_MICROCHIP,
+			0x0f01), /* MM7150 */
+			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_STM_0,
 			USB_DEVICE_ID_STM_HID_SENSOR),
 			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
-- 
2.7.4

