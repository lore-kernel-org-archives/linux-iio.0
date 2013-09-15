Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-015.synserver.de ([212.40.185.15]:1050 "EHLO
	smtp-out-015.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757129Ab3IOQuW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2013 12:50:22 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Denis Ciocca <denis.ciocca@gmail.com>
Subject: [PATCH 14/27] iio:st_sensors: Use iio_push_to_buffers_with_timestamp()
Date: Sun, 15 Sep 2013 18:51:07 +0200
Message-Id: <1379263880-18405-14-git-send-email-lars@metafoo.de>
In-Reply-To: <1379263880-18405-1-git-send-email-lars@metafoo.de>
References: <1379263880-18405-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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

