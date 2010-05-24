Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 05/11] staging:iio: Remove used iio_work_cont definition and all references
Date: Mon, 24 May 2010 22:02:50 +0100
Message-Id: <1274734976-7941-6-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1274734976-7941-1-git-send-email-jic23@cam.ac.uk>
References: <1274734976-7941-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16209.h    |    3 --
 drivers/staging/iio/accel/adis16220.h    |    1 -
 drivers/staging/iio/accel/adis16240.h    |    2 -
 drivers/staging/iio/gyro/adis16260.h     |    2 -
 drivers/staging/iio/iio.h                |   43 ------------------------------
 drivers/staging/iio/imu/adis16300.h      |    2 -
 drivers/staging/iio/imu/adis16300_core.c |    8 -----
 drivers/staging/iio/imu/adis16350.h      |    2 -
 drivers/staging/iio/imu/adis16400.h      |    2 -
 drivers/staging/iio/imu/adis16400_core.c |    8 -----
 10 files changed, 0 insertions(+), 73 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209.h b/drivers/staging/iio/accel/adis16209.h
index 877fd2a..c1d7b47 100644
--- a/drivers/staging/iio/accel/adis16209.h
+++ b/drivers/staging/iio/accel/adis16209.h
@@ -105,8 +105,6 @@
  * struct adis16209_state - device instance specific data
  * @us:			actual spi_device
  * @work_trigger_to_ring: bh for triggered event handling
- * @work_cont_thresh: CLEAN
- * @inter:		used to check if new interrupt has been triggered
  * @last_timestamp:	passing timestamp from th to bh of interrupt handler
  * @indio_dev:		industrial I/O device structure
  * @trig:		data ready trigger registered with iio
@@ -117,7 +115,6 @@
 struct adis16209_state {
 	struct spi_device		*us;
 	struct work_struct		work_trigger_to_ring;
-	struct iio_work_cont		work_cont_thresh;
 	s64				last_timestamp;
 	struct iio_dev			*indio_dev;
 	struct iio_trigger		*trig;
diff --git a/drivers/staging/iio/accel/adis16220.h b/drivers/staging/iio/accel/adis16220.h
index 2abf485..7013314 100644
--- a/drivers/staging/iio/accel/adis16220.h
+++ b/drivers/staging/iio/accel/adis16220.h
@@ -127,7 +127,6 @@
  * struct adis16220_state - device instance specific data
  * @us:			actual spi_device
  * @work_trigger_to_ring: bh for triggered event handling
- * @work_cont_thresh: CLEAN
  * @inter:		used to check if new interrupt has been triggered
  * @last_timestamp:	passing timestamp from th to bh of interrupt handler
  * @indio_dev:		industrial I/O device structure
diff --git a/drivers/staging/iio/accel/adis16240.h b/drivers/staging/iio/accel/adis16240.h
index dcff43c..86e0f3d 100644
--- a/drivers/staging/iio/accel/adis16240.h
+++ b/drivers/staging/iio/accel/adis16240.h
@@ -127,7 +127,6 @@
  * struct adis16240_state - device instance specific data
  * @us:			actual spi_device
  * @work_trigger_to_ring: bh for triggered event handling
- * @work_cont_thresh: CLEAN
  * @inter:		used to check if new interrupt has been triggered
  * @last_timestamp:	passing timestamp from th to bh of interrupt handler
  * @indio_dev:		industrial I/O device structure
@@ -139,7 +138,6 @@
 struct adis16240_state {
 	struct spi_device		*us;
 	struct work_struct		work_trigger_to_ring;
-	struct iio_work_cont		work_cont_thresh;
 	s64				last_timestamp;
 	struct iio_dev			*indio_dev;
 	struct iio_trigger		*trig;
diff --git a/drivers/staging/iio/gyro/adis16260.h b/drivers/staging/iio/gyro/adis16260.h
index f19efb4..53f5fbd 100644
--- a/drivers/staging/iio/gyro/adis16260.h
+++ b/drivers/staging/iio/gyro/adis16260.h
@@ -85,7 +85,6 @@
  * struct adis16260_state - device instance specific data
  * @us:			actual spi_device
  * @work_trigger_to_ring: bh for triggered event handling
- * @work_cont_thresh: CLEAN
  * @inter:		used to check if new interrupt has been triggered
  * @last_timestamp:	passing timestamp from th to bh of interrupt handler
  * @indio_dev:		industrial I/O device structure
@@ -97,7 +96,6 @@
 struct adis16260_state {
 	struct spi_device		*us;
 	struct work_struct		work_trigger_to_ring;
-	struct iio_work_cont		work_cont_thresh;
 	s64				last_timestamp;
 	struct iio_dev			*indio_dev;
 	struct iio_trigger		*trig;
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index fcee47c..6b9c752 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -284,49 +284,6 @@ int iio_push_event(struct iio_dev *dev_info,
 		  s64 timestamp);
 
 /**
- * struct iio_work_cont - container for when singleton handler case matters
- * @ws:			[DEVICE] work_struct when not only possible event
- * @ws_nocheck:		[DEVICE] work_struct when only possible event
- * @address:		[DEVICE] associated register address
- * @mask:		[DEVICE] associated mask for identifying event source
- * @st:			[DEVICE] device specific state information
- **/
-struct iio_work_cont {
-	struct work_struct	ws;
-	struct work_struct	ws_nocheck;
-	int			address;
-	int			mask;
-	void			*st;
-};
-
-#define to_iio_work_cont_check(_ws)			\
-	container_of(_ws, struct iio_work_cont, ws)
-
-#define to_iio_work_cont_no_check(_ws)				\
-	container_of(_ws, struct iio_work_cont, ws_nocheck)
-
-/**
- * iio_init_work_cont() - intiialize the elements of a work container
- * @cont: the work container
- * @_checkfunc: function called when there are multiple possible int sources
- * @_nocheckfunc: function for when there is only one int source
- * @_add: driver dependent, typically a register address
- * @_mask: driver dependent, typically a bit mask for a register
- * @_st: driver dependent, typically pointer to a device state structure
- **/
-static inline void
-iio_init_work_cont(struct iio_work_cont *cont,
-		   void (*_checkfunc)(struct work_struct *),
-		   void (*_nocheckfunc)(struct work_struct *),
-		   int _add, int _mask, void *_st)
-{
-	INIT_WORK(&(cont)->ws, _checkfunc);
-	INIT_WORK(&(cont)->ws_nocheck, _nocheckfunc);
-	cont->address = _add;
-	cont->mask = _mask;
-	cont->st = _st;
-}
-/**
  * __iio_push_event() - tries to add an event to the list associated with a chrdev
  * @ev_int:		the event interface to which we are pushing the event
  * @ev_code:		the outgoing event code
diff --git a/drivers/staging/iio/imu/adis16300.h b/drivers/staging/iio/imu/adis16300.h
index 1c7ea5c..dfe7e64 100644
--- a/drivers/staging/iio/imu/adis16300.h
+++ b/drivers/staging/iio/imu/adis16300.h
@@ -94,7 +94,6 @@
  * struct adis16300_state - device instance specific data
  * @us:			actual spi_device
  * @work_trigger_to_ring: bh for triggered event handling
- * @work_cont_thresh: CLEAN
  * @inter:		used to check if new interrupt has been triggered
  * @last_timestamp:	passing timestamp from th to bh of interrupt handler
  * @indio_dev:		industrial I/O device structure
@@ -106,7 +105,6 @@
 struct adis16300_state {
 	struct spi_device		*us;
 	struct work_struct		work_trigger_to_ring;
-	struct iio_work_cont		work_cont_thresh;
 	s64				last_timestamp;
 	struct iio_dev			*indio_dev;
 	struct iio_trigger		*trig;
diff --git a/drivers/staging/iio/imu/adis16300_core.c b/drivers/staging/iio/imu/adis16300_core.c
index 5a7e5ef..cfedf6d 100644
--- a/drivers/staging/iio/imu/adis16300_core.c
+++ b/drivers/staging/iio/imu/adis16300_core.c
@@ -660,14 +660,6 @@ static int __devinit adis16300_probe(struct spi_device *spi)
 	}
 
 	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0) {
-#if 0 /* fixme: here we should support */
-		iio_init_work_cont(&st->work_cont_thresh,
-				NULL,
-				adis16300_thresh_handler_bh_no_check,
-				0,
-				0,
-				st);
-#endif
 		ret = iio_register_interrupt_line(spi->irq,
 				st->indio_dev,
 				0,
diff --git a/drivers/staging/iio/imu/adis16350.h b/drivers/staging/iio/imu/adis16350.h
index 334b18a..b4533a0 100644
--- a/drivers/staging/iio/imu/adis16350.h
+++ b/drivers/staging/iio/imu/adis16350.h
@@ -100,7 +100,6 @@
  * struct adis16350_state - device instance specific data
  * @us:			actual spi_device
  * @work_trigger_to_ring: bh for triggered event handling
- * @work_cont_thresh: CLEAN
  * @inter:		used to check if new interrupt has been triggered
  * @last_timestamp:	passing timestamp from th to bh of interrupt handler
  * @indio_dev:		industrial I/O device structure
@@ -112,7 +111,6 @@
 struct adis16350_state {
 	struct spi_device		*us;
 	struct work_struct		work_trigger_to_ring;
-	struct iio_work_cont		work_cont_data_rdy;
 	s64				last_timestamp;
 	struct iio_dev			*indio_dev;
 	struct iio_trigger		*trig;
diff --git a/drivers/staging/iio/imu/adis16400.h b/drivers/staging/iio/imu/adis16400.h
index 5a69a7a..c78c840 100644
--- a/drivers/staging/iio/imu/adis16400.h
+++ b/drivers/staging/iio/imu/adis16400.h
@@ -126,7 +126,6 @@
  * struct adis16400_state - device instance specific data
  * @us:			actual spi_device
  * @work_trigger_to_ring: bh for triggered event handling
- * @work_cont_thresh: CLEAN
  * @inter:		used to check if new interrupt has been triggered
  * @last_timestamp:	passing timestamp from th to bh of interrupt handler
  * @indio_dev:		industrial I/O device structure
@@ -138,7 +137,6 @@
 struct adis16400_state {
 	struct spi_device		*us;
 	struct work_struct		work_trigger_to_ring;
-	struct iio_work_cont		work_cont_thresh;
 	s64				last_timestamp;
 	struct iio_dev			*indio_dev;
 	struct iio_trigger		*trig;
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index e69e2ce..d416ec7 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -692,14 +692,6 @@ static int __devinit adis16400_probe(struct spi_device *spi)
 	}
 
 	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0) {
-#if 0 /* fixme: here we should support */
-		iio_init_work_cont(&st->work_cont_thresh,
-				NULL,
-				adis16400_thresh_handler_bh_no_check,
-				0,
-				0,
-				st);
-#endif
 		ret = iio_register_interrupt_line(spi->irq,
 				st->indio_dev,
 				0,
-- 
1.7.0.4
