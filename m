Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6F7C19F2A
	for <linux-iio@archiver.kernel.org>; Sun,  7 Aug 2022 16:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbiHGQLH (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 7 Aug 2022 12:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbiHGQLG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 12:11:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1B22DB
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 09:11:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFC98B80D3B
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 16:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6603FC433C1;
        Sun,  7 Aug 2022 16:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659888661;
        bh=Y0zNwaEOVcKdGagD1rKuv4Wzhv7uKCFUF9NtxWDGbvI=;
        h=From:To:Cc:Subject:Date:From;
        b=S1UzrtVWFARm1ZIrzf4+JdLGZ8ADNhZTavjv5eTLq5JNd2jnW7mo4BXDLkLzjNpT9
         YD9Z8+ajyvJE9R4Bp34HtwSyeeOnm8Iw8JIMNQ+85l4XuNctVKT2PDkfXtQijyeYWW
         3SWpISgu5y353De+IFBeHw44YDO8zYKnq/r7Gm/ga5FdbCfihIjoFdIL5W77va5VQx
         0JILMECW5Y5W8PGOUnEF96Nr7ew3Ig1Wv4bRcL/aEOwlSXOUF5FiE/5DSLui1fpqnH
         Rhrk3c98wFa7VArYVbHYRvvvSBJFJ+S1lcz1oJVuwM9J172ixyO6Ns2KvhwqcPiSRB
         lTULq9+BwpIVQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gene Chen <gene_chen@richtek.com>
Subject: [PATCH] iio: adc: mt6360: Drop an incorrect __maybe_unused marking.
Date:   Sun,  7 Aug 2022 17:21:21 +0100
Message-Id: <20220807162121.862894-1-jic23@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Given the struct platform_driver has one of it's elements assigned to
point to the of_device_id table, it is never going to be unused.

Drop the marking.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gene Chen <gene_chen@richtek.com>
---
 drivers/iio/adc/mt6360-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
index 35260d9e4e47..3710473e526f 100644
--- a/drivers/iio/adc/mt6360-adc.c
+++ b/drivers/iio/adc/mt6360-adc.c
@@ -353,7 +353,7 @@ static int mt6360_adc_probe(struct platform_device *pdev)
 	return devm_iio_device_register(&pdev->dev, indio_dev);
 }
 
-static const struct of_device_id __maybe_unused mt6360_adc_of_id[] = {
+static const struct of_device_id mt6360_adc_of_id[] = {
 	{ .compatible = "mediatek,mt6360-adc", },
 	{}
 };
-- 
2.37.1

