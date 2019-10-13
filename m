Return-Path: <SRS0=XRxs=YG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79E5C4360C
	for <linux-iio@archiver.kernel.org>; Sun, 13 Oct 2019 15:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4836206A3
	for <linux-iio@archiver.kernel.org>; Sun, 13 Oct 2019 15:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570980562;
	bh=t0+p6TgklzOjQdG4PjeUbUTej3vX9nNU5EuOdgKaM2o=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Px4JMqUGllhZmn28FDKGOtYJ3alOOzLSleZAwRVuQ89etZzqVSYdi1ElGGLHp1ldj
	 Gy8Ay+sua/52MLdflR2/k1Va4Rjln3RpJQSSCVom4CJf1gSHkpaMdc/lClDY2TU25d
	 ijXo9MCOPfIGRR+yddE/RqMPVOXUMDAABShRNtJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfJMP3W (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 13 Oct 2019 11:29:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbfJMP3W (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 11:29:22 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A32A220679;
        Sun, 13 Oct 2019 15:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570980561;
        bh=t0+p6TgklzOjQdG4PjeUbUTej3vX9nNU5EuOdgKaM2o=;
        h=From:To:Cc:Subject:Date:From;
        b=SlwdqYtpt2lhvKgjSlr9ldliCRjmIrw1rT7nzLNL8xc4vB6fadC3ojTaRvMGm4gH3
         5W0T8bLfGpjFk6QBtdZCJ+Lc5NxxET+beIl2szh3UKb6XxGyQn5Z5KoAMrfQjZUg3O
         b7CjrlT4zArWQtfCPdDRAg1SfTz0B2q1c4/EiOIE=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH] iio: adc: ingenic: Use devm_platform_ioremap_resource
Date:   Sun, 13 Oct 2019 16:27:16 +0100
Message-Id: <20191013152716.1830911-1-jic23@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Replaces local boilerplate.  Identified by coccinelle.
CHECK   drivers/iio/adc/ingenic-adc.c
drivers/iio/adc/ingenic-adc.c:449:1-10: WARNING: Use devm_platform_ioremap_resource for adc -> base

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Artur Rojek <contact@artur-rojek.eu>
---
 drivers/iio/adc/ingenic-adc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index 7a53c2f8d438..39c0a609fc94 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -428,7 +428,6 @@ static int ingenic_adc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct iio_dev *iio_dev;
 	struct ingenic_adc *adc;
-	struct resource *mem_base;
 	const struct ingenic_adc_soc_data *soc_data;
 	int ret;
 
@@ -445,8 +444,7 @@ static int ingenic_adc_probe(struct platform_device *pdev)
 	mutex_init(&adc->aux_lock);
 	adc->soc_data = soc_data;
 
-	mem_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	adc->base = devm_ioremap_resource(dev, mem_base);
+	adc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(adc->base))
 		return PTR_ERR(adc->base);
 
-- 
2.23.0

