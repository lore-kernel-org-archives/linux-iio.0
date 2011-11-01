Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:33332 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755346Ab1KARDq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Nov 2011 13:03:46 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: linus.ml.walleij@gmail.com, broonie@opensource.wolfsonmicro.com,
	arnd@arndb.de, gregkh@suse.de, dtor@mail.ru,
	thomas.petazzoni@free-electrons.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/5] staging:iio: make all buffer access pass through the buffer_list
Date: Tue,  1 Nov 2011 17:11:50 +0000
Message-Id: <1320167513-587-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1320167513-587-1-git-send-email-jic23@cam.ac.uk>
References: <1320167513-587-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Crucial step in allowing multiple interfaces.

Main stages:

1) Ensure no trigger_handler touches the buffers directly.
They should only care about active_scan_mask and scan_timestamp
in indio_dev.
2) Ensure all setup ops for the buffers act on the general mode
and the individual buffers in a consistent fashion.

There are almost certainly better ways of doing some of this
and I could probably have broken the set up more.  That will
have to wait for round 3.
---
 drivers/staging/iio/accel/adis16201_ring.c      |   16 +-
 drivers/staging/iio/accel/adis16203_ring.c      |   17 +-
 drivers/staging/iio/accel/adis16204_ring.c      |   15 +-
 drivers/staging/iio/accel/adis16209_ring.c      |   15 +-
 drivers/staging/iio/accel/adis16240_ring.c      |   15 +-
 drivers/staging/iio/accel/lis3l02dq_ring.c      |   18 +-
 drivers/staging/iio/adc/ad7192.c                |   39 +-
 drivers/staging/iio/adc/ad7298_ring.c           |   42 ++-
 drivers/staging/iio/adc/ad7476_ring.c           |   32 +-
 drivers/staging/iio/adc/ad7606_ring.c           |   20 +-
 drivers/staging/iio/adc/ad7793.c                |   40 +-
 drivers/staging/iio/adc/ad7887_ring.c           |   32 +-
 drivers/staging/iio/adc/ad799x_ring.c           |   34 +-
 drivers/staging/iio/adc/max1363_ring.c          |   20 +-
 drivers/staging/iio/buffer.h                    |    6 +
 drivers/staging/iio/gyro/adis16260_ring.c       |   18 +-
 drivers/staging/iio/iio.h                       |    2 +
 drivers/staging/iio/iio_simple_dummy_buffer.c   |   26 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c |   17 +-
 drivers/staging/iio/imu/adis16400_ring.c        |    2 +-
 drivers/staging/iio/industrialio-buffer.c       |  542 ++++++++++++++---------
 drivers/staging/iio/industrialio-core.c         |    1 +
 drivers/staging/iio/meter/ade7758_ring.c        |   31 +-
 23 files changed, 616 insertions(+), 384 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_ring.c b/drivers/staging/iio/accel/adis16201_ring.c
index 504773d..897b97f 100644
--- a/drivers/staging/iio/accel/adis16201_ring.c
+++ b/drivers/staging/iio/accel/adis16201_ring.c
@@ -61,11 +61,19 @@ static irqreturn_t adis16201_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16201_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
 
 	int i = 0;
 	s16 *data;
-	size_t datasize = ring->access->get_bytes_per_datum(ring);
+	size_t datasize;
+
+	/* This is available for them demux unit */
+	datasize = bitmap_weight(indio_dev->active_scan_mask,
+				 indio_dev->masklength)*2;
+	if (indio_dev->scan_timestamp) {
+		if (datasize % sizeof(s64))
+			datasize += sizeof(s64) - datasize % sizeof(s64);
+		datasize += sizeof(s64);
+	}
 
 	data = kmalloc(datasize, GFP_KERNEL);
 	if (data == NULL) {
@@ -80,10 +88,10 @@ static irqreturn_t adis16201_trigger_handler(int irq, void *p)
 			data[i] = be16_to_cpup((__be16 *)&(st->rx[i*2]));
 
 	/* Guaranteed to be aligned with 8 byte boundary */
-	if (ring->scan_timestamp)
+	if (indio_dev->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
 
-	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
+	iio_push_to_buffers(indio_dev, (u8 *)data, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 	kfree(data);
diff --git a/drivers/staging/iio/accel/adis16203_ring.c b/drivers/staging/iio/accel/adis16203_ring.c
index dfa9cb0..21e349aa 100644
--- a/drivers/staging/iio/accel/adis16203_ring.c
+++ b/drivers/staging/iio/accel/adis16203_ring.c
@@ -61,11 +61,18 @@ static irqreturn_t adis16203_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16203_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
 
 	int i = 0;
 	s16 *data;
-	size_t datasize = ring->access->get_bytes_per_datum(ring);
+	size_t datasize;
+
+	datasize = bitmap_weight(indio_dev->active_scan_mask,
+				 indio_dev->masklength)*2;
+	if (indio_dev->scan_timestamp) {
+		if (datasize % sizeof(s64))
+			datasize += sizeof(s64) - datasize % sizeof(s64);
+		datasize += sizeof(s64);
+	}
 
 	data = kmalloc(datasize, GFP_KERNEL);
 	if (data == NULL) {
@@ -80,12 +87,10 @@ static irqreturn_t adis16203_trigger_handler(int irq, void *p)
 			data[i] = be16_to_cpup((__be16 *)&(st->rx[i*2]));
 
 	/* Guaranteed to be aligned with 8 byte boundary */
-	if (ring->scan_timestamp)
+	if (indio_dev->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
 
-	ring->access->store_to(ring,
-			      (u8 *)data,
-			      pf->timestamp);
+	iio_push_to_buffers(indio_dev, (u8 *)data, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 	kfree(data);
diff --git a/drivers/staging/iio/accel/adis16204_ring.c b/drivers/staging/iio/accel/adis16204_ring.c
index 8559cb5..322d0c1 100644
--- a/drivers/staging/iio/accel/adis16204_ring.c
+++ b/drivers/staging/iio/accel/adis16204_ring.c
@@ -59,10 +59,17 @@ static irqreturn_t adis16204_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16204_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
 	int i = 0;
 	s16 *data;
-	size_t datasize = ring->access->get_bytes_per_datum(ring);
+	size_t datasize;
+
+	datasize = bitmap_weight(indio_dev->active_scan_mask,
+				 indio_dev->masklength)*2;
+	if (indio_dev->scan_timestamp) {
+		if (datasize % sizeof(s64))
+			datasize += sizeof(s64) - datasize % sizeof(s64);
+		datasize += sizeof(s64);
+	}
 
 	data = kmalloc(datasize, GFP_KERNEL);
 	if (data == NULL) {
@@ -77,10 +84,10 @@ static irqreturn_t adis16204_trigger_handler(int irq, void *p)
 			data[i] = be16_to_cpup((__be16 *)&(st->rx[i*2]));
 
 	/* Guaranteed to be aligned with 8 byte boundary */
-	if (ring->scan_timestamp)
+	if (indio_dev->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
 
-	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
+	iio_push_to_buffers(indio_dev, (u8 *)data, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 	kfree(data);
diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index 971aff6..7731d42 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -59,12 +59,17 @@ static irqreturn_t adis16209_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16209_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
-
 	int i = 0;
 	s16 *data;
-	size_t datasize = ring->access->get_bytes_per_datum(ring);
+	size_t datasize;
 
+	datasize = bitmap_weight(indio_dev->active_scan_mask,
+				 indio_dev->masklength)*2;
+	if (indio_dev->scan_timestamp) {
+		if (datasize % sizeof(s64))
+			datasize += sizeof(s64) - datasize % sizeof(s64);
+		datasize += sizeof(s64);
+	}
 	data = kmalloc(datasize , GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(&st->us->dev, "memory alloc failed in ring bh");
@@ -78,10 +83,10 @@ static irqreturn_t adis16209_trigger_handler(int irq, void *p)
 			data[i] = be16_to_cpup((__be16 *)&(st->rx[i*2]));
 
 	/* Guaranteed to be aligned with 8 byte boundary */
-	if (ring->scan_timestamp)
+	if (indio_dev->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
 
-	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
+	iio_push_to_buffers(indio_dev, (u8 *)data, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 	kfree(data);
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index e4ede74..ccbcace 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -56,12 +56,17 @@ static irqreturn_t adis16240_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16240_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
-
 	int i = 0;
 	s16 *data;
-	size_t datasize = ring->access->get_bytes_per_datum(ring);
+	size_t datasize;
 
+	datasize = bitmap_weight(indio_dev->active_scan_mask,
+				 indio_dev->masklength)*2;
+	if (indio_dev->scan_timestamp) {
+		if (datasize % sizeof(s64))
+			datasize += sizeof(s64) - datasize % sizeof(s64);
+		datasize += sizeof(s64);
+	}
 	data = kmalloc(datasize, GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(&st->us->dev, "memory alloc failed in ring bh");
@@ -75,10 +80,10 @@ static irqreturn_t adis16240_trigger_handler(int irq, void *p)
 			data[i] = be16_to_cpup((__be16 *)&(st->rx[i*2]));
 
 	/* Guaranteed to be aligned with 8 byte boundary */
-	if (ring->scan_timestamp)
+	if (indio_dev->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
 
-	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
+	iio_push_to_buffers(indio_dev, (u8 *)data, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 	kfree(data);
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 8a1d5fe..ed75ed4 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -166,11 +166,19 @@ static irqreturn_t lis3l02dq_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	struct iio_buffer *buffer = indio_dev->buffer;
 	int len = 0;
-	size_t datasize = buffer->access->get_bytes_per_datum(buffer);
-	char *data = kmalloc(datasize, GFP_KERNEL);
+	size_t datasize;
+	char *data;
 
+	datasize = bitmap_weight(indio_dev->active_scan_mask,
+				 indio_dev->masklength)*2;
+	if (indio_dev->scan_timestamp) {
+		if (datasize % sizeof(s64))
+			datasize += sizeof(s64) - datasize % sizeof(s64);
+		datasize += sizeof(s64);
+	}
+
+	data = kmalloc(datasize, GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(indio_dev->dev.parent,
 			"memory alloc failed in buffer bh");
@@ -181,11 +189,11 @@ static irqreturn_t lis3l02dq_trigger_handler(int irq, void *p)
 		len = lis3l02dq_get_buffer_element(indio_dev, data);
 
 	  /* Guaranteed to be aligned with 8 byte boundary */
-	if (buffer->scan_timestamp)
+	if (indio_dev->scan_timestamp)
 		*(s64 *)(((phys_addr_t)data + len
 				+ sizeof(s64) - 1) & ~(sizeof(s64) - 1))
 			= pf->timestamp;
-	buffer->access->store_to(buffer, (u8 *)data, pf->timestamp);
+	iio_push_to_buffers(indio_dev, (u8 *)data, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 	kfree(data);
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 88bf082..6f4188c 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -455,12 +455,14 @@ out:
 
 static int ad7192_scan_from_ring(struct ad7192_state *st, unsigned ch, int *val)
 {
-	struct iio_buffer *ring = iio_priv_to_dev(st)->buffer;
+	struct iio_dev *indio_dev = iio_priv_to_dev(st);
+	struct iio_buffer *ring = indio_dev->buffer;
 	int ret;
 	s64 dat64[2];
 	u32 *dat32 = (u32 *)dat64;
 
-	if (!(test_bit(ch, ring->scan_mask)))
+	if (!iio_is_primary_active(indio_dev) ||
+	    !(test_bit(ch, ring->scan_mask)))
 		return  -EBUSY;
 
 	ret = ring->access->read_last(ring, (u8 *) &dat64);
@@ -475,30 +477,30 @@ static int ad7192_scan_from_ring(struct ad7192_state *st, unsigned ch, int *val)
 static int ad7192_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct ad7192_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
+	struct iio_buffer *buffer;
 	size_t d_size;
 	unsigned channel;
 
 	if (bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
 		return -EINVAL;
 
-	channel = find_first_bit(indio_dev->active_scan_mask,
-				 indio_dev->masklength);
-
-	d_size = bitmap_weight(indio_dev->active_scan_mask,
-			       indio_dev->masklength) *
-		 indio_dev->channels[0].scan_type.storagebits / 8;
+	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
+		d_size = bitmap_weight(buffer->scan_mask,
+				       indio_dev->masklength) *
+			indio_dev->channels[0].scan_type.storagebits / 8;
 
-	if (ring->scan_timestamp) {
-		d_size += sizeof(s64);
+		if (buffer->scan_timestamp) {
+			d_size += sizeof(s64);
+			if (d_size % sizeof(s64))
+				d_size += sizeof(s64) - (d_size % sizeof(s64));
+		}
 
-		if (d_size % sizeof(s64))
-			d_size += sizeof(s64) - (d_size % sizeof(s64));
+		if (buffer->access->set_bytes_per_datum)
+			buffer->access->set_bytes_per_datum(buffer, d_size);
 	}
 
-	if (indio_dev->buffer->access->set_bytes_per_datum)
-		indio_dev->buffer->access->
-			set_bytes_per_datum(indio_dev->buffer, d_size);
+	channel = find_first_bit(indio_dev->active_scan_mask,
+				 indio_dev->masklength);
 
 	st->mode  = (st->mode & ~AD7192_MODE_SEL(-1)) |
 		    AD7192_MODE_SEL(AD7192_MODE_CONT);
@@ -541,7 +543,6 @@ static irqreturn_t ad7192_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	struct iio_buffer *ring = indio_dev->buffer;
 	struct ad7192_state *st = iio_priv(indio_dev);
 	s64 dat64[2];
 	s32 *dat32 = (s32 *)dat64;
@@ -552,10 +553,10 @@ static irqreturn_t ad7192_trigger_handler(int irq, void *p)
 				  indio_dev->channels[0].scan_type.realbits/8);
 
 	/* Guaranteed to be aligned with 8 byte boundary */
-	if (ring->scan_timestamp)
+	if (indio_dev->scan_timestamp)
 		dat64[1] = pf->timestamp;
 
-	ring->access->store_to(ring, (u8 *)dat64, pf->timestamp);
+	iio_push_to_buffers(indio_dev, (u8 *)dat64, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 	st->irq_dis = false;
diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
index 5695eb2..42ad999 100644
--- a/drivers/staging/iio/adc/ad7298_ring.c
+++ b/drivers/staging/iio/adc/ad7298_ring.c
@@ -24,7 +24,8 @@ int ad7298_scan_from_ring(struct iio_dev *indio_dev, long ch)
 	int ret;
 	u16 *ring_data;
 
-	if (!(test_bit(ch, ring->scan_mask))) {
+	if (!iio_is_primary_active(indio_dev) ||
+	    !(test_bit(ch, ring->scan_mask))) {
 		ret = -EBUSY;
 		goto error_ret;
 	}
@@ -35,7 +36,7 @@ int ad7298_scan_from_ring(struct iio_dev *indio_dev, long ch)
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-	ret = ring->access->read_last(ring, (u8 *) ring_data);
+	ret = ring->access->read_last(ring, (u8 *)ring_data);
 	if (ret)
 		goto error_free_ring_data;
 
@@ -57,24 +58,38 @@ error_ret:
 static int ad7298_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct ad7298_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
+	struct iio_buffer *buffer;
 	size_t d_size;
 	int i, m;
 	unsigned short command;
-	int scan_count = bitmap_weight(indio_dev->active_scan_mask,
-				       indio_dev->masklength);
+	int scan_count;
+
+	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
+		scan_count = bitmap_weight(buffer->scan_mask,
+					   indio_dev->masklength);
+		d_size = scan_count * (AD7298_STORAGE_BITS / 8);
+
+		if (buffer->scan_timestamp) {
+			d_size += sizeof(s64);
+			if (d_size % sizeof(s64))
+				d_size += sizeof(s64) - (d_size % sizeof(s64));
+		}
+
+		if (buffer->access->set_bytes_per_datum)
+			buffer->access->set_bytes_per_datum(buffer, d_size);
+	}
+
+	/* Now compute overall size */
+	scan_count = bitmap_weight(indio_dev->active_scan_mask,
+				   indio_dev->masklength);
 	d_size = scan_count * (AD7298_STORAGE_BITS / 8);
 
-	if (ring->scan_timestamp) {
+	if (indio_dev->scan_timestamp) {
 		d_size += sizeof(s64);
-
 		if (d_size % sizeof(s64))
 			d_size += sizeof(s64) - (d_size % sizeof(s64));
 	}
 
-	if (ring->access->set_bytes_per_datum)
-		ring->access->set_bytes_per_datum(ring, d_size);
-
 	st->d_size = d_size;
 
 	command = AD7298_WRITE | st->ext_ref;
@@ -120,7 +135,6 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad7298_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
 	s64 time_ns;
 	__u16 buf[16];
 	int b_sent, i;
@@ -129,17 +143,17 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
 	if (b_sent)
 		return b_sent;
 
-	if (ring->scan_timestamp) {
+	if (indio_dev->scan_timestamp) {
 		time_ns = iio_get_time_ns();
 		memcpy((u8 *)buf + st->d_size - sizeof(s64),
 			&time_ns, sizeof(time_ns));
 	}
 
 	for (i = 0; i < bitmap_weight(indio_dev->active_scan_mask,
-						 indio_dev->masklength); i++)
+				      indio_dev->masklength); i++)
 		buf[i] = be16_to_cpu(st->rx_buf[i]);
 
-	indio_dev->buffer->access->store_to(ring, (u8 *)buf, time_ns);
+	iio_push_to_buffers(indio_dev, (u8 *)buf, time_ns);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
index ff0656a..7e01f3e 100644
--- a/drivers/staging/iio/adc/ad7476_ring.c
+++ b/drivers/staging/iio/adc/ad7476_ring.c
@@ -26,6 +26,9 @@ int ad7476_scan_from_ring(struct iio_dev *indio_dev)
 	int ret;
 	u8 *ring_data;
 
+	if (!iio_is_primary_active(indio_dev))
+		return -EBUSY;
+
 	ring_data = kmalloc(ring->access->get_bytes_per_datum(ring),
 			    GFP_KERNEL);
 	if (ring_data == NULL) {
@@ -54,23 +57,32 @@ error_ret:
 static int ad7476_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct ad7476_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
-
+	struct iio_buffer *buffer;
+	int d_size;
 	st->d_size = bitmap_weight(indio_dev->active_scan_mask,
 				   indio_dev->masklength) *
 		st->chip_info->channel[0].scan_type.storagebits / 8;
 
-	if (ring->scan_timestamp) {
-		st->d_size += sizeof(s64);
-
+	if (indio_dev->scan_timestamp) {
+		d_size += sizeof(s64);
 		if (st->d_size % sizeof(s64))
 			st->d_size += sizeof(s64) - (st->d_size % sizeof(s64));
 	}
 
-	if (indio_dev->buffer->access->set_bytes_per_datum)
-		indio_dev->buffer->access->
-			set_bytes_per_datum(indio_dev->buffer, st->d_size);
+	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
+		d_size = bitmap_weight(buffer->scan_mask,
+				       indio_dev->masklength) *
+			st->chip_info->channel[0].scan_type.storagebits / 8;
+		if (buffer->scan_timestamp) {
+			d_size += sizeof(s64);
 
+			if (st->d_size % sizeof(s64))
+				d_size += sizeof(s64) -
+					(st->d_size % sizeof(s64));
+		}
+		if (buffer->access->set_bytes_per_datum)
+			buffer->access->set_bytes_per_datum(buffer, st->d_size);
+	}
 	return 0;
 }
 
@@ -94,11 +106,11 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
 
 	time_ns = iio_get_time_ns();
 
-	if (indio_dev->buffer->scan_timestamp)
+	if (indio_dev->scan_timestamp)
 		memcpy(rxbuf + st->d_size - sizeof(s64),
 			&time_ns, sizeof(time_ns));
 
-	indio_dev->buffer->access->store_to(indio_dev->buffer, rxbuf, time_ns);
+	iio_push_to_buffers(indio_dev, rxbuf, time_ns);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 	kfree(rxbuf);
diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index f682af6..7086c18 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -70,13 +70,18 @@ static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
 	struct ad7606_state *st = container_of(work_s, struct ad7606_state,
 						poll_work);
 	struct iio_dev *indio_dev = iio_priv_to_dev(st);
-	struct iio_buffer *ring = indio_dev->buffer;
 	s64 time_ns;
 	__u8 *buf;
-	int ret;
+	int ret, scan_size;
 
-	buf = kzalloc(ring->access->get_bytes_per_datum(ring),
-		      GFP_KERNEL);
+	scan_size = bitmap_weight(indio_dev->active_scan_mask,
+				  indio_dev->masklength)*2;
+	if (indio_dev->scan_timestamp) {
+		if (scan_size % sizeof(s64))
+			scan_size += sizeof(s64) - scan_size % sizeof(s64);
+		scan_size += sizeof(s64);
+	}
+	buf = kzalloc(scan_size, GFP_KERNEL);
 	if (buf == NULL)
 		return;
 
@@ -106,11 +111,10 @@ static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
 
 	time_ns = iio_get_time_ns();
 
-	if (ring->scan_timestamp)
-		*((s64 *)(buf + ring->access->get_bytes_per_datum(ring) -
-			  sizeof(s64))) = time_ns;
+	if (indio_dev->scan_timestamp)
+		*((s64 *)(buf + scan_size - sizeof(s64))) = time_ns;
 
-	ring->access->store_to(indio_dev->buffer, buf, time_ns);
+	iio_push_to_buffers(indio_dev, buf, time_ns);
 done:
 	gpio_set_value(st->pdata->gpio_convst, 0);
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index dfc904c..008d2d3 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -317,12 +317,14 @@ out:
 
 static int ad7793_scan_from_ring(struct ad7793_state *st, unsigned ch, int *val)
 {
-	struct iio_buffer *ring = iio_priv_to_dev(st)->buffer;
+	struct iio_dev *indio_dev = iio_priv_to_dev(st);
+	struct iio_buffer *ring = indio_dev->buffer;
 	int ret;
 	s64 dat64[2];
 	u32 *dat32 = (u32 *)dat64;
 
-	if (!(test_bit(ch, ring->scan_mask)))
+	if (!iio_is_primary_active(indio_dev) ||
+	    !(test_bit(ch, ring->scan_mask)))
 		return  -EBUSY;
 
 	ret = ring->access->read_last(ring, (u8 *) &dat64);
@@ -337,30 +339,29 @@ static int ad7793_scan_from_ring(struct ad7793_state *st, unsigned ch, int *val)
 static int ad7793_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct ad7793_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
+	struct iio_buffer *buffer;
 	size_t d_size;
 	unsigned channel;
 
 	if (bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
 		return -EINVAL;
 
-	channel = find_first_bit(indio_dev->active_scan_mask,
-				 indio_dev->masklength);
-
-	d_size = bitmap_weight(indio_dev->active_scan_mask,
-			       indio_dev->masklength) *
-		indio_dev->channels[0].scan_type.storagebits / 8;
+	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
+		d_size = bitmap_weight(buffer->scan_mask,
+				       indio_dev->masklength) *
+			indio_dev->channels[0].scan_type.storagebits / 8;
 
-	if (ring->scan_timestamp) {
-		d_size += sizeof(s64);
-
-		if (d_size % sizeof(s64))
-			d_size += sizeof(s64) - (d_size % sizeof(s64));
+		if (buffer->scan_timestamp) {
+			d_size += sizeof(s64);
+			if (d_size % sizeof(s64))
+				d_size += sizeof(s64) - (d_size % sizeof(s64));
+		}
+		if (buffer->access->set_bytes_per_datum)
+			buffer->access->set_bytes_per_datum(buffer, d_size);
 	}
 
-	if (indio_dev->buffer->access->set_bytes_per_datum)
-		indio_dev->buffer->access->
-			set_bytes_per_datum(indio_dev->buffer, d_size);
+	channel = find_first_bit(indio_dev->active_scan_mask,
+				 indio_dev->masklength);
 
 	st->mode  = (st->mode & ~AD7793_MODE_SEL(-1)) |
 		    AD7793_MODE_SEL(AD7793_MODE_CONT);
@@ -406,7 +407,6 @@ static irqreturn_t ad7793_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	struct iio_buffer *ring = indio_dev->buffer;
 	struct ad7793_state *st = iio_priv(indio_dev);
 	s64 dat64[2];
 	s32 *dat32 = (s32 *)dat64;
@@ -417,10 +417,10 @@ static irqreturn_t ad7793_trigger_handler(int irq, void *p)
 				  indio_dev->channels[0].scan_type.realbits/8);
 
 	/* Guaranteed to be aligned with 8 byte boundary */
-	if (ring->scan_timestamp)
+	if (indio_dev->scan_timestamp)
 		dat64[1] = pf->timestamp;
 
-	ring->access->store_to(ring, (u8 *)dat64, pf->timestamp);
+	iio_push_to_buffers(indio_dev, (u8 *)dat64, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 	st->irq_dis = false;
diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
index f53a663..ac89fb3 100644
--- a/drivers/staging/iio/adc/ad7887_ring.c
+++ b/drivers/staging/iio/adc/ad7887_ring.c
@@ -21,11 +21,13 @@
 
 int ad7887_scan_from_ring(struct ad7887_state *st, int channum)
 {
-	struct iio_buffer *ring = iio_priv_to_dev(st)->buffer;
+	struct iio_dev *indio_dev = iio_priv_to_dev(st);
+	struct iio_buffer *ring = indio_dev->buffer;
 	int count = 0, ret;
 	u16 *ring_data;
 
-	if (!(test_bit(channum, ring->scan_mask))) {
+	if (!iio_is_primary_active(indio_dev) ||
+	    !(test_bit(channum, ring->scan_mask))) {
 		ret = -EBUSY;
 		goto error_ret;
 	}
@@ -63,23 +65,32 @@ error_ret:
 static int ad7887_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct ad7887_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
-
+	struct iio_buffer *buffer;
+	int d_size;
 	st->d_size = bitmap_weight(indio_dev->active_scan_mask,
 				   indio_dev->masklength) *
 		st->chip_info->channel[0].scan_type.storagebits / 8;
 
-	if (ring->scan_timestamp) {
+	if (indio_dev->scan_timestamp) {
 		st->d_size += sizeof(s64);
 
 		if (st->d_size % sizeof(s64))
 			st->d_size += sizeof(s64) - (st->d_size % sizeof(s64));
 	}
 
-	if (indio_dev->buffer->access->set_bytes_per_datum)
-		indio_dev->buffer->access->
-			set_bytes_per_datum(indio_dev->buffer, st->d_size);
+	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
+		d_size = bitmap_weight(indio_dev->active_scan_mask,
+				   indio_dev->masklength) *
+			st->chip_info->channel[0].scan_type.storagebits / 8;
 
+		if (buffer->scan_timestamp) {
+			d_size += sizeof(s64);
+			if (d_size % sizeof(s64))
+				d_size += sizeof(s64) - (d_size % sizeof(s64));
+		}
+		if (buffer->access->set_bytes_per_datum)
+			buffer->access->set_bytes_per_datum(buffer, d_size);
+	}
 	/* We know this is a single long so can 'cheat' */
 	switch (*indio_dev->active_scan_mask) {
 	case (1 << 0):
@@ -117,7 +128,6 @@ static irqreturn_t ad7887_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad7887_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
 	s64 time_ns;
 	__u8 *buf;
 	int b_sent;
@@ -137,11 +147,11 @@ static irqreturn_t ad7887_trigger_handler(int irq, void *p)
 	time_ns = iio_get_time_ns();
 
 	memcpy(buf, st->data, bytes);
-	if (ring->scan_timestamp)
+	if (indio_dev->scan_timestamp)
 		memcpy(buf + st->d_size - sizeof(s64),
 		       &time_ns, sizeof(time_ns));
 
-	indio_dev->buffer->access->store_to(indio_dev->buffer, buf, time_ns);
+	iio_push_to_buffers(indio_dev, buf, time_ns);
 done:
 	kfree(buf);
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index 5841c3c..aae0ff3 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -29,7 +29,8 @@ int ad799x_single_channel_from_ring(struct iio_dev *indio_dev, int channum)
 	int count = 0, ret;
 	u16 *ring_data;
 
-	if (!(test_bit(channum, ring->scan_mask))) {
+	if (!iio_is_primary_active(indio_dev) ||
+	    !(test_bit(channum, ring->scan_mask))) {
 		ret = -EBUSY;
 		goto error_ret;
 	}
@@ -62,9 +63,9 @@ error_ret:
  **/
 static int ad799x_ring_preenable(struct iio_dev *indio_dev)
 {
-	struct iio_buffer *ring = indio_dev->buffer;
+	struct iio_buffer *buffer;
 	struct ad799x_state *st = iio_priv(indio_dev);
-
+	int d_size;
 	/*
 	 * Need to figure out the current mode based upon the requested
 	 * scan mask in iio_dev
@@ -76,17 +77,23 @@ static int ad799x_ring_preenable(struct iio_dev *indio_dev)
 	st->d_size = bitmap_weight(indio_dev->active_scan_mask,
 				   indio_dev->masklength) * 2;
 
-	if (ring->scan_timestamp) {
+	if (indio_dev->scan_timestamp) {
 		st->d_size += sizeof(s64);
-
 		if (st->d_size % sizeof(s64))
-			st->d_size += sizeof(s64) - (st->d_size % sizeof(s64));
+			st->d_size += sizeof(s64) -
+				(st->d_size % sizeof(s64));
+	}
+	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
+		d_size = bitmap_weight(indio_dev->active_scan_mask,
+				   indio_dev->masklength) * 2;
+		if (buffer->scan_timestamp) {
+			d_size += sizeof(s64);
+			if (d_size % sizeof(s64))
+				d_size += sizeof(s64) - (d_size % sizeof(s64));
+		}
+		if (buffer->access->set_bytes_per_datum)
+			buffer->access->set_bytes_per_datum(buffer, d_size);
 	}
-
-	if (indio_dev->buffer->access->set_bytes_per_datum)
-		indio_dev->buffer->access->
-			set_bytes_per_datum(indio_dev->buffer, st->d_size);
-
 	return 0;
 }
 
@@ -102,7 +109,6 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad799x_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
 	s64 time_ns;
 	__u8 *rxbuf;
 	int b_sent;
@@ -141,11 +147,11 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 
 	time_ns = iio_get_time_ns();
 
-	if (ring->scan_timestamp)
+	if (indio_dev->scan_timestamp)
 		memcpy(rxbuf + st->d_size - sizeof(s64),
 			&time_ns, sizeof(time_ns));
 
-	ring->access->store_to(indio_dev->buffer, rxbuf, time_ns);
+	iio_push_to_buffers(indio_dev, rxbuf, time_ns);
 done:
 	kfree(rxbuf);
 	if (b_sent < 0)
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index 3a38a26..b52ec5b 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -23,28 +23,32 @@
 
 int max1363_single_channel_from_ring(const long *mask, struct max1363_state *st)
 {
-	struct iio_buffer *ring = iio_priv_to_dev(st)->buffer;
+	struct iio_dev *indio_dev = iio_priv_to_dev(st);
+	struct iio_buffer *buffer = indio_dev->buffer;
 	int count = 0, ret, index;
 	u8 *ring_data;
 	index = find_first_bit(mask, MAX1363_MAX_CHANNELS);
 
-	if (!(test_bit(index, st->current_mode->modemask))) {
+	if (!iio_is_primary_active(indio_dev))
+		return -EBUSY;
+	if (!(test_bit(index, indio_dev->buffer->scan_mask))) {
 		ret = -EBUSY;
 		goto error_ret;
 	}
 
-	ring_data = kmalloc(ring->access->get_bytes_per_datum(ring),
+	ring_data = kmalloc(buffer->access->
+			    get_bytes_per_datum(indio_dev->buffer),
 			    GFP_KERNEL);
 	if (ring_data == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-	ret = ring->access->read_last(ring, ring_data);
+	ret = buffer->access->read_last(indio_dev->buffer, ring_data);
 	if (ret)
 		goto error_free_ring_data;
 	/* Need a count of channels prior to this one */
 
-	count = bitmap_weight(mask, index - 1);
+	count = bitmap_weight(indio_dev->buffer->scan_mask, index - 1);
 	if (st->chip_info->bits != 8)
 		ret = ((int)(ring_data[count*2 + 0] & 0x0F) << 8)
 			+ (int)(ring_data[count*2 + 1]);
@@ -90,7 +94,7 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
 		d_size = numvals*2;
 	else
 		d_size = numvals;
-	if (indio_dev->buffer->scan_timestamp) {
+	if (indio_dev->scan_timestamp) {
 		d_size += sizeof(s64);
 		if (d_size % sizeof(s64))
 			d_size += sizeof(s64) - (d_size % sizeof(s64));
@@ -114,9 +118,9 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
 
 	time_ns = iio_get_time_ns();
 
-	if (indio_dev->buffer->scan_timestamp)
+	if (indio_dev->scan_timestamp)
 		memcpy(rxbuf + d_size - sizeof(s64), &time_ns, sizeof(time_ns));
-	iio_push_to_buffer(indio_dev->buffer, rxbuf, time_ns);
+	iio_push_to_buffers(indio_dev, rxbuf, time_ns);
 
 done:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/staging/iio/buffer.h b/drivers/staging/iio/buffer.h
index 7fc0894..cdfc15b 100644
--- a/drivers/staging/iio/buffer.h
+++ b/drivers/staging/iio/buffer.h
@@ -99,8 +99,11 @@ struct iio_buffer {
 	const struct attribute_group *attrs;
 	struct list_head			demux_list;
 	unsigned char				*demux_bounce;
+	struct list_head			buffer_list;
 };
 
+bool iio_is_primary_active(struct iio_dev *indio_dev);
+
 /**
  * iio_buffer_init() - Initialize the buffer structure
  * @buffer: buffer to be initialized
@@ -145,6 +148,9 @@ int iio_scan_mask_set(struct iio_buffer *buffer, int bit);
 int iio_push_to_buffer(struct iio_buffer *buffer, unsigned char *data,
 		       s64 timestamp);
 
+int iio_push_to_buffers(struct iio_dev *indio_dev, unsigned char *data,
+		       s64 timestamp);
+
 int iio_update_demux(struct iio_dev *indio_dev);
 
 /**
diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index 6a9b5db4..f87c1fc 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -62,12 +62,20 @@ static irqreturn_t adis16260_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16260_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
 	int i = 0;
 	s16 *data;
-	size_t datasize = ring->access->get_bytes_per_datum(ring);
+	size_t data_size;
 
-	data = kmalloc(datasize , GFP_KERNEL);
+	data_size = bitmap_weight(indio_dev->active_scan_mask,
+				  indio_dev->masklength)*2;
+
+	if (indio_dev->scan_timestamp) {
+		if (data_size % sizeof(s64))
+			data_size += sizeof(s64) - data_size % sizeof(s64);
+		data_size += sizeof(s64);
+	}
+
+	data = kmalloc(data_size, GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(&st->us->dev, "memory alloc failed in ring bh");
 		return -ENOMEM;
@@ -80,10 +88,10 @@ static irqreturn_t adis16260_trigger_handler(int irq, void *p)
 			data[i] = be16_to_cpup((__be16 *)&(st->rx[i*2]));
 
 	/* Guaranteed to be aligned with 8 byte boundary */
-	if (ring->scan_timestamp)
+	if (indio_dev->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
 
-	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
+	iio_push_to_buffers(indio_dev, (u8 *)data, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 	kfree(data);
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index bd29412..19d1741 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -322,11 +322,13 @@ struct iio_dev {
 	struct iio_event_interface	*event_interface;
 
 	struct iio_buffer		*buffer;
+	struct list_head		buffer_list;
 	struct mutex			mlock;
 
 	unsigned long			*available_scan_masks;
 	unsigned			masklength;
 	unsigned long			*active_scan_mask;
+	bool				scan_timestamp;
 	struct iio_trigger		*trig;
 	struct iio_poll_func		*pollfunc;
 
diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
index c572f8b..b4b0531 100644
--- a/drivers/staging/iio/iio_simple_dummy_buffer.c
+++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
@@ -45,18 +45,26 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	struct iio_buffer *buffer = indio_dev->buffer;
 	int len = 0;
 	/*
 	 * The datasize is obtained from the buffer. It was stored when
 	 * the preenable setup function was called.
 	 */
-	size_t datasize = buffer->access->get_bytes_per_datum(buffer);
-	u16 *data = kmalloc(datasize, GFP_KERNEL);
+	size_t data_size;
+	u16 *data;
+
+	data_size = bitmap_weight(indio_dev->active_scan_mask,
+				  indio_dev->masklength);
+	if (indio_dev->scan_timestamp) {
+		if (data_size % sizeof(s64))
+			data_size += sizeof(s64) - (data_size % sizeof(s64));
+		data_size += sizeof(s64);
+	}
+	data = kmalloc(data_size, GFP_KERNEL);
 	if (data == NULL)
 		return -ENOMEM;
 
-	if (buffer->scan_count) {
+	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength)) {
 		/*
 		 * Three common options here:
 		 * hardware scans: certain combinations of channels make
@@ -74,8 +82,10 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 		 * in the constant table fakedata.
 		 */
 		int i, j;
-		for (i = 0, j = 0; i < buffer->scan_count; i++) {
-			j = find_next_bit(buffer->scan_mask,
+		for (i = 0, j = 0;
+		     i < bitmap_weight(indio_dev->active_scan_mask,
+				       indio_dev->masklength); i++) {
+			j = find_next_bit(indio_dev->active_scan_mask,
 					  indio_dev->masklength, j + 1);
 			/* random access read form the 'device' */
 			data[i] = fakedata[j];
@@ -83,11 +93,11 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 		}
 	}
 	/* Store a timestampe at an 8 byte boundary */
-	if (buffer->scan_timestamp)
+	if (indio_dev->scan_timestamp)
 		*(s64 *)(((phys_addr_t)data + len
 				+ sizeof(s64) - 1) & ~(sizeof(s64) - 1))
 			= iio_get_time_ns();
-	buffer->access->store_to(buffer, (u8 *)data, pf->timestamp);
+	iio_push_to_buffers(indio_dev, (u8 *)data, pf->timestamp);
 
 	kfree(data);
 
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 8da86b7..c21a69a 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -539,17 +539,19 @@ static int ad5933_ring_preenable(struct iio_dev *indio_dev)
 	struct ad5933_state *st = iio_priv(indio_dev);
 	size_t d_size;
 	int ret;
+	struct iio_buffer *buffer;
 
 	if (bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
 		return -EINVAL;
 
-	d_size = bitmap_weight(indio_dev->active_scan_mask,
-			       indio_dev->masklength) *
-		 ad5933_channels[1].scan_type.storagebits / 8;
+	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
+		d_size = bitmap_weight(buffer->scan_mask,
+				       indio_dev->masklength) *
+			ad5933_channels[1].scan_type.storagebits / 8;
 
-	if (indio_dev->buffer->access->set_bytes_per_datum)
-		indio_dev->buffer->access->
-			set_bytes_per_datum(indio_dev->buffer, d_size);
+		if (buffer->access->set_bytes_per_datum)
+			buffer->access->set_bytes_per_datum(buffer, d_size);
+	}
 
 	ret = ad5933_reset(st);
 	if (ret < 0)
@@ -623,7 +625,6 @@ static void ad5933_work(struct work_struct *work)
 	struct ad5933_state *st = container_of(work,
 		struct ad5933_state, work.work);
 	struct iio_dev *indio_dev = i2c_get_clientdata(st->client);
-	struct iio_buffer *ring = indio_dev->buffer;
 	signed short buf[2];
 	unsigned char status;
 
@@ -654,7 +655,7 @@ static void ad5933_work(struct work_struct *work)
 			buf[0] = be16_to_cpu(buf[0]);
 		}
 		/* save datum to the ring */
-		ring->access->store_to(ring, (u8 *)buf, iio_get_time_ns());
+		iio_push_to_buffers(indio_dev, (u8 *)buf, iio_get_time_ns());
 	} else {
 		/* no data available - try again later */
 		schedule_delayed_work(&st->work, st->poll_time_jiffies);
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index 9506e05..44f3ee2 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -151,7 +151,7 @@ static irqreturn_t adis16400_trigger_handler(int irq, void *p)
 	/* Guaranteed to be aligned with 8 byte boundary */
 	if (ring->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
-	ring->access->store_to(indio_dev->buffer, (u8 *) data, pf->timestamp);
+	iio_push_to_buffers(indio_dev, (u8 *) data, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 
diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index 5f9ed47..b02a463 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -30,6 +30,17 @@ static const char * const iio_endian_prefix[] = {
 	[IIO_LE] = "le",
 };
 
+bool iio_is_primary_active(struct iio_dev *indio_dev)
+{
+	struct list_head *p;
+
+	list_for_each(p, &indio_dev->buffer_list)
+		if (p == &indio_dev->buffer->buffer_list)
+			return true;
+	return false;
+}
+EXPORT_SYMBOL_GPL(iio_is_primary_active);
+
 /**
  * iio_buffer_read_first_n_outer() - chrdev read for buffer access
  *
@@ -136,7 +147,6 @@ static ssize_t iio_scan_el_show(struct device *dev,
 static int iio_scan_mask_clear(struct iio_buffer *buffer, int bit)
 {
 	clear_bit(bit, buffer->scan_mask);
-	buffer->scan_count--;
 	return 0;
 }
 
@@ -145,15 +155,17 @@ static ssize_t iio_scan_el_store(struct device *dev,
 				 const char *buf,
 				 size_t len)
 {
-	int ret = 0;
+	int ret;
 	bool state;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct iio_buffer *buffer = indio_dev->buffer;
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
-	state = !(buf[0] == '0');
+	ret = strtobool(buf, &state);
+	if (ret < 0)
+		return ret;
 	mutex_lock(&indio_dev->mlock);
-	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
+	if (iio_is_primary_active(indio_dev)) {
 		ret = -EBUSY;
 		goto error_ret;
 	}
@@ -190,13 +202,16 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
 				    const char *buf,
 				    size_t len)
 {
-	int ret = 0;
+	int ret;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	bool state;
 
-	state = !(buf[0] == '0');
+	ret = strtobool(buf, &state);
+	if (ret < 0)
+		return ret;
+
 	mutex_lock(&indio_dev->mlock);
-	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
+	if (iio_is_primary_active(indio_dev)) {
 		ret = -EBUSY;
 		goto error_ret;
 	}
@@ -298,34 +313,41 @@ int iio_buffer_register(struct iio_dev *indio_dev,
 	attrcount = attrcount_orig;
 	INIT_LIST_HEAD(&buffer->demux_list);
 	INIT_LIST_HEAD(&buffer->scan_el_dev_attr_list);
-	if (channels) {
-		/* new magic */
-		for (i = 0; i < num_channels; i++) {
-			/* Establish necessary mask length */
-			if (channels[i].scan_index >
-			    (int)indio_dev->masklength - 1)
-				indio_dev->masklength
-					= indio_dev->channels[i].scan_index + 1;
+	/* new magic */
+	for (i = 0; i < num_channels; i++) {
+		/* Establish necessary mask length */
+		if (channels[i].scan_index >
+		    (int)indio_dev->masklength - 1)
+			indio_dev->masklength
+				= indio_dev->channels[i].scan_index + 1;
 
-			ret = iio_buffer_add_channel_sysfs(indio_dev,
+		ret = iio_buffer_add_channel_sysfs(indio_dev,
 							 &channels[i]);
-			if (ret < 0)
-				goto error_cleanup_dynamic;
-			attrcount += ret;
-			if (channels[i].type == IIO_TIMESTAMP)
-				buffer->scan_index_timestamp = channels[i].scan_index;
-		}
-		if (indio_dev->masklength && buffer->scan_mask == NULL) {
-			buffer->scan_mask
-				= kzalloc(sizeof(*buffer->scan_mask)*
-					  BITS_TO_LONGS(indio_dev->masklength),
-					  GFP_KERNEL);
-			if (buffer->scan_mask == NULL) {
-				ret = -ENOMEM;
-				goto error_cleanup_dynamic;
-			}
+		if (ret < 0)
+			goto error_cleanup_dynamic;
+		attrcount += ret;
+		if (channels[i].type == IIO_TIMESTAMP)
+			buffer->scan_index_timestamp = channels[i].scan_index;
+	}
+	if (indio_dev->masklength && buffer->scan_mask == NULL) {
+		buffer->scan_mask
+			= kzalloc(sizeof(*buffer->scan_mask)*
+				  BITS_TO_LONGS(indio_dev->masklength),
+				  GFP_KERNEL);
+		if (buffer->scan_mask == NULL) {
+			ret = -ENOMEM;
+			goto error_cleanup_dynamic;
 		}
 	}
+	indio_dev->active_scan_mask =
+		kzalloc(sizeof(*buffer->scan_mask)*
+			BITS_TO_LONGS(indio_dev->masklength),
+			GFP_KERNEL);
+	BUG_ON(indio_dev->masklength == 0);
+	if (indio_dev->active_scan_mask == NULL) {
+		ret = -ENOMEM;
+		goto error_free_scan_mask;
+	}
 
 	buffer->scan_el_group.name = iio_scan_elements_group_name;
 
@@ -408,35 +430,88 @@ ssize_t iio_buffer_write_length(struct device *dev,
 }
 EXPORT_SYMBOL(iio_buffer_write_length);
 
-ssize_t iio_buffer_store_enable(struct device *dev,
-				struct device_attribute *attr,
-				const char *buf,
-				size_t len)
+static unsigned long *iio_scan_mask_match(unsigned long *av_masks,
+					  unsigned int masklength,
+					  unsigned long *mask)
+{
+	if (bitmap_empty(mask, masklength))
+		return NULL;
+	while (*av_masks) {
+		if (bitmap_subset(mask, av_masks, masklength))
+			return av_masks;
+		av_masks += BITS_TO_LONGS(masklength);
+	}
+	return NULL;
+}
+
+static int iio_update_buffers(struct iio_dev *indio_dev,
+			      struct iio_buffer *insert_buffer,
+			      struct iio_buffer *remove_buffer)
 {
 	int ret;
-	bool requested_state, current_state;
-	int previous_mode;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer;
+	unsigned long *compound_mask;
+/* Wind down existing buffers - iff there are any */
 
-	mutex_lock(&indio_dev->mlock);
-	previous_mode = indio_dev->currentmode;
-	requested_state = !(buf[0] == '0');
-	current_state = !!(previous_mode & INDIO_ALL_BUFFER_MODES);
-	if (current_state == requested_state) {
-		printk(KERN_INFO "iio-buffer, current state requested again\n");
-		goto done;
-	}
-	if (requested_state) {
-		if (indio_dev->setup_ops->preenable) {
-			ret = indio_dev->setup_ops->preenable(indio_dev);
-			if (ret) {
-				printk(KERN_ERR
-				       "Buffer not started:"
-				       "buffer preenable failed\n");
+	if (!list_empty(&indio_dev->buffer_list)) {
+		/* First predisable */
+		if (indio_dev->setup_ops->predisable) {
+			ret = indio_dev->setup_ops->predisable(indio_dev);
+			if (ret)
+				goto error_ret;
+		}
+		list_for_each_entry(buffer, &indio_dev->buffer_list,
+				    buffer_list)
+			if (buffer->access->unmark_in_use)
+				buffer->access->unmark_in_use(buffer);
+		indio_dev->currentmode = INDIO_DIRECT_MODE;
+		if (indio_dev->setup_ops->postdisable) {
+			ret = indio_dev->setup_ops->postdisable(indio_dev);
+			if (ret)
 				goto error_ret;
-			}
 		}
+	}
+	if (insert_buffer)
+		list_add(&insert_buffer->buffer_list, &indio_dev->buffer_list);
+	if (remove_buffer)
+		list_del(&remove_buffer->buffer_list);
+	/* If no buffers in list, we are done */
+	if (list_empty(&indio_dev->buffer_list))
+		return 0;
+
+	/* What scan mask do we actually have ?*/
+	compound_mask = kzalloc(BITS_TO_LONGS(indio_dev->masklength)
+				*sizeof(long), GFP_KERNEL);
+	if (compound_mask == NULL)
+		return -ENOMEM;
+	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
+		bitmap_or(compound_mask, compound_mask, buffer->scan_mask,
+			  indio_dev->masklength);
+		indio_dev->scan_timestamp |= buffer->scan_timestamp;
+	}
+	if (indio_dev->available_scan_masks) {
+		bitmap_copy(indio_dev->active_scan_mask,
+			    iio_scan_mask_match(indio_dev->available_scan_masks,
+						indio_dev->masklength,
+						compound_mask),
+			    indio_dev->masklength);
+	} else
+		bitmap_copy(indio_dev->active_scan_mask,
+			    compound_mask,
+			    indio_dev->masklength);
+	iio_update_demux(indio_dev);
+
+/* Wind up again */
+	if (indio_dev->setup_ops->preenable) {
+		ret = indio_dev->setup_ops->preenable(indio_dev);
+		if (ret) {
+			printk(KERN_ERR
+			       "Buffer not started:"
+			       "buffer preenable failed\n");
+			goto error_free_compound_mask;
+		}
+	}
+	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
 		if (buffer->access->request_update) {
 			ret = buffer->access->request_update(buffer);
 			if (ret) {
@@ -448,54 +523,96 @@ ssize_t iio_buffer_store_enable(struct device *dev,
 		}
 		if (buffer->access->mark_in_use)
 			buffer->access->mark_in_use(buffer);
-		/* Definitely possible for devices to support both of these.*/
-		if (indio_dev->modes & INDIO_BUFFER_TRIGGERED) {
-			if (!indio_dev->trig) {
-				printk(KERN_INFO
-				       "Buffer not started: no trigger\n");
-				ret = -EINVAL;
-				if (buffer->access->unmark_in_use)
-					buffer->access->unmark_in_use(buffer);
-				goto error_ret;
-			}
-			indio_dev->currentmode = INDIO_BUFFER_TRIGGERED;
-		} else if (indio_dev->modes & INDIO_BUFFER_HARDWARE)
-			indio_dev->currentmode = INDIO_BUFFER_HARDWARE;
-		else { /* should never be reached */
+	}
+	if (indio_dev->info->update_scan_mode) {
+		ret = indio_dev->info
+			->update_scan_mode(indio_dev,
+					   indio_dev->active_scan_mask);
+		if (ret < 0)
+			goto error_free_compound_mask;
+	}
+	/* Definitely possible for devices to support both of these.*/
+	if (indio_dev->modes & INDIO_BUFFER_TRIGGERED) {
+		if (!indio_dev->trig) {
+			printk(KERN_INFO
+			       "Buffer not started: no trigger\n");
 			ret = -EINVAL;
-			goto error_ret;
+			if (buffer->access->unmark_in_use)
+				buffer->access->unmark_in_use(buffer);
+			goto error_free_compound_mask;
 		}
+		indio_dev->currentmode = INDIO_BUFFER_TRIGGERED;
+	} else if (indio_dev->modes & INDIO_BUFFER_HARDWARE)
+		indio_dev->currentmode = INDIO_BUFFER_HARDWARE;
+	else { /* should never be reached */
+		ret = -EINVAL;
+		goto error_free_compound_mask;
+	}
 
-		if (indio_dev->setup_ops->postenable) {
-			ret = indio_dev->setup_ops->postenable(indio_dev);
-			if (ret) {
-				printk(KERN_INFO
-				       "Buffer not started:"
-				       "postenable failed\n");
+	if (indio_dev->setup_ops->postenable) {
+		ret = indio_dev->setup_ops->postenable(indio_dev);
+		if (ret) {
+			printk(KERN_INFO
+			       "Buffer not started:"
+			       "postenable failed\n");
+			list_for_each_entry(buffer, &indio_dev->buffer_list,
+					    buffer_list) {
 				if (buffer->access->unmark_in_use)
 					buffer->access->unmark_in_use(buffer);
-				indio_dev->currentmode = previous_mode;
+				indio_dev->currentmode = INDIO_DIRECT_MODE;
 				if (indio_dev->setup_ops->postdisable)
 					indio_dev->setup_ops->
 						postdisable(indio_dev);
-				goto error_ret;
+				goto error_free_compound_mask;
 			}
 		}
-	} else {
-		if (indio_dev->setup_ops->predisable) {
-			ret = indio_dev->setup_ops->predisable(indio_dev);
-			if (ret)
-				goto error_ret;
-		}
-		if (buffer->access->unmark_in_use)
-			buffer->access->unmark_in_use(buffer);
-		indio_dev->currentmode = INDIO_DIRECT_MODE;
-		if (indio_dev->setup_ops->postdisable) {
-			ret = indio_dev->setup_ops->postdisable(indio_dev);
-			if (ret)
-				goto error_ret;
-		}
 	}
+error_free_compound_mask:
+	kfree(compound_mask);
+error_ret:
+	return ret;
+}
+
+ssize_t iio_buffer_store_enable(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf,
+				size_t len)
+{
+	int ret;
+	bool requested_state;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_buffer *pbuf = indio_dev->buffer;
+	struct list_head *p;
+	bool inlist = false;
+
+	ret = strtobool(buf, &requested_state);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&indio_dev->mlock);
+
+	/* Find out if it is in the list */
+	list_for_each(p, &indio_dev->buffer_list)
+		if (p == &pbuf->buffer_list) {
+			inlist = true;
+			break;
+		}
+	/* Already enabled */
+	if (inlist && requested_state)
+		goto done;
+	/* Already disabled */
+	if (!inlist && !requested_state)
+		goto done;
+
+	if (requested_state)
+		ret = iio_update_buffers(indio_dev,
+					 indio_dev->buffer, NULL);
+	else
+		ret = iio_update_buffers(indio_dev,
+					 NULL, indio_dev->buffer);
+
+	if (ret < 0)
+		goto error_ret;
 done:
 	mutex_unlock(&indio_dev->mlock);
 	return len;
@@ -516,62 +633,36 @@ ssize_t iio_buffer_show_enable(struct device *dev,
 }
 EXPORT_SYMBOL(iio_buffer_show_enable);
 
-/* note NULL used as error indicator as it doesn't make sense. */
-static unsigned long *iio_scan_mask_match(unsigned long *av_masks,
-					  unsigned int masklength,
-					  unsigned long *mask)
-{
-	if (bitmap_empty(mask, masklength))
-		return NULL;
-	while (*av_masks) {
-		if (bitmap_subset(mask, av_masks, masklength))
-			return av_masks;
-		av_masks += BITS_TO_LONGS(masklength);
-	}
-	return NULL;
-}
-
 int iio_sw_buffer_preenable(struct iio_dev *indio_dev)
 {
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer;
 	const struct iio_chan_spec *ch;
 	unsigned bytes = 0;
 	int length, i;
 	dev_dbg(&indio_dev->dev, "%s\n", __func__);
 
-	/* How much space will the demuxed element take? */
-	for_each_set_bit(i, buffer->scan_mask,
-			 indio_dev->masklength) {
-		ch = iio_find_channel_from_si(indio_dev, i);
-		length = ch->scan_type.storagebits/8;
-		if (bytes % length)
-			bytes += length - bytes % length;
-		bytes += length;
-	}
-	if (buffer->scan_timestamp) {
-		ch = iio_find_channel_from_si(indio_dev,
-					      buffer->scan_index_timestamp);
-		length = ch->scan_type.storagebits/8;
-		if (bytes % length)
-			bytes += length - bytes % length;
-		bytes += length;
+	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
+		/* How much space will the demuxed element take? */
+		for_each_set_bit(i, buffer->scan_mask,
+				 indio_dev->masklength) {
+			ch = iio_find_channel_from_si(indio_dev, i);
+			length = ch->scan_type.storagebits / 8;
+			if (bytes % length)
+				bytes += length - bytes % length;
+			bytes += length;
+		}
+		if (buffer->scan_timestamp) {
+			ch = iio_find_channel_from_si(indio_dev,
+						      buffer->
+						      scan_index_timestamp);
+			length = ch->scan_type.storagebits / 8;
+			if (bytes % length)
+				bytes += length - bytes % length;
+			bytes += length;
+		}
+		if (buffer->access->set_bytes_per_datum)
+			buffer->access->set_bytes_per_datum(buffer, bytes);
 	}
-	buffer->access->set_bytes_per_datum(buffer, bytes);
-
-	/* What scan mask do we actually have ?*/
-	if (indio_dev->available_scan_masks)
-		indio_dev->active_scan_mask =
-			iio_scan_mask_match(indio_dev->available_scan_masks,
-					    indio_dev->masklength,
-					    buffer->scan_mask);
-	else
-		indio_dev->active_scan_mask = buffer->scan_mask;
-	iio_update_demux(indio_dev);
-
-	if (indio_dev->info->update_scan_mode)
-		return indio_dev->info
-			->update_scan_mode(indio_dev,
-					   indio_dev->active_scan_mask);
 	return 0;
 }
 EXPORT_SYMBOL(iio_sw_buffer_preenable);
@@ -598,6 +689,7 @@ int iio_scan_mask_set(struct iio_buffer *buffer, int bit)
 		kfree(trialmask);
 		return -EINVAL;
 	}
+	///* Possible this needs updating */
 	bitmap_copy(trialmask, buffer->scan_mask, indio_dev->masklength);
 	set_bit(bit, trialmask);
 
@@ -610,8 +702,7 @@ int iio_scan_mask_set(struct iio_buffer *buffer, int bit)
 			return -EINVAL;
 		}
 	}
-	bitmap_copy(buffer->scan_mask, trialmask, indio_dev->masklength);
-	buffer->scan_count++;
+	set_bit(bit, buffer->scan_mask);
 
 	kfree(trialmask);
 
@@ -662,7 +753,7 @@ static unsigned char * iio_demux(struct iio_buffer *buffer,
 	struct iio_demux_table *t;
 
 	if (list_empty(&buffer->demux_list))
-	    return datain;
+		return datain;
 	list_for_each_entry(t, &buffer->demux_list, l)
 		memcpy(buffer->demux_bounce + t->to,
 		       datain + t->from, t->length);
@@ -679,98 +770,125 @@ int iio_push_to_buffer(struct iio_buffer *buffer, unsigned char *data,
 }
 EXPORT_SYMBOL_GPL(iio_push_to_buffer);
 
+
+int iio_push_to_buffers(struct iio_dev *indio_dev, unsigned char *data,
+			s64 timestamp)
+{
+	int ret;
+	struct iio_buffer *buf;
+	list_for_each_entry(buf, &indio_dev->buffer_list, buffer_list) {
+		ret = iio_push_to_buffer(buf, data, timestamp);
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iio_push_to_buffers);
+
 int iio_update_demux(struct iio_dev *indio_dev)
 {
 	const struct iio_chan_spec *ch;
-	struct iio_buffer *buffer = indio_dev->buffer;
-	int ret, in_ind = -1, out_ind, length;
-	unsigned in_loc = 0, out_loc = 0;
+	struct iio_buffer *buffer;
 	struct iio_demux_table *p, *q;
+	int ret;
 
-	/* Clear out any old demux */
-	list_for_each_entry_safe(p, q, &buffer->demux_list, l) {
-		list_del(&p->l);
-		kfree(p);
-	}
-	kfree(buffer->demux_bounce);
-	buffer->demux_bounce = NULL;
+	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
+		unsigned in_loc = 0, out_loc = 0;
+		int in_ind = -1, out_ind, length;
 
-	/* First work out which scan mode we will actually have */
-	if (bitmap_equal(indio_dev->active_scan_mask,
-			 buffer->scan_mask,
-			 indio_dev->masklength))
-		return 0;
+		/* Clear out any old demux */
+		list_for_each_entry_safe(p, q, &buffer->demux_list, l) {
+			list_del(&p->l);
+			kfree(p);
+		}
+		kfree(buffer->demux_bounce);
+		buffer->demux_bounce = NULL;
 
-	out_ind = find_first_bit(buffer->scan_mask, indio_dev->masklength);
-	/* Now we have the two masks, work from least sig and build up sizes */
-	while (out_ind != indio_dev->masklength) {
-		in_ind = find_next_bit(indio_dev->active_scan_mask,
-				       indio_dev->masklength,
-				       in_ind + 1);
-		while (in_ind != out_ind) {
+		/* First work out which scan mode we will actually have */
+		if (bitmap_equal(indio_dev->active_scan_mask,
+				 buffer->scan_mask,
+				 indio_dev->masklength))
+			return 0;
+		out_ind = find_first_bit(buffer->scan_mask,
+					 indio_dev->masklength);
+		/*
+		 * Now we have the two masks, work from least sig
+		 * and build up sizes
+		 */
+		while (out_ind != indio_dev->masklength) {
 			in_ind = find_next_bit(indio_dev->active_scan_mask,
 					       indio_dev->masklength,
 					       in_ind + 1);
+			while (in_ind != out_ind) {
+				in_ind = find_next_bit(indio_dev->
+						       active_scan_mask,
+						       indio_dev->masklength,
+						       in_ind + 1);
+				ch = iio_find_channel_from_si(indio_dev,
+							      in_ind);
+				length = ch->scan_type.storagebits/8;
+				/* Make sure we are aligned */
+				in_loc += length;
+				if (in_loc % length)
+					in_loc += length - in_loc % length;
+			}
+			p = kmalloc(sizeof(*p), GFP_KERNEL);
+			if (p == NULL) {
+				ret = -ENOMEM;
+				goto error_clear_mux_table;
+			}
 			ch = iio_find_channel_from_si(indio_dev, in_ind);
 			length = ch->scan_type.storagebits/8;
-			/* Make sure we are aligned */
-			in_loc += length;
+			if (out_loc % length)
+				out_loc += length - out_loc % length;
 			if (in_loc % length)
 				in_loc += length - in_loc % length;
+			p->from = in_loc;
+			p->to = out_loc;
+			p->length = length;
+			list_add_tail(&p->l, &buffer->demux_list);
+			out_loc += length;
+			in_loc += length;
+			out_ind = find_next_bit(buffer->scan_mask,
+						indio_dev->masklength,
+						out_ind + 1);
 		}
-		p = kmalloc(sizeof(*p), GFP_KERNEL);
-		if (p == NULL) {
-			ret = -ENOMEM;
-			goto error_clear_mux_table;
+		/* Relies on scan_timestamp being last */
+		if (buffer->scan_timestamp) {
+			p = kmalloc(sizeof(*p), GFP_KERNEL);
+			if (p == NULL) {
+				ret = -ENOMEM;
+				goto error_clear_mux_table;
+			}
+			ch = iio_find_channel_from_si(indio_dev,
+						      buffer->
+						      scan_index_timestamp);
+			length = ch->scan_type.storagebits/8;
+			if (out_loc % length)
+				out_loc += length - out_loc % length;
+			if (in_loc % length)
+				in_loc += length - in_loc % length;
+			p->from = in_loc;
+			p->to = out_loc;
+			p->length = length;
+			list_add_tail(&p->l, &buffer->demux_list);
+			out_loc += length;
+			in_loc += length;
 		}
-		ch = iio_find_channel_from_si(indio_dev, in_ind);
-		length = ch->scan_type.storagebits/8;
-		if (out_loc % length)
-			out_loc += length - out_loc % length;
-		if (in_loc % length)
-			in_loc += length - in_loc % length;
-		p->from = in_loc;
-		p->to = out_loc;
-		p->length = length;
-		list_add_tail(&p->l, &buffer->demux_list);
-		out_loc += length;
-		in_loc += length;
-		out_ind = find_next_bit(buffer->scan_mask,
-					indio_dev->masklength,
-					out_ind + 1);
-	}
-	/* Relies on scan_timestamp being last */
-	if (buffer->scan_timestamp) {
-		p = kmalloc(sizeof(*p), GFP_KERNEL);
-		if (p == NULL) {
+		buffer->demux_bounce = kzalloc(out_loc, GFP_KERNEL);
+		if (buffer->demux_bounce == NULL) {
 			ret = -ENOMEM;
 			goto error_clear_mux_table;
 		}
-		ch = iio_find_channel_from_si(indio_dev,
-			buffer->scan_index_timestamp);
-		length = ch->scan_type.storagebits/8;
-		if (out_loc % length)
-			out_loc += length - out_loc % length;
-		if (in_loc % length)
-			in_loc += length - in_loc % length;
-		p->from = in_loc;
-		p->to = out_loc;
-		p->length = length;
-		list_add_tail(&p->l, &buffer->demux_list);
-		out_loc += length;
-		in_loc += length;
-	}
-	buffer->demux_bounce = kzalloc(out_loc, GFP_KERNEL);
-	if (buffer->demux_bounce == NULL) {
-		ret = -ENOMEM;
-		goto error_clear_mux_table;
 	}
 	return 0;
 
 error_clear_mux_table:
-	list_for_each_entry_safe(p, q, &buffer->demux_list, l) {
-		list_del(&p->l);
-		kfree(p);
+	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
+		list_for_each_entry_safe(p, q, &buffer->demux_list, l) {
+			list_del(&p->l);
+			kfree(p);
+		}
 	}
 	return ret;
 }
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 69c4c98b..29b7902 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -1313,6 +1313,7 @@ struct iio_dev *iio_allocate_device(int sizeof_priv)
 			return NULL;
 		}
 		dev_set_name(&dev->dev, "iio:device%d", dev->id);
+		INIT_LIST_HEAD(&dev->buffer_list);
 	}
 
 	return dev;
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index 254fd69..1d7a6f6 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -61,7 +61,6 @@ static irqreturn_t ade7758_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	struct iio_buffer *ring = indio_dev->buffer;
 	struct ade7758_state *st = iio_priv(indio_dev);
 	s64 dat64[2];
 	u32 *dat32 = (u32 *)dat64;
@@ -71,10 +70,10 @@ static irqreturn_t ade7758_trigger_handler(int irq, void *p)
 			*dat32 = get_unaligned_be32(&st->rx_buf[5]) & 0xFFFFFF;
 
 	/* Guaranteed to be aligned with 8 byte boundary */
-	if (ring->scan_timestamp)
+	if (indio_dev->scan_timestamp)
 		dat64[1] = pf->timestamp;
 
-	ring->access->store_to(ring, (u8 *)dat64, pf->timestamp);
+	iio_push_to_buffers(indio_dev, (u8 *)dat64, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 
@@ -91,28 +90,26 @@ static irqreturn_t ade7758_trigger_handler(int irq, void *p)
 static int ade7758_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct ade7758_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
+	struct iio_buffer *buffer;
 	size_t d_size;
 	unsigned channel;
 
 	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
 		return -EINVAL;
 
-	channel = find_first_bit(indio_dev->active_scan_mask,
-				 indio_dev->masklength);
-
-	d_size = st->ade7758_ring_channels[channel].scan_type.storagebits / 8;
-
-	if (ring->scan_timestamp) {
-		d_size += sizeof(s64);
+	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
+		d_size = st->ade7758_ring_channels[0].scan_type.storagebits / 8;
+		if (buffer->scan_timestamp) {
+			d_size += sizeof(s64);
+			if (d_size % sizeof(s64))
+				d_size += sizeof(s64) - (d_size % sizeof(s64));
+		}
 
-		if (d_size % sizeof(s64))
-			d_size += sizeof(s64) - (d_size % sizeof(s64));
+		if (buffer->access->set_bytes_per_datum)
+			buffer->access->set_bytes_per_datum(buffer, d_size);
 	}
-
-	if (indio_dev->buffer->access->set_bytes_per_datum)
-		indio_dev->buffer->access->
-			set_bytes_per_datum(indio_dev->buffer, d_size);
+	channel = find_first_bit(indio_dev->active_scan_mask,
+				 indio_dev->masklength);
 
 	ade7758_write_waveform_type(&indio_dev->dev,
 		st->ade7758_ring_channels[channel].address);
-- 
1.7.7

