Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 09/10] staging:iio:adc:ad799x: Use new ringbuffer setup helper function
Date: Thu, 1 Dec 2011 15:19:29 +0100
Message-ID: <1322749170-21407-10-git-send-email-lars@metafoo.de>
In-Reply-To: <1322749170-21407-1-git-send-email-lars@metafoo.de>
References: <1322749170-21407-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Use the new ringbuffer setup helper function to allocate and register buffer and
pollfunc.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad799x.h      |    4 +-
 drivers/staging/iio/adc/ad799x_core.c |   25 ++++++----
 drivers/staging/iio/adc/ad799x_ring.c |   82 +++-----------------------------
 3 files changed, 24 insertions(+), 87 deletions(-)

diff --git a/drivers/staging/iio/adc/ad799x.h b/drivers/staging/iio/adc/ad799x.h
index 356f690..883ad43 100644
--- a/drivers/staging/iio/adc/ad799x.h
+++ b/drivers/staging/iio/adc/ad799x.h
@@ -104,7 +104,6 @@ struct ad799x_chip_info {
 struct ad799x_state {
 	struct i2c_client		*client;
 	const struct ad799x_chip_info	*chip_info;
-	size_t				d_size;
 	struct iio_trigger		*trig;
 	struct regulator		*reg;
 	u16				int_vref_mv;
@@ -121,8 +120,6 @@ struct ad799x_platform_data {
 	u16				vref_mv;
 };
 
-int ad7997_8_set_scan_mode(struct ad799x_state *st, unsigned mask);
-
 #ifdef CONFIG_AD799X_RING_BUFFER
 int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev);
 void ad799x_ring_cleanup(struct iio_dev *indio_dev);
@@ -137,5 +134,6 @@ ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 static inline void ad799x_ring_cleanup(struct iio_dev *indio_dev)
 {
 }
+
 #endif /* CONFIG_AD799X_RING_BUFFER */
 #endif /* _AD799X_H_ */
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 815e6b9..11313d8 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -99,10 +99,21 @@ static int ad799x_i2c_write8(struct ad799x_state *st, u8 reg, u8 data)
 	return ret;
 }
 
-int ad7997_8_set_scan_mode(struct ad799x_state *st, unsigned mask)
+static int ad7997_8_update_scan_mode(struct iio_dev *indio_dev,
+	const unsigned long *scan_mask)
 {
-	return ad799x_i2c_write16(st, AD7998_CONF_REG,
-		st->config | (mask << AD799X_CHANNEL_SHIFT));
+	struct ad799x_state *st = iio_priv(indio_dev);
+
+	switch (st->id) {
+	case ad7997:
+	case ad7998:
+		return ad799x_i2c_write16(st, AD7998_CONF_REG,
+			st->config | (*scan_mask << AD799X_CHANNEL_SHIFT));
+	default:
+		break;
+	}
+
+	return 0;
 }
 
 static int ad799x_scan_direct(struct ad799x_state *st, unsigned ch)
@@ -442,6 +453,7 @@ static const struct iio_info ad7993_4_7_8_info = {
 	.read_event_value = &ad799x_read_event_value,
 	.write_event_value = &ad799x_write_event_value,
 	.driver_module = THIS_MODULE,
+	.update_scan_mode = ad7997_8_update_scan_mode,
 };
 
 #define AD799X_EV_MASK (IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) | \
@@ -849,12 +861,6 @@ static int __devinit ad799x_probe(struct i2c_client *client,
 	if (ret)
 		goto error_disable_reg;
 
-	ret = iio_buffer_register(indio_dev,
-				  indio_dev->channels,
-				  indio_dev->num_channels);
-	if (ret)
-		goto error_cleanup_ring;
-
 	if (client->irq > 0) {
 		ret = request_threaded_irq(client->irq,
 					   NULL,
@@ -896,7 +902,6 @@ static __devexit int ad799x_remove(struct i2c_client *client)
 	if (client->irq > 0)
 		free_irq(client->irq, indio_dev);
 
-	iio_buffer_unregister(indio_dev);
 	ad799x_ring_cleanup(indio_dev);
 	if (!IS_ERR(st->reg)) {
 		regulator_disable(st->reg);
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index 28e9a41..42b6618 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -24,43 +24,6 @@
 #include "ad799x.h"
 
 /**
- * ad799x_ring_preenable() setup the parameters of the ring before enabling
- *
- * The complex nature of the setting of the nuber of bytes per datum is due
- * to this driver currently ensuring that the timestamp is stored at an 8
- * byte boundary.
- **/
-static int ad799x_ring_preenable(struct iio_dev *indio_dev)
-{
-	struct iio_buffer *ring = indio_dev->buffer;
-	struct ad799x_state *st = iio_priv(indio_dev);
-
-	/*
-	 * Need to figure out the current mode based upon the requested
-	 * scan mask in iio_dev
-	 */
-
-	if (st->id == ad7997 || st->id == ad7998)
-		ad7997_8_set_scan_mode(st, *indio_dev->active_scan_mask);
-
-	st->d_size = bitmap_weight(indio_dev->active_scan_mask,
-				   indio_dev->masklength) * 2;
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
-/**
  * ad799x_trigger_handler() bh of trigger launched polling to ring buffer
  *
  * Currently there is no option in this driver to disable the saving of
@@ -73,12 +36,13 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad799x_state *st = iio_priv(indio_dev);
 	struct iio_buffer *ring = indio_dev->buffer;
+	unsigned int bpd = buffer_get_bytes_per_datum(ring);
 	s64 time_ns;
 	__u8 *rxbuf;
 	int b_sent;
 	u8 cmd;
 
-	rxbuf = kmalloc(st->d_size, GFP_KERNEL);
+	rxbuf = kmalloc(bpd, GFP_KERNEL);
 	if (rxbuf == NULL)
 		goto out;
 
@@ -112,7 +76,7 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 	time_ns = iio_get_time_ns();
 
 	if (ring->scan_timestamp)
-		memcpy(rxbuf + st->d_size - sizeof(s64),
+		memcpy(rxbuf + bpd - sizeof(s64),
 			&time_ns, sizeof(time_ns));
 
 	ring->access->store_to(indio_dev->buffer, rxbuf, time_ns);
@@ -126,49 +90,19 @@ out:
 	return IRQ_HANDLED;
 }
 
-static const struct iio_buffer_setup_ops ad799x_buf_setup_ops = {
-	.preenable = &ad799x_ring_preenable,
-	.postenable = &iio_triggered_buffer_postenable,
-	.predisable = &iio_triggered_buffer_predisable,
-};
-
 int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 {
-	int ret = 0;
+	int ret;
 
-	indio_dev->buffer = iio_sw_rb_allocate(indio_dev);
-	if (!indio_dev->buffer) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-	indio_dev->pollfunc = iio_alloc_pollfunc(NULL,
-						 &ad799x_trigger_handler,
-						 IRQF_ONESHOT,
-						 indio_dev,
-						 "%s_consumer%d",
-						 indio_dev->name,
-						 indio_dev->id);
-	if (indio_dev->pollfunc == NULL) {
-		ret = -ENOMEM;
-		goto error_deallocate_sw_rb;
-	}
+	ret = iio_sw_rb_simple_setup(indio_dev, NULL, &ad799x_trigger_handler);
+	if (ret)
+		return ret;
 
-	/* Ring buffer functions - here trigger setup related */
-	indio_dev->setup_ops = &ad799x_buf_setup_ops;
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
 
 void ad799x_ring_cleanup(struct iio_dev *indio_dev)
 {
-	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->buffer);
+	iio_sw_rb_simple_cleanup(indio_dev);
 }
-- 
1.7.7.3
