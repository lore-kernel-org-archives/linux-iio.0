Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-015.synserver.de ([212.40.185.15]:1042 "EHLO
	smtp-out-015.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757129Ab3IOQuU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2013 12:50:20 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: [PATCH 15/27] iio:itg3200: Use iio_push_to_buffers_with_timestamp()
Date: Sun, 15 Sep 2013 18:51:08 +0200
Message-Id: <1379263880-18405-15-git-send-email-lars@metafoo.de>
In-Reply-To: <1379263880-18405-1-git-send-email-lars@metafoo.de>
References: <1379263880-18405-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Makes the code a bit shorter and less ugly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
---
 drivers/iio/gyro/itg3200_buffer.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/gyro/itg3200_buffer.c b/drivers/iio/gyro/itg3200_buffer.c
index 6b3c301..e3b3c50 100644
--- a/drivers/iio/gyro/itg3200_buffer.c
+++ b/drivers/iio/gyro/itg3200_buffer.c
@@ -55,11 +55,8 @@ static irqreturn_t itg3200_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto error_ret;
 
-	if (indio_dev->scan_timestamp)
-		memcpy(buf + indio_dev->scan_bytes - sizeof(s64),
-				&pf->timestamp, sizeof(pf->timestamp));
+	iio_push_to_buffers_with_timestamp(indio_dev, buf, pf->timestamp);
 
-	iio_push_to_buffers(indio_dev, buf);
 	iio_trigger_notify_done(indio_dev->trig);
 
 error_ret:
-- 
1.8.0

