Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836F63A5E69
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 22:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809824; cv=none; b=o1BRmu0FXyGpETssNv8S4/v8AIgqZws7YCfwo+o79iN5dPXGHIH8M6hZVCnHAt/bO6cgPfXfGcfbgsFcdFMsld/YedzXBeXHtgAbhab95rs4W9nDbSoJFCLADLajaoVOzKoeMKCnyW52BbYW3rCVTxiiE5EMEzEZVXJXlRlJgqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809824; c=relaxed/simple;
	bh=SN7y5u1UHlPrW3+Ij4lqOW/DHw1WVQ87jFM+vEHumKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KjTrQsfkbDNY6TRGdhA+5N2NGT5X3TiwS03rBK+/UFXuVe3NUZf4QzrfoYhQ2x5Ey4qexAWX4x8LqE1xeNS3Ac/JaPbmuPPxG2GurdrGeQ9ynMqdp7+l4pZW8THrQ/I8Ts3D/D/HrRkD7n6osF8Xoj0Nj4DnvmFsFPfLgPRl3OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=aqNtR/xN; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="aqNtR/xN"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so3689945eec.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 15:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776809821; x=1777414621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pn2lKNM8ZbGs52oI2dTR8+56uoXwooahMoMCtzCSErg=;
        b=aqNtR/xNdgH3RITbbMOIWAxHXJKF5VxdkpV+V1Q4Z3uOPpaPVeWf1g0UeqcCSgxOPK
         TUlxRMzbCIasTBsT84mbaKH7uo5iNG37QvR5+BybDI5NG69tguTXqZAQNVoiSpm4Pn12
         yv4iK1bZbQJCx9pHof3O9DyUX2WZk9rqmCM/ro6Wzpj8SM/o7m3nDV0FaTjD0HmMXI8p
         1rG5t5A+lMv37FgYIpoVcCI67nP48UFPVV998CTZv3hWkDGstVuJctQpuKDMnYdk3qjK
         d+w4TrXbhWu1kh9WyLQqBZnlQV34VKxYkTvX0XS1MOiHIE1OnHY31upSSwvP2CPVN35c
         9mJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776809821; x=1777414621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pn2lKNM8ZbGs52oI2dTR8+56uoXwooahMoMCtzCSErg=;
        b=k9C4Z/nivPGMoVVf6peqY0Vs7PnxwpG3XGS1ptY3yRcqPeMyFLEEGqDk7ESy0uzEKX
         gIU7HsOQ8xA2lAZL1VzeX/JwgLq9ZrgjiTPq96yeLP+dn5nJK+fMycZII+d52k0VLtQ4
         D1WY8ZpvEY6uS/E2mU2BGdPf11AP1NqOe4+V7za6sAmZhElyjkx/7dHNHrs1u2pxH1K0
         +TjuiycIFrzOXizz+iaBMrmMJbdMlY9frvpY0Ri+f8Cz2x/uyGXNym87ygiN38lReC7B
         6dEBBrTHrZOrBDmlXDaVA72KlLXKi7VjQ1SWshuFiXHLuXDhZs1qibjub5N16f4GmMyr
         nBjA==
X-Forwarded-Encrypted: i=1; AFNElJ8kVvnU0BGsT4Lw1WiV2nTcDoZ2ROmPo55ptzRLA0Ts4ptogTVY9w8unlD/rHJk5+lvA8N+5DqNqFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaxhlTLZY8AUhKacQqX2XZc+suEECReoSYkargEaAc9V7SvDP7
	I4/tVpP8i4kSiFSY4n8eS35NKyftNyol+/ejgxD7EGvtv6dFawu5JpLHtyTE65F5w3U=
X-Gm-Gg: AeBDietkFfK/7z6aDpvODBJQOBPaglz0p38RC0GjrMGlGdPNhkPxwZJWxw1UH2/fXbJ
	jdXmBtLE8IKjXYppEav5Gj/JlZoMWLZLGNzbyMe+/HSwmjhzX15QVH+0jCNVv9w3v62kjPHu4iZ
	vVA9IOuNCHL6FKLgG9mn1JAozUJz47K5dzaETUkVL1dcnvDaC5bH7kOexCK+rgV163dJydLzR/d
	HwiW4GP3ZnZ/VqjMfa3MubZMyifVafxdoypWxcZeN2aIfGxrKUrdadAJ1gESUTcZO+Aef0l3iz4
	uBRkv6UScXIIurlY0bCBIz8Z5yluplzy3QM5dP32ANDm8EY5nYaFofgVKfAaqALxKSFUnwY89L2
	ksihyc6c+BCfA/xfjxg7f6yo5BGgLQBvEIBz0VbjBor6j4w4cr0vnu2iuAQdUDTJXUx1/Hz6B11
	j/ulCqRM6sui9B6vnTiwFnTGYZaHtnlwiTgiAIiR+eR1eN4kdJ32Z4KkxpZaQqrlQUlEB/tJhbn
	K3UASU5Wo1l
X-Received: by 2002:a05:7301:9f10:b0:2d4:532e:7e45 with SMTP id 5a478bee46e88-2e47930fdf6mr10921058eec.23.1776809821343;
        Tue, 21 Apr 2026 15:17:01 -0700 (PDT)
Received: from felipe-ThinkPad-E14-Gen-4.. (201-92-135-6.dsl.telesp.net.br. [201.92.135.6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2cfef3sm19827980eec.24.2026.04.21.15.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:17:00 -0700 (PDT)
From: Felipe Ribeiro de Souza <felipers@ime.usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	nuno.sa@analog.com,
	paul@crapouillou.net
Cc: Felipe Ribeiro de Souza <felipers@ime.usp.br>,
	Lucas Ivars Cadima Ciziks <lucas@ciziks.com>,
	linux-iio@vger.kernel.org,
	linux-mips@vger.kernel.org
Subject: [PATCH v3 2/2] iio: adc: ingenic-adc: use guard()() to handle synchronisation
Date: Tue, 21 Apr 2026 19:14:59 -0300
Message-ID: <20260421221629.70401-3-felipers@ime.usp.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421221629.70401-1-felipers@ime.usp.br>
References: <20260421221629.70401-1-felipers@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace mutex_lock() and mutex_unlock() calls with guard()()
in functions ingenic_adc_set_adcmd(), ingenic_adc_set_config(),
ingenic_adc_enable(), ingenic_adc_capture() and
ingenic_adc_read_chan_locked().

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
v3:
  - Split out ingenic_adc_read_chan_info_raw() logic to helper function
---
 drivers/iio/adc/ingenic-adc.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index 81ed92f4490cd..733f0276bb0b1 100644
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
@@ -635,7 +630,7 @@ static int ingenic_adc_read_chan_locked(struct ingenic_adc *adc,
 	int cmd, ret, engine = (chan->channel == INGENIC_ADC_BATTERY);
 
 	/* We cannot sample the aux channels in parallel. */
-	mutex_lock(&adc->aux_lock);
+	guard(mutex)(&adc->aux_lock);
 
 	if (adc->soc_data->has_aux_md && engine == 0) {
 		switch (chan->channel) {
@@ -655,7 +650,7 @@ static int ingenic_adc_read_chan_locked(struct ingenic_adc *adc,
 
 	ret = ingenic_adc_capture(adc, engine);
 	if (ret)
-		goto out;
+		return ret;
 
 	switch (chan->channel) {
 	case INGENIC_ADC_AUX0:
@@ -668,11 +663,7 @@ static int ingenic_adc_read_chan_locked(struct ingenic_adc *adc,
 		break;
 	}
 
-	ret = IIO_VAL_INT;
-out:
-	mutex_unlock(&adc->aux_lock);
-
-	return ret;
+	return IIO_VAL_INT;
 }
 
 static int ingenic_adc_read_chan_info_raw(struct iio_dev *iio_dev,
-- 
2.43.0

