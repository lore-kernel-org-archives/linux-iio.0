Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C7C219303
	for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 01:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776907259; cv=none; b=YJnnrl4SfKVW1uLIYIJLuxiLbg8ikqGKbexjaq+dRqsiVW+duDVk3XWdlgOHzZZ0nLSIV/dnmbqj/w3988OxyrPFqFbq90BYeBXqE0DAXWT7RJJ1Eaob8aBC/Mc9I9ZHlI01sjE6XHMGRTg0GZZlPvXbLd7Qai8mA0RfPbEoFVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776907259; c=relaxed/simple;
	bh=4DrNjwo8uIwCDNducjAx4yUSrQy5oGs+c+60R2z7No8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JeSUUC+F+d19Ed49XV+XQ9zk6rl8mecBd7RQnm/4pRpjjC39c8S0/K9c9fJsXTCBcXmSa+b+3tEuT/OX5Sl69xjvDA2Awvps3cySxwkrK0s7rm+ddtF2yajc8GONhLgBQUvfesrWDkjiOyYhQbdAk3WaB3lkha4DU2p2DVBmWSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=b3g08thV; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="b3g08thV"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c19d23b19so7889375c88.0
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 18:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776907257; x=1777512057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WacU78F8QYGrv10AUSXrlUWShZ6Ipzv7ZroO0zW8aE=;
        b=b3g08thVq045+owgpUuOgiZ5KFPgNGxZtWIbbS/VElKxymHhjln5sz2FKMpTxuCsH3
         Ey4W78btJB5M7G/FmLmNOvorxDSwNHR5rzRwMRacnFPL7oZZ986KehgbRRybZO+LGVWq
         rtr3mqQwzqTe120kIcLQxOiNYEHdJyZQM2CxnS9RSSGoAJ5RPP3FBIxd3YbfuLY4ZE1V
         wXo1INW9mQ3YX/cBar/Phk/6M/FP2E3/UPxw0gLKMelidtQStx1Na/1Dw9ty9GiZDADo
         JKpL62254+LzvmO0p3CJXntySoPjOaVWrARw33sGVdftgD163sKjx6xFsTujunQuaFZ5
         D61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776907257; x=1777512057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4WacU78F8QYGrv10AUSXrlUWShZ6Ipzv7ZroO0zW8aE=;
        b=UHICdsVyAx20y6kpXCeJFzDftcmHQ8Sahr8QpmAn54lbrt9O+LlPnWOKZmAuBbcbcr
         uYbzanZABL0vWTT310+t6waRzywCuUPBW9ssWfeaz0ubFEoyMgL4NRP6A+4WjJkxKXgl
         hhdX5w7xPxr+43RYtUAR1s6Qg7FXLZ14UFICsrXL8fhRz5HXfyS5PoIJNgsU98qpW2tW
         qKAXtnP+UGDR1WHrX9wlG8rxCesXFlqxwcnK9c5SiMTFK8MTE4Iwl9hGmKlb4qd4bqfQ
         D+gw8L5+lVAgFJjywNFf48Y/Wf4YXzsil+IJ5uLQTRqN96PuPR7I0DM8UD2qaxGnLQnr
         qYLw==
X-Forwarded-Encrypted: i=1; AFNElJ9xS0yr2sgTOEEMDQokNzDNOy5DQ2hC/siUEFHYv1XmUnovFFfop8xBYYy2fPs+b/XE/XWXxjixvb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYMlQ6//AKYy/DjI7G+qVaVY4EKDvQ7aEjMtOUShl/KnwPE/rm
	8m1Ysz6vXt55iHHRoQ4y0sexZWiNimbIi/wLy2Qwt5Cv9sJLSCu3WRiiVCi6EbMznH4eheaTOx0
	SxAuU
X-Gm-Gg: AeBDies/IN5h5pPXydJQIMgmeIa2EYXASrhiSULsDDR96u1dStEpZnLMZ1mKt7Rwldw
	pq3MNnojtY3lfbEaXUpe7C+LQQYJSioK7PUGSHXiZI2kukAH1MhCqY1IfN8nCxRUhwyVWRWoBpG
	6f2zYUA8LkUkUgbPFnPDplMBmphhwT85VNbZ94yqNuCJ5BvhUld9wFokZanDt0omYSnd5n0NdIT
	z4E+yrCAS3nQE7iNJbrE1UdWhxbXLQecS4EzLYtA/DLhv4VvDb/ilux3tJ4ilUc5KHuZfZvp3qc
	RVE/iAZrUn5TTo7mRchK7FYazK8DXlHl7mfrx6UZMTTrJU7qcuK+UXFctMu0gc/W3Xmt1qGhc0/
	0NoykXcy1Gm7IocFA8KaFUUEzwIC9uR8ZhsZ4d6l72xUGv0flFN0KuOcyGvppKsfDaqNk7+Aono
	8HUKuU8LrEw5SFa4F5ivT2P00yxqV/NyOo4G9U4O8DKrVE7g==
X-Received: by 2002:a05:7022:223:b0:12c:8e70:c32e with SMTP id a92af1059eb24-12c8e70c78dmr7761080c88.5.1776907257500;
        Wed, 22 Apr 2026 18:20:57 -0700 (PDT)
Received: from localhost.localdomain ([177.81.10.105])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c919266f6sm18139235c88.1.2026.04.22.18.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 18:20:57 -0700 (PDT)
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
Subject: [PATCH v4 2/2] iio: adc: ingenic-adc: use guard()() to handle synchronisation
Date: Wed, 22 Apr 2026 22:18:31 -0300
Message-ID: <20260423012011.41001-3-felipers@ime.usp.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423012011.41001-1-felipers@ime.usp.br>
References: <20260423012011.41001-1-felipers@ime.usp.br>
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
  - Split out ingenic_adc_read_chan_info_raw() logic to helper function.
v4:
  - Adjust code style for better readability.
---
 drivers/iio/adc/ingenic-adc.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index ad1b7bbc059a4..5622b62840e6e 100644
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
 
 static void ingenic_adc_enable_unlocked(struct ingenic_adc *adc,
@@ -201,9 +199,8 @@ static void ingenic_adc_enable(struct ingenic_adc *adc,
 			       int engine,
 			       bool enabled)
 {
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
 	ingenic_adc_enable_unlocked(adc, engine, enabled);
-	mutex_unlock(&adc->lock);
 }
 
 static int ingenic_adc_capture(struct ingenic_adc *adc,
@@ -218,7 +215,7 @@ static int ingenic_adc_capture(struct ingenic_adc *adc,
 	 * probably due to the switch of VREF. We must keep the lock here to
 	 * avoid races with the buffer enable/disable functions.
 	 */
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
 	cfg = readl(adc->base + JZ_ADC_REG_CFG);
 	writel(cfg & ~JZ_ADC_REG_CFG_CMD_SEL, adc->base + JZ_ADC_REG_CFG);
 
@@ -229,7 +226,6 @@ static int ingenic_adc_capture(struct ingenic_adc *adc,
 		ingenic_adc_enable_unlocked(adc, engine, false);
 
 	writel(cfg, adc->base + JZ_ADC_REG_CFG);
-	mutex_unlock(&adc->lock);
 
 	return ret;
 }
@@ -635,7 +631,7 @@ static int ingenic_adc_read_chan_locked(struct ingenic_adc *adc,
 	int cmd, ret, engine = (chan->channel == INGENIC_ADC_BATTERY);
 
 	/* We cannot sample the aux channels in parallel. */
-	mutex_lock(&adc->aux_lock);
+	guard(mutex)(&adc->aux_lock);
 
 	if (adc->soc_data->has_aux_md && engine == 0) {
 		switch (chan->channel) {
@@ -655,7 +651,7 @@ static int ingenic_adc_read_chan_locked(struct ingenic_adc *adc,
 
 	ret = ingenic_adc_capture(adc, engine);
 	if (ret)
-		goto out;
+		return ret;
 
 	switch (chan->channel) {
 	case INGENIC_ADC_AUX0:
@@ -668,11 +664,7 @@ static int ingenic_adc_read_chan_locked(struct ingenic_adc *adc,
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

