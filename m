Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46073C433B4
	for <linux-iio@archiver.kernel.org>; Sat,  1 May 2021 16:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2804B61446
	for <linux-iio@archiver.kernel.org>; Sat,  1 May 2021 16:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhEAQzo (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 1 May 2021 12:55:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230195AbhEAQzo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 12:55:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07A3C61477;
        Sat,  1 May 2021 16:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619888094;
        bh=36uePG+qgyqQVBTud8/t51FHRljBV4GAYAz6sngmxGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cw/U1k7Jv27q12Vyb7/iyZWLgDOWxSjm9bHJS3cfMZq3TZUeRHRwJ+XQFvsP4pP9D
         WMPTHn1OA3ecHZu4yVY7Hx1C7HmSrdGsWWRokWLwwlNrpafdotioniLrTvL5wGy5uR
         ssDyKjy+vM78UbBSG9yZ7WRL9z9VSx1Y7UjJR9Zwlaxh0pUkj1eREF9+BEp9m1lTDa
         QHtcm/nJzkWi+kw0SnffJQY56sAtui1niGbbn1Zr01RyZRHtn8r1BTyMrpNPMQWA4M
         tSrggLnvIc2IMZ2tKNeWzeZ6LxDI0HxJofJUuwQrq7M+VkCffF0hPVMF0co2SzMkV8
         w+DDKLtOk7t4w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Daniel Junho <djunho@gmail.com>
Subject: [PATCH 2/2] iio: adc: ad7923: Fix undersized rx buffer.
Date:   Sat,  1 May 2021 17:53:14 +0100
Message-Id: <20210501165314.511954-3-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210501165314.511954-1-jic23@kernel.org>
References: <20210501165314.511954-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Fixes tag is where the max channels became 8, but timestamp space was missing
before that.

Fixes: 851644a60d20 ("iio: adc: ad7923: Add support for the ad7908/ad7918/ad7928")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Daniel Junho <djunho@gmail.com>
---
 drivers/iio/adc/ad7923.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 9a649745cd0a..069b561ee768 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -59,8 +59,10 @@ struct ad7923_state {
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
+	 * Ensure rx_buf can be directly used in iio_push_to_buffers_with_timetamp
+	 * Length = 8 channels + 4 extra for 8 byte timestamp
 	 */
-	__be16				rx_buf[4] ____cacheline_aligned;
+	__be16				rx_buf[12] ____cacheline_aligned;
 	__be16				tx_buf[4];
 };
 
-- 
2.31.1

