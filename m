Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57871 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758404Ab2K3OW6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 30 Nov 2012 09:22:58 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 4/5] staging:iio:imu: adis16400 switch from sw_ring to kfifo
Date: Fri, 30 Nov 2012 14:22:51 +0000
Message-Id: <1354285372-11779-5-git-send-email-jic23@kernel.org>
In-Reply-To: <1354285372-11779-1-git-send-email-jic23@kernel.org>
References: <1354285372-11779-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

sw ring is going away so switch over to kfifo based buffer implementation.
The only real change is that poll will return on some data there rather than
buffer 50% full.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/imu/Kconfig          |  2 +-
 drivers/staging/iio/imu/adis16400_ring.c | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/imu/Kconfig b/drivers/staging/iio/imu/Kconfig
index 2c2f47d..b9d9c14 100644
--- a/drivers/staging/iio/imu/Kconfig
+++ b/drivers/staging/iio/imu/Kconfig
@@ -6,7 +6,7 @@ menu "Inertial measurement units"
 config ADIS16400
 	tristate "Analog Devices ADIS16400 and similar IMU SPI driver"
 	depends on SPI
-	select IIO_SW_RING if IIO_BUFFER
+	select IIO_KFIFO_BUF if IIO_BUFFER
 	select IIO_TRIGGER if IIO_BUFFER
 	help
 	  Say yes here to build support for Analog Devices adis16300, adis16344,
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index d46c1e3..319c2c0 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -7,7 +7,7 @@
 #include <linux/export.h>
 
 #include <linux/iio/iio.h>
-#include "../ring_sw.h"
+#include <linux/iio/kfifo_buf.h>
 #include <linux/iio/trigger_consumer.h>
 #include "adis16400.h"
 
@@ -161,7 +161,7 @@ done:
 void adis16400_unconfigure_ring(struct iio_dev *indio_dev)
 {
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->buffer);
+	iio_kfifo_free(indio_dev->buffer);
 }
 
 static const struct iio_buffer_setup_ops adis16400_ring_setup_ops = {
@@ -175,7 +175,7 @@ int adis16400_configure_ring(struct iio_dev *indio_dev)
 	int ret = 0;
 	struct iio_buffer *ring;
 
-	ring = iio_sw_rb_allocate(indio_dev);
+	ring = iio_kfifo_allocate(indio_dev);
 	if (!ring) {
 		ret = -ENOMEM;
 		return ret;
@@ -193,12 +193,12 @@ int adis16400_configure_ring(struct iio_dev *indio_dev)
 						 indio_dev->id);
 	if (indio_dev->pollfunc == NULL) {
 		ret = -ENOMEM;
-		goto error_iio_sw_rb_free;
+		goto error_iio_kfifo_free;
 	}
 
 	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 	return 0;
-error_iio_sw_rb_free:
-	iio_sw_rb_free(indio_dev->buffer);
+error_iio_kfifo_free:
+	iio_kfifo_free(indio_dev->buffer);
 	return ret;
 }
-- 
1.8.0.1

