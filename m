Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 10/14] staging:iio: push "sysfs.h" and linux/irq.h out of iio.h
Date: Tue, 30 Aug 2011 12:41:15 +0100
Message-Id: <1314704479-15956-11-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314704479-15956-1-git-send-email-jic23@cam.ac.uk>
References: <1314704479-15956-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

These are no longer needed.
Requires a few driver updates for places "sysfs.h" should have been
present but wasn't.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/dac/max517.c          |    1 +
 drivers/staging/iio/iio.h                 |    2 --
 drivers/staging/iio/industrialio-core.c   |    2 ++
 drivers/staging/iio/industrialio-ring.c   |    1 +
 drivers/staging/iio/light/isl29018.c      |    2 +-
 drivers/staging/iio/light/tsl2563.c       |    1 +
 drivers/staging/iio/magnetometer/ak8975.c |    2 +-
 7 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/dac/max517.c b/drivers/staging/iio/dac/max517.c
index ed5d351..d54262f 100644
--- a/drivers/staging/iio/dac/max517.c
+++ b/drivers/staging/iio/dac/max517.c
@@ -26,6 +26,7 @@
 #include <linux/err.h>
 
 #include "../iio.h"
+#include "../sysfs.h"
 #include "dac.h"
 
 #include "max517.h"
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 36a826e..6b896a5 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -13,8 +13,6 @@
 
 #include <linux/device.h>
 #include <linux/cdev.h>
-#include <linux/irq.h>
-#include "sysfs.h"
 
 /* IIO TODO LIST */
 /*
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index e83d626..f59a603 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -26,6 +26,8 @@
 #include "iio_core.h"
 #include "iio_core_trigger.h"
 #include "chrdev.h"
+#include "sysfs.h"
+
 /* IDA to assign each registered device a unique id*/
 static DEFINE_IDA(iio_ida);
 
diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/iio/industrialio-ring.c
index 947f542..e844246 100644
--- a/drivers/staging/iio/industrialio-ring.c
+++ b/drivers/staging/iio/industrialio-ring.c
@@ -22,6 +22,7 @@
 
 #include "iio.h"
 #include "iio_core.h"
+#include "sysfs.h"
 #include "ring_generic.h"
 
 
diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index da5bb33..f31e8c2 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -28,7 +28,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include "../iio.h"
-
+#include "../sysfs.h"
 #define CONVERSION_TIME_MS		100
 
 #define ISL29018_REG_ADD_COMMAND1	0x00
diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index 60d21f3..bd879ad 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -38,6 +38,7 @@
 #include <linux/slab.h>
 
 #include "../iio.h"
+#include "../sysfs.h"
 #include "tsl2563.h"
 
 /* Use this many bits for fraction part. */
diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
index a17fa9f..43936cb 100644
--- a/drivers/staging/iio/magnetometer/ak8975.c
+++ b/drivers/staging/iio/magnetometer/ak8975.c
@@ -31,7 +31,7 @@
 #include <linux/gpio.h>
 
 #include "../iio.h"
-
+#include "../sysfs.h"
 /*
  * Register definitions, as well as various shifts and masks to get at the
  * individual fields of the registers.
-- 
1.7.3.4
