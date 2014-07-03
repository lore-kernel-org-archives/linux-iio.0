Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:51078 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbaGCGsL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 3 Jul 2014 02:48:11 -0400
Received: by mail-pa0-f46.google.com with SMTP id eu11so13965079pac.33
        for <linux-iio@vger.kernel.org>; Wed, 02 Jul 2014 23:48:10 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@samsung.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, spk.linux@gmail.com,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 7/7] iio: hid-sensors: Fix compilation warning
Date: Thu,  3 Jul 2014 12:14:12 +0530
Message-Id: <1404369852-3255-7-git-send-email-sachin.kamat@samsung.com>
In-Reply-To: <1404369852-3255-1-git-send-email-sachin.kamat@samsung.com>
References: <1404369852-3255-1-git-send-email-sachin.kamat@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Move the 'static' keyword to beginning of definition to silence the
following compilation warning:
drivers/iio/common/hid-sensors/hid-sensor-attributes.c:34:1: warning: ‘static’ is not at beginning of declaration [-Wold-style-declaration]

Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../iio/common/hid-sensors/hid-sensor-attributes.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index 403dd3d..1614340 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -26,12 +26,12 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-struct {
+static struct {
 	u32 usage_id;
 	int unit; /* 0 for default others from HID sensor spec */
 	int scale_val0; /* scale, whole number */
 	int scale_val1; /* scale, fraction in micros */
-} static unit_conversion[] = {
+} unit_conversion[] = {
 	{HID_USAGE_SENSOR_ACCEL_3D, 0, 9, 806650},
 	{HID_USAGE_SENSOR_ACCEL_3D,
 		HID_USAGE_SENSOR_UNITS_METERS_PER_SEC_SQRD, 1, 0},
-- 
1.7.9.5

