Return-Path: <SRS0=XRxs=YG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2FEC4360C
	for <linux-iio@archiver.kernel.org>; Sun, 13 Oct 2019 16:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE72206B7
	for <linux-iio@archiver.kernel.org>; Sun, 13 Oct 2019 16:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570985154;
	bh=ryhMiATLml3l/5aCftyLtvPKh+gC9yvP1osjd+nGwxg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=x1x2AjZKGxzlBE5wXJPIAbI3Tp+LKKCIPDlEUhTnyUkMjwjv+9VpIeEE5JmmQvgvb
	 q08BqNcBcFR2paUDfIGpAmKghEIGk+f3vAzdXobwrbBW0rZwwwxvnfMchBklHWuZU5
	 BmRNi67FwZHZ/20uUI5ivKryJ43Ixj+qosZINs1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfJMQpy (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 13 Oct 2019 12:45:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:32950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbfJMQpx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 12:45:53 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 891FA20679;
        Sun, 13 Oct 2019 16:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570985153;
        bh=ryhMiATLml3l/5aCftyLtvPKh+gC9yvP1osjd+nGwxg=;
        h=From:To:Cc:Subject:Date:From;
        b=VWuIUM63NrdIeyT/kpFIpsAD5HA3DIRQiHoCT4bM3Jp//mIGPVphCxFEblkRFjyrJ
         2fCPpWk0/Rg72kfpByNPwPaWWCE8QZDKuod2DiXdzLrb+IrE6z4NwCJ4UZEQx/Evwv
         P2GA3DpgAwuZPft/Q53QBdT5esZrYW8ZfM6Mf/w4=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fugang Duan <b38611@freescale.com>
Subject: [PATCH] iio: adc: vf610: use devm_platform_ioremap_resource
Date:   Sun, 13 Oct 2019 17:43:49 +0100
Message-Id: <20191013164349.2049538-1-jic23@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reduces boilerplate.

Suggested by coccinelle
CHECK   drivers/iio/adc/vf610_adc.c
drivers/iio/adc/vf610_adc.c:819:1-11: WARNING: Use devm_platform_ioremap_resource for info -> regs

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Fugang Duan <b38611@freescale.com>
---
 drivers/iio/adc/vf610_adc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index 98b30475bbc6..cb7380bf07ca 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -802,7 +802,6 @@ static int vf610_adc_probe(struct platform_device *pdev)
 {
 	struct vf610_adc *info;
 	struct iio_dev *indio_dev;
-	struct resource *mem;
 	int irq;
 	int ret;
 
@@ -815,8 +814,7 @@ static int vf610_adc_probe(struct platform_device *pdev)
 	info = iio_priv(indio_dev);
 	info->dev = &pdev->dev;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	info->regs = devm_ioremap_resource(&pdev->dev, mem);
+	info->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(info->regs))
 		return PTR_ERR(info->regs);
 
-- 
2.23.0

