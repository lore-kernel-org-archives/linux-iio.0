Return-Path: <SRS0=XRxs=YG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A38C4360C
	for <linux-iio@archiver.kernel.org>; Sun, 13 Oct 2019 17:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71F9206A3
	for <linux-iio@archiver.kernel.org>; Sun, 13 Oct 2019 17:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570988458;
	bh=zk1FaFnPn1Esfrwi8hrj2LjpE0HP/rCsA7+OTmkJuYc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=vK9Cy+/BtUIS9+H8bxZbfoqmZSNmaZD0ovkWAaQizCLbbL+0YvD8TcN0JObwSncfK
	 RnBOf15Z3jc60PHcCEknN8x6ynRocp3FedB5LptgBJeMxLLVddNRjvq69i41HwpXpg
	 nguV7KOE3R6eGDBEK6UUwVif76wUCM7NtXA4eO1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfJMRk6 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 13 Oct 2019 13:40:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbfJMRk6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 13:40:58 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C26C52067B;
        Sun, 13 Oct 2019 17:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570988457;
        bh=zk1FaFnPn1Esfrwi8hrj2LjpE0HP/rCsA7+OTmkJuYc=;
        h=From:To:Cc:Subject:Date:From;
        b=b7GWP/PSX7SNuB49WSduBRMKmDEitcuXwvIwenD2jFHz4ljOGvDDLMc79kfBlyyMf
         LnvxRNPhq9iBil8De1HZZ72o1qQ8+CXYZ90yqO4gjnnsqvHyWAp4t5S/1YzVKbmMpj
         Uqphhsjo2BJNa4psA0E6CetS7fbzZYBZuKMdK8qE=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] iio: light: adux1020: Drop an unwanted semicolon.
Date:   Sun, 13 Oct 2019 18:38:52 +0100
Message-Id: <20191013173852.2265620-1-jic23@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Suggested by coccinelle

CHECK   drivers/iio/light/adux1020.c
drivers/iio/light/adux1020.c:747:2-3: Unneeded semicolon

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/iio/light/adux1020.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
index 830e5e95d58f..b07797ac10d7 100644
--- a/drivers/iio/light/adux1020.c
+++ b/drivers/iio/light/adux1020.c
@@ -744,7 +744,7 @@ static int adux1020_chip_init(struct adux1020_data *data)
 	if ((val & ADUX1020_CHIP_ID_MASK) != ADUX1020_CHIP_ID) {
 		dev_err(&client->dev, "invalid chip id 0x%04x\n", val);
 		return -ENODEV;
-	};
+	}
 
 	dev_dbg(&client->dev, "Detected ADUX1020 with chip id: 0x%04x\n", val);
 
-- 
2.23.0

