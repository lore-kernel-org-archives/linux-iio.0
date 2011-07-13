Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:38380 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754742Ab1GMOF6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 13 Jul 2011 10:05:58 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 6/6] staging:iio: spit trigger.h into provider and consumer parts.
Date: Wed, 13 Jul 2011 15:05:55 +0100
Message-Id: <1310565955-13469-7-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1310565955-13469-1-git-send-email-jic23@cam.ac.uk>
References: <1310565955-13469-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16201_ring.c |    2 +-
 drivers/staging/iio/accel/adis16203_ring.c |    2 +-
 drivers/staging/iio/accel/adis16204_ring.c |    2 +-
 drivers/staging/iio/accel/adis16209_ring.c |    2 +-
 drivers/staging/iio/accel/adis16240_ring.c |    2 +-
 drivers/staging/iio/accel/lis3l02dq_ring.c |    1 +
 drivers/staging/iio/adc/ad7298_ring.c      |    2 +-
 drivers/staging/iio/adc/ad7476_ring.c      |    2 +-
 drivers/staging/iio/adc/ad7606_ring.c      |    2 +-
 drivers/staging/iio/adc/ad7793.c           |    1 +
 drivers/staging/iio/adc/ad7887_ring.c      |    2 +-
 drivers/staging/iio/adc/ad799x_ring.c      |    2 +-
 drivers/staging/iio/adc/max1363_ring.c     |    2 +-
 drivers/staging/iio/gyro/adis16260_ring.c  |    2 +-
 drivers/staging/iio/imu/adis16400_ring.c   |    2 +-
 drivers/staging/iio/industrialio-trigger.c |    1 +
 drivers/staging/iio/meter/ade7758_ring.c   |    2 +-
 drivers/staging/iio/trigger.h              |   42 +----------------------
 drivers/staging/iio/trigger_consumer.h     |   52 ++++++++++++++++++++++++++++
 19 files changed, 70 insertions(+), 55 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_ring.c b/drivers/staging/iio/accel/adis16201_ring.c
index ef83dc6..bb75121 100644
--- a/drivers/staging/iio/accel/adis16201_ring.c
+++ b/drivers/staging/iio/accel/adis16201_ring.c
@@ -6,7 +6,7 @@
 
 #include "../iio.h"
 #include "../ring_sw.h"
-#include "../trigger.h"
+#include "../trigger_consumer.h"
 #include "adis16201.h"
 
 
diff --git a/drivers/staging/iio/accel/adis16203_ring.c b/drivers/staging/iio/accel/adis16203_ring.c
index 4398fd9..993e239 100644
--- a/drivers/staging/iio/accel/adis16203_ring.c
+++ b/drivers/staging/iio/accel/adis16203_ring.c
@@ -6,7 +6,7 @@
 
 #include "../iio.h"
 #include "../ring_sw.h"
-#include "../trigger.h"
+#include "../trigger_consumer.h"
 #include "adis16203.h"
 
 /**
diff --git a/drivers/staging/iio/accel/adis16204_ring.c b/drivers/staging/iio/accel/adis16204_ring.c
index 385e350..847f438 100644
--- a/drivers/staging/iio/accel/adis16204_ring.c
+++ b/drivers/staging/iio/accel/adis16204_ring.c
@@ -6,7 +6,7 @@
 
 #include "../iio.h"
 #include "../ring_sw.h"
-#include "../trigger.h"
+#include "../trigger_consumer.h"
 #include "adis16204.h"
 
 /**
diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index 1652f15..f889fe7 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -6,7 +6,7 @@
 
 #include "../iio.h"
 #include "../ring_sw.h"
-#include "../trigger.h"
+#include "../trigger_consumer.h"
 #include "adis16209.h"
 
 /**
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index 9d4ba15..051ba64 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -6,7 +6,7 @@
 
 #include "../iio.h"
 #include "../ring_sw.h"
-#include "../trigger.h"
+#include "../trigger_consumer.h"
 #include "adis16240.h"
 
 /**
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 7f7dca4..5c6fe13 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -9,6 +9,7 @@
 #include "../ring_sw.h"
 #include "../kfifo_buf.h"
 #include "../trigger.h"
+#include "../trigger_consumer.h"
 #include "lis3l02dq.h"
 
 /**
diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
index 5b87926..741818c 100644
--- a/drivers/staging/iio/adc/ad7298_ring.c
+++ b/drivers/staging/iio/adc/ad7298_ring.c
@@ -14,7 +14,7 @@
 #include "../iio.h"
 #include "../ring_generic.h"
 #include "../ring_sw.h"
-#include "../trigger.h"
+#include "../trigger_consumer.h"
 
 #include "ad7298.h"
 
diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
index 41d6b8d..b109afb 100644
--- a/drivers/staging/iio/adc/ad7476_ring.c
+++ b/drivers/staging/iio/adc/ad7476_ring.c
@@ -16,7 +16,7 @@
 #include "../iio.h"
 #include "../ring_generic.h"
 #include "../ring_sw.h"
-#include "../trigger.h"
+#include "../trigger_consumer.h"
 
 #include "ad7476.h"
 
diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index 1c563ec..e642430 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -14,7 +14,7 @@
 #include "../iio.h"
 #include "../ring_generic.h"
 #include "../ring_sw.h"
-#include "../trigger.h"
+#include "../trigger_consumer.h"
 
 #include "ad7606.h"
 
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 8a5857c..1bcb3eb 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -22,6 +22,7 @@
 #include "../ring_generic.h"
 #include "../ring_sw.h"
 #include "../trigger.h"
+#include "../trigger_consumer.h"
 
 #include "ad7793.h"
 
diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
index cc39eee..6b3daf4 100644
--- a/drivers/staging/iio/adc/ad7887_ring.c
+++ b/drivers/staging/iio/adc/ad7887_ring.c
@@ -15,7 +15,7 @@
 #include "../iio.h"
 #include "../ring_generic.h"
 #include "../ring_sw.h"
-#include "../trigger.h"
+#include "../trigger_consumer.h"
 
 #include "ad7887.h"
 
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index e268a61..8f1fc52 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -19,7 +19,7 @@
 #include "../iio.h"
 #include "../ring_generic.h"
 #include "../ring_sw.h"
-#include "../trigger.h"
+#include "../trigger_consumer.h"
 
 #include "ad799x.h"
 
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index d4db91d..be601e0 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -17,7 +17,7 @@
 #include "../iio.h"
 #include "../ring_generic.h"
 #include "../ring_sw.h"
-#include "../trigger.h"
+#include "../trigger_consumer.h"
 
 #include "max1363.h"
 
diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index 36f72c3..10f8a66 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -6,7 +6,7 @@
 
 #include "../iio.h"
 #include "../ring_sw.h"
-#include "../trigger.h"
+#include "../trigger_consumer.h"
 #include "adis16260.h"
 
 /**
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index 56385d3..3fc2403 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -7,7 +7,7 @@
 
 #include "../iio.h"
 #include "../ring_sw.h"
-#include "../trigger.h"
+#include "../trigger_consumer.h"
 #include "adis16400.h"
 
 /**
diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index 27da975..6940f8c 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -18,6 +18,7 @@
 #include "iio.h"
 #include "trigger.h"
 #include "iio_core_trigger.h"
+#include "trigger_consumer.h"
 
 /* RFC - Question of approach
  * Make the common case (single sensor single trigger)
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index 2dec532..1e2a096 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -13,7 +13,7 @@
 
 #include "../iio.h"
 #include "../ring_sw.h"
-#include "../trigger.h"
+#include "../trigger_consumer.h"
 #include "ade7758.h"
 
 /**
diff --git a/drivers/staging/iio/trigger.h b/drivers/staging/iio/trigger.h
index 010da1d..56f8baf 100644
--- a/drivers/staging/iio/trigger.h
+++ b/drivers/staging/iio/trigger.h
@@ -73,29 +73,6 @@ struct iio_trigger {
 	struct mutex			pool_lock;
 };
 
-/**
- * struct iio_poll_func - poll function pair
- *
- * @indio_dev:			data specific to device (passed into poll func)
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
-	struct iio_dev *indio_dev;
-	irqreturn_t (*h)(int irq, void *p);
-	irqreturn_t (*thread)(int irq, void *p);
-	int type;
-	char *name;
-	int irq;
-	s64 timestamp;
-};
 
 static inline struct iio_trigger *to_iio_trigger(struct device *d)
 {
@@ -151,7 +128,7 @@ int iio_trigger_dettach_poll_func(struct iio_trigger *trig,
  **/
 void iio_trigger_poll(struct iio_trigger *trig, s64 time);
 void iio_trigger_poll_chained(struct iio_trigger *trig, s64 time);
-void iio_trigger_notify_done(struct iio_trigger *trig);
+
 
 irqreturn_t iio_trigger_generic_data_rdy_poll(int irq, void *private);
 
@@ -176,23 +153,6 @@ static inline void iio_trigger_put_irq(struct iio_trigger *trig, int irq)
 	mutex_unlock(&trig->pool_lock);
 };
 
-struct iio_poll_func
-*iio_alloc_pollfunc(irqreturn_t (*h)(int irq, void *p),
-		    irqreturn_t (*thread)(int irq, void *p),
-		    int type,
-		    struct iio_dev *indio_dev,
-		    const char *fmt,
-		    ...);
-void iio_dealloc_pollfunc(struct iio_poll_func *pf);
-irqreturn_t iio_pollfunc_store_time(int irq, void *p);
-
-/*
- * Two functions for common case where all that happens is a pollfunc
- * is attached and detached from a trigger
- */
-int iio_triggered_ring_postenable(struct iio_dev *indio_dev);
-int iio_triggered_ring_predisable(struct iio_dev *indio_dev);
-
 struct iio_trigger *iio_allocate_trigger(const char *fmt, ...)
 	__attribute__((format(printf, 1, 2)));
 void iio_free_trigger(struct iio_trigger *trig);
diff --git a/drivers/staging/iio/trigger_consumer.h b/drivers/staging/iio/trigger_consumer.h
new file mode 100644
index 0000000..418e0bd
--- /dev/null
+++ b/drivers/staging/iio/trigger_consumer.h
@@ -0,0 +1,52 @@
+/* The industrial I/O core, trigger consumer functions
+ *
+ * Copyright (c) 2008-2011 Jonathan Cameron
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+/**
+ * struct iio_poll_func - poll function pair
+ *
+ * @indio_dev:			data specific to device (passed into poll func)
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
+	struct iio_dev *indio_dev;
+	irqreturn_t (*h)(int irq, void *p);
+	irqreturn_t (*thread)(int irq, void *p);
+	int type;
+	char *name;
+	int irq;
+	s64 timestamp;
+};
+
+
+struct iio_poll_func
+*iio_alloc_pollfunc(irqreturn_t (*h)(int irq, void *p),
+		    irqreturn_t (*thread)(int irq, void *p),
+		    int type,
+		    struct iio_dev *indio_dev,
+		    const char *fmt,
+		    ...);
+void iio_dealloc_pollfunc(struct iio_poll_func *pf);
+irqreturn_t iio_pollfunc_store_time(int irq, void *p);
+
+void iio_trigger_notify_done(struct iio_trigger *trig);
+
+/*
+ * Two functions for common case where all that happens is a pollfunc
+ * is attached and detached from a trigger
+ */
+int iio_triggered_ring_postenable(struct iio_dev *indio_dev);
+int iio_triggered_ring_predisable(struct iio_dev *indio_dev);
-- 
1.7.3.4

