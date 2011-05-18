Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 028/111] staging:iio: Add infrastructure for irq_chip based triggers
Date: Wed, 18 May 2011 14:41:18 +0100
Message-Id: <1305726161-5606-29-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

V3: Get rid of separate interrupt pool. This is well handled
    by irq_get_descs and irq_free_descs.  Two functions I simply
    wasn't aware of previously.  Thus the allocation for a given
    trigger is now handled by core code rather than us reinventing
    the wheel.

V2: Stop silly name duplication.
    Move pool handling to industrialio-trigger as that is the only user.
    Changed over to using irq_modify_status rather than the arm
    specific set_irq_flags as per Thomas Gleixner's suggestion.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Kconfig                |    7 +
 drivers/staging/iio/industrialio-trigger.c |  175 +++++++++++++++++++++++-----
 drivers/staging/iio/trigger.h              |   57 ++++++++-
 3 files changed, 203 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index 6775bf9..e6235d1 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -48,6 +48,13 @@ config IIO_TRIGGER
 	  ring buffers.  The triggers are effectively a 'capture
 	  data now' interrupt.
 
+config IIO_CONSUMERS_PER_TRIGGER
+       int "Maximum number of consumers per trigger"
+       depends on IIO_TRIGGER
+       default "2"
+       help
+	This value controls the maximum number of consumers that a
+	given trigger may handle. Default is 2.
 
 source "drivers/staging/iio/accel/Kconfig"
 source "drivers/staging/iio/adc/Kconfig"
diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index 083847c..5496ee2 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -163,6 +163,7 @@ static struct iio_trigger *iio_trigger_find_by_name(const char *name,
 
 void iio_trigger_poll(struct iio_trigger *trig, s64 time)
 {
+	int i;
 	struct iio_poll_func *pf_cursor;
 
 	list_for_each_entry(pf_cursor, &trig->pollfunc_list, list) {
@@ -178,6 +179,13 @@ void iio_trigger_poll(struct iio_trigger *trig, s64 time)
 			trig->use_count++;
 		}
 	}
+	if (!trig->use_count) {
+		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++)
+			if (trig->subirqs[i].enabled) {
+				trig->use_count++;
+				generic_handle_irq(trig->subirq_base + i);
+			}
+	}
 }
 EXPORT_SYMBOL(iio_trigger_poll);
 
@@ -219,16 +227,31 @@ int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 	int ret = 0;
 	unsigned long flags;
 
-	spin_lock_irqsave(&trig->pollfunc_list_lock, flags);
-	list_add_tail(&pf->list, &trig->pollfunc_list);
-	spin_unlock_irqrestore(&trig->pollfunc_list_lock, flags);
-
-	if (trig->set_trigger_state)
-		ret = trig->set_trigger_state(trig, true);
-	if (ret) {
-		printk(KERN_ERR "set trigger state failed\n");
-		list_del(&pf->list);
+	if (pf->thread) {
+		bool notinuse
+			= bitmap_empty(trig->pool,
+				       CONFIG_IIO_CONSUMERS_PER_TRIGGER);
+
+		pf->irq = iio_trigger_get_irq(trig);
+		ret = request_threaded_irq(pf->irq, pf->h, pf->thread,
+					   pf->type, pf->name,
+					   pf);
+		if (trig->set_trigger_state && notinuse) {
+			ret = trig->set_trigger_state(trig, true);
+	} else {
+		spin_lock_irqsave(&trig->pollfunc_list_lock, flags);
+		list_add_tail(&pf->list, &trig->pollfunc_list);
+		spin_unlock_irqrestore(&trig->pollfunc_list_lock, flags);
+
+		if (trig->set_trigger_state)
+			ret = trig->set_trigger_state(trig, true);
+		}
+		if (ret) {
+			printk(KERN_ERR "set trigger state failed\n");
+			list_del(&pf->list);
+		}
 	}
+
 	return ret;
 }
 EXPORT_SYMBOL(iio_trigger_attach_poll_func);
@@ -240,37 +263,63 @@ int iio_trigger_dettach_poll_func(struct iio_trigger *trig,
 	unsigned long flags;
 	int ret = -EINVAL;
 
-	spin_lock_irqsave(&trig->pollfunc_list_lock, flags);
-	list_for_each_entry(pf_cursor, &trig->pollfunc_list, list)
-		if (pf_cursor == pf) {
-			ret = 0;
-			break;
-		}
-	if (!ret) {
-		if (list_is_singular(&trig->pollfunc_list)
-		    && trig->set_trigger_state) {
-			spin_unlock_irqrestore(&trig->pollfunc_list_lock,
-					       flags);
-			/* May sleep hence cannot hold the spin lock */
+	if (pf->thread) {
+		bool no_other_users
+			= (bitmap_weight(trig->pool,
+					 CONFIG_IIO_CONSUMERS_PER_TRIGGER)
+			   == 1);
+		if (trig->set_trigger_state && no_other_users) {
 			ret = trig->set_trigger_state(trig, false);
 			if (ret)
 				goto error_ret;
-			spin_lock_irqsave(&trig->pollfunc_list_lock, flags);
+		} else
+			ret = 0;
+		iio_trigger_put_irq(trig, pf->irq);
+		free_irq(pf->irq, pf);
+	} else {
+		spin_lock_irqsave(&trig->pollfunc_list_lock, flags);
+		list_for_each_entry(pf_cursor, &trig->pollfunc_list, list)
+			if (pf_cursor == pf) {
+				ret = 0;
+				break;
+			}
+		if (!ret) {
+			if (list_is_singular(&trig->pollfunc_list)
+			    && trig->set_trigger_state) {
+				spin_unlock_irqrestore(&trig
+						       ->pollfunc_list_lock,
+						       flags);
+				/* May sleep hence cannot hold the spin lock */
+				ret = trig->set_trigger_state(trig, false);
+				if (ret)
+					goto error_ret;
+				spin_lock_irqsave(&trig->pollfunc_list_lock,
+						  flags);
+			}
+			/*
+			 * Now we can delete safe in the knowledge that, if
+			 * this is the last pollfunc then we have disabled
+			 * the trigger anyway and so nothing should be able
+			 * to call the pollfunc.
+			 */
+			list_del(&pf_cursor->list);
 		}
-		/*
-		 * Now we can delete safe in the knowledge that, if this is
-		 * the last pollfunc then we have disabled the trigger anyway
-		 * and so nothing should be able to call the pollfunc.
-		 */
-		list_del(&pf_cursor->list);
+		spin_unlock_irqrestore(&trig->pollfunc_list_lock, flags);
 	}
-	spin_unlock_irqrestore(&trig->pollfunc_list_lock, flags);
 
 error_ret:
 	return ret;
 }
 EXPORT_SYMBOL(iio_trigger_dettach_poll_func);
 
+irqreturn_t iio_pollfunc_store_time(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	pf->timestamp = iio_get_time_ns();
+	return IRQ_WAKE_THREAD;
+}
+EXPORT_SYMBOL(iio_pollfunc_store_time);
+
 /**
  * iio_trigger_read_currrent() - trigger consumer sysfs query which trigger
  *
@@ -337,6 +386,22 @@ static const struct attribute_group iio_trigger_consumer_attr_group = {
 static void iio_trig_release(struct device *device)
 {
 	struct iio_trigger *trig = to_iio_trigger(device);
+	int i;
+
+	if (trig->subirq_base) {
+		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
+			irq_modify_status(trig->subirq_base + i,
+					  IRQ_NOAUTOEN,
+					  IRQ_NOREQUEST | IRQ_NOPROBE);
+			irq_set_chip(trig->subirq_base + i,
+				     NULL);
+			irq_set_handler(trig->subirq_base + i,
+					NULL);
+		}
+
+		irq_free_descs(trig->subirq_base,
+			       CONFIG_IIO_CONSUMERS_PER_TRIGGER);
+	}
 	kfree(trig);
 	iio_put();
 }
@@ -345,11 +410,30 @@ static struct device_type iio_trig_type = {
 	.release = iio_trig_release,
 };
 
-struct iio_trigger *iio_allocate_trigger(void)
+static void iio_trig_subirqmask(struct irq_data *d)
+{
+	struct irq_chip *chip = irq_data_get_irq_chip(d);
+	struct iio_trigger *trig
+		= container_of(chip,
+			       struct iio_trigger, subirq_chip);
+	trig->subirqs[d->irq - trig->subirq_base].enabled = false;
+}
+
+static void iio_trig_subirqunmask(struct irq_data *d)
+{
+	struct irq_chip *chip = irq_data_get_irq_chip(d);
+	struct iio_trigger *trig
+		= container_of(chip,
+			       struct iio_trigger, subirq_chip);
+	trig->subirqs[d->irq - trig->subirq_base].enabled = true;
+}
+
+struct iio_trigger *iio_allocate_trigger_named(const char *name)
 {
 	struct iio_trigger *trig;
 	trig = kzalloc(sizeof *trig, GFP_KERNEL);
 	if (trig) {
+		int i;
 		trig->dev.type = &iio_trig_type;
 		trig->dev.bus = &iio_bus_type;
 		device_initialize(&trig->dev);
@@ -357,10 +441,41 @@ struct iio_trigger *iio_allocate_trigger(void)
 		spin_lock_init(&trig->pollfunc_list_lock);
 		INIT_LIST_HEAD(&trig->list);
 		INIT_LIST_HEAD(&trig->pollfunc_list);
+
+		if (name) {
+			mutex_init(&trig->pool_lock);
+			trig->subirq_base
+				= irq_alloc_descs(-1, 0,
+					CONFIG_IIO_CONSUMERS_PER_TRIGGER,
+					0);
+			if (trig->subirq_base < 0) {
+				kfree(trig);
+				return NULL;
+			}
+			trig->name = name;
+			trig->subirq_chip.name = name;
+			trig->subirq_chip.irq_mask = &iio_trig_subirqmask;
+			trig->subirq_chip.irq_unmask = &iio_trig_subirqunmask;
+			for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
+				irq_set_chip(trig->subirq_base + i,
+					     &trig->subirq_chip);
+				irq_set_handler(trig->subirq_base + i,
+						&handle_simple_irq);
+				irq_modify_status(trig->subirq_base + i,
+						  IRQ_NOREQUEST | IRQ_NOAUTOEN,
+						  IRQ_NOPROBE);
+			}
+		}
 		iio_get();
 	}
 	return trig;
 }
+EXPORT_SYMBOL(iio_allocate_trigger_named);
+
+struct iio_trigger *iio_allocate_trigger(void)
+{
+	return iio_allocate_trigger_named(NULL);
+}
 EXPORT_SYMBOL(iio_allocate_trigger);
 
 void iio_free_trigger(struct iio_trigger *trig)
diff --git a/drivers/staging/iio/trigger.h b/drivers/staging/iio/trigger.h
index c6ab32f..0c44c5e 100644
--- a/drivers/staging/iio/trigger.h
+++ b/drivers/staging/iio/trigger.h
@@ -6,9 +6,15 @@
  * under the terms of the GNU General Public License version 2 as published by
  * the Free Software Foundation.
  */
+#include <linux/irq.h>
+
 #ifndef _IIO_TRIGGER_H_
 #define _IIO_TRIGGER_H_
 
+struct iio_subirq {
+	bool enabled;
+};
+
 /**
  * struct iio_trigger - industrial I/O trigger device
  *
@@ -43,6 +49,13 @@ struct iio_trigger {
 
 	int (*set_trigger_state)(struct iio_trigger *trig, bool state);
 	int (*try_reenable)(struct iio_trigger *trig);
+
+	struct irq_chip			subirq_chip;
+	int				subirq_base;
+
+	struct iio_subirq subirqs[CONFIG_IIO_CONSUMERS_PER_TRIGGER];
+	unsigned long pool[BITS_TO_LONGS(CONFIG_IIO_CONSUMERS_PER_TRIGGER)];
+	struct mutex			pool_lock;
 };
 
 static inline struct iio_trigger *to_iio_trigger(struct device *d)
@@ -114,6 +127,27 @@ int iio_trigger_dettach_poll_func(struct iio_trigger *trig,
 void iio_trigger_poll(struct iio_trigger *trig, s64 time);
 void iio_trigger_notify_done(struct iio_trigger *trig);
 
+static inline int iio_trigger_get_irq(struct iio_trigger *trig)
+{
+	int ret;
+	mutex_lock(&trig->pool_lock);
+	ret = bitmap_find_free_region(trig->pool,
+				      CONFIG_IIO_CONSUMERS_PER_TRIGGER,
+				      ilog2(1));
+	mutex_unlock(&trig->pool_lock);
+	if (ret >= 0)
+		ret += trig->subirq_base;
+
+	return ret;
+};
+
+static inline void iio_trigger_put_irq(struct iio_trigger *trig, int irq)
+{
+	mutex_lock(&trig->pool_lock);
+	clear_bit(irq - trig->subirq_base, trig->pool);
+	mutex_unlock(&trig->pool_lock);
+};
+
 /**
  * struct iio_poll_func - poll function pair
  *
@@ -125,11 +159,14 @@ void iio_trigger_notify_done(struct iio_trigger *trig);
  * @poll_func_main:		function in here is run after all immediates.
  *				Reading from sensor etc typically involves
  *				scheduling from here.
- *
- * The two stage approach used here is only important when multiple sensors are
- * being triggered by a single trigger. This really comes into its own with
- * simultaneous sampling devices where a simple latch command can be used to
- * make the device store the values on all inputs.
+ * @h:				the function that is actually run on trigger
+ * @thread:			threaded interrupt part
+ * @type:			the type of interrupt (basically if oneshot)
+ * @irq:			the corresponding irq as allocated from the
+ *				trigger pool
+ * @timestamp:			some devices need a timestamp grabbed as soon
+ *				as possible after the trigger - hence handler
+ *				passes it via here.
  **/
 struct iio_poll_func {
 	struct				list_head list;
@@ -137,12 +174,20 @@ struct iio_poll_func {
 	void (*poll_func_immediate)(struct iio_dev *indio_dev);
 	void (*poll_func_main)(struct iio_dev *private_data, s64 time);
 
+	irqreturn_t (*h)(int irq, void *p);
+	irqreturn_t (*thread)(int irq, void *p);
+	int type;
+	char *name;
+	int irq;
+	s64 timestamp;
 };
 
 int iio_alloc_pollfunc(struct iio_dev *indio_dev,
 		       void (*immediate)(struct iio_dev *indio_dev),
 		       void (*main)(struct iio_dev *private_data, s64 time));
 
+irqreturn_t iio_pollfunc_store_time(int irq, void *p);
+
 /*
  * Two functions for common case where all that happens is a pollfunc
  * is attached and detached from a trigger
@@ -151,7 +196,7 @@ int iio_triggered_ring_postenable(struct iio_dev *indio_dev);
 int iio_triggered_ring_predisable(struct iio_dev *indio_dev);
 
 struct iio_trigger *iio_allocate_trigger(void);
-
+struct iio_trigger *iio_allocate_trigger_named(const char *name);
 void iio_free_trigger(struct iio_trigger *trig);
 
 #endif /* _IIO_TRIGGER_H_ */
-- 
1.7.3.4
