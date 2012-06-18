Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-105.synserver.de ([212.40.185.105]:1050 "EHLO
	smtp-out-099.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751958Ab2FRLlb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jun 2012 07:41:31 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v4 08/10] staging:iio:adc:ad7793: Use new triggered buffer setup helper function
Date: Mon, 18 Jun 2012 13:45:01 +0200
Message-Id: <1340019903-13305-8-git-send-email-lars@metafoo.de>
In-Reply-To: <1340019903-13305-1-git-send-email-lars@metafoo.de>
References: <1340019903-13305-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use the new triggered buffer setup helper function to allocate and register
buffer and pollfunc.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
No changes in v4
---
 drivers/staging/iio/adc/Kconfig  |    3 +--
 drivers/staging/iio/adc/ad7793.c |   49 +++++---------------------------------
 2 files changed, 7 insertions(+), 45 deletions(-)

diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index ca46627..4fcc4be 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -112,8 +112,7 @@ config AD7793
 	tristate "Analog Devices AD7792 AD7793 ADC driver"
 	depends on SPI
 	select IIO_BUFFER
-	select IIO_KFIFO_BUF
-	select IIO_TRIGGER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices
 	  AD7792 and AD7793 SPI analog to digital converters (ADC).
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index b36556f..2bb9f68 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -21,9 +21,9 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
-#include <linux/iio/kfifo_buf.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #include "ad7793.h"
 
@@ -407,41 +407,13 @@ static const struct iio_buffer_setup_ops ad7793_ring_setup_ops = {
 
 static int ad7793_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 {
-	int ret;
-
-	indio_dev->buffer = iio_kfifo_allocate(indio_dev);
-	if (!indio_dev->buffer) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
-						 &ad7793_trigger_handler,
-						 IRQF_ONESHOT,
-						 indio_dev,
-						 "ad7793_consumer%d",
-						 indio_dev->id);
-	if (indio_dev->pollfunc == NULL) {
-		ret = -ENOMEM;
-		goto error_deallocate_kfifo;
-	}
-
-	/* Ring buffer functions - here trigger setup related */
-	indio_dev->setup_ops = &ad7793_ring_setup_ops;
-
-	/* Flag that polled ring buffering is possible */
-	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
-	return 0;
-
-error_deallocate_kfifo:
-	iio_kfifo_free(indio_dev->buffer);
-error_ret:
-	return ret;
+	return iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
+			&ad7793_trigger_handler, &ad7793_ring_setup_ops);
 }
 
 static void ad7793_ring_cleanup(struct iio_dev *indio_dev)
 {
-	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_kfifo_free(indio_dev->buffer);
+	iio_triggered_buffer_cleanup(indio_dev);
 }
 
 /**
@@ -959,24 +931,16 @@ static int __devinit ad7793_probe(struct spi_device *spi)
 	if (ret)
 		goto error_unreg_ring;
 
-	ret = iio_buffer_register(indio_dev,
-				  indio_dev->channels,
-				  indio_dev->num_channels);
-	if (ret)
-		goto error_remove_trigger;
-
 	ret = ad7793_setup(st);
 	if (ret)
-		goto error_uninitialize_ring;
+		goto error_remove_trigger;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_uninitialize_ring;
+		goto error_remove_trigger;
 
 	return 0;
 
-error_uninitialize_ring:
-	iio_buffer_unregister(indio_dev);
 error_remove_trigger:
 	ad7793_remove_trigger(indio_dev);
 error_unreg_ring:
@@ -999,7 +963,6 @@ static int ad7793_remove(struct spi_device *spi)
 	struct ad7793_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	iio_buffer_unregister(indio_dev);
 	ad7793_remove_trigger(indio_dev);
 	ad7793_ring_cleanup(indio_dev);
 
-- 
1.7.10

