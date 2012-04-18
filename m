Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:41014 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181Ab2DRNOD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Apr 2012 09:14:03 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 04/14] staging:iio: add caching of the number of bytes in a scan.
Date: Wed, 18 Apr 2012 14:13:44 +0100
Message-Id: <1334754834-13622-5-git-send-email-jic23@kernel.org>
In-Reply-To: <1334754834-13622-1-git-send-email-jic23@kernel.org>
References: <1334754834-13622-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/adis16201_ring.c    |    3 +--
 drivers/staging/iio/accel/adis16203_ring.c    |    3 +--
 drivers/staging/iio/accel/adis16204_ring.c    |    3 +--
 drivers/staging/iio/accel/adis16209_ring.c    |    4 +---
 drivers/staging/iio/accel/adis16240_ring.c    |    3 +--
 drivers/staging/iio/accel/lis3l02dq_ring.c    |    4 ++--
 drivers/staging/iio/adc/ad7606_ring.c         |    3 +--
 drivers/staging/iio/gyro/adis16260_ring.c     |    3 +--
 drivers/staging/iio/iio.h                     |    2 ++
 drivers/staging/iio/iio_simple_dummy_buffer.c |    9 +++------
 drivers/staging/iio/imu/adis16400_ring.c      |    4 ++--
 drivers/staging/iio/industrialio-buffer.c     |    6 +++---
 12 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_ring.c b/drivers/staging/iio/accel/adis16201_ring.c
index 97f9e6b..1370e32 100644
--- a/drivers/staging/iio/accel/adis16201_ring.c
+++ b/drivers/staging/iio/accel/adis16201_ring.c
@@ -66,9 +66,8 @@ static irqreturn_t adis16201_trigger_handler(int irq, void *p)
 
 	int i = 0;
 	s16 *data;
-	size_t datasize = ring->access->get_bytes_per_datum(ring);
 
-	data = kmalloc(datasize, GFP_KERNEL);
+	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(&st->us->dev, "memory alloc failed in ring bh");
 		return -ENOMEM;
diff --git a/drivers/staging/iio/accel/adis16203_ring.c b/drivers/staging/iio/accel/adis16203_ring.c
index 6a8963d..86f4efb 100644
--- a/drivers/staging/iio/accel/adis16203_ring.c
+++ b/drivers/staging/iio/accel/adis16203_ring.c
@@ -66,9 +66,8 @@ static irqreturn_t adis16203_trigger_handler(int irq, void *p)
 
 	int i = 0;
 	s16 *data;
-	size_t datasize = ring->access->get_bytes_per_datum(ring);
 
-	data = kmalloc(datasize, GFP_KERNEL);
+	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(&st->us->dev, "memory alloc failed in ring bh");
 		return -ENOMEM;
diff --git a/drivers/staging/iio/accel/adis16204_ring.c b/drivers/staging/iio/accel/adis16204_ring.c
index 5c8ab73..34ef11f 100644
--- a/drivers/staging/iio/accel/adis16204_ring.c
+++ b/drivers/staging/iio/accel/adis16204_ring.c
@@ -63,9 +63,8 @@ static irqreturn_t adis16204_trigger_handler(int irq, void *p)
 	struct iio_buffer *ring = indio_dev->buffer;
 	int i = 0;
 	s16 *data;
-	size_t datasize = ring->access->get_bytes_per_datum(ring);
 
-	data = kmalloc(datasize, GFP_KERNEL);
+	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(&st->us->dev, "memory alloc failed in ring bh");
 		return -ENOMEM;
diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index 57254b6..1424d48 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -61,12 +61,10 @@ static irqreturn_t adis16209_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16209_state *st = iio_priv(indio_dev);
 	struct iio_buffer *ring = indio_dev->buffer;
-
 	int i = 0;
 	s16 *data;
-	size_t datasize = ring->access->get_bytes_per_datum(ring);
 
-	data = kmalloc(datasize , GFP_KERNEL);
+	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(&st->us->dev, "memory alloc failed in ring bh");
 		return -ENOMEM;
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index 43ba84e..9ff0634 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -61,9 +61,8 @@ static irqreturn_t adis16240_trigger_handler(int irq, void *p)
 
 	int i = 0;
 	s16 *data;
-	size_t datasize = ring->access->get_bytes_per_datum(ring);
 
-	data = kmalloc(datasize, GFP_KERNEL);
+	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(&st->us->dev, "memory alloc failed in ring bh");
 		return -ENOMEM;
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 0fc3973..3bdc102 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -137,9 +137,9 @@ static irqreturn_t lis3l02dq_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct iio_buffer *buffer = indio_dev->buffer;
 	int len = 0;
-	size_t datasize = buffer->access->get_bytes_per_datum(buffer);
-	char *data = kmalloc(datasize, GFP_KERNEL);
+	char *data;
 
+	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(indio_dev->dev.parent,
 			"memory alloc failed in buffer bh");
diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index 1ef9fbc..6cbf242 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -51,8 +51,7 @@ static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
 	__u8 *buf;
 	int ret;
 
-	buf = kzalloc(ring->access->get_bytes_per_datum(ring),
-		      GFP_KERNEL);
+	buf = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (buf == NULL)
 		return;
 
diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index 711f151..18fc73c 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -66,9 +66,8 @@ static irqreturn_t adis16260_trigger_handler(int irq, void *p)
 	struct iio_buffer *ring = indio_dev->buffer;
 	int i = 0;
 	s16 *data;
-	size_t datasize = ring->access->get_bytes_per_datum(ring);
 
-	data = kmalloc(datasize , GFP_KERNEL);
+	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(&st->us->dev, "memory alloc failed in ring bh");
 		return -ENOMEM;
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 6832c98..7a10aed 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -299,6 +299,7 @@ struct iio_buffer_setup_ops {
  *			and owner
  * @event_interface:	[INTERN] event chrdevs associated with interrupt lines
  * @buffer:		[DRIVER] any buffer present
+ * @scan_bytes:		[INTERN] num bytes captured to be fed to buffer demux
  * @mlock:		[INTERN] lock used to prevent simultaneous device state
  *			changes
  * @available_scan_masks: [DRIVER] optional array of allowed bitmasks
@@ -335,6 +336,7 @@ struct iio_dev {
 	struct iio_event_interface	*event_interface;
 
 	struct iio_buffer		*buffer;
+	int				scan_bytes;
 	struct mutex			mlock;
 
 	const unsigned long		*available_scan_masks;
diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
index bb4daf7..61a2622 100644
--- a/drivers/staging/iio/iio_simple_dummy_buffer.c
+++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
@@ -48,12 +48,9 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct iio_buffer *buffer = indio_dev->buffer;
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
 
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index 8daa038..d964004 100644
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
diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index efa44c4..f6cb0ab 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -536,13 +536,13 @@ static int iio_compute_scan_bytes(struct iio_dev *indio_dev, const long *mask,
 int iio_sw_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct iio_buffer *buffer = indio_dev->buffer;
-	unsigned bytes = 0;
 	dev_dbg(&indio_dev->dev, "%s\n", __func__);
 
 	/* How much space will the demuxed element take? */
-	bytes = iio_compute_scan_bytes(indio_dev, buffer->scan_mask,
+	indio_dev->scan_bytes =
+		iio_compute_scan_bytes(indio_dev, buffer->scan_mask,
 				       buffer->scan_timestamp);
-	buffer->access->set_bytes_per_datum(buffer, bytes);
+	buffer->access->set_bytes_per_datum(buffer, indio_dev->scan_bytes);
 
 	/* What scan mask do we actually have ?*/
 	if (indio_dev->available_scan_masks)
-- 
1.7.0.4

