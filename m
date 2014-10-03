Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:45525 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbaJCB0o (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 2 Oct 2014 21:26:44 -0400
Received: by mail-qa0-f52.google.com with SMTP id dc16so235188qab.11
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2014 18:26:43 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: jic23@kernel.org
Cc: B38611@freescale.com, linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 2/5] iio: adc: vf610: Return the error code directly
Date: Thu,  2 Oct 2014 22:25:23 -0300
Message-Id: <1412299526-1331-2-git-send-email-festevam@gmail.com>
In-Reply-To: <1412299526-1331-1-git-send-email-festevam@gmail.com>
References: <1412299526-1331-1-git-send-email-festevam@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Fabio Estevam <fabio.estevam@freescale.com>

There is no need to pass the error clock code to the variable 'ret'.

Just return the error directly.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/iio/adc/vf610_adc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index c259901..a9c41ec 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -586,8 +586,7 @@ static int vf610_adc_probe(struct platform_device *pdev)
 	if (IS_ERR(info->clk)) {
 		dev_err(&pdev->dev, "failed getting clock, err = %ld\n",
 						PTR_ERR(info->clk));
-		ret = PTR_ERR(info->clk);
-		return ret;
+		return PTR_ERR(info->clk);
 	}
 
 	info->vref = devm_regulator_get(&pdev->dev, "vref");
-- 
1.9.1

