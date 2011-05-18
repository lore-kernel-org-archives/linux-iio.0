Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 102/111] staging:iio: poll func allocation clean up.
Date: Wed, 18 May 2011 14:42:32 +0100
Message-Id: <1305726161-5606-103-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Add a function to neatly deal with allocation of poll functions.
Ultimately this allows us to more easily change the implementation.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16201_ring.c |   22 +++++-----------
 drivers/staging/iio/accel/adis16203_ring.c |   23 ++++++-----------
 drivers/staging/iio/accel/adis16204_ring.c |   23 ++++++-----------
 drivers/staging/iio/accel/adis16209_ring.c |   24 +++++++-----------
 drivers/staging/iio/accel/adis16240_ring.c |   26 +++++++------------
 drivers/staging/iio/imu/adis16400_ring.c   |   23 +++++++-----------
 drivers/staging/iio/industrialio-trigger.c |   36 ++++++++++++++++++++++++++++
 drivers/staging/iio/trigger.h              |    8 ++++++
 8 files changed, 95 insertions(+), 90 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_ring.c b/drivers/staging/iio/accel/adis16201_ring.c
index 83b5336..c61f981 100644
--- a/drivers/staging/iio/accel/adis16201_ring.c
+++ b/drivers/staging/iio/accel/adis16201_ring.c
@@ -96,8 +96,7 @@ static irqreturn_t adis16201_trigger_handler(int irq, void *p)
 
 void adis16201_unconfigure_ring(struct iio_dev *indio_dev)
 {
-	kfree(indio_dev->pollfunc->name);
-	kfree(indio_dev->pollfunc);
+	iio_dealloc_pollfunc(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
 
@@ -134,26 +133,19 @@ int adis16201_configure_ring(struct iio_dev *indio_dev)
 	iio_scan_mask_set(ring, ADIS16201_SCAN_INCLI_X);
 	iio_scan_mask_set(ring, ADIS16201_SCAN_INCLI_Y);
 
-	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
+	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
+						 &adis16201_trigger_handler,
+						 IRQF_ONESHOT,
+						 indio_dev,
+						 "adis16201_consumer%d",
+						 indio_dev->id);
 	if (indio_dev->pollfunc == NULL) {
 		ret = -ENOMEM;
 		goto error_iio_sw_rb_free;
 	}
-	indio_dev->pollfunc->private_data = indio_dev;
-	indio_dev->pollfunc->h = &iio_pollfunc_store_time;
-	indio_dev->pollfunc->thread = &adis16201_trigger_handler;
-	indio_dev->pollfunc->type = IRQF_ONESHOT;
-	indio_dev->pollfunc->name =
-		kasprintf(GFP_KERNEL, "adis16201_consumer%d", indio_dev->id);
-	if (indio_dev->pollfunc->name == NULL) {
-		ret = -ENOMEM;
-		goto error_free_poll_func;
-	}
 
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 	return 0;
-error_free_poll_func:
-	kfree(indio_dev->pollfunc);
 error_iio_sw_rb_free:
 	iio_sw_rb_free(indio_dev->ring);
 	return ret;
diff --git a/drivers/staging/iio/accel/adis16203_ring.c b/drivers/staging/iio/accel/adis16203_ring.c
index 1b8863d..a9a789d 100644
--- a/drivers/staging/iio/accel/adis16203_ring.c
+++ b/drivers/staging/iio/accel/adis16203_ring.c
@@ -103,8 +103,7 @@ static irqreturn_t adis16203_trigger_handler(int irq, void *p)
 
 void adis16203_unconfigure_ring(struct iio_dev *indio_dev)
 {
-	kfree(indio_dev->pollfunc->name);
-	kfree(indio_dev->pollfunc);
+	iio_dealloc_pollfunc(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
 
@@ -139,26 +138,20 @@ int adis16203_configure_ring(struct iio_dev *indio_dev)
 	iio_scan_mask_set(ring, ADIS16203_SCAN_INCLI_X);
 	iio_scan_mask_set(ring, ADIS16203_SCAN_INCLI_Y);
 
-	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
+	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
+						 &adis16203_trigger_handler,
+						 IRQF_ONESHOT,
+						 indio_dev,
+						 "adis16203_consumer%d",
+						 indio_dev->id);
 	if (indio_dev->pollfunc == NULL) {
 		ret = -ENOMEM;
 		goto error_iio_sw_rb_free;
 	}
-	indio_dev->pollfunc->private_data = indio_dev;
-	indio_dev->pollfunc->h = &iio_pollfunc_store_time;
-	indio_dev->pollfunc->thread = &adis16203_trigger_handler;
-	indio_dev->pollfunc->type = IRQF_ONESHOT;
-	indio_dev->pollfunc->name =
-		kasprintf(GFP_KERNEL, "adis16203_consumer%d", indio_dev->id);
-	if (indio_dev->pollfunc->name == NULL) {
-		ret = -ENOMEM;
-		goto error_free_poll_func;
-	}
 
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 	return 0;
-error_free_poll_func:
-	kfree(indio_dev->pollfunc);
+
 error_iio_sw_rb_free:
 	iio_sw_rb_free(indio_dev->ring);
 	return ret;
diff --git a/drivers/staging/iio/accel/adis16204_ring.c b/drivers/staging/iio/accel/adis16204_ring.c
index 7d99b48..a2d36fb 100644
--- a/drivers/staging/iio/accel/adis16204_ring.c
+++ b/drivers/staging/iio/accel/adis16204_ring.c
@@ -98,8 +98,7 @@ static irqreturn_t adis16204_trigger_handler(int irq, void *p)
 
 void adis16204_unconfigure_ring(struct iio_dev *indio_dev)
 {
-	kfree(indio_dev->pollfunc->name);
-	kfree(indio_dev->pollfunc);
+	iio_dealloc_pollfunc(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
 
@@ -134,27 +133,21 @@ int adis16204_configure_ring(struct iio_dev *indio_dev)
 	iio_scan_mask_set(ring, ADIS16204_SCAN_AUX_ADC);
 	iio_scan_mask_set(ring, ADIS16204_SCAN_TEMP);
 
-	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
+	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
+						 &adis16204_trigger_handler,
+						 IRQF_ONESHOT,
+						 indio_dev,
+						 "%s_consumer%d",
+						 indio_dev->name,
+						 indio_dev->id);
 	if (indio_dev->pollfunc == NULL) {
 		ret = -ENOMEM;
 		goto error_iio_sw_rb_free;
 	}
-	indio_dev->pollfunc->private_data = indio_dev;
-	indio_dev->pollfunc->h = &iio_pollfunc_store_time;
-	indio_dev->pollfunc->thread = &adis16204_trigger_handler;
-	indio_dev->pollfunc->type = IRQF_ONESHOT;
-	indio_dev->pollfunc->name =
-		kasprintf(GFP_KERNEL, "adis16204_consumer%d", indio_dev->id);
-	if (indio_dev->pollfunc->name == NULL) {
-		ret = -ENOMEM;
-		goto error_free_poll_func;
-	}
 
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 	return 0;
 
-error_free_poll_func:
-	kfree(indio_dev->pollfunc);
 error_iio_sw_rb_free:
 	iio_sw_rb_free(indio_dev->ring);
 	return ret;
diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index 26028e9..390908b 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -98,8 +98,7 @@ static irqreturn_t adis16209_trigger_handler(int irq, void *p)
 
 void adis16209_unconfigure_ring(struct iio_dev *indio_dev)
 {
-	kfree(indio_dev->pollfunc->name);
-	kfree(indio_dev->pollfunc);
+	iio_dealloc_pollfunc(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
 
@@ -137,26 +136,21 @@ int adis16209_configure_ring(struct iio_dev *indio_dev)
 	iio_scan_mask_set(ring, ADIS16209_SCAN_INCLI_Y);
 	iio_scan_mask_set(ring, ADIS16209_SCAN_ROT);
 
-	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
+	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
+						 &adis16209_trigger_handler,
+						 IRQF_ONESHOT,
+						 indio_dev,
+						 "%s_consumer%d",
+						 indio_dev->name,
+						 indio_dev->id);
 	if (indio_dev->pollfunc == NULL) {
 		ret = -ENOMEM;
 		goto error_iio_sw_rb_free;
 	}
-	indio_dev->pollfunc->private_data = indio_dev;
-	indio_dev->pollfunc->h = &iio_pollfunc_store_time;
-	indio_dev->pollfunc->thread = &adis16209_trigger_handler;
-	indio_dev->pollfunc->type = IRQF_ONESHOT;
-	indio_dev->pollfunc->name =
-		kasprintf(GFP_KERNEL, "adis16209_consumer%d", indio_dev->id);
-	if (indio_dev->pollfunc->name == NULL) {
-		ret = -ENOMEM;
-		goto error_free_poll_func;
-	}
 
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 	return 0;
-error_free_poll_func:
-	kfree(indio_dev->pollfunc);
+
 error_iio_sw_rb_free:
 	iio_sw_rb_free(indio_dev->ring);
 	return ret;
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index 8450f7f..0c6d781 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -95,8 +95,7 @@ static irqreturn_t adis16240_trigger_handler(int irq, void *p)
 
 void adis16240_unconfigure_ring(struct iio_dev *indio_dev)
 {
-	kfree(indio_dev->pollfunc->name);
-	kfree(indio_dev->pollfunc);
+	iio_dealloc_pollfunc(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
 
@@ -132,27 +131,22 @@ int adis16240_configure_ring(struct iio_dev *indio_dev)
 	iio_scan_mask_set(ring, ADIS16240_SCAN_AUX_ADC);
 	iio_scan_mask_set(ring, ADIS16240_SCAN_TEMP);
 
-	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
+	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
+						 &adis16240_trigger_handler,
+						 IRQF_ONESHOT,
+						 indio_dev,
+						 "%s_consumer%d",
+						 indio_dev->name,
+						 indio_dev->id);
 	if (indio_dev->pollfunc == NULL) {
 		ret = -ENOMEM;
 		goto error_iio_sw_rb_free;
 	}
-	indio_dev->pollfunc->private_data = indio_dev;
-	indio_dev->pollfunc->h = &iio_pollfunc_store_time;
-	indio_dev->pollfunc->thread = &adis16240_trigger_handler;
-	indio_dev->pollfunc->type = IRQF_ONESHOT;
-	indio_dev->pollfunc->name =
-		kasprintf(GFP_KERNEL, "adis16240_consumer%d", indio_dev->id);
-	if (indio_dev->pollfunc->name == NULL) {
-		ret = -ENOMEM;
-		goto error_free_poll_func;
-	}
+
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 	return 0;
-error_free_poll_func:
-	kfree(indio_dev->pollfunc);
+
 error_iio_sw_rb_free:
 	iio_sw_rb_free(indio_dev->ring);
 	return ret;
 }
-
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index 5d99fba..2589a7e 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -165,8 +165,7 @@ static irqreturn_t adis16400_trigger_handler(int irq, void *p)
 
 void adis16400_unconfigure_ring(struct iio_dev *indio_dev)
 {
-	kfree(indio_dev->pollfunc->name);
-	kfree(indio_dev->pollfunc);
+	iio_dealloc_pollfunc(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
 
@@ -194,28 +193,24 @@ int adis16400_configure_ring(struct iio_dev *indio_dev)
 	ring->scan_timestamp = true;
 	ring->setup_ops = &adis16400_ring_setup_ops;
 	ring->owner = THIS_MODULE;
+	/* Set default scan mode */
 	ring->scan_mask = st->variant->default_scan_mask;
 	ring->scan_count = hweight_long(st->variant->default_scan_mask);
-	/* Set default scan mode */
 
-	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
+	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
+						 &adis16400_trigger_handler,
+						 IRQF_ONESHOT,
+						 indio_dev,
+						 "%s_consumer%d",
+						 indio_dev->name,
+						 indio_dev->id);
 	if (indio_dev->pollfunc == NULL) {
 		ret = -ENOMEM;
 		goto error_iio_sw_rb_free;
 	}
-	indio_dev->pollfunc->private_data = indio_dev;
-	indio_dev->pollfunc->h = &iio_pollfunc_store_time;
-	indio_dev->pollfunc->thread = &adis16400_trigger_handler;
-	indio_dev->pollfunc->type = IRQF_ONESHOT;
-	indio_dev->pollfunc->name =
-		kasprintf(GFP_KERNEL, "adis16400_consumer%d", indio_dev->id);
-	if (ret)
-		goto error_iio_free_pollfunc;
 
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 	return 0;
-error_iio_free_pollfunc:
-	kfree(indio_dev->pollfunc);
 error_iio_sw_rb_free:
 	iio_sw_rb_free(indio_dev->ring);
 	return ret;
diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index e83edac..6159023 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -270,6 +270,42 @@ irqreturn_t iio_pollfunc_store_time(int irq, void *p)
 }
 EXPORT_SYMBOL(iio_pollfunc_store_time);
 
+struct iio_poll_func
+*iio_alloc_pollfunc(irqreturn_t (*h)(int irq, void *p),
+		    irqreturn_t (*thread)(int irq, void *p),
+		    int type,
+		    void *private,
+		    const char *fmt,
+		    ...)
+{
+	va_list vargs;
+	struct iio_poll_func *pf;
+
+	pf = kmalloc(sizeof *pf, GFP_KERNEL);
+	if (pf == NULL)
+		return NULL;
+	va_start(vargs, fmt);
+	pf->name = kvasprintf(GFP_KERNEL, fmt, vargs);
+	va_end(vargs);
+	if (pf->name == NULL) {
+		kfree(pf);
+		return NULL;
+	}
+	pf->h = h;
+	pf->thread = thread;
+	pf->type = type;
+
+	return pf;
+}
+EXPORT_SYMBOL_GPL(iio_alloc_pollfunc);
+
+void iio_dealloc_pollfunc(struct iio_poll_func *pf)
+{
+	kfree(pf->name);
+	kfree(pf);
+}
+EXPORT_SYMBOL_GPL(iio_dealloc_pollfunc);
+
 /**
  * iio_trigger_read_currrent() - trigger consumer sysfs query which trigger
  *
diff --git a/drivers/staging/iio/trigger.h b/drivers/staging/iio/trigger.h
index 7faa31a..f329fe1 100644
--- a/drivers/staging/iio/trigger.h
+++ b/drivers/staging/iio/trigger.h
@@ -160,6 +160,14 @@ struct iio_poll_func {
 	s64 timestamp;
 };
 
+struct iio_poll_func
+*iio_alloc_pollfunc(irqreturn_t (*h)(int irq, void *p),
+		    irqreturn_t (*thread)(int irq, void *p),
+		    int type,
+		    void *private,
+		    const char *fmt,
+		    ...);
+void iio_dealloc_pollfunc(struct iio_poll_func *pf);
 irqreturn_t iio_pollfunc_store_time(int irq, void *p);
 
 /*
-- 
1.7.3.4
