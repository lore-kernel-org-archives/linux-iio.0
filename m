Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:59334
	"EHLO VA3EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752097Ab1LLKmu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 12 Dec 2011 05:42:50 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>, <drivers@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 08/13] staging:iio:adc:ad7887: Use new ringbuffer setup helper function
Date: Mon, 12 Dec 2011 11:43:00 +0100
Message-ID: <1323686585-15181-8-git-send-email-lars@metafoo.de>
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
 drivers/staging/iio/adc/ad7887_core.c |    9 ---------
 drivers/staging/iio/adc/ad7887_ring.c |   33 +++------------------------------
 2 files changed, 3 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/adc/ad7887_core.c
index db7e91f..1eb845b 100644
--- a/drivers/staging/iio/adc/ad7887_core.c
+++ b/drivers/staging/iio/adc/ad7887_core.c
@@ -199,20 +199,12 @@ static int __devinit ad7887_probe(struct spi_device *spi)
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
@@ -231,7 +223,6 @@ static int ad7887_remove(struct spi_device *spi)
 	struct ad7887_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	iio_buffer_unregister(indio_dev);
 	ad7887_ring_cleanup(indio_dev);
 	if (!IS_ERR(st->reg)) {
 		regulator_disable(st->reg);
diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
index d180907..0552b3b 100644
--- a/drivers/staging/iio/adc/ad7887_ring.c
+++ b/drivers/staging/iio/adc/ad7887_ring.c
@@ -124,38 +124,11 @@ static const struct iio_buffer_setup_ops ad7887_ring_setup_ops = {
 
 int ad7887_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 {
-	int ret;
-
-	indio_dev->buffer = iio_sw_rb_allocate(indio_dev);
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
-		goto error_deallocate_sw_rb;
-	}
-	/* Ring buffer functions - here trigger setup related */
-	indio_dev->setup_ops = &ad7887_ring_setup_ops;
-
-	/* Flag that polled ring buffering is possible */
-	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
-	return 0;
-
-error_deallocate_sw_rb:
-	iio_sw_rb_free(indio_dev->buffer);
-error_ret:
-	return ret;
+	return iio_sw_rb_simple_setup(indio_dev, &iio_pollfunc_store_time,
+			&ad7887_trigger_handler, &ad7887_ring_setup_ops);
 }
 
 void ad7887_ring_cleanup(struct iio_dev *indio_dev)
 {
-	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->buffer);
+	iio_sw_rb_simple_cleanup(indio_dev);
 }
-- 
1.7.7.3


