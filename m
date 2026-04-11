Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC1C19D065
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775910924; cv=none; b=RvQRerzbvlBcvSCb7Is7n7MDOTPEnV6c8xLYEO+qA14cmxfzpE6wLkAMHLk0whOAP+07J/sk+rPVQ3mJ/vpY3meXNt8ymLDWoJ2NKiReZxcO0NTyPIf2yChRKOOZaZyqlMbV0icSiKIfjh5CNkB41/XlIzzRouMpmuwrroYyS+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775910924; c=relaxed/simple;
	bh=mjPeDXhKfleOqWQe5ymw3i8wHdAtO3jnVFCC15yVock=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qMmlZ5bv4TN56pnzlPGOUr2VdaKswVHZidzBZOdN7i4v3Ed3D+l+QgnhRSiXAC/fpf0poNREdAmc7B3y3uW3nVl79luK+7wTkLXtG76vdxpQaagvWoL8BGqo3HRZb9UKGkxtBxRiJu1Gjf+37Pda0fPzNL174V+j0Tq806ca8To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKtkvoqD; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKtkvoqD"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43b949bf4easo1764644f8f.0
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 05:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775910921; x=1776515721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JGoFfy0QWc8BwYX8irlGqExRr/Ktk1fkaAh03XIjtf4=;
        b=RKtkvoqDGzgSlUGMHdcgZr5A9I+AFP68QkxYw+ftn2E0soWrYZXeIcJXfkix/f61Xq
         Zd+Xhv3Q1zFW8airfWMTc7tQuBQXeZv82LvU02wG+iM3AdX0XlHvMbQ4uiGBqFo+YNe/
         8aBuKwrNSVqE5Umy0XHFEU+W0WypEDthCr7+NQyyb10BvmpUcgQP9uIrkLcOZPan7tFg
         UZWB7rcXEqSXuG4JNJto9GyNyBU4EbrHs+9/WXt44hf0ocB9lUE6Q1qPYbWaJPuIQVpv
         RK8QgYhN+RzuKszoq0baJGBDV17yvx9QjD4qNhk92YIiyphAzrNjDVXZMUqNivIvEQIc
         9eIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775910921; x=1776515721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGoFfy0QWc8BwYX8irlGqExRr/Ktk1fkaAh03XIjtf4=;
        b=OND7sfPsHn1nVG83kIQzZ/9SM86ajY/36Z7MmRnGJMCADn0QzPZ9l6gL/S+SAnLk2U
         JoaZvsLWVRYCN2iiQ3tZFNllt899ikiJ16BOcKoMhxCfVamtPAo38HXv/qGlhIhq4YTt
         peCi7sQljqkS0WP7S8T4D6hP8o4NOHn3lPcmK8eLLrZMVmzerelOIpkDhGFB8PqCRss9
         mdPMuS0roCCYikyUO0jwDQWClFaMEUTZK8yQsRcIbNK2/iZcwTJs90rVy1h9LJYE2tmk
         DDlzNN7WiO1VwZwZ5wxgKk8CQmyu+cbumWo7Dg4E8qeEmtrM1N4vXAJddmWiM40Ux24a
         bzrg==
X-Forwarded-Encrypted: i=1; AJvYcCUa01S66iI/+H4HYDANK6mjZNJgWVgafDp+sSSKvadOBfpVfFrLndcgACL8sjnXnv67a7SjURiux30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl0AYB89pqM8wnq1wNnnzPXtVJ4pV/U/EAeIAJa6ZzN/3xfkH+
	UEgqN9AKS2IqXDxyzgDU22aiLyuigxLPNESlFtqG9aVWOyx/CPb42+4CXdMzEcNOxIF5IW+W
X-Gm-Gg: AeBDies1o6B+kQGJIhUF6z1rRYo7qZw32e3j7EJMlQcV5S4hMVQGfyctUFgRV2Ak1U2
	tSk1IOwFeeoeUiX4uxLmbvVlnwfr6/UibzqxLBvAJm/eUBGt6q+dKr4N5iSA4ELal6Z3Jcb7CZY
	4NvjqvVp1fiJnxSo3LqJhdZk1PLBDjb9ppRyPwaMwl8GfDXFNi2LTJVWUAH7jTBaOyaLwk8s37k
	o2yyZgg1YeeFgjIc6w6hXhwbBaN9OApX8fqIxV3VbuxL3QOzKRv4CcStfiA3V8VJeQiSXWPxfnZ
	I8WgUd6uGXrZiXJ0Fd0eWgywzUY2t1zNQviWkXVvb6UgxJ1zJjZh2mXwinsPoHYKCsqkQdY1cjb
	P9qnp2zzW5k0rhgWyQYuvPnOe07k6u8gkZLCJsO+QkqNHkx7+CNnXAhdw7w3kkGd9ph1jm/aNL1
	CWzMmedlVaf47RWzsJsNzHWGCc9jeG2cmJza4dgNgy9rd4469iT2iala2oAWjun5z3SbA7rnMQp
	NBIt7jfz2Al
X-Received: by 2002:a05:600d:a:b0:485:3428:774c with SMTP id 5b1f17b1804b1-488d682bb48mr68343125e9.4.1775910921131;
        Sat, 11 Apr 2026 05:35:21 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d532ef00sm163047155e9.5.2026.04.11.05.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 05:35:20 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Tomer Maimon <tmaimon77@gmail.com>,
	Avi Fishman <avifishman70@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] iio: adc: npcm: fix unbalanced clk_disable_unprepare()
Date: Sat, 11 Apr 2026 13:35:17 +0100
Message-ID: <20260411123517.15083-1-devnexen@gmail.com>
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
 drivers/iio/adc/npcm_adc.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
index ddabb9600d46..6acafef3e7c7 100644
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
@@ -244,16 +244,14 @@ static int npcm_adc_probe(struct platform_device *pdev)
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
 	if (ret < 0) {
 		dev_err(dev, "failed requesting interrupt\n");
-		goto err_disable_clk;
+		return ret;
 	}
 
 	reg_con = ioread32(info->regs + NPCM_ADCCON);
@@ -262,7 +260,7 @@ static int npcm_adc_probe(struct platform_device *pdev)
 		ret = regulator_enable(info->vref);
 		if (ret) {
 			dev_err(&pdev->dev, "Can't enable ADC reference voltage\n");
-			goto err_disable_clk;
+			return ret;
 		}
 
 		iowrite32(reg_con & ~NPCM_ADCCON_REFSEL,
@@ -274,7 +272,7 @@ static int npcm_adc_probe(struct platform_device *pdev)
 		 */
 		if (PTR_ERR(info->vref) != -ENODEV) {
 			ret = PTR_ERR(info->vref);
-			goto err_disable_clk;
+			return ret;
 		}
 
 		/* Use internal reference */
@@ -314,8 +312,6 @@ static int npcm_adc_probe(struct platform_device *pdev)
 	iowrite32(reg_con & ~NPCM_ADCCON_ADC_EN, info->regs + NPCM_ADCCON);
 	if (!IS_ERR(info->vref))
 		regulator_disable(info->vref);
-err_disable_clk:
-	clk_disable_unprepare(info->adc_clk);
 
 	return ret;
 }
@@ -332,7 +328,6 @@ static void npcm_adc_remove(struct platform_device *pdev)
 	iowrite32(regtemp & ~NPCM_ADCCON_ADC_EN, info->regs + NPCM_ADCCON);
 	if (!IS_ERR(info->vref))
 		regulator_disable(info->vref);
-	clk_disable_unprepare(info->adc_clk);
 }
 
 static struct platform_driver npcm_adc_driver = {
-- 
2.53.0

