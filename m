Return-Path: <SRS0=Too6=52=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07A8C2BA2B
	for <linux-iio@archiver.kernel.org>; Fri, 10 Apr 2020 17:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C401A20801
	for <linux-iio@archiver.kernel.org>; Fri, 10 Apr 2020 17:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgDJRM3 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:12:29 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:53188 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgDJRM3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Apr 2020 13:12:29 -0400
Received: from localhost.localdomain ([93.22.39.186])
        by mwinf5d10 with ME
        id R5CQ2200L40yuPR035CRD2; Fri, 10 Apr 2020 19:12:26 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 10 Apr 2020 19:12:26 +0200
X-ME-IP: 93.22.39.186
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     alexandru.ardelean@analog.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, stefan.popa@analog.com,
        jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] iio: imu: adis: Add a missing '\n' in a log message
Date:   Fri, 10 Apr 2020 19:12:24 +0200
Message-Id: <20200410171224.4633-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Message logged by 'dev_xxx()' or 'pr_xxx()' should end with a '\n'.

Fixes: 1fd456702692 ("iio: imu: adis: add support product ID check in adis_initial_startup")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/iio/imu/adis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index a8afd01de4f3..2e7d0d337f8f 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -419,7 +419,7 @@ int __adis_initial_startup(struct adis *adis)
 
 	if (prod_id != adis->data->prod_id)
 		dev_warn(&adis->spi->dev,
-			 "Device ID(%u) and product ID(%u) do not match.",
+			 "Device ID(%u) and product ID(%u) do not match.\n",
 			 adis->data->prod_id, prod_id);
 
 	return 0;
-- 
2.20.1

