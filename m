Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7F13CA4AA
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776160776; cv=none; b=pUOfIKORpdL00dAsVCrHrvdwhraw3P8fMJm8M/AaTzv5mOsBkuiYmEucjsyym7exlxp4OTQqShkYun7IIH6JvZEROjWE+1qym0CSyz6Ozl2kt5RQmQI3cwi6A3gE0lJJSOtcppCG2ad7bq+Otn8k8etuChl38H3QygWorydpXnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776160776; c=relaxed/simple;
	bh=w6yITj4g+J5jCyFidwGEIyaRk4v1QXuvhpQz4TQxNDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mRuNBlAK6OFbeQ/BkwUk45i9bSJsMfeSk+5Xioy2Vt45Tw9Hisj0ogS+0WJzYKD0OMJB8FxcJpUDyelFjuCwSncgtF8Qwf0chCD7TFYR1NVO0heancbZ17tHaCFrKAtbj8qwaB2qx9HB3JCHZWqJ6Iztr7d0fQCjUUkyEQ7voF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vy/4ZxDt; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vy/4ZxDt"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so51184365e9.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 02:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776160773; x=1776765573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TDjpdI9JCOPXXhqNdEllBIg0nb987Wi+gjesQzdTWuo=;
        b=Vy/4ZxDtborAf1W24uuKvRpEGGSZ4Pfwcjh3Pbb2cM/f/HJKhzAQeKnlK7UiPuin1h
         SXa0klCK1wzcGkwwuVYO007ShYTuT9uOm4CnQpN01nJV3s0QlYLG0pGcmZSKt77eHqNO
         mjx6sbMEVwtHk1wjtH47CfmpDShF1JVMkk9P6tgo+uhQusvLWxzUMsTmDOVWPyyYg8o7
         A/45e+savsNN7nGWaKVEhhBZ6JAkd8pUuFhDOyG8O4qyTkzC4eZ99Q8v8yqTdCW75EoN
         BKAr4jjoAUzc0Ht9BtFREaouwS8Y0+aYQvvnyqbeLDRsmXuo7sH/z2Y8/AXwsmKSoghK
         ykWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776160773; x=1776765573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDjpdI9JCOPXXhqNdEllBIg0nb987Wi+gjesQzdTWuo=;
        b=j0iJ91wp/ByxEjFglxx2zXBSve/ZzBM1IxeuloKL4LeeAIX7m3u6camlAu8TCbIdbx
         eMNlJvTHc95J3/n9KrIOHS/vBJ+rpWPyLQQF43erfHR8o9Sc8EyyvEHRhP8l6HK9nxmV
         c9XIIAl4ITZyyOBFATrUz63cS/kOfy6HTd/T05WQQX82HnAwpsSO7glTwApgzEIRbMxF
         v1m8ZuwFe5E7vQdCUiYZwA+79FOXUci2a8OjKPO5u2PnRiMFHv2kpS4wZYTWBj/pUOsk
         vSKLyFcLvh6UYGFhkVugSZyg8eZIdroQ9KCWU+e0QFinBy5v8f25zYBQDFZyeKFOv/ib
         9kUA==
X-Forwarded-Encrypted: i=1; AFNElJ/OnX/OPnnpdDsoHEJ6algTIF983Hp9vaKhVcUVUkSNzq7y1K8yqAXUyBRLcfUFWvUnpjZ8kzDp8Eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSkZZuFgeWqRYtMhTm2aPbiGJ5o6/xHFcBwZ57dSWcnhjdK6SK
	SZrLaLCAzBz9BrstpJCIKRsng7RfWabiniCt5vKXT11XIlg774hYAtXB
X-Gm-Gg: AeBDieuwwb/4P7ra+ntxHoIfyvr00LB74yRWbXUEdcA6Yndy4qAu9d7KTtFGkGH7MrM
	hYW5fzqw8xfej0io9pFAYfqmH+rkl+xDHNguTo+PQ2ty/k2UkBX65n07nSAlfdhwiGFJWoY1T1w
	4eeIzpvsjwtyhFcpY40XdQDU7dIud7hQ5sPcaRA08htg3p/2+XhhIbPh2JwjFPH4OdwrKsrmNYp
	9wIKYJCDJjU8sThPTK0BeSEHvb2XLcUkxI7VX8XKk2T/ck+J+o8bk7MBlOKx4TxZ0HLIahyQOyr
	gXN5b0sXfuQnoi99K1VuES/dlBQRuOLNhjgqOS3omwgCk4184g/+J2VvxwMt221oA7AI+gyQGOP
	8GcIc2vdId2uT+b5NyuEXtUEbNBLxjnQu5Eb12R+rGrgmI1JCUfz6Vo7MY5BS+CMqXdoFdn3+lo
	PN+75nzlzRGQA3saw4pB9OgklAWzuSlDW1DYGfjMMHlTYQ0eMa5YLqTeYMREpHBi398HHwvE+HM
	J1FdoifppQR
X-Received: by 2002:a05:600c:3b0e:b0:487:20ee:bef6 with SMTP id 5b1f17b1804b1-488d67e65fdmr230274195e9.11.1776160772762;
        Tue, 14 Apr 2026 02:59:32 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede249fasm37502455e9.7.2026.04.14.02.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 02:59:32 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Avi Fishman <avifishman70@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	openbmc@lists.ozlabs.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v2] iio: adc: npcm: fix unbalanced clk_disable_unprepare()
Date: Tue, 14 Apr 2026 10:59:29 +0100
Message-ID: <20260414095929.11257-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver acquired the ADC clock with devm_clk_get() and read its
rate, but never called clk_prepare_enable(). The probe error path and
npcm_adc_remove() both called clk_disable_unprepare() unconditionally,
causing the clk framework's enable/prepare counts to underflow on
probe failure or module unbind.

The issue went unnoticed because NPCM BMC firmware leaves the ADC
clock enabled at boot, so the driver happened to work in practice.

Switch to devm_clk_get_enabled() so the clock is properly enabled
during probe and automatically released by the device-managed
cleanup, and drop the now-redundant clk_disable_unprepare() from
both the probe error path and remove().

Fixes: 9bf85fbc9d8f ("iio: adc: add NPCM ADC driver")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
v2: drop redundant dev_err() on devm_request_irq() failure since the
    IRQ core already logs it, and remove the now-single-statement
    braces (Andy Shevchenko).

 drivers/iio/adc/npcm_adc.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
index ddabb9600d46..8afa20701756 100644
--- a/drivers/iio/adc/npcm_adc.c
+++ b/drivers/iio/adc/npcm_adc.c
@@ -231,7 +231,7 @@ static int npcm_adc_probe(struct platform_device *pdev)
 	if (IS_ERR(info->reset))
 		return PTR_ERR(info->reset);
 
-	info->adc_clk = devm_clk_get(&pdev->dev, NULL);
+	info->adc_clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(info->adc_clk)) {
 		dev_warn(&pdev->dev, "ADC clock failed: can't read clk\n");
 		return PTR_ERR(info->adc_clk);
@@ -244,17 +244,13 @@ static int npcm_adc_probe(struct platform_device *pdev)
 	info->adc_sample_hz = clk_get_rate(info->adc_clk) / ((div + 1) * 2);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		goto err_disable_clk;
-	}
+	if (irq < 0)
+		return irq;
 
 	ret = devm_request_irq(&pdev->dev, irq, npcm_adc_isr, 0,
 			       "NPCM_ADC", indio_dev);
-	if (ret < 0) {
-		dev_err(dev, "failed requesting interrupt\n");
-		goto err_disable_clk;
-	}
+	if (ret < 0)
+		return ret;
 
 	reg_con = ioread32(info->regs + NPCM_ADCCON);
 	info->vref = devm_regulator_get_optional(&pdev->dev, "vref");
@@ -262,7 +258,7 @@ static int npcm_adc_probe(struct platform_device *pdev)
 		ret = regulator_enable(info->vref);
 		if (ret) {
 			dev_err(&pdev->dev, "Can't enable ADC reference voltage\n");
-			goto err_disable_clk;
+			return ret;
 		}
 
 		iowrite32(reg_con & ~NPCM_ADCCON_REFSEL,
@@ -274,7 +270,7 @@ static int npcm_adc_probe(struct platform_device *pdev)
 		 */
 		if (PTR_ERR(info->vref) != -ENODEV) {
 			ret = PTR_ERR(info->vref);
-			goto err_disable_clk;
+			return ret;
 		}
 
 		/* Use internal reference */
@@ -314,8 +310,6 @@ static int npcm_adc_probe(struct platform_device *pdev)
 	iowrite32(reg_con & ~NPCM_ADCCON_ADC_EN, info->regs + NPCM_ADCCON);
 	if (!IS_ERR(info->vref))
 		regulator_disable(info->vref);
-err_disable_clk:
-	clk_disable_unprepare(info->adc_clk);
 
 	return ret;
 }
@@ -332,7 +326,6 @@ static void npcm_adc_remove(struct platform_device *pdev)
 	iowrite32(regtemp & ~NPCM_ADCCON_ADC_EN, info->regs + NPCM_ADCCON);
 	if (!IS_ERR(info->vref))
 		regulator_disable(info->vref);
-	clk_disable_unprepare(info->adc_clk);
 }
 
 static struct platform_driver npcm_adc_driver = {
-- 
2.53.0

