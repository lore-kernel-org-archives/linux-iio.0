Return-Path: <SRS0=XRxs=YG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EC6C4360C
	for <linux-iio@archiver.kernel.org>; Sun, 13 Oct 2019 08:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7842520700
	for <linux-iio@archiver.kernel.org>; Sun, 13 Oct 2019 08:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570957195;
	bh=pn8hSh8Fe79AwCHNy+N56x9s85BACA/JfjKLjRPEA4k=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ovxye/ED7oCFCacLwwP/n01E0hBLFQwJapGYcK24Wu5iY281xgsr4rGVQLhoCsqQ7
	 nANUX8JxYpA6TyQkh7E8KR8/OmdIW6ilj5HmDsgK2p6fRknV9lw5w2elTdiVkxWPGd
	 yDQBGldl4JJslX9Q+s1gu+68ftzRGoYaKzxWpUsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfJMI7y (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 13 Oct 2019 04:59:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728080AbfJMI7y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 04:59:54 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BDDA206B7;
        Sun, 13 Oct 2019 08:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570957194;
        bh=pn8hSh8Fe79AwCHNy+N56x9s85BACA/JfjKLjRPEA4k=;
        h=From:To:Cc:Subject:Date:From;
        b=QsP7AbYPJ8Fmcl2C+tpxgieIxXQbwsq2sNSy19lMqG7KjxVE7V0lWSJMvWn/bVyhv
         DuOx1pSzEEQz/7jI66oO+vrjn3AxNYXXr2fnQ4FbQGh37R6T/M81pwSieOC/N4cBih
         EGBS8yhdAhARxyl8duhv3/62/it6daoq6Y8L/zoY=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH] iio:adc:at91-sama5d2: Replace 0 with NULL when clearing some pointers.
Date:   Sun, 13 Oct 2019 09:57:23 +0100
Message-Id: <20191013085723.1366012-1-jic23@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Cleans up the sparse warning:

CHECK   drivers/iio/adc/at91-sama5d2_adc.c
drivers/iio/adc/at91-sama5d2_adc.c:1486:31: warning: Using plain integer as NULL pointer
drivers/iio/adc/at91-sama5d2_adc.c:1509:31: warning: Using plain integer as NULL pointer

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index a2837a0e7cba..e1850f3d5cf3 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1483,7 +1483,7 @@ static void at91_adc_dma_init(struct platform_device *pdev)
 			  st->dma_st.rx_buf, st->dma_st.rx_dma_buf);
 dma_chan_disable:
 	dma_release_channel(st->dma_st.dma_chan);
-	st->dma_st.dma_chan = 0;
+	st->dma_st.dma_chan = NULL;
 dma_exit:
 	dev_info(&pdev->dev, "continuing without DMA support\n");
 }
@@ -1506,7 +1506,7 @@ static void at91_adc_dma_disable(struct platform_device *pdev)
 	dma_free_coherent(st->dma_st.dma_chan->device->dev, pages * PAGE_SIZE,
 			  st->dma_st.rx_buf, st->dma_st.rx_dma_buf);
 	dma_release_channel(st->dma_st.dma_chan);
-	st->dma_st.dma_chan = 0;
+	st->dma_st.dma_chan = NULL;
 
 	dev_info(&pdev->dev, "continuing without DMA support\n");
 }
-- 
2.23.0

