Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60086 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275Ab3JWRAi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 23 Oct 2013 13:00:38 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] iio: adc: ti_am335x_adc: do not free the kfifo twice
Date: Wed, 23 Oct 2013 19:00:23 +0200
Message-Id: <1382547624-15256-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Since commit 9e69c9 ("iio: Add reference counting for buffers") the iio
core frees the buffer. So if the driver does it as well then bad things
will happen.

Cc: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

By no means I am the expert here but the other users of iio_kfifo_free() like

drivers/iio/industrialio-triggered-buffer.c:    iio_kfifo_free(indio_dev->buffer);
drivers/iio/industrialio-triggered-buffer.c:    iio_kfifo_free(indio_dev->buffer);

are probably wrong, too. Not to mention staging. So *I* think iio_kfifo_free()
should vanish from the tree.

 drivers/iio/adc/ti_am335x_adc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index f974dea..3d70f09 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -254,8 +254,6 @@ static int tiadc_iio_buffered_hardware_setup(struct iio_dev *indio_dev,
 
 error_free_irq:
 	free_irq(irq, indio_dev);
-error_kfifo_free:
-	iio_kfifo_free(indio_dev->buffer);
 	return ret;
 }
 
@@ -264,7 +262,6 @@ static void tiadc_iio_buffered_hardware_remove(struct iio_dev *indio_dev)
 	struct tiadc_device *adc_dev = iio_priv(indio_dev);
 
 	free_irq(adc_dev->mfd_tscadc->irq, indio_dev);
-	iio_kfifo_free(indio_dev->buffer);
 	iio_buffer_unregister(indio_dev);
 }
 
-- 
1.8.4.rc3

