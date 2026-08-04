Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAC13C5DDE
	for <linux-iio@vger.kernel.org>; Tue,  4 Aug 2026 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863172; cv=none; b=ihennZrQQ35x5mPC8ExHQwlZwEgS8UEV7rtm8W59RM1C19gsBHSWXhE7TSXHEew21JQJ15IDAOrv3uTV0i68qIaJfPKdyUWAomf1gl+LZ5ZYpcW1HQYj9AMMMvQs4fZadAsmUV651ph18xeHXSs3N8y7+hqLHntP8uzqJr/EQKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863172; c=relaxed/simple;
	bh=5C7wceqaQFO2f4qXEFx21ohpcplYEZ+eV+kQkbGuCaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2CLx89sB/uE2fOnLtjrLmQPdO94WJ9a6aho2h4poPLGZyAc2rKsEaZPMd2mdzwTkOLhbQ67/hQSmRoaKt3Kl314kLiZDCgXxXnQKI2C5aeqLzc1JL+MOcwNi0VBGE8qrQus9XLjhd8RAWcUgpu+1lsWG1ZHW3xuL2QZPksCiC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pSJ2aHsB; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pSJ2aHsB"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso51342a91.1
        for <linux-iio@vger.kernel.org>; Tue, 04 Aug 2026 10:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785863159; x=1786467959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+19O7nuCCtomwWmgwH/WqZ+QVpHVmBP+p+odMSd16YE=;
        b=pSJ2aHsBgQ6DL5gi6QbaGjTM6rc/bkTS77S7qjXdRm5uyJu3pWNFErW9ATxgfqSJtP
         Rn1c98RI71BS8AhipDVcryunmUPLsOqtE7P7bGp4FgP6HDJnFxE7x5vQTYoP2FFF6aIH
         ONPCUwKtWkD0L0aUTMH45QFVirmafiBsCmepw+frY33sJz1gzoAShMD/+3lda3iiQFSE
         SwkT9jy408zhbg7vQBXSW2NKA1IzB6Vo2am2lCsVAjcLqSk8Ut8IP1gYF6/Nzl0Mq3EY
         YoJoDmp1Mlk2xBP3yxFe1HYU4N/Zj69RcRakK72f9lHWLNWPXWMDpObS81RLqPbRUw09
         h9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785863159; x=1786467959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+19O7nuCCtomwWmgwH/WqZ+QVpHVmBP+p+odMSd16YE=;
        b=BP4psGGZir69asF0wI6Wshg1uQgldd+rVADvZPNK94aPvIv9mGVBwXDEIAo1wBWulB
         9M07eyi+umTnZT/nsnr27PH9Xnpc8ChmeI97jnxwu4VfHWBDUoZYeIp9g837KV0o0fgm
         xl2Z/ujGRnRXQAaqkJx3U4XixIqitUYdK6E68nAqQiOo2Fq+g0yxV9cGzwhzqb8C9tqR
         7Xi5Jepr7uWYypffotwDtk3tYJCiSR8DU0xZ0F3U3ARMtZinh/F4CKSik+E2grgyrAE4
         gUeWiKV7sWQhAeiT1dG3FWaNzec28ws0TQErQZQArNf4/LmVep4TXHhyg2xg0py76IFO
         QV0Q==
X-Forwarded-Encrypted: i=1; AHgh+RpVTy8PHLJmk3wO7ni1lreesha9X59hvgZdvsXczVUWAONhj777yHw+VC4AjXr8CyxzJiRdWUJWjZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhm3lLCodWilIjQtuaXpS+oHtCWmvlODhQK48zmx29McGLv+qU
	On8PqpR5i1TAVHLbUGc4wEc/znwxIW4LgIxA200Z1yfuxOgSdFFrkApm
X-Gm-Gg: AR+sD11U0IaIXRAg1zUVA+bZPTVqW17jvoam973n4zcBS8cfC8fgkAAwEkeJo7YTTlk
	cz6UPfd31pbx2MAtRqFMyAQxsGIyEpDaivuibmOP1Zf8KkE0pqvVACtBg/JgSBGyemyjsdxRFCS
	fUJysJvHRf3Foft34EGk7CVW1GoyP4gh3fKfJzDVjTCBLT6CQGx5iCKeeS0ky/R8QmXry5F5o4W
	BQrq4ds3ADotqVwka0ElsFQ0SkMEg4pLe3hnguv7Lrs2MBwWiaXUCW3xr7krb+NvyuSSYI1/nYn
	G0JnJdShVI14T3eXRgT5b2Szu4V1/oad1nKQrjuonAEynbBMMLa6eJGuLEkhWEezMqEnMJiMrRf
	VKOr9jt9MmHRU7nTxj45potOwpXybCBaA/lR2W/0TUOAN4sipCoElIKRQekBjDFtvguzioNVUqK
	aWBoWvb6loS2SwfvEsIzSKZ4+AmTRIAE4IvMFFRDcHqgFEGs1OaMG5revqACU=
X-Received: by 2002:a17:90b:5823:b0:38d:dbc7:5178 with SMTP id 98e67ed59e1d1-3903c632441mr378816a91.22.1785863159404;
        Tue, 04 Aug 2026 10:05:59 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:1461:a94d:d559:948d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31586162e80sm7230582eec.0.2026.08.04.10.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 10:05:58 -0700 (PDT)
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
Subject: [PATCH v5 1/3] iio: adc: bcm_iproc_adc: Remove redundant probe error messages
Date: Tue,  4 Aug 2026 22:35:19 +0530
Message-ID: <20260804170521.196393-2-mdshahid03@gmail.com>
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

devm_request_threaded_irq() already logs an error when the request
fails, making the explicit dev_err() redundant.

Similarly, iproc_adc_enable() already reports failures, making the
additional dev_err() in the probe path redundant.

Remove both duplicate messages.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 drivers/iio/adc/bcm_iproc_adc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index cf4738b16e62..7c2e2770cd61 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -551,10 +551,8 @@ static int iproc_adc_probe(struct platform_device *pdev)
 				iproc_adc_interrupt_handler,
 				iproc_adc_interrupt_thread,
 				IRQF_SHARED, "iproc-adc", indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "request_irq error %d\n", ret);
+	if (ret)
 		return ret;
-	}
 
 	ret = clk_prepare_enable(adc_priv->adc_clk);
 	if (ret) {
@@ -564,10 +562,8 @@ static int iproc_adc_probe(struct platform_device *pdev)
 	}
 
 	ret = iproc_adc_enable(indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to enable adc %d\n", ret);
+	if (ret)
 		goto err_adc_enable;
-	}
 
 	indio_dev->name = "iproc-static-adc";
 	indio_dev->info = &iproc_adc_iio_info;
-- 
2.43.0

