Return-Path: <SRS0=A9f8=CH=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8792CC433E6
	for <linux-iio@archiver.kernel.org>; Sat, 29 Aug 2020 06:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6438921527
	for <linux-iio@archiver.kernel.org>; Sat, 29 Aug 2020 06:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598683697;
	bh=33QUtFhKd3vgFdrs9V7vjN8bhfHfPOFBEs807yqJTy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Of2pcp3/+/orybf0bqP3q4K3jSBWmjHbEZuehIkDvZoYG+WtmaSd3uU9km3Dn18q2
	 E5EeVx9JgkXXbPba0t3/AFljT/qkSYQWbJ/xUb3TN6dwK3qr46bZuKTD9h3i6n3kJS
	 VhNgaHMEZs1MEL+6BZhElUNRFmucg+H1bjrLqQ1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgH2GsP (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 29 Aug 2020 02:48:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgH2GsM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 02:48:12 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F36F21473;
        Sat, 29 Aug 2020 06:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598683692;
        bh=33QUtFhKd3vgFdrs9V7vjN8bhfHfPOFBEs807yqJTy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t/KnJ9CCBKHeRoBU9R9NcQBXtGQUvnGSSp/nMljOr+8LyxPl6dyVxWp2EtdN1LJrP
         jBY4dpR7F0VB6pwiBn5q5gTPnff4zZIx/5OHZcqdEJSIlAce1BOGkV3sPhacGPBEtv
         y+8GauNsfHY8duxUSJ274xajuI6MYgGzCLwMIL20=
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
Subject: [PATCH v3 03/18] iio: adc: envelope-detector: Simplify with dev_err_probe()
Date:   Sat, 29 Aug 2020 08:47:11 +0200
Message-Id: <20200829064726.26268-3-krzk@kernel.org>
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
 drivers/iio/adc/envelope-detector.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/envelope-detector.c b/drivers/iio/adc/envelope-detector.c
index 2a4fd3bb64cf..d73eac36153f 100644
--- a/drivers/iio/adc/envelope-detector.c
+++ b/drivers/iio/adc/envelope-detector.c
@@ -348,11 +348,9 @@ static int envelope_detector_probe(struct platform_device *pdev)
 	indio_dev->num_channels = 1;
 
 	env->dac = devm_iio_channel_get(dev, "dac");
-	if (IS_ERR(env->dac)) {
-		if (PTR_ERR(env->dac) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get dac input channel\n");
-		return PTR_ERR(env->dac);
-	}
+	if (IS_ERR(env->dac))
+		return dev_err_probe(dev, PTR_ERR(env->dac),
+				     "failed to get dac input channel\n");
 
 	env->comp_irq = platform_get_irq_byname(pdev, "comp");
 	if (env->comp_irq < 0)
@@ -360,11 +358,9 @@ static int envelope_detector_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(dev, env->comp_irq, envelope_detector_comp_isr,
 			       0, "envelope-detector", env);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to request interrupt\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to request interrupt\n");
+
 	env->comp_irq_trigger = irq_get_trigger_type(env->comp_irq);
 	if (env->comp_irq_trigger & IRQF_TRIGGER_RISING)
 		env->comp_irq_trigger_inv |= IRQF_TRIGGER_FALLING;
-- 
2.17.1

