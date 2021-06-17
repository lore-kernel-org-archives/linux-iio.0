Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742D3C2B9F4
	for <linux-iio@archiver.kernel.org>; Thu, 17 Jun 2021 08:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51D14613E9
	for <linux-iio@archiver.kernel.org>; Thu, 17 Jun 2021 08:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhFQIPV (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 17 Jun 2021 04:15:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38575 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhFQIPV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Jun 2021 04:15:21 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1ltn9E-0000tN-Ox; Thu, 17 Jun 2021 08:13:12 +0000
From:   Colin King <colin.king@canonical.com>
To:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: light: si1145: remove redundant continue statement
Date:   Thu, 17 Jun 2021 09:13:12 +0100
Message-Id: <20210617081312.151746-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The continue statement at the end of a for-loop has no effect,
remove it.

Addresses-Coverity: ("Continue has no effect")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/light/si1145.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
index e2abad48b9f4..e8f6cdf26f22 100644
--- a/drivers/iio/light/si1145.c
+++ b/drivers/iio/light/si1145.c
@@ -220,7 +220,6 @@ static int __si1145_command_reset(struct si1145_data *data)
 			return -ETIMEDOUT;
 		}
 		msleep(SI1145_COMMAND_MINSLEEP_MS);
-		continue;
 	}
 }
 
-- 
2.31.1

