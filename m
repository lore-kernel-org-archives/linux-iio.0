Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-015.synserver.de ([212.40.185.15]:1087 "EHLO
	smtp-out-015.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932344Ab3IOQui (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2013 12:50:38 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Marek Vasut <marex@denx.de>
Subject: [PATCH 25/27] staging:iio:mxs-lradc: Use iio_push_to_buffers_with_timestamp()
Date: Sun, 15 Sep 2013 18:51:18 +0200
Message-Id: <1379263880-18405-25-git-send-email-lars@metafoo.de>
In-Reply-To: <1379263880-18405-1-git-send-email-lars@metafoo.de>
References: <1379263880-18405-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Makes the code a bit shorter and less ugly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Marek Vasut <marex@denx.de>
---
 drivers/staging/iio/adc/mxs-lradc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 7401230..9da64bf 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -625,13 +625,7 @@ static irqreturn_t mxs_lradc_trigger_handler(int irq, void *p)
 		j++;
 	}
 
-	if (iio->scan_timestamp) {
-		s64 *timestamp = (s64 *)((u8 *)lradc->buffer +
-					ALIGN(j, sizeof(s64)));
-		*timestamp = pf->timestamp;
-	}
-
-	iio_push_to_buffers(iio, lradc->buffer);
+	iio_push_to_buffers_with_timestamp(iio, lradc->buffer, pf->timestamp);
 
 	iio_trigger_notify_done(iio->trig);
 
-- 
1.8.0

