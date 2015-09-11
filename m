Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:34818 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbbIKN7e (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 Sep 2015 09:59:34 -0400
Date: Fri, 11 Sep 2015 16:59:30 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: jic23@kernel.org
Cc: daniel.baluta@intel.com, octavian.purdila@intel.com,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Staging: iio: Move evgen interrupt generation to irq_work
Message-ID: <57d42c1c73d5d9103fc95ceee5e4f30ec9538e5b.1441895141.git.cristina.opriceana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Enhance interrupt generation in the dummy driver and expand its usage
by introducing the irq_work infrastructure to trigger an interrupt.

This way, the irq_work_queue() wrapper permits calling both of the top
half and threaded part from a hard irq context, unlike handle_nested_irq(),
which only calls the threaded part.

As an outcome, the driver succeeds in simulating real hardware
interrupts, while keeping the normal interrupt flow.

Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
---
 Changes since v1:
  - keep irq_chip and the normal interrupt flow
  - run top half and threaded part from hardirq context
  - add demo function that registers current timestamp and uses it in the
  threaded interrupt handler

 drivers/staging/iio/iio_dummy_evgen.c         | 26 +++++++++++++++++++++++++-
 drivers/staging/iio/iio_simple_dummy.h        |  1 +
 drivers/staging/iio/iio_simple_dummy_events.c | 19 ++++++++++++++-----
 3 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/iio_dummy_evgen.c b/drivers/staging/iio/iio_dummy_evgen.c
index 6d38854..2bb4350 100644
--- a/drivers/staging/iio/iio_dummy_evgen.c
+++ b/drivers/staging/iio/iio_dummy_evgen.c
@@ -24,9 +24,21 @@
 #include "iio_dummy_evgen.h"
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/irq_work.h>
 
 /* Fiddly bit of faking and irq without hardware */
 #define IIO_EVENTGEN_NO 10
+
+/**
+ * struct iio_dummy_handle_irq - helper struct to simulate interrupt generation
+ * @work: irq_work used to run handlers from hardirq context
+ * @irq: fake irq line number to trigger an interrupt
+ */
+struct iio_dummy_handle_irq {
+	struct irq_work work;
+	int irq;
+};
+
 /**
  * struct iio_dummy_evgen - evgen state
  * @chip: irq chip we are faking
@@ -35,6 +47,7 @@
  * @inuse: mask of which irqs are connected
  * @regs: irq regs we are faking
  * @lock: protect the evgen state
+ * @handler: helper for a 'hardware-like' interrupt simulation
  */
 struct iio_dummy_eventgen {
 	struct irq_chip chip;
@@ -43,6 +56,7 @@ struct iio_dummy_eventgen {
 	bool inuse[IIO_EVENTGEN_NO];
 	struct iio_dummy_regs regs[IIO_EVENTGEN_NO];
 	struct mutex lock;
+	struct iio_dummy_handle_irq handler;
 };
 
 /* We can only ever have one instance of this 'device' */
@@ -67,6 +81,14 @@ static void iio_dummy_event_irqunmask(struct irq_data *d)
 	evgen->enabled[d->irq - evgen->base] = true;
 }
 
+void iio_dummy_work_handler(struct irq_work *work)
+{
+	struct iio_dummy_handle_irq *irq_handler;
+
+	irq_handler = container_of(work, struct iio_dummy_handle_irq, work);
+	handle_simple_irq(irq_handler->irq, irq_to_desc(irq_handler->irq));
+}
+
 static int iio_dummy_evgen_create(void)
 {
 	int ret, i;
@@ -91,6 +113,7 @@ static int iio_dummy_evgen_create(void)
 				  IRQ_NOREQUEST | IRQ_NOAUTOEN,
 				  IRQ_NOPROBE);
 	}
+	init_irq_work(&iio_evgen->handler.work, iio_dummy_work_handler);
 	mutex_init(&iio_evgen->lock);
 	return 0;
 }
@@ -169,8 +192,9 @@ static ssize_t iio_evgen_poke(struct device *dev,
 	iio_evgen->regs[this_attr->address].reg_id   = this_attr->address;
 	iio_evgen->regs[this_attr->address].reg_data = event;
 
+	iio_evgen->handler.irq = iio_evgen->base + this_attr->address;
 	if (iio_evgen->enabled[this_attr->address])
-		handle_nested_irq(iio_evgen->base + this_attr->address);
+		irq_work_queue(&iio_evgen->handler.work);
 
 	return len;
 }
diff --git a/drivers/staging/iio/iio_simple_dummy.h b/drivers/staging/iio/iio_simple_dummy.h
index 8d00224..5c2f4d0 100644
--- a/drivers/staging/iio/iio_simple_dummy.h
+++ b/drivers/staging/iio/iio_simple_dummy.h
@@ -46,6 +46,7 @@ struct iio_dummy_state {
 	int event_irq;
 	int event_val;
 	bool event_en;
+	s64 event_timestamp;
 #endif /* CONFIG_IIO_SIMPLE_DUMMY_EVENTS */
 };
 
diff --git a/drivers/staging/iio/iio_simple_dummy_events.c b/drivers/staging/iio/iio_simple_dummy_events.c
index 73108ba..bfbf1c5 100644
--- a/drivers/staging/iio/iio_simple_dummy_events.c
+++ b/drivers/staging/iio/iio_simple_dummy_events.c
@@ -153,6 +153,15 @@ int iio_simple_dummy_write_event_value(struct iio_dev *indio_dev,
 	return 0;
 }
 
+static irqreturn_t iio_simple_dummy_get_timestamp(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct iio_dummy_state *st = iio_priv(indio_dev);
+
+	st->event_timestamp = iio_get_time_ns();
+	return IRQ_HANDLED;
+}
+
 /**
  * iio_simple_dummy_event_handler() - identify and pass on event
  * @irq: irq of event line
@@ -177,7 +186,7 @@ static irqreturn_t iio_simple_dummy_event_handler(int irq, void *private)
 			       IIO_EVENT_CODE(IIO_VOLTAGE, 0, 0,
 					      IIO_EV_DIR_RISING,
 					      IIO_EV_TYPE_THRESH, 0, 0, 0),
-			       iio_get_time_ns());
+			       st->event_timestamp);
 		break;
 	case 1:
 		if (st->activity_running > st->event_val)
@@ -187,7 +196,7 @@ static irqreturn_t iio_simple_dummy_event_handler(int irq, void *private)
 						      IIO_EV_DIR_RISING,
 						      IIO_EV_TYPE_THRESH,
 						      0, 0, 0),
-				       iio_get_time_ns());
+				       st->event_timestamp);
 		break;
 	case 2:
 		if (st->activity_walking < st->event_val)
@@ -197,14 +206,14 @@ static irqreturn_t iio_simple_dummy_event_handler(int irq, void *private)
 						      IIO_EV_DIR_FALLING,
 						      IIO_EV_TYPE_THRESH,
 						      0, 0, 0),
-				       iio_get_time_ns());
+				       st->event_timestamp);
 		break;
 	case 3:
 		iio_push_event(indio_dev,
 			       IIO_EVENT_CODE(IIO_STEPS, 0, IIO_NO_MOD,
 					      IIO_EV_DIR_NONE,
 					      IIO_EV_TYPE_CHANGE, 0, 0, 0),
-			       iio_get_time_ns());
+			       st->event_timestamp);
 		break;
 	default:
 		break;
@@ -238,7 +247,7 @@ int iio_simple_dummy_events_register(struct iio_dev *indio_dev)
 	st->regs = iio_dummy_evgen_get_regs(st->event_irq);
 
 	ret = request_threaded_irq(st->event_irq,
-				   NULL,
+				   &iio_simple_dummy_get_timestamp,
 				   &iio_simple_dummy_event_handler,
 				   IRQF_ONESHOT,
 				   "iio_simple_event",
-- 
1.9.1

