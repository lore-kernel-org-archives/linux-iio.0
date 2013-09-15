Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-015.synserver.de ([212.40.185.15]:1050 "EHLO
	smtp-out-015.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932379Ab3IOQue (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2013 12:50:34 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 23/27] staging:iio:ad7606: Use iio_push_to_buffers_with_timestamp()
Date: Sun, 15 Sep 2013 18:51:16 +0200
Message-Id: <1379263880-18405-23-git-send-email-lars@metafoo.de>
In-Reply-To: <1379263880-18405-1-git-send-email-lars@metafoo.de>
References: <1379263880-18405-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Makes the code a bit shorter and less ugly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7606_ring.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index 2b25cb0..3bf174c 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -46,7 +46,6 @@ static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
 	struct ad7606_state *st = container_of(work_s, struct ad7606_state,
 						poll_work);
 	struct iio_dev *indio_dev = iio_priv_to_dev(st);
-	s64 time_ns;
 	__u8 *buf;
 	int ret;
 
@@ -78,12 +77,7 @@ static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
 			goto done;
 	}
 
-	time_ns = iio_get_time_ns();
-
-	if (indio_dev->scan_timestamp)
-		*((s64 *)(buf + indio_dev->scan_bytes - sizeof(s64))) = time_ns;
-
-	iio_push_to_buffers(indio_dev, buf);
+	iio_push_to_buffers_with_timestamp(indio_dev, buf, iio_get_time_ns());
 done:
 	gpio_set_value(st->pdata->gpio_convst, 0);
 	iio_trigger_notify_done(indio_dev->trig);
-- 
1.8.0

