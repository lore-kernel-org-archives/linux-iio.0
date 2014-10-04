Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:56990 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbaJDLuw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 4 Oct 2014 07:50:52 -0400
Received: by mail-qa0-f47.google.com with SMTP id cm18so1844277qab.34
        for <linux-iio@vger.kernel.org>; Sat, 04 Oct 2014 04:50:51 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: jic23@kernel.org
Cc: marex@denx.de, linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] iio: adc: mxs-lradc: Disable the clock on probe failure
Date: Sat,  4 Oct 2014 08:50:21 -0300
Message-Id: <1412423421-5951-1-git-send-email-festevam@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Fabio Estevam <fabio.estevam@freescale.com>

We should disable lradc->clk in the case of errors in the probe function.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/staging/iio/adc/mxs-lradc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 32a1926..2a29b9b 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -1559,14 +1559,16 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 	/* Grab all IRQ sources */
 	for (i = 0; i < of_cfg->irq_count; i++) {
 		lradc->irq[i] = platform_get_irq(pdev, i);
-		if (lradc->irq[i] < 0)
-			return lradc->irq[i];
+		if (lradc->irq[i] < 0) {
+			ret = lradc->irq[i];
+			goto err_clk;
+		}
 
 		ret = devm_request_irq(dev, lradc->irq[i],
 					mxs_lradc_handle_irq, 0,
 					of_cfg->irq_name[i], iio);
 		if (ret)
-			return ret;
+			goto err_clk;
 	}
 
 	lradc->vref_mv = of_cfg->vref_mv;
@@ -1588,7 +1590,7 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 				&mxs_lradc_trigger_handler,
 				&mxs_lradc_buffer_ops);
 	if (ret)
-		return ret;
+		goto err_clk;
 
 	ret = mxs_lradc_trigger_init(iio);
 	if (ret)
@@ -1643,6 +1645,8 @@ err_dev:
 	mxs_lradc_trigger_remove(iio);
 err_trig:
 	iio_triggered_buffer_cleanup(iio);
+err_clk:
+	clk_disable_unprepare(lradc->clk);
 	return ret;
 }
 
-- 
1.9.1

