Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C229C4338F
	for <linux-iio@archiver.kernel.org>; Fri, 20 Aug 2021 22:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E75B360C41
	for <linux-iio@archiver.kernel.org>; Fri, 20 Aug 2021 22:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhHTW6h (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 20 Aug 2021 18:58:37 -0400
Received: from h04.kommunity.net ([138.201.86.160]:33675 "EHLO
        h04.kommunity.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbhHTW6h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 18:58:37 -0400
X-Greylist: delayed 504 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Aug 2021 18:58:36 EDT
Received: from notebook.fritz.box (p4fc646df.dip0.t-ipconnect.de [79.198.70.223])
        by h04.kommunity.net (Postfix) with ESMTPSA id 51D1BF86E5D;
        Sat, 21 Aug 2021 00:49:31 +0200 (CEST)
Authentication-Results: h04.kommunity.net;
        spf=pass (sender IP is 79.198.70.223) smtp.mailfrom=alec@vc-celle.de smtp.helo=notebook.fritz.box
Received-SPF: pass (h04.kommunity.net: connection is authenticated)
From:   Alexander Vorwerk <alec@vc-celle.de>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Alexander Vorwerk <alec@vc-celle.de>
Subject: [PATCH] staging: iio: cdc: remove braces from single line if blocks
Date:   Sat, 21 Aug 2021 00:49:14 +0200
Message-Id: <20210820224914.1260-1-alec@vc-celle.de>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Remove braces from single line if blocks to clear checkpatch warnings.
WARNING: braces {} are not necessary for single statement blocks

Signed-off-by: Alexander Vorwerk <alec@vc-celle.de>
---
 drivers/staging/iio/cdc/ad7746.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 78ac720266e6..71c709771676 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -241,10 +241,8 @@ static int ad7746_select_channel(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
-		if (chip->capdac_set != chan->channel) {
-
+		if (chip->capdac_set != chan->channel)
 			chip->capdac_set = chan->channel;
-		}
 		break;
 	case IIO_VOLTAGE:
 	case IIO_TEMP:
-- 
2.17.1

