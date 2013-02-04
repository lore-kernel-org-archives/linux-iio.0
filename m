Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:53512 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753267Ab3BDLgq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 4 Feb 2013 06:36:46 -0500
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio: tweak language in industrialio-trigger comments
Date: Mon,  4 Feb 2013 12:36:41 +0100
Message-Id: <1359977801-19202-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Peter Meerwald <p.meerwald@bct-electronic.com>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/industrialio-trigger.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 4fe0ead..4d6c7d8 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -160,7 +160,7 @@ void iio_trigger_notify_done(struct iio_trigger *trig)
 	trig->use_count--;
 	if (trig->use_count == 0 && trig->ops && trig->ops->try_reenable)
 		if (trig->ops->try_reenable(trig))
-			/* Missed and interrupt so launch new poll now */
+			/* Missed an interrupt so launch new poll now */
 			iio_trigger_poll(trig, 0);
 }
 EXPORT_SYMBOL(iio_trigger_notify_done);
@@ -193,7 +193,7 @@ static void iio_trigger_put_irq(struct iio_trigger *trig, int irq)
  * This is not currently handled.  Alternative of not enabling trigger unless
  * the relevant function is in there may be the best option.
  */
-/* Worth protecting against double additions?*/
+/* Worth protecting against double additions? */
 static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 					struct iio_poll_func *pf)
 {
@@ -201,7 +201,7 @@ static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 	bool notinuse
 		= bitmap_empty(trig->pool, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
 
-	/* Prevent the module being removed whilst attached to a trigger */
+	/* Prevent the module from being removed whilst attached to a trigger */
 	__module_get(pf->indio_dev->info->driver_module);
 	pf->irq = iio_trigger_get_irq(trig);
 	ret = request_threaded_irq(pf->irq, pf->h, pf->thread,
@@ -288,7 +288,7 @@ void iio_dealloc_pollfunc(struct iio_poll_func *pf)
 EXPORT_SYMBOL_GPL(iio_dealloc_pollfunc);
 
 /**
- * iio_trigger_read_current() - trigger consumer sysfs query which trigger
+ * iio_trigger_read_current() - trigger consumer sysfs query current trigger
  *
  * For trigger consumers the current_trigger interface allows the trigger
  * used by the device to be queried.
@@ -305,7 +305,7 @@ static ssize_t iio_trigger_read_current(struct device *dev,
 }
 
 /**
- * iio_trigger_write_current() trigger consumer sysfs set current trigger
+ * iio_trigger_write_current() - trigger consumer sysfs set current trigger
  *
  * For trigger consumers the current_trigger interface allows the trigger
  * used for this device to be specified at run time based on the triggers
@@ -476,7 +476,7 @@ void iio_device_register_trigger_consumer(struct iio_dev *indio_dev)
 
 void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev)
 {
-	/* Clean up and associated but not attached triggers references */
+	/* Clean up an associated but not attached trigger reference */
 	if (indio_dev->trig)
 		iio_trigger_put(indio_dev->trig);
 }
-- 
1.7.9.5

