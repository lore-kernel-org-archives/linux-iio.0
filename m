Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6983125B09D
	for <linux-iio@vger.kernel.org>; Thu,  6 Aug 2026 02:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785983998; cv=none; b=FkH3fK+smU8kzPop/DptqHZtSUrQI4AwTQhCstL/+xTH7B/lihVVa29KRvrIYsx5K06Z6IARWQVg+nngaU/ldBpMXYMBMCXpn3JbiAq25i/6CPHnuSaSh5vR/OKo21vSNAfc9S17x7LIcRfpji89J22+U8ZfgUKIMfgVcqYmurA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785983998; c=relaxed/simple;
	bh=M8tT0y/IrWzDMnOAxgfoVUtKKOFefTBOA3AwkfDqohc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Msbg7il0/ITaK7U+b5grJWOUrOzQpCjelXFhGYL/860kaYsJQFiCIKRtQOf+M7QpYvUYCkBvsz5UB2yrmWxreJFKWm3xZpbrs7DleMTACTNYhlSNEX8sab05SAFFIqIenBRPU8+3mHPm8PsfEr+CIp62ElM2DufSrrwcADZmHxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTbWHkFo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTbWHkFo"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ccf2360620so16971425ad.3
        for <linux-iio@vger.kernel.org>; Wed, 05 Aug 2026 19:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785983997; x=1786588797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j1R+uohEcau7J3FUtUcinA4r58oNSFhdAhr/+2ENdYk=;
        b=XTbWHkFoVJW/HaarYXOg2XaBgSgGg4hmNWkBc6xdP5JSr1D3eEC42lcshX0j+rCbgp
         syaxEpIFR6x+nxms3FKgOcpNvJ/QKv9K8pF6TvRJXkCmNWdb8R3bvrnEumBr8eaXQuBV
         bKH8AMIp+3c5oW9YGb3lywu1pxB2IfvFJT06OyJo31JTB/cm5PhkKJsnCrPmftKSHsDz
         T6CKnMpHa0eT6edEjMW2o3QpiMWb1ONo3GskFutZAkQKUZB8YyGOecjUmL5yq5SOWqBY
         l4dpGv/k0Z/tYyN9a4DCdQq6tMoXHAw/zDCMZ15EDy53f1UN5pKFAI426WRE0iuh4OBa
         amYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785983997; x=1786588797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j1R+uohEcau7J3FUtUcinA4r58oNSFhdAhr/+2ENdYk=;
        b=VYRyqfzWcDVFBpMsWh+YsemmkbEqtTaEZV6EF32E2g8ws6g/h9hl33+3WbZv++k/ko
         tosN9pIB4uD9YVovoqFpWJKxVoQnfeOLv3ZoGGRSYDJ6o1oF71/7V7rTIsA9iBT3cW31
         U/17M9GwxNZplzo/mOZBwINsvbJkx0Wrht15A34Ti6+c74J6/8/bxHoAQQFynIm+JFG7
         NCySY6VACAEm+lkZVQngXRU+9P8M7OuUyj52LYMv3O7dMXnE5squXDH5A2BqKRI+7p+v
         sJAGVqkzGyc0iigodkSH3t29DEEedO1s3TjUlzzhqpOQsBCNLZahPrebG9lkBvG+Ny2s
         HErw==
X-Forwarded-Encrypted: i=1; AHgh+Ro6CDr63Mv/0ZxTRz9pe/YIA98CKEB2lIGHKzEY12zfNpzKtKlhyxPux73L4DpWobE00DV0Gu52tv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWxSbQcrvhiwqmTP7vGnytPJeW4XCfvO8BsbNr3MwRfrVPZuHz
	xSuUqA4MiYA18vQx0re6Wb8ZtVFCjBxcVrdPpCf1pzZ7Lxilxe6PjCpp
X-Gm-Gg: AR+sD11Yb/cjyxNbtBLac4aPglexdG7kZivRZZ4rywbxB5YFI5LpYezC49mftji4Ihp
	NPyedBL5FnEl99S8NGB49ztshVM4hfVPxQNGtsI6XKv2Sw12w/M+bdd0enTV8JGGMwpVSwYpnpk
	i7naZjCS4C+ll56tTLjvjMfzVqluu312JvnLIL0SRTaNH3IzdZhdaRFEpjE1NXdRMyUhBVQpOFu
	60r9+Ggp1vrUH1JC0HSw1iwIrht0Vg3M+iQjbvhh05TU07emlIdiILhuWfTs0fWtSaDsUfClvT7
	Hhyr7Lo+Pv2C8o+IWki8keDT66IdjCY8L10kKUlp3BDZa7MvNcloV2wtupifkXgZvL+tMT99XPh
	uLYZ+pPF8h394wyIBwMOb/sMip3yGSEneZz6AhGpji26bkpIW7dztyBrbYVt/29xdTAdOESl+Yb
	EEsyjLH5aq325TZSw4zp+WwaMK6CagIjAcGD4dO8WcYKWymnZZWXldkiyfMb4=
X-Received: by 2002:a17:903:3888:b0:2ca:eea:eb5c with SMTP id d9443c01a7336-2d0ca98137amr124962515ad.18.1785983996637;
        Wed, 05 Aug 2026 19:39:56 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:3194:1e48:e141:80ab])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315867d4929sm22404383eec.30.2026.08.05.19.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 19:39:56 -0700 (PDT)
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
Subject: [PATCH v6 3/3] iio: adc: bcm_iproc_adc: Convert probe error handling to dev_err_probe()
Date: Thu,  6 Aug 2026 08:09:02 +0530
Message-ID: <20260806023902.8608-4-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806023902.8608-1-mdshahid03@gmail.com>
References: <20260806023902.8608-1-mdshahid03@gmail.com>
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
 drivers/iio/adc/bcm_iproc_adc.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index a07a590662c4..ab66b97d2f04 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -522,19 +522,14 @@ static int iproc_adc_probe(struct platform_device *pdev)
 
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
-		dev_err(&pdev->dev,
-			"failed getting clock tsc_clk\n");
-		ret = PTR_ERR(adc_priv->adc_clk);
-		return ret;
-	}
+	if (IS_ERR(adc_priv->adc_clk))
+		return dev_err_probe(dev, PTR_ERR(adc_priv->adc_clk),
+				     "failed getting clock tsc_clk\n");
 
 	adc_priv->irqno = platform_get_irq(pdev, 0);
 	if (adc_priv->irqno < 0)
@@ -542,10 +537,8 @@ static int iproc_adc_probe(struct platform_device *pdev)
 
 	ret = regmap_clear_bits(adc_priv->regmap, IPROC_REGCTL2,
 				IPROC_ADC_AUXIN_SCAN_ENA);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to write IPROC_REGCTL2 %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to write IPROC_REGCTL2\n");
 
 	ret = devm_request_threaded_irq(dev, adc_priv->irqno,
 				iproc_adc_interrupt_handler,
@@ -555,11 +548,8 @@ static int iproc_adc_probe(struct platform_device *pdev)
 		return ret;
 
 	ret = clk_prepare_enable(adc_priv->adc_clk);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"clk_prepare_enable failed %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable clock\n");
 
 	ret = iproc_adc_enable(indio_dev);
 	if (ret)
-- 
2.43.0

