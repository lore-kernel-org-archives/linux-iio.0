Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-115.synserver.de ([212.40.185.115]:1145 "EHLO
	smtp-out-113.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752127Ab3FKSSu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 11 Jun 2013 14:18:50 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio:trigger: Fix use_count race condition
Date: Tue, 11 Jun 2013 20:18:51 +0200
Message-Id: <1370974731-11878-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When using more than one trigger consumer it can happen that multiple threads
perform a read-modify-update cycle on 'use_count' concurrently. This can cause
updates to be lost and use_count can get stuck at non-zero value, in which case
the IIO core assumes that at least one thread is still running and will wait for
it to finish before running any trigger handlers again. This effectively renders
the trigger disabled and a reboot is necessary before it can be used again. To
fix this make use_count an atomic variable. Also set it to the number of
consumers before starting the first consumer, otherwise it might happen that
use_count drops to 0 even though not all consumers have been run yet.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-trigger.c | 44 +++++++++++++++++++++++++++-----------
 include/linux/iio/trigger.h        |  3 ++-
 2 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 4d6c7d8..a02ca65 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -126,13 +126,22 @@ static struct iio_trigger *iio_trigger_find_by_name(const char *name,
 
 void iio_trigger_poll(struct iio_trigger *trig, s64 time)
 {
+	unsigned int num_consumers;
 	int i;
-	if (!trig->use_count)
-		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++)
-			if (trig->subirqs[i].enabled) {
-				trig->use_count++;
+
+	if (!atomic_read(&trig->use_count)) {
+		num_consumers = 0;
+		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
+			if (trig->subirqs[i].enabled)
+				num_consumers++;
+		}
+		atomic_set(&trig->use_count, num_consumers);
+
+		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
+			if (trig->subirqs[i].enabled)
 				generic_handle_irq(trig->subirq_base + i);
-			}
+		}
+	}
 }
 EXPORT_SYMBOL(iio_trigger_poll);
 
@@ -145,20 +154,29 @@ EXPORT_SYMBOL(iio_trigger_generic_data_rdy_poll);
 
 void iio_trigger_poll_chained(struct iio_trigger *trig, s64 time)
 {
+	unsigned int num_consumers;
 	int i;
-	if (!trig->use_count)
-		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++)
-			if (trig->subirqs[i].enabled) {
-				trig->use_count++;
-				handle_nested_irq(trig->subirq_base + i);
-			}
+
+	if (!atomic_read(&trig->use_count)) {
+		num_consumers = 0;
+		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
+			if (trig->subirqs[i].enabled)
+				num_consumers++;
+		}
+		atomic_set(&trig->use_count, num_consumers);
+
+		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
+			if (trig->subirqs[i].enabled)
+				generic_handle_irq(trig->subirq_base + i);
+		}
+	}
 }
 EXPORT_SYMBOL(iio_trigger_poll_chained);
 
 void iio_trigger_notify_done(struct iio_trigger *trig)
 {
-	trig->use_count--;
-	if (trig->use_count == 0 && trig->ops && trig->ops->try_reenable)
+	if (atomic_dec_and_test(&trig->use_count) && trig->ops &&
+		trig->ops->try_reenable)
 		if (trig->ops->try_reenable(trig))
 			/* Missed an interrupt so launch new poll now */
 			iio_trigger_poll(trig, 0);
diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index 3869c52..369cf2c 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -8,6 +8,7 @@
  */
 #include <linux/irq.h>
 #include <linux/module.h>
+#include <linux/atomic.h>
 
 #ifndef _IIO_TRIGGER_H_
 #define _IIO_TRIGGER_H_
@@ -61,7 +62,7 @@ struct iio_trigger {
 
 	struct list_head		list;
 	struct list_head		alloc_list;
-	int use_count;
+	atomic_t			use_count;
 
 	struct irq_chip			subirq_chip;
 	int				subirq_base;
-- 
1.8.0

