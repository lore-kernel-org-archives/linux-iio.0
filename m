Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:34375 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152Ab2DRNez (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Apr 2012 09:34:55 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] staging:iio: Add support for multiple buffers
Date: Wed, 18 Apr 2012 14:34:50 +0100
Message-Id: <1334756090-14579-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1334756090-14579-1-git-send-email-jic23@kernel.org>
References: <1334756090-14579-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Route all buffer writes through the demux.
Addition or removal of a buffer results in tear down and
setup of all the buffers for a given device.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/adis16201_ring.c      |    4 +-
 drivers/staging/iio/accel/adis16203_ring.c      |    6 +-
 drivers/staging/iio/accel/adis16204_ring.c      |    3 +-
 drivers/staging/iio/accel/adis16209_ring.c      |    3 +-
 drivers/staging/iio/accel/adis16240_ring.c      |    4 +-
 drivers/staging/iio/accel/lis3l02dq_ring.c      |    3 +-
 drivers/staging/iio/adc/ad7192.c                |    3 +-
 drivers/staging/iio/adc/ad7298_ring.c           |    5 +-
 drivers/staging/iio/adc/ad7476_ring.c           |    2 +-
 drivers/staging/iio/adc/ad7606_ring.c           |    3 +-
 drivers/staging/iio/adc/ad7793.c                |    3 +-
 drivers/staging/iio/adc/ad7887_ring.c           |    3 +-
 drivers/staging/iio/adc/ad799x_ring.c           |    3 +-
 drivers/staging/iio/adc/max1363_ring.c          |    2 +-
 drivers/staging/iio/buffer.h                    |   24 ++-
 drivers/staging/iio/gyro/adis16260_ring.c       |    3 +-
 drivers/staging/iio/iio.h                       |    2 +
 drivers/staging/iio/iio_simple_dummy_buffer.c   |    5 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c |    3 +-
 drivers/staging/iio/imu/adis16400_ring.c        |    2 +-
 drivers/staging/iio/industrialio-buffer.c       |  354 +++++++++++++++--------
 drivers/staging/iio/industrialio-core.c         |    1 +
 drivers/staging/iio/meter/ade7758_ring.c        |    3 +-
 23 files changed, 276 insertions(+), 168 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_ring.c b/drivers/staging/iio/accel/adis16201_ring.c
index 49912e2..f3673c2 100644
--- a/drivers/staging/iio/accel/adis16201_ring.c
+++ b/drivers/staging/iio/accel/adis16201_ring.c
@@ -62,8 +62,6 @@ static irqreturn_t adis16201_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16201_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
-
 	int i = 0;
 	s16 *data;
 
@@ -83,7 +81,7 @@ static irqreturn_t adis16201_trigger_handler(int irq, void *p)
 	if (indio_dev->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
 
-	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
+	iio_push_to_buffers(indio_dev, (u8 *)data, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 	kfree(data);
diff --git a/drivers/staging/iio/accel/adis16203_ring.c b/drivers/staging/iio/accel/adis16203_ring.c
index 5c40f6c..456bb22 100644
--- a/drivers/staging/iio/accel/adis16203_ring.c
+++ b/drivers/staging/iio/accel/adis16203_ring.c
@@ -62,8 +62,6 @@ static irqreturn_t adis16203_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16203_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
-
 	int i = 0;
 	s16 *data;
 
@@ -83,9 +81,7 @@ static irqreturn_t adis16203_trigger_handler(int irq, void *p)
 	if (indio_dev->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
 
-	ring->access->store_to(ring,
-			      (u8 *)data,
-			      pf->timestamp);
+	iio_push_to_buffers(indio_dev, (u8 *)data, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 	kfree(data);
diff --git a/drivers/staging/iio/accel/adis16204_ring.c b/drivers/staging/iio/accel/adis16204_ring.c
index bf5488e..cc0f699 100644
--- a/drivers/staging/iio/accel/adis16204_ring.c
+++ b/drivers/staging/iio/accel/adis16204_ring.c
@@ -60,7 +60,6 @@ static irqreturn_t adis16204_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16204_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
 	int i = 0;
 	s16 *data;
 
@@ -80,7 +79,7 @@ static irqreturn_t adis16204_trigger_handler(int irq, void *p)
 	if (indio_dev->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
 
-	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
+	iio_push_to_buffers(indio_dev, (u8 *)data, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 	kfree(data);
diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index 3101c53..2c95f3d 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -60,7 +60,6 @@ static irqreturn_t adis16209_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16209_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
 	int i = 0;
 	s16 *data;
 
@@ -80,7 +79,7 @@ static irqreturn_t adis16209_trigger_handler(int irq, void *p)
 	if (indio_dev->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
 
-	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
+	iio_push_to_buffers(indio_dev, (u8 *)data, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 	kfree(data);
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index c4459f7..ee04154 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -57,8 +57,6 @@ static irqreturn_t adis16240_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16240_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
-
 	int i = 0;
 	s16 *data;
 
@@ -78,7 +76,7 @@ static irqreturn_t adis16240_trigger_handler(int irq, void *p)
 	if (indio_dev->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
 
-	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
+	iio_push_to_buffers(indio_dev, (u8 *)data, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 	kfree(data);
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index ebd5b4d..b493034 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -135,7 +135,6 @@ static irqreturn_t lis3l02dq_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	struct iio_buffer *buffer = indio_dev->buffer;
 	int len = 0;
 	char *data;
 
@@ -154,7 +153,7 @@ static irqreturn_t lis3l02dq_trigger_handler(int irq, void *p)
 		*(s64 *)(((phys_addr_t)data + len
 				+ sizeof(s64) - 1) & ~(sizeof(s64) - 1))
 			= pf->timestamp;
-	buffer->access->store_to(buffer, (u8 *)data, pf->timestamp);
+	iio_push_to_buffers(indio_dev, (u8 *)data, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 	kfree(data);
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 5d31685..1424548 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -510,7 +510,6 @@ static irqreturn_t ad7192_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	struct iio_buffer *ring = indio_dev->buffer;
 	struct ad7192_state *st = iio_priv(indio_dev);
 	s64 dat64[2];
 	s32 *dat32 = (s32 *)dat64;
@@ -524,7 +523,7 @@ static irqreturn_t ad7192_trigger_handler(int irq, void *p)
 	if (indio_dev->scan_timestamp)
 		dat64[1] = pf->timestamp;
 
-	ring->access->store_to(ring, (u8 *)dat64, pf->timestamp);
+	iio_push_to_buffers(indio_dev, (u8 *)dat64, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 	st->irq_dis = false;
diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
index 538e3b3..52ddfdf 100644
--- a/drivers/staging/iio/adc/ad7298_ring.c
+++ b/drivers/staging/iio/adc/ad7298_ring.c
@@ -83,7 +83,6 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad7298_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
 	s64 time_ns;
 	__u16 buf[16];
 	int b_sent, i;
@@ -99,10 +98,10 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
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
index 8534f6b..21bce39 100644
--- a/drivers/staging/iio/adc/ad7476_ring.c
+++ b/drivers/staging/iio/adc/ad7476_ring.c
@@ -44,7 +44,7 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
 		memcpy(rxbuf + indio_dev->scan_bytes - sizeof(s64),
 			&time_ns, sizeof(time_ns));
 
-	indio_dev->buffer->access->store_to(indio_dev->buffer, rxbuf, time_ns);
+	iio_push_to_buffers(indio_dev, rxbuf, time_ns);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 	kfree(rxbuf);
diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index 007b600..2d36a7a 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -46,7 +46,6 @@ static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
 	struct ad7606_state *st = container_of(work_s, struct ad7606_state,
 						poll_work);
 	struct iio_dev *indio_dev = iio_priv_to_dev(st);
-	struct iio_buffer *ring = indio_dev->buffer;
 	s64 time_ns;
 	__u8 *buf;
 	int ret;
@@ -84,7 +83,7 @@ static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
 	if (indio_dev->scan_timestamp)
 		*((s64 *)(buf + indio_dev->scan_bytes - sizeof(s64))) = time_ns;
 
-	ring->access->store_to(indio_dev->buffer, buf, time_ns);
+	iio_push_to_buffers(indio_dev, buf, time_ns);
 done:
 	gpio_set_value(st->pdata->gpio_convst, 0);
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 7f68c7c..0f80457 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -375,7 +375,6 @@ static irqreturn_t ad7793_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	struct iio_buffer *ring = indio_dev->buffer;
 	struct ad7793_state *st = iio_priv(indio_dev);
 	s64 dat64[2];
 	s32 *dat32 = (s32 *)dat64;
@@ -389,7 +388,7 @@ static irqreturn_t ad7793_trigger_handler(int irq, void *p)
 	if (indio_dev->scan_timestamp)
 		dat64[1] = pf->timestamp;
 
-	ring->access->store_to(ring, (u8 *)dat64, pf->timestamp);
+	iio_push_to_buffers(indio_dev, (u8 *)dat64, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 	st->irq_dis = false;
diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
index d9f5264..cdfcc91 100644
--- a/drivers/staging/iio/adc/ad7887_ring.c
+++ b/drivers/staging/iio/adc/ad7887_ring.c
@@ -72,7 +72,6 @@ static irqreturn_t ad7887_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad7887_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
 	s64 time_ns;
 	__u8 *buf;
 	int b_sent;
@@ -96,7 +95,7 @@ static irqreturn_t ad7887_trigger_handler(int irq, void *p)
 		memcpy(buf + indio_dev->scan_bytes - sizeof(s64),
 		       &time_ns, sizeof(time_ns));
 
-	indio_dev->buffer->access->store_to(indio_dev->buffer, buf, time_ns);
+	iio_push_to_buffers(indio_dev, buf, time_ns);
 done:
 	kfree(buf);
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index 5190e50..f09b7ef 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -56,7 +56,6 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad799x_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
 	s64 time_ns;
 	__u8 *rxbuf;
 	int b_sent;
@@ -99,7 +98,7 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 		memcpy(rxbuf + indio_dev->scan_bytes - sizeof(s64),
 			&time_ns, sizeof(time_ns));
 
-	ring->access->store_to(indio_dev->buffer, rxbuf, time_ns);
+	iio_push_to_buffers(indio_dev, rxbuf, time_ns);
 done:
 	kfree(rxbuf);
 	if (b_sent < 0)
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index 8372e98..d20218d 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -80,7 +80,7 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
 
 	if (indio_dev->scan_timestamp)
 		memcpy(rxbuf + d_size - sizeof(s64), &time_ns, sizeof(time_ns));
-	iio_push_to_buffer(indio_dev->buffer, rxbuf, time_ns);
+	iio_push_to_buffers(indio_dev, rxbuf, time_ns);
 
 done:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/staging/iio/buffer.h b/drivers/staging/iio/buffer.h
index 3d3ea9e..704f9f6 100644
--- a/drivers/staging/iio/buffer.h
+++ b/drivers/staging/iio/buffer.h
@@ -66,7 +66,8 @@ struct iio_buffer_access_funcs {
  * @stufftoread:	[INTERN] flag to indicate new data.
  * @demux_list:		[INTERN] list of operations required to demux the scan.
  * @demux_bounce:	[INTERN] buffer for doing gather from incoming scan.
- **/
+ * @buffer_list:	[INTERN] entry in the devices list of current buffers.
+ */
 struct iio_buffer {
 	int					length;
 	int					bytes_per_datum;
@@ -81,9 +82,22 @@ struct iio_buffer {
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
@@ -114,12 +128,12 @@ int iio_scan_mask_set(struct iio_dev *indio_dev,
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
index 046f84d..59cc200 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -63,7 +63,6 @@ static irqreturn_t adis16260_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16260_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
 	int i = 0;
 	s16 *data;
 
@@ -83,7 +82,7 @@ static irqreturn_t adis16260_trigger_handler(int irq, void *p)
 	if (indio_dev->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
 
-	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
+	iio_push_to_buffers(indio_dev, (u8 *)data, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 	kfree(data);
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 0770340..344d0cf 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -299,6 +299,7 @@ struct iio_buffer_setup_ops {
  *			and owner
  * @event_interface:	[INTERN] event chrdevs associated with interrupt lines
  * @buffer:		[DRIVER] any buffer present
+ * @buffer_list:	[INTERN] list of all buffers currently attached
  * @scan_bytes:		[INTERN] num bytes captured to be fed to buffer demux
  * @mlock:		[INTERN] lock used to prevent simultaneous device state
  *			changes
@@ -337,6 +338,7 @@ struct iio_dev {
 	struct iio_event_interface	*event_interface;
 
 	struct iio_buffer		*buffer;
+	struct list_head		buffer_list;
 	int				scan_bytes;
 	struct mutex			mlock;
 
diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
index 49e7aa1..5be4749 100644
--- a/drivers/staging/iio/iio_simple_dummy_buffer.c
+++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
@@ -46,7 +46,6 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	struct iio_buffer *buffer = indio_dev->buffer;
 	int len = 0;
 	u16 *data;
 
@@ -76,7 +75,7 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 		     i < bitmap_weight(indio_dev->active_scan_mask,
 				       indio_dev->masklength);
 		     i++) {
-			j = find_next_bit(buffer->scan_mask,
+			j = find_next_bit(indio_dev->buffer->scan_mask,
 					  indio_dev->masklength, j + 1);
 			/* random access read form the 'device' */
 			data[i] = fakedata[j];
@@ -88,7 +87,7 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 		*(s64 *)(((phys_addr_t)data + len
 				+ sizeof(s64) - 1) & ~(sizeof(s64) - 1))
 			= iio_get_time_ns();
-	buffer->access->store_to(buffer, (u8 *)data, pf->timestamp);
+	iio_push_to_buffers(indio_dev, (u8 *)data, pf->timestamp);
 
 	kfree(data);
 
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 8a0485e..442e25b 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -647,7 +647,6 @@ static void ad5933_work(struct work_struct *work)
 	struct ad5933_state *st = container_of(work,
 		struct ad5933_state, work.work);
 	struct iio_dev *indio_dev = i2c_get_clientdata(st->client);
-	struct iio_buffer *ring = indio_dev->buffer;
 	signed short buf[2];
 	unsigned char status;
 
@@ -678,7 +677,7 @@ static void ad5933_work(struct work_struct *work)
 			buf[0] = be16_to_cpu(buf[0]);
 		}
 		/* save datum to the ring */
-		ring->access->store_to(ring, (u8 *)buf, iio_get_time_ns());
+		iio_push_to_buffers(indio_dev, (u8 *)buf, iio_get_time_ns());
 	} else {
 		/* no data available - try again later */
 		schedule_delayed_work(&st->work, st->poll_time_jiffies);
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index d964004..a0b227e 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -152,7 +152,7 @@ static irqreturn_t adis16400_trigger_handler(int irq, void *p)
 	/* Guaranteed to be aligned with 8 byte boundary */
 	if (ring->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
-	ring->access->store_to(indio_dev->buffer, (u8 *) data, pf->timestamp);
+	iio_push_to_buffers(indio_dev, (u8 *) data, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 
diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index b409b95..47a8eea 100644
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
@@ -134,7 +144,7 @@ static ssize_t iio_scan_el_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 	mutex_lock(&indio_dev->mlock);
-	if (iio_buffer_enabled(indio_dev)) {
+	if (iio_buffer_is_primary_active(indio_dev)) {
 		ret = -EBUSY;
 		goto error_ret;
 	}
@@ -180,12 +190,11 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
 		return ret;
 
 	mutex_lock(&indio_dev->mlock);
-	if (iio_buffer_enabled(indio_dev)) {
+	if (iio_buffer_is_primary_active(indio_dev)) {
 		ret = -EBUSY;
 		goto error_ret;
 	}
 	indio_dev->buffer->scan_timestamp = state;
-	indio_dev->scan_timestamp = state;
 error_ret:
 	mutex_unlock(&indio_dev->mlock);
 
@@ -395,106 +404,6 @@ ssize_t iio_buffer_write_length(struct device *dev,
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
@@ -534,31 +443,195 @@ static int iio_compute_scan_bytes(struct iio_dev *indio_dev, const long *mask,
 	return bytes;
 }
 
-int iio_sw_buffer_preenable(struct iio_dev *indio_dev)
+int iio_update_buffers(struct iio_dev *indio_dev,
+		       struct iio_buffer *insert_buffer,
+		       struct iio_buffer *remove_buffer)
 {
-	struct iio_buffer *buffer = indio_dev->buffer;
-	dev_dbg(&indio_dev->dev, "%s\n", __func__);
+	int ret;
+	struct iio_buffer *buffer;
+	unsigned long *compound_mask;
 
-	/* How much space will the demuxed element take? */
-	indio_dev->scan_bytes =
-		iio_compute_scan_bytes(indio_dev, buffer->scan_mask,
-				       buffer->scan_timestamp);
-	buffer->access->set_bytes_per_datum(buffer, indio_dev->scan_bytes);
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
@@ -567,7 +640,11 @@ EXPORT_SYMBOL(iio_sw_buffer_preenable);
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
@@ -597,7 +674,7 @@ int iio_scan_mask_set(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	}
-	bitmap_copy(buffer->scan_mask, trialmask, indio_dev->masklength);
+	set_bit(bit, buffer->scan_mask);
 
 	kfree(trialmask);
 
@@ -646,14 +723,13 @@ static unsigned char *iio_demux(struct iio_buffer *buffer,
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
 
 static void iio_buffer_demux_free(struct iio_buffer *buffer)
 {
@@ -664,10 +740,27 @@ static void iio_buffer_demux_free(struct iio_buffer *buffer)
 	}
 }
 
-int iio_update_demux(struct iio_dev *indio_dev)
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
+
+static int iio_buffer_update_demux(struct iio_dev *indio_dev,
+				   struct iio_buffer *buffer)
 {
 	const struct iio_chan_spec *ch;
-	struct iio_buffer *buffer = indio_dev->buffer;
 	int ret, in_ind = -1, out_ind, length;
 	unsigned in_loc = 0, out_loc = 0;
 	struct iio_demux_table *p;
@@ -752,4 +845,23 @@ error_clear_mux_table:
 
 	return ret;
 }
+
+int iio_update_demux(struct iio_dev *indio_dev)
+{
+	struct iio_buffer *buffer;
+	int ret;
+
+	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
+		ret = iio_buffer_update_demux(indio_dev, buffer);
+		if (ret < 0)
+			goto error_clear_mux_table;
+	}
+	return 0;
+
+error_clear_mux_table:
+	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list)
+		iio_buffer_demux_free(buffer);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(iio_update_demux);
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index db55b81..cb5ae37 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -769,6 +769,7 @@ struct iio_dev *iio_allocate_device(int sizeof_priv)
 			return NULL;
 		}
 		dev_set_name(&dev->dev, "iio:device%d", dev->id);
+		INIT_LIST_HEAD(&dev->buffer_list);
 	}
 
 	return dev;
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index b37bc98..69ec41a 100644
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
@@ -75,7 +74,7 @@ static irqreturn_t ade7758_trigger_handler(int irq, void *p)
 	if (indio_dev->scan_timestamp)
 		dat64[1] = pf->timestamp;
 
-	ring->access->store_to(ring, (u8 *)dat64, pf->timestamp);
+	iio_push_to_buffers(indio_dev, (u8 *)dat64, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
1.7.0.4

