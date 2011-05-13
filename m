Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 3/5] staging:iio: use pollfunc allocation helpers in remaining drivers.
Date: Fri, 13 May 2011 17:09:01 +0100
Message-Id: <1305302943-16475-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305302943-16475-1-git-send-email-jic23@cam.ac.uk>
References: <1305302943-16475-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Some didn't get converted the first time around.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/lis3l02dq_ring.c |   16 +++++++---------
 drivers/staging/iio/adc/ad7298_ring.c      |   24 ++++++++++--------------
 drivers/staging/iio/adc/ad7476_ring.c      |   26 ++++++++++----------------
 drivers/staging/iio/adc/ad7606_ring.c      |   24 +++++++++---------------
 drivers/staging/iio/adc/ad7887_ring.c      |   24 ++++++++----------------
 drivers/staging/iio/adc/ad799x_ring.c      |   25 ++++++++++---------------
 drivers/staging/iio/adc/max1363_ring.c     |   24 +++++++++---------------
 drivers/staging/iio/gyro/adis16260_ring.c  |   23 ++++++++---------------
 drivers/staging/iio/meter/ade7758_ring.c   |   22 ++++++++--------------
 9 files changed, 79 insertions(+), 129 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 1c208d2..8d5c8ac 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -344,8 +344,7 @@ void lis3l02dq_remove_trigger(struct iio_dev *indio_dev)
 
 void lis3l02dq_unconfigure_ring(struct iio_dev *indio_dev)
 {
-	kfree(indio_dev->pollfunc->name);
-	kfree(indio_dev->pollfunc);
+	iio_dealloc_pollfunc(indio_dev->pollfunc);
 	lis3l02dq_free_buf(indio_dev->ring);
 }
 
@@ -448,18 +447,17 @@ int lis3l02dq_configure_ring(struct iio_dev *indio_dev)
 	iio_scan_mask_set(ring, 2);
 
 	/* Functions are NULL as we set handler below */
-	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
+	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
+						 &lis3l02dq_trigger_handler,
+						 0,
+						 indio_dev,
+						 "lis3l02dq_consumer%d",
+						 indio_dev->id);
 
 	if (indio_dev->pollfunc == NULL) {
 		ret = -ENOMEM;
 		goto error_iio_sw_rb_free;
 	}
-	indio_dev->pollfunc->private_data = indio_dev;
-	indio_dev->pollfunc->thread = &lis3l02dq_trigger_handler;
-	indio_dev->pollfunc->h = &iio_pollfunc_store_time;
-	indio_dev->pollfunc->type = 0;
-	indio_dev->pollfunc->name
-		= kasprintf(GFP_KERNEL, "lis3l02dq_consumer%d", indio_dev->id);
 
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 	return 0;
diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
index d0a0aeaaf..9c23dd1 100644
--- a/drivers/staging/iio/adc/ad7298_ring.c
+++ b/drivers/staging/iio/adc/ad7298_ring.c
@@ -164,20 +164,18 @@ int ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	/* Effectively select the ring buffer implementation */
 	indio_dev->ring->access = &ring_sw_access_funcs;
 
-	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
+	indio_dev->pollfunc = iio_alloc_pollfunc(NULL,
+						 &ad7298_trigger_handler,
+						 IRQF_ONESHOT,
+						 indio_dev,
+						 "ad7298_consumer%d",
+						 indio_dev->id);
+	
 	if (indio_dev->pollfunc == NULL) {
 		ret = -ENOMEM;
 		goto error_deallocate_sw_rb;
 	}
-	indio_dev->pollfunc->private_data = indio_dev;
-	indio_dev->pollfunc->thread = &ad7298_trigger_handler;
-	indio_dev->pollfunc->type = IRQF_ONESHOT;
-	indio_dev->pollfunc->name =
-		kasprintf(GFP_KERNEL, "ad7298_consumer%d", indio_dev->id);
-	if (indio_dev->pollfunc->name == NULL) {
-		ret = -ENOMEM;
-		goto error_free_poll_func;
-	}
+
 	/* Ring buffer functions - here trigger setup related */
 	indio_dev->ring->setup_ops = &ad7298_ring_setup_ops;
 	indio_dev->ring->scan_timestamp = true;
@@ -185,8 +183,7 @@ int ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 	return 0;
-error_free_poll_func:
-	kfree(indio_dev->pollfunc);
+
 error_deallocate_sw_rb:
 	iio_sw_rb_free(indio_dev->ring);
 error_ret:
@@ -200,7 +197,6 @@ void ad7298_ring_cleanup(struct iio_dev *indio_dev)
 		iio_trigger_dettach_poll_func(indio_dev->trig,
 					      indio_dev->pollfunc);
 	}
-	kfree(indio_dev->pollfunc->name);
-	kfree(indio_dev->pollfunc);
+	iio_dealloc_pollfunc(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
index 1d696ef..b1b2ee2 100644
--- a/drivers/staging/iio/adc/ad7476_ring.c
+++ b/drivers/staging/iio/adc/ad7476_ring.c
@@ -125,22 +125,18 @@ int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	}
 	/* Effectively select the ring buffer implementation */
 	indio_dev->ring->access = &ring_sw_access_funcs;
-	indio_dev->pollfunc = kzalloc(sizeof(indio_dev->pollfunc), GFP_KERNEL);
+	indio_dev->pollfunc
+		= iio_alloc_pollfunc(NULL,
+				     &ad7476_trigger_handler,
+				     IRQF_ONESHOT,
+				     indio_dev,
+				     "%s_consumer%d",
+				     spi_get_device_id(st->spi)->name,
+				     indio_dev->id);
 	if (indio_dev->pollfunc == NULL) {
 		ret = -ENOMEM;
 		goto error_deallocate_sw_rb;
 	}
-	indio_dev->pollfunc->private_data = indio_dev;
-	indio_dev->pollfunc->thread = &ad7476_trigger_handler;
-	indio_dev->pollfunc->type = IRQF_ONESHOT;
-	indio_dev->pollfunc->name
-		= kasprintf(GFP_KERNEL, "%s_consumer%d",
-			    spi_get_device_id(st->spi)->name,
-			    indio_dev->id);
-	if (indio_dev->pollfunc->name == NULL) {
-		ret = -ENOMEM;
-		goto error_free_pollfunc;
-	}
 
 	/* Ring buffer functions - here trigger setup related */
 	indio_dev->ring->setup_ops = &ad7476_ring_setup_ops;
@@ -149,8 +145,7 @@ int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 	return 0;
-error_free_pollfunc:
-	kfree(indio_dev->pollfunc);
+
 error_deallocate_sw_rb:
 	iio_sw_rb_free(indio_dev->ring);
 error_ret:
@@ -165,7 +160,6 @@ void ad7476_ring_cleanup(struct iio_dev *indio_dev)
 		iio_trigger_dettach_poll_func(indio_dev->trig,
 					      indio_dev->pollfunc);
 	}
-	kfree(indio_dev->pollfunc->name);
-	kfree(indio_dev->pollfunc);
+	iio_dealloc_pollfunc(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index 85cde6a..a199bf4 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -169,22 +169,18 @@ int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 
 	/* Effectively select the ring buffer implementation */
 	indio_dev->ring->access = &ring_sw_access_funcs;
-	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
+	indio_dev->pollfunc = iio_alloc_pollfunc(&ad7606_trigger_handler_th_bh,
+						 &ad7606_trigger_handler_th_bh,
+						 0,
+						 indio_dev,
+						 "%s_consumer%d",
+						 indio_dev->name,
+						 indio_dev->id);
 	if (indio_dev->pollfunc == NULL) {
 		ret = -ENOMEM;
 		goto error_deallocate_sw_rb;
 	}
 
-	indio_dev->pollfunc->private_data = indio_dev;
-	indio_dev->pollfunc->h = &ad7606_trigger_handler_th_bh;
-	indio_dev->pollfunc->thread = &ad7606_trigger_handler_th_bh;
-	indio_dev->pollfunc->name =
-		kasprintf(GFP_KERNEL, "%s_consumer%d", indio_dev->name,
-			  indio_dev->id);
-	if (indio_dev->pollfunc->name == NULL) {
-		ret = -ENOMEM;
-		goto error_free_poll_func;
-	}
 	/* Ring buffer functions - here trigger setup related */
 
 	indio_dev->ring->setup_ops = &ad7606_ring_setup_ops;
@@ -195,8 +191,7 @@ int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 	return 0;
-error_free_poll_func:
-	kfree(indio_dev->pollfunc);
+
 error_deallocate_sw_rb:
 	iio_sw_rb_free(indio_dev->ring);
 error_ret:
@@ -210,7 +205,6 @@ void ad7606_ring_cleanup(struct iio_dev *indio_dev)
 		iio_trigger_dettach_poll_func(indio_dev->trig,
 					      indio_dev->pollfunc);
 	}
-	kfree(indio_dev->pollfunc->name);
-	kfree(indio_dev->pollfunc);
+	iio_dealloc_pollfunc(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
index f3485b3..0e4a5f4 100644
--- a/drivers/staging/iio/adc/ad7887_ring.c
+++ b/drivers/staging/iio/adc/ad7887_ring.c
@@ -166,30 +166,23 @@ int ad7887_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	}
 	/* Effectively select the ring buffer implementation */
 	indio_dev->ring->access = &ring_sw_access_funcs;
-	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
+	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
+						 &ad7887_trigger_handler,
+						 IRQF_ONESHOT,
+						 indio_dev,
+						 "ad7887_consumer%d",
+						 indio_dev->id);
 	if (indio_dev->pollfunc == NULL) {
 		ret = -ENOMEM;
 		goto error_deallocate_sw_rb;
 	}
-
-	indio_dev->pollfunc->private_data = indio_dev;
-	indio_dev->pollfunc->h = &iio_pollfunc_store_time;
-	indio_dev->pollfunc->thread = &ad7887_trigger_handler;
-	indio_dev->pollfunc->type = IRQF_ONESHOT;
-	indio_dev->pollfunc->name =
-		kasprintf(GFP_KERNEL, "ad7887_consumer%d", indio_dev->id);
-	if (indio_dev->pollfunc->name == NULL) {
-		ret = -ENOMEM;
-		goto error_free_pollfunc;
-	}
 	/* Ring buffer functions - here trigger setup related */
 	indio_dev->ring->setup_ops = &ad7887_ring_setup_ops;
 
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 	return 0;
-error_free_pollfunc:
-	kfree(indio_dev->pollfunc);
+
 error_deallocate_sw_rb:
 	iio_sw_rb_free(indio_dev->ring);
 error_ret:
@@ -204,7 +197,6 @@ void ad7887_ring_cleanup(struct iio_dev *indio_dev)
 		iio_trigger_dettach_poll_func(indio_dev->trig,
 					      indio_dev->pollfunc);
 	}
-	kfree(indio_dev->pollfunc->name);
-	kfree(indio_dev->pollfunc);
+	iio_dealloc_pollfunc(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index 57dca20..1ae8857 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -179,21 +179,18 @@ int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	}
 	/* Effectively select the ring buffer implementation */
 	indio_dev->ring->access = &ring_sw_access_funcs;
-	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
+	indio_dev->pollfunc = iio_alloc_pollfunc(NULL,
+						 &ad799x_trigger_handler,
+						 IRQF_ONESHOT,
+						 indio_dev,
+						 "%s_consumer%d",
+						 indio_dev->name,
+						 indio_dev->id);
 	if (indio_dev->pollfunc == NULL) {
 		ret = -ENOMEM;
 		goto error_deallocate_sw_rb;
 	}
-	indio_dev->pollfunc->private_data = indio_dev;
-	indio_dev->pollfunc->thread = &ad799x_trigger_handler;
-	indio_dev->pollfunc->type = IRQF_ONESHOT;
-	indio_dev->pollfunc->name =
-		kasprintf(GFP_KERNEL, "%s_consumer%d", indio_dev->name,
-			  indio_dev->id);
-	if (indio_dev->pollfunc->name == NULL) {
-		ret = -ENOMEM;
-		goto error_free_poll_func;
-	}
+
 	/* Ring buffer functions - here trigger setup related */
 	indio_dev->ring->setup_ops = &ad799x_buf_setup_ops;
 	indio_dev->ring->scan_timestamp = true;
@@ -201,8 +198,7 @@ int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 	return 0;
-error_free_poll_func:
-	kfree(indio_dev->pollfunc);
+
 error_deallocate_sw_rb:
 	iio_sw_rb_free(indio_dev->ring);
 error_ret:
@@ -217,7 +213,6 @@ void ad799x_ring_cleanup(struct iio_dev *indio_dev)
 		iio_trigger_dettach_poll_func(indio_dev->trig,
 					      indio_dev->pollfunc);
 	}
-	kfree(indio_dev->pollfunc->name);
-	kfree(indio_dev->pollfunc);
+	iio_dealloc_pollfunc(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index 1587aec1..f43befd 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -169,21 +169,17 @@ int max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
+	indio_dev->pollfunc = iio_alloc_pollfunc(NULL,
+						 &max1363_trigger_handler,
+						 IRQF_ONESHOT,
+						 indio_dev,
+						 "%s_consumer%d",
+						 st->client->name,
+						 indio_dev->id);
 	if (indio_dev->pollfunc == NULL) {
 		ret = -ENOMEM;
 		goto error_deallocate_sw_rb;
 	}
-	indio_dev->pollfunc->private_data = indio_dev;
-	indio_dev->pollfunc->thread = &max1363_trigger_handler;
-	indio_dev->pollfunc->type = IRQF_ONESHOT;
-	indio_dev->pollfunc->name =
-		kasprintf(GFP_KERNEL, "%s_consumer%d",
-			  st->client->name, indio_dev->id);
-	if (indio_dev->pollfunc->name == NULL) {
-		ret = -ENOMEM;
-		goto error_free_pollfunc;
-	}
 	/* Effectively select the ring buffer implementation */
 	indio_dev->ring->access = &ring_sw_access_funcs;
 	/* Ring buffer functions - here trigger setup related */
@@ -193,8 +189,7 @@ int max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 
 	return 0;
-error_free_pollfunc:
-	kfree(indio_dev->pollfunc);
+
 error_deallocate_sw_rb:
 	iio_sw_rb_free(indio_dev->ring);
 error_ret:
@@ -209,7 +204,6 @@ void max1363_ring_cleanup(struct iio_dev *indio_dev)
 		iio_trigger_dettach_poll_func(indio_dev->trig,
 					      indio_dev->pollfunc);
 	}
-	kfree(indio_dev->pollfunc->name);
-	kfree(indio_dev->pollfunc);
+	iio_dealloc_pollfunc(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index 85586e4..a092504 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -101,8 +101,7 @@ static irqreturn_t adis16260_trigger_handler(int irq, void *p)
 
 void adis16260_unconfigure_ring(struct iio_dev *indio_dev)
 {
-	kfree(indio_dev->pollfunc->name);
-	kfree(indio_dev->pollfunc);
+	iio_dealloc_pollfunc(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
 
@@ -137,26 +136,20 @@ int adis16260_configure_ring(struct iio_dev *indio_dev)
 	iio_scan_mask_set(ring, ADIS16260_SCAN_TEMP);
 	iio_scan_mask_set(ring, ADIS16260_SCAN_ANGL);
 
-	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
+	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
+						 &adis16260_trigger_handler,
+						 IRQF_ONESHOT,
+						 indio_dev,
+						 "adis16260_consumer%d",
+						 indio_dev->id);
 	if (indio_dev->pollfunc == NULL) {
 		ret = -ENOMEM;
 		goto error_iio_sw_rb_free;
 	}
-	indio_dev->pollfunc->private_data = indio_dev;
-	indio_dev->pollfunc->h = &iio_pollfunc_store_time;
-	indio_dev->pollfunc->thread = &adis16260_trigger_handler;
-	indio_dev->pollfunc->type = IRQF_ONESHOT;
-	indio_dev->pollfunc->name =
-		kasprintf(GFP_KERNEL, "adis16260_consumer%d", indio_dev->id);
-	if (indio_dev->pollfunc->name == NULL) {
-		ret = -ENOMEM;
-		goto error_free_pollfunc;
-	}
 
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 	return 0;
-error_free_pollfunc:
-	kfree(indio_dev->pollfunc);
+
 error_iio_sw_rb_free:
 	iio_sw_rb_free(indio_dev->ring);
 	return ret;
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index a5e48c1..b89b7f8 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -142,8 +142,7 @@ void ade7758_unconfigure_ring(struct iio_dev *indio_dev)
 		iio_trigger_dettach_poll_func(indio_dev->trig,
 					      indio_dev->pollfunc);
 	}
-	kfree(indio_dev->pollfunc->name);
-	kfree(indio_dev->pollfunc);
+	iio_dealloc_pollfunc(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
 
@@ -163,20 +162,17 @@ int ade7758_configure_ring(struct iio_dev *indio_dev)
 	indio_dev->ring->setup_ops = &ade7758_ring_setup_ops;
 	indio_dev->ring->owner = THIS_MODULE;
 
-	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
+	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
+						 &ade7758_trigger_handler,
+						 0,
+						 indio_dev,
+						 "ade7759_consumer%d",
+						 indio_dev->id);
 	if (indio_dev->pollfunc == NULL) {
 		ret = -ENOMEM;
 		goto error_iio_sw_rb_free;
 	}
-	indio_dev->pollfunc->private_data = indio_dev;
-	indio_dev->pollfunc->h = &iio_pollfunc_store_time;
-	indio_dev->pollfunc->thread = &ade7758_trigger_handler;
-	indio_dev->pollfunc->name
-		= kasprintf(GFP_KERNEL, "ade7759_consumer%d", indio_dev->id);
-	if (indio_dev->pollfunc->name == NULL) {
-		ret = -ENOMEM;
-		goto error_free_pollfunc;
-	}
+
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 
 	st->tx_buf[0] = ADE7758_READ_REG(ADE7758_RSTATUS);
@@ -214,8 +210,6 @@ int ade7758_configure_ring(struct iio_dev *indio_dev)
 
 	return 0;
 
-error_free_pollfunc:
-	kfree(indio_dev->pollfunc);
 error_iio_sw_rb_free:
 	iio_sw_rb_free(indio_dev->ring);
 	return ret;
-- 
1.7.3.4
