Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: gregkh@suse.de
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 02/12] staging:iio: Add and convert drivers to use iio_alloc_pollfunc
Date: Sun, 11 Jul 2010 16:39:09 +0100
Message-Id: <1278862759-19028-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1278862759-19028-1-git-send-email-jic23@cam.ac.uk>
References: <1278862759-19028-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Barry Song <21cnbao@gmail.com>
---
 drivers/staging/iio/accel/adis16209_ring.c |   11 ++++-------
 drivers/staging/iio/accel/adis16240_ring.c |   11 ++++-------
 drivers/staging/iio/accel/lis3l02dq_ring.c |    9 +++------
 drivers/staging/iio/adc/max1363_ring.c     |    9 ++-------
 drivers/staging/iio/gyro/adis16260_ring.c  |   11 ++++-------
 drivers/staging/iio/imu/adis16300_ring.c   |   11 ++++-------
 drivers/staging/iio/imu/adis16350_ring.c   |   11 ++++-------
 drivers/staging/iio/imu/adis16400_ring.c   |   11 ++++-------
 drivers/staging/iio/industrialio-trigger.c |   13 +++++++++++++
 drivers/staging/iio/trigger.h              |    5 ++++-
 10 files changed, 46 insertions(+), 56 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index 8959ad8..e8f7264 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -241,13 +241,10 @@ int adis16209_configure_ring(struct iio_dev *indio_dev)
 	ring->predisable = &adis16209_data_rdy_ring_predisable;
 	ring->owner = THIS_MODULE;
 
-	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
-	if (indio_dev->pollfunc == NULL) {
-		ret = -ENOMEM;
-		goto error_iio_sw_rb_free;;
-	}
-	indio_dev->pollfunc->poll_func_main = &adis16209_poll_func_th;
-	indio_dev->pollfunc->private_data = indio_dev;
+	ret = iio_alloc_pollfunc(indio_dev, NULL, &adis16209_poll_func_th);
+	if (ret)
+		goto error_iio_sw_rb_free;
+
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 	return 0;
 
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index 490d80e..ab52bcf 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -229,13 +229,10 @@ int adis16240_configure_ring(struct iio_dev *indio_dev)
 	ring->predisable = &adis16240_data_rdy_ring_predisable;
 	ring->owner = THIS_MODULE;
 
-	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
-	if (indio_dev->pollfunc == NULL) {
-		ret = -ENOMEM;
-		goto error_iio_sw_rb_free;;
-	}
-	indio_dev->pollfunc->poll_func_main = &adis16240_poll_func_th;
-	indio_dev->pollfunc->private_data = indio_dev;
+	ret = iio_alloc_pollfunc(indio_dev, NULL, &adis16240_poll_func_th);
+	if (ret)
+		goto error_iio_sw_rb_free;
+
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 	return 0;
 
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index a33599d..38c7340 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -566,13 +566,9 @@ int lis3l02dq_configure_ring(struct iio_dev *indio_dev)
 	ring->predisable = &lis3l02dq_data_rdy_ring_predisable;
 	ring->owner = THIS_MODULE;
 
-	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
-	if (indio_dev->pollfunc == NULL) {
-		ret = -ENOMEM;
+	ret = iio_alloc_pollfunc(indio_dev, NULL, &lis3l02dq_poll_func_th);
+	if (ret)
 		goto error_iio_sw_rb_free;;
-	}
-	indio_dev->pollfunc->poll_func_main = &lis3l02dq_poll_func_th;
-	indio_dev->pollfunc->private_data = indio_dev;
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 	return 0;
 
@@ -592,3 +588,4 @@ void lis3l02dq_uninitialize_ring(struct iio_ring_buffer *ring)
 }
 
 
+
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index b30d680..60f0a44 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -223,14 +223,9 @@ int max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	}
 	/* Effectively select the ring buffer implementation */
 	iio_ring_sw_register_funcs(&st->indio_dev->ring->access);
-	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
-	if (indio_dev->pollfunc == NULL) {
-		ret = -ENOMEM;
+	ret = iio_alloc_pollfunc(indio_dev, NULL, &max1363_poll_func_th);
+	if (ret)
 		goto error_deallocate_sw_rb;
-	}
-	/* Configure the polling function called on trigger interrupts */
-	indio_dev->pollfunc->poll_func_main = &max1363_poll_func_th;
-	indio_dev->pollfunc->private_data = indio_dev;
 
 	/* Ring buffer functions - here trigger setup related */
 	indio_dev->ring->postenable = &max1363_ring_postenable;
diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index 2fe7f02..bf3c2e8 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -231,13 +231,10 @@ int adis16260_configure_ring(struct iio_dev *indio_dev)
 	ring->predisable = &adis16260_data_rdy_ring_predisable;
 	ring->owner = THIS_MODULE;
 
-	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
-	if (indio_dev->pollfunc == NULL) {
-		ret = -ENOMEM;
-		goto error_iio_sw_rb_free;;
-	}
-	indio_dev->pollfunc->poll_func_main = &adis16260_poll_func_th;
-	indio_dev->pollfunc->private_data = indio_dev;
+	ret = iio_alloc_pollfunc(indio_dev, NULL, &adis16260_poll_func_th);
+	if (ret)
+		goto error_iio_sw_rb_free;
+
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 	return 0;
 
diff --git a/drivers/staging/iio/imu/adis16300_ring.c b/drivers/staging/iio/imu/adis16300_ring.c
index 17ceb72..de39187 100644
--- a/drivers/staging/iio/imu/adis16300_ring.c
+++ b/drivers/staging/iio/imu/adis16300_ring.c
@@ -256,13 +256,10 @@ int adis16300_configure_ring(struct iio_dev *indio_dev)
 	ring->predisable = &adis16300_data_rdy_ring_predisable;
 	ring->owner = THIS_MODULE;
 
-	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
-	if (indio_dev->pollfunc == NULL) {
-		ret = -ENOMEM;
-		goto error_iio_sw_rb_free;;
-	}
-	indio_dev->pollfunc->poll_func_main = &adis16300_poll_func_th;
-	indio_dev->pollfunc->private_data = indio_dev;
+	ret = iio_alloc_pollfunc(indio_dev, NULL, &adis16300_poll_func_th);
+	if (ret)
+		goto error_iio_sw_rb_free;
+
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 	return 0;
 
diff --git a/drivers/staging/iio/imu/adis16350_ring.c b/drivers/staging/iio/imu/adis16350_ring.c
index 2a0a465..be9ce31 100644
--- a/drivers/staging/iio/imu/adis16350_ring.c
+++ b/drivers/staging/iio/imu/adis16350_ring.c
@@ -261,13 +261,10 @@ int adis16350_configure_ring(struct iio_dev *indio_dev)
 	ring->predisable = &adis16350_data_rdy_ring_predisable;
 	ring->owner = THIS_MODULE;
 
-	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
-	if (indio_dev->pollfunc == NULL) {
-		ret = -ENOMEM;
-		goto error_iio_sw_rb_free;;
-	}
-	indio_dev->pollfunc->poll_func_main = &adis16350_poll_func_th;
-	indio_dev->pollfunc->private_data = indio_dev;
+	ret = iio_alloc_pollfunc(indio_dev, NULL, &adis16350_poll_func_th);
+	if (ret)
+		goto error_iio_sw_rb_free;
+
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 	return 0;
 
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index 5d94cdc..da24384 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -268,13 +268,10 @@ int adis16400_configure_ring(struct iio_dev *indio_dev)
 	ring->predisable = &adis16400_data_rdy_ring_predisable;
 	ring->owner = THIS_MODULE;
 
-	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
-	if (indio_dev->pollfunc == NULL) {
-		ret = -ENOMEM;
-		goto error_iio_sw_rb_free;;
-	}
-	indio_dev->pollfunc->poll_func_main = &adis16400_poll_func_th;
-	indio_dev->pollfunc->private_data = indio_dev;
+	ret = iio_alloc_pollfunc(indio_dev, NULL, &adis16400_poll_func_th);
+	if (ret)
+		goto error_iio_sw_rb_free;
+
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 	return 0;
 
diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index 92e6006..ea97e11 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -398,3 +398,16 @@ int iio_device_unregister_trigger_consumer(struct iio_dev *dev_info)
 }
 EXPORT_SYMBOL(iio_device_unregister_trigger_consumer);
 
+int iio_alloc_pollfunc(struct iio_dev *indio_dev,
+		       void (*immediate)(struct iio_dev *indio_dev),
+		       void (*main)(struct iio_dev  *private_data))
+{
+	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
+	if (indio_dev->pollfunc == NULL)
+		return -ENOMEM;
+	indio_dev->pollfunc->poll_func_immediate = immediate;
+	indio_dev->pollfunc->poll_func_main = main;
+	indio_dev->pollfunc->private_data = indio_dev;
+	return 0;
+}
+EXPORT_SYMBOL(iio_alloc_pollfunc);
diff --git a/drivers/staging/iio/trigger.h b/drivers/staging/iio/trigger.h
index 89610b5..10e9732 100644
--- a/drivers/staging/iio/trigger.h
+++ b/drivers/staging/iio/trigger.h
@@ -148,9 +148,12 @@ struct iio_poll_func {
 
 };
 
+int iio_alloc_pollfunc(struct iio_dev *indio_dev,
+		       void (*immediate)(struct iio_dev *indio_dev),
+		       void (*main)(struct iio_dev  *private_data));
+
 struct iio_trigger *iio_allocate_trigger(void);
 
 void iio_free_trigger(struct iio_trigger *trig);
 
-
 #endif /* _IIO_TRIGGER_H_ */
-- 
1.7.0.4
