Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F331DF27F
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 02:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778034315; cv=none; b=CVlJ8xpp03zF7toijzOJsHQnlApbSkUV0SCrsCEPQJWR4yah1I8bFYHNTNIn8NMHHiL2X/9Cgw0YIZ+q6fuaH9oUaxXgcG4SUF5+0pl3EBnTi9T/pQdq030p/FOxopZeA+80xe8NOLtEsuaDJ0sxDiL4wxyUG1xgzWjeOjHAoO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778034315; c=relaxed/simple;
	bh=bPaCfOo7Jza/gA/NBqWf9P7UDT6hOs3InWd7/OvZ1zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0x0ts8koCCIYfM1zBjHufm3WG/yXco8YHeBGth77s7ap1csSKKSrRVd3dnQyhaqb+x+gwBw1MV3mkiWIDd2L0NH+6i9g48ASI31W97NpaOPs11NfS9d67VpdIHnaNAhWuhLHcUHmGX1bwFSeVLqcGmBpns9I0x34LakqsdgBtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=lCFf2P3k; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="lCFf2P3k"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso367724eec.0
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 19:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1778034314; x=1778639114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kyJpuOtQ8ZWddySKSeNDHVlMxiqYgQi/4o8AcQNP10=;
        b=lCFf2P3knsqubCN8amgLQWkXq034kR5Yz0HwpYRm6XqUbO8FKOEvl27xt2kxomWfum
         bc/mWzlZ5PbevGYm1r7QeWAuXbqxoKpQiNZNGpZcax06AAhsEHmIAp87Z5pe6pfNO3Oz
         nfCqXx2gUcsu/BpVGRzzDnFjBnFev5vA4jttno0woWjVmSHQYVSaIODEetg1qTfc/v4j
         5zuOf0p9zkWDTI+iBl9vpPmxN8LhORIKWy4dOusbwJJfF9+9IfqmRAb8Ef1DEKz5Fkfq
         sa0pX3mLOxFuARDNFwlqAhUhxlEAb4cko/BIX803QRU3eOhK8JA/ZX99lqcdlXMtiW25
         +Ymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778034314; x=1778639114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5kyJpuOtQ8ZWddySKSeNDHVlMxiqYgQi/4o8AcQNP10=;
        b=asEGehnAO9QKRAyDHmUSYFvTde4vyn8W1Pps6UGAgLD8UaVeC/ROWBPWsD2TF8eSM4
         dY8+1F7LGfjaDEvBtC4yD3GLuxHTJZ0DghdbvJfdsP7qGfiZyBmFWqOKwZJlNbExQsG2
         TrOYtdO2olrWA42C0v1gP/upnRUCzCto/qAkd/hLQsxwbrhgpQBAsWEaGKBecpvpwQj3
         Y5jntaBhqWNRxLeeh+G5nGpOREBkhG8tWZ0NBcbBGC/F4Z09dKFKOkNCnvmYqu+vRGeL
         tWCxD+2rRx0VGi06IXRaP4FSwxNRVp6qd+NFJUxGtHk/AaxLCJmaheEmACg28xxrjW5Q
         eyVg==
X-Forwarded-Encrypted: i=1; AFNElJ8uGNOHbS3lxF2OuHLVDjS/9frT6V+3tVuoXDCjDUUyum0W8I/EM+swMbqxq+L8MN/ySqOlvpcNtwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFkowqClgNC+o0RhnxyBuZmTwFrLRknAeEXYlK2uMNcv3bqpTV
	CEQyBgrWVYrY5DT7+kbmZZj7OfQO8V1lYMEzaCcHdAh+W5NRcofkjzPXazLf1jI4I3M=
X-Gm-Gg: AeBDieu567ivvs388yKegIGVatDO0Q1eUYtym49lqgbiW15HZOF2W5x0yH7LYCN+Gpa
	Zqxew5ri141ejP7g0jBdcnoBGdDM6nZpGS2ouYS6+b+bEMlKNJoM+tv4GROxle75T/N8b84isBN
	ITD4uKV1xntqxKVI3NddnwrhvH5x3hMW3bMRVcESW0d7M81ioGfigPBYDsQaVtgT8W2lHiWNAG7
	7qQ69G/3BqDSAbqmJrIvJO8DJkZbafTWcciG1yyHj75oasqY4v16RzsngRfDvL98d5HTrCakdMc
	b8dUX8h391Hp/gPpXzlX4Xqx5sUp4+XeGdB9jNllwarIf73tkUPhP5MY3T8SwJUy150hVyXK48j
	SlX7QRkMG9AWEaCnezELs3LHsrOTI+s76Xd6+Hw6k6CREt7HVZZl/llgb9P4UN2B92RFI3PPeJA
	XOTRUVRplh1JIzi/mi6D3PpDSaMXN7F/OQSG73jcy1Kp28yw==
X-Received: by 2002:a05:7300:320a:b0:2f1:8f09:702a with SMTP id 5a478bee46e88-2f3d079b31amr2795010eec.13.1778034313619;
        Tue, 05 May 2026 19:25:13 -0700 (PDT)
Received: from localhost.localdomain ([177.81.10.105])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56d5c3783sm1669552eec.11.2026.05.05.19.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 19:25:13 -0700 (PDT)
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
Subject: [PATCH v5 1/3] iio: adc: ingenic-adc: rename ingenic_adc_enable_unlocked() function
Date: Tue,  5 May 2026 23:24:28 -0300
Message-ID: <20260506022454.128169-2-felipers@ime.usp.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506022454.128169-1-felipers@ime.usp.br>
References: <20260506022454.128169-1-felipers@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename ingenic_adc_enable_unlocked() to __ingenic_adc_enable() to
better reflect that this helper must be called with the lock held.

Signed-off-by: Felipe Ribeiro de Souza <felipers@ime.usp.br>
Co-developed-by: Lucas Ivars Cadima Ciziks <lucas@ciziks.com>
Signed-off-by: Lucas Ivars Cadima Ciziks <lucas@ciziks.com>

---
v2:
  - Adjust order of #include.
  - Replace guard() in ingenic_adc_read_chan_info_raw() by scoped_guard()
    to preserve original behavior.
v3:
  - Split out ingenic_adc_read_chan_info_raw() logic to helper function.
v4:
  - Adjust code style for better readability.
v5:
  - Rename ingenic_adc_enable_unlocked() to __ingenic_adc_enable() and
    ingenic_adc_read_chan_locked() to __ingenic_adc_read_chan() to keep
    the convention about the locked functions name.
  - Move the mutex lock back to ingenic_adc_read_chan_info_raw().
---
 drivers/iio/adc/ingenic-adc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index 1e802c8779a4c..231ff8d584c2d 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -181,9 +181,8 @@ static void ingenic_adc_set_config(struct ingenic_adc *adc,
 	mutex_unlock(&adc->lock);
 }
 
-static void ingenic_adc_enable_unlocked(struct ingenic_adc *adc,
-					int engine,
-					bool enabled)
+static void __ingenic_adc_enable(struct ingenic_adc *adc, int engine,
+			      bool enabled)
 {
 	u8 val;
 
@@ -202,7 +201,7 @@ static void ingenic_adc_enable(struct ingenic_adc *adc,
 			       bool enabled)
 {
 	mutex_lock(&adc->lock);
-	ingenic_adc_enable_unlocked(adc, engine, enabled);
+	__ingenic_adc_enable(adc, engine, enabled);
 	mutex_unlock(&adc->lock);
 }
 
@@ -222,11 +221,11 @@ static int ingenic_adc_capture(struct ingenic_adc *adc,
 	cfg = readl(adc->base + JZ_ADC_REG_CFG);
 	writel(cfg & ~JZ_ADC_REG_CFG_CMD_SEL, adc->base + JZ_ADC_REG_CFG);
 
-	ingenic_adc_enable_unlocked(adc, engine, true);
+	__ingenic_adc_enable(adc, engine, true);
 	ret = readb_poll_timeout(adc->base + JZ_ADC_REG_ENABLE, val,
 				 !(val & BIT(engine)), 250, 1000);
 	if (ret)
-		ingenic_adc_enable_unlocked(adc, engine, false);
+		__ingenic_adc_enable(adc, engine, false);
 
 	writel(cfg, adc->base + JZ_ADC_REG_CFG);
 	mutex_unlock(&adc->lock);
-- 
2.43.0

