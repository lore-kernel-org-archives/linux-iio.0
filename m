Return-Path: <SRS0=lwR9=67=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F36C433E0
	for <linux-iio@archiver.kernel.org>; Sun, 17 May 2020 10:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75476207F5
	for <linux-iio@archiver.kernel.org>; Sun, 17 May 2020 10:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgEQKAA (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 17 May 2020 06:00:00 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:38594 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbgEQKAA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 May 2020 06:00:00 -0400
Received: from localhost.localdomain ([92.140.207.208])
        by mwinf5d56 with ME
        id flzv2200S4WJoZY03lzwDN; Sun, 17 May 2020 11:59:58 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 17 May 2020 11:59:58 +0200
X-ME-IP: 92.140.207.208
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Michael.Hennerich@analog.com, renatogeh@gmail.com, lars@metafoo.de,
        jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
        giuliano.belinassi@usp.br
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] iio: adc: ad7780: Fix a resource handling path in 'ad7780_probe()'
Date:   Sun, 17 May 2020 11:59:53 +0200
Message-Id: <20200517095953.278950-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

If 'ad7780_init_gpios()' fails, we must not release some resources that
have not been allocated yet. Return directly instead.

Fixes: 5bb30e7daf00 ("staging: iio: ad7780: move regulator to after GPIO init")
Fixes: 9085daa4abcc ("staging: iio: ad7780: add gain & filter gpio support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/iio/adc/ad7780.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7780.c b/drivers/iio/adc/ad7780.c
index f47606ebbbbe..b33fe6c3907e 100644
--- a/drivers/iio/adc/ad7780.c
+++ b/drivers/iio/adc/ad7780.c
@@ -329,7 +329,7 @@ static int ad7780_probe(struct spi_device *spi)
 
 	ret = ad7780_init_gpios(&spi->dev, st);
 	if (ret)
-		goto error_cleanup_buffer_and_trigger;
+		return ret;
 
 	st->reg = devm_regulator_get(&spi->dev, "avdd");
 	if (IS_ERR(st->reg))
-- 
2.25.1

