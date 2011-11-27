Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	manuel.stahl@iis.fraunhofer.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 05/16] staging:iio:buffer remove unused owner field from struct iio_buffer
Date: Sun, 27 Nov 2011 13:33:34 +0000
Message-Id: <1322400825-29400-6-git-send-email-jic23@kernel.org>
In-Reply-To: <1322400825-29400-1-git-send-email-jic23@kernel.org>
References: <1322400825-29400-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Legacy of having multiple chrdevs that never got cleaned up.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/adis16201_ring.c    |    1 -
 drivers/staging/iio/accel/adis16203_ring.c    |    1 -
 drivers/staging/iio/accel/adis16204_ring.c    |    1 -
 drivers/staging/iio/accel/adis16209_ring.c    |    1 -
 drivers/staging/iio/accel/adis16240_ring.c    |    1 -
 drivers/staging/iio/accel/lis3l02dq_ring.c    |    1 -
 drivers/staging/iio/buffer.h                  |    2 --
 drivers/staging/iio/gyro/adis16260_ring.c     |    1 -
 drivers/staging/iio/iio_simple_dummy_buffer.c |    1 -
 drivers/staging/iio/imu/adis16400_ring.c      |    1 -
 drivers/staging/iio/meter/ade7758_ring.c      |    1 -
 11 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_ring.c b/drivers/staging/iio/accel/adis16201_ring.c
index 68d4b38..26c610f 100644
--- a/drivers/staging/iio/accel/adis16201_ring.c
+++ b/drivers/staging/iio/accel/adis16201_ring.c
@@ -119,7 +119,6 @@ int adis16201_configure_ring(struct iio_dev *indio_dev)
 	ring->scan_timestamp = true;
 	ring->access = &ring_sw_access_funcs;
 	indio_dev->setup_ops = &adis16201_ring_setup_ops;
-	ring->owner = THIS_MODULE;
 
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
 						 &adis16201_trigger_handler,
diff --git a/drivers/staging/iio/accel/adis16203_ring.c b/drivers/staging/iio/accel/adis16203_ring.c
index 0f9d18a..064640d 100644
--- a/drivers/staging/iio/accel/adis16203_ring.c
+++ b/drivers/staging/iio/accel/adis16203_ring.c
@@ -121,7 +121,6 @@ int adis16203_configure_ring(struct iio_dev *indio_dev)
 	ring->scan_timestamp = true;
 	ring->access = &ring_sw_access_funcs;
 	indio_dev->setup_ops = &adis16203_ring_setup_ops;
-	ring->owner = THIS_MODULE;
 
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
 						 &adis16203_trigger_handler,
diff --git a/drivers/staging/iio/accel/adis16204_ring.c b/drivers/staging/iio/accel/adis16204_ring.c
index 8010c1d..4081179 100644
--- a/drivers/staging/iio/accel/adis16204_ring.c
+++ b/drivers/staging/iio/accel/adis16204_ring.c
@@ -116,7 +116,6 @@ int adis16204_configure_ring(struct iio_dev *indio_dev)
 	ring->access = &ring_sw_access_funcs;
 	ring->scan_timestamp = true;
 	indio_dev->setup_ops = &adis16204_ring_setup_ops;
-	ring->owner = THIS_MODULE;
 
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
 						 &adis16204_trigger_handler,
diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index 8629fea..2a6fd334 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -117,7 +117,6 @@ int adis16209_configure_ring(struct iio_dev *indio_dev)
 	ring->access = &ring_sw_access_funcs;
 	ring->scan_timestamp = true;
 	indio_dev->setup_ops = &adis16209_ring_setup_ops;
-	ring->owner = THIS_MODULE;
 
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
 						 &adis16209_trigger_handler,
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index 9a3dba2..e23622d 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -114,7 +114,6 @@ int adis16240_configure_ring(struct iio_dev *indio_dev)
 	ring->access = &ring_sw_access_funcs;
 	ring->scan_timestamp = true;
 	indio_dev->setup_ops = &adis16240_ring_setup_ops;
-	ring->owner = THIS_MODULE;
 
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
 						 &adis16240_trigger_handler,
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 4d40505..978cd4d 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -443,7 +443,6 @@ int lis3l02dq_configure_buffer(struct iio_dev *indio_dev)
 
 	buffer->scan_timestamp = true;
 	indio_dev->setup_ops = &lis3l02dq_buffer_setup_ops;
-	buffer->owner = THIS_MODULE;
 
 	/* Functions are NULL as we set handler below */
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
diff --git a/drivers/staging/iio/buffer.h b/drivers/staging/iio/buffer.h
index 7fc0894..98e9efa 100644
--- a/drivers/staging/iio/buffer.h
+++ b/drivers/staging/iio/buffer.h
@@ -68,7 +68,6 @@ struct iio_buffer_access_funcs {
 /**
  * struct iio_buffer - general buffer structure
  * @indio_dev:		industrial I/O device structure
- * @owner:		module that owns the buffer (for ref counting)
  * @length:		[DEVICE] number of datums in buffer
  * @bytes_per_datum:	[DEVICE] size of individual datum including timestamp
  * @scan_el_attrs:	[DRIVER] control of scan elements if that scan mode
@@ -83,7 +82,6 @@ struct iio_buffer_access_funcs {
  **/
 struct iio_buffer {
 	struct iio_dev				*indio_dev;
-	struct module				*owner;
 	int					length;
 	int					bytes_per_datum;
 	struct attribute_group			*scan_el_attrs;
diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index 88e96af..699a615 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -119,7 +119,6 @@ int adis16260_configure_ring(struct iio_dev *indio_dev)
 	ring->access = &ring_sw_access_funcs;
 	ring->scan_timestamp = true;
 	indio_dev->setup_ops = &adis16260_ring_setup_ops;
-	ring->owner = THIS_MODULE;
 
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
 						 &adis16260_trigger_handler,
diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
index 59e3186..d6a1c0e 100644
--- a/drivers/staging/iio/iio_simple_dummy_buffer.c
+++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
@@ -153,7 +153,6 @@ int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev)
 	 * be run on either side of buffer capture enable / disable.
 	 */
 	indio_dev->setup_ops = &iio_simple_dummy_buffer_setup_ops;
-	buffer->owner = THIS_MODULE;
 
 	/*
 	 * Configure a polling function.
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index 249d11f..ac22de5 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -191,7 +191,6 @@ int adis16400_configure_ring(struct iio_dev *indio_dev)
 	ring->access = &ring_sw_access_funcs;
 	ring->scan_timestamp = true;
 	indio_dev->setup_ops = &adis16400_ring_setup_ops;
-	ring->owner = THIS_MODULE;
 
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
 						 &adis16400_trigger_handler,
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index 028470c..f29f2b2 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -147,7 +147,6 @@ int ade7758_configure_ring(struct iio_dev *indio_dev)
 	/* Effectively select the ring buffer implementation */
 	indio_dev->buffer->access = &ring_sw_access_funcs;
 	indio_dev->setup_ops = &ade7758_ring_setup_ops;
-	indio_dev->buffer->owner = THIS_MODULE;
 
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
 						 &ade7758_trigger_handler,
-- 
1.7.7.3
