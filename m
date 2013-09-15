Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-015.synserver.de ([212.40.185.15]:1046 "EHLO
	smtp-out-015.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757145Ab3IOQty (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2013 12:49:54 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: [PATCH 05/27] iio:bma180: Use iio_push_buffers_with_timestamp()
Date: Sun, 15 Sep 2013 18:50:58 +0200
Message-Id: <1379263880-18405-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1379263880-18405-1-git-send-email-lars@metafoo.de>
References: <1379263880-18405-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Makes the code shorter and a bit less ugly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
---
 drivers/iio/accel/bma180.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 3eff246..bda7a83 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -471,13 +471,10 @@ static irqreturn_t bma180_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bma180_data *data = iio_priv(indio_dev);
+	int64_t time_ns = iio_get_time_ns();
 	int bit, ret, i = 0;
 
 	mutex_lock(&data->mutex);
-	if (indio_dev->scan_timestamp) {
-		ret = indio_dev->scan_bytes / sizeof(s64) - 1;
-		((s64 *)data->buff)[ret] = iio_get_time_ns();
-	}
 
 	for_each_set_bit(bit, indio_dev->buffer->scan_mask,
 			 indio_dev->masklength) {
@@ -490,7 +487,7 @@ static irqreturn_t bma180_trigger_handler(int irq, void *p)
 	}
 	mutex_unlock(&data->mutex);
 
-	iio_push_to_buffers(indio_dev, data->buff);
+	iio_push_to_buffers_with_timestamp(indio_dev, data->buff, time_ns);
 err:
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
1.8.0

