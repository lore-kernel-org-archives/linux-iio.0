Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:54682 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964Ab2JMJez (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 13 Oct 2012 05:34:55 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 1/7] staging:iio:adc:max1363 ring_sw->kfifo conversion
Date: Sat, 13 Oct 2012 10:34:45 +0100
Message-Id: <1350120891-28593-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1350120891-28593-1-git-send-email-jic23@kernel.org>
References: <1350120891-28593-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We are moving towards scrapping ring_sw so this move
is necessary.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/adc/Kconfig        | 2 +-
 drivers/staging/iio/adc/max1363_ring.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index a525143..0d35ccf 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -169,7 +169,7 @@ config MAX1363_RING_BUFFER
 	bool "Maxim max1363: use ring buffer"
 	depends on MAX1363
 	select IIO_BUFFER
-	select IIO_SW_RING
+	select IIO_KFIFO_BUF
 	help
 	  Say yes here to include ring buffer support in the MAX1363
 	  ADC driver.
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index 688304b..41af17b 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -16,7 +16,7 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
-#include "../ring_sw.h"
+#include <linux/iio/kfifo_buf.h>
 #include <linux/iio/trigger_consumer.h>
 
 #include "max1363.h"
@@ -101,7 +101,7 @@ int max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	struct max1363_state *st = iio_priv(indio_dev);
 	int ret = 0;
 
-	indio_dev->buffer = iio_sw_rb_allocate(indio_dev);
+	indio_dev->buffer = iio_kfifo_allocate(indio_dev);
 	if (!indio_dev->buffer) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -126,7 +126,7 @@ int max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	return 0;
 
 error_deallocate_sw_rb:
-	iio_sw_rb_free(indio_dev->buffer);
+	iio_kfifo_free(indio_dev->buffer);
 error_ret:
 	return ret;
 }
@@ -135,5 +135,5 @@ void max1363_ring_cleanup(struct iio_dev *indio_dev)
 {
 	/* ensure that the trigger has been detached */
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->buffer);
+	iio_kfifo_free(indio_dev->buffer);
 }
-- 
1.7.12.2

