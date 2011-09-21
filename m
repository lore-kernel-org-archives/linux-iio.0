Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org,
	greg@kroah.com
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 05/14] staging:iio: treewide rename iio_triggered_ring_* to iio_triggered_buffer_*
Date: Wed, 21 Sep 2011 11:15:53 +0100
Message-Id: <1316600162-15581-6-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316600162-15581-1-git-send-email-jic23@cam.ac.uk>
References: <1316600162-15581-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Not always a ring so naming is missleading.
Also, kfifo_buf is probably first buffer to take out of staging and it
definitely isn't a ring.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16201_ring.c |    4 ++--
 drivers/staging/iio/accel/adis16203_ring.c |    4 ++--
 drivers/staging/iio/accel/adis16204_ring.c |    4 ++--
 drivers/staging/iio/accel/adis16209_ring.c |    4 ++--
 drivers/staging/iio/accel/adis16240_ring.c |    4 ++--
 drivers/staging/iio/accel/lis3l02dq_ring.c |    4 ++--
 drivers/staging/iio/adc/ad7192.c           |    4 ++--
 drivers/staging/iio/adc/ad7298_ring.c      |    4 ++--
 drivers/staging/iio/adc/ad7476_ring.c      |    4 ++--
 drivers/staging/iio/adc/ad7606_ring.c      |    4 ++--
 drivers/staging/iio/adc/ad7793.c           |    4 ++--
 drivers/staging/iio/adc/ad7887_ring.c      |    4 ++--
 drivers/staging/iio/adc/ad799x_ring.c      |    4 ++--
 drivers/staging/iio/adc/max1363_ring.c     |    4 ++--
 drivers/staging/iio/gyro/adis16260_ring.c  |    4 ++--
 drivers/staging/iio/imu/adis16400_ring.c   |    4 ++--
 drivers/staging/iio/industrialio-trigger.c |    8 ++++----
 drivers/staging/iio/meter/ade7758_ring.c   |    4 ++--
 drivers/staging/iio/trigger_consumer.h     |    4 ++--
 19 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_ring.c b/drivers/staging/iio/accel/adis16201_ring.c
index 1c1f35d..47be20a 100644
--- a/drivers/staging/iio/accel/adis16201_ring.c
+++ b/drivers/staging/iio/accel/adis16201_ring.c
@@ -99,8 +99,8 @@ void adis16201_unconfigure_ring(struct iio_dev *indio_dev)
 
 static const struct iio_ring_setup_ops adis16201_ring_setup_ops = {
 	.preenable = &iio_sw_ring_preenable,
-	.postenable = &iio_triggered_ring_postenable,
-	.predisable = &iio_triggered_ring_predisable,
+	.postenable = &iio_triggered_buffer_postenable,
+	.predisable = &iio_triggered_buffer_predisable,
 };
 
 int adis16201_configure_ring(struct iio_dev *indio_dev)
diff --git a/drivers/staging/iio/accel/adis16203_ring.c b/drivers/staging/iio/accel/adis16203_ring.c
index d7d692c..d86f86d 100644
--- a/drivers/staging/iio/accel/adis16203_ring.c
+++ b/drivers/staging/iio/accel/adis16203_ring.c
@@ -101,8 +101,8 @@ void adis16203_unconfigure_ring(struct iio_dev *indio_dev)
 
 static const struct iio_ring_setup_ops adis16203_ring_setup_ops = {
 	.preenable = &iio_sw_ring_preenable,
-	.postenable = &iio_triggered_ring_postenable,
-	.predisable = &iio_triggered_ring_predisable,
+	.postenable = &iio_triggered_buffer_postenable,
+	.predisable = &iio_triggered_buffer_predisable,
 };
 
 int adis16203_configure_ring(struct iio_dev *indio_dev)
diff --git a/drivers/staging/iio/accel/adis16204_ring.c b/drivers/staging/iio/accel/adis16204_ring.c
index 273293a..8cc1499 100644
--- a/drivers/staging/iio/accel/adis16204_ring.c
+++ b/drivers/staging/iio/accel/adis16204_ring.c
@@ -96,8 +96,8 @@ void adis16204_unconfigure_ring(struct iio_dev *indio_dev)
 
 static const struct iio_ring_setup_ops adis16204_ring_setup_ops = {
 	.preenable = &iio_sw_ring_preenable,
-	.postenable = &iio_triggered_ring_postenable,
-	.predisable = &iio_triggered_ring_predisable,
+	.postenable = &iio_triggered_buffer_postenable,
+	.predisable = &iio_triggered_buffer_predisable,
 };
 
 int adis16204_configure_ring(struct iio_dev *indio_dev)
diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index bc654e2..941fc5a 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -96,8 +96,8 @@ void adis16209_unconfigure_ring(struct iio_dev *indio_dev)
 
 static const struct iio_ring_setup_ops adis16209_ring_setup_ops = {
 	.preenable = &iio_sw_ring_preenable,
-	.postenable = &iio_triggered_ring_postenable,
-	.predisable = &iio_triggered_ring_predisable,
+	.postenable = &iio_triggered_buffer_postenable,
+	.predisable = &iio_triggered_buffer_predisable,
 };
 
 int adis16209_configure_ring(struct iio_dev *indio_dev)
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index b41e24f..e52ad2e 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -93,8 +93,8 @@ void adis16240_unconfigure_ring(struct iio_dev *indio_dev)
 
 static const struct iio_ring_setup_ops adis16240_ring_setup_ops = {
 	.preenable = &iio_sw_ring_preenable,
-	.postenable = &iio_triggered_ring_postenable,
-	.predisable = &iio_triggered_ring_predisable,
+	.postenable = &iio_triggered_buffer_postenable,
+	.predisable = &iio_triggered_buffer_predisable,
 };
 
 int adis16240_configure_ring(struct iio_dev *indio_dev)
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index c816933..eaecda4 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -386,7 +386,7 @@ static int lis3l02dq_ring_postenable(struct iio_dev *indio_dev)
 	if (ret)
 		goto error_ret;
 
-	return iio_triggered_ring_postenable(indio_dev);
+	return iio_triggered_buffer_postenable(indio_dev);
 error_ret:
 	return ret;
 }
@@ -397,7 +397,7 @@ static int lis3l02dq_ring_predisable(struct iio_dev *indio_dev)
 	u8 t;
 	int ret;
 
-	ret = iio_triggered_ring_predisable(indio_dev);
+	ret = iio_triggered_buffer_predisable(indio_dev);
 	if (ret)
 		goto error_ret;
 
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 5a389b8..3f4e911 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -564,8 +564,8 @@ static irqreturn_t ad7192_trigger_handler(int irq, void *p)
 
 static const struct iio_ring_setup_ops ad7192_ring_setup_ops = {
 	.preenable = &ad7192_ring_preenable,
-	.postenable = &iio_triggered_ring_postenable,
-	.predisable = &iio_triggered_ring_predisable,
+	.postenable = &iio_triggered_buffer_postenable,
+	.predisable = &iio_triggered_buffer_predisable,
 	.postdisable = &ad7192_ring_postdisable,
 };
 
diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
index 246b2e7..9c5ac9d 100644
--- a/drivers/staging/iio/adc/ad7298_ring.c
+++ b/drivers/staging/iio/adc/ad7298_ring.c
@@ -145,8 +145,8 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
 
 static const struct iio_ring_setup_ops ad7298_ring_setup_ops = {
 	.preenable = &ad7298_ring_preenable,
-	.postenable = &iio_triggered_ring_postenable,
-	.predisable = &iio_triggered_ring_predisable,
+	.postenable = &iio_triggered_buffer_postenable,
+	.predisable = &iio_triggered_buffer_predisable,
 };
 
 int ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev)
diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
index b109afb..3cc673c 100644
--- a/drivers/staging/iio/adc/ad7476_ring.c
+++ b/drivers/staging/iio/adc/ad7476_ring.c
@@ -107,8 +107,8 @@ done:
 
 static const struct iio_ring_setup_ops ad7476_ring_setup_ops = {
 	.preenable = &ad7476_ring_preenable,
-	.postenable = &iio_triggered_ring_postenable,
-	.predisable = &iio_triggered_ring_predisable,
+	.postenable = &iio_triggered_buffer_postenable,
+	.predisable = &iio_triggered_buffer_predisable,
 };
 
 int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev)
diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index e642430..320ec68 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -149,8 +149,8 @@ done:
 
 static const struct iio_ring_setup_ops ad7606_ring_setup_ops = {
 	.preenable = &ad7606_ring_preenable,
-	.postenable = &iio_triggered_ring_postenable,
-	.predisable = &iio_triggered_ring_predisable,
+	.postenable = &iio_triggered_buffer_postenable,
+	.predisable = &iio_triggered_buffer_predisable,
 };
 
 int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 7044ed2..565199d 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -430,8 +430,8 @@ static irqreturn_t ad7793_trigger_handler(int irq, void *p)
 
 static const struct iio_ring_setup_ops ad7793_ring_setup_ops = {
 	.preenable = &ad7793_ring_preenable,
-	.postenable = &iio_triggered_ring_postenable,
-	.predisable = &iio_triggered_ring_predisable,
+	.postenable = &iio_triggered_buffer_postenable,
+	.predisable = &iio_triggered_buffer_predisable,
 	.postdisable = &ad7793_ring_postdisable,
 };
 
diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
index 36e118c..159aeb1 100644
--- a/drivers/staging/iio/adc/ad7887_ring.c
+++ b/drivers/staging/iio/adc/ad7887_ring.c
@@ -149,8 +149,8 @@ done:
 
 static const struct iio_ring_setup_ops ad7887_ring_setup_ops = {
 	.preenable = &ad7887_ring_preenable,
-	.postenable = &iio_triggered_ring_postenable,
-	.predisable = &iio_triggered_ring_predisable,
+	.postenable = &iio_triggered_buffer_postenable,
+	.predisable = &iio_triggered_buffer_predisable,
 	.postdisable = &ad7887_ring_postdisable,
 };
 
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index 438e81d..7b6488d 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -155,8 +155,8 @@ out:
 
 static const struct iio_ring_setup_ops ad799x_buf_setup_ops = {
 	.preenable = &ad799x_ring_preenable,
-	.postenable = &iio_triggered_ring_postenable,
-	.predisable = &iio_triggered_ring_predisable,
+	.postenable = &iio_triggered_buffer_postenable,
+	.predisable = &iio_triggered_buffer_predisable,
 };
 
 int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev)
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index abe9e03..ef1c95f 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -150,9 +150,9 @@ done:
 }
 
 static const struct iio_ring_setup_ops max1363_ring_setup_ops = {
-	.postenable = &iio_triggered_ring_postenable,
+	.postenable = &iio_triggered_buffer_postenable,
 	.preenable = &max1363_ring_preenable,
-	.predisable = &iio_triggered_ring_predisable,
+	.predisable = &iio_triggered_buffer_predisable,
 };
 
 int max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev)
diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index 40226f7..2b1c65a 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -98,8 +98,8 @@ void adis16260_unconfigure_ring(struct iio_dev *indio_dev)
 
 static const struct iio_ring_setup_ops adis16260_ring_setup_ops = {
 	.preenable = &iio_sw_ring_preenable,
-	.postenable = &iio_triggered_ring_postenable,
-	.predisable = &iio_triggered_ring_predisable,
+	.postenable = &iio_triggered_buffer_postenable,
+	.predisable = &iio_triggered_buffer_predisable,
 };
 
 int adis16260_configure_ring(struct iio_dev *indio_dev)
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index af25697..421a9fa 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -168,8 +168,8 @@ void adis16400_unconfigure_ring(struct iio_dev *indio_dev)
 
 static const struct iio_ring_setup_ops adis16400_ring_setup_ops = {
 	.preenable = &iio_sw_ring_preenable,
-	.postenable = &iio_triggered_ring_postenable,
-	.predisable = &iio_triggered_ring_predisable,
+	.postenable = &iio_triggered_buffer_postenable,
+	.predisable = &iio_triggered_buffer_predisable,
 };
 
 int adis16400_configure_ring(struct iio_dev *indio_dev)
diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index a66dcf7..00d0e0c 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -488,20 +488,20 @@ void iio_device_unregister_trigger_consumer(struct iio_dev *dev_info)
 		iio_put_trigger(dev_info->trig);
 }
 
-int iio_triggered_ring_postenable(struct iio_dev *indio_dev)
+int iio_triggered_buffer_postenable(struct iio_dev *indio_dev)
 {
 	return indio_dev->trig
 		? iio_trigger_attach_poll_func(indio_dev->trig,
 					       indio_dev->pollfunc)
 		: 0;
 }
-EXPORT_SYMBOL(iio_triggered_ring_postenable);
+EXPORT_SYMBOL(iio_triggered_buffer_postenable);
 
-int iio_triggered_ring_predisable(struct iio_dev *indio_dev)
+int iio_triggered_buffer_predisable(struct iio_dev *indio_dev)
 {
 	return indio_dev->trig
 		? iio_trigger_dettach_poll_func(indio_dev->trig,
 						indio_dev->pollfunc)
 		: 0;
 }
-EXPORT_SYMBOL(iio_triggered_ring_predisable);
+EXPORT_SYMBOL(iio_triggered_buffer_predisable);
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index 9934f50..ece2a40 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -121,8 +121,8 @@ static int ade7758_ring_preenable(struct iio_dev *indio_dev)
 
 static const struct iio_ring_setup_ops ade7758_ring_setup_ops = {
 	.preenable = &ade7758_ring_preenable,
-	.postenable = &iio_triggered_ring_postenable,
-	.predisable = &iio_triggered_ring_predisable,
+	.postenable = &iio_triggered_buffer_postenable,
+	.predisable = &iio_triggered_buffer_predisable,
 };
 
 void ade7758_unconfigure_ring(struct iio_dev *indio_dev)
diff --git a/drivers/staging/iio/trigger_consumer.h b/drivers/staging/iio/trigger_consumer.h
index 418e0bd..60d64b3 100644
--- a/drivers/staging/iio/trigger_consumer.h
+++ b/drivers/staging/iio/trigger_consumer.h
@@ -48,5 +48,5 @@ void iio_trigger_notify_done(struct iio_trigger *trig);
  * Two functions for common case where all that happens is a pollfunc
  * is attached and detached from a trigger
  */
-int iio_triggered_ring_postenable(struct iio_dev *indio_dev);
-int iio_triggered_ring_predisable(struct iio_dev *indio_dev);
+int iio_triggered_buffer_postenable(struct iio_dev *indio_dev);
+int iio_triggered_buffer_predisable(struct iio_dev *indio_dev);
-- 
1.7.3.4
