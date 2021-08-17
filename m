Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD47C4338F
	for <linux-iio@archiver.kernel.org>; Tue, 17 Aug 2021 12:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 928CC60F5C
	for <linux-iio@archiver.kernel.org>; Tue, 17 Aug 2021 12:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhHQMog (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 17 Aug 2021 08:44:36 -0400
Received: from first.geanix.com ([116.203.34.67]:37256 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229539AbhHQMog (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Aug 2021 08:44:36 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 5BD39440EB8;
        Tue, 17 Aug 2021 12:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1629204241; bh=wsMAzbXu+CYg3T+rFliUvr1a08eDPZiV6+ghNN5JGKc=;
        h=From:To:Cc:Subject:Date;
        b=ZFnFsJQNbi3yyPD28vIclL2nQG5Kl+mtg6lmQa+tXXQuKKVpmqdzjB/vRctonCFI3
         MVlBCFCu6EtYqLsU3w+mc0jPssC92m2y0ZDdxCGSau9opTGUcPXBUP3WWxxCll1uEB
         9YKAoTZOPMPodQ84BPrg7Lkz5lVF/OixIczOF25xB8kkJjdI8Wn+A8Gv0X5wF4/h08
         Sv7TUrFA3iV+s4LMxLtxloE/Kz25aLyNIBj1invzZUg+1emQp4btYHPYu1i3tQZajL
         iYsUhsdgmQwlgFqZEvBl4vyp7/0+po8E1ZAnGPprplhONBmEMNVwbL1ADNupOzns1Y
         hBq+J5PKBNPeQ==
From:   Sean Nyekjaer <sean@geanix.com>
To:     jic23@kernel.org, andriy.shevchenko@linux.intel.com
Cc:     linux-iio@vger.kernel.org, Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH] iio: accel: fxls8962af: return IRQ_HANDLED when fifo is flushed
Date:   Tue, 17 Aug 2021 14:43:36 +0200
Message-Id: <20210817124336.1672169-1-sean@geanix.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

fxls8962af_fifo_flush() will return the samples flushed.
So return IRQ_NONE only if an error is returned.

Fixes: 79e3a5bdd9ef ("iio: accel: fxls8962af: add hw buffered sampling")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/accel/fxls8962af-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 078d87865fde..6b36eb362d07 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -738,7 +738,7 @@ static irqreturn_t fxls8962af_interrupt(int irq, void *p)
 
 	if (reg & FXLS8962AF_INT_STATUS_SRC_BUF) {
 		ret = fxls8962af_fifo_flush(indio_dev);
-		if (ret)
+		if (ret < 0)
 			return IRQ_NONE;
 
 		return IRQ_HANDLED;
-- 
2.32.0

