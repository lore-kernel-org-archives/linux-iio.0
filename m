Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84F83BE17B
	for <linux-iio@vger.kernel.org>; Sun, 30 Aug 2026 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788109832; cv=none; b=AQyw+XQusKcxAegw9EOleLATlDF1ZsU97ZhNug46MxEcDk+J+YqYUZTzk6gYwDoecFQ1gc9cJ88KH2sgk+Vilgu6KQNiEPWxyc4AZsZQNf8iV2HgQSyeUR0RHI4AWz2Vx0vuyzwZrgCqFxGyc4LfwUB0jSiIR/RcM98aeuoWzZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788109832; c=relaxed/simple;
	bh=GqNRyeTFsr7wcrfJ85wse0w5ODrwzgVQAdrq8D4JKck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJXycw20RPHseqy/wWSARVuC/SXqQCTtttqySmQCTduthzx2lNf40txuA8B1z73dfxZaGcifnS861hM5R2k5vBBjxY72N6plauQeYzvMsWyx3MiNLvcVGaSiemOuxmYQTcJqaCYQE0RlgbcYDsSsQ4b6bWyXOLcGi3ZYd6ruHwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIhBjvjN; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIhBjvjN"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-398a4dcf289so1669061a91.2
        for <linux-iio@vger.kernel.org>; Sun, 30 Aug 2026 10:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788109829; x=1788714629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ri0QbBDUdQXRFUs7t8FRY1qNhNj6rQaG5ZybdVVmKl0=;
        b=EIhBjvjNPWq5uPfqy+219fwo0EdJvM+f9D70VNddK0wPAssXs/UgENtbkT68cS0Xfl
         7h1L4VOVTZ/sZIcak4WTGsyAqSOsG1N6fs9XCqTjSsj6DoWsgIpijfN6w1Sxbx7G5yTe
         srLbPQu3x2hKV5pCCEN1gZV6sElYmGhvE7x3lYjocwypVxfgWUIzgn7E2yHXrc81rjk/
         gB4YQSX8zqqu+jtEps5QWqMKIPMJNxeowAsH37H1ouvriccaAlznK231JVQJIEopG68E
         1SBQ4LZ33DwietvDaIhNt2erjgmNg5KqFS/FXX5diYIwloaV7ndKORzWIUPpEc+2Yk8N
         7Lsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788109829; x=1788714629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ri0QbBDUdQXRFUs7t8FRY1qNhNj6rQaG5ZybdVVmKl0=;
        b=M4rFToDKpZML6aVmNeVaava0SP0TyzesKTLEkeSDL6E0QEifjVHWmD7QmozL3BLp2a
         IEV5NnZ390LCM0ydTzTedcgWDWUuDYSyssQ0j+ReqFDVxfWwr3HWWgt7UEDLbx3Mnyhf
         67AFwETFBLEcxLkDs/MpWvrq7yvG42c5fzvRe+f0Na7vmj6MIKJfvXR3hcZI3dKWaukr
         bo3PWpkNu2FXfe7OVsQVyAj8zFbI7kvHpgevBycruOP/hh7x/TibFXKVc4W3sYocHWiF
         8rWzHLyXQdF/sZ9bvb4s2lljhmB7py5LLMIcPGsvoM4DrvopcKjj0UknH1/tsH35ez4h
         RBIg==
X-Forwarded-Encrypted: i=1; AKwUvBwd58qx0T/3vwQnttQKdK5fAsVAOL8U+Y3w9vS7EAXn5rzehUFRVgZbVEsbi0FgBdAsHHXLDb14+AI=@vger.kernel.org
X-Gm-Message-State: AFuF++nDrmaAsVWfgqbnfiJ1YoZw6HENtnFF7mfZ24C1l8vTpSP/aPQk
	YSVy2lL0Zfe637YduQphcjxBWexJAvV1QrWljPOjaxpbJbsyt6TrUgbD
X-Gm-Gg: AYBFou1IQzDon+r99UDUJD7hhdnVqN8w4GlG0sZGZN1EAWJ+XuMufhRW+EH1yBmmetB
	N8iZ3Lo6moXA6s2qOm1YwNo8pjf9UvsnUe/kbMikPRglM8oxueatdkZUT7u9SmZGi4Sa+AcPTYG
	LdMLxijVIgQ7a1+0WwPLIsVfm3MHDYvyYdkAy9Of7bqhbspwzp5CuxYdFJ/5/DOlLjj0vnTsB5g
	tq6QqtFILYxWhOi4d+l6dU9S9lxY9laM0n4OiQWgHSEtFrfPeREgf7mwmvslspR/RbBnasw41a2
	wyFstaKAYOsFyg5T24dlGBJMgi4EtNYNqoutQLerjP/nUoxZK6YEGyUiqef5LX90fLkKRkwmXBk
	JsEu976tsiPv/IGyaI8EqHnoiBceGuNLyISGJimbzFrbXIQB9ezU3LvQ1sFA2RBnrXPdJlikq6C
	OZpRKyVoC84SjBbNwy7cgxoiz6bMmyCEEp874IYutTA0GrukXMu6BeGQvOhw==
X-Received: by 2002:a17:90b:440c:b0:381:6c5:3f63 with SMTP id 98e67ed59e1d1-396d0eab08bmr31913392a91.6.1788109829049;
        Sun, 30 Aug 2026 10:10:29 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:88d5:45ce:40e:490f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fcfa3asm17047101a91.6.2026.08.30.10.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 10:10:28 -0700 (PDT)
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
Subject: [PATCH v2 3/5] iio: adc: bcm_iproc_adc: use devm-managed cleanup
Date: Sun, 30 Aug 2026 22:39:16 +0530
Message-ID: <20260830170919.470974-4-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260830170919.470974-1-mdshahid03@gmail.com>
References: <20260830170919.470974-1-mdshahid03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

Use devm_clk_get_enabled() to manage the ADC clock and
devm_add_action_or_reset() to manage ADC cleanup.

Since the clock is only needed during probe, keep it as a local
variable instead of storing it in struct iproc_adc_priv.

Register the ADC cleanup action immediately after enabling the ADC
so that it is automatically performed on probe failure and device
removal.

This removes the manual clock cleanup callback and simplifies the
probe error paths.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 drivers/iio/adc/bcm_iproc_adc.c | 39 ++++++++++++++-------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index 2b59819c4ca4..c7fbdc21f8cc 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -107,7 +107,6 @@ do { \
 
 struct iproc_adc_priv {
 	struct regmap *regmap;
-	struct clk *adc_clk;
 	struct mutex mutex;
 	int  irqno;
 	int chan_val;
@@ -449,6 +448,13 @@ static void iproc_adc_disable(struct iio_dev *indio_dev)
 	}
 }
 
+static void iproc_adc_disable_action(void *data)
+{
+	struct iio_dev *indio_dev = data;
+
+	iproc_adc_disable(indio_dev);
+}
+
 static int iproc_adc_read_raw(struct iio_dev *indio_dev,
 			  struct iio_chan_spec const *chan,
 			  int *val,
@@ -508,6 +514,7 @@ static int iproc_adc_probe(struct platform_device *pdev)
 	struct iproc_adc_priv *adc_priv;
 	struct iio_dev *indio_dev = NULL;
 	struct device *dev = &pdev->dev;
+	struct clk *adc_clk;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc_priv));
@@ -527,10 +534,9 @@ static int iproc_adc_probe(struct platform_device *pdev)
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
@@ -548,13 +554,13 @@ static int iproc_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(adc_priv->adc_clk);
+	ret = iproc_adc_enable(indio_dev);
 	if (ret)
-		return dev_err_probe(dev, ret, "failed to enable clock\n");
+		return ret;
 
-	ret = iproc_adc_enable(indio_dev);
+	ret = devm_add_action_or_reset(dev, iproc_adc_disable_action, indio_dev);
 	if (ret)
-		goto err_adc_enable;
+		return ret;
 
 	indio_dev->name = "iproc-static-adc";
 	indio_dev->info = &iproc_adc_iio_info;
@@ -563,29 +569,18 @@ static int iproc_adc_probe(struct platform_device *pdev)
 	indio_dev->num_channels = ARRAY_SIZE(iproc_adc_iio_channels);
 
 	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "iio_device_register failed:err %d\n", ret);
-		goto err_clk;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "iio_device_register failed\n");
 
 	return 0;
 
-err_clk:
-	iproc_adc_disable(indio_dev);
-err_adc_enable:
-	clk_disable_unprepare(adc_priv->adc_clk);
-
-	return ret;
 }
 
 static void iproc_adc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct iproc_adc_priv *adc_priv = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	iproc_adc_disable(indio_dev);
-	clk_disable_unprepare(adc_priv->adc_clk);
 }
 
 static const struct of_device_id iproc_adc_of_match[] = {
-- 
2.43.0

