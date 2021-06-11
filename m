Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4072C48BD1
	for <linux-iio@archiver.kernel.org>; Fri, 11 Jun 2021 15:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D08C461400
	for <linux-iio@archiver.kernel.org>; Fri, 11 Jun 2021 15:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhFKP0j (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 11 Jun 2021 11:26:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231726AbhFKP0g (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 11:26:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F9A1613EE;
        Fri, 11 Jun 2021 15:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623425077;
        bh=/j97fJLvi9HNNeHFu8LBc0eER59Zi+oQVnQTYg74bF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L5W4P1bm3+87i3AkadaNDOCh1F8jT44mRFPOLLm+wJymzcwm/u8KwPRHl6+DF/6Px
         q1+5VtP+NXj1sqCJqIw7LSfCaaPZhD/m1RRRWxSk2TlaQ1KPVWDewANLyzN+zniDOP
         HwZJiXcY6A0S1Hk3IUNHJ6ELOV6a4dEV0nc+anYrgJ2E+TqPAW2+NUdQ9IES+Qkdkz
         bo65sMXEBq7h2q1jglezAvwSN+oHNAsRxcXCwtAy6Se2P54YOP8WUrFa3BrRm9OTU7
         c3v5+ZrOY2ugFd+X8ivzw7Vf6fV+/LEwhTJwMudiAWEynNGBH4n59SiQnHaXXjea/J
         pge67ZkuL/0qA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Nuno Sa <Nuno.Sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 7/7] staging:iio:resolver:ad2s1210: Cleanup includes
Date:   Fri, 11 Jun 2021 16:26:14 +0100
Message-Id: <20210611152614.109361-8-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611152614.109361-1-jic23@kernel.org>
References: <20210611152614.109361-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Based on consideration of the output of the include-what-you-use tool.
Drop unused includes and add some that should be there.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 74adb82f37c3..99dec73144ba 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -4,15 +4,16 @@
  *
  * Copyright (c) 2010-2010 Analog Devices Inc.
  */
+#include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
 #include <linux/spi/spi.h>
-#include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/of.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-- 
2.31.1

