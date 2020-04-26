Return-Path: <SRS0=UcXy=6K=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6348DC54FCB
	for <linux-iio@archiver.kernel.org>; Sun, 26 Apr 2020 19:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 540472071C
	for <linux-iio@archiver.kernel.org>; Sun, 26 Apr 2020 19:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgDZToL (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 26 Apr 2020 15:44:11 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:49873 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgDZToK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2020 15:44:10 -0400
Received: from localhost.localdomain ([93.23.12.11])
        by mwinf5d64 with ME
        id XXk72200Q0EJ3pp03Xk7zB; Sun, 26 Apr 2020 21:44:09 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 26 Apr 2020 21:44:09 +0200
X-ME-IP: 93.23.12.11
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, maitysanchayan@gmail.com, robh@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] iio: dac: vf610: Fix an error handling path in 'vf610_dac_probe()'
Date:   Sun, 26 Apr 2020 21:44:03 +0200
Message-Id: <20200426194403.41913-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

A call to 'vf610_dac_exit()' is missing in an error handling path.

Fixes: 1b983bf42fad ("iio: dac: vf610_dac: Add IIO DAC driver for Vybrid SoC")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Un-tested.
Proposal based on function names and functions called in the remove function
---
 drivers/iio/dac/vf610_dac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/dac/vf610_dac.c b/drivers/iio/dac/vf610_dac.c
index 71f8a5c471c4..7f1e9317c3f3 100644
--- a/drivers/iio/dac/vf610_dac.c
+++ b/drivers/iio/dac/vf610_dac.c
@@ -223,6 +223,7 @@ static int vf610_dac_probe(struct platform_device *pdev)
 	return 0;
 
 error_iio_device_register:
+	vf610_dac_exit(info);
 	clk_disable_unprepare(info->clk);
 
 	return ret;
-- 
2.25.1

