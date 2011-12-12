Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 12/13] staging:iio:imu:adis16400: Use new ringbuffer setup helper function
Date: Mon, 12 Dec 2011 11:43:04 +0100
Message-ID: <1323686585-15181-12-git-send-email-lars@metafoo.de>
In-Reply-To: <1323686585-15181-1-git-send-email-lars@metafoo.de>
References: <1323686585-15181-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Use the new ringbuffer setup helper function to allocate and register buffer and
pollfunc.

Also as part of the conversion drop scan_timestamp being enabled by default,
since it is a left over of an earlier cleanup.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/imu/adis16400_core.c |   11 --------
 drivers/staging/iio/imu/adis16400_ring.c |   40 ++---------------------------
 2 files changed, 3 insertions(+), 48 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index de12f9a..f90ede6 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -1147,14 +1147,6 @@ static int __devinit adis16400_probe(struct spi_device *spi)
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
 		ret = adis16400_probe_trigger(indio_dev);
 		if (ret)
@@ -1175,8 +1167,6 @@ error_remove_trigger:
 	if (indio_dev->modes & INDIO_BUFFER_TRIGGERED)
 		adis16400_remove_trigger(indio_dev);
 error_uninitialize_ring:
-	iio_buffer_unregister(indio_dev);
-error_unreg_ring_funcs:
 	adis16400_unconfigure_ring(indio_dev);
 error_free_dev:
 	iio_free_device(indio_dev);
@@ -1196,7 +1186,6 @@ static int adis16400_remove(struct spi_device *spi)
 		goto err_ret;
 
 	adis16400_remove_trigger(indio_dev);
-	iio_buffer_unregister(indio_dev);
 	adis16400_unconfigure_ring(indio_dev);
 	iio_free_device(indio_dev);
 
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index 8daa038..2473640 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -166,45 +166,11 @@ err:
 
 void adis16400_unconfigure_ring(struct iio_dev *indio_dev)
 {
-	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->buffer);
+	iio_sw_rb_simple_cleanup(indio_dev);
 }
 
-static const struct iio_buffer_setup_ops adis16400_ring_setup_ops = {
-	.preenable = &iio_sw_buffer_preenable,
-	.postenable = &iio_triggered_buffer_postenable,
-	.predisable = &iio_triggered_buffer_predisable,
-};
-
 int adis16400_configure_ring(struct iio_dev *indio_dev)
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
+	return iio_sw_rb_simple_setup(indio_dev, &iio_pollfunc_store_time,
+		&adis16400_trigger_handler, NULL);
 }
-- 
1.7.7.3
