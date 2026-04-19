Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC46B1632DD
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776612579; cv=none; b=ZIvP3KSDEgbD56vENCRP4/NyLcHpXKKfAEhhdnwE0K7dOw88hwiR7bpqzf8qUWbZJMj1Q5G4IRRicoWa0tmgR5JQoexiW9SosjGQfJAtbBIPSWzL1T1QP4MX2Z5CBwc+ITtwxxsHyedE7OqJ7WC4TPN1WgDS5q/TN/wF9WNFfS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776612579; c=relaxed/simple;
	bh=dZk4AYRSuixTeHEtwFeJ5/QcTEkmu2JXEkI4wa5yfBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L89S0hCJuXrDT0q1jwr3JdTTY/qG8XpF9LVA9TT2CUs0p8/3Kg93rGltuWDh6n961o796GFbUy5W8t8RoqHf3xF0oUfcJT6ANwwuWBua1O6QxFW0TIEqjDtohhTPMrf4KdfuLGCeQEMRT/mO1gCFT+gHFx8qoA6ibW/zTShPWrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=oXSfuqLL; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="oXSfuqLL"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c19d23b19so2788303c88.0
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 08:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776612575; x=1777217375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B/CPL0C+I2VNJFtpTpEIDtJx0mavuJN+qudj0GJw0BM=;
        b=oXSfuqLLY34ObRFDnD3iqBx9cID0Ba1KOsXQClnF7ZxUyUoGdSPna7x6W7qcmM99ir
         hPFxF8QIFjO+xzNeFmO/NCdyRDbFBJYAVhKkxAvD+5S7Vbw5/6LiFKuFiVEZUjazAvN2
         NgGqKj6hkc3uCnKLs8HqXT3b5B/78C9XlQBj84dknX2qn+CZ2TMz80XFcUG13emfKXC2
         Aym3FFPJKohTv7NYtj7jYMVo7oHYbh4Ri3c6B+M9AMbjIDmg2K+EI0QIvYz4SLbWbdzP
         z4tj8zCY8hyN3RPHmtLfXVtcUIDRSEJ5EjLRHDzVZJ5dZKLsVxy7AHWjSAEmhtaFMY+a
         dTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776612575; x=1777217375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/CPL0C+I2VNJFtpTpEIDtJx0mavuJN+qudj0GJw0BM=;
        b=KAAlRzaNVoRH9GrCi5ze7sz/Wc7dpvxamugdmTFZkBROOu+I5YYuiV6zthB47/9y9S
         uk4Ne1X2ZRYJct7D/pMzHL063iUo5KUn+51O/v8TaQeqAV+fOdqlCH1oTKaz6xDy9gWm
         l6OhZlqhljpN6Z9lqiMlrqbe/p66sSKj1+o4reo7H16dy5GwvRV5+Lh+ATwgwzRmZ75c
         Q+/RvmYhkwKHIdQD8qYWQgvk/k/8JWmwunHCmg4pjuanKGHLTwbpaF7pdhURy+4tGm+0
         OAuvb/41Pgj7/GB5GEZyW/HeawOtSnEoK0irmnCXoYqcOUoyf3Az+N0KRAIER5osAc0Y
         nhhw==
X-Forwarded-Encrypted: i=1; AFNElJ/ENRALq72ak/eIBtauZmqfsv1LBHLc23YBSzVWbuf90l+HyJoWy0IBtTUBFaVmO7g6hLRpQy8qdZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa9qGIoo4ZoE24cVsMyc7mq4itA9odMDUuIpG1vxHzmBT5P3RE
	zTWUwCKcST/rc/duxzTaBE6SmT4Zhw28jA1cFOAnDGKFYBakn0qDQWgXDYuStH8oQuI=
X-Gm-Gg: AeBDievXcO/gMx4dW1oBrbOezbjxHaM6vShlLwwQOQMykH8DdmYX4Cmed1r7VlbZ3QJ
	t5Rq8QhwOvImgng9aKG1CikY0TylU8EBzM/24E3DyvEHmQlR88fo1hFLcJsp1GP9rHR86MQ/oE5
	nwmvNiiBdZ5lLDoB3i9Wz25pveBXmAhg/mSpFgax7vzAI4SHMckmND9qvhZ+Ik8/ZikNFJPpPRv
	U5pplUQgnlV10nTk5+2Gjg6zCPYX8zqlR5PsetAkkE+Nwm5r/+VRtl1XBcjI/f8z/RxRId+t4Yo
	nbfRVUi75S2d2TxmAunTqaXvv1o6MmBo8NKMK/PaGNRDmLhZIa9nqtChojnsDOZPYgB4Kd2Mo9F
	ZR66VirHLku9owpaN2FSzl4Ut+OBGkhD0Qr8tb/T1v8Cd5YSqLKGpO7L0MA8+Mv7n0ozmPAtYeK
	wQanImW6r9GrsIE7VF5EhwRq8DTiZRJe9VZ49IZk46Nqu9k9gpG5dhdD396g==
X-Received: by 2002:a05:7022:458d:b0:12b:f616:1a4e with SMTP id a92af1059eb24-12c73fa362emr4062955c88.23.1776612574962;
        Sun, 19 Apr 2026 08:29:34 -0700 (PDT)
Received: from localhost.localdomain ([179.119.81.104])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c831d5b29sm6246038c88.8.2026.04.19.08.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 08:29:34 -0700 (PDT)
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
Subject: [PATCH v2] iio: adc: ingenic-adc: use guard(mutex)(&lock) to handle synchronisation
Date: Sun, 19 Apr 2026 12:27:34 -0300
Message-ID: <20260419152917.8984-1-felipers@ime.usp.br>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace mutex_lock(&lock) and mutex_unlock(&lock) calls with
guard(mutex)(&lock) in functions ingenic_adc_set_adcmd(),
ingenic_adc_set_config(), ingenic_adc_enable(), ingenic_adc_capture(),
and with scoped_guard(mutex, &lock) in function
ingenic_adc_read_chan_info_raw().

This removes the need to call the unlock function, as the lock is
automatically released when the function return or the scope exits
for any other case.

Signed-off-by: Felipe Ribeiro de Souza <felipers@ime.usp.br>
Co-developed-by: Lucas Ivars Cadima Ciziks <lucas@ciziks.com>
Signed-off-by: Lucas Ivars Cadima Ciziks <lucas@ciziks.com>
---
v2:
  - Adjust order of #include.
  - Replace guard() in ingenic_adc_read_chan_info_raw() by scoped_guard()
    to preserve original behavior.
---
 drivers/iio/adc/ingenic-adc.c | 69 ++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index 1e802c8779a4..5f914d5e5362 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -7,6 +7,7 @@
  */
 
 #include <dt-bindings/iio/adc/ingenic,adc.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
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
@@ -643,41 +638,41 @@ static int ingenic_adc_read_chan_info_raw(struct iio_dev *iio_dev,
 	}
 
 	/* We cannot sample the aux channels in parallel. */
-	mutex_lock(&adc->aux_lock);
-	if (adc->soc_data->has_aux_md && engine == 0) {
+	scoped_guard(mutex, &adc->lock) {
+		if (adc->soc_data->has_aux_md && engine == 0) {
+			switch (chan->channel) {
+			case INGENIC_ADC_AUX0:
+				cmd = 0;
+				break;
+			case INGENIC_ADC_AUX:
+				cmd = 1;
+				break;
+			case INGENIC_ADC_AUX2:
+				cmd = 2;
+				break;
+			}
+	
+			ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_AUX_MD, cmd);
+		}
+	
+		ret = ingenic_adc_capture(adc, engine);
+		if (ret)
+			goto out;
+	
 		switch (chan->channel) {
 		case INGENIC_ADC_AUX0:
-			cmd = 0;
-			break;
 		case INGENIC_ADC_AUX:
-			cmd = 1;
-			break;
 		case INGENIC_ADC_AUX2:
-			cmd = 2;
+			*val = readw(adc->base + JZ_ADC_REG_ADSDAT);
+			break;
+		case INGENIC_ADC_BATTERY:
+			*val = readw(adc->base + JZ_ADC_REG_ADBDAT);
 			break;
 		}
-
-		ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_AUX_MD, cmd);
-	}
-
-	ret = ingenic_adc_capture(adc, engine);
-	if (ret)
-		goto out;
-
-	switch (chan->channel) {
-	case INGENIC_ADC_AUX0:
-	case INGENIC_ADC_AUX:
-	case INGENIC_ADC_AUX2:
-		*val = readw(adc->base + JZ_ADC_REG_ADSDAT);
-		break;
-	case INGENIC_ADC_BATTERY:
-		*val = readw(adc->base + JZ_ADC_REG_ADBDAT);
-		break;
+	
+		ret = IIO_VAL_INT;
 	}
-
-	ret = IIO_VAL_INT;
 out:
-	mutex_unlock(&adc->aux_lock);
 	clk_disable(adc->clk);
 
 	return ret;
-- 
2.43.0

