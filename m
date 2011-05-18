Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 052/111] staging:iio:trigger remove legacy pollfunc elements.
Date: Wed, 18 May 2011 14:41:42 +0100
Message-Id: <1305726161-5606-53-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/industrialio-trigger.c |  124 +++++-----------------------
 drivers/staging/iio/trigger.h              |   19 ----
 2 files changed, 20 insertions(+), 123 deletions(-)

diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index d045b6c..dd762f0 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -164,21 +164,6 @@ static struct iio_trigger *iio_trigger_find_by_name(const char *name,
 void iio_trigger_poll(struct iio_trigger *trig, s64 time)
 {
 	int i;
-	struct iio_poll_func *pf_cursor;
-
-	list_for_each_entry(pf_cursor, &trig->pollfunc_list, list) {
-		if (pf_cursor->poll_func_immediate) {
-			pf_cursor->poll_func_immediate(pf_cursor->private_data);
-			trig->use_count++;
-		}
-	}
-	list_for_each_entry(pf_cursor, &trig->pollfunc_list, list) {
-		if (pf_cursor->poll_func_main) {
-			pf_cursor->poll_func_main(pf_cursor->private_data,
-						  time);
-			trig->use_count++;
-		}
-	}
 	if (!trig->use_count) {
 		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++)
 			if (trig->subirqs[i].enabled) {
@@ -232,32 +217,15 @@ int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 				 struct iio_poll_func *pf)
 {
 	int ret = 0;
-	unsigned long flags;
-
-	if (pf->thread) {
-		bool notinuse
-			= bitmap_empty(trig->pool,
-				       CONFIG_IIO_CONSUMERS_PER_TRIGGER);
-
-		pf->irq = iio_trigger_get_irq(trig);
-		ret = request_threaded_irq(pf->irq, pf->h, pf->thread,
-					   pf->type, pf->name,
-					   pf);
-		if (trig->set_trigger_state && notinuse) {
-			ret = trig->set_trigger_state(trig, true);
-	} else {
-		spin_lock_irqsave(&trig->pollfunc_list_lock, flags);
-		list_add_tail(&pf->list, &trig->pollfunc_list);
-		spin_unlock_irqrestore(&trig->pollfunc_list_lock, flags);
-
-		if (trig->set_trigger_state)
-			ret = trig->set_trigger_state(trig, true);
-		}
-		if (ret) {
-			printk(KERN_ERR "set trigger state failed\n");
-			list_del(&pf->list);
-		}
-	}
+	bool notinuse
+		= bitmap_empty(trig->pool, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
+
+	pf->irq = iio_trigger_get_irq(trig);
+	ret = request_threaded_irq(pf->irq, pf->h, pf->thread,
+				   pf->type, pf->name,
+				   pf);
+	if (trig->set_trigger_state && notinuse)
+		ret = trig->set_trigger_state(trig, true);
 
 	return ret;
 }
@@ -266,53 +234,18 @@ EXPORT_SYMBOL(iio_trigger_attach_poll_func);
 int iio_trigger_dettach_poll_func(struct iio_trigger *trig,
 				  struct iio_poll_func *pf)
 {
-	struct iio_poll_func *pf_cursor;
-	unsigned long flags;
-	int ret = -EINVAL;
-
-	if (pf->thread) {
-		bool no_other_users
-			= (bitmap_weight(trig->pool,
-					 CONFIG_IIO_CONSUMERS_PER_TRIGGER)
-			   == 1);
-		if (trig->set_trigger_state && no_other_users) {
-			ret = trig->set_trigger_state(trig, false);
-			if (ret)
-				goto error_ret;
-		} else
-			ret = 0;
-		iio_trigger_put_irq(trig, pf->irq);
-		free_irq(pf->irq, pf);
-	} else {
-		spin_lock_irqsave(&trig->pollfunc_list_lock, flags);
-		list_for_each_entry(pf_cursor, &trig->pollfunc_list, list)
-			if (pf_cursor == pf) {
-				ret = 0;
-				break;
-			}
-		if (!ret) {
-			if (list_is_singular(&trig->pollfunc_list)
-			    && trig->set_trigger_state) {
-				spin_unlock_irqrestore(&trig
-						       ->pollfunc_list_lock,
-						       flags);
-				/* May sleep hence cannot hold the spin lock */
-				ret = trig->set_trigger_state(trig, false);
-				if (ret)
-					goto error_ret;
-				spin_lock_irqsave(&trig->pollfunc_list_lock,
-						  flags);
-			}
-			/*
-			 * Now we can delete safe in the knowledge that, if
-			 * this is the last pollfunc then we have disabled
-			 * the trigger anyway and so nothing should be able
-			 * to call the pollfunc.
-			 */
-			list_del(&pf_cursor->list);
-		}
-		spin_unlock_irqrestore(&trig->pollfunc_list_lock, flags);
+	int ret = 0;
+	bool no_other_users
+		= (bitmap_weight(trig->pool,
+				 CONFIG_IIO_CONSUMERS_PER_TRIGGER)
+		   == 1);
+	if (trig->set_trigger_state && no_other_users) {
+		ret = trig->set_trigger_state(trig, false);
+		if (ret)
+			goto error_ret;
 	}
+	iio_trigger_put_irq(trig, pf->irq);
+	free_irq(pf->irq, pf);
 
 error_ret:
 	return ret;
@@ -445,9 +378,6 @@ struct iio_trigger *iio_allocate_trigger_named(const char *name)
 		trig->dev.bus = &iio_bus_type;
 		device_initialize(&trig->dev);
 		dev_set_drvdata(&trig->dev, (void *)trig);
-		spin_lock_init(&trig->pollfunc_list_lock);
-		INIT_LIST_HEAD(&trig->list);
-		INIT_LIST_HEAD(&trig->pollfunc_list);
 
 		if (name) {
 			mutex_init(&trig->pool_lock);
@@ -509,20 +439,6 @@ int iio_device_unregister_trigger_consumer(struct iio_dev *dev_info)
 }
 EXPORT_SYMBOL(iio_device_unregister_trigger_consumer);
 
-int iio_alloc_pollfunc(struct iio_dev *indio_dev,
-		       void (*immediate)(struct iio_dev *indio_dev),
-		       void (*main)(struct iio_dev *private_data, s64 time))
-{
-	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
-	if (indio_dev->pollfunc == NULL)
-		return -ENOMEM;
-	indio_dev->pollfunc->poll_func_immediate = immediate;
-	indio_dev->pollfunc->poll_func_main = main;
-	indio_dev->pollfunc->private_data = indio_dev;
-	return 0;
-}
-EXPORT_SYMBOL(iio_alloc_pollfunc);
-
 int iio_triggered_ring_postenable(struct iio_dev *indio_dev)
 {
 	return indio_dev->trig
diff --git a/drivers/staging/iio/trigger.h b/drivers/staging/iio/trigger.h
index 8e25c00..e831a89 100644
--- a/drivers/staging/iio/trigger.h
+++ b/drivers/staging/iio/trigger.h
@@ -24,8 +24,6 @@ struct iio_subirq {
  * @private_data:	[DRIVER] device specific data
  * @list:		[INTERN] used in maintenance of global trigger list
  * @alloc_list:		[DRIVER] used for driver specific trigger list
- * @pollfunc_list_lock:	[INTERN] protection of the polling function list
- * @pollfunc_list:	[INTERN] list of functions to run on trigger.
  * @control_attrs:	[DRIVER] sysfs attributes relevant to trigger type
  * @owner:		[DRIVER] used to monitor usage count of the trigger.
  * @use_count:		use count for the trigger
@@ -41,8 +39,6 @@ struct iio_trigger {
 	void				*private_data;
 	struct list_head		list;
 	struct list_head		alloc_list;
-	spinlock_t			pollfunc_list_lock;
-	struct list_head		pollfunc_list;
 	const struct attribute_group	*control_attrs;
 	struct module			*owner;
 	int use_count;
@@ -153,14 +149,7 @@ static inline void iio_trigger_put_irq(struct iio_trigger *trig, int irq)
 /**
  * struct iio_poll_func - poll function pair
  *
- * @list:			associate this with a triggers pollfunc_list
  * @private_data:		data specific to device (passed into poll func)
- * @poll_func_immediate:	function in here is run first. They should be
- *				extremely lightweight.  Typically used for latch
- *				control on sensor supporting it.
- * @poll_func_main:		function in here is run after all immediates.
- *				Reading from sensor etc typically involves
- *				scheduling from here.
  * @h:				the function that is actually run on trigger
  * @thread:			threaded interrupt part
  * @type:			the type of interrupt (basically if oneshot)
@@ -171,11 +160,7 @@ static inline void iio_trigger_put_irq(struct iio_trigger *trig, int irq)
  *				passes it via here.
  **/
 struct iio_poll_func {
-	struct				list_head list;
 	void				*private_data;
-	void (*poll_func_immediate)(struct iio_dev *indio_dev);
-	void (*poll_func_main)(struct iio_dev *private_data, s64 time);
-
 	irqreturn_t (*h)(int irq, void *p);
 	irqreturn_t (*thread)(int irq, void *p);
 	int type;
@@ -184,10 +169,6 @@ struct iio_poll_func {
 	s64 timestamp;
 };
 
-int iio_alloc_pollfunc(struct iio_dev *indio_dev,
-		       void (*immediate)(struct iio_dev *indio_dev),
-		       void (*main)(struct iio_dev *private_data, s64 time));
-
 irqreturn_t iio_pollfunc_store_time(int irq, void *p);
 
 /*
-- 
1.7.3.4
