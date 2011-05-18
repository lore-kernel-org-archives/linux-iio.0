Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 064/111] staging:iio:adc:ad799x removed unused headers.
Date: Wed, 18 May 2011 14:41:54 +0100
Message-Id: <1305726161-5606-65-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad799x_core.c |    2 --
 drivers/staging/iio/adc/ad799x_ring.c |    1 -
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 94bd808..a105910 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -23,11 +23,9 @@
  */
 
 #include <linux/interrupt.h>
-#include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/sysfs.h>
-#include <linux/list.h>
 #include <linux/i2c.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index c925318..6906568 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -10,7 +10,6 @@
  */
 
 #include <linux/interrupt.h>
-#include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
-- 
1.7.3.4
