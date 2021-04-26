Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C41C433B4
	for <linux-iio@archiver.kernel.org>; Mon, 26 Apr 2021 17:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C508613AA
	for <linux-iio@archiver.kernel.org>; Mon, 26 Apr 2021 17:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbhDZRE6 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 26 Apr 2021 13:04:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233736AbhDZRE5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Apr 2021 13:04:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C76C613AB;
        Mon, 26 Apr 2021 17:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619456655;
        bh=hYza7Set3xxcxEciqQtBZPZwQ0j6Cs1K2uMm02/NVww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NXn+dft73ojBBLTE0lNdHezmnKmSzt2yzol4tk0arPkvrT4tr6zSWMSpCQmWh6IxU
         eO4+f+vszvezJu/5fjdlk/SXeE8Qgt9UgerdyBfhN64KJcb+SGnzPLD57f2TgLlI6T
         GEGI5Hh8m79eK2UxZiZEHgs0HJNDCkQC8fQTVdoBoFL5Klxd5A+WFSaKqhEI8g7GJT
         J2jAmgaS5nL1X60zeC+e5jTOiWlRN0c2huu2KpSs5OpmcoQEfTlhSaqkm+VFaxsm1J
         NqvvKaqxNbph1r6MWCcq8sLTMjNbBNwlJOa54a2svidFd8ZttVFmNMYTSB0CkoGpXB
         LiSVu085wcJ4g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH 3/8] iio: adc: mp2629: Drop duplicate setting iio_dev.dev.parent
Date:   Mon, 26 Apr 2021 18:02:46 +0100
Message-Id: <20210426170251.351957-4-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426170251.351957-1-jic23@kernel.org>
References: <20210426170251.351957-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This is already set to the same value in devm_iio_device_alloc()

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Saravanan Sekar <sravanhome@gmail.com>
---
 drivers/iio/adc/mp2629_adc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/mp2629_adc.c b/drivers/iio/adc/mp2629_adc.c
index 331a9a728217..aca084f1e78a 100644
--- a/drivers/iio/adc/mp2629_adc.c
+++ b/drivers/iio/adc/mp2629_adc.c
@@ -144,7 +144,6 @@ static int mp2629_adc_probe(struct platform_device *pdev)
 	}
 
 	indio_dev->name = "mp2629-adc";
-	indio_dev->dev.parent = dev;
 	indio_dev->channels = mp2629_channels;
 	indio_dev->num_channels = ARRAY_SIZE(mp2629_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.31.1

