Return-Path: <SRS0=dRc7=6J=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07870C55186
	for <linux-iio@archiver.kernel.org>; Sat, 25 Apr 2020 06:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D30E320857
	for <linux-iio@archiver.kernel.org>; Sat, 25 Apr 2020 06:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgDYG5G (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 25 Apr 2020 02:57:06 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:19810 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgDYG5G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Apr 2020 02:57:06 -0400
Received: from localhost.localdomain ([92.148.159.11])
        by mwinf5d16 with ME
        id Wuwy220090F2omL03uwzZN; Sat, 25 Apr 2020 08:57:03 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 25 Apr 2020 08:57:03 +0200
X-ME-IP: 92.148.159.11
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     lars@metafoo.de, Michael.Hennerich@analog.com,
        stefan.popa@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] iio: dac: ad5593r: Fix a typo in MODULE_DESCRIPTION
Date:   Sat, 25 Apr 2020 08:56:53 +0200
Message-Id: <20200425065653.31203-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This module is related to AD5593R, not AD5592R.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/iio/dac/ad5593r.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5593r.c b/drivers/iio/dac/ad5593r.c
index 44ea3b8117d0..1fbe9c019c7f 100644
--- a/drivers/iio/dac/ad5593r.c
+++ b/drivers/iio/dac/ad5593r.c
@@ -134,5 +134,5 @@ static struct i2c_driver ad5593r_driver = {
 module_i2c_driver(ad5593r_driver);
 
 MODULE_AUTHOR("Paul Cercueil <paul.cercueil@analog.com>");
-MODULE_DESCRIPTION("Analog Devices AD5592R multi-channel converters");
+MODULE_DESCRIPTION("Analog Devices AD5593R multi-channel converters");
 MODULE_LICENSE("GPL v2");
-- 
2.20.1

