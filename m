Return-Path: <SRS0=hyJt=S7=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87CFC04AA6
	for <linux-iio@archiver.kernel.org>; Mon, 29 Apr 2019 15:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91FA320673
	for <linux-iio@archiver.kernel.org>; Mon, 29 Apr 2019 15:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfD2PYN (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 29 Apr 2019 11:24:13 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:37488 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728653AbfD2PYM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Apr 2019 11:24:12 -0400
Received: from ramsan ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id 6FQA2000E3XaVaC06FQAUW; Mon, 29 Apr 2019 17:24:11 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hL88Y-0002ZB-GR; Mon, 29 Apr 2019 17:24:10 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hL88Y-000610-En; Mon, 29 Apr 2019 17:24:10 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] iio: adc: rcar-gyroadc: Remove devm_iio_device_alloc() error printing
Date:   Mon, 29 Apr 2019 17:24:09 +0200
Message-Id: <20190429152409.23081-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

devm_iio_device_alloc() can only fail due to a memory or IDA allocation
failure.  Hence there is no need to print a message, as the memory
allocation or IIO core code already takes care of that.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/iio/adc/rcar-gyroadc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
index 2c0d0316d149707f..2d685730f8673e65 100644
--- a/drivers/iio/adc/rcar-gyroadc.c
+++ b/drivers/iio/adc/rcar-gyroadc.c
@@ -485,10 +485,8 @@ static int rcar_gyroadc_probe(struct platform_device *pdev)
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
-	if (!indio_dev) {
-		dev_err(dev, "Failed to allocate IIO device.\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 
 	priv = iio_priv(indio_dev);
 	priv->dev = dev;
-- 
2.17.1

