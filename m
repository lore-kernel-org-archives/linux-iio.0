Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C57AC433EF
	for <linux-iio@archiver.kernel.org>; Wed, 22 Jun 2022 04:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiFVEBO (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 22 Jun 2022 00:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbiFVEBN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jun 2022 00:01:13 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527612F031;
        Tue, 21 Jun 2022 21:01:09 -0700 (PDT)
X-QQ-mid: bizesmtp65t1655870373tceldupx
Received: from ubuntu.localdomain ( [106.117.99.132])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 11:59:28 +0800 (CST)
X-QQ-SSF: 01000000000000B0B000000A0000000
X-QQ-FEAT: ACkb0FcbxRnYk73geYpLkbkj9vr6F9nivVRrtN6oXB7SIWL2x8lhOjZy1Prol
        0+Rfghy0oToGgu3XLckfcn1opdu2DHWCo6D13JUgoFaIYVtDqPI1xsHRLHYnDwNTmJedES0
        3PnxwtrD5PPsAii9NjvmaL1udANFGrJXXryJzGHRjL7of2TogmR1v/d/kB8I9adWUFeL3DV
        QgWb8IBi1/r5otL4URPdjzi+o8C4FqJfWe9L82CW5MGw74AQ1W95O3qTILTMYdcT3VnWjqK
        jqIEJs8piwwTxf0CxPki/cfPoTZHO+qzFofCn3sJJrcF0ILjCFpjblGWHPTUP0vxoKDZkeL
        WWEYnktW0WhE+uVuCviAz/9FIEQmOuALfPsuvSY
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, ardeleanalex@gmail.com, andy.shevchenko@gmail.com,
        antoniu.miclaus@analog.com, u.kleine-koenig@pengutronix.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH v2] iio: magnetometer: hmc5843: Remove duplicate 'the'
Date:   Wed, 22 Jun 2022 11:59:25 +0800
Message-Id: <20220622035925.5008-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix an obvious typing error, found by spellcheck(1).

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/iio/magnetometer/hmc5843_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/hmc5843_core.c b/drivers/iio/magnetometer/hmc5843_core.c
index 92eb2d156ddb..4a63b2da9df0 100644
--- a/drivers/iio/magnetometer/hmc5843_core.c
+++ b/drivers/iio/magnetometer/hmc5843_core.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Device driver for the the HMC5843 multi-chip module designed
+ * Device driver for the HMC5843 multi-chip module designed
  * for low field magnetic sensing.
  *
  * Copyright (C) 2010 Texas Instruments
-- 
2.17.1

