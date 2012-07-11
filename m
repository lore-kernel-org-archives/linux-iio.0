Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Fengguang Wu <wfg@linux.intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio:max1363: Don't free uninitialized variable
Date: Wed, 11 Jul 2012 11:28:23 +0200
Message-Id: <1341998903-4702-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

It is possible that on one of the error paths we are going to try to free
'rxbuf', even though it has not been allocated yet, which cause the following
warning:
	drivers/staging/iio/adc/max1363_ring.c: In function 'max1363_trigger_handler':
		drivers/staging/iio/adc/max1363_ring.c:87:7: warning: 'rxbuf' may be used
		uninitialized in this function

Reported-by: Fengguang Wu <wfg@linux.intel.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/max1363_ring.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index bf6b0c2..774ae1b 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -74,7 +74,7 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
 	else
 		b_sent = i2c_master_recv(st->client, rxbuf, numvals);
 	if (b_sent < 0)
-		goto done;
+		goto done_free;
 
 	time_ns = iio_get_time_ns();
 
@@ -82,9 +82,10 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
 		memcpy(rxbuf + d_size - sizeof(s64), &time_ns, sizeof(time_ns));
 	iio_push_to_buffer(indio_dev->buffer, rxbuf, time_ns);
 
+done_free:
+	kfree(rxbuf);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
-	kfree(rxbuf);
 
 	return IRQ_HANDLED;
 }
-- 
1.7.10.4
