Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio:adc:max1363 actually make timestamp controllable
Date: Sun, 27 Nov 2011 12:22:21 +0000
Message-Id: <1322396541-29959-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@cam.ac.uk>

Previously timestamps were always on in this driver.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
A random minor fixlet that has been in my tree far too long.

 drivers/staging/iio/adc/max1363_ring.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index a87fbe8..3c5e199 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -138,9 +138,8 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
 		goto done;
 
 	time_ns = iio_get_time_ns();
-
-	memcpy(rxbuf + d_size - sizeof(s64), &time_ns, sizeof(time_ns));
-
+	if (indio_dev->buffer->scan_timestamp)
+		memcpy(rxbuf + d_size - sizeof(s64), &time_ns, sizeof(time_ns));
 	indio_dev->buffer->access->store_to(indio_dev->buffer, rxbuf, time_ns);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
-- 
1.7.7.3
