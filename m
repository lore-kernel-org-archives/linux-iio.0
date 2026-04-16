Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5DF1F94F
	for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2026 01:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776302319; cv=none; b=rSU/RrQBAhuDaoDSeBsXJnkUAbmuX+O4EJJo8/06x/Qs4mTFUzPpbwVKEY1UHHgMZKhDp1HK61XdkUjxCRA6z2+IhbOcv2YzG8yf9oi/2yj25hXwTdZyI9k0K0v6gAu+rokii+tN+jU9Jp4sYNe9/NbHhMAnCVR+SEicVeNgJIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776302319; c=relaxed/simple;
	bh=ix4MQCZb0a7oEzoizvKx4388P7WPEzrvMfERUWG1iq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eX/NLVJvGQ173MbQlg95z2bm8obzr09/6uTKiJQIosbN1/rsx2qgVVNa30xQoI9HZ0nZW/Xp9fwFYEihw43jErKWAVFW/az9e9QmPwx0RnIhFbT+8hVaXiqJlsSjf7f/LzmcmE+8lJOolRz/dltvhZvUk3jD1ns7/Ncfb5mDX8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=uhsScY13; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="uhsScY13"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2d832f2f44cso5058777eec.0
        for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 18:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776302313; x=1776907113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0mERTpe6+VkhMm65vrjqdw31z57F7sMaKCjw0DTf6B0=;
        b=uhsScY139xv8hOp7fiJ6iwGD4wtybXEvk3hlvzO+5j21yD5zlSFwxNhqU9prxtPJce
         bBe2vFuOPWPcxvV1l095lCfYFJdzljLj2Gh2qfBXyYOav3LIoQ9J339WTuRdz3pfVf7e
         kB79dmV7cK3g6EFaa0N1kwvJ+b7X+7SMPq+O7/H4qfyP4F1EysZvu7z7d9wDR8mfiAc8
         liYbZYvyAWmgo9t8fz+RsnKhyetrg9Pz7ZUpuWwqhMlMXD/meXlwESc81e5SsCw60XYd
         OxtYpEFbEEDK/X8fAp5MW5M69Qgj5Vnc876o3gCJkeBh/46kbq4Pi4pr7dQ7QLCqV5q4
         1R2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776302313; x=1776907113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mERTpe6+VkhMm65vrjqdw31z57F7sMaKCjw0DTf6B0=;
        b=nWgcO70izOEJ4YNJLUnhzyImJh1Va2GpwjwjtW8dkBHDAhakUtGTqas7fh0GVXaT9Q
         0+65m68phTuxttyn5lh8wFqLAF31R60FE5qlXBjSfTBJR03uLChQtSsnowDTVWcrxjNm
         waePNXfW2fIZ0xhM8X54bWL8fge7TH6OT6goRXX6SNnFns+PUMfRTnsEa6O0w8GfLJpT
         nqwqgjj++h915x7CGKFjdQ5mqqSYepaKkrclqCpku3nCWUD/fEznWLR2+PuqFwoqiHQD
         ITd+HINISrJJCaIz9z1Sb8J3aalm/q6WbBOGwsvh9Z5ZiMlnUEUdaHg35BGjRiAtBr7H
         xm8Q==
X-Forwarded-Encrypted: i=1; AFNElJ9itCupBTtnB8TNtcne49jIBy7y9/zHv7L4FDPH9ivIQ9MJsBB8dy3A4ASoJN38ax+f7GcdCTweEnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YytI3JDsFqwy0yrCkWjGH/lWLHawjej5of4CeNIkzl5q7GT3sIv
	+rTJyRIuXAk3PvukeA4wnwL1KDSbfovp1iE54DaQSr2/z9lpX2ZR2Sh5mQ8KmL8Nc7M=
X-Gm-Gg: AeBDieteGNwjHgvTGndA4xrDqN+KRxJf/g8G29vRjfebZcIj0vHmeB+vemFll7MVYNf
	WIh63xYcFrljOd3v3S7EjLH4SuqqaGV9SmEgfltgeR1C+4RdfZ4ohzAfiFOZoxNg6JC/LFb4Fbr
	N7rBVKCRanRUk/aLNUM0IyPAdFal56aexOYtTG4oU6wgaExsK9hFPOWPvqh7cJBvWJMiQAc1uUa
	xBf09vY4MgTRMF2/AfzrgZ5rAxJn9R054PyGYJa5vJK02pw06rMLhL6bEbQ0jcUNRw5yYs6t+wC
	Wt3jLZZcvBw+qOgSkbdxkDvvmEQGql3rP5UKTQ0Nzaut1SNIm82EAEh4IEnjmBOLoQQEr1UaIQT
	Sbe0rY1WWUsVMMkxrBZCQfrhioB6k7X1WgsWEa0WLoCzTU425aQlRkQS6NIV6VklAxQw1XeVGZy
	YHYuWXM2GJ03gt2WNCLyTYx3AUBP8t3W3McEVegJBD9Vpt0A==
X-Received: by 2002:a05:7300:a583:b0:2de:9470:5e88 with SMTP id 5a478bee46e88-2de94705f86mr2550130eec.21.1776302313352;
        Wed, 15 Apr 2026 18:18:33 -0700 (PDT)
Received: from localhost.localdomain ([177.81.10.105])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8919f9a0sm5325973eec.0.2026.04.15.18.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 18:18:32 -0700 (PDT)
From: Felipe Ribeiro de Souza <felipers@ime.usp.br>
To: paul@crapouillou.net,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Felipe Ribeiro de Souza <felipers@ime.usp.br>,
	Lucas Ivars Cadima Ciziks <lucas@ciziks.com>,
	linux-mips@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: ingenic-adc: use guard(mutex)(&lock) to handle synchronisation
Date: Wed, 15 Apr 2026 22:18:11 -0300
Message-ID: <20260416011815.9140-1-felipers@ime.usp.br>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace mutex_lock(&lock) and mutex_unlock(&lock) calls with
guard(mutex)(&lock) in functions ingenic_adc_set_adcmd,
ingenic_adc_set_config, ingenic_adc_enable, ingenic_adc_capture
and ingenic_adc_read_chan_info_raw.

This removes the need to call the unlock function, as the lock is
automatically released when the function return or the scope exits
for any other case.

Signed-off-by: Felipe Ribeiro de Souza <felipers@ime.usp.br>
Co-developed-by: Lucas Ivars Cadima Ciziks <lucas@ciziks.com>
Signed-off-by: Lucas Ivars Cadima Ciziks <lucas@ciziks.com>
---
 drivers/iio/adc/ingenic-adc.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index 1e802c877..bb7abdcd8 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/cleanup.h>
 
 #define JZ_ADC_REG_ENABLE		0x00
 #define JZ_ADC_REG_CFG			0x04
@@ -115,7 +116,7 @@ static void ingenic_adc_set_adcmd(struct iio_dev *iio_dev, unsigned long mask)
 {
 	struct ingenic_adc *adc = iio_priv(iio_dev);
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
 
 	/* Init ADCMD */
 	readl(adc->base + JZ_ADC_REG_ADCMD);
@@ -162,8 +163,6 @@ static void ingenic_adc_set_adcmd(struct iio_dev *iio_dev, unsigned long mask)
 
 	/* We're done */
 	writel(0, adc->base + JZ_ADC_REG_ADCMD);
-
-	mutex_unlock(&adc->lock);
 }
 
 static void ingenic_adc_set_config(struct ingenic_adc *adc,
@@ -172,13 +171,11 @@ static void ingenic_adc_set_config(struct ingenic_adc *adc,
 {
 	uint32_t cfg;
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
 
 	cfg = readl(adc->base + JZ_ADC_REG_CFG) & ~mask;
 	cfg |= val;
 	writel(cfg, adc->base + JZ_ADC_REG_CFG);
-
-	mutex_unlock(&adc->lock);
 }
 
 static void ingenic_adc_enable_unlocked(struct ingenic_adc *adc,
@@ -201,9 +198,8 @@ static void ingenic_adc_enable(struct ingenic_adc *adc,
 			       int engine,
 			       bool enabled)
 {
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
 	ingenic_adc_enable_unlocked(adc, engine, enabled);
-	mutex_unlock(&adc->lock);
 }
 
 static int ingenic_adc_capture(struct ingenic_adc *adc,
@@ -218,7 +214,7 @@ static int ingenic_adc_capture(struct ingenic_adc *adc,
 	 * probably due to the switch of VREF. We must keep the lock here to
 	 * avoid races with the buffer enable/disable functions.
 	 */
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
 	cfg = readl(adc->base + JZ_ADC_REG_CFG);
 	writel(cfg & ~JZ_ADC_REG_CFG_CMD_SEL, adc->base + JZ_ADC_REG_CFG);
 
@@ -229,7 +225,6 @@ static int ingenic_adc_capture(struct ingenic_adc *adc,
 		ingenic_adc_enable_unlocked(adc, engine, false);
 
 	writel(cfg, adc->base + JZ_ADC_REG_CFG);
-	mutex_unlock(&adc->lock);
 
 	return ret;
 }
@@ -643,7 +638,8 @@ static int ingenic_adc_read_chan_info_raw(struct iio_dev *iio_dev,
 	}
 
 	/* We cannot sample the aux channels in parallel. */
-	mutex_lock(&adc->aux_lock);
+	guard(mutex)(&adc->lock);
+
 	if (adc->soc_data->has_aux_md && engine == 0) {
 		switch (chan->channel) {
 		case INGENIC_ADC_AUX0:
@@ -677,7 +673,6 @@ static int ingenic_adc_read_chan_info_raw(struct iio_dev *iio_dev,
 
 	ret = IIO_VAL_INT;
 out:
-	mutex_unlock(&adc->aux_lock);
 	clk_disable(adc->clk);
 
 	return ret;
-- 
2.43.0

