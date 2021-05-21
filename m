Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98254C433ED
	for <linux-iio@archiver.kernel.org>; Fri, 21 May 2021 06:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76803613B6
	for <linux-iio@archiver.kernel.org>; Fri, 21 May 2021 06:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbhEUG1p (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 21 May 2021 02:27:45 -0400
Received: from mail.buaa.edu.cn ([106.39.41.192]:45480 "HELO
        mailgw2.buaa.edu.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S230217AbhEUG1p (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 May 2021 02:27:45 -0400
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 May 2021 02:27:44 EDT
Received: from tq-G3-3579.tsinghua.edu.cn (unknown [183.173.48.61])
        by mailgw1.buaa.edu.cn (Maildata Gateway V2.8) with ESMTPSA id 67E1DC776FC50;
        Fri, 21 May 2021 14:19:55 +0800 (CST)
X-MD-Sfrom: tq17373059@buaa.edu.cn
X-MD-SrcIP: 183.173.48.61
From:   tq17373059@buaa.edu.cn
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju@tsinghua.edu.cn, Qi Teng <tq17373059@buaa.edu.cn>,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: [PATCH] iio: adf4350: fix a possible divided-by-zero bug in adf4350_set_freq()
Date:   Fri, 21 May 2021 14:19:53 +0800
Message-Id: <20210521061953.35873-1-tq17373059@buaa.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Qi Teng <tq17373059@buaa.edu.cn>

The variable st->r1_mod is checked in:
  if (st->r0_fract && st->r1_mod)

This indicates that st->r1_mod can be zero. Its value is the same as
that in:
  st->r0_fract = do_div(tmp, st->r1_mod);

However, st->r1_mod performs as a divisor in this statement, which
implies a possible divided-by-zero bug.

To fix this possible bug, st->r1_mod is checked before the division
operation. If it is zero, st->r0_fract is set to zero instead of
do_div(tmp, st->r1_mod).

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn> 
Signed-off-by: Qi Teng <tq17373059@buaa.edu.cn>
---
 drivers/iio/frequency/adf4350.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index 99c6f260cc21..1462a6a5bc6d 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -182,10 +182,7 @@ static int adf4350_set_freq(struct adf4350_state *st, unsigned long long freq)
 
 		tmp = freq * (u64)st->r1_mod + (st->fpfd >> 1);
 		do_div(tmp, st->fpfd); /* Div round closest (n + d/2)/d */
-		if (st->r1_mod)
-			st->r0_fract = do_div(tmp, st->r1_mod);
-		else
-			st->r0_fract = 0;
+		st->r0_fract = do_div(tmp, st->r1_mod);
 		st->r0_int = tmp;
 	} while (mdiv > st->r0_int);
 
-- 
2.25.1

