Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/10] staging:iio:adc:ad7476: Use new ringbuffer setup helper function
Date: Thu, 1 Dec 2011 15:19:28 +0100
Message-ID: <1322749170-21407-9-git-send-email-lars@metafoo.de>
In-Reply-To: <1322749170-21407-1-git-send-email-lars@metafoo.de>
References: <1322749170-21407-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Use the new ringbuffer setup helper function to allocate and register buffer and
pollfunc.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7476.h      |    1 -
 drivers/staging/iio/adc/ad7476_core.c |    9 ----
 drivers/staging/iio/adc/ad7476_ring.c |   77 +++-----------------------------
 3 files changed, 8 insertions(+), 79 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7476.h b/drivers/staging/iio/adc/ad7476.h
index 27f696c..b1dd931 100644
--- a/drivers/staging/iio/adc/ad7476.h
+++ b/drivers/staging/iio/adc/ad7476.h
@@ -27,7 +27,6 @@ struct ad7476_state {
 	struct spi_device		*spi;
 	const struct ad7476_chip_info	*chip_info;
 	struct regulator		*reg;
-	size_t				d_size;
 	u16				int_vref_mv;
 	struct spi_transfer		xfer;
 	struct spi_message		msg;
diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index 447fdbe..b27785b 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -179,20 +179,12 @@ static int __devinit ad7476_probe(struct spi_device *spi)
 	if (ret)
 		goto error_disable_reg;
 
-	ret = iio_buffer_register(indio_dev,
-				  st->chip_info->channel,
-				  ARRAY_SIZE(st->chip_info->channel));
-	if (ret)
-		goto error_cleanup_ring;
-
 	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_ring_unregister;
 	return 0;
 
 error_ring_unregister:
-	iio_buffer_unregister(indio_dev);
-error_cleanup_ring:
 	ad7476_ring_cleanup(indio_dev);
 error_disable_reg:
 	if (!IS_ERR(st->reg))
@@ -212,7 +204,6 @@ static int ad7476_remove(struct spi_device *spi)
 	struct ad7476_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	iio_buffer_unregister(indio_dev);
 	ad7476_ring_cleanup(indio_dev);
 	if (!IS_ERR(st->reg)) {
 		regulator_disable(st->reg);
diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
index 35a8576..bd3e3ba 100644
--- a/drivers/staging/iio/adc/ad7476_ring.c
+++ b/drivers/staging/iio/adc/ad7476_ring.c
@@ -20,46 +20,17 @@
 
 #include "ad7476.h"
 
-/**
- * ad7476_ring_preenable() setup the parameters of the ring before enabling
- *
- * The complex nature of the setting of the nuber of bytes per datum is due
- * to this driver currently ensuring that the timestamp is stored at an 8
- * byte boundary.
- **/
-static int ad7476_ring_preenable(struct iio_dev *indio_dev)
-{
-	struct ad7476_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
-
-	st->d_size = bitmap_weight(indio_dev->active_scan_mask,
-				   indio_dev->masklength) *
-		st->chip_info->channel[0].scan_type.storagebits / 8;
-
-	if (ring->scan_timestamp) {
-		st->d_size += sizeof(s64);
-
-		if (st->d_size % sizeof(s64))
-			st->d_size += sizeof(s64) - (st->d_size % sizeof(s64));
-	}
-
-	if (indio_dev->buffer->access->set_bytes_per_datum)
-		indio_dev->buffer->access->
-			set_bytes_per_datum(indio_dev->buffer, st->d_size);
-
-	return 0;
-}
-
 static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad7476_state *st = iio_priv(indio_dev);
+	unsigned int bpd = buffer_get_bytes_per_datum(indio_dev->buffer);
 	s64 time_ns;
 	__u8 *rxbuf;
 	int b_sent;
 
-	rxbuf = kzalloc(st->d_size, GFP_KERNEL);
+	rxbuf = kzalloc(bpd, GFP_KERNEL);
 	if (rxbuf == NULL)
 		return -ENOMEM;
 
@@ -71,7 +42,7 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
 	time_ns = iio_get_time_ns();
 
 	if (indio_dev->buffer->scan_timestamp)
-		memcpy(rxbuf + st->d_size - sizeof(s64),
+		memcpy(rxbuf + bpd - sizeof(s64),
 			&time_ns, sizeof(time_ns));
 
 	indio_dev->buffer->access->store_to(indio_dev->buffer, rxbuf, time_ns);
@@ -82,51 +53,19 @@ done:
 	return IRQ_HANDLED;
 }
 
-static const struct iio_buffer_setup_ops ad7476_ring_setup_ops = {
-	.preenable = &ad7476_ring_preenable,
-	.postenable = &iio_triggered_buffer_postenable,
-	.predisable = &iio_triggered_buffer_predisable,
-};
-
 int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 {
-	struct ad7476_state *st = iio_priv(indio_dev);
-	int ret = 0;
+	int ret;
 
-	indio_dev->buffer = iio_sw_rb_allocate(indio_dev);
-	if (!indio_dev->buffer) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-	indio_dev->pollfunc
-		= iio_alloc_pollfunc(NULL,
-				     &ad7476_trigger_handler,
-				     IRQF_ONESHOT,
-				     indio_dev,
-				     "%s_consumer%d",
-				     spi_get_device_id(st->spi)->name,
-				     indio_dev->id);
-	if (indio_dev->pollfunc == NULL) {
-		ret = -ENOMEM;
-		goto error_deallocate_sw_rb;
-	}
+	ret = iio_sw_rb_simple_setup(indio_dev, NULL, &ad7476_trigger_handler);
+	if (ret)
+		return ret;
 
-	/* Ring buffer functions - here trigger setup related */
-	indio_dev->setup_ops = &ad7476_ring_setup_ops;
 	indio_dev->buffer->scan_timestamp = true;
-
-	/* Flag that polled ring buffering is possible */
-	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 	return 0;
-
-error_deallocate_sw_rb:
-	iio_sw_rb_free(indio_dev->buffer);
-error_ret:
-	return ret;
 }
 
 void ad7476_ring_cleanup(struct iio_dev *indio_dev)
 {
-	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->buffer);
+	iio_sw_rb_simple_cleanup(indio_dev);
 }
-- 
1.7.7.3
