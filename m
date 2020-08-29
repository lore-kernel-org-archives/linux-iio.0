Return-Path: <SRS0=A9f8=CH=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32688C433E7
	for <linux-iio@archiver.kernel.org>; Sat, 29 Aug 2020 06:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0771220E65
	for <linux-iio@archiver.kernel.org>; Sat, 29 Aug 2020 06:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598683766;
	bh=+9ZHsUV0y46Ja0TiXAlSDjBe8qgvjNNrJDCcRfHGJs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wIGucIPOqdDRWUD0JwUTb4h55OopGsN3COZAPQjUhxJYI5RBWOlzE6V/dxMhJjlD9
	 15nGypBRooh/2D9Uk30pLLxOTbR9CMWKWQ2sZsHb+DAjlsC8jy+WNwZ7PdKXO2fMNL
	 nq0lYu49m5Toro5OEktZxylTFLYR90SGsSi3l9EU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgH2GsY (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 29 Aug 2020 02:48:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbgH2GsX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 02:48:23 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECC4A212CC;
        Sat, 29 Aug 2020 06:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598683702;
        bh=+9ZHsUV0y46Ja0TiXAlSDjBe8qgvjNNrJDCcRfHGJs8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KIeViUeY6QyTX92YBy2Cu08o+4iOH/rmeVUGnTZsxx1fz529OQybhMrqmUPpmS2eQ
         Wlvt3lUkfvE0ZPh5IXXdFSxAZ0xQ9LZl4mdhdoA2HDNroIJQvSb1uGynZ2GnTe7A9Y
         vTR2diwZNHhhkSso8ozxl0HX0nc0EAloutIphD/8=
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
Subject: [PATCH v3 06/18] iio: adc: meson_saradc: Simplify with dev_err_probe()
Date:   Sat, 29 Aug 2020 08:47:14 +0200
Message-Id: <20200829064726.26268-6-krzk@kernel.org>
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
 drivers/iio/adc/meson_saradc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 93c2252c0b89..a9d06e8a576a 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -719,11 +719,8 @@ static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
 		if (ret == -ENODEV)
 			return 0;
 
-		if (ret != -EPROBE_DEFER)
-			dev_err(indio_dev->dev.parent,
-				"failed to get temperature_calib cell\n");
-
-		return ret;
+		return dev_err_probe(indio_dev->dev.parent, ret,
+				     "failed to get temperature_calib cell\n");
 	}
 
 	priv->tsc_regmap =
-- 
2.17.1

