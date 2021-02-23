Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B0BC433DB
	for <linux-iio@archiver.kernel.org>; Tue, 23 Feb 2021 12:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D2FE64E00
	for <linux-iio@archiver.kernel.org>; Tue, 23 Feb 2021 12:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhBWMNR (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 23 Feb 2021 07:13:17 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:38399 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232300AbhBWMNR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Feb 2021 07:13:17 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id B29874402B1;
        Tue, 23 Feb 2021 14:12:29 +0200 (IST)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] staging: iio: remove mention of defunct list
Date:   Tue, 23 Feb 2021 14:12:23 +0200
Message-Id: <69b3e45e7666a1dd74a83df0b84ef8a63bf090ea.1614082343.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ADI device-drivers-devel list no longer exists.

Cc: Mike Frysinger <vapier@gentoo.org>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/staging/iio/TODO | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/iio/TODO b/drivers/staging/iio/TODO
index 4d469016a13a..0fa6a5500bdb 100644
--- a/drivers/staging/iio/TODO
+++ b/drivers/staging/iio/TODO
@@ -1,9 +1,5 @@
 2020-02-25
 
 
-ADI Drivers:
-CC the device-drivers-devel@blackfin.uclinux.org mailing list when
-e-mailing the normal IIO list (see below).
-
 Contact: Jonathan Cameron <jic23@kernel.org>.
 Mailing list: linux-iio@vger.kernel.org
-- 
2.30.0

