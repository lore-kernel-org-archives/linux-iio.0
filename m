Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:37542 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758736Ab2I1Xcl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 28 Sep 2012 19:32:41 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	maxime.ripard@free-electrons.com
Subject: [PATCH 2/2] iio: use iio_push_to_buffer() in at91 driver
Date: Sat, 29 Sep 2012 01:32:37 +0200
Message-Id: <1348875157-7793-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1348875157-7793-1-git-send-email-pmeerw@pmeerw.net>
References: <1348875157-7793-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: maxime.ripard@free-electrons.com
---
 drivers/iio/adc/at91_adc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index b3ba8af..2e2c9a8 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -81,7 +81,7 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
 		*timestamp = pf->timestamp;
 	}
 
-	buffer->access->store_to(buffer, (u8 *)st->buffer);
+	iio_push_to_buffer(buffer, st->buffer);
 
 	iio_trigger_notify_done(idev->trig);
 
-- 
1.7.9.5

