Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	manuel.stahl@iis.fraunhofer.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 01/16] staging:iio:buffer drop bpe field.
Date: Sun, 27 Nov 2011 13:33:30 +0000
Message-Id: <1322400825-29400-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1322400825-29400-1-git-send-email-jic23@kernel.org>
References: <1322400825-29400-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@cam.ac.uk>

Has no remaining users.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16201_ring.c    |    1 -
 drivers/staging/iio/accel/adis16203_ring.c    |    1 -
 drivers/staging/iio/accel/adis16204_ring.c    |    1 -
 drivers/staging/iio/accel/adis16209_ring.c    |    1 -
 drivers/staging/iio/accel/adis16240_ring.c    |    1 -
 drivers/staging/iio/accel/lis3l02dq_ring.c    |    1 -
 drivers/staging/iio/accel/sca3000_ring.c      |    2 --
 drivers/staging/iio/adc/ad7606_ring.c         |    2 --
 drivers/staging/iio/buffer.h                  |    2 --
 drivers/staging/iio/gyro/adis16260_ring.c     |    1 -
 drivers/staging/iio/iio_simple_dummy_buffer.c |    2 --
 drivers/staging/iio/imu/adis16400_ring.c      |    1 -
 12 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_ring.c b/drivers/staging/iio/accel/adis16201_ring.c
index 0016ed3..184c9dd 100644
--- a/drivers/staging/iio/accel/adis16201_ring.c
+++ b/drivers/staging/iio/accel/adis16201_ring.c
@@ -116,7 +116,6 @@ int adis16201_configure_ring(struct iio_dev *indio_dev)
 	}
 	indio_dev->buffer = ring;
 	/* Effectively select the ring buffer implementation */
-	ring->bpe = 2;
 	ring->scan_timestamp = true;
 	ring->access = &ring_sw_access_funcs;
 	ring->setup_ops = &adis16201_ring_setup_ops;
diff --git a/drivers/staging/iio/accel/adis16203_ring.c b/drivers/staging/iio/accel/adis16203_ring.c
index 1fdfe6f..da170c8 100644
--- a/drivers/staging/iio/accel/adis16203_ring.c
+++ b/drivers/staging/iio/accel/adis16203_ring.c
@@ -118,7 +118,6 @@ int adis16203_configure_ring(struct iio_dev *indio_dev)
 	}
 	indio_dev->buffer = ring;
 	/* Effectively select the ring buffer implementation */
-	ring->bpe = 2;
 	ring->scan_timestamp = true;
 	ring->access = &ring_sw_access_funcs;
 	ring->setup_ops = &adis16203_ring_setup_ops;
diff --git a/drivers/staging/iio/accel/adis16204_ring.c b/drivers/staging/iio/accel/adis16204_ring.c
index 6fd3d8f..1094564 100644
--- a/drivers/staging/iio/accel/adis16204_ring.c
+++ b/drivers/staging/iio/accel/adis16204_ring.c
@@ -114,7 +114,6 @@ int adis16204_configure_ring(struct iio_dev *indio_dev)
 	indio_dev->buffer = ring;
 	/* Effectively select the ring buffer implementation */
 	ring->access = &ring_sw_access_funcs;
-	ring->bpe = 2;
 	ring->scan_timestamp = true;
 	ring->setup_ops = &adis16204_ring_setup_ops;
 	ring->owner = THIS_MODULE;
diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index d17e39d..e9158ed 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -114,7 +114,6 @@ int adis16209_configure_ring(struct iio_dev *indio_dev)
 	indio_dev->buffer = ring;
 	/* Effectively select the ring buffer implementation */
 	ring->access = &ring_sw_access_funcs;
-	ring->bpe = 2;
 	ring->scan_timestamp = true;
 	ring->setup_ops = &adis16209_ring_setup_ops;
 	ring->owner = THIS_MODULE;
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index b907ca3..5b02e5a 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -111,7 +111,6 @@ int adis16240_configure_ring(struct iio_dev *indio_dev)
 	indio_dev->buffer = ring;
 	/* Effectively select the ring buffer implementation */
 	ring->access = &ring_sw_access_funcs;
-	ring->bpe = 2;
 	ring->scan_timestamp = true;
 	ring->setup_ops = &adis16240_ring_setup_ops;
 	ring->owner = THIS_MODULE;
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 89527af..e400c04 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -437,7 +437,6 @@ int lis3l02dq_configure_buffer(struct iio_dev *indio_dev)
 	indio_dev->buffer = buffer;
 	/* Effectively select the buffer implementation */
 	indio_dev->buffer->access = &lis3l02dq_access_funcs;
-	buffer->bpe = 2;
 
 	buffer->scan_timestamp = true;
 	buffer->setup_ops = &lis3l02dq_buffer_setup_ops;
diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
index 685ded8..4e1d938 100644
--- a/drivers/staging/iio/accel/sca3000_ring.c
+++ b/drivers/staging/iio/accel/sca3000_ring.c
@@ -146,7 +146,6 @@ static int sca3000_ring_get_bytes_per_datum(struct iio_buffer *r)
 }
 
 static IIO_BUFFER_ENABLE_ATTR;
-static IIO_BUFFER_BYTES_PER_DATUM_ATTR;
 static IIO_BUFFER_LENGTH_ATTR;
 
 /**
@@ -243,7 +242,6 @@ static IIO_DEVICE_ATTR(in_accel_scale,
  */
 static struct attribute *sca3000_ring_attributes[] = {
 	&dev_attr_length.attr,
-	&dev_attr_bytes_per_datum.attr,
 	&dev_attr_enable.attr,
 	&iio_dev_attr_50_percent.dev_attr.attr,
 	&iio_dev_attr_75_percent.dev_attr.attr,
diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index af6780a..203c914 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -136,8 +136,6 @@ int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 
 	/* Effectively select the ring buffer implementation */
 	indio_dev->buffer->access = &ring_sw_access_funcs;
-	indio_dev->buffer->bpe =
-		st->chip_info->channels[0].scan_type.storagebits / 8;
 	indio_dev->pollfunc = iio_alloc_pollfunc(&ad7606_trigger_handler_th_bh,
 						 &ad7606_trigger_handler_th_bh,
 						 0,
diff --git a/drivers/staging/iio/buffer.h b/drivers/staging/iio/buffer.h
index 5282441..97d59d9 100644
--- a/drivers/staging/iio/buffer.h
+++ b/drivers/staging/iio/buffer.h
@@ -86,7 +86,6 @@ struct iio_buffer_setup_ops {
  * @owner:		module that owns the buffer (for ref counting)
  * @length:		[DEVICE] number of datums in buffer
  * @bytes_per_datum:	[DEVICE] size of individual datum including timestamp
- * @bpe:		[DEVICE] size of individual channel value
  * @scan_el_attrs:	[DRIVER] control of scan elements if that scan mode
  *			control method is used
  * @scan_count:	[INTERN] the number of elements in the current scan mode
@@ -103,7 +102,6 @@ struct iio_buffer {
 	struct module				*owner;
 	int					length;
 	int					bytes_per_datum;
-	int					bpe;
 	struct attribute_group			*scan_el_attrs;
 	int					scan_count;
 	long					*scan_mask;
diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index 52a9e78..c8d22f5 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -116,7 +116,6 @@ int adis16260_configure_ring(struct iio_dev *indio_dev)
 	indio_dev->buffer = ring;
 	/* Effectively select the ring buffer implementation */
 	ring->access = &ring_sw_access_funcs;
-	ring->bpe = 2;
 	ring->scan_timestamp = true;
 	ring->setup_ops = &adis16260_ring_setup_ops;
 	ring->owner = THIS_MODULE;
diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
index edad0e7..1f1c273 100644
--- a/drivers/staging/iio/iio_simple_dummy_buffer.c
+++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
@@ -142,8 +142,6 @@ int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev)
 	/* Tell the core how to access the buffer */
 	buffer->access = &kfifo_access_funcs;
 
-	/* Number of bytes per element */
-	buffer->bpe = 2;
 	/* Enable timestamps by default */
 	buffer->scan_timestamp = true;
 
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index fd886bf..cee61aa 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -186,7 +186,6 @@ int adis16400_configure_ring(struct iio_dev *indio_dev)
 	indio_dev->buffer = ring;
 	/* Effectively select the ring buffer implementation */
 	ring->access = &ring_sw_access_funcs;
-	ring->bpe = 2;
 	ring->scan_timestamp = true;
 	ring->setup_ops = &adis16400_ring_setup_ops;
 	ring->owner = THIS_MODULE;
-- 
1.7.7.3
