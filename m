Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-015.synserver.de ([212.40.185.15]:1025 "EHLO
	smtp-out-015.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932216Ab3IOQuV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2013 12:50:21 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 16/27] iio:adis16400: Use iio_push_to_buffers_with_timestamp()
Date: Sun, 15 Sep 2013 18:51:09 +0200
Message-Id: <1379263880-18405-16-git-send-email-lars@metafoo.de>
In-Reply-To: <1379263880-18405-1-git-send-email-lars@metafoo.de>
References: <1379263880-18405-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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

