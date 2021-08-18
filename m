Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DF6C4320E
	for <linux-iio@archiver.kernel.org>; Wed, 18 Aug 2021 11:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A73466108F
	for <linux-iio@archiver.kernel.org>; Wed, 18 Aug 2021 11:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbhHRLMS (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 18 Aug 2021 07:12:18 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:37771 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbhHRLMR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Aug 2021 07:12:17 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 2E47260009;
        Wed, 18 Aug 2021 11:11:41 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-iio@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        stable@vger.kernel.org
Subject: [PATCH 02/16] iio: adc: max1027: Fix the number of max1X31 channels
Date:   Wed, 18 Aug 2021 13:11:25 +0200
Message-Id: <20210818111139.330636-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210818111139.330636-1-miquel.raynal@bootlin.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The macro MAX1X29_CHANNELS() already calls MAX1X27_CHANNELS().
Calling MAX1X27_CHANNELS() before MAX1X29_CHANNELS() in the definition
of MAX1X31_CHANNELS() declares the first 8 channels twice. So drop this
extra call from the MAX1X31 channels list definition.

Fixes: 7af5257d8427 ("iio: adc: max1027: Prepare the introduction of different resolutions")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 4a42d140a4b0..b753658bb41e 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -142,7 +142,6 @@ MODULE_DEVICE_TABLE(of, max1027_adc_dt_ids);
 	MAX1027_V_CHAN(11, depth)
 
 #define MAX1X31_CHANNELS(depth)			\
-	MAX1X27_CHANNELS(depth),		\
 	MAX1X29_CHANNELS(depth),		\
 	MAX1027_V_CHAN(12, depth),		\
 	MAX1027_V_CHAN(13, depth),		\
-- 
2.27.0

