Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f195.google.com ([209.85.212.195]:35184 "EHLO
	mail-wi0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932274AbbJ0P0h (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 27 Oct 2015 11:26:37 -0400
Received: by wicuv6 with SMTP id uv6so28267572wic.2
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2015 08:26:36 -0700 (PDT)
From: Ioana Ciornei <ciorneiioana@gmail.com>
To: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org
Cc: Ioana Ciornei <ciorneiioana@gmail.com>
Subject: [PATCH] staging: iio: change IRQ_HANDLED to IRQ_WAKE_THREAD
Date: Tue, 27 Oct 2015 17:26:27 +0200
Message-Id: <1445959587-25953-1-git-send-email-ciorneiioana@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch changes the return value of the primary interrupt handler to
IRQ_WAKE_THREAD in order to wake the kernel thread represented by the
iio_simple_dummy_event_handler function and continue handling the event.

Signed-off-by: Ioana Ciornei <ciorneiioana@gmail.com>
---
 drivers/staging/iio/iio_simple_dummy_events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/iio_simple_dummy_events.c b/drivers/staging/iio/iio_simple_dummy_events.c
index bfbf1c5..6eb600f 100644
--- a/drivers/staging/iio/iio_simple_dummy_events.c
+++ b/drivers/staging/iio/iio_simple_dummy_events.c
@@ -159,7 +159,7 @@ static irqreturn_t iio_simple_dummy_get_timestamp(int irq, void *private)
 	struct iio_dummy_state *st = iio_priv(indio_dev);
 
 	st->event_timestamp = iio_get_time_ns();
-	return IRQ_HANDLED;
+	return IRQ_WAKE_THREAD;
 }
 
 /**
-- 
2.1.4

