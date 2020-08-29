Return-Path: <SRS0=A9f8=CH=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B555C43461
	for <linux-iio@archiver.kernel.org>; Sat, 29 Aug 2020 06:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50C1F212CC
	for <linux-iio@archiver.kernel.org>; Sat, 29 Aug 2020 06:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598683691;
	bh=K83T+JXtESA0TpwgWdU6Z3Vl8lzC3/2+GqaR3PlsHoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ykdptq72gbcmqVSnvQCFmU/8U3p2hn/nGX/YP8v/1S2V1r9FZp/iIQcaVg0gZTWNS
	 sMJWkXVzTu11RjH+795g4fRnZTajj9pMUrM+D/Ghgs9KP5E8Qe3Cu2Q7uGlPpQ3sYZ
	 nrD7m1YwVEYFZcDpqwF+V7j0+UB/ZdkSBZbd7+0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgH2GsK (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 29 Aug 2020 02:48:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgH2GsJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 02:48:09 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B5D92137B;
        Sat, 29 Aug 2020 06:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598683689;
        bh=K83T+JXtESA0TpwgWdU6Z3Vl8lzC3/2+GqaR3PlsHoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zTVALHupfoniHQUm20051KrWI84bHOmJyP/hwatzCG0rANIzfPOmJmaqR/DuaU+Wm
         tS4bqbiP8NA8TnXPOl7PzZCRf+Wa4eN8qkd9N3p91VtViDeCGp411Qr2EAHqVhuJbF
         wbxeZaRfF2FHkTRRyevIzHU3ERkdVU8P5FZhMG3w=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 02/18] iio: accel: mma8452: Simplify with dev_err_probe()
Date:   Sat, 29 Aug 2020 08:47:10 +0200
Message-Id: <20200829064726.26268-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829064726.26268-1-krzk@kernel.org>
References: <20200829064726.26268-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/accel/mma8452.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 4e6e70250048..104b87b98455 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1538,22 +1538,14 @@ static int mma8452_probe(struct i2c_client *client,
 	data->chip_info = match->data;
 
 	data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
-	if (IS_ERR(data->vdd_reg)) {
-		if (PTR_ERR(data->vdd_reg) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-
-		dev_err(&client->dev, "failed to get VDD regulator!\n");
-		return PTR_ERR(data->vdd_reg);
-	}
+	if (IS_ERR(data->vdd_reg))
+		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_reg),
+				     "failed to get VDD regulator!\n");
 
 	data->vddio_reg = devm_regulator_get(&client->dev, "vddio");
-	if (IS_ERR(data->vddio_reg)) {
-		if (PTR_ERR(data->vddio_reg) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-
-		dev_err(&client->dev, "failed to get VDDIO regulator!\n");
-		return PTR_ERR(data->vddio_reg);
-	}
+	if (IS_ERR(data->vddio_reg))
+		return dev_err_probe(&client->dev, PTR_ERR(data->vddio_reg),
+				     "failed to get VDDIO regulator!\n");
 
 	ret = regulator_enable(data->vdd_reg);
 	if (ret) {
-- 
2.17.1

