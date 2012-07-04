Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/11] staging:iio:lis3l02dq: Do not return error code in interrupt handler
Date: Wed,  4 Jul 2012 18:09:30 +0200
Message-Id: <1341418173-3217-8-git-send-email-lars@metafoo.de>
In-Reply-To: <1341418173-3217-1-git-send-email-lars@metafoo.de>
References: <1341418173-3217-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The interrupt handler should only ever return one of the three irqreturn_t
constants and not an error code. Also make sure to always call
iio_trigger_notify_done before leaving the trigger handler.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/accel/lis3l02dq_ring.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 51b00df..d7f8af7 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -143,7 +143,7 @@ static irqreturn_t lis3l02dq_trigger_handler(int irq, void *p)
 	if (data == NULL) {
 		dev_err(indio_dev->dev.parent,
 			"memory alloc failed in buffer bh");
-		return -ENOMEM;
+		goto done;
 	}
 
 	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
@@ -156,8 +156,9 @@ static irqreturn_t lis3l02dq_trigger_handler(int irq, void *p)
 			= pf->timestamp;
 	buffer->access->store_to(buffer, (u8 *)data, pf->timestamp);
 
-	iio_trigger_notify_done(indio_dev->trig);
 	kfree(data);
+done:
+	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;
 }
 
-- 
1.7.10
