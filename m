Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 06/13] staging:iio:adc:ad7606: Use new ringbuffer setup helper function
Date: Mon, 12 Dec 2011 11:42:58 +0100
Message-ID: <1323686585-15181-6-git-send-email-lars@metafoo.de>
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
 drivers/staging/iio/adc/ad7606_core.c |    9 --------
 drivers/staging/iio/adc/ad7606_ring.c |   37 ++------------------------------
 2 files changed, 3 insertions(+), 43 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index da25846..c1c7af62 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -508,20 +508,12 @@ struct iio_dev *ad7606_probe(struct device *dev, int irq,
 	if (ret)
 		goto error_free_irq;
 
-	ret = iio_buffer_register(indio_dev,
-				  indio_dev->channels,
-				  indio_dev->num_channels);
-	if (ret)
-		goto error_cleanup_ring;
 	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_unregister_ring;
 
 	return indio_dev;
 error_unregister_ring:
-	iio_buffer_unregister(indio_dev);
-
-error_cleanup_ring:
 	ad7606_ring_cleanup(indio_dev);
 
 error_free_irq:
@@ -546,7 +538,6 @@ int ad7606_remove(struct iio_dev *indio_dev, int irq)
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	iio_buffer_unregister(indio_dev);
 	ad7606_ring_cleanup(indio_dev);
 
 	free_irq(irq, indio_dev);
diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index 1ef9fbc..aade15f 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -102,45 +102,14 @@ static const struct iio_buffer_setup_ops ad7606_ring_setup_ops = {
 int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	int ret;
-
-	indio_dev->buffer = iio_sw_rb_allocate(indio_dev);
-	if (!indio_dev->buffer) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-
-	indio_dev->pollfunc = iio_alloc_pollfunc(&ad7606_trigger_handler_th_bh,
-						 &ad7606_trigger_handler_th_bh,
-						 0,
-						 indio_dev,
-						 "%s_consumer%d",
-						 indio_dev->name,
-						 indio_dev->id);
-	if (indio_dev->pollfunc == NULL) {
-		ret = -ENOMEM;
-		goto error_deallocate_sw_rb;
-	}
-
-	/* Ring buffer functions - here trigger setup related */
-
-	indio_dev->setup_ops = &ad7606_ring_setup_ops;
-	indio_dev->buffer->scan_timestamp = true ;
 
 	INIT_WORK(&st->poll_work, &ad7606_poll_bh_to_ring);
 
-	/* Flag that polled ring buffering is possible */
-	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
-	return 0;
-
-error_deallocate_sw_rb:
-	iio_sw_rb_free(indio_dev->buffer);
-error_ret:
-	return ret;
+	return iio_sw_rb_simple_setup(indio_dev, ad7606_trigger_handler_th_bh,
+					ad7606_trigger_handler_th_bh, NULL);
 }
 
 void ad7606_ring_cleanup(struct iio_dev *indio_dev)
 {
-	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->buffer);
+	iio_sw_rb_simple_cleanup(indio_dev);
 }
-- 
1.7.7.3
