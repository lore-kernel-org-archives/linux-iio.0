Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 14.mo4.mail-out.ovh.net ([46.105.40.29]:47573 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754572Ab2LLQiu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Dec 2012 11:38:50 -0500
Received: from mail613.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id 78EC4104DF7E
	for <linux-iio@vger.kernel.org>; Wed, 12 Dec 2012 16:28:06 +0100 (CET)
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH 1/1] iio: at91: fix dev var name in at91_adc_trigger_handler
Date: Wed, 12 Dec 2012 16:17:52 +0100
Message-Id: <1355325472-31836-1-git-send-email-plagnioj@jcrosoft.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

/opt/work/linux-2.6/drivers/iio/adc/at91_adc.c: In function 'at91_adc_trigger_handler':
/opt/work/linux-2.6/drivers/iio/adc/at91_adc.c:83:22: error: 'indio_dev' undeclared (first use in this function)
/opt/work/linux-2.6/drivers/iio/adc/at91_adc.c:83:22: note: each undeclared identifier is reported only once for each function it appears in

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/adc/at91_adc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 03b8594..315bed1 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -80,7 +80,7 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
 		*timestamp = pf->timestamp;
 	}
 
-	iio_push_to_buffers(indio_dev, (u8 *)st->buffer);
+	iio_push_to_buffers(idev, (u8 *)st->buffer);
 
 	iio_trigger_notify_done(idev->trig);
 
-- 
1.7.10.4

