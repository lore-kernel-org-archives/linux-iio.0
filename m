Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 10/11] staging:iio:adis16260: Do not return error code in the interrupt handler
Date: Wed,  4 Jul 2012 18:09:32 +0200
Message-Id: <1341418173-3217-10-git-send-email-lars@metafoo.de>
In-Reply-To: <1341418173-3217-1-git-send-email-lars@metafoo.de>
References: <1341418173-3217-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The interrupt handler should only ever return one of the three irqreturn_t
constants and not an error code. Also make sure to always call
iio_trigger_notify_done before leaving the trigger handler.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/adis16260_ring.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index 0fe2d9d..eeee8e7 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -69,7 +69,7 @@ static irqreturn_t adis16260_trigger_handler(int irq, void *p)
 	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(&st->us->dev, "memory alloc failed in ring bh");
-		return -ENOMEM;
+		goto done;
 	}
 
 	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength) &&
@@ -84,8 +84,9 @@ static irqreturn_t adis16260_trigger_handler(int irq, void *p)
 
 	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
 
-	iio_trigger_notify_done(indio_dev->trig);
 	kfree(data);
+done:
+	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
 }
-- 
1.7.10
