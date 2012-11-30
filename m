Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57864 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758407Ab2K3OW6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 30 Nov 2012 09:22:58 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 1/5] staging:iio:accel:lis3l02dq remove sw_ring support.
Date: Fri, 30 Nov 2012 14:22:48 +0000
Message-Id: <1354285372-11779-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1354285372-11779-1-git-send-email-jic23@kernel.org>
References: <1354285372-11779-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The sw_ring buffer is being removed in favour of the kfifo version.
This is one of only a couple of driver still supporting its use.

This driver will hopefully also be removed in favour of supporting the
part in the unified ST accelerometer driver.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/Kconfig          | 23 +----------------------
 drivers/staging/iio/accel/lis3l02dq.h      |  8 --------
 drivers/staging/iio/accel/lis3l02dq_ring.c |  7 +++----
 3 files changed, 4 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig
index 2b54430..fa772a9 100644
--- a/drivers/staging/iio/accel/Kconfig
+++ b/drivers/staging/iio/accel/Kconfig
@@ -67,34 +67,13 @@ config LIS3L02DQ
 	tristate "ST Microelectronics LIS3L02DQ Accelerometer Driver"
 	depends on SPI
 	select IIO_TRIGGER if IIO_BUFFER
-	depends on !IIO_BUFFER || IIO_KFIFO_BUF || IIO_SW_RING
+	depends on !IIO_BUFFER || IIO_KFIFO_BUF
 	depends on GENERIC_GPIO
 	help
 	  Say yes here to build SPI support for the ST microelectronics
 	  accelerometer. The driver supplies direct access via sysfs files
 	  and an event interface via a character device.
 
-choice
-	prompt "Buffer type"
-       	depends on LIS3L02DQ && IIO_BUFFER
-
-config LIS3L02DQ_BUF_KFIFO
-       depends on IIO_KFIFO_BUF
-       bool "Simple FIFO"
-       help
-         Kfifo based FIFO.  Does not provide any events so it is up
-	 to userspace to ensure it reads often enough that data is not
-	 lost.
-
-config LIS3L02DQ_BUF_RING_SW
-       depends on IIO_SW_RING
-       bool "IIO Software Ring"
-       help
-         Original IIO ring buffer implementation.  Provides simple
-	 buffer events, half full etc.
-
-endchoice
-
 config SCA3000
 	depends on IIO_BUFFER
 	depends on SPI
diff --git a/drivers/staging/iio/accel/lis3l02dq.h b/drivers/staging/iio/accel/lis3l02dq.h
index 2bac722..0a8ea82 100644
--- a/drivers/staging/iio/accel/lis3l02dq.h
+++ b/drivers/staging/iio/accel/lis3l02dq.h
@@ -185,14 +185,6 @@ int lis3l02dq_probe_trigger(struct iio_dev *indio_dev);
 int lis3l02dq_configure_buffer(struct iio_dev *indio_dev);
 void lis3l02dq_unconfigure_buffer(struct iio_dev *indio_dev);
 
-#ifdef CONFIG_LIS3L02DQ_BUF_RING_SW
-#define lis3l02dq_free_buf iio_sw_rb_free
-#define lis3l02dq_alloc_buf iio_sw_rb_allocate
-#endif
-#ifdef CONFIG_LIS3L02DQ_BUF_KFIFO
-#define lis3l02dq_free_buf iio_kfifo_free
-#define lis3l02dq_alloc_buf iio_kfifo_allocate
-#endif
 irqreturn_t lis3l02dq_data_rdy_trig_poll(int irq, void *private);
 #define lis3l02dq_th lis3l02dq_data_rdy_trig_poll
 
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index bc38651..6861877 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -7,7 +7,6 @@
 #include <linux/export.h>
 
 #include <linux/iio/iio.h>
-#include "../ring_sw.h"
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
@@ -318,7 +317,7 @@ void lis3l02dq_remove_trigger(struct iio_dev *indio_dev)
 void lis3l02dq_unconfigure_buffer(struct iio_dev *indio_dev)
 {
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	lis3l02dq_free_buf(indio_dev->buffer);
+	iio_kfifo_free(indio_dev->buffer);
 }
 
 static int lis3l02dq_buffer_postenable(struct iio_dev *indio_dev)
@@ -401,7 +400,7 @@ int lis3l02dq_configure_buffer(struct iio_dev *indio_dev)
 	int ret;
 	struct iio_buffer *buffer;
 
-	buffer = lis3l02dq_alloc_buf(indio_dev);
+	buffer = iio_kfifo_allocate(indio_dev);
 	if (!buffer)
 		return -ENOMEM;
 
@@ -427,6 +426,6 @@ int lis3l02dq_configure_buffer(struct iio_dev *indio_dev)
 	return 0;
 
 error_iio_sw_rb_free:
-	lis3l02dq_free_buf(indio_dev->buffer);
+	iio_kfifo_free(indio_dev->buffer);
 	return ret;
 }
-- 
1.8.0.1

