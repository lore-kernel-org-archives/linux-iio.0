Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:53665 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759399Ab2DJUie (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Apr 2012 16:38:34 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org, greg@kroah.com,
	dmitry.torokhov@gmail.com, broonie@opensource.wolfsonmicro.com,
	alan@lxorguk.ukuu.org.uk, arnd@arndb.de, linus.walleij@linaro.org,
	maxime.ripard@free-electrons.com,
	thomas.petazzoni@free-electrons.com, zdevai@gmail.com,
	w.sang@pengutronix.de, marek.vasut@gmail.com,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 1/4] staging:iio: make all buffer access pass through the buffer_list
Date: Tue, 10 Apr 2012 21:38:11 +0100
Message-Id: <1334090294-23407-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1334090294-23407-1-git-send-email-jic23@kernel.org>
References: <1334090294-23407-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Jonathan Cameron <jic23@cam.ac.uk>

Crucial step in allowing multiple interfaces.

Main stages:

1) Ensure no trigger_handler touches the buffers directly.
They should only care about active_scan_mask and scan_timestamp
in indio_dev.
2) Ensure all setup ops for the buffers act on the general mode
and the individual buffers in a consistent fashion.
3) Make use of iio_sw_buffer_preenable where possibe. It's never
in a particular fast path so even if overcomplex it is worth
using to cut down on code duplication.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/adis16201_ring.c      |    9 +-
 drivers/staging/iio/accel/adis16203_ring.c      |   11 +-
 drivers/staging/iio/accel/adis16204_ring.c      |    8 +-
 drivers/staging/iio/accel/adis16209_ring.c      |    9 +-
 drivers/staging/iio/accel/adis16240_ring.c      |    9 +-
 drivers/staging/iio/accel/lis3l02dq_ring.c      |    9 +-
 drivers/staging/iio/adc/ad7192.c                |   27 +-
 drivers/staging/iio/adc/ad7298.h                |    1 -
 drivers/staging/iio/adc/ad7298_ring.c           |   31 +-
 drivers/staging/iio/adc/ad7476.h                |    1 -
 drivers/staging/iio/adc/ad7476_ring.c           |   40 +-
 drivers/staging/iio/adc/ad7606_ring.c           |   11 +-
 drivers/staging/iio/adc/ad7793.c                |   26 +-
 drivers/staging/iio/adc/ad7887.h                |    1 -
 drivers/staging/iio/adc/ad7887_ring.c           |   28 +-
 drivers/staging/iio/adc/ad799x.h                |    1 -
 drivers/staging/iio/adc/ad799x_ring.c           |   27 +-
 drivers/staging/iio/adc/max1363_ring.c          |    6 +-
 drivers/staging/iio/buffer.h                    |   24 +-
 drivers/staging/iio/gyro/adis16260_ring.c       |    8 +-
 drivers/staging/iio/iio.h                       |    8 +
 drivers/staging/iio/iio_simple_dummy_buffer.c   |   16 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c |   14 +-
 drivers/staging/iio/imu/adis16400_ring.c        |    6 +-
 drivers/staging/iio/industrialio-buffer.c       |  553 ++++++++++++++---------
 drivers/staging/iio/industrialio-core.c         |    1 +
 drivers/staging/iio/meter/ade7758_ring.c        |   25 +-
 27 files changed, 455 insertions(+), 455 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_ring.c b/drivers/staging/iio/accel/adis16201_ring.c
index 97f9e6b..f3673c2 100644
--- a/drivers/staging/iio/accel/adis16201_ring.c
+++ b/drivers/staging/iio/accel/adis16201_ring.c
@@ -62,13 +62,10 @@ static irqreturn_t adis16201_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16201_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
-
 	int i = 0;
 	s16 *data;
-	size_t datasize = ring->access->get_bytes_per_datum(ring);
 
-	data = kmalloc(datasize, GFP_KERNEL);
+	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(&st->us->dev, "memory alloc failed in ring bh");
 		return -ENOMEM;
@@ -81,10 +78,10 @@ static irqreturn_t adis16201_trigger_handler(int irq, void *p)
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
index 6a8963d..456bb22 100644
--- a/drivers/staging/iio/accel/adis16203_ring.c
+++ b/drivers/staging/iio/accel/adis16203_ring.c
@@ -62,13 +62,10 @@ static irqreturn_t adis16203_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16203_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
-
 	int i = 0;
 	s16 *data;
-	size_t datasize = ring->access->get_bytes_per_datum(ring);
 
-	data = kmalloc(datasize, GFP_KERNEL);
+	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(&st->us->dev, "memory alloc failed in ring bh");
 		return -ENOMEM;
@@ -81,12 +78,10 @@ static irqreturn_t adis16203_trigger_handler(int irq, void *p)
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
index 5c8ab73..cc0f699 100644
--- a/drivers/staging/iio/accel/adis16204_ring.c
+++ b/drivers/staging/iio/accel/adis16204_ring.c
@@ -60,12 +60,10 @@ static irqreturn_t adis16204_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16204_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
 	int i = 0;
 	s16 *data;
-	size_t datasize = ring->access->get_bytes_per_datum(ring);
 
-	data = kmalloc(datasize, GFP_KERNEL);
+	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(&st->us->dev, "memory alloc failed in ring bh");
 		return -ENOMEM;
@@ -78,10 +76,10 @@ static irqreturn_t adis16204_trigger_handler(int irq, void *p)
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
index 57254b6..2c95f3d 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -60,13 +60,10 @@ static irqreturn_t adis16209_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16209_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
-
 	int i = 0;
 	s16 *data;
-	size_t datasize = ring->access->get_bytes_per_datum(ring);
 
-	data = kmalloc(datasize , GFP_KERNEL);
+	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(&st->us->dev, "memory alloc failed in ring bh");
 		return -ENOMEM;
@@ -79,10 +76,10 @@ static irqreturn_t adis16209_trigger_handler(int irq, void *p)
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
index 43ba84e..ee04154 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -57,13 +57,10 @@ static irqreturn_t adis16240_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16240_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
-
 	int i = 0;
 	s16 *data;
-	size_t datasize = ring->access->get_bytes_per_datum(ring);
 
-	data = kmalloc(datasize, GFP_KERNEL);
+	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(&st->us->dev, "memory alloc failed in ring bh");
 		return -ENOMEM;
@@ -76,10 +73,10 @@ static irqreturn_t adis16240_trigger_handler(int irq, void *p)
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
index 0fc3973..b493034 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -135,11 +135,10 @@ static irqreturn_t lis3l02dq_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	struct iio_buffer *buffer = indio_dev->buffer;
 	int len = 0;
-	size_t datasize = buffer->access->get_bytes_per_datum(buffer);
-	char *data = kmalloc(datasize, GFP_KERNEL);
+	char *data;
 
+	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(indio_dev->dev.parent,
 			"memory alloc failed in buffer bh");
@@ -150,11 +149,11 @@ static irqreturn_t lis3l02dq_trigger_handler(int irq, void *p)
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
index 9d3e037..fd920b0 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -456,31 +456,19 @@ out:
 static int ad7192_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct ad7192_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
-	size_t d_size;
 	unsigned channel;
+	int ret;
 
 	if (bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
 		return -EINVAL;
 
+	ret = iio_sw_buffer_preenable(indio_dev);
+	if (ret < 0)
+		return ret;
+
 	channel = find_first_bit(indio_dev->active_scan_mask,
 				 indio_dev->masklength);
 
-	d_size = bitmap_weight(indio_dev->active_scan_mask,
-			       indio_dev->masklength) *
-		 indio_dev->channels[0].scan_type.storagebits / 8;
-
-	if (ring->scan_timestamp) {
-		d_size += sizeof(s64);
-
-		if (d_size % sizeof(s64))
-			d_size += sizeof(s64) - (d_size % sizeof(s64));
-	}
-
-	if (indio_dev->buffer->access->set_bytes_per_datum)
-		indio_dev->buffer->access->
-			set_bytes_per_datum(indio_dev->buffer, d_size);
-
 	st->mode  = (st->mode & ~AD7192_MODE_SEL(-1)) |
 		    AD7192_MODE_SEL(AD7192_MODE_CONT);
 	st->conf  = (st->conf & ~AD7192_CONF_CHAN(-1)) |
@@ -522,7 +510,6 @@ static irqreturn_t ad7192_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	struct iio_buffer *ring = indio_dev->buffer;
 	struct ad7192_state *st = iio_priv(indio_dev);
 	s64 dat64[2];
 	s32 *dat32 = (s32 *)dat64;
@@ -533,10 +520,10 @@ static irqreturn_t ad7192_trigger_handler(int irq, void *p)
 				  indio_dev->channels[0].scan_type.realbits/8);
 
 	/* Guaranteed to be aligned with 8 byte boundary */
-	if (ring->scan_timestamp)
+	if (indio_dev->scan_timestamp)
 		dat64[1] = pf->timestamp;
 
-	ring->access->store_to(ring, (u8 *)dat64, pf->timestamp);
+	iio_push_to_buffers(indio_dev, (u8 *)dat64, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 	st->irq_dis = false;
diff --git a/drivers/staging/iio/adc/ad7298.h b/drivers/staging/iio/adc/ad7298.h
index a0e5dea..5051a7e 100644
--- a/drivers/staging/iio/adc/ad7298.h
+++ b/drivers/staging/iio/adc/ad7298.h
@@ -38,7 +38,6 @@ struct ad7298_platform_data {
 struct ad7298_state {
 	struct spi_device		*spi;
 	struct regulator		*reg;
-	size_t				d_size;
 	u16				int_vref_mv;
 	unsigned			ext_ref;
 	struct spi_transfer		ring_xfer[10];
diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
index feeb0ee..52ddfdf 100644
--- a/drivers/staging/iio/adc/ad7298_ring.c
+++ b/drivers/staging/iio/adc/ad7298_ring.c
@@ -28,25 +28,17 @@
 static int ad7298_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct ad7298_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
-	size_t d_size;
 	int i, m;
 	unsigned short command;
-	int scan_count = bitmap_weight(indio_dev->active_scan_mask,
-				       indio_dev->masklength);
-	d_size = scan_count * (AD7298_STORAGE_BITS / 8);
+	int scan_count, ret;
 
-	if (ring->scan_timestamp) {
-		d_size += sizeof(s64);
+	ret = iio_sw_buffer_preenable(indio_dev);
+	if (ret < 0)
+		return ret;
 
-		if (d_size % sizeof(s64))
-			d_size += sizeof(s64) - (d_size % sizeof(s64));
-	}
-
-	if (ring->access->set_bytes_per_datum)
-		ring->access->set_bytes_per_datum(ring, d_size);
-
-	st->d_size = d_size;
+	/* Now compute overall size */
+	scan_count = bitmap_weight(indio_dev->active_scan_mask,
+				   indio_dev->masklength);
 
 	command = AD7298_WRITE | st->ext_ref;
 
@@ -91,7 +83,6 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad7298_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
 	s64 time_ns;
 	__u16 buf[16];
 	int b_sent, i;
@@ -100,17 +91,17 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
 	if (b_sent)
 		return b_sent;
 
-	if (ring->scan_timestamp) {
+	if (indio_dev->scan_timestamp) {
 		time_ns = iio_get_time_ns();
-		memcpy((u8 *)buf + st->d_size - sizeof(s64),
+		memcpy((u8 *)buf + indio_dev->scan_bytes - sizeof(s64),
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
diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
index d6af6c0..21bce39 100644
--- a/drivers/staging/iio/adc/ad7476_ring.c
+++ b/drivers/staging/iio/adc/ad7476_ring.c
@@ -20,36 +20,6 @@
 
 #include "ad7476.h"
 
-/**
- * ad7476_ring_preenable() setup the parameters of the ring before enabling
- *
- * The complex nature of the setting of the number of bytes per datum is due
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
@@ -59,7 +29,7 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
 	__u8 *rxbuf;
 	int b_sent;
 
-	rxbuf = kzalloc(st->d_size, GFP_KERNEL);
+	rxbuf = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (rxbuf == NULL)
 		return -ENOMEM;
 
@@ -70,11 +40,11 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
 
 	time_ns = iio_get_time_ns();
 
-	if (indio_dev->buffer->scan_timestamp)
-		memcpy(rxbuf + st->d_size - sizeof(s64),
+	if (indio_dev->scan_timestamp)
+		memcpy(rxbuf + indio_dev->scan_bytes - sizeof(s64),
 			&time_ns, sizeof(time_ns));
 
-	indio_dev->buffer->access->store_to(indio_dev->buffer, rxbuf, time_ns);
+	iio_push_to_buffers(indio_dev, rxbuf, time_ns);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 	kfree(rxbuf);
@@ -83,7 +53,7 @@ done:
 }
 
 static const struct iio_buffer_setup_ops ad7476_ring_setup_ops = {
-	.preenable = &ad7476_ring_preenable,
+	.preenable = &iio_sw_buffer_preenable,
 	.postenable = &iio_triggered_buffer_postenable,
 	.predisable = &iio_triggered_buffer_predisable,
 };
diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index 1ef9fbc..2d36a7a 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -46,13 +46,11 @@ static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
 	struct ad7606_state *st = container_of(work_s, struct ad7606_state,
 						poll_work);
 	struct iio_dev *indio_dev = iio_priv_to_dev(st);
-	struct iio_buffer *ring = indio_dev->buffer;
 	s64 time_ns;
 	__u8 *buf;
 	int ret;
 
-	buf = kzalloc(ring->access->get_bytes_per_datum(ring),
-		      GFP_KERNEL);
+	buf = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (buf == NULL)
 		return;
 
@@ -82,11 +80,10 @@ static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
 
 	time_ns = iio_get_time_ns();
 
-	if (ring->scan_timestamp)
-		*((s64 *)(buf + ring->access->get_bytes_per_datum(ring) -
-			  sizeof(s64))) = time_ns;
+	if (indio_dev->scan_timestamp)
+		*((s64 *)(buf + indio_dev->scan_bytes - sizeof(s64))) = time_ns;
 
-	ring->access->store_to(indio_dev->buffer, buf, time_ns);
+	iio_push_to_buffers(indio_dev, buf, time_ns);
 done:
 	gpio_set_value(st->pdata->gpio_convst, 0);
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index f7f7648d6..93f2391 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -319,31 +319,18 @@ out:
 static int ad7793_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct ad7793_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
-	size_t d_size;
 	unsigned channel;
+	int ret;
 
 	if (bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
 		return -EINVAL;
+	ret = iio_sw_buffer_preenable(indio_dev);
+	if (ret < 0)
+		return ret;
 
 	channel = find_first_bit(indio_dev->active_scan_mask,
 				 indio_dev->masklength);
 
-	d_size = bitmap_weight(indio_dev->active_scan_mask,
-			       indio_dev->masklength) *
-		indio_dev->channels[0].scan_type.storagebits / 8;
-
-	if (ring->scan_timestamp) {
-		d_size += sizeof(s64);
-
-		if (d_size % sizeof(s64))
-			d_size += sizeof(s64) - (d_size % sizeof(s64));
-	}
-
-	if (indio_dev->buffer->access->set_bytes_per_datum)
-		indio_dev->buffer->access->
-			set_bytes_per_datum(indio_dev->buffer, d_size);
-
 	st->mode  = (st->mode & ~AD7793_MODE_SEL(-1)) |
 		    AD7793_MODE_SEL(AD7793_MODE_CONT);
 	st->conf  = (st->conf & ~AD7793_CONF_CHAN(-1)) |
@@ -388,7 +375,6 @@ static irqreturn_t ad7793_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	struct iio_buffer *ring = indio_dev->buffer;
 	struct ad7793_state *st = iio_priv(indio_dev);
 	s64 dat64[2];
 	s32 *dat32 = (s32 *)dat64;
@@ -399,10 +385,10 @@ static irqreturn_t ad7793_trigger_handler(int irq, void *p)
 				  indio_dev->channels[0].scan_type.realbits/8);
 
 	/* Guaranteed to be aligned with 8 byte boundary */
-	if (ring->scan_timestamp)
+	if (indio_dev->scan_timestamp)
 		dat64[1] = pf->timestamp;
 
-	ring->access->store_to(ring, (u8 *)dat64, pf->timestamp);
+	iio_push_to_buffers(indio_dev, (u8 *)dat64, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 	st->irq_dis = false;
diff --git a/drivers/staging/iio/adc/ad7887.h b/drivers/staging/iio/adc/ad7887.h
index bc53b65..2e09e54 100644
--- a/drivers/staging/iio/adc/ad7887.h
+++ b/drivers/staging/iio/adc/ad7887.h
@@ -63,7 +63,6 @@ struct ad7887_state {
 	struct spi_device		*spi;
 	const struct ad7887_chip_info	*chip_info;
 	struct regulator		*reg;
-	size_t				d_size;
 	u16				int_vref_mv;
 	struct spi_transfer		xfer[4];
 	struct spi_message		msg[3];
diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
index d180907..cdfcc91 100644
--- a/drivers/staging/iio/adc/ad7887_ring.c
+++ b/drivers/staging/iio/adc/ad7887_ring.c
@@ -29,22 +29,11 @@
 static int ad7887_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct ad7887_state *st = iio_priv(indio_dev);
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
+	int ret;
 
-	if (indio_dev->buffer->access->set_bytes_per_datum)
-		indio_dev->buffer->access->
-			set_bytes_per_datum(indio_dev->buffer, st->d_size);
+	ret = iio_sw_buffer_preenable(indio_dev);
+	if (ret < 0)
+		return ret;
 
 	/* We know this is a single long so can 'cheat' */
 	switch (*indio_dev->active_scan_mask) {
@@ -83,7 +72,6 @@ static irqreturn_t ad7887_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad7887_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
 	s64 time_ns;
 	__u8 *buf;
 	int b_sent;
@@ -92,7 +80,7 @@ static irqreturn_t ad7887_trigger_handler(int irq, void *p)
 					   indio_dev->masklength) *
 		st->chip_info->channel[0].scan_type.storagebits / 8;
 
-	buf = kzalloc(st->d_size, GFP_KERNEL);
+	buf = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (buf == NULL)
 		return -ENOMEM;
 
@@ -103,11 +91,11 @@ static irqreturn_t ad7887_trigger_handler(int irq, void *p)
 	time_ns = iio_get_time_ns();
 
 	memcpy(buf, st->data, bytes);
-	if (ring->scan_timestamp)
-		memcpy(buf + st->d_size - sizeof(s64),
+	if (indio_dev->scan_timestamp)
+		memcpy(buf + indio_dev->scan_bytes - sizeof(s64),
 		       &time_ns, sizeof(time_ns));
 
-	indio_dev->buffer->access->store_to(indio_dev->buffer, buf, time_ns);
+	iio_push_to_buffers(indio_dev, buf, time_ns);
 done:
 	kfree(buf);
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/staging/iio/adc/ad799x.h b/drivers/staging/iio/adc/ad799x.h
index 356f690..99f8abe 100644
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
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index 069765c..f09b7ef 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -32,9 +32,7 @@
  **/
 static int ad799x_ring_preenable(struct iio_dev *indio_dev)
 {
-	struct iio_buffer *ring = indio_dev->buffer;
 	struct ad799x_state *st = iio_priv(indio_dev);
-
 	/*
 	 * Need to figure out the current mode based upon the requested
 	 * scan mask in iio_dev
@@ -43,21 +41,7 @@ static int ad799x_ring_preenable(struct iio_dev *indio_dev)
 	if (st->id == ad7997 || st->id == ad7998)
 		ad7997_8_set_scan_mode(st, *indio_dev->active_scan_mask);
 
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
+	return iio_sw_buffer_preenable(indio_dev);
 }
 
 /**
@@ -72,13 +56,12 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad799x_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
 	s64 time_ns;
 	__u8 *rxbuf;
 	int b_sent;
 	u8 cmd;
 
-	rxbuf = kmalloc(st->d_size, GFP_KERNEL);
+	rxbuf = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (rxbuf == NULL)
 		goto out;
 
@@ -111,11 +94,11 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 
 	time_ns = iio_get_time_ns();
 
-	if (ring->scan_timestamp)
-		memcpy(rxbuf + st->d_size - sizeof(s64),
+	if (indio_dev->scan_timestamp)
+		memcpy(rxbuf + indio_dev->scan_bytes - sizeof(s64),
 			&time_ns, sizeof(time_ns));
 
-	ring->access->store_to(indio_dev->buffer, rxbuf, time_ns);
+	iio_push_to_buffers(indio_dev, rxbuf, time_ns);
 done:
 	kfree(rxbuf);
 	if (b_sent < 0)
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index d0a60a3..d20218d 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -54,7 +54,7 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
 		d_size = numvals*2;
 	else
 		d_size = numvals;
-	if (indio_dev->buffer->scan_timestamp) {
+	if (indio_dev->scan_timestamp) {
 		d_size += sizeof(s64);
 		if (d_size % sizeof(s64))
 			d_size += sizeof(s64) - (d_size % sizeof(s64));
@@ -78,9 +78,9 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
 
 	time_ns = iio_get_time_ns();
 
-	if (indio_dev->buffer->scan_timestamp)
+	if (indio_dev->scan_timestamp)
 		memcpy(rxbuf + d_size - sizeof(s64), &time_ns, sizeof(time_ns));
-	iio_push_to_buffer(indio_dev->buffer, rxbuf, time_ns);
+	iio_push_to_buffers(indio_dev, rxbuf, time_ns);
 
 done:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/staging/iio/buffer.h b/drivers/staging/iio/buffer.h
index df2046d..df7ec46 100644
--- a/drivers/staging/iio/buffer.h
+++ b/drivers/staging/iio/buffer.h
@@ -67,7 +67,8 @@ struct iio_buffer_access_funcs {
  * @stufftoread:	[INTERN] flag to indicate new data.
  * @demux_list:		[INTERN] list of operations required to demux the scan.
  * @demux_bounce:	[INTERN] buffer for doing gather from incoming scan.
- **/
+ * @buffer_list:	[INTERN] entry in the devices list of current buffers.
+ */
 struct iio_buffer {
 	int					length;
 	int					bytes_per_datum;
@@ -83,9 +84,22 @@ struct iio_buffer {
 	const struct attribute_group *attrs;
 	struct list_head			demux_list;
 	unsigned char				*demux_bounce;
+	struct list_head			buffer_list;
 };
 
 /**
+ * iio_update_buffers() - add or remove buffer from active list
+ * @indio_dev:		device to add buffer to
+ * @insert_buffer:	buffer to insert
+ * @remove_buffer:	buffer_to_remove
+ *
+ * Note this will tear down the all buffering and build it up again
+ */
+int iio_update_buffers(struct iio_dev *indio_dev,
+		       struct iio_buffer *insert_buffer,
+		       struct iio_buffer *remove_buffer);
+
+/**
  * iio_buffer_init() - Initialize the buffer structure
  * @buffer: buffer to be initialized
  **/
@@ -116,12 +130,12 @@ int iio_scan_mask_set(struct iio_dev *indio_dev,
 		      struct iio_buffer *buffer, int bit);
 
 /**
- * iio_push_to_buffer() - push to a registered buffer.
- * @buffer:		IIO buffer structure for device
- * @scan:		Full scan.
+ * iio_push_to_buffers() - push to a registered buffer.
+ * @indio_dev:		iio_dev structure for device.
+ * @data:		Full scan.
  * @timestamp:
  */
-int iio_push_to_buffer(struct iio_buffer *buffer, unsigned char *data,
+int iio_push_to_buffers(struct iio_dev *indio_dev, unsigned char *data,
 		       s64 timestamp);
 
 int iio_update_demux(struct iio_dev *indio_dev);
diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index 711f151..59cc200 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -63,12 +63,10 @@ static irqreturn_t adis16260_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16260_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
 	int i = 0;
 	s16 *data;
-	size_t datasize = ring->access->get_bytes_per_datum(ring);
 
-	data = kmalloc(datasize , GFP_KERNEL);
+	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(&st->us->dev, "memory alloc failed in ring bh");
 		return -ENOMEM;
@@ -81,10 +79,10 @@ static irqreturn_t adis16260_trigger_handler(int irq, void *p)
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
index d96ee4b..8256eb9 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -300,12 +300,16 @@ struct iio_buffer_setup_ops {
  *			and owner
  * @event_interface:	[INTERN] event chrdevs associated with interrupt lines
  * @buffer:		[DRIVER] any buffer present
+ * @buffer_list:	[INTERN] list of all buffers currently attached
+ * @scan_bytes:		[INTERN] num bytes captured to be fed to buffer demux
  * @mlock:		[INTERN] lock used to prevent simultaneous device state
  *			changes
  * @available_scan_masks: [DRIVER] optional array of allowed bitmasks
  * @masklength:		[INTERN] the length of the mask established from
  *			channels
  * @active_scan_mask:	[INTERN] union of all scan masks requested by buffers
+ * @scan_timestamp:	[INTERN] set if any buffers have requested timestamp
+ * @scan_index_timestamp:[INTERN] cache of the index to the timestamp
  * @trig:		[INTERN] current device trigger (buffer modes)
  * @pollfunc:		[DRIVER] function run on trigger being received
  * @channels:		[DRIVER] channel specification structure table
@@ -335,11 +339,15 @@ struct iio_dev {
 	struct iio_event_interface	*event_interface;
 
 	struct iio_buffer		*buffer;
+	struct list_head		buffer_list;
+	int				scan_bytes;
 	struct mutex			mlock;
 
 	const unsigned long		*available_scan_masks;
 	unsigned			masklength;
 	const unsigned long		*active_scan_mask;
+	bool				scan_timestamp;
+	unsigned			scan_index_timestamp;
 	struct iio_trigger		*trig;
 	struct iio_poll_func		*pollfunc;
 
diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
index bb4daf7..5be4749 100644
--- a/drivers/staging/iio/iio_simple_dummy_buffer.c
+++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
@@ -46,14 +46,10 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	struct iio_buffer *buffer = indio_dev->buffer;
 	int len = 0;
-	/*
-	 * The datasize is obtained from the buffer. It was stored when
-	 * the preenable setup function was called.
-	 */
-	size_t datasize = buffer->access->get_bytes_per_datum(buffer);
-	u16 *data = kmalloc(datasize, GFP_KERNEL);
+	u16 *data;
+
+	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (data == NULL)
 		return -ENOMEM;
 
@@ -79,7 +75,7 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 		     i < bitmap_weight(indio_dev->active_scan_mask,
 				       indio_dev->masklength);
 		     i++) {
-			j = find_next_bit(buffer->scan_mask,
+			j = find_next_bit(indio_dev->buffer->scan_mask,
 					  indio_dev->masklength, j + 1);
 			/* random access read form the 'device' */
 			data[i] = fakedata[j];
@@ -87,11 +83,11 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
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
index 06b9fe2..652f500 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -566,19 +566,14 @@ static const struct iio_info ad5933_info = {
 static int ad5933_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct ad5933_state *st = iio_priv(indio_dev);
-	size_t d_size;
 	int ret;
 
 	if (bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
 		return -EINVAL;
 
-	d_size = bitmap_weight(indio_dev->active_scan_mask,
-			       indio_dev->masklength) *
-		 ad5933_channels[1].scan_type.storagebits / 8;
-
-	if (indio_dev->buffer->access->set_bytes_per_datum)
-		indio_dev->buffer->access->
-			set_bytes_per_datum(indio_dev->buffer, d_size);
+	ret = iio_sw_buffer_preenable(indio_dev);
+	if (ret < 0)
+		return ret;
 
 	ret = ad5933_reset(st);
 	if (ret < 0)
@@ -649,7 +644,6 @@ static void ad5933_work(struct work_struct *work)
 	struct ad5933_state *st = container_of(work,
 		struct ad5933_state, work.work);
 	struct iio_dev *indio_dev = i2c_get_clientdata(st->client);
-	struct iio_buffer *ring = indio_dev->buffer;
 	signed short buf[2];
 	unsigned char status;
 
@@ -680,7 +674,7 @@ static void ad5933_work(struct work_struct *work)
 			buf[0] = be16_to_cpu(buf[0]);
 		}
 		/* save datum to the ring */
-		ring->access->store_to(ring, (u8 *)buf, iio_get_time_ns());
+		iio_push_to_buffers(indio_dev, (u8 *)buf, iio_get_time_ns());
 	} else {
 		/* no data available - try again later */
 		schedule_delayed_work(&st->work, st->poll_time_jiffies);
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index 8daa038..a0b227e 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -119,12 +119,12 @@ static irqreturn_t adis16400_trigger_handler(int irq, void *p)
 	struct iio_buffer *ring = indio_dev->buffer;
 	int i = 0, j, ret = 0;
 	s16 *data;
-	size_t datasize = ring->access->get_bytes_per_datum(ring);
+
 	/* Asumption that long is enough for maximum channels */
 	unsigned long mask = *indio_dev->active_scan_mask;
 	int scan_count = bitmap_weight(indio_dev->active_scan_mask,
 				       indio_dev->masklength);
-	data = kmalloc(datasize , GFP_KERNEL);
+	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(&st->us->dev, "memory alloc failed in ring bh");
 		return -ENOMEM;
@@ -152,7 +152,7 @@ static irqreturn_t adis16400_trigger_handler(int irq, void *p)
 	/* Guaranteed to be aligned with 8 byte boundary */
 	if (ring->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
-	ring->access->store_to(indio_dev->buffer, (u8 *) data, pf->timestamp);
+	iio_push_to_buffers(indio_dev, (u8 *) data, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 
diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index 386ba76..db6e930 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -31,6 +31,16 @@ static const char * const iio_endian_prefix[] = {
 	[IIO_LE] = "le",
 };
 
+static bool iio_buffer_is_primary_active(struct iio_dev *indio_dev)
+{
+	struct list_head *p;
+
+	list_for_each(p, &indio_dev->buffer_list)
+		if (p == &indio_dev->buffer->buffer_list)
+			return true;
+	return false;
+}
+
 /**
  * iio_buffer_read_first_n_outer() - chrdev read for buffer access
  *
@@ -124,15 +134,17 @@ static ssize_t iio_scan_el_store(struct device *dev,
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
-	if (iio_buffer_enabled(indio_dev)) {
+	if (iio_buffer_is_primary_active(indio_dev)) {
 		ret = -EBUSY;
 		goto error_ret;
 	}
@@ -169,13 +181,16 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
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
-	if (iio_buffer_enabled(indio_dev)) {
+	if (iio_buffer_is_primary_active(indio_dev)) {
 		ret = -EBUSY;
 		goto error_ret;
 	}
@@ -276,32 +291,30 @@ int iio_buffer_register(struct iio_dev *indio_dev,
 	}
 	attrcount = attrcount_orig;
 	INIT_LIST_HEAD(&buffer->scan_el_dev_attr_list);
-	if (channels) {
-		/* new magic */
-		for (i = 0; i < num_channels; i++) {
-			/* Establish necessary mask length */
-			if (channels[i].scan_index >
-			    (int)indio_dev->masklength - 1)
-				indio_dev->masklength
-					= indio_dev->channels[i].scan_index + 1;
-
-			ret = iio_buffer_add_channel_sysfs(indio_dev,
-							 &channels[i]);
-			if (ret < 0)
-				goto error_cleanup_dynamic;
-			attrcount += ret;
-			if (channels[i].type == IIO_TIMESTAMP)
-				buffer->scan_index_timestamp =
-					channels[i].scan_index;
-		}
-		if (indio_dev->masklength && buffer->scan_mask == NULL) {
-			buffer->scan_mask = kcalloc(BITS_TO_LONGS(indio_dev->masklength),
-						    sizeof(*buffer->scan_mask),
-						    GFP_KERNEL);
-			if (buffer->scan_mask == NULL) {
-				ret = -ENOMEM;
-				goto error_cleanup_dynamic;
-			}
+	for (i = 0; i < num_channels; i++) {
+		/* Establish necessary mask length */
+		if (channels[i].scan_index >
+		    (int)indio_dev->masklength - 1)
+			indio_dev->masklength
+				= indio_dev->channels[i].scan_index + 1;
+
+		ret = iio_buffer_add_channel_sysfs(indio_dev,
+						   &channels[i]);
+		if (ret < 0)
+			goto error_cleanup_dynamic;
+		attrcount += ret;
+		if (channels[i].type == IIO_TIMESTAMP)
+			indio_dev->scan_index_timestamp =
+				channels[i].scan_index;
+	}
+	if (indio_dev->masklength && buffer->scan_mask == NULL) {
+		buffer->scan_mask
+			= kcalloc(BITS_TO_LONGS(indio_dev->masklength),
+				  sizeof(*buffer->scan_mask),
+				  GFP_KERNEL);
+		if (buffer->scan_mask == NULL) {
+			ret = -ENOMEM;
+			goto error_cleanup_dynamic;
 		}
 	}
 
@@ -389,106 +402,6 @@ ssize_t iio_buffer_write_length(struct device *dev,
 }
 EXPORT_SYMBOL(iio_buffer_write_length);
 
-ssize_t iio_buffer_store_enable(struct device *dev,
-				struct device_attribute *attr,
-				const char *buf,
-				size_t len)
-{
-	int ret;
-	bool requested_state, current_state;
-	int previous_mode;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
-
-	mutex_lock(&indio_dev->mlock);
-	previous_mode = indio_dev->currentmode;
-	requested_state = !(buf[0] == '0');
-	current_state = iio_buffer_enabled(indio_dev);
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
-				goto error_ret;
-			}
-		}
-		if (buffer->access->request_update) {
-			ret = buffer->access->request_update(buffer);
-			if (ret) {
-				printk(KERN_INFO
-				       "Buffer not started:"
-				       "buffer parameter update failed\n");
-				goto error_ret;
-			}
-		}
-		/* Definitely possible for devices to support both of these.*/
-		if (indio_dev->modes & INDIO_BUFFER_TRIGGERED) {
-			if (!indio_dev->trig) {
-				printk(KERN_INFO
-				       "Buffer not started: no trigger\n");
-				ret = -EINVAL;
-				goto error_ret;
-			}
-			indio_dev->currentmode = INDIO_BUFFER_TRIGGERED;
-		} else if (indio_dev->modes & INDIO_BUFFER_HARDWARE)
-			indio_dev->currentmode = INDIO_BUFFER_HARDWARE;
-		else { /* should never be reached */
-			ret = -EINVAL;
-			goto error_ret;
-		}
-
-		if (indio_dev->setup_ops->postenable) {
-			ret = indio_dev->setup_ops->postenable(indio_dev);
-			if (ret) {
-				printk(KERN_INFO
-				       "Buffer not started:"
-				       "postenable failed\n");
-				indio_dev->currentmode = previous_mode;
-				if (indio_dev->setup_ops->postdisable)
-					indio_dev->setup_ops->
-						postdisable(indio_dev);
-				goto error_ret;
-			}
-		}
-	} else {
-		if (indio_dev->setup_ops->predisable) {
-			ret = indio_dev->setup_ops->predisable(indio_dev);
-			if (ret)
-				goto error_ret;
-		}
-		indio_dev->currentmode = INDIO_DIRECT_MODE;
-		if (indio_dev->setup_ops->postdisable) {
-			ret = indio_dev->setup_ops->postdisable(indio_dev);
-			if (ret)
-				goto error_ret;
-		}
-	}
-done:
-	mutex_unlock(&indio_dev->mlock);
-	return len;
-
-error_ret:
-	mutex_unlock(&indio_dev->mlock);
-	return ret;
-}
-EXPORT_SYMBOL(iio_buffer_store_enable);
-
-ssize_t iio_buffer_show_enable(struct device *dev,
-			       struct device_attribute *attr,
-			       char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	return sprintf(buf, "%d\n", iio_buffer_enabled(indio_dev));
-}
-EXPORT_SYMBOL(iio_buffer_show_enable);
-
-/* note NULL used as error indicator as it doesn't make sense. */
 static const unsigned long *iio_scan_mask_match(const unsigned long *av_masks,
 					  unsigned int masklength,
 					  const unsigned long *mask)
@@ -503,45 +416,220 @@ static const unsigned long *iio_scan_mask_match(const unsigned long *av_masks,
 	return NULL;
 }
 
-int iio_sw_buffer_preenable(struct iio_dev *indio_dev)
+static int iio_compute_scan_bytes(struct iio_dev *indio_dev, const long *mask,
+				  bool timestamp)
 {
-	struct iio_buffer *buffer = indio_dev->buffer;
 	const struct iio_chan_spec *ch;
 	unsigned bytes = 0;
 	int length, i;
-	dev_dbg(&indio_dev->dev, "%s\n", __func__);
 
 	/* How much space will the demuxed element take? */
-	for_each_set_bit(i, buffer->scan_mask,
+	for_each_set_bit(i, mask,
 			 indio_dev->masklength) {
 		ch = iio_find_channel_from_si(indio_dev, i);
-		length = ch->scan_type.storagebits/8;
+		length = ch->scan_type.storagebits / 8;
 		bytes = ALIGN(bytes, length);
 		bytes += length;
 	}
-	if (buffer->scan_timestamp) {
+	if (timestamp) {
 		ch = iio_find_channel_from_si(indio_dev,
-					      buffer->scan_index_timestamp);
-		length = ch->scan_type.storagebits/8;
+					      indio_dev->scan_index_timestamp);
+		length = ch->scan_type.storagebits / 8;
 		bytes = ALIGN(bytes, length);
 		bytes += length;
 	}
-	buffer->access->set_bytes_per_datum(buffer, bytes);
+	return bytes;
+}
+
+int iio_update_buffers(struct iio_dev *indio_dev,
+		       struct iio_buffer *insert_buffer,
+		       struct iio_buffer *remove_buffer)
+{
+	int ret;
+	struct iio_buffer *buffer;
+	unsigned long *compound_mask;
+
+	/* Wind down existing buffers - iff there are any */
+	if (!list_empty(&indio_dev->buffer_list)) {
+		if (indio_dev->setup_ops->predisable) {
+			ret = indio_dev->setup_ops->predisable(indio_dev);
+			if (ret)
+				goto error_ret;
+		}
+		indio_dev->currentmode = INDIO_DIRECT_MODE;
+		if (indio_dev->setup_ops->postdisable) {
+			ret = indio_dev->setup_ops->postdisable(indio_dev);
+			if (ret)
+				goto error_ret;
+		}
+	}
+	if (!indio_dev->available_scan_masks)
+		kfree(indio_dev->active_scan_mask);
+
+	if (insert_buffer)
+		list_add(&insert_buffer->buffer_list, &indio_dev->buffer_list);
+	if (remove_buffer)
+		list_del(&remove_buffer->buffer_list);
+
+	/* If no buffers in list, we are done */
+	if (list_empty(&indio_dev->buffer_list))
+		return 0;
 
 	/* What scan mask do we actually have ?*/
+	compound_mask = kzalloc(BITS_TO_LONGS(indio_dev->masklength)
+				*sizeof(long), GFP_KERNEL);
+	if (compound_mask == NULL)
+		return -ENOMEM;
+	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
+		bitmap_or(compound_mask, compound_mask, buffer->scan_mask,
+			  indio_dev->masklength);
+		indio_dev->scan_timestamp |= buffer->scan_timestamp;
+	}
 	if (indio_dev->available_scan_masks)
 		indio_dev->active_scan_mask =
 			iio_scan_mask_match(indio_dev->available_scan_masks,
 					    indio_dev->masklength,
-					    buffer->scan_mask);
+					    compound_mask);
 	else
-		indio_dev->active_scan_mask = buffer->scan_mask;
+		indio_dev->active_scan_mask = compound_mask;
+
 	iio_update_demux(indio_dev);
 
-	if (indio_dev->info->update_scan_mode)
-		return indio_dev->info
+	/* Wind up again */
+	if (indio_dev->setup_ops->preenable) {
+		ret = indio_dev->setup_ops->preenable(indio_dev);
+		if (ret) {
+			printk(KERN_ERR
+			       "Buffer not started:"
+			       "buffer preenable failed\n");
+			goto error_free_compound_mask;
+		}
+	}
+	indio_dev->scan_bytes =
+		iio_compute_scan_bytes(indio_dev,
+				       indio_dev->active_scan_mask,
+				       indio_dev->scan_timestamp);
+	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list)
+		if (buffer->access->request_update) {
+			ret = buffer->access->request_update(buffer);
+			if (ret) {
+				printk(KERN_INFO
+				       "Buffer not started:"
+				       "buffer parameter update failed\n");
+				goto error_ret;
+			}
+		}
+	if (indio_dev->info->update_scan_mode) {
+		ret = indio_dev->info
 			->update_scan_mode(indio_dev,
 					   indio_dev->active_scan_mask);
+		if (ret < 0)
+			goto error_free_compound_mask;
+	}
+	/* Definitely possible for devices to support both of these.*/
+	if (indio_dev->modes & INDIO_BUFFER_TRIGGERED) {
+		if (!indio_dev->trig) {
+			printk(KERN_INFO "Buffer not started: no trigger\n");
+			ret = -EINVAL;
+			goto error_free_compound_mask;
+		}
+		indio_dev->currentmode = INDIO_BUFFER_TRIGGERED;
+	} else if (indio_dev->modes & INDIO_BUFFER_HARDWARE) {
+		indio_dev->currentmode = INDIO_BUFFER_HARDWARE;
+	} else { /* should never be reached */
+		ret = -EINVAL;
+		goto error_free_compound_mask;
+	}
+
+	if (indio_dev->setup_ops->postenable) {
+		ret = indio_dev->setup_ops->postenable(indio_dev);
+		if (ret) {
+			printk(KERN_INFO
+			       "Buffer not started: postenable failed\n");
+			indio_dev->currentmode = INDIO_DIRECT_MODE;
+			if (indio_dev->setup_ops->postdisable)
+				indio_dev->setup_ops->postdisable(indio_dev);
+			goto error_free_compound_mask;
+		}
+	}
+error_free_compound_mask:
+	indio_dev->active_scan_mask = NULL;
+	kfree(compound_mask);
+error_ret:
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iio_update_buffers);
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
+		goto done;
+done:
+	mutex_unlock(&indio_dev->mlock);
+	return (ret < 0) ? ret : len;
+}
+EXPORT_SYMBOL(iio_buffer_store_enable);
+
+ssize_t iio_buffer_show_enable(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	return sprintf(buf, "%d\n", iio_buffer_enabled(indio_dev));
+}
+EXPORT_SYMBOL(iio_buffer_show_enable);
+
+int iio_sw_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct iio_buffer *buffer;
+	unsigned bytes;
+	dev_dbg(&indio_dev->dev, "%s\n", __func__);
+
+	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list)
+		if (buffer->access->set_bytes_per_datum) {
+			bytes = iio_compute_scan_bytes(indio_dev,
+						       buffer->scan_mask,
+						       buffer->scan_timestamp);
+
+			buffer->access->set_bytes_per_datum(buffer, bytes);
+		}
 	return 0;
 }
 EXPORT_SYMBOL(iio_sw_buffer_preenable);
@@ -550,7 +638,11 @@ EXPORT_SYMBOL(iio_sw_buffer_preenable);
  * iio_scan_mask_set() - set particular bit in the scan mask
  * @buffer: the buffer whose scan mask we are interested in
  * @bit: the bit to be set.
- **/
+ *
+ * Note that at this point we have no way of knowing what other
+ * buffers might request, hence this code only verifies that the
+ * individual buffers request is plausible.
+ */
 int iio_scan_mask_set(struct iio_dev *indio_dev,
 		      struct iio_buffer *buffer, int bit)
 {
@@ -580,7 +672,7 @@ int iio_scan_mask_set(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	}
-	bitmap_copy(buffer->scan_mask, trialmask, indio_dev->masklength);
+	set_bit(bit, buffer->scan_mask);
 
 	kfree(trialmask);
 
@@ -629,105 +721,132 @@ static unsigned char *iio_demux(struct iio_buffer *buffer,
 	return buffer->demux_bounce;
 }
 
-int iio_push_to_buffer(struct iio_buffer *buffer, unsigned char *data,
+static int iio_push_to_buffer(struct iio_buffer *buffer, unsigned char *data,
 		       s64 timestamp)
 {
 	unsigned char *dataout = iio_demux(buffer, data);
 
 	return buffer->access->store_to(buffer, dataout, timestamp);
 }
-EXPORT_SYMBOL_GPL(iio_push_to_buffer);
+
+int iio_push_to_buffers(struct iio_dev *indio_dev, unsigned char *data,
+			s64 timestamp)
+{
+	int ret;
+	struct iio_buffer *buf;
+
+	list_for_each_entry(buf, &indio_dev->buffer_list, buffer_list) {
+		ret = iio_push_to_buffer(buf, data, timestamp);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iio_push_to_buffers);
 
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
-
-	/* First work out which scan mode we will actually have */
-	if (bitmap_equal(indio_dev->active_scan_mask,
-			 buffer->scan_mask,
-			 indio_dev->masklength))
-		return 0;
+	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
+		unsigned in_loc = 0, out_loc = 0;
+		int in_ind = -1, out_ind, length;
 
-	/* Now we have the two masks, work from least sig and build up sizes */
-	for_each_set_bit(out_ind,
-			 indio_dev->active_scan_mask,
-			 indio_dev->masklength) {
-		in_ind = find_next_bit(indio_dev->active_scan_mask,
-				       indio_dev->masklength,
-				       in_ind + 1);
-		while (in_ind != out_ind) {
+		/* Clear out any old demux */
+		list_for_each_entry_safe(p, q, &buffer->demux_list, l) {
+			list_del(&p->l);
+			kfree(p);
+		}
+		kfree(buffer->demux_bounce);
+		buffer->demux_bounce = NULL;
+
+		/* First work out which scan mode we will actually have */
+		if (bitmap_equal(indio_dev->active_scan_mask,
+				 buffer->scan_mask,
+				 indio_dev->masklength))
+			return 0;
+
+		/*
+		 * Now we have the two masks, work from least sig
+		 * and build up sizes.
+		 */
+		for_each_set_bit(out_ind,
+				 indio_dev->active_scan_mask,
+				 indio_dev->masklength) {
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
+						      indio_dev->
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
index 2b51178..f6c6bd1 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -786,6 +786,7 @@ struct iio_dev *iio_allocate_device(int sizeof_priv)
 			return NULL;
 		}
 		dev_set_name(&dev->dev, "iio:device%d", dev->id);
+		INIT_LIST_HEAD(&dev->buffer_list);
 	}
 
 	return dev;
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index c45b23b..69ec41a 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -62,7 +62,6 @@ static irqreturn_t ade7758_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	struct iio_buffer *ring = indio_dev->buffer;
 	struct ade7758_state *st = iio_priv(indio_dev);
 	s64 dat64[2];
 	u32 *dat32 = (u32 *)dat64;
@@ -72,10 +71,10 @@ static irqreturn_t ade7758_trigger_handler(int irq, void *p)
 			*dat32 = get_unaligned_be32(&st->rx_buf[5]) & 0xFFFFFF;
 
 	/* Guaranteed to be aligned with 8 byte boundary */
-	if (ring->scan_timestamp)
+	if (indio_dev->scan_timestamp)
 		dat64[1] = pf->timestamp;
 
-	ring->access->store_to(ring, (u8 *)dat64, pf->timestamp);
+	iio_push_to_buffers(indio_dev, (u8 *)dat64, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 
@@ -92,29 +91,19 @@ static irqreturn_t ade7758_trigger_handler(int irq, void *p)
 static int ade7758_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct ade7758_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
-	size_t d_size;
 	unsigned channel;
+	int ret;
 
 	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
 		return -EINVAL;
 
+	ret = iio_sw_buffer_preenable(indio_dev);
+	if (ret < 0)
+		return ret;
+
 	channel = find_first_bit(indio_dev->active_scan_mask,
 				 indio_dev->masklength);
 
-	d_size = st->ade7758_ring_channels[channel].scan_type.storagebits / 8;
-
-	if (ring->scan_timestamp) {
-		d_size += sizeof(s64);
-
-		if (d_size % sizeof(s64))
-			d_size += sizeof(s64) - (d_size % sizeof(s64));
-	}
-
-	if (indio_dev->buffer->access->set_bytes_per_datum)
-		indio_dev->buffer->access->
-			set_bytes_per_datum(indio_dev->buffer, d_size);
-
 	ade7758_write_waveform_type(&indio_dev->dev,
 		st->ade7758_ring_channels[channel].address);
 
-- 
1.7.9.4

