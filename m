Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F3CC43461
	for <linux-iio@archiver.kernel.org>; Mon, 12 Apr 2021 08:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 416D3611F0
	for <linux-iio@archiver.kernel.org>; Mon, 12 Apr 2021 08:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237219AbhDLIjR (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 12 Apr 2021 04:39:17 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16567 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237270AbhDLIjQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Apr 2021 04:39:16 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FJht20svjz1BGYS;
        Mon, 12 Apr 2021 16:36:42 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Mon, 12 Apr 2021 16:38:49 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <jic23@kernel.org>, <tduszyns@gmail.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>
CC:     <linux-iio@vger.kernel.org>, Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH drivers/iio 2/3] iio: light: Convert sysfs sprintf/snprintf family to sysfs_emit
Date:   Mon, 12 Apr 2021 16:39:10 +0800
Message-ID: <1618216751-1678-3-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1618216751-1678-1-git-send-email-tiantao6@hisilicon.com>
References: <1618216751-1678-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix the following coccicheck warning:
drivers/iio/light/veml6030.c:131:8-16: WARNING:
use scnprintf or sprintf

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/iio/light/veml6030.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index de85c9b..3c937c5 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -128,7 +128,7 @@ static ssize_t in_illuminance_period_available_show(struct device *dev,
 		return -EINVAL;
 	}
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", period_values[x]);
+	return sysfs_emit(buf, "%s\n", period_values[x]);
 }
 
 static IIO_DEVICE_ATTR_RO(in_illuminance_period_available, 0);
-- 
2.7.4

