Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92E846F48A
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785522274; cv=none; b=UZcjH93Cawd8zzCHYmkHFTyDY8fpwkK2DZj1TOUjd/4n9xsMg1jySeWLh2h+2aM+jO0J623kEkk98NDfz3eYsvjnaisVPp0T8DFp+0yHCpE6x5sB10qPv3yk/xxvRmUomRswNVC/MfaO7AjWPaaWqSV0D/Z+4GyQU0B6F7rCs0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785522274; c=relaxed/simple;
	bh=j4VKKE2lbj9EIehEK9wJEP89gyl1CvgBqtl5SfvS28s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mL4Cdp8tx9sT7EDmg53X4oDbXcEnyW+OgGovxSX/0T/5fjmfgOVG54ikOvfIBzC9AozfFef65ts2sQgbxql341uNGHp2tLCoKKQRP9l7UCX2k1MuMZNIB/3wisiANFUbR/8AEr2Jg2/mhQ6cKJ1jYsBP0Yy6Hh2aHY54VlRdB7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqOAVfux; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqOAVfux"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cfff5f88dbso15154025ad.3
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 11:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785522272; x=1786127072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gsS73bmDoxyOch7pFT+GXYXN7OXiaTwdO6oVVnU6ol0=;
        b=fqOAVfuxd0YXprlVo/1PwgPvj+ReaQ6VTQq+JkPfdW2JqjA5F50PTwsDtmEimu/KyM
         eLWsHh5YZDIZtsjDSM9FDWUyOOE+M35t174XHrq5Kr5D4GbvNgwuqmleau7zboDojkNR
         uP9si+NWBdq4UJjh/VMX2yDAHtwjLdkFZFhq0ZAZ5kmHSZbjxIMozECd3Q8xgyY95KXE
         DhLHCWfNZNDAVfoytuEeTDehrP59C/NwCxLDHjfAOO7U1FWMZFNMD2DAJsb3y/cZ51WL
         wkUMUrFz6G3Rr2DzUJ/pNtmVE6DK4HwLJaqG6NB6SH2Cr/yT9/wByIuph2qTRwsiW4eJ
         H2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785522272; x=1786127072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gsS73bmDoxyOch7pFT+GXYXN7OXiaTwdO6oVVnU6ol0=;
        b=AvIMMmqUO+F82pppTip7QY/L2vXGf9H3TGbR24V7+KSzDgML5en/NhxT+2clM499gR
         dbuIpob5CmE4ZhWQxFbGwo4yo8TDpY3YfIWYx4/FVjfUzwUEh605vwrhi44LlBGO78Lf
         /SPZpWiFVt8/309v038KGDg5mYkMpgV1jXwNxFZz/WEqSRf3ysMk3Xka006HxNFLOFI3
         +d+lZhk8gF6/K7yJpQxIC4/E/gqwN57PfRpTGZFsnYkXk9J4x+pr/iMP6v80bTYdGOm/
         jj2xj9/QSWQonNlF8hrBpCt0+ivRPZ7Ix5m4co4lVWmYZo/cb9WUwCWFXh5CImb/vnsf
         7Nlw==
X-Forwarded-Encrypted: i=1; AHgh+Rqe5imyd/hehsEHLxRpdmq81qb5Lv6mbX2/TwPtCceRsm5pCUjAJaLKjwSZOI5m72hKCctBgxZMiwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YztGvZxnxCnSTG0b3QQ4aqExdq5IYunHUEzFzIXUlyxImtgLjYm
	3wjNajdhpy3hFbFX5hWX03zEvFzn7NQopqhcAetRdPRDyM0uoQQ4l7Dv
X-Gm-Gg: AR+sD128XmIIT96854G+DmXyPDrOMn1JQEc9OnuBSWsnM78ca+2Spc4txo8mHsv6LnC
	bh7uW0/jBn6+6dJtjRKMG3v3wEYH7SHcKJnNrC2O+0cnyboNb3csnx6uUMP08HaC6mKHoa4rnSj
	L5qeL3Q2Uk8ubFmApjB/FP7OxF1ymr7/ImOLibw23ZDCuqPw2UyX2ySwg86b079YVnYokeTQDP1
	3wxE+p2d9MwXxCkbcXJN3RReXlhsieLJcpVduIDfa2ceyVLSGf9JB8rd02Wh+wxm1S/qxzeIFZa
	MSsstn4hgc/lXDaXwCh3QYCT09KGHyFMs3r2iW/jVONs8PxTVHeDUKsKT/Iw4EN1zpl3ITXoBwb
	J0BGGJwvAMswrM6Tj1NZ2Aha/QMSBNi79qjAHnF6ga/m2epMsR2yLBm45OSeSTaNZ22ksqXf/0O
	aiHH7dHvWqC4SHiQEwd+i6IczieoxI7PCdSyIkczad2u3Qj2B+FGgm0xRfxH2t
X-Received: by 2002:a05:6a21:6f13:b0:3c4:2a97:fd2 with SMTP id adf61e73a8af0-3c92a8757b4mr806736637.67.1785522272021;
        Fri, 31 Jul 2026 11:24:32 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:d69c:7f00:28b4:311c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9c1casm8400785eec.10.2026.07.31.11.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 11:24:31 -0700 (PDT)
From: mdshahid03@gmail.com
To: Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Joshua Crofts <joshua.crofts@broadcom.com>,
	Broadcom internal kernel list <bcm-kernel-feedback-list@broadcom.com>,
	David Lechner <dlechner@baylibre.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH v3 2/3] iio: adc: bcm_iproc_adc: Introduce local device pointer
Date: Fri, 31 Jul 2026 23:53:46 +0530
Message-ID: <20260731182347.42888-3-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731182347.42888-1-mdshahid03@gmail.com>
References: <20260731182347.42888-1-mdshahid03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

Introduce a local 'struct device *dev' variable in iproc_adc_probe()
and use it instead of repeatedly referencing '&pdev->dev'.

This simplifies the code and makes subsequent error handling changes
less verbose.

No functional change intended.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 drivers/iio/adc/bcm_iproc_adc.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index 1b0dd654402f..29ea35972a23 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -506,9 +506,10 @@ static int iproc_adc_probe(struct platform_device *pdev)
 {
 	struct iproc_adc_priv *adc_priv;
 	struct iio_dev *indio_dev = NULL;
+	struct device *dev = &pdev->dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev,
+	indio_dev = devm_iio_device_alloc(dev,
 					sizeof(*adc_priv));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -523,14 +524,14 @@ static int iproc_adc_probe(struct platform_device *pdev)
 	adc_priv->regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
 			   "adc-syscon");
 	if (IS_ERR(adc_priv->regmap)) {
-		dev_err(&pdev->dev, "failed to get handle for tsc syscon\n");
+		dev_err(dev, "failed to get handle for tsc syscon\n");
 		ret = PTR_ERR(adc_priv->regmap);
 		return ret;
 	}
 
-	adc_priv->adc_clk = devm_clk_get(&pdev->dev, "tsc_clk");
+	adc_priv->adc_clk = devm_clk_get(dev, "tsc_clk");
 	if (IS_ERR(adc_priv->adc_clk)) {
-		dev_err(&pdev->dev,
+		dev_err(dev,
 			"failed getting clock tsc_clk\n");
 		ret = PTR_ERR(adc_priv->adc_clk);
 		return ret;
@@ -543,11 +544,11 @@ static int iproc_adc_probe(struct platform_device *pdev)
 	ret = regmap_clear_bits(adc_priv->regmap, IPROC_REGCTL2,
 				IPROC_ADC_AUXIN_SCAN_ENA);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to write IPROC_REGCTL2 %d\n", ret);
+		dev_err(dev, "failed to write IPROC_REGCTL2 %d\n", ret);
 		return ret;
 	}
 
-	ret = devm_request_threaded_irq(&pdev->dev, adc_priv->irqno,
+	ret = devm_request_threaded_irq(dev, adc_priv->irqno,
 				iproc_adc_interrupt_handler,
 				iproc_adc_interrupt_thread,
 				IRQF_SHARED, "iproc-adc", indio_dev);
@@ -556,14 +557,14 @@ static int iproc_adc_probe(struct platform_device *pdev)
 
 	ret = clk_prepare_enable(adc_priv->adc_clk);
 	if (ret) {
-		dev_err(&pdev->dev,
+		dev_err(dev,
 			"clk_prepare_enable failed %d\n", ret);
 		return ret;
 	}
 
 	ret = iproc_adc_enable(indio_dev);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to enable adc %d\n", ret);
+		dev_err(dev, "failed to enable adc %d\n", ret);
 		goto err_adc_enable;
 	}
 
@@ -575,7 +576,7 @@ static int iproc_adc_probe(struct platform_device *pdev)
 
 	ret = iio_device_register(indio_dev);
 	if (ret) {
-		dev_err(&pdev->dev, "iio_device_register failed:err %d\n", ret);
+		dev_err(dev, "iio_device_register failed:err %d\n", ret);
 		goto err_clk;
 	}
 
-- 
2.43.0

