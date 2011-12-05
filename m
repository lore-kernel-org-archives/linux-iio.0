Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	greg@kroah.com
Cc: lars@metafoo.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 18/19] staging:iio:buffer struct iio_buffer doesn't need an indio_dev pointer.
Date: Mon,  5 Dec 2011 22:18:29 +0000
Message-Id: <1323123510-21388-19-git-send-email-jic23@kernel.org>
In-Reply-To: <1323123510-21388-1-git-send-email-jic23@kernel.org>
References: <1323123510-21388-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

In all existing cases, the calls are coming from a location where
the indio_dev is already available.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/sca3000_core.c        |    6 +++---
 drivers/staging/iio/accel/sca3000_ring.c        |   11 ++++-------
 drivers/staging/iio/buffer.h                    |   12 +++++-------
 drivers/staging/iio/gyro/adis16260_core.c       |   15 ++++++++++-----
 drivers/staging/iio/impedance-analyzer/ad5933.c |    4 ++--
 drivers/staging/iio/industrialio-buffer.c       |   15 +++++++--------
 drivers/staging/iio/kfifo_buf.c                 |    2 +-
 drivers/staging/iio/ring_sw.c                   |    2 +-
 8 files changed, 33 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 12ee6f8..40e3f6f 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -1162,9 +1162,9 @@ static int __devinit sca3000_probe(struct spi_device *spi)
 	if (ret < 0)
 		goto error_unregister_dev;
 	if (indio_dev->buffer) {
-		iio_scan_mask_set(indio_dev->buffer, 0);
-		iio_scan_mask_set(indio_dev->buffer, 1);
-		iio_scan_mask_set(indio_dev->buffer, 2);
+		iio_scan_mask_set(indio_dev, indio_dev->buffer, 0);
+		iio_scan_mask_set(indio_dev, indio_dev->buffer, 1);
+		iio_scan_mask_set(indio_dev, indio_dev->buffer, 2);
 	}
 
 	if (spi->irq) {
diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
index 6a27a95..6b824a1 100644
--- a/drivers/staging/iio/accel/sca3000_ring.c
+++ b/drivers/staging/iio/accel/sca3000_ring.c
@@ -157,8 +157,7 @@ static ssize_t sca3000_query_ring_int(struct device *dev,
 {
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret, val;
-	struct iio_buffer *ring = dev_get_drvdata(dev);
-	struct iio_dev *indio_dev = ring->indio_dev;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct sca3000_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->lock);
@@ -179,8 +178,7 @@ static ssize_t sca3000_set_ring_int(struct device *dev,
 				      const char *buf,
 				      size_t len)
 {
-	struct iio_buffer *ring = dev_get_drvdata(dev);
-	struct iio_dev *indio_dev = ring->indio_dev;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct sca3000_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	long val;
@@ -221,8 +219,7 @@ static ssize_t sca3000_show_buffer_scale(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
-	struct iio_buffer *ring = dev_get_drvdata(dev);
-	struct iio_dev *indio_dev = ring->indio_dev;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct sca3000_state *st = iio_priv(indio_dev);
 
 	return sprintf(buf, "0.%06d\n", 4*st->info->scale);
@@ -267,7 +264,7 @@ static struct iio_buffer *sca3000_rb_allocate(struct iio_dev *indio_dev)
 	buf = &ring->buf;
 	buf->stufftoread = 0;
 	buf->attrs = &sca3000_ring_attr;
-	iio_buffer_init(buf, indio_dev);
+	iio_buffer_init(buf);
 
 	return buf;
 }
diff --git a/drivers/staging/iio/buffer.h b/drivers/staging/iio/buffer.h
index 501d4ee..9b1a4f1 100644
--- a/drivers/staging/iio/buffer.h
+++ b/drivers/staging/iio/buffer.h
@@ -65,7 +65,6 @@ struct iio_buffer_access_funcs {
 
 /**
  * struct iio_buffer - general buffer structure
- * @indio_dev:		industrial I/O device structure
  * @length:		[DEVICE] number of datums in buffer
  * @bytes_per_datum:	[DEVICE] size of individual datum including timestamp
  * @scan_el_attrs:	[DRIVER] control of scan elements if that scan mode
@@ -79,7 +78,6 @@ struct iio_buffer_access_funcs {
  * @demux_bounce:	[INTERN] buffer for doing gather from incoming scan.
  **/
 struct iio_buffer {
-	struct iio_dev				*indio_dev;
 	int					length;
 	int					bytes_per_datum;
 	struct attribute_group			*scan_el_attrs;
@@ -100,10 +98,8 @@ struct iio_buffer {
 /**
  * iio_buffer_init() - Initialize the buffer structure
  * @buffer: buffer to be initialized
- * @indio_dev: the iio device the buffer is assocated with
  **/
-void iio_buffer_init(struct iio_buffer *buffer,
-			  struct iio_dev *indio_dev);
+void iio_buffer_init(struct iio_buffer *buffer);
 
 void iio_buffer_deinit(struct iio_buffer *buffer);
 
@@ -120,14 +116,16 @@ static inline void __iio_update_buffer(struct iio_buffer *buffer,
 	buffer->length = length;
 }
 
-int iio_scan_mask_query(struct iio_buffer *buffer, int bit);
+int iio_scan_mask_query(struct iio_dev *indio_dev,
+			struct iio_buffer *buffer, int bit);
 
 /**
  * iio_scan_mask_set() - set particular bit in the scan mask
  * @buffer: the buffer whose scan mask we are interested in
  * @bit: the bit to be set.
  **/
-int iio_scan_mask_set(struct iio_buffer *buffer, int bit);
+int iio_scan_mask_set(struct iio_dev *indio_dev,
+		      struct iio_buffer *buffer, int bit);
 
 /**
  * iio_push_to_buffer() - push to a registered buffer.
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 5614a22..871f76b 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -632,11 +632,16 @@ static int __devinit adis16260_probe(struct spi_device *spi)
 	}
 	if (indio_dev->buffer) {
 		/* Set default scan mode */
-		iio_scan_mask_set(indio_dev->buffer, ADIS16260_SCAN_SUPPLY);
-		iio_scan_mask_set(indio_dev->buffer, ADIS16260_SCAN_GYRO);
-		iio_scan_mask_set(indio_dev->buffer, ADIS16260_SCAN_AUX_ADC);
-		iio_scan_mask_set(indio_dev->buffer, ADIS16260_SCAN_TEMP);
-		iio_scan_mask_set(indio_dev->buffer, ADIS16260_SCAN_ANGL);
+		iio_scan_mask_set(indio_dev, indio_dev->buffer,
+				  ADIS16260_SCAN_SUPPLY);
+		iio_scan_mask_set(indio_dev, indio_dev->buffer,
+				  ADIS16260_SCAN_GYRO);
+		iio_scan_mask_set(indio_dev, indio_dev->buffer,
+				  ADIS16260_SCAN_AUX_ADC);
+		iio_scan_mask_set(indio_dev, indio_dev->buffer,
+				  ADIS16260_SCAN_TEMP);
+		iio_scan_mask_set(indio_dev, indio_dev->buffer,
+				  ADIS16260_SCAN_ANGL);
 	}
 	if (spi->irq) {
 		ret = adis16260_probe_trigger(indio_dev);
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 23241c4..f02d1c0 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -736,8 +736,8 @@ static int __devinit ad5933_probe(struct i2c_client *client,
 		goto error_unreg_ring;
 
 	/* enable both REAL and IMAG channels by default */
-	iio_scan_mask_set(indio_dev->buffer, 0);
-	iio_scan_mask_set(indio_dev->buffer, 1);
+	iio_scan_mask_set(indio_dev, indio_dev->buffer, 0);
+	iio_scan_mask_set(indio_dev, indio_dev->buffer, 1);
 
 	ret = ad5933_setup(st);
 	if (ret)
diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index b46ae6a..552e33f 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -85,10 +85,9 @@ void iio_chrdev_buffer_release(struct iio_dev *indio_dev)
 		rb->access->unmark_in_use(rb);
 }
 
-void iio_buffer_init(struct iio_buffer *buffer, struct iio_dev *indio_dev)
+void iio_buffer_init(struct iio_buffer *buffer)
 {
 	INIT_LIST_HEAD(&buffer->demux_list);
-	buffer->indio_dev = indio_dev;
 	init_waitqueue_head(&buffer->pollq);
 }
 EXPORT_SYMBOL(iio_buffer_init);
@@ -158,7 +157,7 @@ static ssize_t iio_scan_el_store(struct device *dev,
 		ret = -EBUSY;
 		goto error_ret;
 	}
-	ret = iio_scan_mask_query(buffer, this_attr->address);
+	ret = iio_scan_mask_query(indio_dev, buffer, this_attr->address);
 	if (ret < 0)
 		goto error_ret;
 	if (!state && ret) {
@@ -166,7 +165,7 @@ static ssize_t iio_scan_el_store(struct device *dev,
 		if (ret)
 			goto error_ret;
 	} else if (state && !ret) {
-		ret = iio_scan_mask_set(buffer, this_attr->address);
+		ret = iio_scan_mask_set(indio_dev, buffer, this_attr->address);
 		if (ret)
 			goto error_ret;
 	}
@@ -578,9 +577,9 @@ EXPORT_SYMBOL(iio_sw_buffer_preenable);
  * @buffer: the buffer whose scan mask we are interested in
  * @bit: the bit to be set.
  **/
-int iio_scan_mask_set(struct iio_buffer *buffer, int bit)
+int iio_scan_mask_set(struct iio_dev *indio_dev,
+		      struct iio_buffer *buffer, int bit)
 {
-	struct iio_dev *indio_dev = buffer->indio_dev;
 	unsigned long *mask;
 	unsigned long *trialmask;
 
@@ -615,9 +614,9 @@ int iio_scan_mask_set(struct iio_buffer *buffer, int bit)
 };
 EXPORT_SYMBOL_GPL(iio_scan_mask_set);
 
-int iio_scan_mask_query(struct iio_buffer *buffer, int bit)
+int iio_scan_mask_query(struct iio_dev *indio_dev,
+			struct iio_buffer *buffer, int bit)
 {
-	struct iio_dev *indio_dev = buffer->indio_dev;
 	long *mask;
 
 	if (bit > indio_dev->masklength)
diff --git a/drivers/staging/iio/kfifo_buf.c b/drivers/staging/iio/kfifo_buf.c
index fb3b7ae..d8867ab 100644
--- a/drivers/staging/iio/kfifo_buf.c
+++ b/drivers/staging/iio/kfifo_buf.c
@@ -96,7 +96,7 @@ struct iio_buffer *iio_kfifo_allocate(struct iio_dev *indio_dev)
 	if (!kf)
 		return NULL;
 	kf->update_needed = true;
-	iio_buffer_init(&kf->buffer, indio_dev);
+	iio_buffer_init(&kf->buffer);
 	kf->buffer.attrs = &iio_kfifo_attribute_group;
 	__iio_init_kfifo(kf);
 
diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.c
index 37d26e6..a541a73 100644
--- a/drivers/staging/iio/ring_sw.c
+++ b/drivers/staging/iio/ring_sw.c
@@ -385,7 +385,7 @@ struct iio_buffer *iio_sw_rb_allocate(struct iio_dev *indio_dev)
 		return NULL;
 	ring->update_needed = true;
 	buf = &ring->buf;
-	iio_buffer_init(buf, indio_dev);
+	iio_buffer_init(buf);
 	__iio_init_sw_ring_buffer(ring);
 	buf->attrs = &iio_ring_attribute_group;
 
-- 
1.7.7.4
