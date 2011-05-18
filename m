Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:54135 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933256Ab1ERNkJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 May 2011 09:40:09 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 094/111] staging:iio: rationalization of different buffer implementation hooks.
Date: Wed, 18 May 2011 14:42:24 +0100
Message-Id: <1305726161-5606-95-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

1) move a generic helper function out of ring_sw. It applies to other buffers as well.
2) Get rid of a lot of left over function definitions.
3) Move all the access functions into static structures.
4) Introduce and use a static structure for the setup functions, preenable etc.

Some driver conversions thanks to Michael Hennerich (pulled out of patches
that would otherwise sit after this).

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16201_ring.c |   16 ++-
 drivers/staging/iio/accel/adis16203_ring.c |   16 ++-
 drivers/staging/iio/accel/adis16204_ring.c |   16 ++-
 drivers/staging/iio/accel/adis16209_ring.c |   16 ++-
 drivers/staging/iio/accel/adis16240_ring.c |   16 ++-
 drivers/staging/iio/accel/lis3l02dq.h      |    4 +-
 drivers/staging/iio/accel/lis3l02dq_ring.c |   15 ++-
 drivers/staging/iio/accel/sca3000_ring.c   |   19 ++-
 drivers/staging/iio/adc/ad7298_ring.c      |   23 ++--
 drivers/staging/iio/adc/ad7476_ring.c      |   25 +++--
 drivers/staging/iio/adc/ad7606_ring.c      |   23 ++--
 drivers/staging/iio/adc/ad7887_ring.c      |   27 +++--
 drivers/staging/iio/adc/ad799x_ring.c      |   24 ++--
 drivers/staging/iio/adc/max1363_ring.c     |   26 +++--
 drivers/staging/iio/gyro/adis16260_ring.c  |   16 ++-
 drivers/staging/iio/imu/adis16400_ring.c   |   16 ++-
 drivers/staging/iio/industrialio-ring.c    |   99 ++++++++++------
 drivers/staging/iio/kfifo_buf.c            |   58 ++++++----
 drivers/staging/iio/kfifo_buf.h            |   39 +------
 drivers/staging/iio/meter/ade7758_ring.c   |   18 ++-
 drivers/staging/iio/ring_generic.h         |   18 ++-
 drivers/staging/iio/ring_sw.c              |  120 +++++++++++---------
 drivers/staging/iio/ring_sw.h              |  176 +---------------------------
 23 files changed, 363 insertions(+), 463 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_ring.c b/drivers/staging/iio/accel/adis16201_ring.c
index 5405a38..83b5336 100644
--- a/drivers/staging/iio/accel/adis16201_ring.c
+++ b/drivers/staging/iio/accel/adis16201_ring.c
@@ -68,7 +68,7 @@ static irqreturn_t adis16201_trigger_handler(int irq, void *p)
 
 	int i = 0;
 	s16 *data;
-	size_t datasize = ring->access.get_bytes_per_datum(ring);
+	size_t datasize = ring->access->get_bytes_per_datum(ring);
 
 	data = kmalloc(datasize, GFP_KERNEL);
 	if (data == NULL) {
@@ -86,7 +86,7 @@ static irqreturn_t adis16201_trigger_handler(int irq, void *p)
 	if (ring->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
 
-	ring->access.store_to(ring, (u8 *)data, pf->timestamp);
+	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
 
 	iio_trigger_notify_done(st->indio_dev->trig);
 	kfree(data);
@@ -101,6 +101,12 @@ void adis16201_unconfigure_ring(struct iio_dev *indio_dev)
 	iio_sw_rb_free(indio_dev->ring);
 }
 
+static const struct iio_ring_setup_ops adis16201_ring_setup_ops = {
+	.preenable = &iio_sw_ring_preenable,
+	.postenable = &iio_triggered_ring_postenable,
+	.predisable = &iio_triggered_ring_predisable,
+};
+
 int adis16201_configure_ring(struct iio_dev *indio_dev)
 {
 	int ret = 0;
@@ -113,12 +119,10 @@ int adis16201_configure_ring(struct iio_dev *indio_dev)
 	}
 	indio_dev->ring = ring;
 	/* Effectively select the ring buffer implementation */
-	iio_ring_sw_register_funcs(&ring->access);
 	ring->bpe = 2;
 	ring->scan_timestamp = true;
-	ring->preenable = &iio_sw_ring_preenable;
-	ring->postenable = &iio_triggered_ring_postenable;
-	ring->predisable = &iio_triggered_ring_predisable;
+	ring->access = &ring_sw_access_funcs;
+	ring->setup_ops = &adis16201_ring_setup_ops;
 	ring->owner = THIS_MODULE;
 
 	/* Set default scan mode */
diff --git a/drivers/staging/iio/accel/adis16203_ring.c b/drivers/staging/iio/accel/adis16203_ring.c
index a21a71d..1b8863d 100644
--- a/drivers/staging/iio/accel/adis16203_ring.c
+++ b/drivers/staging/iio/accel/adis16203_ring.c
@@ -73,7 +73,7 @@ static irqreturn_t adis16203_trigger_handler(int irq, void *p)
 
 	int i = 0;
 	s16 *data;
-	size_t datasize = ring->access.get_bytes_per_datum(ring);
+	size_t datasize = ring->access->get_bytes_per_datum(ring);
 
 	data = kmalloc(datasize, GFP_KERNEL);
 	if (data == NULL) {
@@ -91,7 +91,7 @@ static irqreturn_t adis16203_trigger_handler(int irq, void *p)
 	if (ring->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
 
-	ring->access.store_to(ring,
+	ring->access->store_to(ring,
 			      (u8 *)data,
 			      pf->timestamp);
 
@@ -108,6 +108,12 @@ void adis16203_unconfigure_ring(struct iio_dev *indio_dev)
 	iio_sw_rb_free(indio_dev->ring);
 }
 
+static const struct iio_ring_setup_ops adis16203_ring_setup_ops = {
+	.preenable = &iio_sw_ring_preenable,
+	.postenable = &iio_triggered_ring_postenable,
+	.predisable = &iio_triggered_ring_predisable,
+};
+
 int adis16203_configure_ring(struct iio_dev *indio_dev)
 {
 	int ret = 0;
@@ -120,12 +126,10 @@ int adis16203_configure_ring(struct iio_dev *indio_dev)
 	}
 	indio_dev->ring = ring;
 	/* Effectively select the ring buffer implementation */
-	iio_ring_sw_register_funcs(&ring->access);
 	ring->bpe = 2;
 	ring->scan_timestamp = true;
-	ring->preenable = &iio_sw_ring_preenable;
-	ring->postenable = &iio_triggered_ring_postenable;
-	ring->predisable = &iio_triggered_ring_predisable;
+	ring->access = &ring_sw_access_funcs;
+	ring->setup_ops = &adis16203_ring_setup_ops;
 	ring->owner = THIS_MODULE;
 
 	/* Set default scan mode */
diff --git a/drivers/staging/iio/accel/adis16204_ring.c b/drivers/staging/iio/accel/adis16204_ring.c
index 50cd073..7d99b48 100644
--- a/drivers/staging/iio/accel/adis16204_ring.c
+++ b/drivers/staging/iio/accel/adis16204_ring.c
@@ -70,7 +70,7 @@ static irqreturn_t adis16204_trigger_handler(int irq, void *p)
 	struct iio_ring_buffer *ring = indio_dev->ring;
 	int i = 0;
 	s16 *data;
-	size_t datasize = ring->access.get_bytes_per_datum(ring);
+	size_t datasize = ring->access->get_bytes_per_datum(ring);
 
 	data = kmalloc(datasize, GFP_KERNEL);
 	if (data == NULL) {
@@ -88,7 +88,7 @@ static irqreturn_t adis16204_trigger_handler(int irq, void *p)
 	if (ring->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
 
-	ring->access.store_to(ring, (u8 *)data, pf->timestamp);
+	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
 
 	iio_trigger_notify_done(st->indio_dev->trig);
 	kfree(data);
@@ -103,6 +103,12 @@ void adis16204_unconfigure_ring(struct iio_dev *indio_dev)
 	iio_sw_rb_free(indio_dev->ring);
 }
 
+static const struct iio_ring_setup_ops adis16204_ring_setup_ops = {
+	.preenable = &iio_sw_ring_preenable,
+	.postenable = &iio_triggered_ring_postenable,
+	.predisable = &iio_triggered_ring_predisable,
+};
+
 int adis16204_configure_ring(struct iio_dev *indio_dev)
 {
 	int ret = 0;
@@ -115,12 +121,10 @@ int adis16204_configure_ring(struct iio_dev *indio_dev)
 	}
 	indio_dev->ring = ring;
 	/* Effectively select the ring buffer implementation */
-	iio_ring_sw_register_funcs(&ring->access);
+	ring->access = &ring_sw_access_funcs;
 	ring->bpe = 2;
 	ring->scan_timestamp = true;
-	ring->preenable = &iio_sw_ring_preenable;
-	ring->postenable = &iio_triggered_ring_postenable;
-	ring->predisable = &iio_triggered_ring_predisable;
+	ring->setup_ops = &adis16204_ring_setup_ops;
 	ring->owner = THIS_MODULE;
 
 	/* Set default scan mode */
diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index 2c7be3b..26028e9 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -71,7 +71,7 @@ static irqreturn_t adis16209_trigger_handler(int irq, void *p)
 
 	int i = 0;
 	s16 *data;
-	size_t datasize = ring->access.get_bytes_per_datum(ring);
+	size_t datasize = ring->access->get_bytes_per_datum(ring);
 
 	data = kmalloc(datasize , GFP_KERNEL);
 	if (data == NULL) {
@@ -88,7 +88,7 @@ static irqreturn_t adis16209_trigger_handler(int irq, void *p)
 	if (ring->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
 
-	ring->access.store_to(ring, (u8 *)data, pf->timestamp);
+	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
 
 	iio_trigger_notify_done(st->indio_dev->trig);
 	kfree(data);
@@ -103,6 +103,12 @@ void adis16209_unconfigure_ring(struct iio_dev *indio_dev)
 	iio_sw_rb_free(indio_dev->ring);
 }
 
+static const struct iio_ring_setup_ops adis16209_ring_setup_ops = {
+	.preenable = &iio_sw_ring_preenable,
+	.postenable = &iio_triggered_ring_postenable,
+	.predisable = &iio_triggered_ring_predisable,
+};
+
 int adis16209_configure_ring(struct iio_dev *indio_dev)
 {
 	int ret = 0;
@@ -115,12 +121,10 @@ int adis16209_configure_ring(struct iio_dev *indio_dev)
 	}
 	indio_dev->ring = ring;
 	/* Effectively select the ring buffer implementation */
-	iio_ring_sw_register_funcs(&ring->access);
+	ring->access = &ring_sw_access_funcs;
 	ring->bpe = 2;
 	ring->scan_timestamp = true;
-	ring->preenable = &iio_sw_ring_preenable;
-	ring->postenable = &iio_triggered_ring_postenable;
-	ring->predisable = &iio_triggered_ring_predisable;
+	ring->setup_ops = &adis16209_ring_setup_ops;
 	ring->owner = THIS_MODULE;
 
 	/* Set default scan mode */
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index bddd699..8450f7f 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -68,7 +68,7 @@ static irqreturn_t adis16240_trigger_handler(int irq, void *p)
 
 	int i = 0;
 	s16 *data;
-	size_t datasize = ring->access.get_bytes_per_datum(ring);
+	size_t datasize = ring->access->get_bytes_per_datum(ring);
 
 	data = kmalloc(datasize, GFP_KERNEL);
 	if (data == NULL) {
@@ -85,7 +85,7 @@ static irqreturn_t adis16240_trigger_handler(int irq, void *p)
 	if (ring->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
 
-	ring->access.store_to(ring, (u8 *)data, pf->timestamp);
+	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
 
 	iio_trigger_notify_done(st->indio_dev->trig);
 	kfree(data);
@@ -100,6 +100,12 @@ void adis16240_unconfigure_ring(struct iio_dev *indio_dev)
 	iio_sw_rb_free(indio_dev->ring);
 }
 
+static const struct iio_ring_setup_ops adis16240_ring_setup_ops = {
+	.preenable = &iio_sw_ring_preenable,
+	.postenable = &iio_triggered_ring_postenable,
+	.predisable = &iio_triggered_ring_predisable,
+};
+
 int adis16240_configure_ring(struct iio_dev *indio_dev)
 {
 	int ret = 0;
@@ -112,12 +118,10 @@ int adis16240_configure_ring(struct iio_dev *indio_dev)
 	}
 	indio_dev->ring = ring;
 	/* Effectively select the ring buffer implementation */
-	iio_ring_sw_register_funcs(&ring->access);
+	ring->access = &ring_sw_access_funcs;
 	ring->bpe = 2;
 	ring->scan_timestamp = true;
-	ring->preenable = &iio_sw_ring_preenable;
-	ring->postenable = &iio_triggered_ring_postenable;
-	ring->predisable = &iio_triggered_ring_predisable;
+	ring->setup_ops = &adis16240_ring_setup_ops;
 	ring->owner = THIS_MODULE;
 
 	/* Set default scan mode */
diff --git a/drivers/staging/iio/accel/lis3l02dq.h b/drivers/staging/iio/accel/lis3l02dq.h
index 3f1d7c6..43277d1 100644
--- a/drivers/staging/iio/accel/lis3l02dq.h
+++ b/drivers/staging/iio/accel/lis3l02dq.h
@@ -196,12 +196,12 @@ void lis3l02dq_unconfigure_ring(struct iio_dev *indio_dev);
 #ifdef CONFIG_LIS3L02DQ_BUF_RING_SW
 #define lis3l02dq_free_buf iio_sw_rb_free
 #define lis3l02dq_alloc_buf iio_sw_rb_allocate
-#define lis3l02dq_register_buf_funcs iio_ring_sw_register_funcs
+#define lis3l02dq_access_funcs ring_sw_access_funcs
 #endif
 #ifdef CONFIG_LIS3L02DQ_BUF_KFIFO
 #define lis3l02dq_free_buf iio_kfifo_free
 #define lis3l02dq_alloc_buf iio_kfifo_allocate
-#define lis3l02dq_register_buf_funcs iio_kfifo_register_funcs
+#define lis3l02dq_access_funcs kfifo_access_funcs
 #endif
 irqreturn_t lis3l02dq_data_rdy_trig_poll(int irq, void *private);
 #define lis3l02dq_th lis3l02dq_data_rdy_trig_poll
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 2b7219b..ab11e52 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -54,12 +54,12 @@ ssize_t lis3l02dq_read_accel_from_ring(struct iio_ring_buffer *ring,
 	if (!iio_scan_mask_query(ring, index))
 		return -EINVAL;
 
-	data = kmalloc(ring->access.get_bytes_per_datum(ring),
+	data = kmalloc(ring->access->get_bytes_per_datum(ring),
 		       GFP_KERNEL);
 	if (data == NULL)
 		return -ENOMEM;
 
-	ret = ring->access.read_last(ring, (u8 *)data);
+	ret = ring->access->read_last(ring, (u8 *)data);
 	if (ret)
 		goto error_free_data;
 	*val = data[iio_scan_mask_count_to_right(ring, index)];
@@ -400,6 +400,11 @@ error_ret:
 	return ret;
 }
 
+static const struct iio_ring_setup_ops lis3l02dq_ring_setup_ops = {
+	.preenable = &iio_sw_ring_preenable,
+	.postenable = &lis3l02dq_ring_postenable,
+	.predisable = &lis3l02dq_ring_predisable,
+};
 
 int lis3l02dq_configure_ring(struct iio_dev *indio_dev)
 {
@@ -415,13 +420,11 @@ int lis3l02dq_configure_ring(struct iio_dev *indio_dev)
 
 	indio_dev->ring = ring;
 	/* Effectively select the ring buffer implementation */
-	lis3l02dq_register_buf_funcs(&ring->access);
+	indio_dev->ring->access = &lis3l02dq_access_funcs;
 	ring->bpe = 2;
 
 	ring->scan_timestamp = true;
-	ring->preenable = &iio_sw_ring_preenable;
-	ring->postenable = &lis3l02dq_ring_postenable;
-	ring->predisable = &lis3l02dq_ring_predisable;
+	ring->setup_ops = &lis3l02dq_ring_setup_ops;
 	ring->owner = THIS_MODULE;
 
 	/* Set default scan mode */
diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
index d3c3789..7c4ff0b 100644
--- a/drivers/staging/iio/accel/sca3000_ring.c
+++ b/drivers/staging/iio/accel/sca3000_ring.c
@@ -367,6 +367,12 @@ static inline void sca3000_rb_free(struct iio_ring_buffer *r)
 		iio_put_ring_buffer(r);
 }
 
+static const struct iio_ring_access_funcs sca3000_ring_access_funcs = {
+	.read_first_n = &sca3000_read_first_n_hw_rb,
+	.get_length = &sca3000_ring_get_length,
+	.get_bytes_per_datum = &sca3000_ring_get_bytes_per_datum,
+};
+
 int sca3000_configure_ring(struct iio_dev *indio_dev)
 {
 	indio_dev->ring = sca3000_rb_allocate(indio_dev);
@@ -374,10 +380,7 @@ int sca3000_configure_ring(struct iio_dev *indio_dev)
 		return -ENOMEM;
 	indio_dev->modes |= INDIO_RING_HARDWARE_BUFFER;
 
-	indio_dev->ring->access.read_first_n = &sca3000_read_first_n_hw_rb;
-	indio_dev->ring->access.get_length = &sca3000_ring_get_length;
-	indio_dev->ring->access.get_bytes_per_datum =
-		&sca3000_ring_get_bytes_per_datum;
+	indio_dev->ring->access = &sca3000_ring_access_funcs;
 
 	iio_scan_mask_set(indio_dev->ring, 0);
 	iio_scan_mask_set(indio_dev->ring, 1);
@@ -432,10 +435,14 @@ static int sca3000_hw_ring_postdisable(struct iio_dev *indio_dev)
 	return __sca3000_hw_ring_state_set(indio_dev, 0);
 }
 
+static const struct iio_ring_setup_ops sca3000_ring_setup_ops = {
+	.preenable = &sca3000_hw_ring_preenable,
+	.postdisable = &sca3000_hw_ring_postdisable,
+};
+
 void sca3000_register_ring_funcs(struct iio_dev *indio_dev)
 {
-	indio_dev->ring->preenable = &sca3000_hw_ring_preenable;
-	indio_dev->ring->postdisable = &sca3000_hw_ring_postdisable;
+	indio_dev->ring->setup_ops = &sca3000_ring_setup_ops;
 }
 
 /**
diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
index d3251f7..09b1477 100644
--- a/drivers/staging/iio/adc/ad7298_ring.c
+++ b/drivers/staging/iio/adc/ad7298_ring.c
@@ -32,13 +32,13 @@ int ad7298_scan_from_ring(struct ad7298_state *st, long ch)
 		goto error_ret;
 	}
 
-	ring_data = kmalloc(ring->access.get_bytes_per_datum(ring),
+	ring_data = kmalloc(ring->access->get_bytes_per_datum(ring),
 			    GFP_KERNEL);
 	if (ring_data == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-	ret = ring->access.read_last(ring, (u8 *) ring_data);
+	ret = ring->access->read_last(ring, (u8 *) ring_data);
 	if (ret)
 		goto error_free_ring_data;
 
@@ -74,8 +74,8 @@ static int ad7298_ring_preenable(struct iio_dev *indio_dev)
 			d_size += sizeof(s64) - (d_size % sizeof(s64));
 	}
 
-	if (ring->access.set_bytes_per_datum)
-		ring->access.set_bytes_per_datum(ring, d_size);
+	if (ring->access->set_bytes_per_datum)
+		ring->access->set_bytes_per_datum(ring, d_size);
 
 	st->d_size = d_size;
 
@@ -140,12 +140,18 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
 	for (i = 0; i < ring->scan_count; i++)
 		buf[i] = be16_to_cpu(st->rx_buf[i]);
 
-	indio_dev->ring->access.store_to(ring, (u8 *)buf, time_ns);
+	indio_dev->ring->access->store_to(ring, (u8 *)buf, time_ns);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
 }
 
+static const struct iio_ring_setup_ops ad7298_ring_setup_ops = {
+	.preenable = &ad7298_ring_preenable,
+	.postenable = &iio_triggered_ring_postenable,
+	.predisable = &iio_triggered_ring_predisable,
+};
+
 int ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 {
 	int ret;
@@ -156,7 +162,7 @@ int ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 		goto error_ret;
 	}
 	/* Effectively select the ring buffer implementation */
-	iio_ring_sw_register_funcs(&indio_dev->ring->access);
+	indio_dev->ring->access = &ring_sw_access_funcs;
 
 	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
 	if (indio_dev->pollfunc == NULL) {
@@ -173,10 +179,7 @@ int ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 		goto error_free_poll_func;
 	}
 	/* Ring buffer functions - here trigger setup related */
-	indio_dev->ring->preenable = &ad7298_ring_preenable;
-	indio_dev->ring->postenable = &iio_triggered_ring_postenable;
-	indio_dev->ring->predisable = &iio_triggered_ring_predisable;
-
+	indio_dev->ring->setup_ops = &ad7298_ring_setup_ops;
 	indio_dev->ring->scan_timestamp = true;
 
 	/* Flag that polled ring buffering is possible */
diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
index ec1fa14..1d696ef 100644
--- a/drivers/staging/iio/adc/ad7476_ring.c
+++ b/drivers/staging/iio/adc/ad7476_ring.c
@@ -28,12 +28,13 @@ int ad7476_scan_from_ring(struct ad7476_state *st)
 	int ret;
 	u8 *ring_data;
 
-	ring_data = kmalloc(ring->access.get_bytes_per_datum(ring), GFP_KERNEL);
+	ring_data = kmalloc(ring->access->get_bytes_per_datum(ring),
+			    GFP_KERNEL);
 	if (ring_data == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-	ret = ring->access.read_last(ring, ring_data);
+	ret = ring->access->read_last(ring, ring_data);
 	if (ret)
 		goto error_free_ring_data;
 
@@ -67,8 +68,8 @@ static int ad7476_ring_preenable(struct iio_dev *indio_dev)
 			st->d_size += sizeof(s64) - (st->d_size % sizeof(s64));
 	}
 
-	if (indio_dev->ring->access.set_bytes_per_datum)
-		indio_dev->ring->access.set_bytes_per_datum(indio_dev->ring,
+	if (indio_dev->ring->access->set_bytes_per_datum)
+		indio_dev->ring->access->set_bytes_per_datum(indio_dev->ring,
 							    st->d_size);
 
 	return 0;
@@ -79,7 +80,6 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->private_data;
 	struct ad7476_state *st = iio_dev_get_devdata(indio_dev);
-	struct iio_sw_ring_buffer *sw_ring = iio_to_sw_ring(indio_dev->ring);
 	s64 time_ns;
 	__u8 *rxbuf;
 	int b_sent;
@@ -99,7 +99,7 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
 		memcpy(rxbuf + st->d_size - sizeof(s64),
 			&time_ns, sizeof(time_ns));
 
-	indio_dev->ring->access.store_to(&sw_ring->buf, rxbuf, time_ns);
+	indio_dev->ring->access->store_to(indio_dev->ring, rxbuf, time_ns);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 	kfree(rxbuf);
@@ -107,6 +107,12 @@ done:
 	return IRQ_HANDLED;
 }
 
+static const struct iio_ring_setup_ops ad7476_ring_setup_ops = {
+	.preenable = &ad7476_ring_preenable,
+	.postenable = &iio_triggered_ring_postenable,
+	.predisable = &iio_triggered_ring_predisable,
+};
+
 int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 {
 	struct ad7476_state *st = indio_dev->dev_data;
@@ -118,7 +124,7 @@ int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 		goto error_ret;
 	}
 	/* Effectively select the ring buffer implementation */
-	iio_ring_sw_register_funcs(&indio_dev->ring->access);
+	indio_dev->ring->access = &ring_sw_access_funcs;
 	indio_dev->pollfunc = kzalloc(sizeof(indio_dev->pollfunc), GFP_KERNEL);
 	if (indio_dev->pollfunc == NULL) {
 		ret = -ENOMEM;
@@ -137,10 +143,7 @@ int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	}
 
 	/* Ring buffer functions - here trigger setup related */
-
-	indio_dev->ring->preenable = &ad7476_ring_preenable;
-	indio_dev->ring->postenable = &iio_triggered_ring_postenable;
-	indio_dev->ring->predisable = &iio_triggered_ring_predisable;
+	indio_dev->ring->setup_ops = &ad7476_ring_setup_ops;
 	indio_dev->ring->scan_timestamp = true;
 
 	/* Flag that polled ring buffering is possible */
diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index 351d58e..925806c 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -27,13 +27,13 @@ int ad7606_scan_from_ring(struct ad7606_state *st, unsigned ch)
 	int ret;
 	u16 *ring_data;
 
-	ring_data = kmalloc(ring->access.get_bytes_per_datum(ring),
+	ring_data = kmalloc(ring->access->get_bytes_per_datum(ring),
 			    GFP_KERNEL);
 	if (ring_data == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-	ret = ring->access.read_last(ring, (u8 *) ring_data);
+	ret = ring->access->read_last(ring, (u8 *) ring_data);
 	if (ret)
 		goto error_free_ring_data;
 
@@ -68,8 +68,8 @@ static int ad7606_ring_preenable(struct iio_dev *indio_dev)
 			d_size += sizeof(s64) - (d_size % sizeof(s64));
 	}
 
-	if (ring->access.set_bytes_per_datum)
-		ring->access.set_bytes_per_datum(ring, d_size);
+	if (ring->access->set_bytes_per_datum)
+		ring->access->set_bytes_per_datum(ring, d_size);
 
 	st->d_size = d_size;
 
@@ -105,7 +105,6 @@ static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
 	struct ad7606_state *st = container_of(work_s, struct ad7606_state,
 						poll_work);
 	struct iio_dev *indio_dev = iio_priv_to_dev(st);
-	struct iio_sw_ring_buffer *sw_ring = iio_to_sw_ring(indio_dev->ring);
 	struct iio_ring_buffer *ring = indio_dev->ring;
 	s64 time_ns;
 	__u8 *buf;
@@ -145,13 +144,19 @@ static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
 		memcpy(buf + st->d_size - sizeof(s64),
 			&time_ns, sizeof(time_ns));
 
-	ring->access.store_to(&sw_ring->buf, buf, time_ns);
+	ring->access->store_to(indio_dev->ring, buf, time_ns);
 done:
 	gpio_set_value(st->pdata->gpio_convst, 0);
 	iio_trigger_notify_done(indio_dev->trig);
 	kfree(buf);
 }
 
+static const struct iio_ring_setup_ops ad7606_ring_setup_ops = {
+	.preenable = &ad7606_ring_preenable,
+	.postenable = &iio_triggered_ring_postenable,
+	.predisable = &iio_triggered_ring_predisable,
+};
+
 int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 {
 	struct ad7606_state *st = indio_dev->dev_data;
@@ -164,7 +169,7 @@ int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	}
 
 	/* Effectively select the ring buffer implementation */
-	iio_ring_sw_register_funcs(&indio_dev->ring->access);
+	indio_dev->ring->access = &ring_sw_access_funcs;
 	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
 	if (indio_dev->pollfunc == NULL) {
 		ret = -ENOMEM;
@@ -183,9 +188,7 @@ int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	}
 	/* Ring buffer functions - here trigger setup related */
 
-	indio_dev->ring->preenable = &ad7606_ring_preenable;
-	indio_dev->ring->postenable = &iio_triggered_ring_postenable;
-	indio_dev->ring->predisable = &iio_triggered_ring_predisable;
+	indio_dev->ring->setup_ops = &ad7606_ring_setup_ops;
 	indio_dev->ring->scan_timestamp = true ;
 
 	INIT_WORK(&st->poll_work, &ad7606_poll_bh_to_ring);
diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
index 113e97e..f3485b3 100644
--- a/drivers/staging/iio/adc/ad7887_ring.c
+++ b/drivers/staging/iio/adc/ad7887_ring.c
@@ -33,12 +33,13 @@ int ad7887_scan_from_ring(struct ad7887_state *st, long mask)
 		goto error_ret;
 	}
 
-	ring_data = kmalloc(ring->access.get_bytes_per_datum(ring), GFP_KERNEL);
+	ring_data = kmalloc(ring->access->get_bytes_per_datum(ring),
+			    GFP_KERNEL);
 	if (ring_data == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-	ret = ring->access.read_last(ring, (u8 *) ring_data);
+	ret = ring->access->read_last(ring, (u8 *) ring_data);
 	if (ret)
 		goto error_free_ring_data;
 
@@ -76,8 +77,8 @@ static int ad7887_ring_preenable(struct iio_dev *indio_dev)
 			st->d_size += sizeof(s64) - (st->d_size % sizeof(s64));
 	}
 
-	if (indio_dev->ring->access.set_bytes_per_datum)
-		indio_dev->ring->access.set_bytes_per_datum(indio_dev->ring,
+	if (indio_dev->ring->access->set_bytes_per_datum)
+		indio_dev->ring->access->set_bytes_per_datum(indio_dev->ring,
 							    st->d_size);
 
 	switch (ring->scan_mask) {
@@ -117,7 +118,6 @@ static irqreturn_t ad7887_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->private_data;
 	struct ad7887_state *st = iio_dev_get_devdata(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
-	struct iio_sw_ring_buffer *sw_ring = iio_to_sw_ring(indio_dev->ring);
 	s64 time_ns;
 	__u8 *buf;
 	int b_sent;
@@ -140,7 +140,7 @@ static irqreturn_t ad7887_trigger_handler(int irq, void *p)
 		memcpy(buf + st->d_size - sizeof(s64),
 		       &time_ns, sizeof(time_ns));
 
-	indio_dev->ring->access.store_to(&sw_ring->buf, buf, time_ns);
+	indio_dev->ring->access->store_to(indio_dev->ring, buf, time_ns);
 done:
 	kfree(buf);
 	iio_trigger_notify_done(indio_dev->trig);
@@ -148,6 +148,13 @@ done:
 	return IRQ_HANDLED;
 }
 
+static const struct iio_ring_setup_ops ad7887_ring_setup_ops = {
+	.preenable = &ad7887_ring_preenable,
+	.postenable = &iio_triggered_ring_postenable,
+	.predisable = &iio_triggered_ring_predisable,
+	.postdisable = &ad7887_ring_postdisable,
+};
+
 int ad7887_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 {
 	int ret;
@@ -158,7 +165,7 @@ int ad7887_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 		goto error_ret;
 	}
 	/* Effectively select the ring buffer implementation */
-	iio_ring_sw_register_funcs(&indio_dev->ring->access);
+	indio_dev->ring->access = &ring_sw_access_funcs;
 	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
 	if (indio_dev->pollfunc == NULL) {
 		ret = -ENOMEM;
@@ -176,11 +183,7 @@ int ad7887_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 		goto error_free_pollfunc;
 	}
 	/* Ring buffer functions - here trigger setup related */
-
-	indio_dev->ring->preenable = &ad7887_ring_preenable;
-	indio_dev->ring->postenable = &iio_triggered_ring_postenable;
-	indio_dev->ring->predisable = &iio_triggered_ring_predisable;
-	indio_dev->ring->postdisable = &ad7887_ring_postdisable;
+	indio_dev->ring->setup_ops = &ad7887_ring_setup_ops;
 
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index 6906568..57dca20 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -37,12 +37,13 @@ int ad799x_single_channel_from_ring(struct ad799x_state *st, long mask)
 		goto error_ret;
 	}
 
-	ring_data = kmalloc(ring->access.get_bytes_per_datum(ring), GFP_KERNEL);
+	ring_data = kmalloc(ring->access->get_bytes_per_datum(ring),
+			    GFP_KERNEL);
 	if (ring_data == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-	ret = ring->access.read_last(ring, (u8 *) ring_data);
+	ret = ring->access->read_last(ring, (u8 *) ring_data);
 	if (ret)
 		goto error_free_ring_data;
 	/* Need a count of channels prior to this one */
@@ -90,8 +91,8 @@ static int ad799x_ring_preenable(struct iio_dev *indio_dev)
 			st->d_size += sizeof(s64) - (st->d_size % sizeof(s64));
 	}
 
-	if (indio_dev->ring->access.set_bytes_per_datum)
-		indio_dev->ring->access.set_bytes_per_datum(indio_dev->ring,
+	if (indio_dev->ring->access->set_bytes_per_datum)
+		indio_dev->ring->access->set_bytes_per_datum(indio_dev->ring,
 							    st->d_size);
 
 	return 0;
@@ -110,7 +111,6 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->private_data;
 	struct ad799x_state *st = iio_dev_get_devdata(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
-	struct iio_sw_ring_buffer *ring_sw = iio_to_sw_ring(indio_dev->ring);
 	s64 time_ns;
 	__u8 *rxbuf;
 	int b_sent;
@@ -151,7 +151,7 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 		memcpy(rxbuf + st->d_size - sizeof(s64),
 			&time_ns, sizeof(time_ns));
 
-	ring->access.store_to(&ring_sw->buf, rxbuf, time_ns);
+	ring->access->store_to(indio_dev->ring, rxbuf, time_ns);
 done:
 	kfree(rxbuf);
 	if (b_sent < 0)
@@ -162,6 +162,11 @@ out:
 	return IRQ_HANDLED;
 }
 
+static const struct iio_ring_setup_ops ad799x_buf_setup_ops = {
+	.preenable = &ad799x_ring_preenable,
+	.postenable = &iio_triggered_ring_postenable,
+	.predisable = &iio_triggered_ring_predisable,
+};
 
 int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 {
@@ -173,7 +178,7 @@ int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 		goto error_ret;
 	}
 	/* Effectively select the ring buffer implementation */
-	iio_ring_sw_register_funcs(&indio_dev->ring->access);
+	indio_dev->ring->access = &ring_sw_access_funcs;
 	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
 	if (indio_dev->pollfunc == NULL) {
 		ret = -ENOMEM;
@@ -190,10 +195,7 @@ int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 		goto error_free_poll_func;
 	}
 	/* Ring buffer functions - here trigger setup related */
-
-	indio_dev->ring->preenable = &ad799x_ring_preenable;
-	indio_dev->ring->postenable = &iio_triggered_ring_postenable;
-	indio_dev->ring->predisable = &iio_triggered_ring_predisable;
+	indio_dev->ring->setup_ops = &ad799x_buf_setup_ops;
 	indio_dev->ring->scan_timestamp = true;
 
 	/* Flag that polled ring buffering is possible */
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index a387a99..9638909 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -35,12 +35,13 @@ int max1363_single_channel_from_ring(long mask, struct max1363_state *st)
 		goto error_ret;
 	}
 
-	ring_data = kmalloc(ring->access.get_bytes_per_datum(ring), GFP_KERNEL);
+	ring_data = kmalloc(ring->access->get_bytes_per_datum(ring),
+			    GFP_KERNEL);
 	if (ring_data == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-	ret = ring->access.read_last(ring, ring_data);
+	ret = ring->access->read_last(ring, ring_data);
 	if (ret)
 		goto error_free_ring_data;
 	/* Need a count of channels prior to this one */
@@ -88,7 +89,7 @@ static int max1363_ring_preenable(struct iio_dev *indio_dev)
 	max1363_set_scan_mode(st);
 
 	numvals = hweight_long(st->current_mode->modemask);
-	if (ring->access.set_bytes_per_datum) {
+	if (ring->access->set_bytes_per_datum) {
 		if (ring->scan_timestamp)
 			d_size += sizeof(s64);
 		if (st->chip_info->bits != 8)
@@ -97,7 +98,7 @@ static int max1363_ring_preenable(struct iio_dev *indio_dev)
 			d_size += numvals;
 		if (ring->scan_timestamp && (d_size % 8))
 			d_size += 8 - (d_size % 8);
-		ring->access.set_bytes_per_datum(ring, d_size);
+		ring->access->set_bytes_per_datum(ring, d_size);
 	}
 
 	return 0;
@@ -108,7 +109,6 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->private_data;
 	struct max1363_state *st = iio_priv(indio_dev);
-	struct iio_sw_ring_buffer *sw_ring = iio_to_sw_ring(indio_dev->ring);
 	s64 time_ns;
 	__u8 *rxbuf;
 	int b_sent;
@@ -144,7 +144,7 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
 
 	memcpy(rxbuf + d_size - sizeof(s64), &time_ns, sizeof(time_ns));
 
-	indio_dev->ring->access.store_to(&sw_ring->buf, rxbuf, time_ns);
+	indio_dev->ring->access->store_to(indio_dev->ring, rxbuf, time_ns);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 	kfree(rxbuf);
@@ -152,6 +152,11 @@ done:
 	return IRQ_HANDLED;
 }
 
+static const struct iio_ring_setup_ops max1363_ring_setup_ops = {
+	.postenable = &iio_triggered_ring_postenable,
+	.preenable = &max1363_ring_preenable,
+	.predisable = &iio_triggered_ring_predisable,
+};
 
 int max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 {
@@ -163,8 +168,6 @@ int max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-	/* Effectively select the ring buffer implementation */
-	iio_ring_sw_register_funcs(&indio_dev->ring->access);
 	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
 	if (indio_dev->pollfunc == NULL) {
 		ret = -ENOMEM;
@@ -180,11 +183,10 @@ int max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 		ret = -ENOMEM;
 		goto error_free_pollfunc;
 	}
-
+	/* Effectively select the ring buffer implementation */
+	indio_dev->ring->access = &ring_sw_access_funcs;
 	/* Ring buffer functions - here trigger setup related */
-	indio_dev->ring->postenable = &iio_triggered_ring_postenable;
-	indio_dev->ring->preenable = &max1363_ring_preenable;
-	indio_dev->ring->predisable = &iio_triggered_ring_predisable;
+	indio_dev->ring->setup_ops = &max1363_ring_setup_ops;
 
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index 12fbbf2..85586e4 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -74,7 +74,7 @@ static irqreturn_t adis16260_trigger_handler(int irq, void *p)
 	struct iio_ring_buffer *ring = indio_dev->ring;
 	int i = 0;
 	s16 *data;
-	size_t datasize = ring->access.get_bytes_per_datum(ring);
+	size_t datasize = ring->access->get_bytes_per_datum(ring);
 
 	data = kmalloc(datasize , GFP_KERNEL);
 	if (data == NULL) {
@@ -91,7 +91,7 @@ static irqreturn_t adis16260_trigger_handler(int irq, void *p)
 	if (ring->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
 
-	ring->access.store_to(ring, (u8 *)data, pf->timestamp);
+	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
 
 	iio_trigger_notify_done(st->indio_dev->trig);
 	kfree(data);
@@ -106,6 +106,12 @@ void adis16260_unconfigure_ring(struct iio_dev *indio_dev)
 	iio_sw_rb_free(indio_dev->ring);
 }
 
+static const struct iio_ring_setup_ops adis16260_ring_setup_ops = {
+	.preenable = &iio_sw_ring_preenable,
+	.postenable = &iio_triggered_ring_postenable,
+	.predisable = &iio_triggered_ring_predisable,
+};
+
 int adis16260_configure_ring(struct iio_dev *indio_dev)
 {
 	int ret = 0;
@@ -118,12 +124,10 @@ int adis16260_configure_ring(struct iio_dev *indio_dev)
 	}
 	indio_dev->ring = ring;
 	/* Effectively select the ring buffer implementation */
-	iio_ring_sw_register_funcs(&ring->access);
+	ring->access = &ring_sw_access_funcs;
 	ring->bpe = 2;
 	ring->scan_timestamp = true;
-	ring->preenable = &iio_sw_ring_preenable;
-	ring->postenable = &iio_triggered_ring_postenable;
-	ring->predisable = &iio_triggered_ring_predisable;
+	ring->setup_ops = &adis16260_ring_setup_ops;
 	ring->owner = THIS_MODULE;
 
 	/* Set default scan mode */
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index 271fe1d..5d99fba 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -124,7 +124,7 @@ static irqreturn_t adis16400_trigger_handler(int irq, void *p)
 	struct iio_ring_buffer *ring = indio_dev->ring;
 	int i = 0, j, ret = 0;
 	s16 *data;
-	size_t datasize = ring->access.get_bytes_per_datum(ring);
+	size_t datasize = ring->access->get_bytes_per_datum(ring);
 	unsigned long mask = ring->scan_mask;
 
 	data = kmalloc(datasize , GFP_KERNEL);
@@ -155,7 +155,7 @@ static irqreturn_t adis16400_trigger_handler(int irq, void *p)
 	/* Guaranteed to be aligned with 8 byte boundary */
 	if (ring->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
-	ring->access.store_to(indio_dev->ring, (u8 *) data, pf->timestamp);
+	ring->access->store_to(indio_dev->ring, (u8 *) data, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 	kfree(data);
@@ -170,6 +170,12 @@ void adis16400_unconfigure_ring(struct iio_dev *indio_dev)
 	iio_sw_rb_free(indio_dev->ring);
 }
 
+static const struct iio_ring_setup_ops adis16400_ring_setup_ops = {
+	.preenable = &iio_sw_ring_preenable,
+	.postenable = &iio_triggered_ring_postenable,
+	.predisable = &iio_triggered_ring_predisable,
+};
+
 int adis16400_configure_ring(struct iio_dev *indio_dev)
 {
 	int ret = 0;
@@ -183,12 +189,10 @@ int adis16400_configure_ring(struct iio_dev *indio_dev)
 	}
 	indio_dev->ring = ring;
 	/* Effectively select the ring buffer implementation */
-	iio_ring_sw_register_funcs(&ring->access);
+	ring->access = &ring_sw_access_funcs;
 	ring->bpe = 2;
 	ring->scan_timestamp = true;
-	ring->preenable = &iio_sw_ring_preenable;
-	ring->postenable = &iio_triggered_ring_postenable;
-	ring->predisable = &iio_triggered_ring_predisable;
+	ring->setup_ops = &adis16400_ring_setup_ops;
 	ring->owner = THIS_MODULE;
 	ring->scan_mask = st->variant->default_scan_mask;
 	ring->scan_count = hweight_long(st->variant->default_scan_mask);
diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/iio/industrialio-ring.c
index 853ebe9..050f9f9 100644
--- a/drivers/staging/iio/industrialio-ring.c
+++ b/drivers/staging/iio/industrialio-ring.c
@@ -36,8 +36,8 @@ static int iio_ring_open(struct inode *inode, struct file *filp)
 	struct iio_ring_buffer *rb = hand->private;
 
 	filp->private_data = hand->private;
-	if (rb->access.mark_in_use)
-		rb->access.mark_in_use(rb);
+	if (rb->access->mark_in_use)
+		rb->access->mark_in_use(rb);
 
 	return 0;
 }
@@ -55,8 +55,8 @@ static int iio_ring_release(struct inode *inode, struct file *filp)
 	struct iio_ring_buffer *rb = hand->private;
 
 	clear_bit(IIO_BUSY_BIT_POS, &rb->access_handler.flags);
-	if (rb->access.unmark_in_use)
-		rb->access.unmark_in_use(rb);
+	if (rb->access->unmark_in_use)
+		rb->access->unmark_in_use(rb);
 
 	return 0;
 }
@@ -74,9 +74,9 @@ static ssize_t iio_ring_read_first_n_outer(struct file *filp, char __user *buf,
 	int ret;
 
 	/* rip lots must exist. */
-	if (!rb->access.read_first_n)
+	if (!rb->access->read_first_n)
 		return -EINVAL;
-	ret = rb->access.read_first_n(rb, n, buf);
+	ret = rb->access->read_first_n(rb, n, buf);
 
 	return ret;
 }
@@ -165,8 +165,6 @@ static void __iio_free_ring_buffer_chrdev(struct iio_ring_buffer *buf)
 void iio_ring_buffer_init(struct iio_ring_buffer *ring,
 			  struct iio_dev *dev_info)
 {
-	if (ring->access.mark_param_change)
-		ring->access.mark_param_change(ring);
 	ring->indio_dev = dev_info;
 	ring->access_handler.private = ring;
 	init_waitqueue_head(&ring->pollq);
@@ -344,9 +342,9 @@ ssize_t iio_read_ring_length(struct device *dev,
 	int len = 0;
 	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
 
-	if (ring->access.get_length)
+	if (ring->access->get_length)
 		len = sprintf(buf, "%d\n",
-			      ring->access.get_length(ring));
+			      ring->access->get_length(ring));
 
 	return len;
 }
@@ -364,14 +362,14 @@ ssize_t iio_write_ring_length(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (ring->access.get_length)
-		if (val == ring->access.get_length(ring))
+	if (ring->access->get_length)
+		if (val == ring->access->get_length(ring))
 			return len;
 
-	if (ring->access.set_length) {
-		ring->access.set_length(ring, val);
-		if (ring->access.mark_param_change)
-			ring->access.mark_param_change(ring);
+	if (ring->access->set_length) {
+		ring->access->set_length(ring, val);
+		if (ring->access->mark_param_change)
+			ring->access->mark_param_change(ring);
 	}
 
 	return len;
@@ -385,9 +383,9 @@ ssize_t iio_read_ring_bytes_per_datum(struct device *dev,
 	int len = 0;
 	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
 
-	if (ring->access.get_bytes_per_datum)
+	if (ring->access->get_bytes_per_datum)
 		len = sprintf(buf, "%d\n",
-			      ring->access.get_bytes_per_datum(ring));
+			      ring->access->get_bytes_per_datum(ring));
 
 	return len;
 }
@@ -413,8 +411,8 @@ ssize_t iio_store_ring_enable(struct device *dev,
 		goto done;
 	}
 	if (requested_state) {
-		if (ring->preenable) {
-			ret = ring->preenable(dev_info);
+		if (ring->setup_ops->preenable) {
+			ret = ring->setup_ops->preenable(dev_info);
 			if (ret) {
 				printk(KERN_ERR
 				       "Buffer not started:"
@@ -422,8 +420,8 @@ ssize_t iio_store_ring_enable(struct device *dev,
 				goto error_ret;
 			}
 		}
-		if (ring->access.request_update) {
-			ret = ring->access.request_update(ring);
+		if (ring->access->request_update) {
+			ret = ring->access->request_update(ring);
 			if (ret) {
 				printk(KERN_INFO
 				       "Buffer not started:"
@@ -431,16 +429,16 @@ ssize_t iio_store_ring_enable(struct device *dev,
 				goto error_ret;
 			}
 		}
-		if (ring->access.mark_in_use)
-			ring->access.mark_in_use(ring);
+		if (ring->access->mark_in_use)
+			ring->access->mark_in_use(ring);
 		/* Definitely possible for devices to support both of these.*/
 		if (dev_info->modes & INDIO_RING_TRIGGERED) {
 			if (!dev_info->trig) {
 				printk(KERN_INFO
 				       "Buffer not started: no trigger\n");
 				ret = -EINVAL;
-				if (ring->access.unmark_in_use)
-					ring->access.unmark_in_use(ring);
+				if (ring->access->unmark_in_use)
+					ring->access->unmark_in_use(ring);
 				goto error_ret;
 			}
 			dev_info->currentmode = INDIO_RING_TRIGGERED;
@@ -451,32 +449,32 @@ ssize_t iio_store_ring_enable(struct device *dev,
 			goto error_ret;
 		}
 
-		if (ring->postenable) {
+		if (ring->setup_ops->postenable) {
 
-			ret = ring->postenable(dev_info);
+			ret = ring->setup_ops->postenable(dev_info);
 			if (ret) {
 				printk(KERN_INFO
 				       "Buffer not started:"
 				       "postenable failed\n");
-				if (ring->access.unmark_in_use)
-					ring->access.unmark_in_use(ring);
+				if (ring->access->unmark_in_use)
+					ring->access->unmark_in_use(ring);
 				dev_info->currentmode = previous_mode;
-				if (ring->postdisable)
-					ring->postdisable(dev_info);
+				if (ring->setup_ops->postdisable)
+					ring->setup_ops->postdisable(dev_info);
 				goto error_ret;
 			}
 		}
 	} else {
-		if (ring->predisable) {
-			ret = ring->predisable(dev_info);
+		if (ring->setup_ops->predisable) {
+			ret = ring->setup_ops->predisable(dev_info);
 			if (ret)
 				goto error_ret;
 		}
-		if (ring->access.unmark_in_use)
-			ring->access.unmark_in_use(ring);
+		if (ring->access->unmark_in_use)
+			ring->access->unmark_in_use(ring);
 		dev_info->currentmode = INDIO_DIRECT_MODE;
-		if (ring->postdisable) {
-			ret = ring->postdisable(dev_info);
+		if (ring->setup_ops->postdisable) {
+			ret = ring->setup_ops->postdisable(dev_info);
 			if (ret)
 				goto error_ret;
 		}
@@ -584,3 +582,28 @@ error_ret:
 	return ret ? ret : len;
 }
 EXPORT_SYMBOL(iio_scan_el_ts_store);
+
+int iio_sw_ring_preenable(struct iio_dev *indio_dev)
+{
+	struct iio_ring_buffer *ring = indio_dev->ring;
+	size_t size;
+	dev_dbg(&indio_dev->dev, "%s\n", __func__);
+	/* Check if there are any scan elements enabled, if not fail*/
+	if (!(ring->scan_count || ring->scan_timestamp))
+		return -EINVAL;
+	if (ring->scan_timestamp)
+		if (ring->scan_count)
+			/* Timestamp (aligned to s64) and data */
+			size = (((ring->scan_count * ring->bpe)
+					+ sizeof(s64) - 1)
+				& ~(sizeof(s64) - 1))
+				+ sizeof(s64);
+		else /* Timestamp only  */
+			size = sizeof(s64);
+	else /* Data only */
+		size = ring->scan_count * ring->bpe;
+	ring->access->set_bytes_per_datum(ring, size);
+
+	return 0;
+}
+EXPORT_SYMBOL(iio_sw_ring_preenable);
diff --git a/drivers/staging/iio/kfifo_buf.c b/drivers/staging/iio/kfifo_buf.c
index fdd5d9e..cc14b96 100644
--- a/drivers/staging/iio/kfifo_buf.c
+++ b/drivers/staging/iio/kfifo_buf.c
@@ -8,6 +8,8 @@
 
 #include "kfifo_buf.h"
 
+#define iio_to_kfifo(r) container_of(r, struct iio_kfifo, ring)
+
 static inline int __iio_allocate_kfifo(struct iio_kfifo *buf,
 				int bytes_per_datum, int length)
 {
@@ -18,7 +20,7 @@ static inline int __iio_allocate_kfifo(struct iio_kfifo *buf,
 	return kfifo_alloc(&buf->kf, bytes_per_datum*length, GFP_KERNEL);
 }
 
-int iio_request_update_kfifo(struct iio_ring_buffer *r)
+static int iio_request_update_kfifo(struct iio_ring_buffer *r)
 {
 	int ret = 0;
 	struct iio_kfifo *buf = iio_to_kfifo(r);
@@ -37,31 +39,27 @@ error_ret:
 	mutex_unlock(&buf->use_lock);
 	return ret;
 }
-EXPORT_SYMBOL(iio_request_update_kfifo);
 
-void iio_mark_kfifo_in_use(struct iio_ring_buffer *r)
+static void iio_mark_kfifo_in_use(struct iio_ring_buffer *r)
 {
 	struct iio_kfifo *buf = iio_to_kfifo(r);
 	mutex_lock(&buf->use_lock);
 	buf->use_count++;
 	mutex_unlock(&buf->use_lock);
 }
-EXPORT_SYMBOL(iio_mark_kfifo_in_use);
 
-void iio_unmark_kfifo_in_use(struct iio_ring_buffer *r)
+static void iio_unmark_kfifo_in_use(struct iio_ring_buffer *r)
 {
 	struct iio_kfifo *buf = iio_to_kfifo(r);
 	mutex_lock(&buf->use_lock);
 	buf->use_count--;
 	mutex_unlock(&buf->use_lock);
 }
-EXPORT_SYMBOL(iio_unmark_kfifo_in_use);
 
-int iio_get_length_kfifo(struct iio_ring_buffer *r)
+static int iio_get_length_kfifo(struct iio_ring_buffer *r)
 {
 	return r->length;
 }
-EXPORT_SYMBOL(iio_get_length_kfifo);
 
 static inline void __iio_init_kfifo(struct iio_kfifo *kf)
 {
@@ -108,6 +106,7 @@ struct iio_ring_buffer *iio_kfifo_allocate(struct iio_dev *indio_dev)
 	kf = kzalloc(sizeof *kf, GFP_KERNEL);
 	if (!kf)
 		return NULL;
+	kf->update_needed = true;
 	iio_ring_buffer_init(&kf->ring, indio_dev);
 	__iio_init_kfifo(kf);
 	kf->ring.dev.type = &iio_kfifo_type;
@@ -120,41 +119,37 @@ struct iio_ring_buffer *iio_kfifo_allocate(struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL(iio_kfifo_allocate);
 
-int iio_get_bytes_per_datum_kfifo(struct iio_ring_buffer *r)
+static int iio_get_bytes_per_datum_kfifo(struct iio_ring_buffer *r)
 {
 	return r->bytes_per_datum;
 }
-EXPORT_SYMBOL(iio_get_bytes_per_datum_kfifo);
 
-int iio_set_bytes_per_datum_kfifo(struct iio_ring_buffer *r, size_t bpd)
+static int iio_set_bytes_per_datum_kfifo(struct iio_ring_buffer *r, size_t bpd)
 {
 	if (r->bytes_per_datum != bpd) {
 		r->bytes_per_datum = bpd;
-		if (r->access.mark_param_change)
-			r->access.mark_param_change(r);
+		if (r->access->mark_param_change)
+			r->access->mark_param_change(r);
 	}
 	return 0;
 }
-EXPORT_SYMBOL(iio_set_bytes_per_datum_kfifo);
 
-int iio_mark_update_needed_kfifo(struct iio_ring_buffer *r)
+static int iio_mark_update_needed_kfifo(struct iio_ring_buffer *r)
 {
 	struct iio_kfifo *kf = iio_to_kfifo(r);
 	kf->update_needed = true;
 	return 0;
 }
-EXPORT_SYMBOL(iio_mark_update_needed_kfifo);
 
-int iio_set_length_kfifo(struct iio_ring_buffer *r, int length)
+static int iio_set_length_kfifo(struct iio_ring_buffer *r, int length)
 {
 	if (r->length != length) {
 		r->length = length;
-		if (r->access.mark_param_change)
-			r->access.mark_param_change(r);
+		if (r->access->mark_param_change)
+			r->access->mark_param_change(r);
 	}
 	return 0;
 }
-EXPORT_SYMBOL(iio_set_length_kfifo);
 
 void iio_kfifo_free(struct iio_ring_buffer *r)
 {
@@ -163,7 +158,9 @@ void iio_kfifo_free(struct iio_ring_buffer *r)
 }
 EXPORT_SYMBOL(iio_kfifo_free);
 
-int iio_store_to_kfifo(struct iio_ring_buffer *r, u8 *data, s64 timestamp)
+static int iio_store_to_kfifo(struct iio_ring_buffer *r,
+			      u8 *data,
+			      s64 timestamp)
 {
 	int ret;
 	struct iio_kfifo *kf = iio_to_kfifo(r);
@@ -179,9 +176,8 @@ int iio_store_to_kfifo(struct iio_ring_buffer *r, u8 *data, s64 timestamp)
 	kfree(datal);
 	return 0;
 }
-EXPORT_SYMBOL(iio_store_to_kfifo);
 
-int iio_read_first_n_kfifo(struct iio_ring_buffer *r,
+static int iio_read_first_n_kfifo(struct iio_ring_buffer *r,
 			   size_t n, char __user *buf)
 {
 	int ret, copied;
@@ -191,5 +187,19 @@ int iio_read_first_n_kfifo(struct iio_ring_buffer *r,
 
 	return copied;
 }
-EXPORT_SYMBOL(iio_read_first_n_kfifo);
+
+const struct iio_ring_access_funcs kfifo_access_funcs = {
+	.mark_in_use = &iio_mark_kfifo_in_use,
+	.unmark_in_use = &iio_unmark_kfifo_in_use,
+	.store_to = &iio_store_to_kfifo,
+	.read_first_n = &iio_read_first_n_kfifo,
+	.mark_param_change = &iio_mark_update_needed_kfifo,
+	.request_update = &iio_request_update_kfifo,
+	.get_bytes_per_datum = &iio_get_bytes_per_datum_kfifo,
+	.set_bytes_per_datum = &iio_set_bytes_per_datum_kfifo,
+	.get_length = &iio_get_length_kfifo,
+	.set_length = &iio_set_length_kfifo,
+};
+EXPORT_SYMBOL(kfifo_access_funcs);
+
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/iio/kfifo_buf.h b/drivers/staging/iio/kfifo_buf.h
index eb337a4..aac3053 100644
--- a/drivers/staging/iio/kfifo_buf.h
+++ b/drivers/staging/iio/kfifo_buf.h
@@ -11,44 +11,7 @@ struct iio_kfifo {
 	struct mutex use_lock;
 };
 
-#define iio_to_kfifo(r) container_of(r, struct iio_kfifo, ring)
-
-int iio_create_kfifo(struct iio_ring_buffer **r);
-int iio_init_kfifo(struct iio_ring_buffer *r, struct iio_dev *indio_dev);
-void iio_exit_kfifo(struct iio_ring_buffer *r);
-void iio_free_kfifo(struct iio_ring_buffer *r);
-void iio_mark_kfifo_in_use(struct iio_ring_buffer *r);
-void iio_unmark_kfifo_in_use(struct iio_ring_buffer *r);
-
-int iio_store_to_kfifo(struct iio_ring_buffer *r, u8 *data, s64 timestamp);
-int iio_read_first_n_kfifo(struct iio_ring_buffer *r,
-			   size_t n,
-			   char __user *buf);
-
-int iio_request_update_kfifo(struct iio_ring_buffer *r);
-int iio_mark_update_needed_kfifo(struct iio_ring_buffer *r);
-
-int iio_get_bytes_per_datum_kfifo(struct iio_ring_buffer *r);
-int iio_set_bytes_per_datum_kfifo(struct iio_ring_buffer *r, size_t bpd);
-int iio_get_length_kfifo(struct iio_ring_buffer *r);
-int iio_set_length_kfifo(struct iio_ring_buffer *r, int length);
-
-static inline void iio_kfifo_register_funcs(struct iio_ring_access_funcs *ra)
-{
-	ra->mark_in_use = &iio_mark_kfifo_in_use;
-	ra->unmark_in_use = &iio_unmark_kfifo_in_use;
-
-	ra->store_to = &iio_store_to_kfifo;
-	ra->read_first_n = &iio_read_first_n_kfifo;
-
-	ra->mark_param_change = &iio_mark_update_needed_kfifo;
-	ra->request_update = &iio_request_update_kfifo;
-
-	ra->get_bytes_per_datum = &iio_get_bytes_per_datum_kfifo;
-	ra->set_bytes_per_datum = &iio_set_bytes_per_datum_kfifo;
-	ra->get_length = &iio_get_length_kfifo;
-	ra->set_length = &iio_set_length_kfifo;
-};
+extern const struct iio_ring_access_funcs kfifo_access_funcs;
 
 struct iio_ring_buffer *iio_kfifo_allocate(struct iio_dev *indio_dev);
 void iio_kfifo_free(struct iio_ring_buffer *r);
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index c8ebfd2..564555a 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -83,7 +83,7 @@ static irqreturn_t ade7758_trigger_handler(int irq, void *p)
 	if (ring->scan_timestamp)
 		dat64[1] = pf->timestamp;
 
-	ring->access.store_to(ring, (u8 *)dat64, pf->timestamp);
+	ring->access->store_to(ring, (u8 *)dat64, pf->timestamp);
 
 	iio_trigger_notify_done(st->indio_dev->trig);
 
@@ -118,8 +118,8 @@ static int ade7758_ring_preenable(struct iio_dev *indio_dev)
 			d_size += sizeof(s64) - (d_size % sizeof(s64));
 	}
 
-	if (indio_dev->ring->access.set_bytes_per_datum)
-		indio_dev->ring->access.set_bytes_per_datum(indio_dev->ring,
+	if (indio_dev->ring->access->set_bytes_per_datum)
+		indio_dev->ring->access->set_bytes_per_datum(indio_dev->ring,
 							    d_size);
 
 	ade7758_write_waveform_type(&indio_dev->dev,
@@ -128,6 +128,12 @@ static int ade7758_ring_preenable(struct iio_dev *indio_dev)
 	return 0;
 }
 
+static const struct iio_ring_setup_ops ade7758_ring_setup_ops = {
+	.preenable = &ade7758_ring_preenable,
+	.postenable = &iio_triggered_ring_postenable,
+	.predisable = &iio_triggered_ring_predisable,
+};
+
 void ade7758_unconfigure_ring(struct iio_dev *indio_dev)
 {
 	/* ensure that the trigger has been detached */
@@ -153,10 +159,8 @@ int ade7758_configure_ring(struct iio_dev *indio_dev)
 	}
 
 	/* Effectively select the ring buffer implementation */
-	iio_ring_sw_register_funcs(&indio_dev->ring->access);
-	indio_dev->ring->preenable = &ade7758_ring_preenable;
-	indio_dev->ring->postenable = &iio_triggered_ring_postenable;
-	indio_dev->ring->predisable = &iio_triggered_ring_predisable;
+	indio_dev->ring->access = &ring_sw_access_funcs;
+	indio_dev->ring->setup_ops = &ade7758_ring_setup_ops;
 	indio_dev->ring->owner = THIS_MODULE;
 
 	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
index 15d15a4..3349676 100644
--- a/drivers/staging/iio/ring_generic.h
+++ b/drivers/staging/iio/ring_generic.h
@@ -64,6 +64,13 @@ struct iio_ring_access_funcs {
 	int (*enable)(struct iio_ring_buffer *ring);
 };
 
+struct iio_ring_setup_ops {
+	int				(*preenable)(struct iio_dev *);
+	int				(*postenable)(struct iio_dev *);
+	int				(*predisable)(struct iio_dev *);
+	int				(*postdisable)(struct iio_dev *);
+};
+
 /**
  * struct iio_ring_buffer - general ring buffer structure
  * @dev:		ring buffer device struct
@@ -101,12 +108,8 @@ struct iio_ring_buffer {
 	u32				scan_mask;
 	bool				scan_timestamp;
 	struct iio_handler		access_handler;
-	struct iio_ring_access_funcs	access;
-	int				(*preenable)(struct iio_dev *);
-	int				(*postenable)(struct iio_dev *);
-	int				(*predisable)(struct iio_dev *);
-	int				(*postdisable)(struct iio_dev *);
-
+	const struct iio_ring_access_funcs	*access;
+	const struct iio_ring_setup_ops	*setup_ops;
 	struct list_head scan_el_dev_attr_list;
 
 	wait_queue_head_t pollq;
@@ -349,6 +352,9 @@ ssize_t iio_show_ring_enable(struct device *dev,
 #define IIO_RING_ENABLE_ATTR DEVICE_ATTR(enable, S_IRUGO | S_IWUSR, \
 					 iio_show_ring_enable,		\
 					 iio_store_ring_enable)
+
+int iio_sw_ring_preenable(struct iio_dev *indio_dev);
+
 #else /* CONFIG_IIO_RING_BUFFER */
 static inline int iio_ring_buffer_register(struct iio_ring_buffer *ring, int id)
 {
diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.c
index d55757b..35896cbb 100644
--- a/drivers/staging/iio/ring_sw.c
+++ b/drivers/staging/iio/ring_sw.c
@@ -17,6 +17,36 @@
 #include "ring_sw.h"
 #include "trigger.h"
 
+/**
+ * struct iio_sw_ring_buffer - software ring buffer
+ * @buf:		generic ring buffer elements
+ * @data:		the ring buffer memory
+ * @read_p:		read pointer (oldest available)
+ * @write_p:		write pointer
+ * @last_written_p:	read pointer (newest available)
+ * @half_p:		half buffer length behind write_p (event generation)
+ * @use_count:		reference count to prevent resizing when in use
+ * @update_needed:	flag to indicated change in size requested
+ * @use_lock:		lock to prevent change in size when in use
+ *
+ * Note that the first element of all ring buffers must be a
+ * struct iio_ring_buffer.
+**/
+struct iio_sw_ring_buffer {
+	struct iio_ring_buffer  buf;
+	unsigned char		*data;
+	unsigned char		*read_p;
+	unsigned char		*write_p;
+	unsigned char		*last_written_p;
+	/* used to act as a point at which to signal an event */
+	unsigned char		*half_p;
+	int			use_count;
+	int			update_needed;
+	spinlock_t		use_lock;
+};
+
+#define iio_to_sw_ring(r) container_of(r, struct iio_sw_ring_buffer, buf)
+
 static inline int __iio_allocate_sw_ring_buffer(struct iio_sw_ring_buffer *ring,
 						int bytes_per_datum, int length)
 {
@@ -41,23 +71,21 @@ static inline void __iio_free_sw_ring_buffer(struct iio_sw_ring_buffer *ring)
 	kfree(ring->data);
 }
 
-void iio_mark_sw_rb_in_use(struct iio_ring_buffer *r)
+static void iio_mark_sw_rb_in_use(struct iio_ring_buffer *r)
 {
 	struct iio_sw_ring_buffer *ring = iio_to_sw_ring(r);
 	spin_lock(&ring->use_lock);
 	ring->use_count++;
 	spin_unlock(&ring->use_lock);
 }
-EXPORT_SYMBOL(iio_mark_sw_rb_in_use);
 
-void iio_unmark_sw_rb_in_use(struct iio_ring_buffer *r)
+static void iio_unmark_sw_rb_in_use(struct iio_ring_buffer *r)
 {
 	struct iio_sw_ring_buffer *ring = iio_to_sw_ring(r);
 	spin_lock(&ring->use_lock);
 	ring->use_count--;
 	spin_unlock(&ring->use_lock);
 }
-EXPORT_SYMBOL(iio_unmark_sw_rb_in_use);
 
 
 /* Ring buffer related functionality */
@@ -138,8 +166,8 @@ static int iio_store_to_sw_ring(struct iio_sw_ring_buffer *ring,
 	return ret;
 }
 
-int iio_read_first_n_sw_rb(struct iio_ring_buffer *r,
-			   size_t n, char __user *buf)
+static int iio_read_first_n_sw_rb(struct iio_ring_buffer *r,
+				  size_t n, char __user *buf)
 {
 	struct iio_sw_ring_buffer *ring = iio_to_sw_ring(r);
 
@@ -268,14 +296,14 @@ error_ret:
 
 	return ret;
 }
-EXPORT_SYMBOL(iio_read_first_n_sw_rb);
 
-int iio_store_to_sw_rb(struct iio_ring_buffer *r, u8 *data, s64 timestamp)
+static int iio_store_to_sw_rb(struct iio_ring_buffer *r,
+			      u8 *data,
+			      s64 timestamp)
 {
 	struct iio_sw_ring_buffer *ring = iio_to_sw_ring(r);
 	return iio_store_to_sw_ring(ring, data, timestamp);
 }
-EXPORT_SYMBOL(iio_store_to_sw_rb);
 
 static int iio_read_last_from_sw_ring(struct iio_sw_ring_buffer *ring,
 				      unsigned char *data)
@@ -299,14 +327,13 @@ again:
 	return 0;
 }
 
-int iio_read_last_from_sw_rb(struct iio_ring_buffer *r,
+static int iio_read_last_from_sw_rb(struct iio_ring_buffer *r,
 			     unsigned char *data)
 {
 	return iio_read_last_from_sw_ring(iio_to_sw_ring(r), data);
 }
-EXPORT_SYMBOL(iio_read_last_from_sw_rb);
 
-int iio_request_update_sw_rb(struct iio_ring_buffer *r)
+static int iio_request_update_sw_rb(struct iio_ring_buffer *r)
 {
 	int ret = 0;
 	struct iio_sw_ring_buffer *ring = iio_to_sw_ring(r);
@@ -326,50 +353,44 @@ error_ret:
 	spin_unlock(&ring->use_lock);
 	return ret;
 }
-EXPORT_SYMBOL(iio_request_update_sw_rb);
 
-int iio_get_bytes_per_datum_sw_rb(struct iio_ring_buffer *r)
+static int iio_get_bytes_per_datum_sw_rb(struct iio_ring_buffer *r)
 {
 	struct iio_sw_ring_buffer *ring = iio_to_sw_ring(r);
 	return ring->buf.bytes_per_datum;
 }
-EXPORT_SYMBOL(iio_get_bytes_per_datum_sw_rb);
 
-int iio_set_bytes_per_datum_sw_rb(struct iio_ring_buffer *r, size_t bpd)
+static int iio_set_bytes_per_datum_sw_rb(struct iio_ring_buffer *r, size_t bpd)
 {
 	if (r->bytes_per_datum != bpd) {
 		r->bytes_per_datum = bpd;
-		if (r->access.mark_param_change)
-			r->access.mark_param_change(r);
+		if (r->access->mark_param_change)
+			r->access->mark_param_change(r);
 	}
 	return 0;
 }
-EXPORT_SYMBOL(iio_set_bytes_per_datum_sw_rb);
 
-int iio_get_length_sw_rb(struct iio_ring_buffer *r)
+static int iio_get_length_sw_rb(struct iio_ring_buffer *r)
 {
 	return r->length;
 }
-EXPORT_SYMBOL(iio_get_length_sw_rb);
 
-int iio_set_length_sw_rb(struct iio_ring_buffer *r, int length)
+static int iio_set_length_sw_rb(struct iio_ring_buffer *r, int length)
 {
 	if (r->length != length) {
 		r->length = length;
-		if (r->access.mark_param_change)
-			r->access.mark_param_change(r);
+		if (r->access->mark_param_change)
+			r->access->mark_param_change(r);
 	}
 	return 0;
 }
-EXPORT_SYMBOL(iio_set_length_sw_rb);
 
-int iio_mark_update_needed_sw_rb(struct iio_ring_buffer *r)
+static int iio_mark_update_needed_sw_rb(struct iio_ring_buffer *r)
 {
 	struct iio_sw_ring_buffer *ring = iio_to_sw_ring(r);
 	ring->update_needed = true;
 	return 0;
 }
-EXPORT_SYMBOL(iio_mark_update_needed_sw_rb);
 
 static void iio_sw_rb_release(struct device *dev)
 {
@@ -412,6 +433,7 @@ struct iio_ring_buffer *iio_sw_rb_allocate(struct iio_dev *indio_dev)
 	ring = kzalloc(sizeof *ring, GFP_KERNEL);
 	if (!ring)
 		return NULL;
+	ring->update_needed = true;
 	buf = &ring->buf;
 	iio_ring_buffer_init(buf, indio_dev);
 	__iio_init_sw_ring_buffer(ring);
@@ -430,36 +452,11 @@ void iio_sw_rb_free(struct iio_ring_buffer *r)
 }
 EXPORT_SYMBOL(iio_sw_rb_free);
 
-int iio_sw_ring_preenable(struct iio_dev *indio_dev)
-{
-	struct iio_ring_buffer *ring = indio_dev->ring;
-	size_t size;
-	dev_dbg(&indio_dev->dev, "%s\n", __func__);
-	/* Check if there are any scan elements enabled, if not fail*/
-	if (!(ring->scan_count || ring->scan_timestamp))
-		return -EINVAL;
-	if (ring->scan_timestamp)
-		if (ring->scan_count)
-			/* Timestamp (aligned to s64) and data */
-			size = (((ring->scan_count * ring->bpe)
-					+ sizeof(s64) - 1)
-				& ~(sizeof(s64) - 1))
-				+ sizeof(s64);
-		else /* Timestamp only  */
-			size = sizeof(s64);
-	else /* Data only */
-		size = ring->scan_count * ring->bpe;
-	ring->access.set_bytes_per_datum(ring, size);
-
-	return 0;
-}
-EXPORT_SYMBOL(iio_sw_ring_preenable);
-
 void iio_sw_trigger_to_ring(struct iio_sw_ring_helper_state *st)
 {
 	struct iio_ring_buffer *ring = st->indio_dev->ring;
 	int len = 0;
-	size_t datasize = ring->access.get_bytes_per_datum(ring);
+	size_t datasize = ring->access->get_bytes_per_datum(ring);
 	char *data = kmalloc(datasize, GFP_KERNEL);
 
 	if (data == NULL) {
@@ -476,7 +473,7 @@ void iio_sw_trigger_to_ring(struct iio_sw_ring_helper_state *st)
 		*(s64 *)(((phys_addr_t)data + len
 				+ sizeof(s64) - 1) & ~(sizeof(s64) - 1))
 			= st->last_timestamp;
-	ring->access.store_to(ring,
+	ring->access->store_to(ring,
 			(u8 *)data,
 			st->last_timestamp);
 
@@ -504,5 +501,20 @@ void iio_sw_poll_func_th(struct iio_dev *indio_dev, s64 time)
 }
 EXPORT_SYMBOL(iio_sw_poll_func_th);
 
+const struct iio_ring_access_funcs ring_sw_access_funcs = {
+	.mark_in_use = &iio_mark_sw_rb_in_use,
+	.unmark_in_use = &iio_unmark_sw_rb_in_use,
+	.store_to = &iio_store_to_sw_rb,
+	.read_last = &iio_read_last_from_sw_rb,
+	.read_first_n = &iio_read_first_n_sw_rb,
+	.mark_param_change = &iio_mark_update_needed_sw_rb,
+	.request_update = &iio_request_update_sw_rb,
+	.get_bytes_per_datum = &iio_get_bytes_per_datum_sw_rb,
+	.set_bytes_per_datum = &iio_set_bytes_per_datum_sw_rb,
+	.get_length = &iio_get_length_sw_rb,
+	.set_length = &iio_set_length_sw_rb,
+};
+EXPORT_SYMBOL(ring_sw_access_funcs);
+
 MODULE_DESCRIPTION("Industrialio I/O software ring buffer");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/iio/ring_sw.h b/drivers/staging/iio/ring_sw.h
index 84b7c5a..9344989 100644
--- a/drivers/staging/iio/ring_sw.h
+++ b/drivers/staging/iio/ring_sw.h
@@ -23,190 +23,18 @@
 
 #ifndef _IIO_RING_SW_H_
 #define _IIO_RING_SW_H_
-/* NEEDS COMMENTS */
-/* The intention is that this should be a separate module from the iio core.
- * This is a bit like supporting algorithms dependent on what the device
- * driver requests - some may support multiple options */
-
-
 #include "iio.h"
 #include "ring_generic.h"
 
 #if defined CONFIG_IIO_SW_RING || defined CONFIG_IIO_SW_RING_MODULE
-
-/**
- * iio_create_sw_rb() - software ring buffer allocation
- * @r:		pointer to ring buffer pointer
- **/
-int iio_create_sw_rb(struct iio_ring_buffer **r);
-
-/**
- * iio_init_sw_rb() - initialize the software ring buffer
- * @r:		pointer to a software ring buffer created by an
- *		iio_create_sw_rb call
- * @indio_dev:		industrial I/O device structure
- **/
-int iio_init_sw_rb(struct iio_ring_buffer *r, struct iio_dev *indio_dev);
-
-/**
- * iio_exit_sw_rb() - reverse what was done in iio_init_sw_rb
- * @r:		pointer to a software ring buffer created by an
- *		iio_create_sw_rb call
- **/
-void iio_exit_sw_rb(struct iio_ring_buffer *r);
-
 /**
- * iio_free_sw_rb() - free memory occupied by the core ring buffer struct
- * @r:		pointer to a software ring buffer created by an
- *		iio_create_sw_rb call
+ * ring_sw_access_funcs - access functions for a software ring buffer
  **/
-void iio_free_sw_rb(struct iio_ring_buffer *r);
-
-/**
- * iio_mark_sw_rb_in_use() - reference counting to prevent incorrect chances
- * @r:		pointer to a software ring buffer created by an
- *		iio_create_sw_rb call
- **/
-void iio_mark_sw_rb_in_use(struct iio_ring_buffer *r);
-
-/**
- *  iio_unmark_sw_rb_in_use() - notify the ring buffer that we don't care anymore
- * @r:		pointer to a software ring buffer created by an
- *		iio_create_sw_rb call
- **/
-void iio_unmark_sw_rb_in_use(struct iio_ring_buffer *r);
-
-/**
- * iio_read_last_from_sw_rb() - attempt to read the last stored datum from the rb
- * @r:		pointer to a software ring buffer created by an
- *		iio_create_sw_rb call
- * @data:	where to store the last datum
- **/
-int iio_read_last_from_sw_rb(struct iio_ring_buffer *r, u8 *data);
-
-/**
- * iio_store_to_sw_rb() - store a new datum to the ring buffer
- * @r:		pointer to ring buffer instance
- * @data:	the datum to be stored including timestamp if relevant
- * @timestamp:	timestamp which will be attached to buffer events if relevant
- **/
-int iio_store_to_sw_rb(struct iio_ring_buffer *r, u8 *data, s64 timestamp);
-
-/**
- * iio_read_first_n_sw_rb() - attempt to read data from the ring buffer
- * @r:			ring buffer instance
- * @n:			number of datum's to try and read
- * @buf:		userspace buffer into which data is copied
- *			the end of the copy.
- **/
-int iio_read_first_n_sw_rb(struct iio_ring_buffer *r,
-			   size_t n,
-			   char __user *buf);
-
-/**
- * iio_request_update_sw_rb() - update params if update needed
- * @r:		pointer to a software ring buffer created by an
- *		iio_create_sw_rb call
- **/
-int iio_request_update_sw_rb(struct iio_ring_buffer *r);
-
-/**
- * iio_mark_update_needed_sw_rb() - tell the ring buffer it needs a param update
- * @r:		pointer to a software ring buffer created by an
- *		iio_create_sw_rb call
- **/
-int iio_mark_update_needed_sw_rb(struct iio_ring_buffer *r);
-
-
-/**
- * iio_get_bytes_per_datum_sw_rb() - get the datum size in bytes
- * @r:		pointer to a software ring buffer created by an
- *		iio_create_sw_rb call
- **/
-int iio_get_bytes_per_datum_sw_rb(struct iio_ring_buffer *r);
-
-/**
- * iio_set_bytes_per_datum_sw_rb() - set the datum size in bytes
- * @r:		pointer to a software ring buffer created by an
- *		iio_create_sw_rb call
- * @bpd:	bytes per datum value
- **/
-int iio_set_bytes_per_datum_sw_rb(struct iio_ring_buffer *r, size_t bpd);
-
-/**
- * iio_get_length_sw_rb() - get how many datums the rb may contain
- * @r:		pointer to a software ring buffer created by an
- *		iio_create_sw_rb call
- **/
-int iio_get_length_sw_rb(struct iio_ring_buffer *r);
-
-/**
- * iio_set_length_sw_rb() - set how many datums the rb may contain
- * @r:		pointer to a software ring buffer created by an
- *		iio_create_sw_rb call
- * @length:	max number of data items for the ring buffer
- **/
-int iio_set_length_sw_rb(struct iio_ring_buffer *r, int length);
-
-/**
- * iio_ring_sw_register_funcs() - helper function to set up rb access
- * @ra:		pointer to @iio_ring_access_funcs
- **/
-static inline void iio_ring_sw_register_funcs(struct iio_ring_access_funcs *ra)
-{
-	ra->mark_in_use = &iio_mark_sw_rb_in_use;
-	ra->unmark_in_use = &iio_unmark_sw_rb_in_use;
-
-	ra->store_to = &iio_store_to_sw_rb;
-	ra->read_last = &iio_read_last_from_sw_rb;
-	ra->read_first_n = &iio_read_first_n_sw_rb;
-
-	ra->mark_param_change = &iio_mark_update_needed_sw_rb;
-	ra->request_update = &iio_request_update_sw_rb;
-
-	ra->get_bytes_per_datum = &iio_get_bytes_per_datum_sw_rb;
-	ra->set_bytes_per_datum = &iio_set_bytes_per_datum_sw_rb;
-
-	ra->get_length = &iio_get_length_sw_rb;
-	ra->set_length = &iio_set_length_sw_rb;
-};
-
-/**
- * struct iio_sw_ring_buffer - software ring buffer
- * @buf:		generic ring buffer elements
- * @data:		the ring buffer memory
- * @read_p:		read pointer (oldest available)
- * @write_p:		write pointer
- * @last_written_p:	read pointer (newest available)
- * @half_p:		half buffer length behind write_p (event generation)
- * @use_count:		reference count to prevent resizing when in use
- * @update_needed:	flag to indicated change in size requested
- * @use_lock:		lock to prevent change in size when in use
- *
- * Note that the first element of all ring buffers must be a
- * struct iio_ring_buffer.
-**/
-
-struct iio_sw_ring_buffer {
-	struct iio_ring_buffer  buf;
-	unsigned char		*data;
-	unsigned char		*read_p;
-	unsigned char		*write_p;
-	unsigned char		*last_written_p;
-	/* used to act as a point at which to signal an event */
-	unsigned char		*half_p;
-	int			use_count;
-	int			update_needed;
-	spinlock_t		use_lock;
-};
-
-#define iio_to_sw_ring(r) container_of(r, struct iio_sw_ring_buffer, buf)
+extern const struct iio_ring_access_funcs ring_sw_access_funcs;
 
 struct iio_ring_buffer *iio_sw_rb_allocate(struct iio_dev *indio_dev);
 void iio_sw_rb_free(struct iio_ring_buffer *ring);
 
-int iio_sw_ring_preenable(struct iio_dev *indio_dev);
-
 struct iio_sw_ring_helper_state {
 	struct work_struct		work_trigger_to_ring;
 	struct iio_dev			*indio_dev;
-- 
1.7.3.4

