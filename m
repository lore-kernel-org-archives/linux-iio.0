Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-218.synserver.de ([212.40.185.218]:1570 "EHLO
	smtp-out-217.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756779Ab2IDL0s (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Sep 2012 07:26:48 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio: Use iio_push_to_buffer
Date: Tue,  4 Sep 2012 13:31:28 +0200
Message-Id: <1346758288-20031-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Consistently use iio_push_to_buffer instead of manually calling the buffers
store_to callback.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/accel/adis16201_ring.c      |    3 +--
 drivers/staging/iio/accel/adis16203_ring.c      |    5 +----
 drivers/staging/iio/accel/adis16204_ring.c      |    3 +--
 drivers/staging/iio/accel/adis16209_ring.c      |    3 +--
 drivers/staging/iio/accel/adis16240_ring.c      |    3 +--
 drivers/staging/iio/accel/lis3l02dq_ring.c      |    3 +--
 drivers/staging/iio/adc/ad7192.c                |    3 +--
 drivers/staging/iio/adc/ad7298_ring.c           |    3 +--
 drivers/staging/iio/adc/ad7476_ring.c           |    2 +-
 drivers/staging/iio/adc/ad7606_ring.c           |    3 +--
 drivers/staging/iio/adc/ad7793.c                |    3 +--
 drivers/staging/iio/adc/ad7887_ring.c           |    2 +-
 drivers/staging/iio/adc/ad799x_ring.c           |    3 +--
 drivers/staging/iio/gyro/adis16260_ring.c       |    3 +--
 drivers/staging/iio/iio_simple_dummy_buffer.c   |    2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c |    2 +-
 drivers/staging/iio/imu/adis16400_ring.c        |    2 +-
 drivers/staging/iio/meter/ade7758_ring.c        |    3 +--
 18 files changed, 18 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_ring.c b/drivers/staging/iio/accel/adis16201_ring.c
index 03fcf6e..884dcf8 100644
--- a/drivers/staging/iio/accel/adis16201_ring.c
+++ b/drivers/staging/iio/accel/adis16201_ring.c
@@ -62,7 +62,6 @@ static irqreturn_t adis16201_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16201_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
 
 	int i = 0;
 	s16 *data;
@@ -83,7 +82,7 @@ static irqreturn_t adis16201_trigger_handler(int irq, void *p)
 	if (indio_dev->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
 
-	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
+	iio_push_to_buffer(indio_dev->buffer, (u8 *)data, pf->timestamp);
 
 	kfree(data);
 done:
diff --git a/drivers/staging/iio/accel/adis16203_ring.c b/drivers/staging/iio/accel/adis16203_ring.c
index c16b2b7..a7ff804 100644
--- a/drivers/staging/iio/accel/adis16203_ring.c
+++ b/drivers/staging/iio/accel/adis16203_ring.c
@@ -61,7 +61,6 @@ static irqreturn_t adis16203_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16203_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
 
 	int i = 0;
 	s16 *data;
@@ -82,9 +81,7 @@ static irqreturn_t adis16203_trigger_handler(int irq, void *p)
 	if (indio_dev->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
 
-	ring->access->store_to(ring,
-			      (u8 *)data,
-			      pf->timestamp);
+	iio_push_to_buffer(indio_dev->buffer, (u8 *)data, pf->timestamp);
 
 	kfree(data);
 done:
diff --git a/drivers/staging/iio/accel/adis16204_ring.c b/drivers/staging/iio/accel/adis16204_ring.c
index 1d2b31c..16e36e3 100644
--- a/drivers/staging/iio/accel/adis16204_ring.c
+++ b/drivers/staging/iio/accel/adis16204_ring.c
@@ -59,7 +59,6 @@ static irqreturn_t adis16204_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16204_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
 	int i = 0;
 	s16 *data;
 
@@ -79,7 +78,7 @@ static irqreturn_t adis16204_trigger_handler(int irq, void *p)
 	if (indio_dev->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
 
-	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
+	iio_push_to_buffer(indio_dev->buffer, (u8 *)data, pf->timestamp);
 
 	kfree(data);
 done:
diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index 1a4a55c..5cfeff4 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -59,7 +59,6 @@ static irqreturn_t adis16209_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16209_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
 	int i = 0;
 	s16 *data;
 
@@ -79,7 +78,7 @@ static irqreturn_t adis16209_trigger_handler(int irq, void *p)
 	if (indio_dev->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
 
-	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
+	iio_push_to_buffer(indio_dev->buffer, (u8 *)data, pf->timestamp);
 
 	kfree(data);
 done:
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index 360dfed..d5ec43e 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -56,7 +56,6 @@ static irqreturn_t adis16240_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16240_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
 
 	int i = 0;
 	s16 *data;
@@ -77,7 +76,7 @@ static irqreturn_t adis16240_trigger_handler(int irq, void *p)
 	if (indio_dev->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
 
-	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
+	iio_push_to_buffer(indio_dev->buffer, (u8 *)data, pf->timestamp);
 
 	kfree(data);
 done:
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 18d108f..a47f15b 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -135,7 +135,6 @@ static irqreturn_t lis3l02dq_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	struct iio_buffer *buffer = indio_dev->buffer;
 	int len = 0;
 	char *data;
 
@@ -153,7 +152,7 @@ static irqreturn_t lis3l02dq_trigger_handler(int irq, void *p)
 	if (indio_dev->scan_timestamp)
 		*(s64 *)((u8 *)data + ALIGN(len, sizeof(s64)))
 			= pf->timestamp;
-	buffer->access->store_to(buffer, (u8 *)data, pf->timestamp);
+	iio_push_to_buffer(indio_dev->buffer, (u8 *)data, pf->timestamp);
 
 	kfree(data);
 done:
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 405d9a8..d91b96f 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -509,7 +509,6 @@ static irqreturn_t ad7192_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	struct iio_buffer *ring = indio_dev->buffer;
 	struct ad7192_state *st = iio_priv(indio_dev);
 	s64 dat64[2];
 	s32 *dat32 = (s32 *)dat64;
@@ -523,7 +522,7 @@ static irqreturn_t ad7192_trigger_handler(int irq, void *p)
 	if (indio_dev->scan_timestamp)
 		dat64[1] = pf->timestamp;
 
-	ring->access->store_to(ring, (u8 *)dat64, pf->timestamp);
+	iio_push_to_buffer(indio_dev->buffer, (u8 *)dat64, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 	st->irq_dis = false;
diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
index 506016f..9fce404 100644
--- a/drivers/staging/iio/adc/ad7298_ring.c
+++ b/drivers/staging/iio/adc/ad7298_ring.c
@@ -75,7 +75,6 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad7298_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
 	s64 time_ns = 0;
 	__u16 buf[16];
 	int b_sent, i;
@@ -94,7 +93,7 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
 						 indio_dev->masklength); i++)
 		buf[i] = be16_to_cpu(st->rx_buf[i]);
 
-	indio_dev->buffer->access->store_to(ring, (u8 *)buf, time_ns);
+	iio_push_to_buffer(indio_dev->buffer, (u8 *)buf, time_ns);
 
 done:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
index d087b21..3741ac6 100644
--- a/drivers/staging/iio/adc/ad7476_ring.c
+++ b/drivers/staging/iio/adc/ad7476_ring.c
@@ -44,7 +44,7 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
 		memcpy(rxbuf + indio_dev->scan_bytes - sizeof(s64),
 			&time_ns, sizeof(time_ns));
 
-	indio_dev->buffer->access->store_to(indio_dev->buffer, rxbuf, time_ns);
+	iio_push_to_buffer(indio_dev->buffer, rxbuf, time_ns);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 	kfree(rxbuf);
diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index f15afe4..f4b009e 100644
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
+	iio_push_to_buffer(indio_dev->buffer, buf, time_ns);
 done:
 	gpio_set_value(st->pdata->gpio_convst, 0);
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 112e2b7..f6301a2 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -374,7 +374,6 @@ static irqreturn_t ad7793_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	struct iio_buffer *ring = indio_dev->buffer;
 	struct ad7793_state *st = iio_priv(indio_dev);
 	s64 dat64[2];
 	s32 *dat32 = (s32 *)dat64;
@@ -388,7 +387,7 @@ static irqreturn_t ad7793_trigger_handler(int irq, void *p)
 	if (indio_dev->scan_timestamp)
 		dat64[1] = pf->timestamp;
 
-	ring->access->store_to(ring, (u8 *)dat64, pf->timestamp);
+	iio_push_to_buffer(indio_dev->buffer, (u8 *)dat64, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 	st->irq_dis = false;
diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
index c76fdb5..a4ff493 100644
--- a/drivers/staging/iio/adc/ad7887_ring.c
+++ b/drivers/staging/iio/adc/ad7887_ring.c
@@ -95,7 +95,7 @@ static irqreturn_t ad7887_trigger_handler(int irq, void *p)
 		memcpy(buf + indio_dev->scan_bytes - sizeof(s64),
 		       &time_ns, sizeof(time_ns));
 
-	indio_dev->buffer->access->store_to(indio_dev->buffer, buf, time_ns);
+	iio_push_to_buffer(indio_dev->buffer, buf, time_ns);
 done:
 	kfree(buf);
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index 858a685..84275c3 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -35,7 +35,6 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad799x_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
 	s64 time_ns;
 	__u8 *rxbuf;
 	int b_sent;
@@ -78,7 +77,7 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 		memcpy(rxbuf + indio_dev->scan_bytes - sizeof(s64),
 			&time_ns, sizeof(time_ns));
 
-	ring->access->store_to(indio_dev->buffer, rxbuf, time_ns);
+	iio_push_to_buffer(indio_dev->buffer, rxbuf, time_ns);
 done:
 	kfree(rxbuf);
 out:
diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index eeee8e7..e6e2345 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -62,7 +62,6 @@ static irqreturn_t adis16260_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16260_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
 	int i = 0;
 	s16 *data;
 
@@ -82,7 +81,7 @@ static irqreturn_t adis16260_trigger_handler(int irq, void *p)
 	if (indio_dev->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
 
-	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
+	iio_push_to_buffer(indio_dev->buffer, (u8 *)data, pf->timestamp);
 
 	kfree(data);
 done:
diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
index bd628de..e080213 100644
--- a/drivers/staging/iio/iio_simple_dummy_buffer.c
+++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
@@ -87,7 +87,7 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 	if (indio_dev->scan_timestamp)
 		*(s64 *)((u8 *)data + ALIGN(len, sizeof(s64)))
 			= iio_get_time_ns();
-	buffer->access->store_to(buffer, (u8 *)data, pf->timestamp);
+	iio_push_to_buffer(buffer, (u8 *)data, pf->timestamp);
 
 	kfree(data);
 
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index e239ea9..39a9be8 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -678,7 +678,7 @@ static void ad5933_work(struct work_struct *work)
 			buf[0] = be16_to_cpu(buf[0]);
 		}
 		/* save datum to the ring */
-		ring->access->store_to(ring, (u8 *)buf, iio_get_time_ns());
+		iio_push_to_buffer(ring, (u8 *)buf, iio_get_time_ns());
 	} else {
 		/* no data available - try again later */
 		schedule_delayed_work(&st->work, st->poll_time_jiffies);
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index beec650..6b71788 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -150,7 +150,7 @@ static irqreturn_t adis16400_trigger_handler(int irq, void *p)
 	/* Guaranteed to be aligned with 8 byte boundary */
 	if (ring->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
-	ring->access->store_to(indio_dev->buffer, (u8 *) data, pf->timestamp);
+	iio_push_to_buffer(ring, (u8 *) data, pf->timestamp);
 
 done:
 	kfree(data);
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index 1ce10b2..23c107a 100644
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
@@ -74,7 +73,7 @@ static irqreturn_t ade7758_trigger_handler(int irq, void *p)
 	if (indio_dev->scan_timestamp)
 		dat64[1] = pf->timestamp;
 
-	ring->access->store_to(ring, (u8 *)dat64, pf->timestamp);
+	iio_push_to_buffer(indio_dev->buffer, (u8 *)dat64, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
1.7.10.4

