Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:55256 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846AbaINXjb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Sep 2014 19:39:31 -0400
Received: by mail-yk0-f169.google.com with SMTP id 20so1701210yks.28
        for <linux-iio@vger.kernel.org>; Sun, 14 Sep 2014 16:39:30 -0700 (PDT)
From: Chris Ruffin <cmruffin@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Chris Ruffin <cmruffin@gmail.com>
Subject: [PATCH] staging: iio: accel: remove unnecessary syntax
Date: Sun, 14 Sep 2014 19:38:57 -0400
Message-Id: <1410737937-10773-1-git-send-email-cmruffin@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The else clause in the conditional of lis3l02dq_data_rdy_trig_poll()
does not make consistent use of braces with the rest of the
conditional.  Fix this coding style problem by removing the
unnecessary conditional altogether.

Signed-off-by: Chris Ruffin <cmruffin@gmail.com>
---
 drivers/staging/iio/accel/lis3l02dq_ring.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 1d934ee..9efc77b 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -34,8 +34,9 @@ irqreturn_t lis3l02dq_data_rdy_trig_poll(int irq, void *private)
 	if (st->trigger_on) {
 		iio_trigger_poll(st->trig);
 		return IRQ_HANDLED;
-	} else
-		return IRQ_WAKE_THREAD;
+	}
+
+	return IRQ_WAKE_THREAD;
 }
 
 static const u8 read_all_tx_array[] = {
-- 
1.7.10.4

