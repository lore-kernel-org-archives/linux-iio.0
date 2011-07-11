Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:39097 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757988Ab1GKQA5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jul 2011 12:00:57 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/3] staging:iio:accel header housekeeping - remove unecessary includes.
Date: Mon, 11 Jul 2011 17:00:52 +0100
Message-Id: <1310400053-30041-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1310400053-30041-1-git-send-email-jic23@cam.ac.uk>
References: <1310400053-30041-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16201_ring.c    |    4 ----
 drivers/staging/iio/accel/adis16201_trigger.c |    5 -----
 drivers/staging/iio/accel/adis16203_ring.c    |    7 -------
 drivers/staging/iio/accel/adis16203_trigger.c |    6 ------
 drivers/staging/iio/accel/adis16204_ring.c    |    7 -------
 drivers/staging/iio/accel/adis16204_trigger.c |    6 ------
 drivers/staging/iio/accel/adis16209_ring.c    |    7 -------
 drivers/staging/iio/accel/adis16209_trigger.c |    6 ------
 drivers/staging/iio/accel/adis16240_ring.c    |    7 -------
 drivers/staging/iio/accel/adis16240_trigger.c |    6 ------
 drivers/staging/iio/accel/lis3l02dq_ring.c    |    4 ----
 drivers/staging/iio/accel/sca3000_ring.c      |    2 --
 12 files changed, 0 insertions(+), 67 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_ring.c b/drivers/staging/iio/accel/adis16201_ring.c
index aa4e465..9913354 100644
--- a/drivers/staging/iio/accel/adis16201_ring.c
+++ b/drivers/staging/iio/accel/adis16201_ring.c
@@ -1,14 +1,10 @@
 #include <linux/interrupt.h>
-#include <linux/irq.h>
 #include <linux/mutex.h>
-#include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
-#include <linux/sysfs.h>
 
 #include "../iio.h"
-#include "../sysfs.h"
 #include "../ring_sw.h"
 #include "../trigger.h"
 #include "adis16201.h"
diff --git a/drivers/staging/iio/accel/adis16201_trigger.c b/drivers/staging/iio/accel/adis16201_trigger.c
index 7c853a6..f448258 100644
--- a/drivers/staging/iio/accel/adis16201_trigger.c
+++ b/drivers/staging/iio/accel/adis16201_trigger.c
@@ -1,13 +1,8 @@
 #include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/mutex.h>
-#include <linux/device.h>
 #include <linux/kernel.h>
-#include <linux/sysfs.h>
 #include <linux/spi/spi.h>
 
 #include "../iio.h"
-#include "../sysfs.h"
 #include "../trigger.h"
 #include "adis16201.h"
 
diff --git a/drivers/staging/iio/accel/adis16203_ring.c b/drivers/staging/iio/accel/adis16203_ring.c
index 7ca9c25..049174d 100644
--- a/drivers/staging/iio/accel/adis16203_ring.c
+++ b/drivers/staging/iio/accel/adis16203_ring.c
@@ -1,17 +1,10 @@
 #include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/gpio.h>
-#include <linux/workqueue.h>
 #include <linux/mutex.h>
-#include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
-#include <linux/sysfs.h>
-#include <linux/list.h>
 
 #include "../iio.h"
-#include "../sysfs.h"
 #include "../ring_sw.h"
 #include "../trigger.h"
 #include "adis16203.h"
diff --git a/drivers/staging/iio/accel/adis16203_trigger.c b/drivers/staging/iio/accel/adis16203_trigger.c
index 9ea1c1e..50165f9 100644
--- a/drivers/staging/iio/accel/adis16203_trigger.c
+++ b/drivers/staging/iio/accel/adis16203_trigger.c
@@ -1,14 +1,8 @@
 #include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/mutex.h>
-#include <linux/device.h>
 #include <linux/kernel.h>
-#include <linux/sysfs.h>
-#include <linux/list.h>
 #include <linux/spi/spi.h>
 
 #include "../iio.h"
-#include "../sysfs.h"
 #include "../trigger.h"
 #include "adis16203.h"
 
diff --git a/drivers/staging/iio/accel/adis16204_ring.c b/drivers/staging/iio/accel/adis16204_ring.c
index 537d463..b173856 100644
--- a/drivers/staging/iio/accel/adis16204_ring.c
+++ b/drivers/staging/iio/accel/adis16204_ring.c
@@ -1,17 +1,10 @@
 #include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/gpio.h>
-#include <linux/workqueue.h>
 #include <linux/mutex.h>
-#include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
-#include <linux/sysfs.h>
-#include <linux/list.h>
 
 #include "../iio.h"
-#include "../sysfs.h"
 #include "../ring_sw.h"
 #include "../trigger.h"
 #include "adis16204.h"
diff --git a/drivers/staging/iio/accel/adis16204_trigger.c b/drivers/staging/iio/accel/adis16204_trigger.c
index bd6d293..55b661c 100644
--- a/drivers/staging/iio/accel/adis16204_trigger.c
+++ b/drivers/staging/iio/accel/adis16204_trigger.c
@@ -1,14 +1,8 @@
 #include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/mutex.h>
-#include <linux/device.h>
 #include <linux/kernel.h>
-#include <linux/sysfs.h>
-#include <linux/list.h>
 #include <linux/spi/spi.h>
 
 #include "../iio.h"
-#include "../sysfs.h"
 #include "../trigger.h"
 #include "adis16204.h"
 
diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index 77b70e3..7547ddb 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -1,17 +1,10 @@
 #include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/gpio.h>
-#include <linux/workqueue.h>
 #include <linux/mutex.h>
-#include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
-#include <linux/sysfs.h>
-#include <linux/list.h>
 
 #include "../iio.h"
-#include "../sysfs.h"
 #include "../ring_sw.h"
 #include "../trigger.h"
 #include "adis16209.h"
diff --git a/drivers/staging/iio/accel/adis16209_trigger.c b/drivers/staging/iio/accel/adis16209_trigger.c
index 4c6df9e..8df8a97 100644
--- a/drivers/staging/iio/accel/adis16209_trigger.c
+++ b/drivers/staging/iio/accel/adis16209_trigger.c
@@ -1,14 +1,8 @@
 #include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/mutex.h>
-#include <linux/device.h>
 #include <linux/kernel.h>
-#include <linux/sysfs.h>
-#include <linux/list.h>
 #include <linux/spi/spi.h>
 
 #include "../iio.h"
-#include "../sysfs.h"
 #include "../trigger.h"
 #include "adis16209.h"
 
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index 3f1e159..9bb4ff8 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -1,17 +1,10 @@
 #include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/gpio.h>
-#include <linux/workqueue.h>
 #include <linux/mutex.h>
-#include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
-#include <linux/sysfs.h>
-#include <linux/list.h>
 
 #include "../iio.h"
-#include "../sysfs.h"
 #include "../ring_sw.h"
 #include "../trigger.h"
 #include "adis16240.h"
diff --git a/drivers/staging/iio/accel/adis16240_trigger.c b/drivers/staging/iio/accel/adis16240_trigger.c
index 0c75338..13f1d14 100644
--- a/drivers/staging/iio/accel/adis16240_trigger.c
+++ b/drivers/staging/iio/accel/adis16240_trigger.c
@@ -1,14 +1,8 @@
 #include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/mutex.h>
-#include <linux/device.h>
 #include <linux/kernel.h>
-#include <linux/sysfs.h>
-#include <linux/list.h>
 #include <linux/spi/spi.h>
 
 #include "../iio.h"
-#include "../sysfs.h"
 #include "../trigger.h"
 #include "adis16240.h"
 
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 7305c78..c53985e 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -1,15 +1,11 @@
 #include <linux/interrupt.h>
-#include <linux/irq.h>
 #include <linux/gpio.h>
 #include <linux/mutex.h>
-#include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
-#include <linux/sysfs.h>
 #include <linux/slab.h>
 
 #include "../iio.h"
-#include "../sysfs.h"
 #include "../ring_sw.h"
 #include "../kfifo_buf.h"
 #include "../trigger.h"
diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
index db9cf98..e7eb279 100644
--- a/drivers/staging/iio/accel/sca3000_ring.c
+++ b/drivers/staging/iio/accel/sca3000_ring.c
@@ -10,9 +10,7 @@
  */
 
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
 #include <linux/fs.h>
-#include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
-- 
1.7.3.4

