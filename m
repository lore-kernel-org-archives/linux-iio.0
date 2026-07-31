Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ED44582ED
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785522286; cv=none; b=WSRQHKzIIqpsC/C/E5q1rsB4NpYK8cTrYa2hPi8kLN8mhw2PkrouOJ3A9y71h5wJbhykfVs+9bcA0SokVUtoNvMx0CZvIewznEqCAhL+wOFKPzGVTw61ZZSM2VNX3cc04/jEARtXyL4Ui866OpRsfalOnt5yx27y6YBifjNEdSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785522286; c=relaxed/simple;
	bh=VD2QHojgachEtitvCMQ22pgLNRLQvtYqV1cce6F2O+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTpWM61m1ZPJ5w4OUKRkms/QkUrnPSIJCSm1OflQOGK88bS1kLy4rVDRBXGbxbW/yaWG3NCSYyiQ/iarItDt0cNjxRxP9cf9y8Wa0Oc6PU+hHAKSzeV0rp6JlL/T/Pdtc1wEmoaAMtJicO8T2fTkPhDrxLj+rTmL2kMQEQ58wq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lko9YkiT; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lko9YkiT"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e58034d05so1429159a91.2
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 11:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785522282; x=1786127082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S96pVSc6qSK7JNjBnWVrJfF1KAwOzUVlXD18tkrIn6w=;
        b=lko9YkiTAslGn6X5mbMSTAL7xnSHkPC7oG6e5OEZQ9Gk2nBce5wfjEJIx5aPsQwaCU
         Rjy9frMFar0Q4xU26XtTcLzHh6p1jzD1hBrQdqBOknFrbxO2Jdsk0kfop/Yeew8ZzGeK
         9N15s/VHiMXOwQWg2DAcDcxXFwB5LtD92rpCcFVSzHIua4t6P7mkYUN0P9wzN3r1mWgD
         cWY/8BbEdXTla8DX2vSbP8g9hrLLYid890zNT+fn+/NA3iUy/tU7Xyu+Ms0RnA0AzSAK
         0q8IkTDFzbxY21TVH9DVjoBp6Mm8Lg0zTfRL2Ecrf7VemiS4WfZV61HI6FvBtKniADes
         lqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785522282; x=1786127082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S96pVSc6qSK7JNjBnWVrJfF1KAwOzUVlXD18tkrIn6w=;
        b=VHpwgS7nGYwiVlX572K0LJAb3t4cjs9QUWeP9W/GFYUpWy25KilzJU+MdbbFiudBoL
         uUxnVtxXnACuOQHn35LD4o+uIHIV/6I+jawheb4bIKd3BFc1nfkWfbMjOIyxq31umuNq
         iCGp/u8rrpHqj2OApi6cR7RXzPLkn61kH3wgSatNNle4O6bmYyljhHebs+n3UXqT/Vdq
         qLJ80VDn1YKyS+Lxpp52UmL7uMLsN5iyZ0w8rocN0Te5BapeR1Pbis/0cUkv1j7jAO8w
         J7hxJRqfs3j+hSk0FygJ5dMwmJD9fFnbfyquvWqgoQ3gniXeM4c1/KDKvBvOsm0PS05/
         yKRw==
X-Forwarded-Encrypted: i=1; AHgh+Rp03XlLo+gux+Y8BiunZOZ9cSF8To49utwWbktSKeYv10d/5+w75+ZG5526PtnCuSNQv5dAe3MxkjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ezEwVkoDxugNwKTNVDdfRcIuAmqT/W4WXvV0meTV0D6MROX9
	OMFWi1xfwEvOa9yUsBtEgn35qLbdNQKa8nya3kSuP77nahcTevL+hekj
X-Gm-Gg: AR+sD10sRyDDDyUWnz+MxWVivv1ATt8JoL96jgGGq6v72bPuKtKvJa+kCzZCqNRDEv7
	2x3rzMzbH09XPqgJ83IW2myi9ZTMQJI0ms2OMTCXf5bRTf5tk9zGxqbkddvcKsBLEukAWez+Zi9
	fJNeZQrhDo6FfxnuC37Aq/ZClXdQJ78cv+TYWn2CwR+6DvS4Pkyo6jFg386bVG45Vqpb1nKsHeQ
	DZ3T+lj+sJMxozFOCq1RM5LNdXw9ffVG2L8lwGx1K066MIAt/3LuE8i0kEBim7yU7hAFrcJVoV0
	19pYeZNfHyA8Q895KrH2dzsvBAXzxNmHo4mF6L2O1KK9TD2ouMkUJYQ9ysry5cwcYPTs5SMIyhP
	bObHyCGx3uvr+dxw+yJbIiOKgHVO6wxdlZKSw35HMf42tuooDhQxyL622y4ypVSpSan3h6+Yk8P
	RQ+WlCV8vL/ARheZnhFvVlgrgjuL5mIXpA4EFrF8m1USxMhUIImQR3S+/kiV8=
X-Received: by 2002:a17:903:3886:b0:2ca:feb:303b with SMTP id d9443c01a7336-2d052429193mr8562495ad.25.1785522282316;
        Fri, 31 Jul 2026 11:24:42 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:d69c:7f00:28b4:311c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9c1casm8400785eec.10.2026.07.31.11.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 11:24:41 -0700 (PDT)
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
Subject: [PATCH v3 3/3] iio: adc: bcm_iproc_adc: Convert probe error handling to dev_err_probe()
Date: Fri, 31 Jul 2026 23:53:47 +0530
Message-ID: <20260731182347.42888-4-mdshahid03@gmail.com>
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

This simplifies the probe error handling by replacing open-coded
dev_err() and return sequences. Also remove the redundant
dev_err() after iproc_adc_enable(), as the helper already reports
the failure.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 drivers/iio/adc/bcm_iproc_adc.c | 43 +++++++++++++++------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index 29ea35972a23..5fcd528eb88a 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -523,19 +523,16 @@ static int iproc_adc_probe(struct platform_device *pdev)
 
 	adc_priv->regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
 			   "adc-syscon");
-	if (IS_ERR(adc_priv->regmap)) {
-		dev_err(dev, "failed to get handle for tsc syscon\n");
-		ret = PTR_ERR(adc_priv->regmap);
-		return ret;
-	}
+	if (IS_ERR(adc_priv->regmap))
+		return dev_err_probe(dev,
+				     PTR_ERR(adc_priv->regmap),
+				     "failed to get handle for tsc syscon\n");
 
 	adc_priv->adc_clk = devm_clk_get(dev, "tsc_clk");
-	if (IS_ERR(adc_priv->adc_clk)) {
-		dev_err(dev,
-			"failed getting clock tsc_clk\n");
-		ret = PTR_ERR(adc_priv->adc_clk);
-		return ret;
-	}
+	if (IS_ERR(adc_priv->adc_clk))
+		return dev_err_probe(dev,
+				     PTR_ERR(adc_priv->adc_clk),
+				     "failed getting clock tsc_clk\n");
 
 	adc_priv->irqno = platform_get_irq(pdev, 0);
 	if (adc_priv->irqno < 0)
@@ -543,10 +540,10 @@ static int iproc_adc_probe(struct platform_device *pdev)
 
 	ret = regmap_clear_bits(adc_priv->regmap, IPROC_REGCTL2,
 				IPROC_ADC_AUXIN_SCAN_ENA);
-	if (ret) {
-		dev_err(dev, "failed to write IPROC_REGCTL2 %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev,
+				     ret,
+				     "failed to write IPROC_REGCTL2\n");
 
 	ret = devm_request_threaded_irq(dev, adc_priv->irqno,
 				iproc_adc_interrupt_handler,
@@ -556,17 +553,14 @@ static int iproc_adc_probe(struct platform_device *pdev)
 		return ret;
 
 	ret = clk_prepare_enable(adc_priv->adc_clk);
-	if (ret) {
-		dev_err(dev,
-			"clk_prepare_enable failed %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev,
+				     ret,
+				     "failed to enable clock\n");
 
 	ret = iproc_adc_enable(indio_dev);
-	if (ret) {
-		dev_err(dev, "failed to enable adc %d\n", ret);
+	if (ret)
 		goto err_adc_enable;
-	}
 
 	indio_dev->name = "iproc-static-adc";
 	indio_dev->info = &iproc_adc_iio_info;
@@ -576,7 +570,8 @@ static int iproc_adc_probe(struct platform_device *pdev)
 
 	ret = iio_device_register(indio_dev);
 	if (ret) {
-		dev_err(dev, "iio_device_register failed:err %d\n", ret);
+		dev_err_probe(dev, ret,
+			      "failed to register IIO device\n");
 		goto err_clk;
 	}
 
-- 
2.43.0

