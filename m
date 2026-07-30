Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A9A432E6A
	for <linux-iio@vger.kernel.org>; Thu, 30 Jul 2026 14:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785420403; cv=none; b=Hikf/2paZKSp+cNBhOIR264M347prchopY2EQZnFdnfKKPjVrH0qPkjTZcOx3Fc3izPgVF84Ppecmrub1Xvw5fpDzrTvv/u2LSzwdC9PAThU4zVf4wUTcFwdotq9xR8n540QEpqAR9UL+KafJi9x5ScNWguuX4RHsKGGppxDAJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785420403; c=relaxed/simple;
	bh=ALckN1nV5wzz8cd6PQjathMwp9PWXp/GbdcbSmSLNEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3J3gRqgUlO4qL11qeg0S0cZxZnxg6DoMXf54KBDt5+IqxQTN/OSF87G8YnwvhOMuqoFg3v9r2wNJUI/bvO2DxEgtG9oYPtUc/87GDBIp7b6LbjH8wIk1hkFO1fZ9x7Dw834Dlomj+niqkRBw8249AqhIsc1nxmsS23sRA4wfqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PioGqGcM; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PioGqGcM"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84864086bfeso2225179b3a.1
        for <linux-iio@vger.kernel.org>; Thu, 30 Jul 2026 07:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785420402; x=1786025202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hJ72M8reVIZqxbhzSXS1Mi2+37hAcyZSuGI4YdKYzKM=;
        b=PioGqGcMKNkLX29ZrJEJQQR1aMICZ/Yn5eliNSp6LBJmsKOtJL1bkBu6vikLLHAeq7
         fB6Lj6iRGX9BMJF+J0BdnF+uNu8/u8ENJybxX0ser1dMc4T5rA1NFK4WqolvlPF1XLHZ
         YPHm3he7b4Krk24S431jyuax2vSCBkKEF9kjohRrn71HfipBx7zkw6qR+a0yeYF2IrU1
         0J5W97vc9TJMos7vzc/UTG8yetBjrzVGuzlSTykWl3+mIKaAK8y6hCXnhwtJSe33VpVA
         EQrljezOz8Qqu2Ha0GC3D3hPGm11D5ssKc+/t1IeRcNG7AqOpuZJ7LI0v7QdHSE+vPqc
         OE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785420402; x=1786025202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hJ72M8reVIZqxbhzSXS1Mi2+37hAcyZSuGI4YdKYzKM=;
        b=kDl8kEJzMwEYbuZhAxRjtXaeUK8oTKAZyQQXVcAfvH480/Iu8dRfcFDDpjDv9M3QaA
         QraAr3ic/7MZoPumhnb6FZ1VAMddLIqij9z2WX8fTAxV/jCLCNKqezOhqR9V/3CSjYjT
         fxen3ks+o485hfWQWRLnHanQl4HcRmTbcjDQUR4PbkqIiQvgsfK78wRV6ngwoE+OLOly
         J9cO0Cmnxw5Ewik+oUQvAulw+a3FkU+gedLVRUQEuWLk7qvcAYMF0zn1IKvSnTkkmpW2
         puDP6cr/ElMBjfeYsRS8eIWjM35bFE/HtteemPNN4lnVJEMf47kRDCjPPZXLinaKa9xJ
         c6mQ==
X-Forwarded-Encrypted: i=1; AHgh+RoeszjYT2u5+4gUk/4JnlHqkrsyoMxVzi7UaPJgQRlmjQYVVnJf71tcvA4e/wQmMe8wKCBwGxDYb6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW90MiABPN7b7FOcqFJckfWDjEfLda1YI/8qYdBDZsOoPJDCfL
	MIyZACsToNyyqngrNF4+TMETpX9+r0ekzWPwnKDyFOVrxtPf6NGnueG0
X-Gm-Gg: AR+sD13ewaojPYEsXCIHPcXuAE8P7/H0jughUwP0djKNrfSNJ6dbodZGa1z/mJoBpB2
	PZh2K7ESSOcHne7BAooevnVtdq7wrJZ3yIAFVaTtvArM5VSe9LQ7dRL4wAdb3CiYTSqkEgV3LSA
	6uBqckAEGCzsbxL62/5Il4jHdyybSAZxNIYEXF9greDPDJ4KcW7tox817ebcKiUvtOoIlIZpKr1
	NsGh1h0eGLgdS7XbRLn0XWz34GaRkr5dsYYMd8Ojcmsk9MB7o5LOj5xVQY25FBZlbPBlF7dl7Rd
	nFsmmpEtj5NtdeVFYedhui/4VUqnhTkV90hWvSNg1Z+0hyJyK1mgSY+6zO7FrYPKHto3EcKeLqv
	ggCqyzglPiNYJiZZUX13V/yHj+4O4E49JRpLGRkP/nLdLXkOf1NylSvg8HzdEjhPHbTEtZCHKZM
	LDNpm0My7oLxTIaa6t+O3KaQKkKVnLG7EWaBAeg1sSwVop9Kvp9LRbWyhJe3G0goZtbOnhOsM=
X-Received: by 2002:a05:6a20:7346:b0:3bf:d0c8:2aa4 with SMTP id adf61e73a8af0-3c90067d9a9mr2533292637.8.1785420401598;
        Thu, 30 Jul 2026 07:06:41 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:5fd6:849a:c1fd:20ef])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b15f77sm23551069eec.4.2026.07.30.07.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 07:06:41 -0700 (PDT)
From: mdshahid03@gmail.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	David Lechner <dlechner@baylibre.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
Subject: [PATCH v2] iio: adc: bcm_iproc_adc: Convert probe() to use dev_err_probe()
Date: Thu, 30 Jul 2026 19:32:45 +0530
Message-ID: <20260730140405.369634-2-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730140405.369634-1-mdshahid03@gmail.com>
References: <20260727034009.5c6b0be9@jic23-huawei>
 <20260730140405.369634-1-mdshahid03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

Replace open-coded probe error handling with dev_err_probe() for
resource acquisition and initialization failures.

This simplifies the error paths, avoids repetitive error handling,
and automatically suppresses duplicate messages when -EPROBE_DEFER is
returned while preserving the existing error messages.

Also remove the redundant error message after iproc_adc_enable(),
allowing the error to be propagated without additional logging.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
v2:
- Convert remaining probe error paths to use dev_err_probe().
- Remove redundant error message after iproc_adc_enable()
 drivers/iio/adc/bcm_iproc_adc.c | 52 +++++++++++++++------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index cf4738b16e62..08e056468d8e 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -522,52 +522,48 @@ static int iproc_adc_probe(struct platform_device *pdev)
 
 	adc_priv->regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
 			   "adc-syscon");
-	if (IS_ERR(adc_priv->regmap)) {
-		dev_err(&pdev->dev, "failed to get handle for tsc syscon\n");
-		ret = PTR_ERR(adc_priv->regmap);
-		return ret;
-	}
+	if (IS_ERR(adc_priv->regmap))
+		return dev_err_probe(&pdev->dev,
+				     PTR_ERR(adc_priv->regmap),
+				     "failed to get handle for tsc syscon\n");
 
 	adc_priv->adc_clk = devm_clk_get(&pdev->dev, "tsc_clk");
-	if (IS_ERR(adc_priv->adc_clk)) {
-		dev_err(&pdev->dev,
-			"failed getting clock tsc_clk\n");
-		ret = PTR_ERR(adc_priv->adc_clk);
-		return ret;
-	}
+	if (IS_ERR(adc_priv->adc_clk))
+		return dev_err_probe(&pdev->dev,
+				     PTR_ERR(adc_priv->adc_clk),
+				     "failed getting clock tsc_clk\n");
 
 	adc_priv->irqno = platform_get_irq(pdev, 0);
 	if (adc_priv->irqno < 0)
-		return adc_priv->irqno;
+		return dev_err_probe(&pdev->dev,
+				     adc_priv->irqno,
+				     "failed to get IRQ\n");
 
 	ret = regmap_clear_bits(adc_priv->regmap, IPROC_REGCTL2,
 				IPROC_ADC_AUXIN_SCAN_ENA);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to write IPROC_REGCTL2 %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev,
+				     ret,
+				     "failed to write IPROC_REGCTL2\n");
 
 	ret = devm_request_threaded_irq(&pdev->dev, adc_priv->irqno,
 				iproc_adc_interrupt_handler,
 				iproc_adc_interrupt_thread,
 				IRQF_SHARED, "iproc-adc", indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "request_irq error %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev,
+				     ret,
+				     "failed to request IRQ\n");
 
 	ret = clk_prepare_enable(adc_priv->adc_clk);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"clk_prepare_enable failed %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev,
+				     ret,
+				     "failed to enable clock\n");
 
 	ret = iproc_adc_enable(indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to enable adc %d\n", ret);
+	if (ret)
 		goto err_adc_enable;
-	}
 
 	indio_dev->name = "iproc-static-adc";
 	indio_dev->info = &iproc_adc_iio_info;
-- 
2.43.0

