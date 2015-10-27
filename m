Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f193.google.com ([209.85.212.193]:33544 "EHLO
	mail-wi0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398AbbJ0SlI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 27 Oct 2015 14:41:08 -0400
Received: by wiut4 with SMTP id t4so29511953wiu.0
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2015 11:41:06 -0700 (PDT)
From: Ioana Ciornei <ciorneiioana@gmail.com>
To: linux-iio@vger.kernel.org
Cc: outreachy-kernel@googlegroups.com, cristina.opriceana@gmail.com,
	Ioana Ciornei <ciorneiioana@gmail.com>
Subject: [PATCH] staging: iio: dummy: complete IIO events delivery to userspace
Date: Tue, 27 Oct 2015 20:40:56 +0200
Message-Id: <1445971256-22474-1-git-send-email-ciorneiioana@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Starting with commit fd2bb310ca (Staging: iio: Move evgen interrupt
generation to irq_work) event processing is handled by calling
both the top half and the threaded part properly simulating real
hardware interrupts making use of threaded interrupts.
This way the processing is split in 2 parts:

* the IRQ handler that runs in IRQ context and only saves the event
timestamp
* the threaded handler that runs in process context, reads the events
and pushes the in the userspace.

If the IRQ handler returns IRQ_HANDLED the threaded handler is not
even being called since the interrupt is considered to be processed.
Because the iio dummy driver processes the events in the threaded
handler the IRQ handler must return IRQ_WAKE_THREAD so that the
threaded part would be awakened and called.

Signed-off-by: Ioana Ciornei <ciorneiioana@gmail.com>
---
rebased on linux-iio tree

 drivers/iio/dummy/iio_simple_dummy_events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy_events.c b/drivers/iio/dummy/iio_simple_dummy_events.c
index bfbf1c5..6eb600f 100644
--- a/drivers/iio/dummy/iio_simple_dummy_events.c
+++ b/drivers/iio/dummy/iio_simple_dummy_events.c
@@ -159,7 +159,7 @@ static irqreturn_t iio_simple_dummy_get_timestamp(int irq, void *private)
 	struct iio_dummy_state *st = iio_priv(indio_dev);
 
 	st->event_timestamp = iio_get_time_ns();
-	return IRQ_HANDLED;
+	return IRQ_WAKE_THREAD;
 }
 
 /**
-- 
2.1.4

