Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E55243E06E
	for <linux-iio@vger.kernel.org>; Thu, 30 Jul 2026 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427059; cv=none; b=ueJ+HsfQelJRjSy/S2u5itJ5f7rqz5yv3Z8YWadgLmZ394V5GfPrGC50RZSfeA0QA0oWcVMwJJO7jww01Yh+u8Lf24VOe52Tq+sAk0sZDdwViZwTD2uhfWCsmfdvHYNQ3o9sWtAszyP3CerPPMXyHWMcEctcGhGwdN6luMo6T/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427059; c=relaxed/simple;
	bh=ALckN1nV5wzz8cd6PQjathMwp9PWXp/GbdcbSmSLNEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AnETFkgHQ3ahwdiByOSN2T5DUVum/sTbGKm8ZZltWmM56SZh6cs89L6yuEVTsYDj4VE7R+06D3OYDYWq0ZPyF2CvlExCuBZSP7XEWUzWq7LwwqbYeNwyi+rfKxkUaNQ+H9kyWxiJ70+VVBAKWTE1AR01A6O82fGfcOYi59LPBQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4Ix/Whb; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4Ix/Whb"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cbb662575d3so1387725a12.0
        for <linux-iio@vger.kernel.org>; Thu, 30 Jul 2026 08:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785427057; x=1786031857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hJ72M8reVIZqxbhzSXS1Mi2+37hAcyZSuGI4YdKYzKM=;
        b=Q4Ix/WhbWDv6H7PK0m63V6++Gu69Q0t1KIO4/oJCXndAPGkG/Lfya0W4nfZj4afdG5
         YPX63gG0D0tgAFRTrKL6Vj8GsfmUIofALkqc+aYhbgMNh72/cB094IS8YUaiglOCj8KY
         vdyF6/AZyfJx6leUwYXk2KAxubPemgBfFr6BnfDtfU/6kD8O9hJuS2nKX8K1+AA8ynPl
         UCSP/BKR6QqU1v2AYYBDyxZIzrJ9OZntBEA4bMu6qYb6UB7HfgII2Sjlv1kqu5PBp5/s
         Yg1UbK6T+xGzjPoGT96tbN1ZBzX9zOzehyK/3qslHV6n6UnTQXbZr/0E27JbdH4oRWfY
         Fmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785427057; x=1786031857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hJ72M8reVIZqxbhzSXS1Mi2+37hAcyZSuGI4YdKYzKM=;
        b=E5ZP4pl1gRW4Blk8twm5UpzlvnEoOieaY762IJpZVpm3EcHahQ63koe/K98bAMoN+c
         si2e18SG8qLrNYOcvw6G8EOPajSk/BTAbq6ZW0IO5DpfhGKKj4QFFkFJ0VjFIuy6m+OM
         ZsD9RoQBCz7XZGfI5JH0kQw0erTm8aZEDlPFqHK8VzyQPxSNfQhpLe6HfgdEvc8L/Wm+
         x8McXYKi3/Pknml8M4ociQAf/Jqs/xq/Us8gho2m+2282lNtfLjwlCV8OdMOlgHoKwzc
         DKtaQm5F9I0xjYkEGI/lvesdnigMdavN1ETMZtI8AyoF5wNrwQQ5LqSVS4eNoRiN+rEY
         PllQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro/swaR9fDh0GgXg3eRv11eCoFcAhTU7giRNGvuuo9F1c0Ilazn5Bx2gJPyLNEkkF8naWmbHAp05OY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb7v8mfczwL7WC2NlpJTwVh6HPyzY4PYT38dri6K1XGbTM9Zh9
	IFfFf1LCGOzx14av2mLoaoGh2U0Dx5Y8a1S6K1QNoKXxcsu2Jr6oK/52
X-Gm-Gg: AR+sD11P1hrnIvVW1Rblz/+ZhB67urAn/3zNjLl1ZNKb8ABdhz8hUtEh2cB/mVZ50BX
	oDAqgiiCZDCqURvZtfMmXXC/81Ishwx1/LrrpE45idTON3lN3nueVmYPVH0eE0OxNEiN3W+80po
	FJUwMt6LLuqbHcaa8sklUIem+Yp2Gu1bHlfmTjaS5f9qb2n8u5sgZjN08aJv6+/WQIuvP+6tVH6
	VPp8EHmeGuj9VCbsFwN7QyxQyNp4BaA254ZpuKwBUdl8Pv9KL0RQhFPyBeTBjt+dSb3BUcL9A5K
	sXwleWV+rhKjCUfd2vyEgcJlQmr9kkNIAHAJxqhvHRH8MbHnFa0mTkzWD3USJGqm6k83cmBOCYa
	7UJDty95qk3Xek4VRZnJNjLk5F5bKErQJ6xoJzd4rTNRIue4hMj4fcxeslIyzVRwg9fOfLQy5PH
	l0p+XV8JVrLz48NJ3suIcEvHkgX2LDzcWYRG6HkLulaTjige7rl5rRD8TUjJg=
X-Received: by 2002:a05:6a21:4d91:b0:3c0:b766:7500 with SMTP id adf61e73a8af0-3c90075983emr3111077637.68.1785427057464;
        Thu, 30 Jul 2026 08:57:37 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:5fd6:849a:c1fd:20ef])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504e1ff81sm23423608eec.31.2026.07.30.08.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 08:57:36 -0700 (PDT)
From: mdshahid03@gmail.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	David Lechner <dlechner@baylibre.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
Subject: [RESEND PATCH v2] iio: adc: bcm_iproc_adc: Convert probe() to use dev_err_probe()
Date: Thu, 30 Jul 2026 21:27:12 +0530
Message-ID: <20260730155712.374464-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
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

