Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:61839 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbaJCB0q (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 2 Oct 2014 21:26:46 -0400
Received: by mail-qa0-f54.google.com with SMTP id i13so214151qae.41
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2014 18:26:45 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: jic23@kernel.org
Cc: B38611@freescale.com, linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 3/5] iio: adc: vf610: Disable the regulator on error
Date: Thu,  2 Oct 2014 22:25:24 -0300
Message-Id: <1412299526-1331-3-git-send-email-festevam@gmail.com>
In-Reply-To: <1412299526-1331-1-git-send-email-festevam@gmail.com>
References: <1412299526-1331-1-git-send-email-festevam@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Fabio Estevam <fabio.estevam@freescale.com>

If clk_prepare_enable() fails we should disable the regulator that was 
previously enabled.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/iio/adc/vf610_adc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index a9c41ec..ae56753 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -680,11 +680,15 @@ static int vf610_adc_resume(struct device *dev)
 
 	ret = clk_prepare_enable(info->clk);
 	if (ret)
-		return ret;
+		goto disable_reg;
 
 	vf610_adc_hw_init(info);
 
 	return 0;
+
+disable_reg:
+	regulator_disable(info->vref);
+	return ret;
 }
 #endif
 
-- 
1.9.1

