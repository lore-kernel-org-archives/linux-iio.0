Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 03/11] staging:iio:dummy driver: Do not return error code in interrupt handler
Date: Wed,  4 Jul 2012 18:09:25 +0200
Message-Id: <1341418173-3217-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1341418173-3217-1-git-send-email-lars@metafoo.de>
References: <1341418173-3217-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The interrupt handler should only ever return one of the three irqreturn_t
constants and not an error code. Also make sure to always call
iio_trigger_notify_done before leaving the trigger handler.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/iio_simple_dummy_buffer.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
index b9e6093..c0951f9 100644
--- a/drivers/staging/iio/iio_simple_dummy_buffer.c
+++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
@@ -52,7 +52,7 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 
 	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (data == NULL)
-		return -ENOMEM;
+		goto done;
 
 	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength)) {
 		/*
@@ -91,6 +91,7 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 
 	kfree(data);
 
+done:
 	/*
 	 * Tell the core we are done with this trigger and ready for the
 	 * next one.
-- 
1.7.10
