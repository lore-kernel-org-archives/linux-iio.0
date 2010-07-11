Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: gregkh@suse.de
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 07/12] staging:iio: Add stubs for iio_ring_buffer_[un]register and equivalent driver stubs
Date: Sun, 11 Jul 2010 16:39:14 +0100
Message-Id: <1278862759-19028-8-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1278862759-19028-1-git-send-email-jic23@cam.ac.uk>
References: <1278862759-19028-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Barry Song <21cnbao@gmail.com>
---
 drivers/staging/iio/accel/adis16209.h      |   11 -----------
 drivers/staging/iio/accel/adis16209_core.c |    7 ++++---
 drivers/staging/iio/accel/adis16209_ring.c |   10 ----------
 drivers/staging/iio/accel/adis16240.h      |   11 -----------
 drivers/staging/iio/accel/adis16240_core.c |    7 ++++---
 drivers/staging/iio/accel/adis16240_ring.c |    9 ---------
 drivers/staging/iio/accel/lis3l02dq.h      |    9 ---------
 drivers/staging/iio/accel/lis3l02dq_core.c |    7 ++++---
 drivers/staging/iio/accel/lis3l02dq_ring.c |   10 ----------
 drivers/staging/iio/adc/max1363.h          |   13 -------------
 drivers/staging/iio/adc/max1363_core.c     |    6 +++---
 drivers/staging/iio/adc/max1363_ring.c     |   10 ----------
 drivers/staging/iio/gyro/adis16260.h       |   11 -----------
 drivers/staging/iio/gyro/adis16260_core.c  |   10 ++++------
 drivers/staging/iio/gyro/adis16260_ring.c  |   10 ----------
 drivers/staging/iio/imu/adis16300_core.c   |    7 ++++---
 drivers/staging/iio/imu/adis16300_ring.c   |    9 ---------
 drivers/staging/iio/imu/adis16350.h        |   20 --------------------
 drivers/staging/iio/imu/adis16350_core.c   |    7 ++++---
 drivers/staging/iio/imu/adis16350_ring.c   |    9 ---------
 drivers/staging/iio/imu/adis16400.h        |   11 -----------
 drivers/staging/iio/imu/adis16400_core.c   |    7 ++++---
 drivers/staging/iio/imu/adis16400_ring.c   |   10 ----------
 drivers/staging/iio/ring_generic.h         |   11 +++++++++++
 24 files changed, 42 insertions(+), 190 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209.h b/drivers/staging/iio/accel/adis16209.h
index c1d7b47..92daf6f 100644
--- a/drivers/staging/iio/accel/adis16209.h
+++ b/drivers/staging/iio/accel/adis16209.h
@@ -147,8 +147,6 @@ ssize_t adis16209_read_data_from_ring(struct device *dev,
 int adis16209_configure_ring(struct iio_dev *indio_dev);
 void adis16209_unconfigure_ring(struct iio_dev *indio_dev);
 
-int adis16209_initialize_ring(struct iio_ring_buffer *ring);
-void adis16209_uninitialize_ring(struct iio_ring_buffer *ring);
 #else /* CONFIG_IIO_RING_BUFFER */
 
 static inline void adis16209_remove_trigger(struct iio_dev *indio_dev)
@@ -177,14 +175,5 @@ static inline void adis16209_unconfigure_ring(struct iio_dev *indio_dev)
 {
 }
 
-static inline int adis16209_initialize_ring(struct iio_ring_buffer *ring)
-{
-	return 0;
-}
-
-static inline void adis16209_uninitialize_ring(struct iio_ring_buffer *ring)
-{
-}
-
 #endif /* CONFIG_IIO_RING_BUFFER */
 #endif /* SPI_ADIS16209_H_ */
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index c696160..6c6923f 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -20,6 +20,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
+#include "../ring_generic.h"
 #include "accel.h"
 #include "inclinometer.h"
 #include "../gyro/gyro.h"
@@ -520,7 +521,7 @@ static int __devinit adis16209_probe(struct spi_device *spi)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = adis16209_initialize_ring(st->indio_dev->ring);
+	ret = iio_ring_buffer_register(st->indio_dev->ring, 0);
 	if (ret) {
 		printk(KERN_ERR "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
@@ -552,7 +553,7 @@ error_unregister_line:
 	if (spi->irq)
 		iio_unregister_interrupt_line(st->indio_dev, 0);
 error_uninitialize_ring:
-	adis16209_uninitialize_ring(st->indio_dev->ring);
+	iio_ring_buffer_unregister(st->indio_dev->ring);
 error_unreg_ring_funcs:
 	adis16209_unconfigure_ring(st->indio_dev);
 error_free_dev:
@@ -581,7 +582,7 @@ static int adis16209_remove(struct spi_device *spi)
 	if (spi->irq)
 		iio_unregister_interrupt_line(indio_dev, 0);
 
-	adis16209_uninitialize_ring(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev->ring);
 	iio_device_unregister(indio_dev);
 	adis16209_unconfigure_ring(indio_dev);
 	kfree(st->tx);
diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index 5945d67..f3a9493 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -225,13 +225,3 @@ error_iio_sw_rb_free:
 	iio_sw_rb_free(indio_dev->ring);
 	return ret;
 }
-
-int adis16209_initialize_ring(struct iio_ring_buffer *ring)
-{
-	return iio_ring_buffer_register(ring, 0);
-}
-
-void adis16209_uninitialize_ring(struct iio_ring_buffer *ring)
-{
-	iio_ring_buffer_unregister(ring);
-}
diff --git a/drivers/staging/iio/accel/adis16240.h b/drivers/staging/iio/accel/adis16240.h
index 86e0f3d..e45419a 100644
--- a/drivers/staging/iio/accel/adis16240.h
+++ b/drivers/staging/iio/accel/adis16240.h
@@ -173,8 +173,6 @@ ssize_t adis16240_read_data_from_ring(struct device *dev,
 int adis16240_configure_ring(struct iio_dev *indio_dev);
 void adis16240_unconfigure_ring(struct iio_dev *indio_dev);
 
-int adis16240_initialize_ring(struct iio_ring_buffer *ring);
-void adis16240_uninitialize_ring(struct iio_ring_buffer *ring);
 #else /* CONFIG_IIO_RING_BUFFER */
 
 static inline void adis16240_remove_trigger(struct iio_dev *indio_dev)
@@ -203,14 +201,5 @@ static inline void adis16240_unconfigure_ring(struct iio_dev *indio_dev)
 {
 }
 
-static inline int adis16240_initialize_ring(struct iio_ring_buffer *ring)
-{
-	return 0;
-}
-
-static inline void adis16240_uninitialize_ring(struct iio_ring_buffer *ring)
-{
-}
-
 #endif /* CONFIG_IIO_RING_BUFFER */
 #endif /* SPI_ADIS16240_H_ */
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index ba336cb..3e9531d 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -20,6 +20,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
+#include "../ring_generic.h"
 #include "accel.h"
 #include "../adc/adc.h"
 
@@ -502,7 +503,7 @@ static int __devinit adis16240_probe(struct spi_device *spi)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = adis16240_initialize_ring(st->indio_dev->ring);
+	ret = iio_ring_buffer_register(st->indio_dev->ring, 0);
 	if (ret) {
 		printk(KERN_ERR "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
@@ -534,7 +535,7 @@ error_unregister_line:
 	if (spi->irq)
 		iio_unregister_interrupt_line(st->indio_dev, 0);
 error_uninitialize_ring:
-	adis16240_uninitialize_ring(st->indio_dev->ring);
+	iio_ring_buffer_unregister(st->indio_dev->ring);
 error_unreg_ring_funcs:
 	adis16240_unconfigure_ring(st->indio_dev);
 error_free_dev:
@@ -563,7 +564,7 @@ static int adis16240_remove(struct spi_device *spi)
 	if (spi->irq)
 		iio_unregister_interrupt_line(indio_dev, 0);
 
-	adis16240_uninitialize_ring(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev->ring);
 	iio_device_unregister(indio_dev);
 	adis16240_unconfigure_ring(indio_dev);
 	kfree(st->tx);
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index ecf1110..a1611bb 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -214,12 +214,3 @@ error_iio_sw_rb_free:
 	return ret;
 }
 
-int adis16240_initialize_ring(struct iio_ring_buffer *ring)
-{
-	return iio_ring_buffer_register(ring, 0);
-}
-
-void adis16240_uninitialize_ring(struct iio_ring_buffer *ring)
-{
-	iio_ring_buffer_unregister(ring);
-}
diff --git a/drivers/staging/iio/accel/lis3l02dq.h b/drivers/staging/iio/accel/lis3l02dq.h
index a9adae3..6de172e 100644
--- a/drivers/staging/iio/accel/lis3l02dq.h
+++ b/drivers/staging/iio/accel/lis3l02dq.h
@@ -195,8 +195,6 @@ ssize_t lis3l02dq_read_accel_from_ring(struct device *dev,
 int lis3l02dq_configure_ring(struct iio_dev *indio_dev);
 void lis3l02dq_unconfigure_ring(struct iio_dev *indio_dev);
 
-int lis3l02dq_initialize_ring(struct iio_ring_buffer *ring);
-void lis3l02dq_uninitialize_ring(struct iio_ring_buffer *ring);
 #else /* CONFIG_IIO_RING_BUFFER */
 
 static inline void lis3l02dq_remove_trigger(struct iio_dev *indio_dev)
@@ -222,12 +220,5 @@ static int lis3l02dq_configure_ring(struct iio_dev *indio_dev)
 static inline void lis3l02dq_unconfigure_ring(struct iio_dev *indio_dev)
 {
 }
-static inline int lis3l02dq_initialize_ring(struct iio_ring_buffer *ring)
-{
-	return 0;
-}
-static inline void lis3l02dq_uninitialize_ring(struct iio_ring_buffer *ring)
-{
-}
 #endif /* CONFIG_IIO_RING_BUFFER */
 #endif /* SPI_LIS3L02DQ_H_ */
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 4034869..f86ffb8 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -27,6 +27,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
+#include "../ring_generic.h"
 #include "accel.h"
 
 #include "lis3l02dq.h"
@@ -791,7 +792,7 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = lis3l02dq_initialize_ring(st->indio_dev->ring);
+	ret = iio_ring_buffer_register(st->indio_dev->ring, 0);
 	if (ret) {
 		printk(KERN_ERR "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
@@ -825,7 +826,7 @@ error_unregister_line:
 	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
 		iio_unregister_interrupt_line(st->indio_dev, 0);
 error_uninitialize_ring:
-	lis3l02dq_uninitialize_ring(st->indio_dev->ring);
+	iio_ring_buffer_unregister(st->indio_dev->ring);
 error_unreg_ring_funcs:
 	lis3l02dq_unconfigure_ring(st->indio_dev);
 error_free_dev:
@@ -886,7 +887,7 @@ static int lis3l02dq_remove(struct spi_device *spi)
 	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
 		iio_unregister_interrupt_line(indio_dev, 0);
 
-	lis3l02dq_uninitialize_ring(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev->ring);
 	lis3l02dq_unconfigure_ring(indio_dev);
 	iio_device_unregister(indio_dev);
 	kfree(st->tx);
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 28d95ed..a506dab 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -559,15 +559,5 @@ error_iio_sw_rb_free:
 	return ret;
 }
 
-int lis3l02dq_initialize_ring(struct iio_ring_buffer *ring)
-{
-	return iio_ring_buffer_register(ring, 0);
-}
-
-void lis3l02dq_uninitialize_ring(struct iio_ring_buffer *ring)
-{
-	iio_ring_buffer_unregister(ring);
-}
-
 
 
diff --git a/drivers/staging/iio/adc/max1363.h b/drivers/staging/iio/adc/max1363.h
index bd35509..8f0fe1c 100644
--- a/drivers/staging/iio/adc/max1363.h
+++ b/drivers/staging/iio/adc/max1363.h
@@ -230,26 +230,13 @@ int max1363_single_channel_from_ring(long mask, struct max1363_state *st);
 int max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev);
 void max1363_ring_cleanup(struct iio_dev *indio_dev);
 
-int max1363_initialize_ring(struct iio_ring_buffer *ring);
-void max1363_uninitialize_ring(struct iio_ring_buffer *ring);
-
 #else /* CONFIG_MAX1363_RING_BUFFER */
 
-static inline void max1363_uninitialize_ring(struct iio_ring_buffer *ring)
-{
-}
-
-static inline int max1363_initialize_ring(struct iio_ring_buffer *ring)
-{
-	return 0;
-}
-
 int max1363_single_channel_from_ring(long mask, struct max1363_state *st)
 {
 	return -EINVAL;
 }
 
-
 static inline int
 max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 {
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index c23485f..6435e50 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -1653,7 +1653,7 @@ static int __devinit max1363_probe(struct i2c_client *client,
 	if (ret)
 		goto error_cleanup_ring;
 	regdone = 1;
-	ret = max1363_initialize_ring(st->indio_dev->ring);
+	ret = iio_ring_buffer_register(st->indio_dev->ring, 0);
 	if (ret)
 		goto error_cleanup_ring;
 
@@ -1671,7 +1671,7 @@ static int __devinit max1363_probe(struct i2c_client *client,
 
 	return 0;
 error_uninit_ring:
-	max1363_uninitialize_ring(st->indio_dev->ring);
+	iio_ring_buffer_unregister(st->indio_dev->ring);
 error_cleanup_ring:
 	max1363_ring_cleanup(st->indio_dev);
 error_free_available_scan_masks:
@@ -1700,7 +1700,7 @@ static int max1363_remove(struct i2c_client *client)
 
 	if (st->chip_info->monitor_mode && client->irq)
 		iio_unregister_interrupt_line(st->indio_dev, 0);
-	max1363_uninitialize_ring(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev->ring);
 	max1363_ring_cleanup(indio_dev);
 	kfree(st->indio_dev->available_scan_masks);
 	iio_device_unregister(indio_dev);
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index f9d5101..786b17a 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -224,13 +224,3 @@ void max1363_ring_cleanup(struct iio_dev *indio_dev)
 	kfree(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
-
-void max1363_uninitialize_ring(struct iio_ring_buffer *ring)
-{
-	iio_ring_buffer_unregister(ring);
-}
-
-int max1363_initialize_ring(struct iio_ring_buffer *ring)
-{
-	return iio_ring_buffer_register(ring, 0);
-}
diff --git a/drivers/staging/iio/gyro/adis16260.h b/drivers/staging/iio/gyro/adis16260.h
index 53f5fbd..9f868b5 100644
--- a/drivers/staging/iio/gyro/adis16260.h
+++ b/drivers/staging/iio/gyro/adis16260.h
@@ -130,8 +130,6 @@ ssize_t adis16260_read_data_from_ring(struct device *dev,
 int adis16260_configure_ring(struct iio_dev *indio_dev);
 void adis16260_unconfigure_ring(struct iio_dev *indio_dev);
 
-int adis16260_initialize_ring(struct iio_ring_buffer *ring);
-void adis16260_uninitialize_ring(struct iio_ring_buffer *ring);
 #else /* CONFIG_IIO_RING_BUFFER */
 
 static inline void adis16260_remove_trigger(struct iio_dev *indio_dev)
@@ -160,14 +158,5 @@ static inline void adis16260_unconfigure_ring(struct iio_dev *indio_dev)
 {
 }
 
-static inline int adis16260_initialize_ring(struct iio_ring_buffer *ring)
-{
-	return 0;
-}
-
-static inline void adis16260_uninitialize_ring(struct iio_ring_buffer *ring)
-{
-}
-
 #endif /* CONFIG_IIO_RING_BUFFER */
 #endif /* SPI_ADIS16260_H_ */
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index f0246a4..134dfaa 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -20,6 +20,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
+#include "../ring_generic.h"
 #include "../adc/adc.h"
 #include "gyro.h"
 
@@ -555,8 +556,7 @@ static int __devinit adis16260_probe(struct spi_device *spi)
 	if (ret)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
-
-	ret = adis16260_initialize_ring(st->indio_dev->ring);
+	ret = iio_ring_buffer_register(st->indio_dev->ring, 0);
 	if (ret) {
 		printk(KERN_ERR "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
@@ -588,7 +588,7 @@ error_unregister_line:
 	if (spi->irq)
 		iio_unregister_interrupt_line(st->indio_dev, 0);
 error_uninitialize_ring:
-	adis16260_uninitialize_ring(st->indio_dev->ring);
+	iio_ring_buffer_unregister(st->indio_dev->ring);
 error_unreg_ring_funcs:
 	adis16260_unconfigure_ring(st->indio_dev);
 error_free_dev:
@@ -622,15 +622,13 @@ static int adis16260_remove(struct spi_device *spi)
 	if (spi->irq)
 		iio_unregister_interrupt_line(indio_dev, 0);
 
-	adis16260_uninitialize_ring(indio_dev->ring);
+	iio_ring_buffer_unregister(st->indio_dev->ring);
 	iio_device_unregister(indio_dev);
 	adis16260_unconfigure_ring(indio_dev);
 	kfree(st->tx);
 	kfree(st->rx);
 	kfree(st);
 
-	return 0;
-
 err_ret:
 	return ret;
 }
diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index 57ebc8c..94b4515 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -215,13 +215,3 @@ error_iio_sw_rb_free:
 	iio_sw_rb_free(indio_dev->ring);
 	return ret;
 }
-
-int adis16260_initialize_ring(struct iio_ring_buffer *ring)
-{
-	return iio_ring_buffer_register(ring, 0);
-}
-
-void adis16260_uninitialize_ring(struct iio_ring_buffer *ring)
-{
-	iio_ring_buffer_unregister(ring);
-}
diff --git a/drivers/staging/iio/imu/adis16300_core.c b/drivers/staging/iio/imu/adis16300_core.c
index 28667e8..f1950d5 100644
--- a/drivers/staging/iio/imu/adis16300_core.c
+++ b/drivers/staging/iio/imu/adis16300_core.c
@@ -20,6 +20,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
+#include "../ring_generic.h"
 #include "../accel/accel.h"
 #include "../accel/inclinometer.h"
 #include "../gyro/gyro.h"
@@ -644,7 +645,7 @@ static int __devinit adis16300_probe(struct spi_device *spi)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = adis16300_initialize_ring(st->indio_dev->ring);
+	ret = iio_ring_buffer_register(st->indio_dev->ring, 0);
 	if (ret) {
 		printk(KERN_ERR "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
@@ -676,7 +677,7 @@ error_unregister_line:
 	if (spi->irq)
 		iio_unregister_interrupt_line(st->indio_dev, 0);
 error_uninitialize_ring:
-	adis16300_uninitialize_ring(st->indio_dev->ring);
+	iio_ring_buffer_unregister(st->indio_dev->ring);
 error_unreg_ring_funcs:
 	adis16300_unconfigure_ring(st->indio_dev);
 error_free_dev:
@@ -710,7 +711,7 @@ static int adis16300_remove(struct spi_device *spi)
 	if (spi->irq)
 		iio_unregister_interrupt_line(indio_dev, 0);
 
-	adis16300_uninitialize_ring(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev->ring);
 	iio_device_unregister(indio_dev);
 	adis16300_unconfigure_ring(indio_dev);
 	kfree(st->tx);
diff --git a/drivers/staging/iio/imu/adis16300_ring.c b/drivers/staging/iio/imu/adis16300_ring.c
index a76d43c..3bf9904 100644
--- a/drivers/staging/iio/imu/adis16300_ring.c
+++ b/drivers/staging/iio/imu/adis16300_ring.c
@@ -241,12 +241,3 @@ error_iio_sw_rb_free:
 	return ret;
 }
 
-int adis16300_initialize_ring(struct iio_ring_buffer *ring)
-{
-	return iio_ring_buffer_register(ring, 0);
-}
-
-void adis16300_uninitialize_ring(struct iio_ring_buffer *ring)
-{
-	iio_ring_buffer_unregister(ring);
-}
diff --git a/drivers/staging/iio/imu/adis16350.h b/drivers/staging/iio/imu/adis16350.h
index b4533a0..d94f6ab 100644
--- a/drivers/staging/iio/imu/adis16350.h
+++ b/drivers/staging/iio/imu/adis16350.h
@@ -148,8 +148,6 @@ ssize_t adis16350_read_data_from_ring(struct device *dev,
 int adis16350_configure_ring(struct iio_dev *indio_dev);
 void adis16350_unconfigure_ring(struct iio_dev *indio_dev);
 
-int adis16350_initialize_ring(struct iio_ring_buffer *ring);
-void adis16350_uninitialize_ring(struct iio_ring_buffer *ring);
 #else /* CONFIG_IIO_RING_BUFFER */
 
 static inline void adis16350_remove_trigger(struct iio_dev *indio_dev)
@@ -169,23 +167,5 @@ adis16350_read_data_from_ring(struct device *dev,
 	return 0;
 }
 
-static int adis16350_configure_ring(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-
-static inline void adis16350_unconfigure_ring(struct iio_dev *indio_dev)
-{
-}
-
-static inline int adis16350_initialize_ring(struct iio_ring_buffer *ring)
-{
-	return 0;
-}
-
-static inline void adis16350_uninitialize_ring(struct iio_ring_buffer *ring)
-{
-}
-
 #endif /* CONFIG_IIO_RING_BUFFER */
 #endif /* SPI_ADIS16350_H_ */
diff --git a/drivers/staging/iio/imu/adis16350_core.c b/drivers/staging/iio/imu/adis16350_core.c
index 0bb19a9..1575b7b 100644
--- a/drivers/staging/iio/imu/adis16350_core.c
+++ b/drivers/staging/iio/imu/adis16350_core.c
@@ -20,6 +20,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
+#include "../ring_generic.h"
 #include "../accel/accel.h"
 #include "../adc/adc.h"
 #include "../gyro/gyro.h"
@@ -619,7 +620,7 @@ static int __devinit adis16350_probe(struct spi_device *spi)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = adis16350_initialize_ring(st->indio_dev->ring);
+	ret = iio_ring_buffer_register(st->indio_dev->ring, 0);
 	if (ret) {
 		printk(KERN_ERR "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
@@ -651,7 +652,7 @@ error_unregister_line:
 	if (spi->irq)
 		iio_unregister_interrupt_line(st->indio_dev, 0);
 error_uninitialize_ring:
-	adis16350_uninitialize_ring(st->indio_dev->ring);
+	iio_ring_buffer_unregister(st->indio_dev->ring);
 error_unreg_ring_funcs:
 	adis16350_unconfigure_ring(st->indio_dev);
 error_free_dev:
@@ -685,7 +686,7 @@ static int adis16350_remove(struct spi_device *spi)
 	if (spi->irq)
 		iio_unregister_interrupt_line(indio_dev, 0);
 
-	adis16350_uninitialize_ring(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev->ring);
 	iio_device_unregister(indio_dev);
 	adis16350_unconfigure_ring(indio_dev);
 	kfree(st->tx);
diff --git a/drivers/staging/iio/imu/adis16350_ring.c b/drivers/staging/iio/imu/adis16350_ring.c
index ca4f685..319aa34 100644
--- a/drivers/staging/iio/imu/adis16350_ring.c
+++ b/drivers/staging/iio/imu/adis16350_ring.c
@@ -246,12 +246,3 @@ error_iio_sw_rb_free:
 	return ret;
 }
 
-int adis16350_initialize_ring(struct iio_ring_buffer *ring)
-{
-	return iio_ring_buffer_register(ring, 0);
-}
-
-void adis16350_uninitialize_ring(struct iio_ring_buffer *ring)
-{
-	iio_ring_buffer_unregister(ring);
-}
diff --git a/drivers/staging/iio/imu/adis16400.h b/drivers/staging/iio/imu/adis16400.h
index f74faee..0685195 100644
--- a/drivers/staging/iio/imu/adis16400.h
+++ b/drivers/staging/iio/imu/adis16400.h
@@ -178,8 +178,6 @@ ssize_t adis16400_read_data_from_ring(struct device *dev,
 int adis16400_configure_ring(struct iio_dev *indio_dev);
 void adis16400_unconfigure_ring(struct iio_dev *indio_dev);
 
-int adis16400_initialize_ring(struct iio_ring_buffer *ring);
-void adis16400_uninitialize_ring(struct iio_ring_buffer *ring);
 #else /* CONFIG_IIO_RING_BUFFER */
 
 static inline void adis16400_remove_trigger(struct iio_dev *indio_dev)
@@ -208,14 +206,5 @@ static inline void adis16400_unconfigure_ring(struct iio_dev *indio_dev)
 {
 }
 
-static inline int adis16400_initialize_ring(struct iio_ring_buffer *ring)
-{
-	return 0;
-}
-
-static inline void adis16400_uninitialize_ring(struct iio_ring_buffer *ring)
-{
-}
-
 #endif /* CONFIG_IIO_RING_BUFFER */
 #endif /* SPI_ADIS16400_H_ */
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 160585f..6013fee 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -27,6 +27,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
+#include "../ring_generic.h"
 #include "../accel/accel.h"
 #include "../adc/adc.h"
 #include "../gyro/gyro.h"
@@ -641,7 +642,7 @@ static int __devinit adis16400_probe(struct spi_device *spi)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = adis16400_initialize_ring(st->indio_dev->ring);
+	ret = iio_ring_buffer_register(st->indio_dev->ring, 0);
 	if (ret) {
 		printk(KERN_ERR "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
@@ -674,7 +675,7 @@ error_unregister_line:
 	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
 		iio_unregister_interrupt_line(st->indio_dev, 0);
 error_uninitialize_ring:
-	adis16400_uninitialize_ring(st->indio_dev->ring);
+	iio_ring_buffer_unregister(st->indio_dev->ring);
 error_unreg_ring_funcs:
 	adis16400_unconfigure_ring(st->indio_dev);
 error_free_dev:
@@ -709,7 +710,7 @@ static int adis16400_remove(struct spi_device *spi)
 	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
 		iio_unregister_interrupt_line(indio_dev, 0);
 
-	adis16400_uninitialize_ring(indio_dev->ring);
+	iio_ring_buffer_unregister(st->indio_dev->ring);
 	adis16400_unconfigure_ring(indio_dev);
 	iio_device_unregister(indio_dev);
 	kfree(st->tx);
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index 59d62a7..c7744ef 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -252,13 +252,3 @@ error_iio_sw_rb_free:
 	iio_sw_rb_free(indio_dev->ring);
 	return ret;
 }
-
-int adis16400_initialize_ring(struct iio_ring_buffer *ring)
-{
-	return iio_ring_buffer_register(ring, 0);
-}
-
-void adis16400_uninitialize_ring(struct iio_ring_buffer *ring)
-{
-	iio_ring_buffer_unregister(ring);
-}
diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
index 0e44375..dbf11e1 100644
--- a/drivers/staging/iio/ring_generic.h
+++ b/drivers/staging/iio/ring_generic.h
@@ -11,6 +11,8 @@
 #define _IIO_RING_GENERIC_H_
 #include "iio.h"
 
+#ifdef CONFIG_IIO_RING_BUFFER
+
 struct iio_handler;
 struct iio_ring_buffer;
 struct iio_dev;
@@ -287,5 +289,14 @@ ssize_t iio_show_ring_enable(struct device *dev,
 #define IIO_RING_ENABLE_ATTR DEVICE_ATTR(ring_enable, S_IRUGO | S_IWUSR, \
 					 iio_show_ring_enable,		\
 					 iio_store_ring_enable)
+#else /* CONFIG_IIO_RING_BUFFER */
+static inline int iio_ring_buffer_register(struct iio_ring_buffer *ring, int id)
+{
+	return 0;
+};
+static inline void iio_ring_buffer_unregister(struct iio_ring_buffer *ring)
+{};
+
+#endif /* CONFIG_IIO_RING_BUFFER */
 
 #endif /* _IIO_RING_GENERIC_H_ */
-- 
1.7.0.4
