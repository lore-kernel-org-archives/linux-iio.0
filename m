Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: Greg KH <greg@kroah.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
	akpm@linux-foundation.org,
	linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/3] staging:iio:lis3l02dq add a thresh_timestamp field to state for no ring case
Date: Wed, 28 Jul 2010 20:07:36 +0100
Message-Id: <1280344057-18786-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <4C5077A0.7090701@cam.ac.uk>
References: <4C5077A0.7090701@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/lis3l02dq.h      |    2 ++
 drivers/staging/iio/accel/lis3l02dq_core.c |   14 +++++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq.h b/drivers/staging/iio/accel/lis3l02dq.h
index 44669ee..6e73055 100644
--- a/drivers/staging/iio/accel/lis3l02dq.h
+++ b/drivers/staging/iio/accel/lis3l02dq.h
@@ -151,6 +151,7 @@ Form of high byte dependant on justification set in ctrl reg */
  * @helper:		data and func pointer allowing generic functions
  * @us:			actual spi_device
  * @work_thresh:	bh for threshold events
+ * @thresh_timestamp:	timestamp for threshold interrupts.
  * @inter:		used to check if new interrupt has been triggered
  * @trig:		data ready trigger registered with iio
  * @tx:			transmit buffer
@@ -161,6 +162,7 @@ struct lis3l02dq_state {
 	struct iio_sw_ring_helper_state	help;
 	struct spi_device		*us;
 	struct work_struct		work_thresh;
+	s64				thresh_timestamp;
 	bool				inter;
 	struct iio_trigger		*trig;
 	u8				*tx;
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index b04f498..0ee9337 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -615,7 +615,7 @@ static int lis3l02dq_thresh_handler_th(struct iio_dev *indio_dev,
 	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
 
 	/* Stash the timestamp somewhere convenient for the bh */
-	h->last_timestamp = timestamp;
+	st->thresh_timestamp = timestamp;
 	schedule_work(&st->work_thresh);
 
 	return 0;
@@ -640,32 +640,32 @@ static void lis3l02dq_thresh_handler_bh_no_check(struct work_struct *work_s)
 	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_Z_HIGH)
 		iio_push_event(st->help.indio_dev, 0,
 			       IIO_EVENT_CODE_ACCEL_Z_HIGH,
-			       st->help.last_timestamp);
+			       st->thresh_timestamp);
 
 	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_Z_LOW)
 		iio_push_event(st->help.indio_dev, 0,
 			       IIO_EVENT_CODE_ACCEL_Z_LOW,
-			       st->help.last_timestamp);
+			       st->thresh_timestamp);
 
 	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_Y_HIGH)
 		iio_push_event(st->help.indio_dev, 0,
 			       IIO_EVENT_CODE_ACCEL_Y_HIGH,
-			       st->help.last_timestamp);
+			       st->thresh_timestamp);
 
 	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_Y_LOW)
 		iio_push_event(st->help.indio_dev, 0,
 			       IIO_EVENT_CODE_ACCEL_Y_LOW,
-			       st->help.last_timestamp);
+			       st->thresh_timestamp);
 
 	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_X_HIGH)
 		iio_push_event(st->help.indio_dev, 0,
 			       IIO_EVENT_CODE_ACCEL_X_HIGH,
-			       st->help.last_timestamp);
+			       st->thresh_timestamp);
 
 	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_X_LOW)
 		iio_push_event(st->help.indio_dev, 0,
 			       IIO_EVENT_CODE_ACCEL_X_LOW,
-			       st->help.last_timestamp);
+			       st->thresh_timestamp);
 	/* reenable the irq */
 	enable_irq(st->us->irq);
 	/* Ack and allow for new interrupts */
-- 
1.7.1
