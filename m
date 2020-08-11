Return-Path: <SRS0=zMCo=BV=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AC5C433E0
	for <linux-iio@archiver.kernel.org>; Tue, 11 Aug 2020 03:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC0C7206EF
	for <linux-iio@archiver.kernel.org>; Tue, 11 Aug 2020 03:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgHKDsO (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 10 Aug 2020 23:48:14 -0400
Received: from inva021.nxp.com ([92.121.34.21]:41348 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728182AbgHKDsO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 Aug 2020 23:48:14 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0959220073D;
        Tue, 11 Aug 2020 05:48:13 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4A1DA20072D;
        Tue, 11 Aug 2020 05:48:09 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4D425402DF;
        Tue, 11 Aug 2020 05:48:04 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, alexandru.ardelean@analog.com,
        hslester96@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/3] iio: light: isl29018: Use dev_err_probe() to simplify error handling
Date:   Tue, 11 Aug 2020 11:43:15 +0800
Message-Id: <1597117396-2894-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597117396-2894-1-git-send-email-Anson.Huang@nxp.com>
References: <1597117396-2894-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

dev_err_probe() can reduce code size, uniform error handling and record the
defer probe reason etc., use it to simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/iio/light/isl29018.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index ac8ad0f..2689867 100644
--- a/drivers/iio/light/isl29018.c
+++ b/drivers/iio/light/isl29018.c
@@ -746,12 +746,9 @@ static int isl29018_probe(struct i2c_client *client,
 	chip->suspended = false;
 
 	chip->vcc_reg = devm_regulator_get(&client->dev, "vcc");
-	if (IS_ERR(chip->vcc_reg)) {
-		err = PTR_ERR(chip->vcc_reg);
-		if (err != -EPROBE_DEFER)
-			dev_err(&client->dev, "failed to get VCC regulator!\n");
-		return err;
-	}
+	if (IS_ERR(chip->vcc_reg))
+		return dev_err_probe(&client->dev, PTR_ERR(chip->vcc_reg),
+				     "failed to get VCC regulator!\n");
 
 	err = regulator_enable(chip->vcc_reg);
 	if (err) {
-- 
2.7.4

