Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:35836 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755405Ab1BKNJ5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 Feb 2011 08:09:57 -0500
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 3/5] staging:iio:lis3l02dq allow buffer implementation selection
Date: Fri, 11 Feb 2011 13:09:11 +0000
Message-Id: <1297429753-6606-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1297429753-6606-1-git-send-email-jic23@cam.ac.uk>
References: <1297429753-6606-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/Kconfig          |   23 ++++++++++++++++++++++-
 drivers/staging/iio/accel/lis3l02dq.h      |   10 ++++++++++
 drivers/staging/iio/accel/lis3l02dq_ring.c |    9 +++++----
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig
index a34f1d3..81a33b6 100644
--- a/drivers/staging/iio/accel/Kconfig
+++ b/drivers/staging/iio/accel/Kconfig
@@ -66,12 +66,33 @@ config LIS3L02DQ
 	tristate "ST Microelectronics LIS3L02DQ Accelerometer Driver"
 	depends on SPI
 	select IIO_TRIGGER if IIO_RING_BUFFER
-	select IIO_SW_RING if IIO_RING_BUFFER
+	depends on !IIO_RING_BUFFER || IIO_KFIFO_BUF || IIO_SW_RING
 	help
 	  Say yes here to build SPI support for the ST microelectronics
 	  accelerometer. The driver supplies direct access via sysfs files
 	  and an event interface via a character device.
 
+choice
+	prompt "Buffer type"
+       	depends on LIS3L02DQ && IIO_RING_BUFFER
+
+config LIS3L02DQ_BUF_KFIFO
+       depends on IIO_KFIFO_BUF
+       bool "Simple FIFO"
+       help
+         Kfifo based FIFO.  Does not provide any events so it is up
+	 to userspace to ensure it reads often enough that data is not
+	 lost.
+
+config LIS3L02DQ_BUF_RING_SW
+       depends on IIO_SW_RING
+       bool "IIO Software Ring"
+       help
+         Original IIO ring buffer implementation.  Provides simple
+	 buffer events, half full etc.
+
+endchoice
+
 config SCA3000
 	depends on IIO_RING_BUFFER
 	depends on SPI
diff --git a/drivers/staging/iio/accel/lis3l02dq.h b/drivers/staging/iio/accel/lis3l02dq.h
index 6e73055..579b3a2 100644
--- a/drivers/staging/iio/accel/lis3l02dq.h
+++ b/drivers/staging/iio/accel/lis3l02dq.h
@@ -196,6 +196,16 @@ ssize_t lis3l02dq_read_accel_from_ring(struct device *dev,
 int lis3l02dq_configure_ring(struct iio_dev *indio_dev);
 void lis3l02dq_unconfigure_ring(struct iio_dev *indio_dev);
 
+#ifdef CONFIG_LIS3L02DQ_BUF_RING_SW
+#define lis3l02dq_free_buf iio_sw_rb_free
+#define lis3l02dq_alloc_buf iio_sw_rb_allocate
+#define lis3l02dq_register_buf_funcs iio_ring_sw_register_funcs
+#endif
+#ifdef CONFIG_LIS3L02DQ_BUF_KFIFO
+#define lis3l02dq_free_buf iio_kfifo_free
+#define lis3l02dq_alloc_buf iio_kfifo_allocate
+#define lis3l02dq_register_buf_funcs iio_kfifo_register_funcs
+#endif
 #else /* CONFIG_IIO_RING_BUFFER */
 
 static inline void lis3l02dq_remove_trigger(struct iio_dev *indio_dev)
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 1fd088a..2c461a3 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -13,6 +13,7 @@
 #include "../iio.h"
 #include "../sysfs.h"
 #include "../ring_sw.h"
+#include "../kfifo_buf.h"
 #include "accel.h"
 #include "../trigger.h"
 #include "lis3l02dq.h"
@@ -484,7 +485,7 @@ void lis3l02dq_remove_trigger(struct iio_dev *indio_dev)
 void lis3l02dq_unconfigure_ring(struct iio_dev *indio_dev)
 {
 	kfree(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->ring);
+	lis3l02dq_free_buf(indio_dev->ring);
 }
 
 int lis3l02dq_configure_ring(struct iio_dev *indio_dev)
@@ -495,13 +496,13 @@ int lis3l02dq_configure_ring(struct iio_dev *indio_dev)
 	INIT_WORK(&h->work_trigger_to_ring, lis3l02dq_trigger_bh_to_ring);
 	h->get_ring_element = &lis3l02dq_get_ring_element;
 
-	ring = iio_sw_rb_allocate(indio_dev);
+	ring = lis3l02dq_alloc_buf(indio_dev);
 	if (!ring)
 		return -ENOMEM;
 
 	indio_dev->ring = ring;
 	/* Effectively select the ring buffer implementation */
-	iio_ring_sw_register_funcs(&ring->access);
+	lis3l02dq_register_buf_funcs(&ring->access);
 	ring->bpe = 2;
 	ring->scan_el_attrs = &lis3l02dq_scan_el_group;
 	ring->scan_timestamp = true;
@@ -522,6 +523,6 @@ int lis3l02dq_configure_ring(struct iio_dev *indio_dev)
 	return 0;
 
 error_iio_sw_rb_free:
-	iio_sw_rb_free(indio_dev->ring);
+	lis3l02dq_free_buf(indio_dev->ring);
 	return ret;
 }
-- 
1.7.3.4

