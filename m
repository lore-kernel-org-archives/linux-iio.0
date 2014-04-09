Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 5.mo3.mail-out.ovh.net ([87.98.178.36]:49631 "EHLO
	mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934297AbaDIT0W (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Apr 2014 15:26:22 -0400
Received: from mail404.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id 58637FFA4F3
	for <linux-iio@vger.kernel.org>; Wed,  9 Apr 2014 20:10:24 +0200 (CEST)
From: Joel Porquet <joel@porquet.org>
To: jic23@kernel.org, gregkh@linuxfoundation.org, jg1.han@samsung.com
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, Joel Porquet <joel@porquet.org>
Subject: [PATCH] staging: iio: fix coding style
Date: Wed,  9 Apr 2014 20:09:45 +0200
Message-Id: <1397066985-2504-1-git-send-email-joel@porquet.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

As suggested by checkpatch.pl, use dev_info() instead of
printk(KERN_INFO ...) to print message.

Signed-off-by: Joel Porquet <joel@porquet.org>
---
Only tested by compilation.
 drivers/staging/iio/trigger/iio-trig-periodic-rtc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
index 48a6afa..38ecb4b 100644
--- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
+++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
@@ -33,7 +33,8 @@ static int iio_trig_periodic_rtc_set_state(struct iio_trigger *trig, bool state)
 	struct iio_prtc_trigger_info *trig_info = iio_trigger_get_drvdata(trig);
 	if (trig_info->frequency == 0)
 		return -EINVAL;
-	printk(KERN_INFO "trigger frequency is %d\n", trig_info->frequency);
+	dev_info(&trig_info->rtc->dev, "trigger frequency is %d\n",
+			trig_info->frequency);
 	return rtc_irq_set_state(trig_info->rtc, &trig_info->task, state);
 }
 
-- 
1.9.1

