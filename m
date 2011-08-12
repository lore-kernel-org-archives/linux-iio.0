Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 14/19] staging:iio:gyro and meter: header housecleaning.
Date: Fri, 12 Aug 2011 17:08:48 +0100
Message-Id: <1313165333-3951-15-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1313165333-3951-1-git-send-email-jic23@cam.ac.uk>
References: <1313165333-3951-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/adis16260_ring.c    |    7 -------
 drivers/staging/iio/gyro/adis16260_trigger.c |    6 ------
 drivers/staging/iio/meter/ade7758_ring.c     |    8 --------
 drivers/staging/iio/meter/ade7758_trigger.c  |    6 ------
 4 files changed, 0 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index e9cff3b..92d1fac 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
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
 #include "adis16260.h"
diff --git a/drivers/staging/iio/gyro/adis16260_trigger.c b/drivers/staging/iio/gyro/adis16260_trigger.c
index f240961..2f2b216 100644
--- a/drivers/staging/iio/gyro/adis16260_trigger.c
+++ b/drivers/staging/iio/gyro/adis16260_trigger.c
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
 #include "adis16260.h"
 
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index e7a04b4..c9271d0 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -6,20 +6,12 @@
  * Licensed under the GPL-2.
  */
 #include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/gpio.h>
-#include <linux/workqueue.h>
-#include <linux/mutex.h>
-#include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
-#include <linux/sysfs.h>
-#include <linux/list.h>
 #include <asm/unaligned.h>
 
 #include "../iio.h"
-#include "../sysfs.h"
 #include "../ring_sw.h"
 #include "../trigger.h"
 #include "ade7758.h"
diff --git a/drivers/staging/iio/meter/ade7758_trigger.c b/drivers/staging/iio/meter/ade7758_trigger.c
index 4c451c2..392dfe3 100644
--- a/drivers/staging/iio/meter/ade7758_trigger.c
+++ b/drivers/staging/iio/meter/ade7758_trigger.c
@@ -7,16 +7,10 @@
  */
 
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
 #include "ade7758.h"
 
-- 
1.7.3.4
