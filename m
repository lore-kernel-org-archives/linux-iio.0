Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 13/24] iio:adis16400: Use iio_push_to_buffers_with_timestamp()
Date: Thu, 19 Sep 2013 14:59:50 +0200
Message-Id: <1379595601-26448-13-git-send-email-lars@metafoo.de>
In-Reply-To: <1379595601-26448-1-git-send-email-lars@metafoo.de>
References: <1379595601-26448-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Makes the code a bit shorter and less ugly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/imu/adis16400_buffer.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/adis16400_buffer.c b/drivers/iio/imu/adis16400_buffer.c
index 054c01d..f2cf829 100644
--- a/drivers/iio/imu/adis16400_buffer.c
+++ b/drivers/iio/imu/adis16400_buffer.c
@@ -82,13 +82,8 @@ irqreturn_t adis16400_trigger_handler(int irq, void *p)
 		spi_setup(st->adis.spi);
 	}
 
-	/* Guaranteed to be aligned with 8 byte boundary */
-	if (indio_dev->scan_timestamp) {
-		void *b = adis->buffer + indio_dev->scan_bytes - sizeof(s64);
-		*(s64 *)b = pf->timestamp;
-	}
-
-	iio_push_to_buffers(indio_dev, adis->buffer);
+	iio_push_to_buffers_with_timestamp(indio_dev, adis->buffer,
+		pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
1.8.0
