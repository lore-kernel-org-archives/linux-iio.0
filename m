Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yh0-f49.google.com ([209.85.213.49]:51850 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbaBND2p (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 13 Feb 2014 22:28:45 -0500
Received: by mail-yh0-f49.google.com with SMTP id t59so11075945yho.36
        for <linux-iio@vger.kernel.org>; Thu, 13 Feb 2014 19:28:44 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: jic23@kernel.org
Cc: marex@denx.de, linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] iio: mxs-lradc: Propagate the real error code on platform_get_irq() failure
Date: Fri, 14 Feb 2014 01:28:35 -0200
Message-Id: <1392348515-11420-1-git-send-email-festevam@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Fabio Estevam <fabio.estevam@freescale.com>

No need to return a 'fake' return value on platform_get_irq() failure.

Just return the error code itself instead.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/staging/iio/adc/mxs-lradc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index d304156..ab3c0d4 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -1558,7 +1558,7 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 	for (i = 0; i < of_cfg->irq_count; i++) {
 		lradc->irq[i] = platform_get_irq(pdev, i);
 		if (lradc->irq[i] < 0)
-			return -EINVAL;
+			return lradc->irq[i];
 
 		ret = devm_request_irq(dev, lradc->irq[i],
 					mxs_lradc_handle_irq, 0,
-- 
1.8.1.2

