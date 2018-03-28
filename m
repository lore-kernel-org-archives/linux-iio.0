Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42267 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeC1XyB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Mar 2018 19:54:01 -0400
Received: by mail-pf0-f193.google.com with SMTP id a16so1937227pfn.9
        for <linux-iio@vger.kernel.org>; Wed, 28 Mar 2018 16:54:01 -0700 (PDT)
From: Gwendal Grignou <gwendal@chromium.org>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, enric.balletbo@collabora.com
Subject: [PATCH v2] iio: cros_ec: Move cros_ec_sensors_core.h in /include
Date: Wed, 28 Mar 2018 16:53:49 -0700
Message-Id: <20180328235349.111656-1-gwendal@chromium.org>
In-Reply-To: <20180317200003.595e88d5@archlinux>
References: <20180317200003.595e88d5@archlinux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Similar to other common iio frameworks, move cros_ec_sensors_core.h from
drivers/iio/common/cros_ec_sensors/ to include/linux/iio/common.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---

Changes in v2:
- Include linux/platform_device.h in cros_ec_sensors_core.h

 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c           | 3 +--
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c      | 3 +--
 drivers/iio/light/cros_ec_light_prox.c                         | 3 +--
 drivers/iio/pressure/cros_ec_baro.c                            | 3 +--
 .../linux/iio/common}/cros_ec_sensors_core.h                   | 3 +++
 5 files changed, 7 insertions(+), 8 deletions(-)
 rename {drivers/iio/common/cros_ec_sensors => include/linux/iio/common}/cros_ec_sensors_core.h (98%)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index 7d30c59da3e2..8e3f99a8b30c 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/common/cros_ec_sensors_core.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/trigger_consumer.h>
@@ -31,8 +32,6 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 
-#include "cros_ec_sensors_core.h"
-
 #define CROS_EC_SENSORS_MAX_CHANNELS 4
 
 /* State data for ec_sensors iio driver. */
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 416cae5ebbd0..ea3268bd92f4 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/common/cros_ec_sensors_core.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/trigger_consumer.h>
@@ -27,8 +28,6 @@
 #include <linux/sysfs.h>
 #include <linux/platform_device.h>
 
-#include "cros_ec_sensors_core.h"
-
 static char *cros_ec_loc[] = {
 	[MOTIONSENSE_LOC_BASE] = "base",
 	[MOTIONSENSE_LOC_LID] = "lid",
diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
index acfad4aeb27a..15bd105b08f3 100644
--- a/drivers/iio/light/cros_ec_light_prox.c
+++ b/drivers/iio/light/cros_ec_light_prox.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/common/cros_ec_sensors_core.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/trigger.h>
@@ -29,8 +30,6 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 
-#include "../common/cros_ec_sensors/cros_ec_sensors_core.h"
-
 /*
  * We only represent one entry for light or proximity. EC is merging different
  * light sensors to return the what the eye would see. For proximity, we
diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
index 4599fde4dd25..87c07af9181f 100644
--- a/drivers/iio/pressure/cros_ec_baro.c
+++ b/drivers/iio/pressure/cros_ec_baro.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/common/cros_ec_sensors_core.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/trigger.h>
@@ -28,8 +29,6 @@
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 
-#include "../common/cros_ec_sensors/cros_ec_sensors_core.h"
-
 /*
  * One channel for pressure, the other for timestamp.
  */
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
similarity index 98%
rename from drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h
rename to include/linux/iio/common/cros_ec_sensors_core.h
index 8bc2ca3c2e2e..e6b6190ba8af 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -16,7 +16,10 @@
 #ifndef __CROS_EC_SENSORS_CORE_H
 #define __CROS_EC_SENSORS_CORE_H
 
+#include <linux/iio/iio.h>
 #include <linux/irqreturn.h>
+#include <linux/mfd/cros_ec.h>
+#include <linux/platform_device.h>
 
 enum {
 	CROS_EC_SENSOR_X,
-- 
2.17.0.rc1.321.gba9d0f2565-goog

