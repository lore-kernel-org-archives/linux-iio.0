Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 04/12] staging:iio:various move default scan mask setting after ring register or remove
Date: Fri, 26 Aug 2011 11:16:27 +0100
Message-Id: <1314353795-7437-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314353795-7437-1-git-send-email-jic23@cam.ac.uk>
References: <1314353795-7437-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

The scan mask will be dynamically assigned in register, so don't
use it before that.

In adis16260 I've moved it as I know this driver has userspace code.
Same for sca3000 where it is cost free due to hardware buffer.
Can do that for the others, but in theory userspace code should always
have been checking these and setting them appropriately anyway!

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16201_ring.c |    9 ---------
 drivers/staging/iio/accel/adis16203_ring.c |    7 -------
 drivers/staging/iio/accel/adis16204_ring.c |    7 -------
 drivers/staging/iio/accel/adis16209_ring.c |   10 ----------
 drivers/staging/iio/accel/adis16240_ring.c |    8 --------
 drivers/staging/iio/accel/lis3l02dq_ring.c |    5 -----
 drivers/staging/iio/accel/sca3000_core.c   |    6 ++++++
 drivers/staging/iio/accel/sca3000_ring.c   |    4 ----
 drivers/staging/iio/gyro/adis16260_core.c  |    9 ++++++++-
 drivers/staging/iio/gyro/adis16260_ring.c  |    7 -------
 10 files changed, 14 insertions(+), 58 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_ring.c b/drivers/staging/iio/accel/adis16201_ring.c
index 4b433c5..1c1f35d 100644
--- a/drivers/staging/iio/accel/adis16201_ring.c
+++ b/drivers/staging/iio/accel/adis16201_ring.c
@@ -121,15 +121,6 @@ int adis16201_configure_ring(struct iio_dev *indio_dev)
 	ring->setup_ops = &adis16201_ring_setup_ops;
 	ring->owner = THIS_MODULE;
 
-	/* Set default scan mode */
-	iio_scan_mask_set(ring,	ADIS16201_SCAN_SUPPLY);
-	iio_scan_mask_set(ring, ADIS16201_SCAN_ACC_X);
-	iio_scan_mask_set(ring, ADIS16201_SCAN_ACC_Y);
-	iio_scan_mask_set(ring, ADIS16201_SCAN_AUX_ADC);
-	iio_scan_mask_set(ring, ADIS16201_SCAN_TEMP);
-	iio_scan_mask_set(ring, ADIS16201_SCAN_INCLI_X);
-	iio_scan_mask_set(ring, ADIS16201_SCAN_INCLI_Y);
-
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
 						 &adis16201_trigger_handler,
 						 IRQF_ONESHOT,
diff --git a/drivers/staging/iio/accel/adis16203_ring.c b/drivers/staging/iio/accel/adis16203_ring.c
index 993e239..d7d692c 100644
--- a/drivers/staging/iio/accel/adis16203_ring.c
+++ b/drivers/staging/iio/accel/adis16203_ring.c
@@ -123,13 +123,6 @@ int adis16203_configure_ring(struct iio_dev *indio_dev)
 	ring->setup_ops = &adis16203_ring_setup_ops;
 	ring->owner = THIS_MODULE;
 
-	/* Set default scan mode */
-	iio_scan_mask_set(ring, ADIS16203_SCAN_SUPPLY);
-	iio_scan_mask_set(ring, ADIS16203_SCAN_TEMP);
-	iio_scan_mask_set(ring, ADIS16203_SCAN_AUX_ADC);
-	iio_scan_mask_set(ring, ADIS16203_SCAN_INCLI_X);
-	iio_scan_mask_set(ring, ADIS16203_SCAN_INCLI_Y);
-
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
 						 &adis16203_trigger_handler,
 						 IRQF_ONESHOT,
diff --git a/drivers/staging/iio/accel/adis16204_ring.c b/drivers/staging/iio/accel/adis16204_ring.c
index 847f438..273293a 100644
--- a/drivers/staging/iio/accel/adis16204_ring.c
+++ b/drivers/staging/iio/accel/adis16204_ring.c
@@ -118,13 +118,6 @@ int adis16204_configure_ring(struct iio_dev *indio_dev)
 	ring->setup_ops = &adis16204_ring_setup_ops;
 	ring->owner = THIS_MODULE;
 
-	/* Set default scan mode */
-	iio_scan_mask_set(ring, ADIS16204_SCAN_SUPPLY);
-	iio_scan_mask_set(ring, ADIS16204_SCAN_ACC_X);
-	iio_scan_mask_set(ring, ADIS16204_SCAN_ACC_Y);
-	iio_scan_mask_set(ring, ADIS16204_SCAN_AUX_ADC);
-	iio_scan_mask_set(ring, ADIS16204_SCAN_TEMP);
-
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
 						 &adis16204_trigger_handler,
 						 IRQF_ONESHOT,
diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index f889fe7..bc654e2 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -118,16 +118,6 @@ int adis16209_configure_ring(struct iio_dev *indio_dev)
 	ring->setup_ops = &adis16209_ring_setup_ops;
 	ring->owner = THIS_MODULE;
 
-	/* Set default scan mode */
-	iio_scan_mask_set(ring, ADIS16209_SCAN_SUPPLY);
-	iio_scan_mask_set(ring, ADIS16209_SCAN_ACC_X);
-	iio_scan_mask_set(ring, ADIS16209_SCAN_ACC_Y);
-	iio_scan_mask_set(ring, ADIS16209_SCAN_AUX_ADC);
-	iio_scan_mask_set(ring, ADIS16209_SCAN_TEMP);
-	iio_scan_mask_set(ring, ADIS16209_SCAN_INCLI_X);
-	iio_scan_mask_set(ring, ADIS16209_SCAN_INCLI_Y);
-	iio_scan_mask_set(ring, ADIS16209_SCAN_ROT);
-
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
 						 &adis16209_trigger_handler,
 						 IRQF_ONESHOT,
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index 051ba64..b41e24f 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -115,14 +115,6 @@ int adis16240_configure_ring(struct iio_dev *indio_dev)
 	ring->setup_ops = &adis16240_ring_setup_ops;
 	ring->owner = THIS_MODULE;
 
-	/* Set default scan mode */
-	iio_scan_mask_set(ring, ADIS16240_SCAN_SUPPLY);
-	iio_scan_mask_set(ring, ADIS16240_SCAN_ACC_X);
-	iio_scan_mask_set(ring, ADIS16240_SCAN_ACC_Y);
-	iio_scan_mask_set(ring, ADIS16240_SCAN_ACC_Z);
-	iio_scan_mask_set(ring, ADIS16240_SCAN_AUX_ADC);
-	iio_scan_mask_set(ring, ADIS16240_SCAN_TEMP);
-
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
 						 &adis16240_trigger_handler,
 						 IRQF_ONESHOT,
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 5c6fe13..d67d783 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -441,11 +441,6 @@ int lis3l02dq_configure_ring(struct iio_dev *indio_dev)
 	ring->setup_ops = &lis3l02dq_ring_setup_ops;
 	ring->owner = THIS_MODULE;
 
-	/* Set default scan mode */
-	iio_scan_mask_set(ring, 0);
-	iio_scan_mask_set(ring, 1);
-	iio_scan_mask_set(ring, 2);
-
 	/* Functions are NULL as we set handler below */
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
 						 &lis3l02dq_trigger_handler,
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 0f70b53..a47a6e8 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -1160,6 +1160,12 @@ static int __devinit sca3000_probe(struct spi_device *spi)
 				       ARRAY_SIZE(sca3000_channels));
 	if (ret < 0)
 		goto error_unregister_dev;
+	if (indio_dev->ring) {
+		iio_scan_mask_set(indio_dev->ring, 0);
+		iio_scan_mask_set(indio_dev->ring, 1);
+		iio_scan_mask_set(indio_dev->ring, 2);
+	}
+
 	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0) {
 		ret = request_threaded_irq(spi->irq,
 					   NULL,
diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
index cc38521e..3d6dafa 100644
--- a/drivers/staging/iio/accel/sca3000_ring.c
+++ b/drivers/staging/iio/accel/sca3000_ring.c
@@ -294,10 +294,6 @@ int sca3000_configure_ring(struct iio_dev *indio_dev)
 
 	indio_dev->ring->access = &sca3000_ring_access_funcs;
 
-	iio_scan_mask_set(indio_dev->ring, 0);
-	iio_scan_mask_set(indio_dev->ring, 1);
-	iio_scan_mask_set(indio_dev->ring, 2);
-
 	return 0;
 }
 
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 97294de..18d2a28 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -635,7 +635,14 @@ static int __devinit adis16260_probe(struct spi_device *spi)
 		printk(KERN_ERR "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
 	}
-
+	if (indio_dev->ring) {
+		/* Set default scan mode */
+		iio_scan_mask_set(indio_dev->ring, ADIS16260_SCAN_SUPPLY);
+		iio_scan_mask_set(indio_dev->ring, ADIS16260_SCAN_GYRO);
+		iio_scan_mask_set(indio_dev->ring, ADIS16260_SCAN_AUX_ADC);
+		iio_scan_mask_set(indio_dev->ring, ADIS16260_SCAN_TEMP);
+		iio_scan_mask_set(indio_dev->ring, ADIS16260_SCAN_ANGL);
+	}
 	if (spi->irq) {
 		ret = adis16260_probe_trigger(indio_dev);
 		if (ret)
diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index 10f8a66..40226f7 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -120,13 +120,6 @@ int adis16260_configure_ring(struct iio_dev *indio_dev)
 	ring->setup_ops = &adis16260_ring_setup_ops;
 	ring->owner = THIS_MODULE;
 
-	/* Set default scan mode */
-	iio_scan_mask_set(ring, ADIS16260_SCAN_SUPPLY);
-	iio_scan_mask_set(ring, ADIS16260_SCAN_GYRO);
-	iio_scan_mask_set(ring, ADIS16260_SCAN_AUX_ADC);
-	iio_scan_mask_set(ring, ADIS16260_SCAN_TEMP);
-	iio_scan_mask_set(ring, ADIS16260_SCAN_ANGL);
-
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
 						 &adis16260_trigger_handler,
 						 IRQF_ONESHOT,
-- 
1.7.3.4
