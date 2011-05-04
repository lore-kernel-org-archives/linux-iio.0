Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:57589 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024Ab1EDL4x (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2011 07:56:53 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de, Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 36/99] staging:iio:meter:ade7758 move to irqchip based trigger handling.
Date: Wed,  4 May 2011 12:58:08 +0100
Message-Id: <1304510351-10922-37-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Untested

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/meter/ade7758.h      |    5 ---
 drivers/staging/iio/meter/ade7758_ring.c |   58 +++++++++++++----------------
 2 files changed, 26 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7758.h b/drivers/staging/iio/meter/ade7758.h
index c6fd94f..169982b 100644
--- a/drivers/staging/iio/meter/ade7758.h
+++ b/drivers/staging/iio/meter/ade7758.h
@@ -92,9 +92,6 @@
 /**
  * struct ade7758_state - device instance specific data
  * @us:			actual spi_device
- * @work_trigger_to_ring: bh for triggered event handling
- * @inter:		used to check if new interrupt has been triggered
- * @last_timestamp:	passing timestamp from th to bh of interrupt handler
  * @indio_dev:		industrial I/O device structure
  * @trig:		data ready trigger registered with iio
  * @tx:			transmit buffer
@@ -103,8 +100,6 @@
  **/
 struct ade7758_state {
 	struct spi_device		*us;
-	struct work_struct		work_trigger_to_ring;
-	s64				last_timestamp;
 	struct iio_dev			*indio_dev;
 	struct iio_trigger		*trig;
 	u8				*tx;
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index 274b4a0..2c9865d 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -50,23 +50,6 @@ static struct attribute_group ade7758_scan_el_group = {
 };
 
 /**
- * ade7758_poll_func_th() top half interrupt handler called by trigger
- * @private_data:	iio_dev
- **/
-static void ade7758_poll_func_th(struct iio_dev *indio_dev, s64 time)
-{
-	struct ade7758_state *st = iio_dev_get_devdata(indio_dev);
-	st->last_timestamp = time;
-	schedule_work(&st->work_trigger_to_ring);
-	/* Indicate that this interrupt is being handled */
-
-	/* Technically this is trigger related, but without this
-	 * handler running there is currently no way for the interrupt
-	 * to clear.
-	 */
-}
-
-/**
  * ade7758_spi_read_burst() - read all data registers
  * @dev: device associated with child of actual device (iio_dev or iio_trig)
  * @rx: somewhere to pass back the value read (min size is 24 bytes)
@@ -117,13 +100,12 @@ static int ade7758_spi_read_burst(struct device *dev, u8 *rx)
 /* Whilst this makes a lot of calls to iio_sw_ring functions - it is to device
  * specific to be rolled into the core.
  */
-static void ade7758_trigger_bh_to_ring(struct work_struct *work_s)
+static irqreturn_t ade7758_trigger_handler(int irq, void *p)
 {
-	struct ade7758_state *st
-		= container_of(work_s, struct ade7758_state,
-			       work_trigger_to_ring);
-	struct iio_ring_buffer *ring = st->indio_dev->ring;
-
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->private_data;
+	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct ade7758_state *st = iio_dev_get_devdata(indio_dev);
 	int i = 0;
 	s32 *data;
 	size_t datasize = ring->access.get_bytes_per_datum(ring);
@@ -131,7 +113,7 @@ static void ade7758_trigger_bh_to_ring(struct work_struct *work_s)
 	data = kmalloc(datasize, GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(&st->us->dev, "memory alloc failed in ring bh");
-		return;
+		return -ENOMEM;
 	}
 
 	if (ring->scan_count)
@@ -145,20 +127,21 @@ static void ade7758_trigger_bh_to_ring(struct work_struct *work_s)
 	if (ring->scan_timestamp)
 		*((s64 *)
 		(((u32)data + 4 * ring->scan_count + 4) & ~0x7)) =
-			st->last_timestamp;
+			pf->timestamp;
 
 	ring->access.store_to(ring,
 			      (u8 *)data,
-			      st->last_timestamp);
+			      pf->timestamp);
 
 	iio_trigger_notify_done(st->indio_dev->trig);
 	kfree(data);
 
-	return;
+	return IRQ_HANDLED;
 }
 
 void ade7758_unconfigure_ring(struct iio_dev *indio_dev)
 {
+	kfree(indio_dev->pollfunc->name);
 	kfree(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
@@ -166,9 +149,7 @@ void ade7758_unconfigure_ring(struct iio_dev *indio_dev)
 int ade7758_configure_ring(struct iio_dev *indio_dev)
 {
 	int ret = 0;
-	struct ade7758_state *st = indio_dev->dev_data;
 	struct iio_ring_buffer *ring;
-	INIT_WORK(&st->work_trigger_to_ring, ade7758_trigger_bh_to_ring);
 
 	ring = iio_sw_rb_allocate(indio_dev);
 	if (!ring) {
@@ -189,13 +170,26 @@ int ade7758_configure_ring(struct iio_dev *indio_dev)
 	/* Set default scan mode */
 	iio_scan_mask_set(ring, iio_scan_el_wform.number);
 
-	ret = iio_alloc_pollfunc(indio_dev, NULL, &ade7758_poll_func_th);
-	if (ret)
+	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
+	if (indio_dev->pollfunc == NULL) {
+		ret = -ENOMEM;
 		goto error_iio_sw_rb_free;
-
+	}
+	indio_dev->pollfunc->private_data = indio_dev->ring;
+	indio_dev->pollfunc->h = &iio_pollfunc_store_time;
+	indio_dev->pollfunc->thread = &ade7758_trigger_handler;
+	indio_dev->pollfunc->name
+		= kasprintf(GFP_KERNEL, "ade7759_consumer%d", indio_dev->id);
+	if (indio_dev->pollfunc->name == NULL) {
+		ret = -ENOMEM;
+		goto error_free_pollfunc;
+	}
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
+
 	return 0;
 
+error_free_pollfunc:
+	kfree(indio_dev->pollfunc);
 error_iio_sw_rb_free:
 	iio_sw_rb_free(indio_dev->ring);
 	return ret;
-- 
1.7.3.4

