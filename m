Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93BBC001BE
	for <linux-iio@archiver.kernel.org>; Thu,  1 Apr 2021 17:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C06ED613B5
	for <linux-iio@archiver.kernel.org>; Thu,  1 Apr 2021 17:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbhDARpl (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:45:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234558AbhDARiA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 1 Apr 2021 13:38:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 087206052B;
        Thu,  1 Apr 2021 15:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617289806;
        bh=cyp7Z/MZ5qPnP2LqVlPxFQ0FumZKdLZFAXMd6vdSnZs=;
        h=From:To:Cc:Subject:Date:From;
        b=gmTioM7vLG8PxzhxAsuv4a5282nXZwSli0s295+We+vTc2SO8Q+++He6uMlbNCFD+
         i28Jhv0sLknV9X6XrIQ/YEr52QyymGRvQJOmpi60L8Zqtg5wPsyo620aOhyz98Xv2z
         XJXdR/DXa+VtqrlVAeWMQWZbWFaUpGowHY3hSWWPmX9TaJbuolMAlOYNCsJjB+1oBE
         RxTeyToNfdjqQ1s3aCja6SHzaQKaUfUkcHeb80nzm+f8YvUebWAB5VD2kXGCQI9TdQ
         nam3JppBJAothyHGQb/4KnIf6A57qtfTiZrJRAK8OKk66gYVL/eSvCQM/RlAQuPfuy
         dmBavFXOGQgmA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] iio:adc: Fix trivial typo
Date:   Thu,  1 Apr 2021 16:08:10 +0100
Message-Id: <20210401150810.227168-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

"an" should be "and".

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index d20a3b574af9..87c55f7104f0 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -97,7 +97,7 @@ config AD7298
 	  module will be called ad7298.
 
 config AD7476
-	tristate "Analog Devices AD7476 1-channel ADCs driver and other similar devices from AD an TI"
+	tristate "Analog Devices AD7476 1-channel ADCs driver and other similar devices from AD and TI"
 	depends on SPI
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
-- 
2.31.1

