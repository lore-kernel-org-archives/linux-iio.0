Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 03/11] staging:iio:lis3l02dq cleanups
Date: Mon, 24 May 2010 22:02:48 +0100
Message-Id: <1274734976-7941-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1274734976-7941-1-git-send-email-jic23@cam.ac.uk>
References: <1274734976-7941-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/lis3l02dq.h      |    4 ++--
 drivers/staging/iio/accel/lis3l02dq_core.c |   25 ++++++++-----------------
 drivers/staging/iio/accel/lis3l02dq_ring.c |    8 --------
 3 files changed, 10 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq.h b/drivers/staging/iio/accel/lis3l02dq.h
index e76a979..7f09d2e 100644
--- a/drivers/staging/iio/accel/lis3l02dq.h
+++ b/drivers/staging/iio/accel/lis3l02dq.h
@@ -150,7 +150,7 @@ Form of high byte dependant on justification set in ctrl reg */
  * struct lis3l02dq_state - device instance specific data
  * @us:			actual spi_device
  * @work_trigger_to_ring: bh for triggered event handling
- * @work_cont_thresh: CLEAN
+ * @work_thresh:	bh for threshold events
  * @inter:		used to check if new interrupt has been triggered
  * @last_timestamp:	passing timestamp from th to bh of interrupt handler
  * @indio_dev:		industrial I/O device structure
@@ -162,7 +162,7 @@ Form of high byte dependant on justification set in ctrl reg */
 struct lis3l02dq_state {
 	struct spi_device		*us;
 	struct work_struct		work_trigger_to_ring;
-	struct iio_work_cont		work_cont_thresh;
+	struct work_struct		work_thresh;
 	bool				inter;
 	s64				last_timestamp;
 	struct iio_dev			*indio_dev;
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 6b5577d..4034869 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -96,7 +96,7 @@ int lis3l02dq_spi_write_reg_8(struct device *dev,
 
 	spi_message_init(&msg);
 	spi_message_add_tail(&xfer, &msg);
-	ret =  spi_sync(st->us, &msg);
+	ret = spi_sync(st->us, &msg);
 	mutex_unlock(&st->buf_lock);
 
 	return ret;
@@ -524,8 +524,7 @@ static ssize_t lis3l02dq_read_interrupt_config(struct device *dev,
 				       LIS3L02DQ_REG_WAKE_UP_CFG_ADDR,
 				       (u8 *)&val);
 
-	return ret ? ret : sprintf(buf, "%d\n",
-				   (val & this_attr->mask) ? 1 : 0);;
+	return ret ? ret : sprintf(buf, "%d\n", !!(val & this_attr->mask));
 }
 
 static ssize_t lis3l02dq_write_interrupt_config(struct device *dev,
@@ -604,7 +603,7 @@ static int lis3l02dq_thresh_handler_th(struct iio_dev *dev_info,
 
 	/* Stash the timestamp somewhere convenient for the bh */
 	st->last_timestamp = timestamp;
-	schedule_work(&st->work_cont_thresh.ws);
+	schedule_work(&st->work_thresh);
 
 	return 0;
 }
@@ -615,9 +614,10 @@ static int lis3l02dq_thresh_handler_th(struct iio_dev *dev_info,
  */
 static void lis3l02dq_thresh_handler_bh_no_check(struct work_struct *work_s)
 {
-	struct iio_work_cont *wc
-		= container_of(work_s, struct iio_work_cont, ws);
-	struct lis3l02dq_state *st = wc->st;
+       struct lis3l02dq_state *st
+	       = container_of(work_s,
+		       struct lis3l02dq_state, work_thresh);
+
 	u8 t;
 
 	lis3l02dq_spi_read_reg_8(&st->indio_dev->dev,
@@ -750,6 +750,7 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 		ret =  -ENOMEM;
 		goto error_ret;
 	}
+	INIT_WORK(&st->work_thresh, lis3l02dq_thresh_handler_bh_no_check);
 	/* this is only used tor removal purposes */
 	spi_set_drvdata(spi, st);
 
@@ -797,16 +798,6 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 	}
 
 	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0) {
-		/* This is a little unusual, in that the device seems
-		   to need a full read of the interrupt source reg before
-		   the interrupt will reset.
-		   Hence the two handlers are the same */
-		iio_init_work_cont(&st->work_cont_thresh,
-				   lis3l02dq_thresh_handler_bh_no_check,
-				   lis3l02dq_thresh_handler_bh_no_check,
-				   LIS3L02DQ_REG_WAKE_UP_SRC_ADDR,
-				   0,
-				   st);
 		st->inter = 0;
 		ret = iio_register_interrupt_line(spi->irq,
 						  st->indio_dev,
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index e4e202e..6b0b124 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -591,12 +591,4 @@ void lis3l02dq_uninitialize_ring(struct iio_ring_buffer *ring)
 	iio_ring_buffer_unregister(ring);
 }
 
-int lis3l02dq_set_ring_length(struct iio_dev *indio_dev, int length)
-{
-	/* Set sensible defaults for the ring buffer */
-	if (indio_dev->ring->access.set_length)
-		return indio_dev->ring->access.set_length(indio_dev->ring, 500);
-	return 0;
-}
-
 
-- 
1.7.0.4
