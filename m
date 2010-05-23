Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:59853 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667Ab0EWHGf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 23 May 2010 03:06:35 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH] staging:iio: pull in slab.h for kmalloc funcs
Date: Sun, 23 May 2010 03:10:35 -0400
Message-Id: <1274598635-12193-1-git-send-email-vapier@gentoo.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These drivers use kzalloc() but don't include slab.h.  They currently
build though because the spi.h header will pull in slab.h for us.  But
rather than rely on that behavior forever, include slab.h explicitly.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/staging/iio/accel/adis16209_core.c |    2 +-
 drivers/staging/iio/accel/adis16209_ring.c |    1 +
 drivers/staging/iio/accel/adis16220_core.c |    2 +-
 drivers/staging/iio/accel/adis16240_core.c |    2 +-
 drivers/staging/iio/accel/adis16240_ring.c |    1 +
 drivers/staging/iio/gyro/adis16260_core.c  |    2 +-
 drivers/staging/iio/gyro/adis16260_ring.c  |    1 +
 drivers/staging/iio/imu/adis16300_core.c   |    2 +-
 drivers/staging/iio/imu/adis16300_ring.c   |    1 +
 drivers/staging/iio/imu/adis16350_core.c   |    2 +-
 drivers/staging/iio/imu/adis16350_ring.c   |    1 +
 drivers/staging/iio/imu/adis16400_core.c   |    2 +-
 drivers/staging/iio/imu/adis16400_ring.c   |    1 +
 13 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index ac375c5..b3acdc3 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -14,7 +14,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
-
+#include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/list.h>
 
diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index 533e285..8959ad8 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -6,6 +6,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
+#include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/list.h>
 
diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index 6de439f..fefeca2 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -14,7 +14,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
-
+#include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/list.h>
 
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 54fd6d7..316022f 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -14,7 +14,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
-
+#include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/list.h>
 
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index 26b677b..490d80e 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -6,6 +6,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
+#include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/list.h>
 
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index c93f4d5..f0246a4 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -14,7 +14,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
-
+#include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/list.h>
 
diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index 4c4390c..2fe7f02 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -6,6 +6,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
+#include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/list.h>
 
diff --git a/drivers/staging/iio/imu/adis16300_core.c b/drivers/staging/iio/imu/adis16300_core.c
index 5a7e5ef..bf02fbe 100644
--- a/drivers/staging/iio/imu/adis16300_core.c
+++ b/drivers/staging/iio/imu/adis16300_core.c
@@ -14,7 +14,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
-
+#include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/list.h>
 
diff --git a/drivers/staging/iio/imu/adis16300_ring.c b/drivers/staging/iio/imu/adis16300_ring.c
index 76cf8a6..9c01994 100644
--- a/drivers/staging/iio/imu/adis16300_ring.c
+++ b/drivers/staging/iio/imu/adis16300_ring.c
@@ -6,6 +6,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
+#include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/list.h>
 
diff --git a/drivers/staging/iio/imu/adis16350_core.c b/drivers/staging/iio/imu/adis16350_core.c
index 0edde73..145966b 100644
--- a/drivers/staging/iio/imu/adis16350_core.c
+++ b/drivers/staging/iio/imu/adis16350_core.c
@@ -14,7 +14,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
-
+#include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/list.h>
 
diff --git a/drivers/staging/iio/imu/adis16350_ring.c b/drivers/staging/iio/imu/adis16350_ring.c
index 5e9716e..2a0a465 100644
--- a/drivers/staging/iio/imu/adis16350_ring.c
+++ b/drivers/staging/iio/imu/adis16350_ring.c
@@ -6,6 +6,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
+#include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/list.h>
 
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index e69e2ce..8957985 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -21,7 +21,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
-
+#include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/list.h>
 
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index 5529b32..66a91ad 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -6,6 +6,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
+#include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/list.h>
 
-- 
1.7.1

