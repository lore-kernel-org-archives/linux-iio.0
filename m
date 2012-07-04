Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/11] staging:iio:ad7298: Do not return error code in interrupt handler
Date: Wed,  4 Jul 2012 18:09:23 +0200
Message-Id: <1341418173-3217-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The interrupt handler should only ever return one of the three irqreturn_t
constants and not an error code. Also make sure to always call
iio_trigger_notify_done before leaving the trigger handler.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7298_ring.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
index cd3e9cb..fd1d855 100644
--- a/drivers/staging/iio/adc/ad7298_ring.c
+++ b/drivers/staging/iio/adc/ad7298_ring.c
@@ -82,7 +82,7 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
 
 	b_sent = spi_sync(st->spi, &st->ring_msg);
 	if (b_sent)
-		return b_sent;
+		goto done;
 
 	if (indio_dev->scan_timestamp) {
 		time_ns = iio_get_time_ns();
@@ -95,6 +95,8 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
 		buf[i] = be16_to_cpu(st->rx_buf[i]);
 
 	indio_dev->buffer->access->store_to(ring, (u8 *)buf, time_ns);
+
+done:
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
-- 
1.7.10
