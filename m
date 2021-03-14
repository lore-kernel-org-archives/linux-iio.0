Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79EAC43381
	for <linux-iio@archiver.kernel.org>; Sun, 14 Mar 2021 18:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EB8F64E7A
	for <linux-iio@archiver.kernel.org>; Sun, 14 Mar 2021 18:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbhCNSSS (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 14 Mar 2021 14:18:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233779AbhCNSRv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 14:17:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F84264EE2;
        Sun, 14 Mar 2021 18:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615745870;
        bh=+ArNy+2cTID8ZwLSd3Q9f96iGanAixPkEC+0C8TzIL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k89auVQNk2zL59TU1A39BxDA1jhykPGSpghSDjILaCS+U1FeGG1/VSD+qzOQ9Atlq
         +VLtTJ0D8fBMAKbatuNN/zBoMDbGgKtbwSWnfBUkPB2gv5xV9raK4Y4fSyfnN2UqUd
         54io/2ymed9paK9D6D4uUx8Syy3GURR78KdNAV0LkRcJ6khPaVIpYfBDkVeBZDBgrY
         P3f+/gKki9j4koLXMQbrrsI51YQJXCUdesvGJQNakcXGkuXGgMh9by5QWM9k+jfbmj
         Ss5QcDaEYe4kU9552GbQK603Rgl2WArA3b5uEd4xlAW6dbVSEhSa+a5hF2xIKc0RSq
         jJ7IL8F5Qrr9Q==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <aardelean@deviqon.com>, Robh+dt@kernel.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 14/24] staging:iio:cdc:ad7150: Reorganize headers.
Date:   Sun, 14 Mar 2021 18:15:01 +0000
Message-Id: <20210314181511.531414-15-jic23@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314181511.531414-1-jic23@kernel.org>
References: <20210314181511.531414-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Whilst not important, it's nice to have the general headers in
alphabetical order.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>
Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20210207154623.433442-15-jic23@kernel.org
---
 drivers/staging/iio/cdc/ad7150.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 99125abb889b..8131fbb56d37 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -6,13 +6,13 @@
  */
 
 #include <linux/bitfield.h>
-#include <linux/interrupt.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/i2c.h>
+#include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-- 
2.30.2

