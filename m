Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:6208
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750864Ab1LLKIj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 12 Dec 2011 05:08:39 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: Jonathan Cameron <jic23@kernel.org>, <devel@driverdev.osuosl.org>,
	<linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio: Setup buffer access functions when allocating the buffer
Date: Mon, 12 Dec 2011 11:09:05 +0100
Message-ID: <1323684545-11188-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Setup the buffer access functions in the buffer allocate function. There is no
need to let each driver handle this on its own.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/adis16201_ring.c      |    2 --
 drivers/staging/iio/accel/adis16203_ring.c      |    2 --
 drivers/staging/iio/accel/adis16204_ring.c      |    2 --
 drivers/staging/iio/accel/adis16209_ring.c      |    2 --
 drivers/staging/iio/accel/adis16240_ring.c      |    2 --
 drivers/staging/iio/accel/lis3l02dq.h           |    2 --
 drivers/staging/iio/accel/lis3l02dq_ring.c      |    2 --
 drivers/staging/iio/adc/ad7192.c                |    2 --
 drivers/staging/iio/adc/ad7298_ring.c           |    3 ---
 drivers/staging/iio/adc/ad7476_ring.c           |    2 --
 drivers/staging/iio/adc/ad7606_ring.c           |    2 --
 drivers/staging/iio/adc/ad7793.c                |    2 --
 drivers/staging/iio/adc/ad7887_ring.c           |    2 --
 drivers/staging/iio/adc/ad799x_ring.c           |    2 --
 drivers/staging/iio/adc/max1363_ring.c          |    2 --
 drivers/staging/iio/gyro/adis16260_ring.c       |    2 --
 drivers/staging/iio/iio_simple_dummy_buffer.c   |    2 --
 drivers/staging/iio/impedance-analyzer/ad5933.c |    3 ---
 drivers/staging/iio/imu/adis16400_ring.c        |    2 --
 drivers/staging/iio/kfifo_buf.c                 |    1 +
 drivers/staging/iio/meter/ade7758_ring.c        |    2 --
 drivers/staging/iio/ring_sw.c                   |    1 +
 22 files changed, 2 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_ring.c b/drivers/staging/iio/accel/adis16201_ring.c
index 26c610f..97f9e6b 100644
--- a/drivers/staging/iio/accel/adis16201_ring.c
+++ b/drivers/staging/iio/accel/adis16201_ring.c
@@ -115,9 +115,7 @@ int adis16201_configure_ring(struct iio_dev *indio_dev)
 		return ret;
 	}
 	indio_dev->buffer = ring;
-	/* Effectively select the ring buffer implementation */
 	ring->scan_timestamp = true;
-	ring->access = &ring_sw_access_funcs;
 	indio_dev->setup_ops = &adis16201_ring_setup_ops;
 
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
diff --git a/drivers/staging/iio/accel/adis16203_ring.c b/drivers/staging/iio/accel/adis16203_ring.c
index 064640d..6a8963d 100644
--- a/drivers/staging/iio/accel/adis16203_ring.c
+++ b/drivers/staging/iio/accel/adis16203_ring.c
@@ -117,9 +117,7 @@ int adis16203_configure_ring(struct iio_dev *indio_dev)
 		return ret;
 	}
 	indio_dev->buffer = ring;
-	/* Effectively select the ring buffer implementation */
 	ring->scan_timestamp = true;
-	ring->access = &ring_sw_access_funcs;
 	indio_dev->setup_ops = &adis16203_ring_setup_ops;
 
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
diff --git a/drivers/staging/iio/accel/adis16204_ring.c b/drivers/staging/iio/accel/adis16204_ring.c
index 4081179..5c8ab73 100644
--- a/drivers/staging/iio/accel/adis16204_ring.c
+++ b/drivers/staging/iio/accel/adis16204_ring.c
@@ -112,8 +112,6 @@ int adis16204_configure_ring(struct iio_dev *indio_dev)
 		return ret;
 	}
 	indio_dev->buffer = ring;
-	/* Effectively select the ring buffer implementation */
-	ring->access = &ring_sw_access_funcs;
 	ring->scan_timestamp = true;
 	indio_dev->setup_ops = &adis16204_ring_setup_ops;
 
diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index 2a6fd334..57254b6 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -113,8 +113,6 @@ int adis16209_configure_ring(struct iio_dev *indio_dev)
 		return ret;
 	}
 	indio_dev->buffer = ring;
-	/* Effectively select the ring buffer implementation */
-	ring->access = &ring_sw_access_funcs;
 	ring->scan_timestamp = true;
 	indio_dev->setup_ops = &adis16209_ring_setup_ops;
 
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index e23622d..43ba84e 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -110,8 +110,6 @@ int adis16240_configure_ring(struct iio_dev *indio_dev)
 		return ret;
 	}
 	indio_dev->buffer = ring;
-	/* Effectively select the ring buffer implementation */
-	ring->access = &ring_sw_access_funcs;
 	ring->scan_timestamp = true;
 	indio_dev->setup_ops = &adis16240_ring_setup_ops;
 
diff --git a/drivers/staging/iio/accel/lis3l02dq.h b/drivers/staging/iio/accel/lis3l02dq.h
index 2db383f..ae5f225 100644
--- a/drivers/staging/iio/accel/lis3l02dq.h
+++ b/drivers/staging/iio/accel/lis3l02dq.h
@@ -187,12 +187,10 @@ void lis3l02dq_unconfigure_buffer(struct iio_dev *indio_dev);
 #ifdef CONFIG_LIS3L02DQ_BUF_RING_SW
 #define lis3l02dq_free_buf iio_sw_rb_free
 #define lis3l02dq_alloc_buf iio_sw_rb_allocate
-#define lis3l02dq_access_funcs ring_sw_access_funcs
 #endif
 #ifdef CONFIG_LIS3L02DQ_BUF_KFIFO
 #define lis3l02dq_free_buf iio_kfifo_free
 #define lis3l02dq_alloc_buf iio_kfifo_allocate
-#define lis3l02dq_access_funcs kfifo_access_funcs
 #endif
 irqreturn_t lis3l02dq_data_rdy_trig_poll(int irq, void *private);
 #define lis3l02dq_th lis3l02dq_data_rdy_trig_poll
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 98c5c92..ca0a1fe 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -406,8 +406,6 @@ int lis3l02dq_configure_buffer(struct iio_dev *indio_dev)
 		return -ENOMEM;
 
 	indio_dev->buffer = buffer;
-	/* Effectively select the buffer implementation */
-	indio_dev->buffer->access = &lis3l02dq_access_funcs;
 
 	buffer->scan_timestamp = true;
 	indio_dev->setup_ops = &lis3l02dq_buffer_setup_ops;
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 66cc507..ab0cd10 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -561,8 +561,6 @@ static int ad7192_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-	/* Effectively select the ring buffer implementation */
-	indio_dev->buffer->access = &ring_sw_access_funcs;
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
 						 &ad7192_trigger_handler,
 						 IRQF_ONESHOT,
diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
index d1a12dd..feeb0ee 100644
--- a/drivers/staging/iio/adc/ad7298_ring.c
+++ b/drivers/staging/iio/adc/ad7298_ring.c
@@ -131,9 +131,6 @@ int ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-	/* Effectively select the ring buffer implementation */
-	indio_dev->buffer->access = &ring_sw_access_funcs;
-
 	indio_dev->pollfunc = iio_alloc_pollfunc(NULL,
 						 &ad7298_trigger_handler,
 						 IRQF_ONESHOT,
diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
index 4e298b2..35a8576 100644
--- a/drivers/staging/iio/adc/ad7476_ring.c
+++ b/drivers/staging/iio/adc/ad7476_ring.c
@@ -98,8 +98,6 @@ int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-	/* Effectively select the ring buffer implementation */
-	indio_dev->buffer->access = &ring_sw_access_funcs;
 	indio_dev->pollfunc
 		= iio_alloc_pollfunc(NULL,
 				     &ad7476_trigger_handler,
diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index e8f94a1..1ef9fbc 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -110,8 +110,6 @@ int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 		goto error_ret;
 	}
 
-	/* Effectively select the ring buffer implementation */
-	indio_dev->buffer->access = &ring_sw_access_funcs;
 	indio_dev->pollfunc = iio_alloc_pollfunc(&ad7606_trigger_handler_th_bh,
 						 &ad7606_trigger_handler_th_bh,
 						 0,
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 4047c5d..637820b 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -427,8 +427,6 @@ static int ad7793_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-	/* Effectively select the ring buffer implementation */
-	indio_dev->buffer->access = &ring_sw_access_funcs;
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
 						 &ad7793_trigger_handler,
 						 IRQF_ONESHOT,
diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
index 85076cd..d180907 100644
--- a/drivers/staging/iio/adc/ad7887_ring.c
+++ b/drivers/staging/iio/adc/ad7887_ring.c
@@ -131,8 +131,6 @@ int ad7887_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-	/* Effectively select the ring buffer implementation */
-	indio_dev->buffer->access = &ring_sw_access_funcs;
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
 						 &ad7887_trigger_handler,
 						 IRQF_ONESHOT,
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index 5dded9e..28e9a41 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -141,8 +141,6 @@ int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-	/* Effectively select the ring buffer implementation */
-	indio_dev->buffer->access = &ring_sw_access_funcs;
 	indio_dev->pollfunc = iio_alloc_pollfunc(NULL,
 						 &ad799x_trigger_handler,
 						 IRQF_ONESHOT,
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index f730b3f..d0a60a3 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -116,8 +116,6 @@ int max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 		ret = -ENOMEM;
 		goto error_deallocate_sw_rb;
 	}
-	/* Effectively select the ring buffer implementation */
-	indio_dev->buffer->access = &ring_sw_access_funcs;
 	/* Ring buffer functions - here trigger setup related */
 	indio_dev->setup_ops = &max1363_ring_setup_ops;
 
diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index 699a615..711f151 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -115,8 +115,6 @@ int adis16260_configure_ring(struct iio_dev *indio_dev)
 		return ret;
 	}
 	indio_dev->buffer = ring;
-	/* Effectively select the ring buffer implementation */
-	ring->access = &ring_sw_access_funcs;
 	ring->scan_timestamp = true;
 	indio_dev->setup_ops = &adis16260_ring_setup_ops;
 
diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
index d6a1c0e..bb4daf7 100644
--- a/drivers/staging/iio/iio_simple_dummy_buffer.c
+++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
@@ -142,8 +142,6 @@ int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev)
 	}
 
 	indio_dev->buffer = buffer;
-	/* Tell the core how to access the buffer */
-	buffer->access = &kfifo_access_funcs;
 
 	/* Enable timestamps by default */
 	buffer->scan_timestamp = true;
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index f02d1c0..4138082 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -607,9 +607,6 @@ static int ad5933_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	if (!indio_dev->buffer)
 		return -ENOMEM;
 
-	/* Effectively select the ring buffer implementation */
-	indio_dev->buffer->access = &ring_sw_access_funcs;
-
 	/* Ring buffer functions - here trigger setup related */
 	indio_dev->setup_ops = &ad5933_ring_setup_ops;
 
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index ac22de5..8daa038 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -187,8 +187,6 @@ int adis16400_configure_ring(struct iio_dev *indio_dev)
 		return ret;
 	}
 	indio_dev->buffer = ring;
-	/* Effectively select the ring buffer implementation */
-	ring->access = &ring_sw_access_funcs;
 	ring->scan_timestamp = true;
 	indio_dev->setup_ops = &adis16400_ring_setup_ops;
 
diff --git a/drivers/staging/iio/kfifo_buf.c b/drivers/staging/iio/kfifo_buf.c
index b69cca5..930029b 100644
--- a/drivers/staging/iio/kfifo_buf.c
+++ b/drivers/staging/iio/kfifo_buf.c
@@ -98,6 +98,7 @@ struct iio_buffer *iio_kfifo_allocate(struct iio_dev *indio_dev)
 	kf->update_needed = true;
 	iio_buffer_init(&kf->buffer);
 	kf->buffer.attrs = &iio_kfifo_attribute_group;
+	kf->buffer->access = kfifo_access_funcs;
 	__iio_init_kfifo(kf);
 
 	return &kf->buffer;
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index f29f2b2..c5c522b 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -144,8 +144,6 @@ int ade7758_configure_ring(struct iio_dev *indio_dev)
 		return ret;
 	}
 
-	/* Effectively select the ring buffer implementation */
-	indio_dev->buffer->access = &ring_sw_access_funcs;
 	indio_dev->setup_ops = &ade7758_ring_setup_ops;
 
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.c
index 4c15cc8..98b66a0 100644
--- a/drivers/staging/iio/ring_sw.c
+++ b/drivers/staging/iio/ring_sw.c
@@ -376,6 +376,7 @@ struct iio_buffer *iio_sw_rb_allocate(struct iio_dev *indio_dev)
 	iio_buffer_init(buf);
 	__iio_init_sw_ring_buffer(ring);
 	buf->attrs = &iio_ring_attribute_group;
+	buf->access = &ring_sw_access_funcs;
 
 	return buf;
 }
-- 
1.7.7.3


