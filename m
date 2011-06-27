Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:48373 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757703Ab1F0J5E (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2011 05:57:04 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 02/54] iio: trigger: Move declaration of struct iio_poll_func to avoid warnings
Date: Mon, 27 Jun 2011 11:04:12 +0100
Message-Id: <1309169104-22139-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
References: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Move declaration of struct iio_poll_func to avoid warnings

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/trigger.h |   48 ++++++++++++++++++++--------------------
 1 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/iio/trigger.h b/drivers/staging/iio/trigger.h
index f329fe1..7ddaabb 100644
--- a/drivers/staging/iio/trigger.h
+++ b/drivers/staging/iio/trigger.h
@@ -57,6 +57,30 @@ struct iio_trigger {
 	struct mutex			pool_lock;
 };
 
+/**
+ * struct iio_poll_func - poll function pair
+ *
+ * @private_data:		data specific to device (passed into poll func)
+ * @h:				the function that is actually run on trigger
+ * @thread:			threaded interrupt part
+ * @type:			the type of interrupt (basically if oneshot)
+ * @name:			name used to identify the trigger consumer.
+ * @irq:			the corresponding irq as allocated from the
+ *				trigger pool
+ * @timestamp:			some devices need a timestamp grabbed as soon
+ *				as possible after the trigger - hence handler
+ *				passes it via here.
+ **/
+struct iio_poll_func {
+	void				*private_data;
+	irqreturn_t (*h)(int irq, void *p);
+	irqreturn_t (*thread)(int irq, void *p);
+	int type;
+	char *name;
+	int irq;
+	s64 timestamp;
+};
+
 static inline struct iio_trigger *to_iio_trigger(struct device *d)
 {
 	return container_of(d, struct iio_trigger, dev);
@@ -136,30 +160,6 @@ static inline void iio_trigger_put_irq(struct iio_trigger *trig, int irq)
 	mutex_unlock(&trig->pool_lock);
 };
 
-/**
- * struct iio_poll_func - poll function pair
- *
- * @private_data:		data specific to device (passed into poll func)
- * @h:				the function that is actually run on trigger
- * @thread:			threaded interrupt part
- * @type:			the type of interrupt (basically if oneshot)
- * @name:			name used to identify the trigger consumer.
- * @irq:			the corresponding irq as allocated from the
- *				trigger pool
- * @timestamp:			some devices need a timestamp grabbed as soon
- *				as possible after the trigger - hence handler
- *				passes it via here.
- **/
-struct iio_poll_func {
-	void				*private_data;
-	irqreturn_t (*h)(int irq, void *p);
-	irqreturn_t (*thread)(int irq, void *p);
-	int type;
-	char *name;
-	int irq;
-	s64 timestamp;
-};
-
 struct iio_poll_func
 *iio_alloc_pollfunc(irqreturn_t (*h)(int irq, void *p),
 		    irqreturn_t (*thread)(int irq, void *p),
-- 
1.7.3.4

