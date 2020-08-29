Return-Path: <SRS0=A9f8=CH=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C31C433E2
	for <linux-iio@archiver.kernel.org>; Sat, 29 Aug 2020 06:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B35420E65
	for <linux-iio@archiver.kernel.org>; Sat, 29 Aug 2020 06:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598683703;
	bh=yN2CXKQfY/uZdOl3rgqKv39aMA7Qb1yuEX/j8QscrAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LqhDqHzI+Im/0n++jhhIfpkfTsOTE4GBpH17BjSj4WG/yT1JG0KBCTyXXlBQ3TUM/
	 23sWLW3OkolhPVBdoiJX8mDzQE81DNsWff4vndxzgqCrz7F9MtGBuklObKSq5X2H4N
	 Ulz9oqVjveoMeB82G4VVnzvPhu/0izwVjtXC1b40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgH2GsU (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 29 Aug 2020 02:48:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgH2GsT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 02:48:19 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8023E214D8;
        Sat, 29 Aug 2020 06:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598683699;
        bh=yN2CXKQfY/uZdOl3rgqKv39aMA7Qb1yuEX/j8QscrAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GpwEXvL9qr/48IVmL4F6CQvkM2Et247vmZQD1fZ8sDc2nHJfg2ENTpNrjb3oHGy6+
         4AffxnMZWvXHtYlHuP1dTYidoVKasMJD6YBsm3nVUrS18Pj/HXXBtTeinPZQ8JyX9C
         TtRo1Xjrzvm6reSLMOB9fiNB8VSYs2nBGfYkkD8Y=
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
Subject: [PATCH v3 05/18] iio: adc: ltc2497: Simplify with dev_err_probe()
Date:   Sat, 29 Aug 2020 08:47:13 +0200
Message-Id: <20200829064726.26268-5-krzk@kernel.org>
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

Changes since v2:
1. Wrap dev_err_probe() lines at 80 character

Changes since v1:
1. Wrap dev_err_probe() lines at 100 character
---
 drivers/iio/adc/ltc2497-core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
index 9b8fd9c32364..2a485c8a1940 100644
--- a/drivers/iio/adc/ltc2497-core.c
+++ b/drivers/iio/adc/ltc2497-core.c
@@ -180,13 +180,9 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
 		return ret;
 
 	ddata->ref = devm_regulator_get(dev, "vref");
-	if (IS_ERR(ddata->ref)) {
-		if (PTR_ERR(ddata->ref) != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get vref regulator: %pe\n",
-				ddata->ref);
-
-		return PTR_ERR(ddata->ref);
-	}
+	if (IS_ERR(ddata->ref))
+		return dev_err_probe(dev, PTR_ERR(ddata->ref),
+				     "Failed to get vref regulator\n");
 
 	ret = regulator_enable(ddata->ref);
 	if (ret < 0) {
-- 
2.17.1

