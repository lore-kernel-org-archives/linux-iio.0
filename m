Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 03/13] staging:iio:adc:ad7192: Use new ringbuffer setup helper function
Date: Mon, 12 Dec 2011 11:42:55 +0100
Message-ID: <1323686585-15181-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1323686585-15181-1-git-send-email-lars@metafoo.de>
References: <1323686585-15181-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Use the new ringbuffer setup helper function to allocate and register buffer and
pollfunc.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7192.c |   47 ++++---------------------------------
 1 files changed, 5 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index ab0cd10..39ad143 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -554,41 +554,13 @@ static const struct iio_buffer_setup_ops ad7192_ring_setup_ops = {
 
 static int ad7192_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 {
-	int ret;
-
-	indio_dev->buffer = iio_sw_rb_allocate(indio_dev);
-	if (!indio_dev->buffer) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
-						 &ad7192_trigger_handler,
-						 IRQF_ONESHOT,
-						 indio_dev,
-						 "ad7192_consumer%d",
-						 indio_dev->id);
-	if (indio_dev->pollfunc == NULL) {
-		ret = -ENOMEM;
-		goto error_deallocate_sw_rb;
-	}
-
-	/* Ring buffer functions - here trigger setup related */
-	indio_dev->setup_ops = &ad7192_ring_setup_ops;
-
-	/* Flag that polled ring buffering is possible */
-	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
-	return 0;
-
-error_deallocate_sw_rb:
-	iio_sw_rb_free(indio_dev->buffer);
-error_ret:
-	return ret;
+	return iio_sw_rb_simple_setup(indio_dev, iio_pollfunc_store_time,
+			ad7192_trigger_handler, &ad7192_ring_setup_ops);
 }
 
 static void ad7192_ring_cleanup(struct iio_dev *indio_dev)
 {
-	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->buffer);
+	iio_sw_rb_simple_cleanup(indio_dev);
 }
 
 /**
@@ -1076,23 +1048,15 @@ static int __devinit ad7192_probe(struct spi_device *spi)
 	if (ret)
 		goto error_ring_cleanup;
 
-	ret = iio_buffer_register(indio_dev,
-				  indio_dev->channels,
-				  indio_dev->num_channels);
-	if (ret)
-		goto error_remove_trigger;
-
 	ret = ad7192_setup(st);
 	if (ret)
-		goto error_unreg_ring;
+		goto error_remove_trigger;
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
-		goto error_unreg_ring;
+		goto error_remove_trigger;
 	return 0;
 
-error_unreg_ring:
-	iio_buffer_unregister(indio_dev);
 error_remove_trigger:
 	ad7192_remove_trigger(indio_dev);
 error_ring_cleanup:
@@ -1115,7 +1079,6 @@ static int ad7192_remove(struct spi_device *spi)
 	struct ad7192_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	iio_buffer_unregister(indio_dev);
 	ad7192_remove_trigger(indio_dev);
 	ad7192_ring_cleanup(indio_dev);
 
-- 
1.7.7.3
