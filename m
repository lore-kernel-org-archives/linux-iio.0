Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:35744 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbaJCB0l (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 2 Oct 2014 21:26:41 -0400
Received: by mail-qg0-f47.google.com with SMTP id i50so244617qgf.20
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2014 18:26:40 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: jic23@kernel.org
Cc: B38611@freescale.com, linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 1/5] iio: adc: vf610: Propagate the real error when platform_get_irq() fails
Date: Thu,  2 Oct 2014 22:25:22 -0300
Message-Id: <1412299526-1331-1-git-send-email-festevam@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Fabio Estevam <fabio.estevam@freescale.com>

There is no need to pass a 'fake' return value when platform_get_irq() fails.

Propagate the real error instead. 

While at it, only consider negative numbers returned by platform_get_irq()
as error.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/iio/adc/vf610_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index 4a10ae9..c259901 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -569,9 +569,9 @@ static int vf610_adc_probe(struct platform_device *pdev)
 		return PTR_ERR(info->regs);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
+	if (irq < 0) {
 		dev_err(&pdev->dev, "no irq resource?\n");
-		return -EINVAL;
+		return irq;
 	}
 
 	ret = devm_request_irq(info->dev, irq,
-- 
1.9.1

