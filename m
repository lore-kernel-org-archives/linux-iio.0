Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:60006 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757153AbcJSRHU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Oct 2016 13:07:20 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/13] staging:iio:ad7606: Avoid allocating buffer for each data capture
Date: Wed, 19 Oct 2016 19:07:01 +0200
Message-Id: <1476896828-10544-7-git-send-email-lars@metafoo.de>
In-Reply-To: <1476896828-10544-1-git-send-email-lars@metafoo.de>
References: <1476896828-10544-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currently the ad7606 driver dynamically allocates and frees a transfer
buffer each time a sample capture is performed in buffered mode, which
introduces unnecessary overhead. The driver state struct already contains a
buffer that is used for transfers in one-shot mode. This buffer is large
enough to hold all samples, but not the timestamp that might be present in
buffered mode. Extend the buffer size to be able to contain the timestamp
and update the buffered capture function to use this buffer.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7606.h      |  4 ++--
 drivers/staging/iio/adc/ad7606_ring.c | 14 ++++----------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
index cf6be65..129f94e 100644
--- a/drivers/staging/iio/adc/ad7606.h
+++ b/drivers/staging/iio/adc/ad7606.h
@@ -68,9 +68,9 @@ struct ad7606_state {
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
+	 * 8 * 16-bit samples + 64-bit timestamp
 	 */
-
-	unsigned short			data[8] ____cacheline_aligned;
+	unsigned short			data[12] ____cacheline_aligned;
 };
 
 struct ad7606_bus_ops {
diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index 0572df9..7fa4ccc 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -46,15 +46,10 @@ static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
 	struct ad7606_state *st = container_of(work_s, struct ad7606_state,
 						poll_work);
 	struct iio_dev *indio_dev = iio_priv_to_dev(st);
-	__u8 *buf;
 	int ret;
 
-	buf = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
-	if (!buf)
-		return;
-
 	if (gpio_is_valid(st->pdata->gpio_frstdata)) {
-		ret = st->bops->read_block(st->dev, 1, buf);
+		ret = st->bops->read_block(st->dev, 1, st->data);
 		if (ret)
 			goto done;
 		if (!gpio_get_value(st->pdata->gpio_frstdata)) {
@@ -67,22 +62,21 @@ static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
 			goto done;
 		}
 		ret = st->bops->read_block(st->dev,
-			st->chip_info->num_channels - 1, buf + 2);
+			st->chip_info->num_channels - 1, st->data + 1);
 		if (ret)
 			goto done;
 	} else {
 		ret = st->bops->read_block(st->dev,
-			st->chip_info->num_channels, buf);
+			st->chip_info->num_channels, st->data);
 		if (ret)
 			goto done;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buf,
+	iio_push_to_buffers_with_timestamp(indio_dev, st->data,
 					   iio_get_time_ns(indio_dev));
 done:
 	gpio_set_value(st->pdata->gpio_convst, 0);
 	iio_trigger_notify_done(indio_dev->trig);
-	kfree(buf);
 }
 
 int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
-- 
2.1.4

