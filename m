Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 03/19] staging:iio:imu:adis16400 remove now unused headers.
Date: Fri, 12 Aug 2011 17:08:37 +0100
Message-Id: <1313165333-3951-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1313165333-3951-1-git-send-email-jic23@cam.ac.uk>
References: <1313165333-3951-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

These should really have gone away with the code that needed them.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/imu/adis16400_ring.c    |    7 -------
 drivers/staging/iio/imu/adis16400_trigger.c |    6 ------
 2 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index 3612373..556d928 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -1,18 +1,11 @@
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
 #include <linux/bitops.h>
 
 #include "../iio.h"
-#include "../sysfs.h"
 #include "../ring_sw.h"
 #include "../accel/accel.h"
 #include "../trigger.h"
diff --git a/drivers/staging/iio/imu/adis16400_trigger.c b/drivers/staging/iio/imu/adis16400_trigger.c
index c6ec41a..ce98173 100644
--- a/drivers/staging/iio/imu/adis16400_trigger.c
+++ b/drivers/staging/iio/imu/adis16400_trigger.c
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
 #include "adis16400.h"
 
-- 
1.7.3.4
