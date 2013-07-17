Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-051.synserver.de ([212.40.185.51]:1047 "EHLO
	smtp-out-051.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755749Ab3GQOoL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jul 2013 10:44:11 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 12/15] staging:iio:adis16260: Remove unused includes
Date: Wed, 17 Jul 2013 16:44:36 +0200
Message-Id: <1374072279-7140-12-git-send-email-lars@metafoo.de>
In-Reply-To: <1374072279-7140-1-git-send-email-lars@metafoo.de>
References: <1374072279-7140-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Remove some unused includes from the driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/adis16260_core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 48b0e63..b8a6a04 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -7,15 +7,11 @@
  */
 
 #include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/delay.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
-#include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/list.h>
 #include <linux/module.h>
 
 #include <linux/iio/iio.h>
-- 
1.8.0

