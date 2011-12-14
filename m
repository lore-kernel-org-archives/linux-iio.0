Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:34098 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505Ab1LNV1B (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 14 Dec 2011 16:27:01 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] staging:iio:drivers stop enabling the timestamp for buffers at start time.
Date: Wed, 14 Dec 2011 21:27:05 +0000
Message-Id: <1323898025-10730-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This should always be userspace controlled and these defaults are
unpredictable and make for rather pointlessly complex code when
handling multiple buffers.

The equivalent code for setting up default channels for scans has
long since gone.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/adis16201_ring.c    |    1 -
 drivers/staging/iio/accel/adis16203_ring.c    |    1 -
 drivers/staging/iio/accel/adis16204_ring.c    |    1 -
 drivers/staging/iio/accel/adis16209_ring.c    |    1 -
 drivers/staging/iio/accel/adis16240_ring.c    |    1 -
 drivers/staging/iio/accel/lis3l02dq_ring.c    |    1 -
 drivers/staging/iio/adc/ad7298_ring.c         |    1 -
 drivers/staging/iio/adc/ad7476_ring.c         |    1 -
 drivers/staging/iio/adc/ad7606_ring.c         |    1 -
 drivers/staging/iio/adc/ad799x_ring.c         |    1 -
 drivers/staging/iio/gyro/adis16260_ring.c     |    1 -
 drivers/staging/iio/iio_simple_dummy_buffer.c |    3 ---
 drivers/staging/iio/imu/adis16400_ring.c      |    1 -
 13 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_ring.c b/drivers/staging/iio/accel/adis16201_ring.c
index 26c610f..dedfb44 100644
--- a/drivers/staging/iio/accel/adis16201_ring.c
+++ b/drivers/staging/iio/accel/adis16201_ring.c
@@ -116,7 +116,6 @@ int adis16201_configure_ring(struct iio_dev *indio_dev)
 	}
 	indio_dev->buffer = ring;
 	/* Effectively select the ring buffer implementation */
-	ring->scan_timestamp = true;
 	ring->access = &ring_sw_access_funcs;
 	indio_dev->setup_ops = &adis16201_ring_setup_ops;
 
diff --git a/drivers/staging/iio/accel/adis16203_ring.c b/drivers/staging/iio/accel/adis16203_ring.c
index 064640d..8037ae9 100644
--- a/drivers/staging/iio/accel/adis16203_ring.c
+++ b/drivers/staging/iio/accel/adis16203_ring.c
@@ -118,7 +118,6 @@ int adis16203_configure_ring(struct iio_dev *indio_dev)
 	}
 	indio_dev->buffer = ring;
 	/* Effectively select the ring buffer implementation */
-	ring->scan_timestamp = true;
 	ring->access = &ring_sw_access_funcs;
 	indio_dev->setup_ops = &adis16203_ring_setup_ops;
 
diff --git a/drivers/staging/iio/accel/adis16204_ring.c b/drivers/staging/iio/accel/adis16204_ring.c
index 4081179..56fb9d0 100644
--- a/drivers/staging/iio/accel/adis16204_ring.c
+++ b/drivers/staging/iio/accel/adis16204_ring.c
@@ -114,7 +114,6 @@ int adis16204_configure_ring(struct iio_dev *indio_dev)
 	indio_dev->buffer = ring;
 	/* Effectively select the ring buffer implementation */
 	ring->access = &ring_sw_access_funcs;
-	ring->scan_timestamp = true;
 	indio_dev->setup_ops = &adis16204_ring_setup_ops;
 
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index 2a6fd334..55f0409 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -115,7 +115,6 @@ int adis16209_configure_ring(struct iio_dev *indio_dev)
 	indio_dev->buffer = ring;
 	/* Effectively select the ring buffer implementation */
 	ring->access = &ring_sw_access_funcs;
-	ring->scan_timestamp = true;
 	indio_dev->setup_ops = &adis16209_ring_setup_ops;
 
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index e23622d..16e6431 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -112,7 +112,6 @@ int adis16240_configure_ring(struct iio_dev *indio_dev)
 	indio_dev->buffer = ring;
 	/* Effectively select the ring buffer implementation */
 	ring->access = &ring_sw_access_funcs;
-	ring->scan_timestamp = true;
 	indio_dev->setup_ops = &adis16240_ring_setup_ops;
 
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 98c5c92..6e24de1 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -409,7 +409,6 @@ int lis3l02dq_configure_buffer(struct iio_dev *indio_dev)
 	/* Effectively select the buffer implementation */
 	indio_dev->buffer->access = &lis3l02dq_access_funcs;
 
-	buffer->scan_timestamp = true;
 	indio_dev->setup_ops = &lis3l02dq_buffer_setup_ops;
 
 	/* Functions are NULL as we set handler below */
diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
index d1a12dd..d5539f8 100644
--- a/drivers/staging/iio/adc/ad7298_ring.c
+++ b/drivers/staging/iio/adc/ad7298_ring.c
@@ -148,7 +148,6 @@ int ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 
 	/* Ring buffer functions - here trigger setup related */
 	indio_dev->setup_ops = &ad7298_ring_setup_ops;
-	indio_dev->buffer->scan_timestamp = true;
 
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
index 4e298b2..7430b1f 100644
--- a/drivers/staging/iio/adc/ad7476_ring.c
+++ b/drivers/staging/iio/adc/ad7476_ring.c
@@ -115,7 +115,6 @@ int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 
 	/* Ring buffer functions - here trigger setup related */
 	indio_dev->setup_ops = &ad7476_ring_setup_ops;
-	indio_dev->buffer->scan_timestamp = true;
 
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index e8f94a1..3acccae 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -127,7 +127,6 @@ int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	/* Ring buffer functions - here trigger setup related */
 
 	indio_dev->setup_ops = &ad7606_ring_setup_ops;
-	indio_dev->buffer->scan_timestamp = true ;
 
 	INIT_WORK(&st->poll_work, &ad7606_poll_bh_to_ring);
 
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index 5dded9e..cc8115c 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -157,7 +157,6 @@ int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 
 	/* Ring buffer functions - here trigger setup related */
 	indio_dev->setup_ops = &ad799x_buf_setup_ops;
-	indio_dev->buffer->scan_timestamp = true;
 
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index 699a615..976cf6d 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -117,7 +117,6 @@ int adis16260_configure_ring(struct iio_dev *indio_dev)
 	indio_dev->buffer = ring;
 	/* Effectively select the ring buffer implementation */
 	ring->access = &ring_sw_access_funcs;
-	ring->scan_timestamp = true;
 	indio_dev->setup_ops = &adis16260_ring_setup_ops;
 
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
index d6a1c0e..4b9f1fe 100644
--- a/drivers/staging/iio/iio_simple_dummy_buffer.c
+++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
@@ -145,9 +145,6 @@ int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev)
 	/* Tell the core how to access the buffer */
 	buffer->access = &kfifo_access_funcs;
 
-	/* Enable timestamps by default */
-	buffer->scan_timestamp = true;
-
 	/*
 	 * Tell the core what device type specific functions should
 	 * be run on either side of buffer capture enable / disable.
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index ac22de5..2e634cc 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -189,7 +189,6 @@ int adis16400_configure_ring(struct iio_dev *indio_dev)
 	indio_dev->buffer = ring;
 	/* Effectively select the ring buffer implementation */
 	ring->access = &ring_sw_access_funcs;
-	ring->scan_timestamp = true;
 	indio_dev->setup_ops = &adis16400_ring_setup_ops;
 
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
-- 
1.7.7.4

