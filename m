Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/10] staging:iio:accel:adis16201: Use new ringbuffer setup helper function
Date: Thu, 1 Dec 2011 15:19:26 +0100
Message-ID: <1322749170-21407-7-git-send-email-lars@metafoo.de>
In-Reply-To: <1322749170-21407-1-git-send-email-lars@metafoo.de>
References: <1322749170-21407-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Use the new ringbuffer setup helper function to allocate and register buffer and
pollfunc.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/accel/adis16201_core.c |   11 --------
 drivers/staging/iio/accel/adis16201_ring.c |   38 ++++-----------------------
 2 files changed, 6 insertions(+), 43 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index ed97da2..29e3c91 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -491,14 +491,6 @@ static int __devinit adis16201_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_dev;
 
-	ret = iio_buffer_register(indio_dev,
-				  adis16201_channels,
-				  ARRAY_SIZE(adis16201_channels));
-	if (ret) {
-		printk(KERN_ERR "failed to initialize the ring\n");
-		goto error_unreg_ring_funcs;
-	}
-
 	if (spi->irq) {
 		ret = adis16201_probe_trigger(indio_dev);
 		if (ret)
@@ -518,8 +510,6 @@ static int __devinit adis16201_probe(struct spi_device *spi)
 error_remove_trigger:
 	adis16201_remove_trigger(indio_dev);
 error_uninitialize_ring:
-	iio_buffer_unregister(indio_dev);
-error_unreg_ring_funcs:
 	adis16201_unconfigure_ring(indio_dev);
 error_free_dev:
 	iio_free_device(indio_dev);
@@ -533,7 +523,6 @@ static int adis16201_remove(struct spi_device *spi)
 
 	iio_device_unregister(indio_dev);
 	adis16201_remove_trigger(indio_dev);
-	iio_buffer_unregister(indio_dev);
 	adis16201_unconfigure_ring(indio_dev);
 	iio_free_device(indio_dev);
 
diff --git a/drivers/staging/iio/accel/adis16201_ring.c b/drivers/staging/iio/accel/adis16201_ring.c
index 97f9e6b..882a1e3 100644
--- a/drivers/staging/iio/accel/adis16201_ring.c
+++ b/drivers/staging/iio/accel/adis16201_ring.c
@@ -94,44 +94,18 @@ static irqreturn_t adis16201_trigger_handler(int irq, void *p)
 
 void adis16201_unconfigure_ring(struct iio_dev *indio_dev)
 {
-	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->buffer);
+	iio_sw_rb_simple_cleanup(indio_dev);
 }
 
-static const struct iio_buffer_setup_ops adis16201_ring_setup_ops = {
-	.preenable = &iio_sw_buffer_preenable,
-	.postenable = &iio_triggered_buffer_postenable,
-	.predisable = &iio_triggered_buffer_predisable,
-};
-
 int adis16201_configure_ring(struct iio_dev *indio_dev)
 {
-	int ret = 0;
-	struct iio_buffer *ring;
+	int ret;
 
-	ring = iio_sw_rb_allocate(indio_dev);
-	if (!ring) {
-		ret = -ENOMEM;
+	ret = iio_sw_rb_simple_setup(indio_dev, &iio_pollfunc_store_time,
+		&adis16201_trigger_handler);
+	if (ret)
 		return ret;
-	}
-	indio_dev->buffer = ring;
-	ring->scan_timestamp = true;
-	indio_dev->setup_ops = &adis16201_ring_setup_ops;
-
-	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
-						 &adis16201_trigger_handler,
-						 IRQF_ONESHOT,
-						 indio_dev,
-						 "adis16201_consumer%d",
-						 indio_dev->id);
-	if (indio_dev->pollfunc == NULL) {
-		ret = -ENOMEM;
-		goto error_iio_sw_rb_free;
-	}
 
-	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
+	indio_dev->buffer->scan_timestamp = true;
 	return 0;
-error_iio_sw_rb_free:
-	iio_sw_rb_free(indio_dev->buffer);
-	return ret;
 }
-- 
1.7.7.3
