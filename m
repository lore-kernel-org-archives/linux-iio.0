Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:45635 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbaJCB0s (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 2 Oct 2014 21:26:48 -0400
Received: by mail-qg0-f50.google.com with SMTP id q108so239811qgd.37
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2014 18:26:48 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: jic23@kernel.org
Cc: B38611@freescale.com, linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 4/5] iio: adc: vf610: SIMPLE_DEV_PM_OPS can fit on a single line
Date: Thu,  2 Oct 2014 22:25:25 -0300
Message-Id: <1412299526-1331-4-git-send-email-festevam@gmail.com>
In-Reply-To: <1412299526-1331-1-git-send-email-festevam@gmail.com>
References: <1412299526-1331-1-git-send-email-festevam@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Fabio Estevam <fabio.estevam@freescale.com>

No need to call the SIMPLE_DEV_PM_OPS() macro in several lines.

It can fit into the 80-column range.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/iio/adc/vf610_adc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index ae56753..6164558 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -692,9 +692,7 @@ disable_reg:
 }
 #endif
 
-static SIMPLE_DEV_PM_OPS(vf610_adc_pm_ops,
-			vf610_adc_suspend,
-			vf610_adc_resume);
+static SIMPLE_DEV_PM_OPS(vf610_adc_pm_ops, vf610_adc_suspend, vf610_adc_resume);
 
 static struct platform_driver vf610_adc_driver = {
 	.probe          = vf610_adc_probe,
-- 
1.9.1

