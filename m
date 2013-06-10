Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/4] staging:iio:adis16130: Remove unused includes
Date: Mon, 10 Jun 2013 16:00:12 +0200
Message-Id: <1370872815-14386-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/adis16130_core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16130_core.c b/drivers/staging/iio/gyro/adis16130_core.c
index 531b803..5288635 100644
--- a/drivers/staging/iio/gyro/adis16130_core.c
+++ b/drivers/staging/iio/gyro/adis16130_core.c
@@ -6,18 +6,12 @@
  * Licensed under the GPL-2 or later.
  */
 
-#include <linux/delay.h>
 #include <linux/mutex.h>
-#include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
-#include <linux/list.h>
 #include <linux/module.h>
 
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 
 #define ADIS16130_CON         0x0
 #define ADIS16130_CON_RD      (1 << 6)
-- 
1.8.0
