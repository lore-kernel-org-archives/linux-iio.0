Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F172C4338F
	for <linux-iio@archiver.kernel.org>; Tue, 27 Jul 2021 12:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50E2261A4F
	for <linux-iio@archiver.kernel.org>; Tue, 27 Jul 2021 12:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhG0Mvx (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 27 Jul 2021 08:51:53 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:7318 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbhG0Mvw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jul 2021 08:51:52 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee661000147f3b-9972f; Tue, 27 Jul 2021 20:51:19 +0800 (CST)
X-RM-TRANSID: 2ee661000147f3b-9972f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee261000142a5e-9392f;
        Tue, 27 Jul 2021 20:51:18 +0800 (CST)
X-RM-TRANSID: 2ee261000142a5e-9392f
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] iio: adc: fsl-imx25-gcq: fix the right check and simplify code
Date:   Tue, 27 Jul 2021 20:52:09 +0800
Message-Id: <20210727125209.28248-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

For the function of platform_get_irq(), the example in platform.c is
*		int irq = platform_get_irq(pdev, 0);
*		if (irq < 0)
*			return irq;
So the return value of zero is unnecessary to check. And move it
up to a little bit can simplify the code jump.

Co-developed-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/iio/adc/fsl-imx25-gcq.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
index 8cb51cf7a..d28976f21 100644
--- a/drivers/iio/adc/fsl-imx25-gcq.c
+++ b/drivers/iio/adc/fsl-imx25-gcq.c
@@ -320,6 +320,10 @@ static int mx25_gcq_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	priv->irq = platform_get_irq(pdev, 0);
+	if (priv->irq < 0)
+		return priv->irq;
+
 	for (i = 0; i != 4; ++i) {
 		if (!priv->vref[i])
 			continue;
@@ -336,14 +340,6 @@ static int mx25_gcq_probe(struct platform_device *pdev)
 		goto err_vref_disable;
 	}
 
-	priv->irq = platform_get_irq(pdev, 0);
-	if (priv->irq <= 0) {
-		ret = priv->irq;
-		if (!ret)
-			ret = -ENXIO;
-		goto err_clk_unprepare;
-	}
-
 	ret = request_irq(priv->irq, mx25_gcq_irq, 0, pdev->name, priv);
 	if (ret) {
 		dev_err(dev, "Failed requesting IRQ\n");
-- 
2.20.1.windows.1



