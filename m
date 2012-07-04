Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/11] staging:iio:ad7476: Do not return error code in interrupt handler
Date: Wed,  4 Jul 2012 18:09:27 +0200
Message-Id: <1341418173-3217-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1341418173-3217-1-git-send-email-lars@metafoo.de>
References: <1341418173-3217-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The interrupt handler should only ever return one of the three irqreturn_t
constants and not an error code. Also make sure to always call
iio_trigger_notify_done before leaving the trigger handler.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7476_ring.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
index 10f8b8d..d087b21 100644
--- a/drivers/staging/iio/adc/ad7476_ring.c
+++ b/drivers/staging/iio/adc/ad7476_ring.c
@@ -31,7 +31,7 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
 
 	rxbuf = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (rxbuf == NULL)
-		return -ENOMEM;
+		goto done;
 
 	b_sent = spi_read(st->spi, rxbuf,
 			  st->chip_info->channel[0].scan_type.storagebits / 8);
-- 
1.7.10
