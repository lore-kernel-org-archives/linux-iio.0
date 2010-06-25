Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Barry.Song@analog.com, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 5/6] staging:iio: remove timestamp field from trigger and pass instead through pollfuncs
Date: Fri, 25 Jun 2010 16:55:13 +0100
Message-Id: <1277481314-31717-6-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1277481314-31717-5-git-send-email-jic23@cam.ac.uk>
References: <1277481314-31717-1-git-send-email-jic23@cam.ac.uk>
 <1277481314-31717-2-git-send-email-jic23@cam.ac.uk>
 <1277481314-31717-3-git-send-email-jic23@cam.ac.uk>
 <1277481314-31717-4-git-send-email-jic23@cam.ac.uk>
 <1277481314-31717-5-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 Noticed this in passing.  The trig->timestamp value was simply
 used to pass the timestamp into iio_trigger_poll and to functions
 called from there.  Lets move it to a function parameter to make
 code easier to follow.

 drivers/staging/iio/accel/adis16209_ring.c         |    4 ++--
 drivers/staging/iio/accel/adis16209_trigger.c      |    3 +--
 drivers/staging/iio/accel/adis16240_ring.c         |    4 ++--
 drivers/staging/iio/accel/adis16240_trigger.c      |    3 +--
 drivers/staging/iio/accel/lis3l02dq_ring.c         |    9 ++++-----
 drivers/staging/iio/adc/max1363_ring.c             |    2 +-
 drivers/staging/iio/gyro/adis16260_ring.c          |    4 ++--
 drivers/staging/iio/gyro/adis16260_trigger.c       |    3 +--
 drivers/staging/iio/imu/adis16300_ring.c           |    4 ++--
 drivers/staging/iio/imu/adis16300_trigger.c        |    3 +--
 drivers/staging/iio/imu/adis16350_ring.c           |    4 ++--
 drivers/staging/iio/imu/adis16350_trigger.c        |    3 +--
 drivers/staging/iio/imu/adis16400_ring.c           |    4 ++--
 drivers/staging/iio/imu/adis16400_trigger.c        |    3 +--
 drivers/staging/iio/industrialio-trigger.c         |   10 +++++-----
 drivers/staging/iio/trigger.h                      |   12 +++++++-----
 drivers/staging/iio/trigger/iio-trig-gpio.c        |    3 ++-
 .../staging/iio/trigger/iio-trig-periodic-rtc.c    |    3 ++-
 18 files changed, 39 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index 3b42a65..ad71538 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -68,10 +68,10 @@ static struct attribute_group adis16209_scan_el_group = {
  * adis16209_poll_func_th() top half interrupt handler called by trigger
  * @private_data:	iio_dev
  **/
-static void adis16209_poll_func_th(struct iio_dev *indio_dev)
+static void adis16209_poll_func_th(struct iio_dev *indio_dev, s64 time)
 {
 	struct adis16209_state *st = iio_dev_get_devdata(indio_dev);
-	st->last_timestamp = indio_dev->trig->timestamp;
+	st->last_timestamp = time;
 	schedule_work(&st->work_trigger_to_ring);
 }
 
diff --git a/drivers/staging/iio/accel/adis16209_trigger.c b/drivers/staging/iio/accel/adis16209_trigger.c
index cd901a4..1487eff 100644
--- a/drivers/staging/iio/accel/adis16209_trigger.c
+++ b/drivers/staging/iio/accel/adis16209_trigger.c
@@ -23,8 +23,7 @@ static int adis16209_data_rdy_trig_poll(struct iio_dev *dev_info,
 	struct adis16209_state *st = iio_dev_get_devdata(dev_info);
 	struct iio_trigger *trig = st->trig;
 
-	trig->timestamp = timestamp;
-	iio_trigger_poll(trig);
+	iio_trigger_poll(trig, timestamp);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index 08fef63..5cced2e 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -62,10 +62,10 @@ static struct attribute_group adis16240_scan_el_group = {
  * adis16240_poll_func_th() top half interrupt handler called by trigger
  * @private_data:	iio_dev
  **/
-static void adis16240_poll_func_th(struct iio_dev *indio_dev)
+static void adis16240_poll_func_th(struct iio_dev *indio_dev, s64 time)
 {
 	struct adis16240_state *st = iio_dev_get_devdata(indio_dev);
-	st->last_timestamp = indio_dev->trig->timestamp;
+	st->last_timestamp = time;
 	schedule_work(&st->work_trigger_to_ring);
 }
 
diff --git a/drivers/staging/iio/accel/adis16240_trigger.c b/drivers/staging/iio/accel/adis16240_trigger.c
index d58b405..2ba71fd 100644
--- a/drivers/staging/iio/accel/adis16240_trigger.c
+++ b/drivers/staging/iio/accel/adis16240_trigger.c
@@ -23,8 +23,7 @@ static int adis16240_data_rdy_trig_poll(struct iio_dev *dev_info,
 	struct adis16240_state *st = iio_dev_get_devdata(dev_info);
 	struct iio_trigger *trig = st->trig;
 
-	trig->timestamp = timestamp;
-	iio_trigger_poll(trig);
+	iio_trigger_poll(trig, timestamp);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index bc0de78..28d95ed 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -103,10 +103,10 @@ static struct attribute_group lis3l02dq_scan_el_group = {
  * lis3l02dq_poll_func_th() top half interrupt handler called by trigger
  * @private_data:	iio_dev
  **/
-static void lis3l02dq_poll_func_th(struct iio_dev *indio_dev)
+static void lis3l02dq_poll_func_th(struct iio_dev *indio_dev, s64 time)
 {
-  struct lis3l02dq_state *st = iio_dev_get_devdata(indio_dev);
-	st->last_timestamp = indio_dev->trig->timestamp;
+	struct lis3l02dq_state *st = iio_dev_get_devdata(indio_dev);
+	st->last_timestamp = time;
 	schedule_work(&st->work_trigger_to_ring);
 	/* Indicate that this interrupt is being handled */
 
@@ -128,8 +128,7 @@ static int lis3l02dq_data_rdy_trig_poll(struct iio_dev *dev_info,
 	struct lis3l02dq_state *st = iio_dev_get_devdata(dev_info);
 	struct iio_trigger *trig = st->trig;
 
-	trig->timestamp = timestamp;
-	iio_trigger_poll(trig);
+	iio_trigger_poll(trig, timestamp);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index 896973d..1e0ad9d 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -112,7 +112,7 @@ static int max1363_ring_preenable(struct iio_dev *indio_dev)
  * then.  Some triggers will generate their own time stamp.  Currently
  * there is no way of notifying them when no one cares.
  **/
-static void max1363_poll_func_th(struct iio_dev *indio_dev)
+static void max1363_poll_func_th(struct iio_dev *indio_dev, s64 time)
 {
 	struct max1363_state *st = indio_dev->dev_data;
 
diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index 05e7a69..97d7660 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -59,10 +59,10 @@ static struct attribute_group adis16260_scan_el_group = {
  * adis16260_poll_func_th() top half interrupt handler called by trigger
  * @private_data:	iio_dev
  **/
-static void adis16260_poll_func_th(struct iio_dev *indio_dev)
+static void adis16260_poll_func_th(struct iio_dev *indio_dev, s64 time)
 {
 	struct adis16260_state *st = iio_dev_get_devdata(indio_dev);
-	st->last_timestamp = indio_dev->trig->timestamp;
+	st->last_timestamp = time;
 	schedule_work(&st->work_trigger_to_ring);
 }
 
diff --git a/drivers/staging/iio/gyro/adis16260_trigger.c b/drivers/staging/iio/gyro/adis16260_trigger.c
index 54afd9e..de01537 100644
--- a/drivers/staging/iio/gyro/adis16260_trigger.c
+++ b/drivers/staging/iio/gyro/adis16260_trigger.c
@@ -23,8 +23,7 @@ static int adis16260_data_rdy_trig_poll(struct iio_dev *dev_info,
 	struct adis16260_state *st = iio_dev_get_devdata(dev_info);
 	struct iio_trigger *trig = st->trig;
 
-	trig->timestamp = timestamp;
-	iio_trigger_poll(trig);
+	iio_trigger_poll(trig, timestamp);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/staging/iio/imu/adis16300_ring.c b/drivers/staging/iio/imu/adis16300_ring.c
index 4dee670..6b25f12 100644
--- a/drivers/staging/iio/imu/adis16300_ring.c
+++ b/drivers/staging/iio/imu/adis16300_ring.c
@@ -75,10 +75,10 @@ static struct attribute_group adis16300_scan_el_group = {
  * adis16300_poll_func_th() top half interrupt handler called by trigger
  * @private_data:	iio_dev
  **/
-static void adis16300_poll_func_th(struct iio_dev *indio_dev)
+static void adis16300_poll_func_th(struct iio_dev *indio_dev, s64 time)
 {
 	struct adis16300_state *st = iio_dev_get_devdata(indio_dev);
-	st->last_timestamp = indio_dev->trig->timestamp;
+	st->last_timestamp = time;
 	schedule_work(&st->work_trigger_to_ring);
 	/* Indicate that this interrupt is being handled */
 
diff --git a/drivers/staging/iio/imu/adis16300_trigger.c b/drivers/staging/iio/imu/adis16300_trigger.c
index a55f383..64036cd 100644
--- a/drivers/staging/iio/imu/adis16300_trigger.c
+++ b/drivers/staging/iio/imu/adis16300_trigger.c
@@ -23,8 +23,7 @@ static int adis16300_data_rdy_trig_poll(struct iio_dev *dev_info,
 	struct adis16300_state *st = iio_dev_get_devdata(dev_info);
 	struct iio_trigger *trig = st->trig;
 
-	trig->timestamp = timestamp;
-	iio_trigger_poll(trig);
+	iio_trigger_poll(trig, timestamp);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/staging/iio/imu/adis16350_ring.c b/drivers/staging/iio/imu/adis16350_ring.c
index c70816d..28c13ef 100644
--- a/drivers/staging/iio/imu/adis16350_ring.c
+++ b/drivers/staging/iio/imu/adis16350_ring.c
@@ -81,10 +81,10 @@ static struct attribute_group adis16350_scan_el_group = {
  * adis16350_poll_func_th() top half interrupt handler called by trigger
  * @private_data:	iio_dev
  **/
-static void adis16350_poll_func_th(struct iio_dev *indio_dev)
+static void adis16350_poll_func_th(struct iio_dev *indio_dev, s64 time)
 {
 	struct adis16350_state *st = iio_dev_get_devdata(indio_dev);
-	st->last_timestamp = indio_dev->trig->timestamp;
+	st->last_timestamp = time;
 	schedule_work(&st->work_trigger_to_ring);
 }
 
diff --git a/drivers/staging/iio/imu/adis16350_trigger.c b/drivers/staging/iio/imu/adis16350_trigger.c
index fbe246a..76edccc 100644
--- a/drivers/staging/iio/imu/adis16350_trigger.c
+++ b/drivers/staging/iio/imu/adis16350_trigger.c
@@ -23,8 +23,7 @@ static int adis16350_data_rdy_trig_poll(struct iio_dev *dev_info,
 	struct adis16350_state *st = iio_dev_get_devdata(dev_info);
 	struct iio_trigger *trig = st->trig;
 
-	trig->timestamp = timestamp;
-	iio_trigger_poll(trig);
+	iio_trigger_poll(trig, timestamp);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index 8f7d257..95f53b2 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -84,10 +84,10 @@ static struct attribute_group adis16400_scan_el_group = {
  * adis16400_poll_func_th() top half interrupt handler called by trigger
  * @private_data:	iio_dev
  **/
-static void adis16400_poll_func_th(struct iio_dev *indio_dev)
+static void adis16400_poll_func_th(struct iio_dev *indio_dev, s64 time)
 {
 	struct adis16400_state *st = iio_dev_get_devdata(indio_dev);
-	st->last_timestamp = indio_dev->trig->timestamp;
+	st->last_timestamp = time;
 	schedule_work(&st->work_trigger_to_ring);
 	/* Indicate that this interrupt is being handled */
 
diff --git a/drivers/staging/iio/imu/adis16400_trigger.c b/drivers/staging/iio/imu/adis16400_trigger.c
index bf7c603..aafe601 100644
--- a/drivers/staging/iio/imu/adis16400_trigger.c
+++ b/drivers/staging/iio/imu/adis16400_trigger.c
@@ -23,8 +23,7 @@ static int adis16400_data_rdy_trig_poll(struct iio_dev *dev_info,
 	struct adis16400_state *st = iio_dev_get_devdata(dev_info);
 	struct iio_trigger *trig = st->trig;
 
-	trig->timestamp = timestamp;
-	iio_trigger_poll(trig);
+	iio_trigger_poll(trig, timestamp);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index 0f8ba14..0d5f15b 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -173,7 +173,7 @@ struct iio_trigger *iio_trigger_find_by_name(const char *name, size_t len)
 }
 EXPORT_SYMBOL(iio_trigger_find_by_name);
 
-void iio_trigger_poll(struct iio_trigger *trig)
+void iio_trigger_poll(struct iio_trigger *trig, s64 time)
 {
 	struct iio_poll_func *pf_cursor;
 
@@ -185,7 +185,8 @@ void iio_trigger_poll(struct iio_trigger *trig)
 	}
 	list_for_each_entry(pf_cursor, &trig->pollfunc_list, list) {
 		if (pf_cursor->poll_func_main) {
-			pf_cursor->poll_func_main(pf_cursor->private_data);
+			pf_cursor->poll_func_main(pf_cursor->private_data,
+						  time);
 			trig->use_count++;
 		}
 	}
@@ -198,8 +199,7 @@ void iio_trigger_notify_done(struct iio_trigger *trig)
 	if (trig->use_count == 0 && trig->try_reenable)
 		if (trig->try_reenable(trig)) {
 			/* Missed and interrupt so launch new poll now */
-			trig->timestamp = 0;
-			iio_trigger_poll(trig);
+			iio_trigger_poll(trig, 0);
 		}
 }
 EXPORT_SYMBOL(iio_trigger_notify_done);
@@ -401,7 +401,7 @@ EXPORT_SYMBOL(iio_device_unregister_trigger_consumer);
 
 int iio_alloc_pollfunc(struct iio_dev *indio_dev,
 		       void (*immediate)(struct iio_dev *indio_dev),
-		       void (*main)(struct iio_dev  *private_data))
+		       void (*main)(struct iio_dev *private_data, s64 time))
 {
 	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
 	if (indio_dev->pollfunc == NULL)
diff --git a/drivers/staging/iio/trigger.h b/drivers/staging/iio/trigger.h
index 832de15..4699586 100644
--- a/drivers/staging/iio/trigger.h
+++ b/drivers/staging/iio/trigger.h
@@ -21,7 +21,6 @@
  * @pollfunc_list_lock:	[INTERN] protection of the polling function list
  * @pollfunc_list:	[INTERN] list of functions to run on trigger.
  * @control_attrs:	[DRIVER] sysfs attributes relevant to trigger type
- * @timestamp:		[INTERN] timestamp usesd by some trigs (e.g. datardy)
  * @owner:		[DRIVER] used to monitor usage count of the trigger.
  * @use_count:		use count for the trigger
  * @set_trigger_state:	[DRIVER] switch on/off the trigger on demand
@@ -39,7 +38,6 @@ struct iio_trigger {
 	spinlock_t			pollfunc_list_lock;
 	struct list_head		pollfunc_list;
 	const struct attribute_group	*control_attrs;
-	s64				timestamp;
 	struct module			*owner;
 	int use_count;
 
@@ -120,7 +118,7 @@ int iio_trigger_dettach_poll_func(struct iio_trigger *trig,
  *
  * Typically called in relevant hardware interrupt handler.
  **/
-void iio_trigger_poll(struct iio_trigger *trig);
+void iio_trigger_poll(struct iio_trigger *trig, s64 time);
 void iio_trigger_notify_done(struct iio_trigger *trig);
 
 /**
@@ -144,13 +142,13 @@ struct iio_poll_func {
 	struct				list_head list;
 	void				*private_data;
 	void (*poll_func_immediate)(struct iio_dev *indio_dev);
-	void (*poll_func_main)(struct iio_dev  *private_data);
+	void (*poll_func_main)(struct iio_dev *private_data, s64 time);
 
 };
 
 int iio_alloc_pollfunc(struct iio_dev *indio_dev,
 		       void (*immediate)(struct iio_dev *indio_dev),
-		       void (*main)(struct iio_dev  *private_data));
+		       void (*main)(struct iio_dev *private_data, s64 time));
 
 /*
  * Two functions for common case where all that happens is a pollfunc
@@ -163,4 +161,8 @@ struct iio_trigger *iio_allocate_trigger(void);
 
 void iio_free_trigger(struct iio_trigger *trig);
 
+
+struct iio_simple_trigger {
+	struct iio_trigger trig;
+};
 #endif /* _IIO_TRIGGER_H_ */
diff --git a/drivers/staging/iio/trigger/iio-trig-gpio.c b/drivers/staging/iio/trigger/iio-trig-gpio.c
index 3c0614e..f93cc91 100644
--- a/drivers/staging/iio/trigger/iio-trig-gpio.c
+++ b/drivers/staging/iio/trigger/iio-trig-gpio.c
@@ -42,7 +42,8 @@ struct iio_gpio_trigger_info {
 
 static irqreturn_t iio_gpio_trigger_poll(int irq, void *private)
 {
-	iio_trigger_poll(private);
+	/* Timestamp not currently provided */
+	iio_trigger_poll(private, 0);
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
index d8c58cb..b0b52f8 100644
--- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
+++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
@@ -98,7 +98,8 @@ static const struct attribute_group iio_trig_prtc_attr_group = {
 
 static void iio_prtc_trigger_poll(void *private_data)
 {
-	iio_trigger_poll(private_data);
+	/* Timestamp is not provided currently */
+	iio_trigger_poll(private_data, 0);
 }
 
 static int iio_trig_periodic_rtc_probe(struct platform_device *dev)
-- 
1.6.4.4
