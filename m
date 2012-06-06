Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-134.synserver.de ([212.40.185.134]:1249 "EHLO
	smtp-out-123.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753152Ab2FFMAX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 6 Jun 2012 08:00:23 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 8/9] staging:iio:adc:ad7887: Use new triggered buffer setup helper function
Date: Wed,  6 Jun 2012 13:55:55 +0200
Message-Id: <1338983756-31243-9-git-send-email-lars@metafoo.de>
In-Reply-To: <1338983756-31243-1-git-send-email-lars@metafoo.de>
References: <1338983756-31243-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use the new triggered buffer setup helper function to allocate and register
buffer and pollfunc.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/Kconfig       |    1 +
 drivers/staging/iio/adc/ad7887_core.c |    9 ---------
 drivers/staging/iio/adc/ad7887_ring.c |   33 +++------------------------------
 3 files changed, 4 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index d654cd3..36cca0e 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -92,6 +92,7 @@ config AD7887
 	select IIO_BUFFER
 	select IIO_KFIFO_BUF
 	select IIO_TRIGGER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices
 	  AD7887 SPI analog to digital converter (ADC).
diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/adc/ad7887_core.c
index 7186074..397b849 100644
--- a/drivers/staging/iio/adc/ad7887_core.c
+++ b/drivers/staging/iio/adc/ad7887_core.c
@@ -201,20 +201,12 @@ static int __devinit ad7887_probe(struct spi_device *spi)
 	if (ret)
 		goto error_disable_reg;
 
-	ret = iio_buffer_register(indio_dev,
-				  indio_dev->channels,
-				  indio_dev->num_channels);
-	if (ret)
-		goto error_cleanup_ring;
-
 	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_unregister_ring;
 
 	return 0;
 error_unregister_ring:
-	iio_buffer_unregister(indio_dev);
-error_cleanup_ring:
 	ad7887_ring_cleanup(indio_dev);
 error_disable_reg:
 	if (!IS_ERR(st->reg))
@@ -233,7 +225,6 @@ static int ad7887_remove(struct spi_device *spi)
 	struct ad7887_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	iio_buffer_unregister(indio_dev);
 	ad7887_ring_cleanup(indio_dev);
 	if (!IS_ERR(st->reg)) {
 		regulator_disable(st->reg);
diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
index fd91384..bd48810 100644
--- a/drivers/staging/iio/adc/ad7887_ring.c
+++ b/drivers/staging/iio/adc/ad7887_ring.c
@@ -112,38 +112,11 @@ static const struct iio_buffer_setup_ops ad7887_ring_setup_ops = {
 
 int ad7887_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 {
-	int ret;
-
-	indio_dev->buffer = iio_kfifo_allocate(indio_dev);
-	if (!indio_dev->buffer) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
-						 &ad7887_trigger_handler,
-						 IRQF_ONESHOT,
-						 indio_dev,
-						 "ad7887_consumer%d",
-						 indio_dev->id);
-	if (indio_dev->pollfunc == NULL) {
-		ret = -ENOMEM;
-		goto error_deallocate_kfifo;
-	}
-	/* Ring buffer functions - here trigger setup related */
-	indio_dev->setup_ops = &ad7887_ring_setup_ops;
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
+			&ad7887_trigger_handler, &ad7887_ring_setup_ops);
 }
 
 void ad7887_ring_cleanup(struct iio_dev *indio_dev)
 {
-	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_kfifo_free(indio_dev->buffer);
+	iio_triggered_buffer_cleanup(indio_dev);
 }
-- 
1.7.10

