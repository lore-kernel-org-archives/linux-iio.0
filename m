Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 07/11] staging:iio:max1363: Do not return error code in interrupt handler
Date: Wed,  4 Jul 2012 18:09:29 +0200
Message-Id: <1341418173-3217-7-git-send-email-lars@metafoo.de>
In-Reply-To: <1341418173-3217-1-git-send-email-lars@metafoo.de>
References: <1341418173-3217-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The interrupt handler should only ever return one of the three irqreturn_t
constants and not an error code. Also make sure to always call
iio_trigger_notify_done before leaving the trigger handler.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/max1363_ring.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index b302013..bf6b0c2 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -64,11 +64,11 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
 	 * no harm.
 	 */
 	if (numvals == 0)
-		return IRQ_HANDLED;
+		goto done;
 
 	rxbuf = kmalloc(d_size,	GFP_KERNEL);
 	if (rxbuf == NULL)
-		return -ENOMEM;
+		goto done;
 	if (st->chip_info->bits != 8)
 		b_sent = i2c_master_recv(st->client, rxbuf, numvals*2);
 	else
-- 
1.7.10
