Return-Path: <SRS0=XRxs=YG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E77C4360C
	for <linux-iio@archiver.kernel.org>; Sun, 13 Oct 2019 15:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C542082F
	for <linux-iio@archiver.kernel.org>; Sun, 13 Oct 2019 15:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570981205;
	bh=zyQwJK6JaXvVvOFs2Arw+Y+LF7K36n42LICiryFjqs4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=guy2NVSOq1pRu/78dcYxmEAq/B/Wf1tY8qf57fX/RpRqw2l2mOz7iTrTl5viHYQk1
	 oVp9KsDn0C6JzIxfAl3Zd3fSYbAARux5up+xXOB9ZjTQC0BMzPZ16HusLLIL1yWDEz
	 Fack5WcNAWTpWbNasqZQk87cfRWmrsZoMnJIvNiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfJMPkE (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 13 Oct 2019 11:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbfJMPkE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 11:40:04 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF3D320663;
        Sun, 13 Oct 2019 15:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570981203;
        bh=zyQwJK6JaXvVvOFs2Arw+Y+LF7K36n42LICiryFjqs4=;
        h=From:To:Cc:Subject:Date:From;
        b=I7jyyYSfkUDvMI7fhV8e4WgZXhe0zvwfytGPK6B0NWtDS/M0HJE/N6AeZovaHKTUs
         j4SB3sM5LZ6c0ogucuN6HwmSpjLgJxVDl0j+RbOx8g9uaNixNCOgfOaZavye4pFzc5
         ULE59/u5w2lJCZWpSWEVjceoSc0I8zA/SMssou7g=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] iio: adc: meson_saradc: use devm_platform_ioremap_resource
Date:   Sun, 13 Oct 2019 16:37:59 +0100
Message-Id: <20191013153759.1840761-1-jic23@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Avoid local boilerplate.
Suggested by coccinelle via coccicheck.
CHECK   drivers/iio/adc/meson_saradc.c
drivers/iio/adc/meson_saradc.c:1218:1-5: WARNING: Use devm_platform_ioremap_resource for base

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/iio/adc/meson_saradc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 7b28d045d271..256048baf5d0 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -1187,7 +1187,6 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
 	const struct meson_sar_adc_data *match_data;
 	struct meson_sar_adc_priv *priv;
 	struct iio_dev *indio_dev;
-	struct resource *res;
 	void __iomem *base;
 	int irq, ret;
 
@@ -1214,8 +1213,7 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &meson_sar_adc_iio_info;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
2.23.0

