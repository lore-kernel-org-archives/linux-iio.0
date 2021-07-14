Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4105CC07E9C
	for <linux-iio@archiver.kernel.org>; Wed, 14 Jul 2021 11:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26D15613AB
	for <linux-iio@archiver.kernel.org>; Wed, 14 Jul 2021 11:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238951AbhGNLRh (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 14 Jul 2021 07:17:37 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:37573 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238774AbhGNLRh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jul 2021 07:17:37 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d27 with ME
        id UzEj2500A21Fzsu03zEj6Q; Wed, 14 Jul 2021 13:14:44 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 14 Jul 2021 13:14:44 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] iio: buffer: Save a few cycles in 'iio_scan_mask_set()'
Date:   Wed, 14 Jul 2021 13:14:41 +0200
Message-Id: <89d8a766eb971eda1ee362444a8711037bdb208c.1626261211.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use 'bitmap_alloc()' instead of 'bitmap_zalloc()' because the bitmap
is fully overridden by a 'bitmap_copy()' call just after its allocation.

While at it, fix the style of a NULL check.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/iio/industrialio-buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index fdd623407b96..6d4776a7f002 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -354,8 +354,8 @@ static int iio_scan_mask_set(struct iio_dev *indio_dev,
 	const unsigned long *mask;
 	unsigned long *trialmask;
 
-	trialmask = bitmap_zalloc(indio_dev->masklength, GFP_KERNEL);
-	if (trialmask == NULL)
+	trialmask = bitmap_alloc(indio_dev->masklength, GFP_KERNEL);
+	if (!trialmask)
 		return -ENOMEM;
 	if (!indio_dev->masklength) {
 		WARN(1, "Trying to set scanmask prior to registering buffer\n");
-- 
2.30.2

