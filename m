Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org,
	greg@kroah.com
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 10/14] staging:iio:accel:lis3l02dq ring->buffer renames.
Date: Wed, 21 Sep 2011 11:15:58 +0100
Message-Id: <1316600162-15581-11-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316600162-15581-1-git-send-email-jic23@cam.ac.uk>
References: <1316600162-15581-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This driver already supports kfifo usage, so the term ring is
misleading and hence replaced.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/lis3l02dq.h      |   20 ++++----
 drivers/staging/iio/accel/lis3l02dq_core.c |   25 +++++----
 drivers/staging/iio/accel/lis3l02dq_ring.c |   76 ++++++++++++++--------------
 3 files changed, 61 insertions(+), 60 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq.h b/drivers/staging/iio/accel/lis3l02dq.h
index 6633091..7237a9a 100644
--- a/drivers/staging/iio/accel/lis3l02dq.h
+++ b/drivers/staging/iio/accel/lis3l02dq.h
@@ -175,19 +175,19 @@ int lis3l02dq_spi_write_reg_8(struct iio_dev *indio_dev,
 int lis3l02dq_disable_all_events(struct iio_dev *indio_dev);
 
 #ifdef CONFIG_IIO_BUFFER
-/* At the moment triggers are only used for ring buffer
+/* At the moment triggers are only used for buffer
  * filling. This may change!
  */
 void lis3l02dq_remove_trigger(struct iio_dev *indio_dev);
 int lis3l02dq_probe_trigger(struct iio_dev *indio_dev);
 
-ssize_t lis3l02dq_read_accel_from_ring(struct iio_buffer *ring,
+ssize_t lis3l02dq_read_accel_from_buffer(struct iio_buffer *buffer,
 				       int index,
 				       int *val);
 
 
-int lis3l02dq_configure_ring(struct iio_dev *indio_dev);
-void lis3l02dq_unconfigure_ring(struct iio_dev *indio_dev);
+int lis3l02dq_configure_buffer(struct iio_dev *indio_dev);
+void lis3l02dq_unconfigure_buffer(struct iio_dev *indio_dev);
 
 #ifdef CONFIG_LIS3L02DQ_BUF_RING_SW
 #define lis3l02dq_free_buf iio_sw_rb_free
@@ -203,7 +203,7 @@ irqreturn_t lis3l02dq_data_rdy_trig_poll(int irq, void *private);
 #define lis3l02dq_th lis3l02dq_data_rdy_trig_poll
 
 #else /* CONFIG_IIO_BUFFER */
-#define lis3l02dq_th lis3l02dq_noring
+#define lis3l02dq_th lis3l02dq_nobuffer
 
 static inline void lis3l02dq_remove_trigger(struct iio_dev *indio_dev)
 {
@@ -213,18 +213,18 @@ static inline int lis3l02dq_probe_trigger(struct iio_dev *indio_dev)
 	return 0;
 }
 static inline ssize_t
-lis3l02dq_read_accel_from_ring(struct iio_buffer *ring,
-			       int index,
-			       int *val)
+lis3l02dq_read_accel_from_buffer(struct iio_buffer *buffer,
+				 int index,
+				 int *val)
 {
 	return 0;
 }
 
-static int lis3l02dq_configure_ring(struct iio_dev *indio_dev)
+static int lis3l02dq_configure_buffer(struct iio_dev *indio_dev)
 {
 	return 0;
 }
-static inline void lis3l02dq_unconfigure_ring(struct iio_dev *indio_dev)
+static inline void lis3l02dq_unconfigure_buffer(struct iio_dev *indio_dev)
 {
 }
 #endif /* CONFIG_IIO_BUFFER */
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index c59ca1c..737dd97 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -35,7 +35,7 @@
  */
 /* direct copy of the irq_default_primary_handler */
 #ifndef CONFIG_IIO_BUFFER
-static irqreturn_t lis3l02dq_noring(int irq, void *private)
+static irqreturn_t lis3l02dq_nobuffer(int irq, void *private)
 {
 	return IRQ_WAKE_THREAD;
 }
@@ -260,9 +260,10 @@ static int lis3l02dq_read_raw(struct iio_dev *indio_dev,
 		/* Take the iio_dev status lock */
 		mutex_lock(&indio_dev->mlock);
 		if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
-			ret = lis3l02dq_read_accel_from_ring(indio_dev->buffer,
-							     chan->scan_index,
-							     val);
+			ret = lis3l02dq_read_accel_from_buffer(indio_dev->
+							       buffer,
+							       chan->scan_index,
+							       val);
 		else {
 			reg = lis3l02dq_axis_map
 				[LIS3L02DQ_ACCEL][chan->address];
@@ -686,7 +687,7 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = lis3l02dq_configure_ring(indio_dev);
+	ret = lis3l02dq_configure_buffer(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
@@ -694,8 +695,8 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 				  lis3l02dq_channels,
 				  ARRAY_SIZE(lis3l02dq_channels));
 	if (ret) {
-		printk(KERN_ERR "failed to initialize the ring\n");
-		goto error_unreg_ring_funcs;
+		printk(KERN_ERR "failed to initialize the buffer\n");
+		goto error_unreg_buffer_funcs;
 	}
 
 	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0) {
@@ -706,7 +707,7 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 					   "lis3l02dq",
 					   indio_dev);
 		if (ret)
-			goto error_uninitialize_ring;
+			goto error_uninitialize_buffer;
 
 		ret = lis3l02dq_probe_trigger(indio_dev);
 		if (ret)
@@ -730,10 +731,10 @@ error_remove_trigger:
 error_free_interrupt:
 	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
 		free_irq(st->us->irq, indio_dev);
-error_uninitialize_ring:
+error_uninitialize_buffer:
 	iio_buffer_unregister(indio_dev);
-error_unreg_ring_funcs:
-	lis3l02dq_unconfigure_ring(indio_dev);
+error_unreg_buffer_funcs:
+	lis3l02dq_unconfigure_buffer(indio_dev);
 error_free_dev:
 		iio_free_device(indio_dev);
 error_ret:
@@ -786,7 +787,7 @@ static int lis3l02dq_remove(struct spi_device *spi)
 
 	lis3l02dq_remove_trigger(indio_dev);
 	iio_buffer_unregister(indio_dev);
-	lis3l02dq_unconfigure_ring(indio_dev);
+	lis3l02dq_unconfigure_buffer(indio_dev);
 
 	iio_device_unregister(indio_dev);
 
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 1ccfba9..5c542dd 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -38,30 +38,30 @@ irqreturn_t lis3l02dq_data_rdy_trig_poll(int irq, void *private)
 }
 
 /**
- * lis3l02dq_read_accel_from_ring() individual acceleration read from ring
+ * lis3l02dq_read_accel_from_buffer() individual acceleration read from buffer
  **/
-ssize_t lis3l02dq_read_accel_from_ring(struct iio_buffer *ring,
-				       int index,
-				       int *val)
+ssize_t lis3l02dq_read_accel_from_buffer(struct iio_buffer *buffer,
+					 int index,
+					 int *val)
 {
 	int ret;
 	s16 *data;
 
-	if (!iio_scan_mask_query(ring, index))
+	if (!iio_scan_mask_query(buffer, index))
 		return -EINVAL;
 
-	if (!ring->access->read_last)
+	if (!buffer->access->read_last)
 		return -EBUSY;
 
-	data = kmalloc(ring->access->get_bytes_per_datum(ring),
+	data = kmalloc(buffer->access->get_bytes_per_datum(buffer),
 		       GFP_KERNEL);
 	if (data == NULL)
 		return -ENOMEM;
 
-	ret = ring->access->read_last(ring, (u8 *)data);
+	ret = buffer->access->read_last(buffer, (u8 *)data);
 	if (ret)
 		goto error_free_data;
-	*val = data[bitmap_weight(ring->scan_mask, index)];
+	*val = data[bitmap_weight(buffer->scan_mask, index)];
 error_free_data:
 
 	kfree(data);
@@ -86,13 +86,13 @@ static const u8 read_all_tx_array[] = {
  **/
 static int lis3l02dq_read_all(struct iio_dev *indio_dev, u8 *rx_array)
 {
-	struct iio_buffer *ring = indio_dev->buffer;
+	struct iio_buffer *buffer = indio_dev->buffer;
 	struct lis3l02dq_state *st = iio_priv(indio_dev);
 	struct spi_transfer *xfers;
 	struct spi_message msg;
 	int ret, i, j = 0;
 
-	xfers = kzalloc((ring->scan_count) * 2
+	xfers = kzalloc((buffer->scan_count) * 2
 			* sizeof(*xfers), GFP_KERNEL);
 	if (!xfers)
 		return -ENOMEM;
@@ -100,7 +100,7 @@ static int lis3l02dq_read_all(struct iio_dev *indio_dev, u8 *rx_array)
 	mutex_lock(&st->buf_lock);
 
 	for (i = 0; i < ARRAY_SIZE(read_all_tx_array)/4; i++)
-		if (test_bit(i, ring->scan_mask)) {
+		if (test_bit(i, buffer->scan_mask)) {
 			/* lower byte */
 			xfers[j].tx_buf = st->tx + 2*j;
 			st->tx[2*j] = read_all_tx_array[i*4];
@@ -128,7 +128,7 @@ static int lis3l02dq_read_all(struct iio_dev *indio_dev, u8 *rx_array)
 	 * values in alternate bytes
 	 */
 	spi_message_init(&msg);
-	for (j = 0; j < ring->scan_count * 2; j++)
+	for (j = 0; j < buffer->scan_count * 2; j++)
 		spi_message_add_tail(&xfers[j], &msg);
 
 	ret = spi_sync(st->us, &msg);
@@ -138,7 +138,7 @@ static int lis3l02dq_read_all(struct iio_dev *indio_dev, u8 *rx_array)
 	return ret;
 }
 
-static int lis3l02dq_get_ring_element(struct iio_dev *indio_dev,
+static int lis3l02dq_get_buffer_element(struct iio_dev *indio_dev,
 				u8 *buf)
 {
 	int ret, i;
@@ -163,26 +163,26 @@ static irqreturn_t lis3l02dq_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	struct iio_buffer *ring = indio_dev->buffer;
+	struct iio_buffer *buffer = indio_dev->buffer;
 	int len = 0;
-	size_t datasize = ring->access->get_bytes_per_datum(ring);
+	size_t datasize = buffer->access->get_bytes_per_datum(buffer);
 	char *data = kmalloc(datasize, GFP_KERNEL);
 
 	if (data == NULL) {
 		dev_err(indio_dev->dev.parent,
-			"memory alloc failed in ring bh");
+			"memory alloc failed in buffer bh");
 		return -ENOMEM;
 	}
 
-	if (ring->scan_count)
-		len = lis3l02dq_get_ring_element(indio_dev, data);
+	if (buffer->scan_count)
+		len = lis3l02dq_get_buffer_element(indio_dev, data);
 
 	  /* Guaranteed to be aligned with 8 byte boundary */
-	if (ring->scan_timestamp)
+	if (buffer->scan_timestamp)
 		*(s64 *)(((phys_addr_t)data + len
 				+ sizeof(s64) - 1) & ~(sizeof(s64) - 1))
 			= pf->timestamp;
-	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
+	buffer->access->store_to(buffer, (u8 *)data, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 	kfree(data);
@@ -255,7 +255,7 @@ error_ret:
  *
  * If disabling the interrupt also does a final read to ensure it is clear.
  * This is only important in some cases where the scan enable elements are
- * switched before the ring is reenabled.
+ * switched before the buffer is reenabled.
  **/
 static int lis3l02dq_data_rdy_trigger_set_state(struct iio_trigger *trig,
 						bool state)
@@ -343,13 +343,13 @@ void lis3l02dq_remove_trigger(struct iio_dev *indio_dev)
 	iio_free_trigger(st->trig);
 }
 
-void lis3l02dq_unconfigure_ring(struct iio_dev *indio_dev)
+void lis3l02dq_unconfigure_buffer(struct iio_dev *indio_dev)
 {
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
 	lis3l02dq_free_buf(indio_dev->buffer);
 }
 
-static int lis3l02dq_ring_postenable(struct iio_dev *indio_dev)
+static int lis3l02dq_buffer_postenable(struct iio_dev *indio_dev)
 {
 	/* Disable unwanted channels otherwise the interrupt will not clear */
 	u8 t;
@@ -392,7 +392,7 @@ error_ret:
 }
 
 /* Turn all channels on again */
-static int lis3l02dq_ring_predisable(struct iio_dev *indio_dev)
+static int lis3l02dq_buffer_predisable(struct iio_dev *indio_dev)
 {
 	u8 t;
 	int ret;
@@ -418,29 +418,29 @@ error_ret:
 	return ret;
 }
 
-static const struct iio_buffer_setup_ops lis3l02dq_ring_setup_ops = {
+static const struct iio_buffer_setup_ops lis3l02dq_buffer_setup_ops = {
 	.preenable = &iio_sw_buffer_preenable,
-	.postenable = &lis3l02dq_ring_postenable,
-	.predisable = &lis3l02dq_ring_predisable,
+	.postenable = &lis3l02dq_buffer_postenable,
+	.predisable = &lis3l02dq_buffer_predisable,
 };
 
-int lis3l02dq_configure_ring(struct iio_dev *indio_dev)
+int lis3l02dq_configure_buffer(struct iio_dev *indio_dev)
 {
 	int ret;
-	struct iio_buffer *ring;
+	struct iio_buffer *buffer;
 
-	ring = lis3l02dq_alloc_buf(indio_dev);
-	if (!ring)
+	buffer = lis3l02dq_alloc_buf(indio_dev);
+	if (!buffer)
 		return -ENOMEM;
 
-	indio_dev->buffer = ring;
-	/* Effectively select the ring buffer implementation */
+	indio_dev->buffer = buffer;
+	/* Effectively select the buffer implementation */
 	indio_dev->buffer->access = &lis3l02dq_access_funcs;
-	ring->bpe = 2;
+	buffer->bpe = 2;
 
-	ring->scan_timestamp = true;
-	ring->setup_ops = &lis3l02dq_ring_setup_ops;
-	ring->owner = THIS_MODULE;
+	buffer->scan_timestamp = true;
+	buffer->setup_ops = &lis3l02dq_buffer_setup_ops;
+	buffer->owner = THIS_MODULE;
 
 	/* Functions are NULL as we set handler below */
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
-- 
1.7.3.4
