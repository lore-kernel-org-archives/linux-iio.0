Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1FB2F3632
	for <linux-iio@vger.kernel.org>; Sat,  1 Aug 2026 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785575450; cv=none; b=jsqcKfw4wwwJPdVSgiApfeyT+6PdOGAmi6Q/beKASA7S7VPs0HKs8+5AHAaruGPYwveXqEDZ1DBSo5r7IF1oXBBhNinDvoALqrPKQIjrU3f1pm9WU+bHoG5UqaI36tNDSbCkT8u+AmGKSa/cY34yKBuetdQayGod3lDMcP8liec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785575450; c=relaxed/simple;
	bh=OvQKuoneFsh/WxICPt1MaBIMs0/iiqu65A4ormy8KeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4y/Erk/Ou3LgnUumwkvY/Uyuf0BIUZ7WYnJjSydR1pSr6Km8v0zICMPx1S5S2rh0NffEVvENf9zn/ZZWqJflVqgT1oYuPzx7lVtMK3Xet9gDdoYBJmORzijWdXY+57jkWLR0lmlcsyQp9U+LYtFMTeMz9H+KV0z/FNEwEuhEEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdDgUjKk; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdDgUjKk"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cb5a6aa8760so955274a12.1
        for <linux-iio@vger.kernel.org>; Sat, 01 Aug 2026 02:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785575449; x=1786180249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PgxBTc/eAxhpXNXIIpPZ/eJLF5hZIUUNMPVKiLuD+Wo=;
        b=WdDgUjKkyv4zqYfB0A8uO4zTfw9lz3K6v2WFTHUscNEFZkRnYjRCVP6WVQYywIXmgl
         +Fyi1ZNDWGI6fI4AT2LHW8RtxvAniT1EbfBdoTv2rGvGW8GX1R22iZp7FcpYGoa/jG2A
         7iwcnDWCURh1gnhEFj/dzu3z2GjEE50moPTmljZJ8eV2L9aEnqwmGSbBdMPAneVx1iwB
         g2xTjWTy4IS6B/PvUQ8qUi9SY6YYFXHUtXe0J62EHksQxR7UEyPFUzUFydL/Y9h+0EHk
         m2wDzxjAmEHpFnTgROch0+LHocX7FIiWwq/qsT5Xx26L22uE4ya4qR42jGPUelTbFLAE
         C0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785575449; x=1786180249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PgxBTc/eAxhpXNXIIpPZ/eJLF5hZIUUNMPVKiLuD+Wo=;
        b=J1i5JfiJrXG96u1gPd5iJKdY5UMOw6W6VPJFMbBZDgLvT0GHVYUk1aTHCe0fEQcikB
         pbhe+IsSadOyLE0aGDXs9HUjmVOFNVnxBsd3rfukt1wifF6XpPa2bix44fwwNUM8waby
         cAxLisJGU+46SdgTYP60tNjIVuSAGL9eaP2iZ6Dvc0p+IiAIUpGgIpsdoxW4urbGKHif
         4OYk5FaWAvqH4Wdr/7P+LDX2HbZxN5svSxpRXQJvgxoCNQwypgsrpcWLzHUXBuQe3O3Q
         tSarZC+QlOFdXVuKyhZOCCP1B51chRYcsBX/8t7j7PRpNj6MvF0h5+epPTDyot2aXbQf
         D2Dg==
X-Forwarded-Encrypted: i=1; AHgh+Rp6DfEGVEJ3O/nNxWDOsMX4wtKZAtCoxXD1nB1M808I4ysZK7Ysl5XXZ0g+WroiWWDLWqNMaMqSC58=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyC7YQ9I0INn9WFJOhtWAshHbad+7j3F+xFxfwjsNSr1iBc5I4
	WNJ4wF3Lh2x/yfFG2KFmr10X+Q7bZFyK4178+0Lt2nFK8ks7yKZ0CskJ
X-Gm-Gg: AR+sD10BHcLMiPlaU0K73LJiSp4EkcKRxo0bMEMY1ZMa8ZIE1oj2FNVrUl59V9GCvrq
	AXeZF1zSSXAAVn5D3pSHgE4IaIMooVdjv4l1vcW7XrU5EMAy9ebV4vLoSWbD4/tvRSwOuBG2Osm
	C5wopWHhInuIEYEV8kZh+CmmItzPEdVCibLMHFY0ySx8AVYrKIOv2d8MARBiAN6y9oyqbDGP6AK
	YgphzJq29XaRgBGXhksBZbTF+eHl0k0V/XaYQAcmwu+C0NNNbxkhETDBoSLngt1B9s7XQiYwP4l
	QB4I6KRye/8PYjEKiu8MargLUynX0dgJdh2+v14hP4vRF81VRlb0A2LQ+0bxU0WIIbTl300b6z1
	ci+H/mdNfQf+H4BIiNGUjjjCx0aKj7m6kCzr8hfl8xQ+kN9SZ1SNIz24kdH4gL7FM6K1SEk5EFP
	CKUQ1mUwXOCrDJ5TjI3oZcXTfTLHZVSn/tR81kxpEWyfh30nX7vKnlL5a3Sg==
X-Received: by 2002:a05:6a21:2212:b0:3bf:9b61:f7ae with SMTP id adf61e73a8af0-3c92a75b245mr2888824637.14.1785575448667;
        Sat, 01 Aug 2026 02:10:48 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:36ae:7de2:5cca:938])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9c96asm15432431eec.7.2026.08.01.02.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:10:48 -0700 (PDT)
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
Subject: [PATCH v4 3/3] iio: adc: bcm_iproc_adc: Convert probe error handling to dev_err_probe()
Date: Sat,  1 Aug 2026 14:39:53 +0530
Message-ID: <20260801090953.61603-4-mdshahid03@gmail.com>
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

This simplifies the probe error handling by replacing open-coded
dev_err() and return sequences while preserving the existing
messages.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 drivers/iio/adc/bcm_iproc_adc.c | 39 +++++++++++++++------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index 4acd9c3f089b..5fcd528eb88a 100644
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
@@ -556,11 +553,10 @@ static int iproc_adc_probe(struct platform_device *pdev)
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
 	if (ret)
@@ -574,7 +570,8 @@ static int iproc_adc_probe(struct platform_device *pdev)
 
 	ret = iio_device_register(indio_dev);
 	if (ret) {
-		dev_err(dev, "iio_device_register failed:err %d\n", ret);
+		dev_err_probe(dev, ret,
+			      "failed to register IIO device\n");
 		goto err_clk;
 	}
 
-- 
2.43.0

