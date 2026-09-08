Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5AF4CB8D2
	for <linux-iio@vger.kernel.org>; Tue,  8 Sep 2026 17:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888318; cv=none; b=cKG00i2BP3VbPQIxMGWg4qBJhLonHhbRhY+t1Bk8w+jEIbT+f2Hn7bmNP8qSKQWY4J1k7tHo+kyiTZLZ+LcCTi3ccTezpa0af9JIIc/uJIaZ2ilchD+LMgtQTg0EKtuMbAXnDQnEIfLRmkyjVsHsaszT5pcDKtSKV3wh8x6nEi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888318; c=relaxed/simple;
	bh=hQ+d7J8gtjsDGLvfNnMIrer8Ha9unpnDP+fsEJIUaq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIClchH1NRvz9J+TmEk32fW4L6VrtIIgjJqKklP+C4sfWrL99qHhPh+hAclPdv+8nlEzsYJPSyqaQLFPm3oOjFru99kYt9ibpPO7GeZMaoEDj3IIpfI7WRE8xK9ZzCtqhXurFSkgfvArK5HqPszZgIVr12jtbjBSavLibM2JXlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCYPs1jJ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCYPs1jJ"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so4674208a91.2
        for <linux-iio@vger.kernel.org>; Tue, 08 Sep 2026 10:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788888316; x=1789493116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZQcP2F4emeVQ9JpkX9Int2YPn5v7ZeGN+IRcU4vsCsU=;
        b=QCYPs1jJnFjY0Ynl6+AswNy4xIy3oO8H9x4ipufxkLf+W9QxwttC0oscO3eltpSI+h
         Ltgh+ZsOyPoL0YIFiJg261H/opm0HVv6t7IOFq/od6kFcwtLSa62SFeo4nw7R85qMeWi
         d9cQ0vh2h2cLv5hIdQRgqvO00zPztQfAJ6EkM9DustcY2hYM5nUIjAbCH/7eWLeLajIl
         qAxo+wPfN5epdIpaLgNjzFs0dWxRF4q0j76kBtBANctz/5Hc+QghLOc+40Af7gZVVmoj
         KA4ilDuxDFBRymrngPuWFQa/LRUV52U0pkY54QRGZpUE/b6k7yjr0Jab6x42PsRY2N70
         645A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788888316; x=1789493116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZQcP2F4emeVQ9JpkX9Int2YPn5v7ZeGN+IRcU4vsCsU=;
        b=poVIyiMY1Gn7Mn4ALf360wch0LbGP1IiZVeOrm6Dls8hD+jBdfq3mtODjHZZMeCjH8
         1xdy8lwJA0lVnlle4iWy8QNNZrOg6zY9EDvt9a+G7nemn2QyTtyxftD6Jx41BZ84xp+K
         FYrkx0LMQlDzKqFYWflq3PdI/AFaPhmqTjVPgcK+0UrEabc5Ovrc80f1v/biNL9zSVS3
         pnEOJk2JFgfXlFT24RmpEcnwNGHRUpZoBksOHX9H+M/ECX0Bj0bupaLm0MiOvRYKUbQE
         iIzxaoelLmLCT75oMSz6r8L++XAIf5jBK9HCjt8/vxhSkCbBP2/GynL4uPxJTmJZKxC8
         XeKw==
X-Forwarded-Encrypted: i=1; AKwUvBxCPwsibOJDKRPV0Dnmsu7Ka/RVgmtdxs52VlCXqk3YrgSWuhyh9nFVNC6GEaUvvlMFpKozTYR3W/o=@vger.kernel.org
X-Gm-Message-State: AFuF++ni2eXTEBplSbUsjgqhtXHsjZnvTtdU3aNMcuDYaYpNmqZwH8Nw
	FqoQl4dzX2ZtUAmkwwH9SVvQHU41UEyHuvQNwueODp11ivpDWAbem9q7
X-Gm-Gg: AYBFou0Uepq2SRko0Z9MPMi7P7XOvhjsizlMl3JIW33Pd4yng1DryOiOBrlNfr+lyRr
	3Cb394e3YPPVdshhSJhJmC0wX2v7lGSsGjWFqwQD45saAa/9JieRcCHfbRZ3OGAOlEUsMTbkkDD
	SZHErOle3+sE2+hE+p9UJlmBZ2PwOtQ2RN7k8aCqeZRmpm/f+QL3cwcqQDyqJcPHgmM93Agfpp/
	qkKf8JEaX9Kkbw8W1OQGhx0gyLaOSDkrLtpwTNyGAnRMGRNKefcE9cZthcqqUuJE/X3lRchgakP
	AmHRkcgg7yla78VrP5cD1z2ith2LpB4VNhEuP71lQZ5LxaBSpeuyzVrQ/J5M7N8+l3IzVsrPyN4
	RC5plpVizPezXtluB/u2Dw7vISNf1Q0ZEhqYhSCXHWk9eGtCj124vuc7E+dGan6VC08pS7/HyMi
	b5AzR77Pmd+Pz8Fk7RZ+ebziurckj+ThAcHe4GCUD10Ex1/obMaLVlWM247Qw=
X-Received: by 2002:a17:90b:3a81:b0:398:c292:ac80 with SMTP id 98e67ed59e1d1-39b2612eaa4mr42334724a91.10.1788888316179;
        Tue, 08 Sep 2026 10:25:16 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:43ae:bf76:d99a:e5ff])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33688cfc714sm19297176eec.20.2026.09.08.10.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:25:15 -0700 (PDT)
From: mdshahid03@gmail.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH v4 3/6] iio: adc: bcm_iproc_adc: use devm-managed clock
Date: Tue,  8 Sep 2026 22:53:56 +0530
Message-ID: <20260908172359.30003-4-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908172359.30003-1-mdshahid03@gmail.com>
References: <20260908172359.30003-1-mdshahid03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

Convert the ADC clock to use devm-managed APIs to simplify
resource cleanup.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 drivers/iio/adc/bcm_iproc_adc.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index 21bd51da9cd6..d6f82f8ddee1 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -110,7 +110,6 @@ do { \
 
 struct iproc_adc_priv {
 	struct regmap *regmap;
-	struct clk *adc_clk;
 	struct mutex mutex;
 	int  irqno;
 	int chan_val;
@@ -511,6 +510,7 @@ static int iproc_adc_probe(struct platform_device *pdev)
 	struct iproc_adc_priv *adc_priv;
 	struct iio_dev *indio_dev = NULL;
 	struct device *dev = &pdev->dev;
+	struct clk *adc_clk;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc_priv));
@@ -530,10 +530,9 @@ static int iproc_adc_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(adc_priv->regmap),
 				     "failed to get handle for tsc syscon\n");
 
-	adc_priv->adc_clk = devm_clk_get(dev, "tsc_clk");
-	if (IS_ERR(adc_priv->adc_clk))
-		return dev_err_probe(dev, PTR_ERR(adc_priv->adc_clk),
-				     "failed getting clock tsc_clk\n");
+	adc_clk = devm_clk_get_enabled(dev, "tsc_clk");
+	if (IS_ERR(adc_clk))
+		return dev_err_probe(dev, PTR_ERR(adc_clk), "failed to enable clock\n");
 
 	adc_priv->irqno = platform_get_irq(pdev, 0);
 	if (adc_priv->irqno < 0)
@@ -551,13 +550,9 @@ static int iproc_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(adc_priv->adc_clk);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to enable clock\n");
-
 	ret = iproc_adc_enable(indio_dev);
 	if (ret)
-		goto err_adc_enable;
+		return ret;
 
 	indio_dev->name = "iproc-static-adc";
 	indio_dev->info = &iproc_adc_iio_info;
@@ -575,8 +570,6 @@ static int iproc_adc_probe(struct platform_device *pdev)
 
 err_clk:
 	iproc_adc_disable(indio_dev);
-err_adc_enable:
-	clk_disable_unprepare(adc_priv->adc_clk);
 
 	return ret;
 }
@@ -584,11 +577,9 @@ static int iproc_adc_probe(struct platform_device *pdev)
 static void iproc_adc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct iproc_adc_priv *adc_priv = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
 	iproc_adc_disable(indio_dev);
-	clk_disable_unprepare(adc_priv->adc_clk);
 }
 
 static const struct of_device_id iproc_adc_of_match[] = {
-- 
2.43.0

