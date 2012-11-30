Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57865 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758405Ab2K3OW6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 30 Nov 2012 09:22:58 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 3/5] staging:iio:meter:ade7758 switch from sw_ring to kfifo
Date: Fri, 30 Nov 2012 14:22:50 +0000
Message-Id: <1354285372-11779-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1354285372-11779-1-git-send-email-jic23@kernel.org>
References: <1354285372-11779-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

sw ring is going away so switch over to kfifo based buffer implementation.
The only real change is that poll will return on some data there rather than
buffer 50% full.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/meter/Kconfig        |  2 +-
 drivers/staging/iio/meter/ade7758_ring.c | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/meter/Kconfig b/drivers/staging/iio/meter/Kconfig
index d290d27..e53274b 100644
--- a/drivers/staging/iio/meter/Kconfig
+++ b/drivers/staging/iio/meter/Kconfig
@@ -21,7 +21,7 @@ config ADE7758
 	tristate "Analog Devices ADE7758 Poly Phase Multifunction Energy Metering IC Driver"
 	depends on SPI
 	select IIO_TRIGGER if IIO_BUFFER
-	select IIO_SW_RING if IIO_BUFFER
+	select IIO_KFIFO_BUF if IIO_BUFFER
 	help
 	  Say yes here to build support for Analog Devices ADE7758 Polyphase
 	  Multifunction Energy Metering IC with Per Phase Information Driver.
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index 4552a4c..b29e2d5 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -13,7 +13,7 @@
 #include <asm/unaligned.h>
 
 #include <linux/iio/iio.h>
-#include "../ring_sw.h"
+#include <linux/iio/kfifo_buf.h>
 #include <linux/iio/trigger_consumer.h>
 #include "ade7758.h"
 
@@ -119,7 +119,7 @@ static const struct iio_buffer_setup_ops ade7758_ring_setup_ops = {
 void ade7758_unconfigure_ring(struct iio_dev *indio_dev)
 {
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->buffer);
+	iio_kfifo_free(indio_dev->buffer);
 }
 
 int ade7758_configure_ring(struct iio_dev *indio_dev)
@@ -127,7 +127,7 @@ int ade7758_configure_ring(struct iio_dev *indio_dev)
 	struct ade7758_state *st = iio_priv(indio_dev);
 	int ret = 0;
 
-	indio_dev->buffer = iio_sw_rb_allocate(indio_dev);
+	indio_dev->buffer = iio_kfifo_allocate(indio_dev);
 	if (!indio_dev->buffer) {
 		ret = -ENOMEM;
 		return ret;
@@ -143,7 +143,7 @@ int ade7758_configure_ring(struct iio_dev *indio_dev)
 						 indio_dev->id);
 	if (indio_dev->pollfunc == NULL) {
 		ret = -ENOMEM;
-		goto error_iio_sw_rb_free;
+		goto error_iio_kfifo_free;
 	}
 
 	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
@@ -183,8 +183,8 @@ int ade7758_configure_ring(struct iio_dev *indio_dev)
 
 	return 0;
 
-error_iio_sw_rb_free:
-	iio_sw_rb_free(indio_dev->buffer);
+error_iio_kfifo_free:
+	iio_kfifo_free(indio_dev->buffer);
 	return ret;
 }
 
-- 
1.8.0.1

