Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: linus.ml.walleij@gmail.com,
	broonie@opensource.wolfsonmicro.com,
	arnd@arndb.de,
	gregkh@suse.de,
	thomas.petazzoni@free-electrons.com,
	Michael.Hennerich@analog.com,
	lars@metafoo.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 3/7] staging:iio:buffer move setup ops from buffer instance to iio_dev
Date: Wed, 26 Oct 2011 16:54:14 +0100
Message-Id: <1319644458-30630-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1319644458-30630-1-git-send-email-jic23@cam.ac.uk>
References: <1319644458-30630-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

These callbacks should not be buffer instance specific.
Hence move them out of the buffer.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16201_ring.c      |    2 +-
 drivers/staging/iio/accel/adis16203_ring.c      |    2 +-
 drivers/staging/iio/accel/adis16204_ring.c      |    2 +-
 drivers/staging/iio/accel/adis16209_ring.c      |    2 +-
 drivers/staging/iio/accel/adis16240_ring.c      |    2 +-
 drivers/staging/iio/accel/lis3l02dq_ring.c      |    2 +-
 drivers/staging/iio/accel/sca3000_ring.c        |    2 +-
 drivers/staging/iio/adc/ad7192.c                |    2 +-
 drivers/staging/iio/adc/ad7298_ring.c           |    2 +-
 drivers/staging/iio/adc/ad7476_ring.c           |    2 +-
 drivers/staging/iio/adc/ad7606_ring.c           |    2 +-
 drivers/staging/iio/adc/ad7793.c                |    2 +-
 drivers/staging/iio/adc/ad7887_ring.c           |    2 +-
 drivers/staging/iio/adc/ad799x_ring.c           |    2 +-
 drivers/staging/iio/adc/max1363_ring.c          |    2 +-
 drivers/staging/iio/buffer.h                    |   16 ----------------
 drivers/staging/iio/gyro/adis16260_ring.c       |    2 +-
 drivers/staging/iio/iio.h                       |   16 ++++++++++++++++
 drivers/staging/iio/iio_simple_dummy_buffer.c   |    2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c |    2 +-
 drivers/staging/iio/imu/adis16400_ring.c        |    2 +-
 drivers/staging/iio/industrialio-buffer.c       |   20 ++++++++++----------
 drivers/staging/iio/meter/ade7758_ring.c        |    2 +-
 23 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_ring.c b/drivers/staging/iio/accel/adis16201_ring.c
index 3ecfcee..787a719 100644
--- a/drivers/staging/iio/accel/adis16201_ring.c
+++ b/drivers/staging/iio/accel/adis16201_ring.c
@@ -117,7 +117,7 @@ int adis16201_configure_ring(struct iio_dev *indio_dev)
 	/* Effectively select the ring buffer implementation */
 	ring->scan_timestamp = true;
 	ring->access = &ring_sw_access_funcs;
-	ring->setup_ops = &adis16201_ring_setup_ops;
+	indio_dev->setup_ops = &adis16201_ring_setup_ops;
 	ring->owner = THIS_MODULE;
 
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
diff --git a/drivers/staging/iio/accel/adis16203_ring.c b/drivers/staging/iio/accel/adis16203_ring.c
index 67d9dc9..55020fb 100644
--- a/drivers/staging/iio/accel/adis16203_ring.c
+++ b/drivers/staging/iio/accel/adis16203_ring.c
@@ -119,7 +119,7 @@ int adis16203_configure_ring(struct iio_dev *indio_dev)
 	/* Effectively select the ring buffer implementation */
 	ring->scan_timestamp = true;
 	ring->access = &ring_sw_access_funcs;
-	ring->setup_ops = &adis16203_ring_setup_ops;
+	indio_dev->setup_ops = &adis16203_ring_setup_ops;
 	ring->owner = THIS_MODULE;
 
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
diff --git a/drivers/staging/iio/accel/adis16204_ring.c b/drivers/staging/iio/accel/adis16204_ring.c
index 53d865e..33f59fb 100644
--- a/drivers/staging/iio/accel/adis16204_ring.c
+++ b/drivers/staging/iio/accel/adis16204_ring.c
@@ -114,7 +114,7 @@ int adis16204_configure_ring(struct iio_dev *indio_dev)
 	/* Effectively select the ring buffer implementation */
 	ring->access = &ring_sw_access_funcs;
 	ring->scan_timestamp = true;
-	ring->setup_ops = &adis16204_ring_setup_ops;
+	indio_dev->setup_ops = &adis16204_ring_setup_ops;
 	ring->owner = THIS_MODULE;
 
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index 9f9c31d..37f0f7f 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -114,7 +114,7 @@ int adis16209_configure_ring(struct iio_dev *indio_dev)
 	/* Effectively select the ring buffer implementation */
 	ring->access = &ring_sw_access_funcs;
 	ring->scan_timestamp = true;
-	ring->setup_ops = &adis16209_ring_setup_ops;
+	indio_dev->setup_ops = &adis16209_ring_setup_ops;
 	ring->owner = THIS_MODULE;
 
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index 6576e2f..08e8625 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -111,7 +111,7 @@ int adis16240_configure_ring(struct iio_dev *indio_dev)
 	/* Effectively select the ring buffer implementation */
 	ring->access = &ring_sw_access_funcs;
 	ring->scan_timestamp = true;
-	ring->setup_ops = &adis16240_ring_setup_ops;
+	indio_dev->setup_ops = &adis16240_ring_setup_ops;
 	ring->owner = THIS_MODULE;
 
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 5f26e53..410c6d6 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -438,7 +438,7 @@ int lis3l02dq_configure_buffer(struct iio_dev *indio_dev)
 	indio_dev->buffer->access = &lis3l02dq_access_funcs;
 
 	buffer->scan_timestamp = true;
-	buffer->setup_ops = &lis3l02dq_buffer_setup_ops;
+	indio_dev->setup_ops = &lis3l02dq_buffer_setup_ops;
 	buffer->owner = THIS_MODULE;
 
 	/* Functions are NULL as we set handler below */
diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
index 4e1d938..6a27a95 100644
--- a/drivers/staging/iio/accel/sca3000_ring.c
+++ b/drivers/staging/iio/accel/sca3000_ring.c
@@ -348,7 +348,7 @@ static const struct iio_buffer_setup_ops sca3000_ring_setup_ops = {
 
 void sca3000_register_ring_funcs(struct iio_dev *indio_dev)
 {
-	indio_dev->buffer->setup_ops = &sca3000_ring_setup_ops;
+	indio_dev->setup_ops = &sca3000_ring_setup_ops;
 }
 
 /**
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 1dd0f9f..f706c90 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -592,7 +592,7 @@ static int ad7192_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	}
 
 	/* Ring buffer functions - here trigger setup related */
-	indio_dev->buffer->setup_ops = &ad7192_ring_setup_ops;
+	indio_dev->setup_ops = &ad7192_ring_setup_ops;
 
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
index 192328e..611e212 100644
--- a/drivers/staging/iio/adc/ad7298_ring.c
+++ b/drivers/staging/iio/adc/ad7298_ring.c
@@ -174,7 +174,7 @@ int ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	}
 
 	/* Ring buffer functions - here trigger setup related */
-	indio_dev->buffer->setup_ops = &ad7298_ring_setup_ops;
+	indio_dev->setup_ops = &ad7298_ring_setup_ops;
 	indio_dev->buffer->scan_timestamp = true;
 
 	/* Flag that polled ring buffering is possible */
diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
index 0961887..2dad7f8 100644
--- a/drivers/staging/iio/adc/ad7476_ring.c
+++ b/drivers/staging/iio/adc/ad7476_ring.c
@@ -137,7 +137,7 @@ int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	}
 
 	/* Ring buffer functions - here trigger setup related */
-	indio_dev->buffer->setup_ops = &ad7476_ring_setup_ops;
+	indio_dev->setup_ops = &ad7476_ring_setup_ops;
 	indio_dev->buffer->scan_timestamp = true;
 
 	/* Flag that polled ring buffering is possible */
diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index 203c914..f682af6 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -150,7 +150,7 @@ int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 
 	/* Ring buffer functions - here trigger setup related */
 
-	indio_dev->buffer->setup_ops = &ad7606_ring_setup_ops;
+	indio_dev->setup_ops = &ad7606_ring_setup_ops;
 	indio_dev->buffer->scan_timestamp = true ;
 
 	INIT_WORK(&st->poll_work, &ad7606_poll_bh_to_ring);
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index cbefa22..0220aea 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -458,7 +458,7 @@ static int ad7793_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	}
 
 	/* Ring buffer functions - here trigger setup related */
-	indio_dev->buffer->setup_ops = &ad7793_ring_setup_ops;
+	indio_dev->setup_ops = &ad7793_ring_setup_ops;
 
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
index fbe21b5..fee338c 100644
--- a/drivers/staging/iio/adc/ad7887_ring.c
+++ b/drivers/staging/iio/adc/ad7887_ring.c
@@ -176,7 +176,7 @@ int ad7887_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 		goto error_deallocate_sw_rb;
 	}
 	/* Ring buffer functions - here trigger setup related */
-	indio_dev->buffer->setup_ops = &ad7887_ring_setup_ops;
+	indio_dev->setup_ops = &ad7887_ring_setup_ops;
 
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index b215a1f..50c1216 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -183,7 +183,7 @@ int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	}
 
 	/* Ring buffer functions - here trigger setup related */
-	indio_dev->buffer->setup_ops = &ad799x_buf_setup_ops;
+	indio_dev->setup_ops = &ad799x_buf_setup_ops;
 	indio_dev->buffer->scan_timestamp = true;
 
 	/* Flag that polled ring buffering is possible */
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index 19977a6..3a38a26 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -155,7 +155,7 @@ int max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	/* Effectively select the ring buffer implementation */
 	indio_dev->buffer->access = &ring_sw_access_funcs;
 	/* Ring buffer functions - here trigger setup related */
-	indio_dev->buffer->setup_ops = &max1363_ring_setup_ops;
+	indio_dev->setup_ops = &max1363_ring_setup_ops;
 
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
diff --git a/drivers/staging/iio/buffer.h b/drivers/staging/iio/buffer.h
index 9171735..58c7571 100644
--- a/drivers/staging/iio/buffer.h
+++ b/drivers/staging/iio/buffer.h
@@ -66,21 +66,6 @@ struct iio_buffer_access_funcs {
 };
 
 /**
- * struct iio_buffer_setup_ops - buffer setup related callbacks
- * @preenable:		[DRIVER] function to run prior to marking buffer enabled
- * @postenable:		[DRIVER] function to run after marking buffer enabled
- * @predisable:		[DRIVER] function to run prior to marking buffer
- *			disabled
- * @postdisable:	[DRIVER] function to run after marking buffer disabled
- */
-struct iio_buffer_setup_ops {
-	int				(*preenable)(struct iio_dev *);
-	int				(*postenable)(struct iio_dev *);
-	int				(*predisable)(struct iio_dev *);
-	int				(*postdisable)(struct iio_dev *);
-};
-
-/**
  * struct iio_buffer - general buffer structure
  * @indio_dev:		industrial I/O device structure
  * @owner:		module that owns the buffer (for ref counting)
@@ -108,7 +93,6 @@ struct iio_buffer {
 	bool					scan_timestamp;
 	unsigned				scan_index_timestamp;
 	const struct iio_buffer_access_funcs	*access;
-	const struct iio_buffer_setup_ops		*setup_ops;
 	struct list_head			scan_el_dev_attr_list;
 	struct attribute_group			scan_el_group;
 	wait_queue_head_t			pollq;
diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index b18f7e5..675b05d 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -116,7 +116,7 @@ int adis16260_configure_ring(struct iio_dev *indio_dev)
 	/* Effectively select the ring buffer implementation */
 	ring->access = &ring_sw_access_funcs;
 	ring->scan_timestamp = true;
-	ring->setup_ops = &adis16260_ring_setup_ops;
+	indio_dev->setup_ops = &adis16260_ring_setup_ops;
 	ring->owner = THIS_MODULE;
 
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index e30d33d..bd29412 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -270,6 +270,21 @@ struct iio_info {
 };
 
 /**
+ * struct iio_buffer_setup_ops - buffer setup related callbacks
+ * @preenable:		[DRIVER] function to run prior to marking buffer enabled
+ * @postenable:		[DRIVER] function to run after marking buffer enabled
+ * @predisable:		[DRIVER] function to run prior to marking buffer
+ *			disabled
+ * @postdisable:	[DRIVER] function to run after marking buffer disabled
+ */
+struct iio_buffer_setup_ops {
+	int				(*preenable)(struct iio_dev *);
+	int				(*postenable)(struct iio_dev *);
+	int				(*predisable)(struct iio_dev *);
+	int				(*postdisable)(struct iio_dev *);
+};
+
+/**
  * struct iio_dev - industrial I/O device
  * @id:			[INTERN] used to identify device internally
  * @modes:		[DRIVER] operating modes supported by device
@@ -322,6 +337,7 @@ struct iio_dev {
 	struct attribute_group		chan_attr_group;
 	const char			*name;
 	const struct iio_info		*info;
+	const struct iio_buffer_setup_ops	*setup_ops;
 	struct cdev			chrdev;
 #define IIO_MAX_GROUPS 6
 	const struct attribute_group	*groups[IIO_MAX_GROUPS + 1];
diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
index 2ed4c1c..c572f8b 100644
--- a/drivers/staging/iio/iio_simple_dummy_buffer.c
+++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
@@ -148,7 +148,7 @@ int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev)
 	 * Tell the core what device type specific functions should
 	 * be run on either side of buffer capture enable / disable.
 	 */
-	buffer->setup_ops = &iio_simple_dummy_buffer_setup_ops;
+	indio_dev->setup_ops = &iio_simple_dummy_buffer_setup_ops;
 	buffer->owner = THIS_MODULE;
 
 	/*
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 56c89af..2576fc2 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -611,7 +611,7 @@ static int ad5933_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	indio_dev->buffer->access = &ring_sw_access_funcs;
 
 	/* Ring buffer functions - here trigger setup related */
-	indio_dev->buffer->setup_ops = &ad5933_ring_setup_ops;
+	indio_dev->setup_ops = &ad5933_ring_setup_ops;
 
 	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
 
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index 0c37622..aaf53f6 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -186,7 +186,7 @@ int adis16400_configure_ring(struct iio_dev *indio_dev)
 	/* Effectively select the ring buffer implementation */
 	ring->access = &ring_sw_access_funcs;
 	ring->scan_timestamp = true;
-	ring->setup_ops = &adis16400_ring_setup_ops;
+	indio_dev->setup_ops = &adis16400_ring_setup_ops;
 	ring->owner = THIS_MODULE;
 
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index e71b515..5f9ed47 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -428,8 +428,8 @@ ssize_t iio_buffer_store_enable(struct device *dev,
 		goto done;
 	}
 	if (requested_state) {
-		if (buffer->setup_ops->preenable) {
-			ret = buffer->setup_ops->preenable(indio_dev);
+		if (indio_dev->setup_ops->preenable) {
+			ret = indio_dev->setup_ops->preenable(indio_dev);
 			if (ret) {
 				printk(KERN_ERR
 				       "Buffer not started:"
@@ -466,8 +466,8 @@ ssize_t iio_buffer_store_enable(struct device *dev,
 			goto error_ret;
 		}
 
-		if (buffer->setup_ops->postenable) {
-			ret = buffer->setup_ops->postenable(indio_dev);
+		if (indio_dev->setup_ops->postenable) {
+			ret = indio_dev->setup_ops->postenable(indio_dev);
 			if (ret) {
 				printk(KERN_INFO
 				       "Buffer not started:"
@@ -475,23 +475,23 @@ ssize_t iio_buffer_store_enable(struct device *dev,
 				if (buffer->access->unmark_in_use)
 					buffer->access->unmark_in_use(buffer);
 				indio_dev->currentmode = previous_mode;
-				if (buffer->setup_ops->postdisable)
-					buffer->setup_ops->
+				if (indio_dev->setup_ops->postdisable)
+					indio_dev->setup_ops->
 						postdisable(indio_dev);
 				goto error_ret;
 			}
 		}
 	} else {
-		if (buffer->setup_ops->predisable) {
-			ret = buffer->setup_ops->predisable(indio_dev);
+		if (indio_dev->setup_ops->predisable) {
+			ret = indio_dev->setup_ops->predisable(indio_dev);
 			if (ret)
 				goto error_ret;
 		}
 		if (buffer->access->unmark_in_use)
 			buffer->access->unmark_in_use(buffer);
 		indio_dev->currentmode = INDIO_DIRECT_MODE;
-		if (buffer->setup_ops->postdisable) {
-			ret = buffer->setup_ops->postdisable(indio_dev);
+		if (indio_dev->setup_ops->postdisable) {
+			ret = indio_dev->setup_ops->postdisable(indio_dev);
 			if (ret)
 				goto error_ret;
 		}
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index 99ade65..25df982 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -144,7 +144,7 @@ int ade7758_configure_ring(struct iio_dev *indio_dev)
 
 	/* Effectively select the ring buffer implementation */
 	indio_dev->buffer->access = &ring_sw_access_funcs;
-	indio_dev->buffer->setup_ops = &ade7758_ring_setup_ops;
+	indio_dev->setup_ops = &ade7758_ring_setup_ops;
 	indio_dev->buffer->owner = THIS_MODULE;
 
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
-- 
1.7.7
