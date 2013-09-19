Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 24/24] staging:iio:ade7758: Use iio_push_to_buffers_with_timestamp()
Date: Thu, 19 Sep 2013 15:00:01 +0200
Message-Id: <1379595601-26448-24-git-send-email-lars@metafoo.de>
In-Reply-To: <1379595601-26448-1-git-send-email-lars@metafoo.de>
References: <1379595601-26448-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Makes the code a bit shorter and less ugly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/meter/ade7758_ring.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index 3d8bc2d..4080995 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -69,11 +69,7 @@ static irqreturn_t ade7758_trigger_handler(int irq, void *p)
 		if (ade7758_spi_read_burst(indio_dev) >= 0)
 			*dat32 = get_unaligned_be32(&st->rx_buf[5]) & 0xFFFFFF;
 
-	/* Guaranteed to be aligned with 8 byte boundary */
-	if (indio_dev->scan_timestamp)
-		dat64[1] = pf->timestamp;
-
-	iio_push_to_buffers(indio_dev, dat64);
+	iio_push_to_buffers_with_timestamp(indio_dev, dat64, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
1.8.0
