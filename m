Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:4516 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752664AbdCTAuL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Mar 2017 20:50:11 -0400
From: Song Hongyan <hongyan.song@intel.com>
To: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@intel.com,
        Song Hongyan <hongyan.song@intel.com>
Subject: [PATCH] iio: hid-sensor-attributes: Fix gravity sensor scale value not right issue
Date: Mon, 20 Mar 2017 17:12:54 +0800
Message-Id: <1490001174-897-1-git-send-email-hongyan.song@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Scale value include two parts: unit conversion and exponent conversion.
Add gravity unit convert table to fix gravity sensor scale value not
right issue.

Signed-off-by: Song Hongyan <hongyan.song@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index cc2ce2a..2884783 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -38,6 +38,12 @@
 	{HID_USAGE_SENSOR_ACCEL_3D,
 		HID_USAGE_SENSOR_UNITS_G, 9, 806650000},
 
+	{HID_USAGE_SENSOR_GRAVITY_VECTOR, 0, 9, 806650000},
+	{HID_USAGE_SENSOR_GRAVITY_VECTOR,
+		HID_USAGE_SENSOR_UNITS_METERS_PER_SEC_SQRD, 1, 0},
+	{HID_USAGE_SENSOR_GRAVITY_VECTOR,
+		HID_USAGE_SENSOR_UNITS_G, 9, 806650000},
+
 	{HID_USAGE_SENSOR_GYRO_3D, 0, 0, 17453293},
 	{HID_USAGE_SENSOR_GYRO_3D,
 		HID_USAGE_SENSOR_UNITS_RADIANS_PER_SECOND, 1, 0},
-- 
1.9.1

