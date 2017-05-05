Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34416 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752330AbdEEAc0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 May 2017 20:32:26 -0400
Received: by mail-pg0-f53.google.com with SMTP id 12so339667pgc.1
        for <linux-iio@vger.kernel.org>; Thu, 04 May 2017 17:32:26 -0700 (PDT)
From: Matt Ranostay <matt.ranostay@konsulko.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        stable@vger.kernel.org
Subject: [PATCH] iio: proximity: as3935: fix iio_trigger_poll issue
Date: Thu,  4 May 2017 17:32:19 -0700
Message-Id: <20170505003219.17570-1-matt.ranostay@konsulko.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Using iio_trigger_poll() can oops when multiple interrupts
happen before the first is handled.

Use iio_trigger_poll_chained() instead and use the timestamp
when processed, since it will be in theory be 2 ms max latency.

Fixes: 24ddb0e4bba4 ("iio: Add AS3935 lightning sensor support")
Cc: stable@vger.kernel.org
Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/proximity/as3935.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index ddf9bee89f77..d98d38227f26 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -215,7 +215,7 @@ static irqreturn_t as3935_trigger_handler(int irq, void *private)
 
 	st->buffer[0] = val & AS3935_DATA_MASK;
 	iio_push_to_buffers_with_timestamp(indio_dev, &st->buffer,
-					   pf->timestamp);
+					   iio_get_time_ns(indio_dev));
 err_read:
 	iio_trigger_notify_done(indio_dev->trig);
 
@@ -244,7 +244,7 @@ static void as3935_event_work(struct work_struct *work)
 
 	switch (val) {
 	case AS3935_EVENT_INT:
-		iio_trigger_poll(st->trig);
+		iio_trigger_poll_chained(st->trig);
 		break;
 	case AS3935_NOISE_INT:
 		dev_warn(&st->spi->dev, "noise level is too high\n");
-- 
2.11.0

