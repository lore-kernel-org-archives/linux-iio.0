Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Denis Ciocca <denis.ciocca@gmail.com>
Subject: [PATCH 11/24] iio:st_sensors: Use iio_push_to_buffers_with_timestamp()
Date: Thu, 19 Sep 2013 14:59:48 +0200
Message-Id: <1379595601-26448-11-git-send-email-lars@metafoo.de>
In-Reply-To: <1379595601-26448-1-git-send-email-lars@metafoo.de>
References: <1379595601-26448-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Makes the code a bit shorter and less ugly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Denis Ciocca <denis.ciocca@gmail.com>
---
 drivers/iio/common/st_sensors/st_sensors_buffer.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
index 71a2c5f..1665c8e 100644
--- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
+++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
@@ -113,11 +113,8 @@ irqreturn_t st_sensors_trigger_handler(int irq, void *p)
 	if (len < 0)
 		goto st_sensors_get_buffer_element_error;
 
-	if (indio_dev->scan_timestamp)
-		*(s64 *)((u8 *)sdata->buffer_data +
-				ALIGN(len, sizeof(s64))) = pf->timestamp;
-
-	iio_push_to_buffers(indio_dev, sdata->buffer_data);
+	iio_push_to_buffers_with_timestamp(indio_dev, sdata->buffer_data,
+		pf->timestamp);
 
 st_sensors_get_buffer_element_error:
 	iio_trigger_notify_done(indio_dev->trig);
-- 
1.8.0
