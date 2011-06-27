Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio:triggers introduce iio_trigger_ops to take const bits out of iio_trig_structure.
Date: Mon, 27 Jun 2011 11:09:48 +0100
Message-Id: <1309169388-24266-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi All,

I mentioned this one a while ago in context of Michael's filtering code for triggers,
but just realized I never actually sent it to the list...

As this messes with the internal api's I'm quite keen to push it soon, so all
comments asap please.

Right now this results in increased code, but I still think it is worth doing to avoid
replication across instances of drivers etc and move as much stuff as possible to constant.
Ops structure is optional for the occasional driver that uses none of it (currently
only the ad7793).

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16201_trigger.c     |    8 +++-
 drivers/staging/iio/accel/adis16203_trigger.c     |    8 +++-
 drivers/staging/iio/accel/adis16204_trigger.c     |    8 +++-
 drivers/staging/iio/accel/adis16209_trigger.c     |    8 +++-
 drivers/staging/iio/accel/adis16240_trigger.c     |    8 +++-
 drivers/staging/iio/accel/lis3l02dq_ring.c        |   10 ++++--
 drivers/staging/iio/gyro/adis16260_trigger.c      |    8 +++-
 drivers/staging/iio/imu/adis16400_trigger.c       |    8 +++-
 drivers/staging/iio/industrialio-trigger.c        |   16 +++++-----
 drivers/staging/iio/meter/ade7758_trigger.c       |   10 ++++--
 drivers/staging/iio/trigger.h                     |   36 ++++++++++++++-------
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c |    6 +++-
 drivers/staging/iio/trigger/iio-trig-gpio.c       |    6 +++-
 drivers/staging/iio/trigger/iio-trig-sysfs.c      |    6 +++-
 14 files changed, 103 insertions(+), 43 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_trigger.c b/drivers/staging/iio/accel/adis16201_trigger.c
index 3a95c08..7c853a6 100644
--- a/drivers/staging/iio/accel/adis16201_trigger.c
+++ b/drivers/staging/iio/accel/adis16201_trigger.c
@@ -23,6 +23,11 @@ static int adis16201_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	return adis16201_set_irq(indio_dev, state);
 }
 
+static const struct iio_trigger_ops adis16201_trigger_ops = {
+	.owner = THIS_MODULE,
+	.set_trigger_state = &adis16201_data_rdy_trigger_set_state,
+};
+
 int adis16201_probe_trigger(struct iio_dev *indio_dev)
 {
 	int ret;
@@ -41,9 +46,8 @@ int adis16201_probe_trigger(struct iio_dev *indio_dev)
 	if (ret)
 		goto error_free_trig;
 	st->trig->dev.parent = &st->us->dev;
-	st->trig->owner = THIS_MODULE;
+	st->trig->ops = &adis16201_trigger_ops;
 	st->trig->private_data = indio_dev;
-	st->trig->set_trigger_state = &adis16201_data_rdy_trigger_set_state;
 	ret = iio_trigger_register(st->trig);
 
 	/* select default trigger */
diff --git a/drivers/staging/iio/accel/adis16203_trigger.c b/drivers/staging/iio/accel/adis16203_trigger.c
index 3caf3e8..9ea1c1e 100644
--- a/drivers/staging/iio/accel/adis16203_trigger.c
+++ b/drivers/staging/iio/accel/adis16203_trigger.c
@@ -24,6 +24,11 @@ static int adis16203_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	return adis16203_set_irq(indio_dev, state);
 }
 
+static const struct iio_trigger_ops adis16203_trigger_ops = {
+	.owner = THIS_MODULE,
+	.set_trigger_state = &adis16203_data_rdy_trigger_set_state,
+};
+
 int adis16203_probe_trigger(struct iio_dev *indio_dev)
 {
 	int ret;
@@ -44,9 +49,8 @@ int adis16203_probe_trigger(struct iio_dev *indio_dev)
 		goto error_free_trig;
 
 	st->trig->dev.parent = &st->us->dev;
-	st->trig->owner = THIS_MODULE;
+	st->trig->ops = &adis16203_trigger_ops;
 	st->trig->private_data = indio_dev;
-	st->trig->set_trigger_state = &adis16203_data_rdy_trigger_set_state;
 	ret = iio_trigger_register(st->trig);
 
 	/* select default trigger */
diff --git a/drivers/staging/iio/accel/adis16204_trigger.c b/drivers/staging/iio/accel/adis16204_trigger.c
index 01f73b9..bd6d293 100644
--- a/drivers/staging/iio/accel/adis16204_trigger.c
+++ b/drivers/staging/iio/accel/adis16204_trigger.c
@@ -24,6 +24,11 @@ static int adis16204_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	return adis16204_set_irq(indio_dev, state);
 }
 
+static const struct iio_trigger_ops adis16204_trigger_ops = {
+	.owner = THIS_MODULE,
+	.set_trigger_state = &adis16204_data_rdy_trigger_set_state,
+};
+
 int adis16204_probe_trigger(struct iio_dev *indio_dev)
 {
 	int ret;
@@ -44,9 +49,8 @@ int adis16204_probe_trigger(struct iio_dev *indio_dev)
 		goto error_free_trig;
 
 	st->trig->dev.parent = &st->us->dev;
-	st->trig->owner = THIS_MODULE;
+	st->trig->ops = &adis16204_trigger_ops;
 	st->trig->private_data = indio_dev;
-	st->trig->set_trigger_state = &adis16204_data_rdy_trigger_set_state;
 	ret = iio_trigger_register(st->trig);
 
 	/* select default trigger */
diff --git a/drivers/staging/iio/accel/adis16209_trigger.c b/drivers/staging/iio/accel/adis16209_trigger.c
index 6df7b47..4c6df9e 100644
--- a/drivers/staging/iio/accel/adis16209_trigger.c
+++ b/drivers/staging/iio/accel/adis16209_trigger.c
@@ -33,6 +33,11 @@ static int adis16209_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	return adis16209_set_irq(indio_dev, state);
 }
 
+static const struct iio_trigger_ops adis16209_trigger_ops = {
+	.owner = THIS_MODULE,
+	.set_trigger_state = &adis16209_data_rdy_trigger_set_state,
+};
+
 int adis16209_probe_trigger(struct iio_dev *indio_dev)
 {
 	int ret;
@@ -52,9 +57,8 @@ int adis16209_probe_trigger(struct iio_dev *indio_dev)
 	if (ret)
 		goto error_free_trig;
 	st->trig->dev.parent = &st->us->dev;
-	st->trig->owner = THIS_MODULE;
+	st->trig->ops = &adis16209_trigger_ops;
 	st->trig->private_data = indio_dev;
-	st->trig->set_trigger_state = &adis16209_data_rdy_trigger_set_state;
 	ret = iio_trigger_register(st->trig);
 
 	/* select default trigger */
diff --git a/drivers/staging/iio/accel/adis16240_trigger.c b/drivers/staging/iio/accel/adis16240_trigger.c
index 17135fc3..0c75338 100644
--- a/drivers/staging/iio/accel/adis16240_trigger.c
+++ b/drivers/staging/iio/accel/adis16240_trigger.c
@@ -33,6 +33,11 @@ static int adis16240_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	return adis16240_set_irq(indio_dev, state);
 }
 
+static const struct iio_trigger_ops adis16240_trigger_ops = {
+	.owner = THIS_MODULE,
+	.set_trigger_state = &adis16240_data_rdy_trigger_set_state,
+};
+
 int adis16240_probe_trigger(struct iio_dev *indio_dev)
 {
 	int ret;
@@ -53,9 +58,8 @@ int adis16240_probe_trigger(struct iio_dev *indio_dev)
 		goto error_free_trig;
 
 	st->trig->dev.parent = &st->us->dev;
-	st->trig->owner = THIS_MODULE;
+	st->trig->ops = &adis16240_trigger_ops;
 	st->trig->private_data = indio_dev;
-	st->trig->set_trigger_state = &adis16240_data_rdy_trigger_set_state;
 	ret = iio_trigger_register(st->trig);
 
 	/* select default trigger */
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 8d5c8ac..5795f82 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -306,6 +306,12 @@ static int lis3l02dq_trig_try_reen(struct iio_trigger *trig)
 	return 0;
 }
 
+static const struct iio_trigger_ops lis3l02dq_trigger_ops = {
+	.owner = THIS_MODULE,
+	.set_trigger_state = &lis3l02dq_data_rdy_trigger_set_state,
+	.try_reenable = &lis3l02dq_trig_try_reen,
+};
+
 int lis3l02dq_probe_trigger(struct iio_dev *indio_dev)
 {
 	int ret;
@@ -318,10 +324,8 @@ int lis3l02dq_probe_trigger(struct iio_dev *indio_dev)
 	}
 
 	st->trig->dev.parent = &st->us->dev;
-	st->trig->owner = THIS_MODULE;
+	st->trig->ops = &lis3l02dq_trigger_ops;
 	st->trig->private_data = indio_dev;
-	st->trig->set_trigger_state = &lis3l02dq_data_rdy_trigger_set_state;
-	st->trig->try_reenable = &lis3l02dq_trig_try_reen;
 	ret = iio_trigger_register(st->trig);
 	if (ret)
 		goto error_free_trig;
diff --git a/drivers/staging/iio/gyro/adis16260_trigger.c b/drivers/staging/iio/gyro/adis16260_trigger.c
index 01094d0..f240961 100644
--- a/drivers/staging/iio/gyro/adis16260_trigger.c
+++ b/drivers/staging/iio/gyro/adis16260_trigger.c
@@ -24,6 +24,11 @@ static int adis16260_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	return adis16260_set_irq(indio_dev, state);
 }
 
+static const struct iio_trigger_ops adis16260_trigger_ops = {
+	.owner = THIS_MODULE,
+	.set_trigger_state = &adis16260_data_rdy_trigger_set_state,
+};
+
 int adis16260_probe_trigger(struct iio_dev *indio_dev)
 {
 	int ret;
@@ -46,9 +51,8 @@ int adis16260_probe_trigger(struct iio_dev *indio_dev)
 		goto error_free_trig;
 
 	st->trig->dev.parent = &st->us->dev;
-	st->trig->owner = THIS_MODULE;
+	st->trig->ops = &adis16260_trigger_ops;
 	st->trig->private_data = indio_dev;
-	st->trig->set_trigger_state = &adis16260_data_rdy_trigger_set_state;
 	ret = iio_trigger_register(st->trig);
 
 	/* select default trigger */
diff --git a/drivers/staging/iio/imu/adis16400_trigger.c b/drivers/staging/iio/imu/adis16400_trigger.c
index c6ec41a..4e1f295 100644
--- a/drivers/staging/iio/imu/adis16400_trigger.c
+++ b/drivers/staging/iio/imu/adis16400_trigger.c
@@ -24,6 +24,11 @@ static int adis16400_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	return adis16400_set_irq(indio_dev, state);
 }
 
+static const struct iio_trigger_ops adis16400_trigger_ops = {
+	.owner = THIS_MODULE,
+	.set_trigger_state = &adis16400_data_rdy_trigger_set_state,
+};
+
 int adis16400_probe_trigger(struct iio_dev *indio_dev)
 {
 	int ret;
@@ -45,9 +50,8 @@ int adis16400_probe_trigger(struct iio_dev *indio_dev)
 	if (ret)
 		goto error_free_trig;
 	st->trig->dev.parent = &st->us->dev;
-	st->trig->owner = THIS_MODULE;
 	st->trig->private_data = indio_dev;
-	st->trig->set_trigger_state = &adis16400_data_rdy_trigger_set_state;
+	st->trig->ops = &adis16400_trigger_ops;
 	ret = iio_trigger_register(st->trig);
 
 	/* select default trigger */
diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index 90ca2df..513a7a0 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -206,8 +206,8 @@ EXPORT_SYMBOL(iio_trigger_poll_chained);
 void iio_trigger_notify_done(struct iio_trigger *trig)
 {
 	trig->use_count--;
-	if (trig->use_count == 0 && trig->try_reenable)
-		if (trig->try_reenable(trig)) {
+	if (trig->use_count == 0 && trig->ops && trig->ops->try_reenable)
+		if (trig->ops->try_reenable(trig)) {
 			/* Missed and interrupt so launch new poll now */
 			iio_trigger_poll(trig, 0);
 		}
@@ -234,8 +234,8 @@ int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 	ret = request_threaded_irq(pf->irq, pf->h, pf->thread,
 				   pf->type, pf->name,
 				   pf);
-	if (trig->set_trigger_state && notinuse)
-		ret = trig->set_trigger_state(trig, true);
+	if (trig->ops && trig->ops->set_trigger_state && notinuse)
+		ret = trig->ops->set_trigger_state(trig, true);
 
 	return ret;
 }
@@ -249,8 +249,8 @@ int iio_trigger_dettach_poll_func(struct iio_trigger *trig,
 		= (bitmap_weight(trig->pool,
 				 CONFIG_IIO_CONSUMERS_PER_TRIGGER)
 		   == 1);
-	if (trig->set_trigger_state && no_other_users) {
-		ret = trig->set_trigger_state(trig, false);
+	if (trig->ops && trig->ops->set_trigger_state && no_other_users) {
+		ret = trig->ops->set_trigger_state(trig, false);
 		if (ret)
 			goto error_ret;
 	}
@@ -358,8 +358,8 @@ static ssize_t iio_trigger_write_current(struct device *dev,
 			return ret;
 	}
 
-	if (trig && trig->validate_device) {
-		ret = trig->validate_device(trig, dev_info);
+	if (trig && trig->ops && trig->ops->validate_device) {
+		ret = trig->ops->validate_device(trig, dev_info);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/staging/iio/meter/ade7758_trigger.c b/drivers/staging/iio/meter/ade7758_trigger.c
index a5c3248..4c451c2 100644
--- a/drivers/staging/iio/meter/ade7758_trigger.c
+++ b/drivers/staging/iio/meter/ade7758_trigger.c
@@ -57,6 +57,12 @@ static int ade7758_trig_try_reen(struct iio_trigger *trig)
 	return 0;
 }
 
+static const struct iio_trigger_ops ade7758_trigger_ops = {
+	.owner = THIS_MODULE,
+	.set_trigger_state = &ade7758_data_rdy_trigger_set_state,
+	.try_reenable = &ade7758_trig_try_reen,
+};
+
 int ade7758_probe_trigger(struct iio_dev *indio_dev)
 {
 	struct ade7758_state *st = iio_priv(indio_dev);
@@ -79,10 +85,8 @@ int ade7758_probe_trigger(struct iio_dev *indio_dev)
 		goto error_free_trig;
 
 	st->trig->dev.parent = &st->us->dev;
-	st->trig->owner = THIS_MODULE;
+	st->trig->ops = &ade7758_trigger_ops;
 	st->trig->private_data = indio_dev;
-	st->trig->set_trigger_state = &ade7758_data_rdy_trigger_set_state;
-	st->trig->try_reenable = &ade7758_trig_try_reen;
 	ret = iio_trigger_register(st->trig);
 
 	/* select default trigger */
diff --git a/drivers/staging/iio/trigger.h b/drivers/staging/iio/trigger.h
index e0b58ed..325e086 100644
--- a/drivers/staging/iio/trigger.h
+++ b/drivers/staging/iio/trigger.h
@@ -16,6 +16,27 @@ struct iio_subirq {
 };
 
 /**
+ * struct iio_trigger_ops - operations structure for an iio_trigger.
+ * @owner:		used to monitor usage count of the trigger.
+ * @set_trigger_state:	switch on/off the trigger on demand
+ * @try_reenable:	function to reenable the trigger when the
+ *			use count is zero (may be NULL)
+ * @validate_device:	function to validate the device when the
+ *			current trigger gets changed.
+ *
+ * This is typically static const within a driver and shared by
+ * instances of a given device.
+ **/
+struct iio_trigger_ops {
+	struct module			*owner;
+	int (*set_trigger_state)(struct iio_trigger *trig, bool state);
+	int (*try_reenable)(struct iio_trigger *trig);
+	int (*validate_device)(struct iio_trigger *trig,
+			       struct iio_dev *indio_dev);
+};
+
+
+/**
  * struct iio_trigger - industrial I/O trigger device
  *
  * @id:			[INTERN] unique id number
@@ -26,11 +47,6 @@ struct iio_subirq {
  * @alloc_list:		[DRIVER] used for driver specific trigger list
  * @owner:		[DRIVER] used to monitor usage count of the trigger.
  * @use_count:		use count for the trigger
- * @set_trigger_state:	[DRIVER] switch on/off the trigger on demand
- * @try_reenable:	function to reenable the trigger when the
- *			use count is zero (may be NULL)
- * @validate_device:	function to validate the device when the
- *			current trigger gets changed.
  * @subirq_chip:	[INTERN] associate 'virtual' irq chip.
  * @subirq_base:	[INTERN] base number for irqs provided by trigger.
  * @subirqs:		[INTERN] information about the 'child' irqs.
@@ -38,6 +54,7 @@ struct iio_subirq {
  * @pool_lock:		[INTERN] protection of the irq pool.
  **/
 struct iio_trigger {
+	const struct iio_trigger_ops	*ops;
 	int				id;
 	const char			*name;
 	struct device			dev;
@@ -48,11 +65,6 @@ struct iio_trigger {
 	struct module			*owner;
 	int use_count;
 
-	int (*set_trigger_state)(struct iio_trigger *trig, bool state);
-	int (*try_reenable)(struct iio_trigger *trig);
-	int (*validate_device)(struct iio_trigger *trig,
-			       struct iio_dev *indio_dev);
-
 	struct irq_chip			subirq_chip;
 	int				subirq_base;
 
@@ -93,12 +105,12 @@ static inline struct iio_trigger *to_iio_trigger(struct device *d)
 static inline void iio_put_trigger(struct iio_trigger *trig)
 {
 	put_device(&trig->dev);
-	module_put(trig->owner);
+	module_put(trig->ops->owner);
 };
 
 static inline void iio_get_trigger(struct iio_trigger *trig)
 {
-	__module_get(trig->owner);
+	__module_get(trig->ops->owner);
 	get_device(&trig->dev);
 };
 
diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
index 4f17295..243f38f 100644
--- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
+++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
@@ -143,6 +143,10 @@ static int iio_bfin_tmr_get_number(int irq)
 	return -ENODEV;
 }
 
+static const struct iio_trigger_ops iio_bfin_tmr_trigger_ops = {
+	owner = THIS_MODULE,
+};
+
 static int __devinit iio_bfin_tmr_trigger_probe(struct platform_device *pdev)
 {
 	struct bfin_tmr_state *st;
@@ -175,7 +179,7 @@ static int __devinit iio_bfin_tmr_trigger_probe(struct platform_device *pdev)
 	}
 
 	st->trig->private_data = st;
-	st->trig->owner = THIS_MODULE;
+	st->trig->ops = &iio_bfin_tmr_trigger_ops;
 	st->trig->dev.groups = iio_bfin_tmr_trigger_attr_groups;
 	ret = iio_trigger_register(st->trig);
 	if (ret)
diff --git a/drivers/staging/iio/trigger/iio-trig-gpio.c b/drivers/staging/iio/trigger/iio-trig-gpio.c
index f1fb795..f2a6559 100644
--- a/drivers/staging/iio/trigger/iio-trig-gpio.c
+++ b/drivers/staging/iio/trigger/iio-trig-gpio.c
@@ -47,6 +47,10 @@ static irqreturn_t iio_gpio_trigger_poll(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+static const struct iio_trigger_ops iio_gpio_trigger_ops = {
+	.owner = THIS_MODULE,
+};
+
 static int iio_gpio_trigger_probe(struct platform_device *pdev)
 {
 	struct iio_gpio_trigger_info *trig_info;
@@ -81,7 +85,7 @@ static int iio_gpio_trigger_probe(struct platform_device *pdev)
 			}
 			trig->private_data = trig_info;
 			trig_info->irq = irq;
-			trig->owner = THIS_MODULE;
+			trig->ops = &iio_gpio_trigger_ops;
 			ret = request_irq(irq, iio_gpio_trigger_poll,
 					  irqflags, trig->name, trig);
 			if (ret) {
diff --git a/drivers/staging/iio/trigger/iio-trig-sysfs.c b/drivers/staging/iio/trigger/iio-trig-sysfs.c
index 47248cd..346b30c 100644
--- a/drivers/staging/iio/trigger/iio-trig-sysfs.c
+++ b/drivers/staging/iio/trigger/iio-trig-sysfs.c
@@ -107,6 +107,10 @@ static const struct attribute_group *iio_sysfs_trigger_attr_groups[] = {
 	NULL
 };
 
+static const struct iio_trigger_ops iio_sysfs_trigger_ops = {
+	.owner = THIS_MODULE,
+};
+
 static int iio_sysfs_trigger_probe(int id)
 {
 	struct iio_sysfs_trig *t;
@@ -135,7 +139,7 @@ static int iio_sysfs_trigger_probe(int id)
 	}
 
 	t->trig->dev.groups = iio_sysfs_trigger_attr_groups;
-	t->trig->owner = THIS_MODULE;
+	t->trig->ops = &iio_sysfs_trigger_ops;
 	t->trig->dev.parent = &iio_sysfs_trig_dev;
 
 	ret = iio_trigger_register(t->trig);
-- 
1.7.3.4
