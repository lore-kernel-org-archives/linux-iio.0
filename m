Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 101/111] staging:iio:ad7780 trivial unused header cleanup.
Date: Wed, 18 May 2011 14:42:31 +0100
Message-Id: <1305726161-5606-102-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7780.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 06d3b6a..713e202 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -7,12 +7,10 @@
  */
 
 #include <linux/interrupt.h>
-#include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/list.h>
 #include <linux/spi/spi.h>
 #include <linux/regulator/consumer.h>
 #include <linux/err.h>
-- 
1.7.3.4
