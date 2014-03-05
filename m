Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:38441 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907AbaCEAYf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Mar 2014 19:24:35 -0500
Received: by mail-qg0-f46.google.com with SMTP id e89so864749qgf.5
        for <linux-iio@vger.kernel.org>; Tue, 04 Mar 2014 16:24:34 -0800 (PST)
Received: from [192.168.94.198] ([199.4.160.88])
        by mx.google.com with ESMTPSA id q10sm1951713qaj.13.2014.03.04.16.17.29
        for <linux-iio@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Mar 2014 16:17:30 -0800 (PST)
Message-ID: <53166D17.10104@gmail.com>
Date: Tue, 04 Mar 2014 16:17:27 -0800
From: "Peter F. Patel-Schneider" <pfpschneider@gmail.com>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PATCH] iio:hid-sensor-hub: Add in quirk for sensor hub in Lenovo
 Ideapad Yogas
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The sensor hub in Lenovo Yogas needs the ennumeration quirk.  I've been 
running the patch for about a week with no problems, whereas theunpatched 
drivers reliably mis-initialized the sensors.

Signed-off-by: Peter F. Patel-Schneider <pfpschneider@gmail.com>
---
  drivers/hid/hid-ids.h        | 3 +++
  drivers/hid/hid-sensor-hub.c | 3 +++
  2 files changed, 6 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 5a5248f..f944e37 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -823,6 +823,9 @@
  #define USB_DEVICE_ID_SYNAPTICS_HD    0x0ac3
  #define USB_DEVICE_ID_SYNAPTICS_QUAD_HD    0x1ac3

+#define USB_VENDOR_ID_TEXAS_INSTRUMENTS    0x2047
+#define USB_DEVICE_ID_TEXAS_INSTRUMENTS_LENOVO_YOGA    0x0855
+
  #define USB_VENDOR_ID_THINGM        0x27b8
  #define USB_DEVICE_ID_BLINK1        0x01ed

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 46f4480..597732b 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -665,6 +665,9 @@ static const struct hid_device_id sensor_hub_devices[] = {
      { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_INTEL_1,
              USB_DEVICE_ID_INTEL_HID_SENSOR),
              .driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
+    { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, 
USB_VENDOR_ID_TEXAS_INSTRUMENTS,
+             USB_DEVICE_ID_TEXAS_INSTRUMENTS_LENOVO_YOGA),
+             .driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
      { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, HID_ANY_ID,
               HID_ANY_ID) },
      { }

