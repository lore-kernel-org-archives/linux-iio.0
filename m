Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:45559
	"EHLO VA3EHSOBE007.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752097Ab1LLKnJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 12 Dec 2011 05:43:09 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>, <drivers@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 13/13] staging:iio:meter:ade7758: Use new ringbuffer setup helper function
Date: Mon, 12 Dec 2011 11:43:05 +0100
Message-ID: <1323686585-15181-13-git-send-email-lars@metafoo.de>
In-Reply-To: <1323686585-15181-1-git-send-email-lars@metafoo.de>
References: <1323686585-15181-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use the new ringbuffer setup helper function to allocate and register buffer and
pollfunc.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/meter/ade7758.h      |    8 ------
 drivers/staging/iio/meter/ade7758_core.c |   11 ---------
 drivers/staging/iio/meter/ade7758_ring.c |   36 ++++-------------------------
 3 files changed, 5 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7758.h b/drivers/staging/iio/meter/ade7758.h
index bdd1b05..2a6c4ad 100644
--- a/drivers/staging/iio/meter/ade7758.h
+++ b/drivers/staging/iio/meter/ade7758.h
@@ -150,7 +150,6 @@ ssize_t ade7758_read_data_from_ring(struct device *dev,
 int ade7758_configure_ring(struct iio_dev *indio_dev);
 void ade7758_unconfigure_ring(struct iio_dev *indio_dev);
 
-void ade7758_uninitialize_ring(struct iio_dev *indio_dev);
 int ade7758_set_irq(struct device *dev, bool enable);
 
 int ade7758_spi_write_reg_8(struct device *dev,
@@ -175,13 +174,6 @@ static int ade7758_configure_ring(struct iio_dev *indio_dev)
 static inline void ade7758_unconfigure_ring(struct iio_dev *indio_dev)
 {
 }
-static inline int ade7758_initialize_ring(struct iio_ring_buffer *ring)
-{
-	return 0;
-}
-static inline void ade7758_uninitialize_ring(struct iio_dev *indio_dev)
-{
-}
 #endif /* CONFIG_IIO_BUFFER */
 
 #endif
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 9dc881f..fd1993a 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -774,14 +774,6 @@ static int __devinit ade7758_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_tx;
 
-	ret = iio_buffer_register(indio_dev,
-				  &ade7758_channels[0],
-				  ARRAY_SIZE(ade7758_channels));
-	if (ret) {
-		dev_err(&spi->dev, "failed to initialize the ring\n");
-		goto error_unreg_ring_funcs;
-	}
-
 	/* Get the device into a sane initial state */
 	ret = ade7758_initial_setup(indio_dev);
 	if (ret)
@@ -803,8 +795,6 @@ error_remove_trigger:
 	if (indio_dev->modes & INDIO_BUFFER_TRIGGERED)
 		ade7758_remove_trigger(indio_dev);
 error_uninitialize_ring:
-	ade7758_uninitialize_ring(indio_dev);
-error_unreg_ring_funcs:
 	ade7758_unconfigure_ring(indio_dev);
 error_free_tx:
 	kfree(st->tx);
@@ -828,7 +818,6 @@ static int ade7758_remove(struct spi_device *spi)
 		goto err_ret;
 
 	ade7758_remove_trigger(indio_dev);
-	ade7758_uninitialize_ring(indio_dev);
 	ade7758_unconfigure_ring(indio_dev);
 	kfree(st->tx);
 	kfree(st->rx);
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index c5c522b..808e6f9 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -129,35 +129,18 @@ static const struct iio_buffer_setup_ops ade7758_ring_setup_ops = {
 
 void ade7758_unconfigure_ring(struct iio_dev *indio_dev)
 {
-	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->buffer);
+	iio_sw_rb_simple_cleanup(indio_dev);
 }
 
 int ade7758_configure_ring(struct iio_dev *indio_dev)
 {
 	struct ade7758_state *st = iio_priv(indio_dev);
-	int ret = 0;
+	int ret;
 
-	indio_dev->buffer = iio_sw_rb_allocate(indio_dev);
-	if (!indio_dev->buffer) {
-		ret = -ENOMEM;
+	ret = iio_sw_rb_simple_setup(indio_dev, &iio_pollfunc_store_time,
+			&ade7758_trigger_handler, &ade7758_ring_setup_ops);
+	if (ret)
 		return ret;
-	}
-
-	indio_dev->setup_ops = &ade7758_ring_setup_ops;
-
-	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
-						 &ade7758_trigger_handler,
-						 0,
-						 indio_dev,
-						 "ade7759_consumer%d",
-						 indio_dev->id);
-	if (indio_dev->pollfunc == NULL) {
-		ret = -ENOMEM;
-		goto error_iio_sw_rb_free;
-	}
-
-	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 
 	st->tx_buf[0] = ADE7758_READ_REG(ADE7758_RSTATUS);
 	st->tx_buf[1] = 0;
@@ -193,13 +176,4 @@ int ade7758_configure_ring(struct iio_dev *indio_dev)
 	spi_message_add_tail(&st->ring_xfer[3], &st->ring_msg);
 
 	return 0;
-
-error_iio_sw_rb_free:
-	iio_sw_rb_free(indio_dev->buffer);
-	return ret;
-}
-
-void ade7758_uninitialize_ring(struct iio_dev *indio_dev)
-{
-	iio_buffer_unregister(indio_dev);
 }
-- 
1.7.7.3


