Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-069.synserver.de ([212.40.185.69]:1076 "EHLO
	smtp-out-069.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753587Ab3APMsL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Jan 2013 07:48:11 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/15] staging:iio:adis16400: Use triggered buffer setup helper function
Date: Wed, 16 Jan 2013 13:48:41 +0100
Message-Id: <1358340531-31350-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1358340531-31350-1-git-send-email-lars@metafoo.de>
References: <1358340531-31350-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use the triggered buffer helper functions to setup and tear down the buffer for
the adis16400 instead of doing this manually. This also means that we switch
away from the deprecated sw_ring buffer and use the kfifo buffer now instead.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/imu/adis16400_core.c | 13 +--------
 drivers/staging/iio/imu/adis16400_ring.c | 47 +++++---------------------------
 2 files changed, 8 insertions(+), 52 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index a948472..c545cd9 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -981,18 +981,10 @@ static int adis16400_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_dev;
 
-	ret = iio_buffer_register(indio_dev,
-				  st->variant->channels,
-				  st->variant->num_channels);
-	if (ret) {
-		dev_err(&spi->dev, "failed to initialize the ring\n");
-		goto error_unreg_ring_funcs;
-	}
-
 	if (spi->irq) {
 		ret = adis_probe_trigger(&st->adis, indio_dev);
 		if (ret)
-			goto error_uninitialize_ring;
+			goto error_unreg_ring_funcs;
 	}
 
 	/* Get the device into a sane initial state */
@@ -1008,8 +1000,6 @@ static int adis16400_probe(struct spi_device *spi)
 error_remove_trigger:
 	if (spi->irq)
 		adis_remove_trigger(&st->adis);
-error_uninitialize_ring:
-	iio_buffer_unregister(indio_dev);
 error_unreg_ring_funcs:
 	adis16400_unconfigure_ring(indio_dev);
 error_free_dev:
@@ -1029,7 +1019,6 @@ static int adis16400_remove(struct spi_device *spi)
 
 	if (spi->irq)
 		adis_remove_trigger(&st->adis);
-	iio_buffer_unregister(indio_dev);
 	adis16400_unconfigure_ring(indio_dev);
 
 	iio_device_free(indio_dev);
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index 6c5b0be..e421278 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -7,7 +7,8 @@
 #include <linux/export.h>
 
 #include <linux/iio/iio.h>
-#include "../ring_sw.h"
+#include <linux/iio/buffer.h>
+#include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 
 #include "adis16400.h"
@@ -159,47 +160,13 @@ done:
 	return IRQ_HANDLED;
 }
 
-void adis16400_unconfigure_ring(struct iio_dev *indio_dev)
+int adis16400_configure_ring(struct iio_dev *indio_dev)
 {
-	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->buffer);
+	return iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
+		&adis16400_trigger_handler, NULL);
 }
 
-static const struct iio_buffer_setup_ops adis16400_ring_setup_ops = {
-	.preenable = &iio_sw_buffer_preenable,
-	.postenable = &iio_triggered_buffer_postenable,
-	.predisable = &iio_triggered_buffer_predisable,
-};
-
-int adis16400_configure_ring(struct iio_dev *indio_dev)
+void adis16400_unconfigure_ring(struct iio_dev *indio_dev)
 {
-	int ret = 0;
-	struct iio_buffer *ring;
-
-	ring = iio_sw_rb_allocate(indio_dev);
-	if (!ring) {
-		ret = -ENOMEM;
-		return ret;
-	}
-	indio_dev->buffer = ring;
-	ring->scan_timestamp = true;
-	indio_dev->setup_ops = &adis16400_ring_setup_ops;
-
-	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
-						 &adis16400_trigger_handler,
-						 IRQF_ONESHOT,
-						 indio_dev,
-						 "%s_consumer%d",
-						 indio_dev->name,
-						 indio_dev->id);
-	if (indio_dev->pollfunc == NULL) {
-		ret = -ENOMEM;
-		goto error_iio_sw_rb_free;
-	}
-
-	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
-	return 0;
-error_iio_sw_rb_free:
-	iio_sw_rb_free(indio_dev->buffer);
-	return ret;
+	iio_triggered_buffer_cleanup(indio_dev);
 }
-- 
1.8.0

