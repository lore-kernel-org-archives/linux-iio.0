Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: gregkh@suse.de
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 03/12] staging:iio: Add iio_triggered_ring postenable and predisable + use in drivers
Date: Sun, 11 Jul 2010 16:39:10 +0100
Message-Id: <1278862759-19028-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1278862759-19028-1-git-send-email-jic23@cam.ac.uk>
References: <1278862759-19028-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Barry Song <21cnbao@gmail.com>
---
 drivers/staging/iio/accel/adis16209_ring.c |   20 +---------------
 drivers/staging/iio/accel/adis16240_ring.c |   20 +---------------
 drivers/staging/iio/accel/lis3l02dq_ring.c |   21 +----------------
 drivers/staging/iio/adc/max1363_ring.c     |   33 +--------------------------
 drivers/staging/iio/gyro/adis16260_ring.c  |   20 +---------------
 drivers/staging/iio/imu/adis16300_ring.c   |   20 +---------------
 drivers/staging/iio/imu/adis16350_ring.c   |   20 +---------------
 drivers/staging/iio/imu/adis16400_ring.c   |   20 +---------------
 drivers/staging/iio/industrialio-trigger.c |   18 +++++++++++++++
 drivers/staging/iio/trigger.h              |    7 ++++++
 10 files changed, 41 insertions(+), 158 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index e8f7264..3b42a65 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -186,22 +186,6 @@ static int adis16209_data_rdy_ring_preenable(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static int adis16209_data_rdy_ring_postenable(struct iio_dev *indio_dev)
-{
-	return indio_dev->trig
-		? iio_trigger_attach_poll_func(indio_dev->trig,
-					       indio_dev->pollfunc)
-		: 0;
-}
-
-static int adis16209_data_rdy_ring_predisable(struct iio_dev *indio_dev)
-{
-	return indio_dev->trig
-		? iio_trigger_dettach_poll_func(indio_dev->trig,
-						indio_dev->pollfunc)
-		: 0;
-}
-
 void adis16209_unconfigure_ring(struct iio_dev *indio_dev)
 {
 	kfree(indio_dev->pollfunc);
@@ -237,8 +221,8 @@ int adis16209_configure_ring(struct iio_dev *indio_dev)
 	/* Effectively select the ring buffer implementation */
 	iio_ring_sw_register_funcs(&ring->access);
 	ring->preenable = &adis16209_data_rdy_ring_preenable;
-	ring->postenable = &adis16209_data_rdy_ring_postenable;
-	ring->predisable = &adis16209_data_rdy_ring_predisable;
+	ring->postenable = &iio_triggered_ring_postenable;
+	ring->predisable = &iio_triggered_ring_predisable;
 	ring->owner = THIS_MODULE;
 
 	ret = iio_alloc_pollfunc(indio_dev, NULL, &adis16209_poll_func_th);
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index ab52bcf..08fef63 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -176,22 +176,6 @@ static int adis16240_data_rdy_ring_preenable(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static int adis16240_data_rdy_ring_postenable(struct iio_dev *indio_dev)
-{
-	return indio_dev->trig
-		? iio_trigger_attach_poll_func(indio_dev->trig,
-				indio_dev->pollfunc)
-		: 0;
-}
-
-static int adis16240_data_rdy_ring_predisable(struct iio_dev *indio_dev)
-{
-	return indio_dev->trig
-		? iio_trigger_dettach_poll_func(indio_dev->trig,
-				indio_dev->pollfunc)
-		: 0;
-}
-
 void adis16240_unconfigure_ring(struct iio_dev *indio_dev)
 {
 	kfree(indio_dev->pollfunc);
@@ -225,8 +209,8 @@ int adis16240_configure_ring(struct iio_dev *indio_dev)
 	/* Effectively select the ring buffer implementation */
 	iio_ring_sw_register_funcs(&ring->access);
 	ring->preenable = &adis16240_data_rdy_ring_preenable;
-	ring->postenable = &adis16240_data_rdy_ring_postenable;
-	ring->predisable = &adis16240_data_rdy_ring_predisable;
+	ring->postenable = &iio_triggered_ring_postenable;
+	ring->predisable = &iio_triggered_ring_predisable;
 	ring->owner = THIS_MODULE;
 
 	ret = iio_alloc_pollfunc(indio_dev, NULL, &adis16240_poll_func_th);
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 38c7340..bc0de78 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -339,23 +339,6 @@ static int lis3l02dq_data_rdy_ring_preenable(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static int lis3l02dq_data_rdy_ring_postenable(struct iio_dev *indio_dev)
-{
-	return indio_dev->trig
-		? iio_trigger_attach_poll_func(indio_dev->trig,
-					       indio_dev->pollfunc)
-		: 0;
-}
-
-static int lis3l02dq_data_rdy_ring_predisable(struct iio_dev *indio_dev)
-{
-	return indio_dev->trig
-		? iio_trigger_dettach_poll_func(indio_dev->trig,
-						indio_dev->pollfunc)
-		: 0;
-}
-
-
 /* Caller responsible for locking as necessary. */
 static int
 __lis3l02dq_write_data_ready_config(struct device *dev,
@@ -562,8 +545,8 @@ int lis3l02dq_configure_ring(struct iio_dev *indio_dev)
 	/* Effectively select the ring buffer implementation */
 	iio_ring_sw_register_funcs(&ring->access);
 	ring->preenable = &lis3l02dq_data_rdy_ring_preenable;
-	ring->postenable = &lis3l02dq_data_rdy_ring_postenable;
-	ring->predisable = &lis3l02dq_data_rdy_ring_predisable;
+	ring->postenable = &iio_triggered_ring_postenable;
+	ring->predisable = &iio_triggered_ring_predisable;
 	ring->owner = THIS_MODULE;
 
 	ret = iio_alloc_pollfunc(indio_dev, NULL, &lis3l02dq_poll_func_th);
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index 60f0a44..b510ca6 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -105,35 +105,6 @@ static int max1363_ring_preenable(struct iio_dev *indio_dev)
 	return 0;
 }
 
-/**
- * max1363_ring_postenable() - typical ring post enable
- *
- * Only not moved into the core for the hardware ring buffer cases
- * that are more sophisticated.
- **/
-static int max1363_ring_postenable(struct iio_dev *indio_dev)
-{
-	if (indio_dev->trig == NULL)
-		return 0;
-	return iio_trigger_attach_poll_func(indio_dev->trig,
-					    indio_dev->pollfunc);
-}
-
-/**
- * max1363_ring_predisable() - runs just prior to ring buffer being disabled
- *
- * Typical predisable function which ensures that no trigger events can
- * occur before we disable the ring buffer (and hence would have no idea
- * what to do with them)
- **/
-static int max1363_ring_predisable(struct iio_dev *indio_dev)
-{
-	if (indio_dev->trig)
-		return iio_trigger_dettach_poll_func(indio_dev->trig,
-						     indio_dev->pollfunc);
-	else
-		return 0;
-}
 
 /**
  * max1363_poll_func_th() - th of trigger launched polling to ring buffer
@@ -228,9 +199,9 @@ int max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 		goto error_deallocate_sw_rb;
 
 	/* Ring buffer functions - here trigger setup related */
-	indio_dev->ring->postenable = &max1363_ring_postenable;
+	indio_dev->ring->postenable = &iio_triggered_ring_postenable;
 	indio_dev->ring->preenable = &max1363_ring_preenable;
-	indio_dev->ring->predisable = &max1363_ring_predisable;
+	indio_dev->ring->predisable = &iio_triggered_ring_predisable;
 	INIT_WORK(&st->poll_work, &max1363_poll_bh_to_ring);
 
 	/* Flag that polled ring buffering is possible */
diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index bf3c2e8..05e7a69 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -179,22 +179,6 @@ static int adis16260_data_rdy_ring_preenable(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static int adis16260_data_rdy_ring_postenable(struct iio_dev *indio_dev)
-{
-	return indio_dev->trig
-		? iio_trigger_attach_poll_func(indio_dev->trig,
-				indio_dev->pollfunc)
-		: 0;
-}
-
-static int adis16260_data_rdy_ring_predisable(struct iio_dev *indio_dev)
-{
-	return indio_dev->trig
-		? iio_trigger_dettach_poll_func(indio_dev->trig,
-				indio_dev->pollfunc)
-		: 0;
-}
-
 void adis16260_unconfigure_ring(struct iio_dev *indio_dev)
 {
 	kfree(indio_dev->pollfunc);
@@ -227,8 +211,8 @@ int adis16260_configure_ring(struct iio_dev *indio_dev)
 	/* Effectively select the ring buffer implementation */
 	iio_ring_sw_register_funcs(&ring->access);
 	ring->preenable = &adis16260_data_rdy_ring_preenable;
-	ring->postenable = &adis16260_data_rdy_ring_postenable;
-	ring->predisable = &adis16260_data_rdy_ring_predisable;
+	ring->postenable = &iio_triggered_ring_postenable;
+	ring->predisable = &iio_triggered_ring_predisable;
 	ring->owner = THIS_MODULE;
 
 	ret = iio_alloc_pollfunc(indio_dev, NULL, &adis16260_poll_func_th);
diff --git a/drivers/staging/iio/imu/adis16300_ring.c b/drivers/staging/iio/imu/adis16300_ring.c
index de39187..4dee670 100644
--- a/drivers/staging/iio/imu/adis16300_ring.c
+++ b/drivers/staging/iio/imu/adis16300_ring.c
@@ -200,22 +200,6 @@ static int adis16300_data_rdy_ring_preenable(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static int adis16300_data_rdy_ring_postenable(struct iio_dev *indio_dev)
-{
-	return indio_dev->trig
-		? iio_trigger_attach_poll_func(indio_dev->trig,
-					       indio_dev->pollfunc)
-		: 0;
-}
-
-static int adis16300_data_rdy_ring_predisable(struct iio_dev *indio_dev)
-{
-	return indio_dev->trig
-		? iio_trigger_dettach_poll_func(indio_dev->trig,
-						indio_dev->pollfunc)
-		: 0;
-}
-
 void adis16300_unconfigure_ring(struct iio_dev *indio_dev)
 {
 	kfree(indio_dev->pollfunc);
@@ -252,8 +236,8 @@ int adis16300_configure_ring(struct iio_dev *indio_dev)
 	/* Effectively select the ring buffer implementation */
 	iio_ring_sw_register_funcs(&ring->access);
 	ring->preenable = &adis16300_data_rdy_ring_preenable;
-	ring->postenable = &adis16300_data_rdy_ring_postenable;
-	ring->predisable = &adis16300_data_rdy_ring_predisable;
+	ring->postenable = &iio_triggered_ring_postenable;
+	ring->predisable = &iio_triggered_ring_predisable;
 	ring->owner = THIS_MODULE;
 
 	ret = iio_alloc_pollfunc(indio_dev, NULL, &adis16300_poll_func_th);
diff --git a/drivers/staging/iio/imu/adis16350_ring.c b/drivers/staging/iio/imu/adis16350_ring.c
index be9ce31..c70816d 100644
--- a/drivers/staging/iio/imu/adis16350_ring.c
+++ b/drivers/staging/iio/imu/adis16350_ring.c
@@ -203,22 +203,6 @@ static int adis16350_data_rdy_ring_preenable(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static int adis16350_data_rdy_ring_postenable(struct iio_dev *indio_dev)
-{
-	return indio_dev->trig
-		? iio_trigger_attach_poll_func(indio_dev->trig,
-					       indio_dev->pollfunc)
-		: 0;
-}
-
-static int adis16350_data_rdy_ring_predisable(struct iio_dev *indio_dev)
-{
-	return indio_dev->trig
-		? iio_trigger_dettach_poll_func(indio_dev->trig,
-						indio_dev->pollfunc)
-		: 0;
-}
-
 void adis16350_unconfigure_ring(struct iio_dev *indio_dev)
 {
 	kfree(indio_dev->pollfunc);
@@ -257,8 +241,8 @@ int adis16350_configure_ring(struct iio_dev *indio_dev)
 	/* Effectively select the ring buffer implementation */
 	iio_ring_sw_register_funcs(&ring->access);
 	ring->preenable = &adis16350_data_rdy_ring_preenable;
-	ring->postenable = &adis16350_data_rdy_ring_postenable;
-	ring->predisable = &adis16350_data_rdy_ring_predisable;
+	ring->postenable = &iio_triggered_ring_postenable;
+	ring->predisable = &iio_triggered_ring_predisable;
 	ring->owner = THIS_MODULE;
 
 	ret = iio_alloc_pollfunc(indio_dev, NULL, &adis16350_poll_func_th);
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index da24384..8f7d257 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -209,22 +209,6 @@ static int adis16400_data_rdy_ring_preenable(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static int adis16400_data_rdy_ring_postenable(struct iio_dev *indio_dev)
-{
-	return indio_dev->trig
-		? iio_trigger_attach_poll_func(indio_dev->trig,
-					       indio_dev->pollfunc)
-		: 0;
-}
-
-static int adis16400_data_rdy_ring_predisable(struct iio_dev *indio_dev)
-{
-	return indio_dev->trig
-		? iio_trigger_dettach_poll_func(indio_dev->trig,
-						indio_dev->pollfunc)
-		: 0;
-}
-
 void adis16400_unconfigure_ring(struct iio_dev *indio_dev)
 {
 	kfree(indio_dev->pollfunc);
@@ -264,8 +248,8 @@ int adis16400_configure_ring(struct iio_dev *indio_dev)
 	/* Effectively select the ring buffer implementation */
 	iio_ring_sw_register_funcs(&ring->access);
 	ring->preenable = &adis16400_data_rdy_ring_preenable;
-	ring->postenable = &adis16400_data_rdy_ring_postenable;
-	ring->predisable = &adis16400_data_rdy_ring_predisable;
+	ring->postenable = &iio_triggered_ring_postenable;
+	ring->predisable = &iio_triggered_ring_predisable;
 	ring->owner = THIS_MODULE;
 
 	ret = iio_alloc_pollfunc(indio_dev, NULL, &adis16400_poll_func_th);
diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index ea97e11..2d8e5b9 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -411,3 +411,21 @@ int iio_alloc_pollfunc(struct iio_dev *indio_dev,
 	return 0;
 }
 EXPORT_SYMBOL(iio_alloc_pollfunc);
+
+int iio_triggered_ring_postenable(struct iio_dev *indio_dev)
+{
+	return indio_dev->trig
+		? iio_trigger_attach_poll_func(indio_dev->trig,
+					       indio_dev->pollfunc)
+		: 0;
+}
+EXPORT_SYMBOL(iio_triggered_ring_postenable);
+
+int iio_triggered_ring_predisable(struct iio_dev *indio_dev)
+{
+	return indio_dev->trig
+		? iio_trigger_dettach_poll_func(indio_dev->trig,
+						indio_dev->pollfunc)
+		: 0;
+}
+EXPORT_SYMBOL(iio_triggered_ring_predisable);
diff --git a/drivers/staging/iio/trigger.h b/drivers/staging/iio/trigger.h
index 10e9732..832de15 100644
--- a/drivers/staging/iio/trigger.h
+++ b/drivers/staging/iio/trigger.h
@@ -152,6 +152,13 @@ int iio_alloc_pollfunc(struct iio_dev *indio_dev,
 		       void (*immediate)(struct iio_dev *indio_dev),
 		       void (*main)(struct iio_dev  *private_data));
 
+/*
+ * Two functions for common case where all that happens is a pollfunc
+ * is attached and detached form a trigger
+ */
+int iio_triggered_ring_postenable(struct iio_dev *indio_dev);
+int iio_triggered_ring_predisable(struct iio_dev *indio_dev);
+
 struct iio_trigger *iio_allocate_trigger(void);
 
 void iio_free_trigger(struct iio_trigger *trig);
-- 
1.7.0.4
