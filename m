Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561CE314D05
	for <linux-iio@vger.kernel.org>; Sat,  1 Aug 2026 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785575441; cv=none; b=Yp5i8/guI6Rsm8W8terddVHtcnRHncTvXWIr2yVHSehukh2/szmlUoopG4xg5H1nuIV5GUbLqXO/omLq1KmzEOx6HzhA+QFMoYmB/AJ4ajrQDScjAR7H5yfXStgQgJZN0OwVpgaoC7QI3TKhAC6Zx5V1pnX+OaQvNTyvP01h1q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785575441; c=relaxed/simple;
	bh=mBvzCrJqfjVnlWATRpHn3lgMmeSiDO2rsv8lorvrc+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9xNlyMc9QMIo8904pmoAGmVUO5cMP1h4ERgQ6bsTHsd1qCBgt2OSEv8CQIlYuhxe9/Tlt25fFeiAV/19JsX1NJFpIjTF3u/N394F10hEeDkyqvxsuWqQRf7Pb6Co49jAcUPDynPzdBHIU24f9VKjH0Xm4HIoNg5NQzL2QdzVAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0IlD/dK; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0IlD/dK"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbe431467e6so242855a12.1
        for <linux-iio@vger.kernel.org>; Sat, 01 Aug 2026 02:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785575439; x=1786180239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4sMBazdEJYTe6pzd45qpWokzuIgSbldBJhe0jeEanG8=;
        b=P0IlD/dKxh2lhAKurckYAbamScw/wmAZLullJmvdvcb7MNwnjHkPKjzWtib1i/O1gI
         zZzp6egVFVuthBai63Yw86suRyd2oD//0LxZR1UHc9VBgvF5KAHgYVHw5mFjx7mt3RcU
         81XfOQkI03iSjCk4acXSEwIUlqjOQr/HsSllC55HWKZEWb6Wkmmi+C9HXPckcjsIyJQz
         T6zvqAxXhMwHLOaXBjcYB7MLYi1DugrkP6s3YGAHZfzP/rdnr0OLERfweC20F905nitT
         VB72sphDEKluD9zpyqYjvzNhHvmOqWFsfqfeaUBlRELH1XnWbmk9s8RAP0O1P6lxSQOg
         /O+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785575439; x=1786180239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4sMBazdEJYTe6pzd45qpWokzuIgSbldBJhe0jeEanG8=;
        b=YS3eUuphxkSyXzNhI80Eaape8ZhN1CTydG9F1KoQFTgHwdMLuv/eUt/G0fStli0PoO
         fKRYgQQu0LxcgaL3vMyF/rMSq49va1KHrX8LkoH5doBKJb6uvAhzbcCfRrEhNzjxuFhI
         LOVMija6aFSx0tLpharANqfTl1/FO0ywvQdZsJ7XSBfco27pcv3oeu2q0GmxxwmIHCUa
         08oirzU9KdpYIpB9DwVrsLtD3NwYZSRhxHjC2JixWUfQSUqR06HGgdc0/s9FaEr/51J8
         fviyO3+L1WGnJ8zIYhrexxhy8nnz5BwUZzOZl9or0+xbxmX1LzohgJhYw59heXyAT6IX
         WMOA==
X-Forwarded-Encrypted: i=1; AHgh+Rpk4VtKKq8cXksdsBU/7Q3zneT/cR7FFYp8e0n5nT11nL7RwmkGWGbQd7qPaUzZ+9aiHzBskdi+jtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBgX+favOeEo3O0A7e1BKdqh3woq2BO75rFA7EUsDBQ0DXyk6z
	C+4YJkj/XbsXzd2fNIbDkgf+ZyBSDFXo3OPAzeyA+GWDACM0crwfQRYr
X-Gm-Gg: AR+sD11WICELfWLP0l9QN7sZNVPEKvYVF4EcP3H084r0RNXNlIlsXxkarxn50ZSuNdQ
	gsQCGpDHXc6PZFZ9VtUejT2XiwLiZVk9CPLZ7vJmWr1SxOLADoic6kOzGx1cWBYzGlx375Pl/P6
	pmYYyHDusUOgFaJmRRirnF4iNPY+h+zQlhw4WEUi3nkRKdu6Fs4KgJRYw5+zftogBHrBzxj5buD
	haRS55s5AIpZLSR2vrSUPkaXNCBNYfzgeCjoqNUCCJ6036HtaND78T8Ony9vnHmwgAnKLruW8JV
	Yuo+T48Z3cp+YAsIDbice/7C8iHrMlDAaTNbTpYcmeYpOGjwExnaU8NXrEmeycf48RQDTyTkWwp
	VQ6u0wST5cTFOdbI7B6o+fb29tPpkXTL26gr6qRb0Ea7yS2k4xTk5xz4NpmY1/noHock7g7+O9o
	uWts+pwTAlu4qIm9mrSjrVkZ7eXocLIGkKlBDo0GR0QnIQdV4d6yq0L8sYZA==
X-Received: by 2002:a05:6a21:e598:b0:3c6:6f25:594 with SMTP id adf61e73a8af0-3c91aa0a4f5mr5101134637.38.1785575439377;
        Sat, 01 Aug 2026 02:10:39 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:36ae:7de2:5cca:938])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9c96asm15432431eec.7.2026.08.01.02.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:10:38 -0700 (PDT)
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
Subject: [PATCH v4 2/3] iio: adc: bcm_iproc_adc: Introduce local device pointer
Date: Sat,  1 Aug 2026 14:39:52 +0530
Message-ID: <20260801090953.61603-3-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801090953.61603-1-mdshahid03@gmail.com>
References: <20260801090953.61603-1-mdshahid03@gmail.com>
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
 drivers/iio/adc/bcm_iproc_adc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index 7c2e2770cd61..4acd9c3f089b 100644
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
@@ -556,7 +557,7 @@ static int iproc_adc_probe(struct platform_device *pdev)
 
 	ret = clk_prepare_enable(adc_priv->adc_clk);
 	if (ret) {
-		dev_err(&pdev->dev,
+		dev_err(dev,
 			"clk_prepare_enable failed %d\n", ret);
 		return ret;
 	}
@@ -573,7 +574,7 @@ static int iproc_adc_probe(struct platform_device *pdev)
 
 	ret = iio_device_register(indio_dev);
 	if (ret) {
-		dev_err(&pdev->dev, "iio_device_register failed:err %d\n", ret);
+		dev_err(dev, "iio_device_register failed:err %d\n", ret);
 		goto err_clk;
 	}
 
-- 
2.43.0

