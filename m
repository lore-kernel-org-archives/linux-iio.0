Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:36328 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951Ab1GYNKz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jul 2011 09:10:55 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 7/8] staging:iio:trigger push functions that don't need to be generaly available down into the core.
Date: Mon, 25 Jul 2011 14:10:57 +0100
Message-Id: <1311599458-15152-8-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1311599458-15152-1-git-send-email-jic23@cam.ac.uk>
References: <1311599458-15152-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/industrialio-trigger.c |   30 +++++++++++++++++----
 drivers/staging/iio/trigger.h              |   39 ----------------------------
 2 files changed, 24 insertions(+), 45 deletions(-)

diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index 72ea106..f1ece86 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -215,6 +215,26 @@ void iio_trigger_notify_done(struct iio_trigger *trig)
 EXPORT_SYMBOL(iio_trigger_notify_done);
 
 /* Trigger Consumer related functions */
+static int iio_trigger_get_irq(struct iio_trigger *trig)
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
+}
+
+static void iio_trigger_put_irq(struct iio_trigger *trig, int irq)
+{
+	mutex_lock(&trig->pool_lock);
+	clear_bit(irq - trig->subirq_base, trig->pool);
+	mutex_unlock(&trig->pool_lock);
+}
 
 /* Complexity in here.  With certain triggers (datardy) an acknowledgement
  * may be needed if the pollfuncs do not include the data read for the
@@ -223,8 +243,8 @@ EXPORT_SYMBOL(iio_trigger_notify_done);
  * the relevant function is in there may be the best option.
  */
 /* Worth protecting against double additions?*/
-int iio_trigger_attach_poll_func(struct iio_trigger *trig,
-				 struct iio_poll_func *pf)
+static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
+					struct iio_poll_func *pf)
 {
 	int ret = 0;
 	bool notinuse
@@ -241,10 +261,9 @@ int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 
 	return ret;
 }
-EXPORT_SYMBOL(iio_trigger_attach_poll_func);
 
-int iio_trigger_dettach_poll_func(struct iio_trigger *trig,
-				  struct iio_poll_func *pf)
+static int iio_trigger_dettach_poll_func(struct iio_trigger *trig,
+					 struct iio_poll_func *pf)
 {
 	int ret = 0;
 	bool no_other_users
@@ -263,7 +282,6 @@ int iio_trigger_dettach_poll_func(struct iio_trigger *trig,
 error_ret:
 	return ret;
 }
-EXPORT_SYMBOL(iio_trigger_dettach_poll_func);
 
 irqreturn_t iio_pollfunc_store_time(int irq, void *p)
 {
diff --git a/drivers/staging/iio/trigger.h b/drivers/staging/iio/trigger.h
index 56f8baf..722fc33 100644
--- a/drivers/staging/iio/trigger.h
+++ b/drivers/staging/iio/trigger.h
@@ -104,23 +104,6 @@ int iio_trigger_register(struct iio_trigger *trig_info);
 void iio_trigger_unregister(struct iio_trigger *trig_info);
 
 /**
- * iio_trigger_attach_poll_func() - add a function pair to be run on trigger
- * @trig:	trigger to which the function pair are being added
- * @pf:		poll function pair
- **/
-int iio_trigger_attach_poll_func(struct iio_trigger *trig,
-				 struct iio_poll_func *pf);
-
-/**
- * iio_trigger_dettach_poll_func() -	remove function pair from those to be
- *					run on trigger
- * @trig:	trigger from which the function is being removed
- * @pf:		poll function pair
- **/
-int iio_trigger_dettach_poll_func(struct iio_trigger *trig,
-				  struct iio_poll_func *pf);
-
-/**
  * iio_trigger_poll() - called on a trigger occurring
  * @trig: trigger which occurred
  *
@@ -129,30 +112,8 @@ int iio_trigger_dettach_poll_func(struct iio_trigger *trig,
 void iio_trigger_poll(struct iio_trigger *trig, s64 time);
 void iio_trigger_poll_chained(struct iio_trigger *trig, s64 time);
 
-
 irqreturn_t iio_trigger_generic_data_rdy_poll(int irq, void *private);
 
-static inline int iio_trigger_get_irq(struct iio_trigger *trig)
-{
-	int ret;
-	mutex_lock(&trig->pool_lock);
-	ret = bitmap_find_free_region(trig->pool,
-				      CONFIG_IIO_CONSUMERS_PER_TRIGGER,
-				      ilog2(1));
-	mutex_unlock(&trig->pool_lock);
-	if (ret >= 0)
-		ret += trig->subirq_base;
-
-	return ret;
-};
-
-static inline void iio_trigger_put_irq(struct iio_trigger *trig, int irq)
-{
-	mutex_lock(&trig->pool_lock);
-	clear_bit(irq - trig->subirq_base, trig->pool);
-	mutex_unlock(&trig->pool_lock);
-};
-
 struct iio_trigger *iio_allocate_trigger(const char *fmt, ...)
 	__attribute__((format(printf, 1, 2)));
 void iio_free_trigger(struct iio_trigger *trig);
-- 
1.7.3.4

