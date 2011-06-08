Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <greg@kroah.com>
CC: <linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, <jic23@cam.ac.uk>, Michael Hennerich
	<michael.hennerich@analog.com>
Subject: [PATCH 1/4] iio: trigger: Move declaration of struct iio_poll_func to avoid warnings
Date: Wed, 8 Jun 2011 16:12:41 +0200
Message-ID: <1307542364-7089-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

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
1.7.0.4
