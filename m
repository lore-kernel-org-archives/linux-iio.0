Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B4E1DF27F
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 02:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778034326; cv=none; b=LL0lOBtcIS7C2yWjweFJkdi4vNzzuTJaQbeBfrbgeSElL5FtVlV1NZIcbz7OjEZQkWS+oaNsM7V1eelOOAnG5/zrLeagaXpJidFYOaQAca/q32GzycKW2HxGp66y9/Okazma51EEtpf4y/RE/CoBaHgQ7Tsd6NiX2dpFaScyvZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778034326; c=relaxed/simple;
	bh=lFTm9qEyCAK2nGIpK0rQ1cCJK08Abms4bIKKP+sMSnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBvVlc5fItJW+2fTUYGDL5WBRjKF6O0nL7aSiR1HtxOTjGKydBytlupnlJslb9vQwP2gyp1dxatYPyOsOfeGWvEh/yJ8BYgJcy4KKY6YfCTTzBD1lMhTJkSDqa/JENpstvp7nfKWs5SCEAqyyHhKI0uU1G9ukbNFWAg0L7Z2IfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=CkCBS827; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="CkCBS827"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2f3c623322bso3454179eec.0
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 19:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1778034324; x=1778639124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DevSjtpLYeeeXCne4nAk0EPcavZXhzZV81kaGXd3EmA=;
        b=CkCBS827efhghJFkb8tQProxN0yfW3+Ehu7+MeXW68YHW8/PfWb7d59n2ZwlgaT0LK
         16c9VfbkRqNYAco3mZnRjOCmXCoiAl1J8dWLZ9ES7+atf4YpH9AhxvqwgKb/YatFSYuE
         eLfz2goenbjBsLz9SUWNBxR9zWaZeh25oe1JmxUclt4M8dTz6o8MBvNEULPknj73z4aw
         0Dr5GJexye/yRbbFsTozGIFJtANUKV8mgJQT1ZBsSnycIy0AycBDp6wvi7GbM6lELfml
         QWlBod7I4Dx+FVInASy1jPzj5/bAR1ab/rbrYZo0H3mDTMQxgLaq10d6XGy7tZXtw0/e
         wD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778034324; x=1778639124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DevSjtpLYeeeXCne4nAk0EPcavZXhzZV81kaGXd3EmA=;
        b=Wp3HdVkbuYuUInfpaHQeWH9tzytm7jCnFFL2uPElLx+mMZEABjlC5szbhc7O7L8u9J
         fO9YCsPv7UVjk0LVHvrBn2MhFAUOP7tqYFgojEw9mKs0R/CJ3mcFHWzMX4Vz1ZeTRlii
         q+fBBeRng03PCTk0HeW7NmbTA+AS1rVMoXPW/4eHwX60/DtWc8amUGUbdr1hb/T7axcS
         xvnvYmnBdQRM2pATcGnHd5Wy284rPumfSMA/8kvGpxpPUW833aNSkvjbyVc8Z8L4JXxb
         7mneew8iKv+gNR8K30pceU0l6BwJoLukezSr1bOn8ih+DmxdcjbRA/tyOG+NQ4sDymKS
         kx5Q==
X-Forwarded-Encrypted: i=1; AFNElJ8Gme2mzf5sRv23Y+GRr+xJlnAZNj75oATGMak+no4tyF03C+IPIs41Af1o+bTiyhEtcaS6XI0x0hE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5aTTGKlBEzXVbPhJN9+R2IESAOcrDcCCCh09Z7HYTFIHO5TUl
	HLk/GlixMKUPn1LoZdeUV0/JYVu0EJYmKoJdjQuPLCkpgt3l0tsFIV0K9PSkxTUvOp0=
X-Gm-Gg: AeBDiev2WqSEatNONDFtVnbdnzhPAO5Ioib5ibAJ5S/Ng2Yj6eRxrScHcoLZs8jiTHd
	ys5Rzt/dnVyNNtcjHoQQby+P41orR0/oFCBMoU8xZNUgSqQbrpwQk1Db7lLYyLfedwGjQdjpn+7
	u6vcnV01bwFcKgchVoCkwQl2C/Si+2SU4O5M8Kg6DYNxkhhFQmHLrYywoYSAO+aCu8IEE0shVYg
	fr60poVa5ASe7/pPd0lpsa94cG0+YwDLR+/WYBgCoOFvoPnvGAcEh14XG7vmfcRtEGuyDCl5PIL
	LDkCUtiyqb1z6H+M3jq7GLx6wiU0E7WoBDiIUhUTpMKSeM4QAVrOMcYz+yVi4hhzrSfUL161j49
	kG2rwyd27yaC9za9tj7WSbS+nJWJKkFAXecUUScC1AdN1ZdJt4SLUSZzmejwJMXcEYKGtl9wDQ4
	/9AOXK2REXIeM3y/XLSCV4DlWmtAcNtIQor32qt3q7n0RhYw==
X-Received: by 2002:a05:7301:3f16:b0:2c9:1943:e7ff with SMTP id 5a478bee46e88-2f54b35fb00mr855079eec.10.1778034324067;
        Tue, 05 May 2026 19:25:24 -0700 (PDT)
Received: from localhost.localdomain ([177.81.10.105])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56d5c3783sm1669552eec.11.2026.05.05.19.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 19:25:23 -0700 (PDT)
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
Subject: [PATCH v5 3/3] iio: adc: ingenic-adc: use guard()() and scoped_guard() to handle synchronisation
Date: Tue,  5 May 2026 23:24:30 -0300
Message-ID: <20260506022454.128169-4-felipers@ime.usp.br>
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

Replace mutex_lock() and mutex_unlock() calls with guard()() in
functions ingenic_adc_set_adcmd(), ingenic_adc_set_config(),
ingenic_adc_enable(), ingenic_adc_capture(), and with scoped_guard()
in function ingenic_adc_read_chan_info_raw().

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
  - Split out ingenic_adc_read_chan_info_raw() logic to helper function.
v4:
  - Adjust code style for better readability.
v5:
  - Rename ingenic_adc_enable_unlocked() to __ingenic_adc_enable() and
    ingenic_adc_read_chan_locked() to __ingenic_adc_read_chan() to keep
    the convention about the locked functions name.
  - Move the mutex lock back to ingenic_adc_read_chan_info_raw().
---
 drivers/iio/adc/ingenic-adc.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index 91e3ea6615942..414f69acab7b3 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -7,6 +7,8 @@
  */
 
 #include <dt-bindings/iio/adc/ingenic,adc.h>
+
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
@@ -115,7 +117,7 @@ static void ingenic_adc_set_adcmd(struct iio_dev *iio_dev, unsigned long mask)
 {
 	struct ingenic_adc *adc = iio_priv(iio_dev);
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
 
 	/* Init ADCMD */
 	readl(adc->base + JZ_ADC_REG_ADCMD);
@@ -162,8 +164,6 @@ static void ingenic_adc_set_adcmd(struct iio_dev *iio_dev, unsigned long mask)
 
 	/* We're done */
 	writel(0, adc->base + JZ_ADC_REG_ADCMD);
-
-	mutex_unlock(&adc->lock);
 }
 
 static void ingenic_adc_set_config(struct ingenic_adc *adc,
@@ -172,13 +172,11 @@ static void ingenic_adc_set_config(struct ingenic_adc *adc,
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
 
 static void __ingenic_adc_enable(struct ingenic_adc *adc, int engine,
@@ -200,9 +198,8 @@ static void ingenic_adc_enable(struct ingenic_adc *adc,
 			       int engine,
 			       bool enabled)
 {
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
 	__ingenic_adc_enable(adc, engine, enabled);
-	mutex_unlock(&adc->lock);
 }
 
 static int ingenic_adc_capture(struct ingenic_adc *adc,
@@ -217,7 +214,7 @@ static int ingenic_adc_capture(struct ingenic_adc *adc,
 	 * probably due to the switch of VREF. We must keep the lock here to
 	 * avoid races with the buffer enable/disable functions.
 	 */
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
 	cfg = readl(adc->base + JZ_ADC_REG_CFG);
 	writel(cfg & ~JZ_ADC_REG_CFG_CMD_SEL, adc->base + JZ_ADC_REG_CFG);
 
@@ -228,7 +225,6 @@ static int ingenic_adc_capture(struct ingenic_adc *adc,
 		__ingenic_adc_enable(adc, engine, false);
 
 	writel(cfg, adc->base + JZ_ADC_REG_CFG);
-	mutex_unlock(&adc->lock);
 
 	return ret;
 }
@@ -681,9 +677,8 @@ static int ingenic_adc_read_chan_info_raw(struct iio_dev *iio_dev,
 	}
 
 	/* We cannot sample the aux channels in parallel. */
-	mutex_lock(&adc->aux_lock);
-	ret = __ingenic_adc_read_chan(adc, chan, val);
-	mutex_unlock(&adc->aux_lock);
+	scoped_guard(mutex, &adc->aux_lock)
+		ret = __ingenic_adc_read_chan(adc, chan, val);
 
 	clk_disable(adc->clk);
 
-- 
2.43.0

