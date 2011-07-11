Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Device-drivers-devel@blackfin.uclinux.org,
	manuel.stahl@iis.fraunhofer.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 4/4] staging:iio:imu:adis16400 remove now unused headers.
Date: Mon, 11 Jul 2011 16:58:07 +0100
Message-Id: <1310399887-4049-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1310399887-4049-1-git-send-email-jic23@cam.ac.uk>
References: <1310399887-4049-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

These should really have gone away with the code that needed them.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/imu/adis16400_ring.c    |    7 -------
 drivers/staging/iio/imu/adis16400_trigger.c |    6 ------
 2 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index d07c86b..ef38477 100644
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
 #include "../trigger.h"
 #include "adis16400.h"
diff --git a/drivers/staging/iio/imu/adis16400_trigger.c b/drivers/staging/iio/imu/adis16400_trigger.c
index 4e1f295..3860d92 100644
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
