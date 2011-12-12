Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:45200
	"EHLO VA3EHSOBE007.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752097Ab1LLKmv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 12 Dec 2011 05:42:51 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>, <drivers@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 11/13] staging:iio:gyro:adis16260: Use new ringbuffer setup helper function
Date: Mon, 12 Dec 2011 11:43:03 +0100
Message-ID: <1323686585-15181-11-git-send-email-lars@metafoo.de>
In-Reply-To: <1323686585-15181-1-git-send-email-lars@metafoo.de>
References: <1323686585-15181-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use the new ringbuffer setup helper function to allocate and register buffer and
pollfunc.

Also as part of the conversion drop scan_timestamp being enabled by default,
since it is a left over of an earlier cleanup.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/adis16260_core.c |   10 -------
 drivers/staging/iio/gyro/adis16260_ring.c |   40 ++--------------------------
 2 files changed, 3 insertions(+), 47 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 871f76b..1e77eae 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -623,13 +623,6 @@ static int __devinit adis16260_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_dev;
 
-	ret = iio_buffer_register(indio_dev,
-				  indio_dev->channels,
-				  ARRAY_SIZE(adis16260_channels_x));
-	if (ret) {
-		printk(KERN_ERR "failed to initialize the ring\n");
-		goto error_unreg_ring_funcs;
-	}
 	if (indio_dev->buffer) {
 		/* Set default scan mode */
 		iio_scan_mask_set(indio_dev, indio_dev->buffer,
@@ -662,8 +655,6 @@ static int __devinit adis16260_probe(struct spi_device *spi)
 error_remove_trigger:
 	adis16260_remove_trigger(indio_dev);
 error_uninitialize_ring:
-	iio_buffer_unregister(indio_dev);
-error_unreg_ring_funcs:
 	adis16260_unconfigure_ring(indio_dev);
 error_free_dev:
 	iio_free_device(indio_dev);
@@ -685,7 +676,6 @@ static int adis16260_remove(struct spi_device *spi)
 	flush_scheduled_work();
 
 	adis16260_remove_trigger(indio_dev);
-	iio_buffer_unregister(indio_dev);
 	adis16260_unconfigure_ring(indio_dev);
 	iio_free_device(indio_dev);
 
diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index 711f151..68971e9 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -94,45 +94,11 @@ static irqreturn_t adis16260_trigger_handler(int irq, void *p)
 
 void adis16260_unconfigure_ring(struct iio_dev *indio_dev)
 {
-	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->buffer);
+	iio_sw_rb_simple_cleanup(indio_dev);
 }
 
-static const struct iio_buffer_setup_ops adis16260_ring_setup_ops = {
-	.preenable = &iio_sw_buffer_preenable,
-	.postenable = &iio_triggered_buffer_postenable,
-	.predisable = &iio_triggered_buffer_predisable,
-};
-
 int adis16260_configure_ring(struct iio_dev *indio_dev)
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
-	indio_dev->setup_ops = &adis16260_ring_setup_ops;
-
-	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
-						 &adis16260_trigger_handler,
-						 IRQF_ONESHOT,
-						 indio_dev,
-						 "adis16260_consumer%d",
-						 indio_dev->id);
-	if (indio_dev->pollfunc == NULL) {
-		ret = -ENOMEM;
-		goto error_iio_sw_rb_free;
-	}
-
-	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
-	return 0;
-
-error_iio_sw_rb_free:
-	iio_sw_rb_free(indio_dev->buffer);
-	return ret;
+	return iio_sw_rb_simple_setup(indio_dev, &iio_pollfunc_store_time,
+		&adis16260_trigger_handler, NULL);
 }
-- 
1.7.7.3


