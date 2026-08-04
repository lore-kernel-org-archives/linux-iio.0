Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431D74963A2
	for <linux-iio@vger.kernel.org>; Tue,  4 Aug 2026 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863174; cv=none; b=faYyL9QXpjsS/6/EKkTBM2Z6vNXtJmONfORkNvTKnu3MfWIyjrxKR5NiK3/ClOa/mNQWiGMFgO6R7lUcapP8FrqcxaxVP//We1I9nuxpWDCqUndF26k5l6CE2JOVqArD7lYtsQanVXKIzY1Oib8mOvUCHBGv3exVHp/nin8EhI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863174; c=relaxed/simple;
	bh=dsaxg7vkdnu1jZjqwuR1twivrSIw2gVVPmu/aM5RmjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tt1GjcWGOlgRddLBb6NqAcAgrqGv7zjpuabQQkPbasGSI4vskDYAbG8UW0l+AXL+hCh7s/GsD7gUWICYCwMtk+oGkEmhK6Xw5OY1TXFZOqbo9nO7oSZFu42Twxh185ooAwosf3ff4EIcm3McqDnrdzPK6iAL5JA3nQY2XHGxgsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuFPnblN; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuFPnblN"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca88130e09aso3548992a12.3
        for <linux-iio@vger.kernel.org>; Tue, 04 Aug 2026 10:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785863170; x=1786467970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aqQolFyy9CteLDWszj4sftvNtB4+0GIquieHeua55fE=;
        b=HuFPnblNLrEu+fezIr2MZhjwDkMHX7S1NeQ82Peft5mHuhdodkL9MX0S8ds4Gs3547
         NgdqjJI4XFg07VbCvBLCHEFdj+2thuLnZ61HQwoGgBsUVGIs1VY0+RvorcL8RjKFPjms
         grSlgu8qgQ1tmrKKe263bniObCpSAIKyW36ILZZBKTdRrLhE+gm2TcUF1v7xAyIqyFxW
         YFoeMix7kWvcujJVV6kEw+1IApRjXOeXOXxPplb+j1N3XwrK2Y/Hri2FFQeXTRW0p9wP
         RM3hIpj+n9RAL6CxElhtOUwpEB/Q1ioSpS7RGp0OcyqI/E1GqvoLM/burlMSqMUPYzwE
         +FBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785863170; x=1786467970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aqQolFyy9CteLDWszj4sftvNtB4+0GIquieHeua55fE=;
        b=V6H2wzu8aLpWalr+Eg+6OTD0xwiqxQlJKu/fxZwkdORO/PqOo+k3qxPDGtsDGbyD1o
         AN9fVND1vEJ05vcDEcDCFWflLBi63WzCs0rBUqFzbOLBDFo8QxMCG5dq/GInjLe7rEU4
         0QOJEukjnyjNEAh3VF0NKs8+Om/1l4hCr1a21ZhksaFC0FyXtb47DX9VqNYtnLcy8oYV
         TgnDCovrsDZ5FVlxFx9Lc5r/TXE+pli/fnMHRE65rvSEX/2m9xY0uEXPCzI3BGmvey7l
         k64rVFUHT44v7tt6DDvOHjaR3TuhUepglKMXZ2zdnzsYW0IftvOWf9SotXYtA/Xpg09o
         Ad6g==
X-Forwarded-Encrypted: i=1; AHgh+RriLUQKkAZasx3wRHuvPepJ3UbcVgvnDDFPOPHeE4GW1f3WYm7UzFg+uzfcHHI2+GlSvU04SVCkhE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc/+GUNYXwnd1ofg8ltTjhcA0MLqEVU7UJ/an7sIWUx/ryq7AH
	8hMsL8YqXQxb5JUB3goLjsdJukuroUL1jj7gcY9aW7xHyV/TZdNsy358
X-Gm-Gg: AR+sD10XqH9zFM9kevUDVBOjmOh+HyMU9iOR2sneAeUtjIpu5s5/jnMGSe4emrL/ccB
	cEYrpFqL/oPUVLYNdeqm2SHb2QudGG/l/OWlvahXh2D3GovPb4t5gY1YnXkWAq2TO1MttzVY8jB
	zF49XcXvzeiG0/Fx1tXANgiex4M5Y1T9WZRwMbQuRaGMOhRtTFZL0jKGM5S8znqh73fA/d+LZJi
	K1Rj7tYFo5KFe2zQWTMmjVep2+ZCuNujgfL/MDMErOg+W8Q2oQvy2jU5kgC2V4E++bSkZ91Z4rc
	oy+5seXvjEKWvtgERDkbzH4XO2O9uoaWITgt1Fcn3CVqIUTlAKi3jcgnHrKMW3CbA+4yBfbeTPk
	MYbd29pHaa4EUs0RJt9weUYU6Z+udgegU43Q2K7mm8Or4oaGbOlE/V4rs9mYABXyZjISlNKQ2lL
	E4RcuNUz2waZdXg8TYO8X2da3JMLNjdtfyiKgG6m29Sl6FFxsZh/Zd4kewa5QapFinoyaOLw==
X-Received: by 2002:a17:902:cecd:b0:2ca:53e9:1277 with SMTP id d9443c01a7336-2d0ca712f17mr2879415ad.1.1785863169414;
        Tue, 04 Aug 2026 10:06:09 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:1461:a94d:d559:948d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31586162e80sm7230582eec.0.2026.08.04.10.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 10:06:08 -0700 (PDT)
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
Subject: [PATCH v5 2/3] iio: adc: bcm_iproc_adc: Introduce local device pointer
Date: Tue,  4 Aug 2026 22:35:20 +0530
Message-ID: <20260804170521.196393-3-mdshahid03@gmail.com>
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

Introduce a local 'struct device *dev' variable in iproc_adc_probe()
and use it for device-managed helper calls instead of repeatedly
referencing '&pdev->dev'.

No functional change intended.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 drivers/iio/adc/bcm_iproc_adc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index 7c2e2770cd61..312be7c12e58 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -506,10 +506,10 @@ static int iproc_adc_probe(struct platform_device *pdev)
 {
 	struct iproc_adc_priv *adc_priv;
 	struct iio_dev *indio_dev = NULL;
+	struct device *dev = &pdev->dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev,
-					sizeof(*adc_priv));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc_priv));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -528,10 +528,9 @@ static int iproc_adc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	adc_priv->adc_clk = devm_clk_get(&pdev->dev, "tsc_clk");
+	adc_priv->adc_clk = devm_clk_get(dev, "tsc_clk");
 	if (IS_ERR(adc_priv->adc_clk)) {
-		dev_err(&pdev->dev,
-			"failed getting clock tsc_clk\n");
+		dev_err(&pdev->dev, "failed getting clock tsc_clk\n");
 		ret = PTR_ERR(adc_priv->adc_clk);
 		return ret;
 	}
@@ -547,7 +546,7 @@ static int iproc_adc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_request_threaded_irq(&pdev->dev, adc_priv->irqno,
+	ret = devm_request_threaded_irq(dev, adc_priv->irqno,
 				iproc_adc_interrupt_handler,
 				iproc_adc_interrupt_thread,
 				IRQF_SHARED, "iproc-adc", indio_dev);
-- 
2.43.0

