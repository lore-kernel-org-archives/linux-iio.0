Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEDF3D6698
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 12:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776169813; cv=none; b=LifKgHTnp7hz5YJgsh+QQJsZbk7U5+32lDLTrOLyvgVgzKZSSmEf/fOqP6oKXcyBKHOsRtaRec0Fe5NFEJb5BHs7PtneVwwiIx7ZAjWMkKHRHVnfA5oF8j0bVjTG2lvaTF4yd77YeQzIjlKNPk8gs+OaLoY80Sv6ym6J5sScVqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776169813; c=relaxed/simple;
	bh=9sTV1Z9z8WDg4IMrXvQiXfpITvPwawHzhSeoN2l5Z58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e0C9t3yDI1jckzeAEyLsCax/avCytNMxb4iDaVwz+NLo1vdm72I+U8ekGX3yChWfKdlYBLKY9+pJ2C5+qKWzo9130/Sx8e4lAb/idOIX89edpceoOHy0EY9PlT864fzhUrbVGyVqCK0JRJjSoNIE2o08nHe/Dd71K5VFLXQW/0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifHodL94; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifHodL94"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so38507065e9.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 05:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776169811; x=1776774611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WW4kcmfHDRNiC/0ztPa+kXKA3hUAYvX9T4RsXBiI8d8=;
        b=ifHodL94i2HgJj3sVE1p3w0eICYev48dcEETIdAV5F2OI8TUa9qD8EBAyQwWQBFok2
         dFrzB+BXKFWmIgasqbGvA8uEQQTHmE3/O/n0OvM22E8V78Lit7bLl+VU8iRBc3YvFNqJ
         7/vsq5lf3+WIFuB4S/UNaznEBm7uFVK1gx4AFS8qIXa2jZ4+aq32d9kGwIvFeTMwuA5C
         yMWnTLcdy4asWSqzXoI9U7pv1wKJjupfmv9IrawCoZCfwJm4jmYVwywuHnfzcrKPKDU5
         nwVej78fLc9B7YYJTRU4rhZ3iAoOfVLzTZuCXiT1OmXiLDO2D2CFtCAymw0J7MYNH4pR
         Qw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776169811; x=1776774611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WW4kcmfHDRNiC/0ztPa+kXKA3hUAYvX9T4RsXBiI8d8=;
        b=TnKzEmAoEsJnRcMe1C819Ayhjl1nDTzjnA3r0vfFbH164nBmmdxpjXYbDTncWBnqg5
         yacFfPicXTAakLxBAqOnClwqtH0ptMjZJ98//8Jwt0vn+HDNe81qeRxT63Gs3Mn5g8xJ
         GmlaZcgxiarCIfby1detVopC+ON06UQGWS0eP9wIQFqaj2rzliKmhoUppZNBVWqyvPHr
         KfEkvQ+j6csLKaOCybU6CjEom51Tg82W1Dn7p+2EuuYjSRyPZFI9mMSJ6In52MpoxBBt
         lIPWMVAEN8HPC6U0w9YfVNkhxCXe8iiyi/0l64MTiVwPl7CPmBrcgtA7Bly9dU25OQGi
         RxSQ==
X-Forwarded-Encrypted: i=1; AFNElJ83uUjuCudMnqfobkX+rr4VcLZyy8JrH3N/L9+rdPN31kzQEPvJ77REInWIhsnM7ihJPiLMQssayBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw1FqPAXGVhjcYWRDwKNvfsLgb9GZjb8xnSxeY3me+xMxyDIis
	F8L+RaS0sZ1iOscO2eijVFmOb2+GWszM2imqli9BiEPk8Xtx7B6Iiac6qCzMvo+wUAg=
X-Gm-Gg: AeBDieuAjY5GOpHWx/EaNnQ7KWq2qu0QYE2Mc4LgOkc6o0ORwjqMhPHpv3InuC2TWz7
	YzanNp7dcWXWjf4fiKzRlXKOX7kX2tcZz73lXGU3ISm82RUeMkrek7Hw6g52hm+eCpO1TGK15bw
	NQ0W+1LQqV7gQzsr3jutQ2UuG3hpbyy8P5BTcs4+MZxTBnQBsRDDZmD0CWuefzljIFPEDvhaX3z
	pOAnFcKs9DuK4oFd8pFsxqWLVNcmKz6IHfarJVZazyzKqotzz2zMiKhdO3NV0GwNHCJQnSXZfub
	1h0ovUz9vaLd4wS9UhFR2s9RIuFhmniMYqx/r9m+ZLRs7J36NH+6AEo14DG1nSTBQqGxpIDJAFa
	4ln4f9mCdV+bmNRpDr+Wmsh47CAi9x8iXVc8W/ec6YTvf40899JC0K++ErwiShhuKES+mtUNoB4
	mciuPO3AvLToWn3UjWNkQtoz21/Mpy8FxPz6f0Ft8lGGFqXlsvAUPgCjfiP7rYnszBGF5/6NxYn
	0wslNMsOIk8
X-Received: by 2002:a05:600c:5249:b0:488:c40b:c8bf with SMTP id 5b1f17b1804b1-488d680577dmr229609355e9.2.1776169810158;
        Tue, 14 Apr 2026 05:30:10 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d681edc7sm118080145e9.17.2026.04.14.05.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:30:09 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: jic23@kernel.org
Cc: tmaimon77@gmail.com,
	avifishman70@gmail.com,
	tali.perry1@gmail.com,
	andrew@codeconstruct.com.au,
	venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	andriy.shevchenko@intel.com,
	openbmc@lists.ozlabs.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v3] iio: adc: npcm: fix unbalanced clk_disable_unprepare()
Date: Tue, 14 Apr 2026 13:30:06 +0100
Message-ID: <20260414123006.262152-1-devnexen@gmail.com>
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

While at it, drop the duplicate error message on devm_request_irq()
failure since the IRQ core already logs it.

Fixes: 9bf85fbc9d8f ("iio: adc: add NPCM ADC driver")
Signed-off-by: David Carlier <devnexen@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
v3: mention the dev_err drop in the commit log and collapse the
    single-statement -ENODEV branch (Andy Shevchenko).
v2: drop redundant dev_err() on devm_request_irq() failure since the
    IRQ core already logs it, and remove the now-single-statement
    braces (Andy Shevchenko).

 drivers/iio/adc/npcm_adc.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
index ddabb9600d46..61c8b825bda1 100644
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
@@ -272,10 +268,8 @@ static int npcm_adc_probe(struct platform_device *pdev)
 		 * Any error which is not ENODEV indicates the regulator
 		 * has been specified and so is a failure case.
 		 */
-		if (PTR_ERR(info->vref) != -ENODEV) {
-			ret = PTR_ERR(info->vref);
-			goto err_disable_clk;
-		}
+		if (PTR_ERR(info->vref) != -ENODEV)
+			return PTR_ERR(info->vref);
 
 		/* Use internal reference */
 		iowrite32(reg_con | NPCM_ADCCON_REFSEL,
@@ -314,8 +308,6 @@ static int npcm_adc_probe(struct platform_device *pdev)
 	iowrite32(reg_con & ~NPCM_ADCCON_ADC_EN, info->regs + NPCM_ADCCON);
 	if (!IS_ERR(info->vref))
 		regulator_disable(info->vref);
-err_disable_clk:
-	clk_disable_unprepare(info->adc_clk);
 
 	return ret;
 }
@@ -332,7 +324,6 @@ static void npcm_adc_remove(struct platform_device *pdev)
 	iowrite32(regtemp & ~NPCM_ADCCON_ADC_EN, info->regs + NPCM_ADCCON);
 	if (!IS_ERR(info->vref))
 		regulator_disable(info->vref);
-	clk_disable_unprepare(info->adc_clk);
 }
 
 static struct platform_driver npcm_adc_driver = {
-- 
2.53.0

