Return-Path: <SRS0=AGAg=QZ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719CBC43381
	for <linux-iio@archiver.kernel.org>; Mon, 18 Feb 2019 06:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC1E2177E
	for <linux-iio@archiver.kernel.org>; Mon, 18 Feb 2019 06:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfBRGn7 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 18 Feb 2019 01:43:59 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3758 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725836AbfBRGn7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 18 Feb 2019 01:43:59 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D2A1F480B3769EA2A0E2;
        Mon, 18 Feb 2019 14:43:54 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Mon, 18 Feb 2019 14:43:48 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Artur Rojek <contact@artur-rojek.eu>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-iio@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] iio: adc: ingenic: remove redundant dev_err call in ingenic_adc_probe()
Date:   Mon, 18 Feb 2019 06:57:35 +0000
Message-ID: <20190218065735.159915-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Fixes: 1a78daea107d ("IIO: add Ingenic JZ47xx ADC driver.")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/iio/adc/ingenic-adc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index 6ee1673deb0d..8f9c125939a8 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -302,10 +302,8 @@ static int ingenic_adc_probe(struct platform_device *pdev)
 
 	mem_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	adc->base = devm_ioremap_resource(dev, mem_base);
-	if (IS_ERR(adc->base)) {
-		dev_err(dev, "Unable to ioremap mmio resource\n");
+	if (IS_ERR(adc->base))
 		return PTR_ERR(adc->base);
-	}
 
 	adc->clk = devm_clk_get(dev, "adc");
 	if (IS_ERR(adc->clk)) {



