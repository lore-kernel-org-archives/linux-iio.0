Return-Path: <SRS0=XRxs=YG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C687C4CECE
	for <linux-iio@archiver.kernel.org>; Sun, 13 Oct 2019 12:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E04D2084D
	for <linux-iio@archiver.kernel.org>; Sun, 13 Oct 2019 12:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570969262;
	bh=2a/uBt3E2/oqtRbPfDRkNHjm3CK0r5VffgrNjB1CbWc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=s8pKyDPQko8GNoGfFL+wZrB7xOOR5Rcpe84P4wR8AHl52Nc5C6hglYNdMhtoBbuQu
	 C7RkihPpOX3h1dH9FcxXRGPQ6sYzvISQBv/OkNA0JyRRLLxFdJpDs+P5xbDIvDaYBK
	 6WUvCIHjgSFTmw/7gIksPi68E2gcXlcejnYnUcYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbfJMMVB (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 13 Oct 2019 08:21:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728620AbfJMMVB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 08:21:01 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38D532082F;
        Sun, 13 Oct 2019 12:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570969261;
        bh=2a/uBt3E2/oqtRbPfDRkNHjm3CK0r5VffgrNjB1CbWc=;
        h=From:To:Cc:Subject:Date:From;
        b=qIl3PLknZ3ZC8/zMjmD13xCSzg7HfodoM8GxH+ugkqToVUs86eIwqUcfZx7sNtEVe
         D9LzS/OOJUcENoVtrISF6Z0igtvQgMiqBy6rVVMLU+Xy4SXK0ylsy8LKIJydMyE3Q3
         /YLCgqXVN0w1vdGzDow3qC07af0N8sxmP2MYKv3U=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Subject: [PATCH] iio: adc: bcm_iproc_adc: drop a stray semicolon
Date:   Sun, 13 Oct 2019 13:18:56 +0100
Message-Id: <20191013121856.1782707-1-jic23@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Found by coccinelle / coccicheck

CHECK   drivers/iio/adc/bcm_iproc_adc.c
drivers/iio/adc/bcm_iproc_adc.c:311:3-4: Unneeded semicolon

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
---
 drivers/iio/adc/bcm_iproc_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index 646ebdc0a8b4..5e396104ac86 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -308,7 +308,7 @@ static int iproc_adc_do_read(struct iio_dev *indio_dev,
 				"IntMask set failed. Read will likely fail.");
 			read_len = -EIO;
 			goto adc_err;
-		};
+		}
 	}
 	regmap_read(adc_priv->regmap, IPROC_INTERRUPT_MASK, &val_check);
 
-- 
2.23.0

