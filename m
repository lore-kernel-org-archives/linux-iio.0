Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] staging:iio:adc:max1363 ring_sw->kfifo conversion
Date: Wed, 30 May 2012 20:44:30 +0100
Message-Id: <1338407070-27320-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

We are moving towards scrapping ring_sw so this move
is necessary.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/adc/max1363_ring.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index 73273c0..94377ed 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -16,7 +16,7 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
-#include "../ring_sw.h"
+#include <linux/iio/kfifo_buf.h>
 #include <linux/iio/trigger_consumer.h>
 
 #include "max1363.h"
@@ -100,7 +100,7 @@ int max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	struct max1363_state *st = iio_priv(indio_dev);
 	int ret = 0;
 
-	indio_dev->buffer = iio_sw_rb_allocate(indio_dev);
+	indio_dev->buffer = iio_kfifo_allocate(indio_dev);
 	if (!indio_dev->buffer) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -125,7 +125,7 @@ int max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	return 0;
 
 error_deallocate_sw_rb:
-	iio_sw_rb_free(indio_dev->buffer);
+	iio_kfifo_free(indio_dev->buffer);
 error_ret:
 	return ret;
 }
@@ -134,5 +134,5 @@ void max1363_ring_cleanup(struct iio_dev *indio_dev)
 {
 	/* ensure that the trigger has been detached */
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->buffer);
+	iio_kfifo_free(indio_dev->buffer);
 }
-- 
1.7.10.2
