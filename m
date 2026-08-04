Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1674748CD70
	for <linux-iio@vger.kernel.org>; Tue,  4 Aug 2026 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863191; cv=none; b=bjrzmU+3Ghvhzh4LmZzuHhgfOiJVc/8J+yyGm8bvJXWAzE1uOBKWNbI8S8ZHAp/D1nGGlz95sxrxvTLF1VoiHcFCccqm83/yVD4g7UtPKHb4r3YqanFyP8TkgY22F9qMBIUGkMMeoCbHI1JlDjEhW5swIdRlc/6MKWN1f8ATEMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863191; c=relaxed/simple;
	bh=aaG3fmxJFvgG+2hFmR/kUuEaeX8ZQwfOcPELccRjOzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7k9ZHMaZjhlyN0W3NBDR/fwESCZAgyf1c/mzxgxEGA5efvw1yA7QHxTRYvpmLN2G6bjuggitwmvFPz4GnVsAMMa7wVfB5IuSTAsWTrCtu1wUM7yKyKbMdZAcSnO+UsUDreKB+gZvmPxhIKRCdByV0WRyxj9okPP4VVKI0gHaT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBbvmu0C; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBbvmu0C"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cab973140bso1183945ad.3
        for <linux-iio@vger.kernel.org>; Tue, 04 Aug 2026 10:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785863180; x=1786467980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/WxyWYexSwoS0Xhfap20Ecck/ANPlEcZKb1zpjgFsT0=;
        b=WBbvmu0C6DRhghhkcJl+g0iMqEkLHvApWeA3H/ftbbVto+TQem8J3G7UftYCL3eYeL
         8iCzxIvzeDwrABHO81i7X/62hWSHX3s46ZXwFXD6v+Z7bWS9aRmn4DAR26SpRlaX66zm
         X5+OG4ab10xgzuxB8uHZnKhvrGBkOOCfzq6igx43XdlBNX2S8JaRGqvYeqGvyeKAwuSc
         gf2LvDM8RhQMDiZpbN5/9ga93uKwSBUdEgOMEYmwGig7FatoODaAz2QHlhrmFLHSOKio
         m0lnutkD7HrNtdAdFvEW+5YOlU7U5lIbCuvlBkfXGWVHdGIgPi5aOYOBaQE4NDGgPRS8
         fWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785863180; x=1786467980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/WxyWYexSwoS0Xhfap20Ecck/ANPlEcZKb1zpjgFsT0=;
        b=VDDExIw+EM0N0FftdNMeHRr+QSXYyflT6PtxiiDrjY6fEJVQwdqE2xw3kPGKSLGKHt
         BdRmPA8mudP8S7NteyCQe5RTDIjfmaIXA7zqYgZ/iQffMoCg+SLXcWKzjKDF4TbcZ1jS
         qDDNvq9Yf+4BMKkVlpVZ4Bu1+Pg3XxAghH+ir2yTLpj7vCMMA7DK7jyM0ADww851RZjU
         vufAk7cXkdhJjYjz5desK3N5+oKn3HESMqElOye9e6wwmitWgwOexJrsPcSOwS9cf2fN
         v5mk2vWPwkpaaCAt5gMFY05fbWG0y/xXqnifllVwA0AbZCxewIXamJws4QxGAekubAHQ
         HRdA==
X-Forwarded-Encrypted: i=1; AHgh+RoVH2srxd9+9xmIPId2fX/5s6gGExSUQro+DYJfVtHzwIavw4Yjvteoh3Xti+SOGLaltoZy+d09B/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIEVM5cNHQ6xP26gDF/ui5AmpKEA/SGrtufE7Koni1cZLJ1VTI
	cxgqUM8T+WMa655t7bK9QSsJpVgciXJ3Yjxr43/joFRzPYF7Xz3sUhgx
X-Gm-Gg: AR+sD12rjIi4ve6tw1sjWqlEghfIdc6FbSV0y1k3YzXmaXQp4hFy9AoClQH5vtmPcGR
	3i+xb6E6eziS1K249DGk/OloQo8GT04/WD6DrTl87ez7FvDkijPIe8pSvjVE8hNQ9qZFWo5GcMm
	Vqz0mwu2GOTrCWlO5+F2Njoz/GPiTZHv82WFXpZw+CAFuVN0LRev27U2XeZo/DqCsz9+8bFmRIV
	wnG7wbxIhTLJPupgx7dAm7PrTssXKItARb8nHYFQTwKFRHe0yl2dim1lAY5clIwnYOfMvVx/AN/
	NCogpJh1gaQWLiKieSvY+sgmKm97REs2zixL7WADlR92gmJrcpoNsWsqSwknhaAEzsSxSLKLmhJ
	30fTdKWteBpezhY+l3s6R8o+eKQvAxzz6s/sIFek1pftHI1pVDoP5EUxBVuw4O+kGKVUGeqZZy/
	g5fCD8ULyLeQ3q9HKgTFHIX5grwKS7HZ7oxuaqh2HfDWg4aL4JS+LNcI4YQtLRFJtAgZ0LCLxFR
	nc4dob1OA==
X-Received: by 2002:a17:903:2b0d:b0:2ce:faa6:7cbb with SMTP id d9443c01a7336-2d0ca7afcc1mr2775625ad.4.1785863180300;
        Tue, 04 Aug 2026 10:06:20 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:1461:a94d:d559:948d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31586162e80sm7230582eec.0.2026.08.04.10.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 10:06:19 -0700 (PDT)
From: mdshahid03@gmail.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH v5 3/3] iio: adc: bcm_iproc_adc: Convert probe error handling to dev_err_probe()
Date: Tue,  4 Aug 2026 22:35:21 +0530
Message-ID: <20260804170521.196393-4-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804170521.196393-1-mdshahid03@gmail.com>
References: <20260804170521.196393-1-mdshahid03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

Replace open-coded dev_err() followed by return with dev_err_probe()
for probe failures that immediately return.

Leave error paths that jump to cleanup labels unchanged to reduce code
churn. These paths will be converted separately together with the
planned devm-managed cleanup using devm_add_action_or_reset().

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 drivers/iio/adc/bcm_iproc_adc.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index 312be7c12e58..9238dc8c8873 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -522,18 +522,14 @@ static int iproc_adc_probe(struct platform_device *pdev)
 
 	adc_priv->regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
 			   "adc-syscon");
-	if (IS_ERR(adc_priv->regmap)) {
-		dev_err(&pdev->dev, "failed to get handle for tsc syscon\n");
-		ret = PTR_ERR(adc_priv->regmap);
-		return ret;
-	}
+	if (IS_ERR(adc_priv->regmap))
+		return dev_err_probe(dev, PTR_ERR(adc_priv->regmap),
+				     "failed to get handle for tsc syscon\n");
 
 	adc_priv->adc_clk = devm_clk_get(dev, "tsc_clk");
-	if (IS_ERR(adc_priv->adc_clk)) {
-		dev_err(&pdev->dev, "failed getting clock tsc_clk\n");
-		ret = PTR_ERR(adc_priv->adc_clk);
-		return ret;
-	}
+	if (IS_ERR(adc_priv->adc_clk))
+		return dev_err_probe(dev, PTR_ERR(adc_priv->adc_clk),
+				     "failed getting clock tsc_clk\n");
 
 	adc_priv->irqno = platform_get_irq(pdev, 0);
 	if (adc_priv->irqno < 0)
@@ -541,10 +537,9 @@ static int iproc_adc_probe(struct platform_device *pdev)
 
 	ret = regmap_clear_bits(adc_priv->regmap, IPROC_REGCTL2,
 				IPROC_ADC_AUXIN_SCAN_ENA);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to write IPROC_REGCTL2 %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to write IPROC_REGCTL2\n");
 
 	ret = devm_request_threaded_irq(dev, adc_priv->irqno,
 				iproc_adc_interrupt_handler,
@@ -554,11 +549,9 @@ static int iproc_adc_probe(struct platform_device *pdev)
 		return ret;
 
 	ret = clk_prepare_enable(adc_priv->adc_clk);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"clk_prepare_enable failed %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to enable clock\n");
 
 	ret = iproc_adc_enable(indio_dev);
 	if (ret)
-- 
2.43.0

