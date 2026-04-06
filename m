Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACD5322533
	for <linux-iio@vger.kernel.org>; Mon,  6 Apr 2026 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775469212; cv=none; b=PlxoFDSER4E8r2oFRzFukAOWAdKFCkzTNxkKi9L3HYgFuZwXZaIDfKa1x/C6WBO2vQFOcPh6rwq9uM6vt8/fZ8ScDK7STA1KiTVayFKKJTKhcerrTgCD97G9zLaG46JlhhCHEfbmEwNyjIc58iCj1Gm/q4lBjcR07yNlNRqKwtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775469212; c=relaxed/simple;
	bh=p3Z5iwwt2x1cfUh6k4iuWdT2PgE8N5k2s1aejSqeTb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b22bycSk1OFEtKW1HqrAog7tGTKsvQ8fr6BpWWSh0D0nbIDwn6QT9jnkiFjnjjb41uzjbIk5BAMSHRefJPJpaPgnBMhwTXIJ7IHmSn/Nkm2ZHjzI16w7Lrsyj0ICGrKN5p1ID648kWzX5RqI/kXC+UaJZirhs1wuy4gaTRzhFTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0StChN4; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0StChN4"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c6e2355739dso1567825a12.2
        for <linux-iio@vger.kernel.org>; Mon, 06 Apr 2026 02:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775469211; x=1776074011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rrLPu5HoxohUMC5Klt/th0tPKP7dSiS9AP+Vq6CTnZ0=;
        b=h0StChN4KbHSY5g5buTKt05Yt8j3t9RuRPYsspDC/NRJzkx6SLRw6EYvjVn3nUfKzQ
         qQw7Cu0ML5rzH8Q7x1CiObGZqT0m7yzbzcZLsbUmbgnjcs0QBi9xiXSoT9pvOANaUVCD
         aqV2sayoCFY9iRK2tsH3SRuBSUK5zujBl12BlH0PVfIEwlZa4Ci5Q/QHhYNM1ysZKRke
         q4ZcITGFfPDWd8msqDEnYsFppmBg8Ou/CDKpL/Zw+QRNv7UKXCTbJA6Bqqlj6sMbHSLC
         /i+0XaTzcWRiAMARgCAcwmL1luAt8Yh12TvunBuvOH8eFSz5KKfmJ321liwhPQQd5Cec
         bS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775469211; x=1776074011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrLPu5HoxohUMC5Klt/th0tPKP7dSiS9AP+Vq6CTnZ0=;
        b=asHEq5enmnWNhEaoJl7RT+QItP1jB4jFIIp0SvNZMtj3n5CZx9MP4wIJNbdlnnnf2K
         95SMFoKvtGDjdza4aryrrqfaoSdQ4yUOifJ91bp1aMUxIXYacUDwux6cBUHSpXcaxeXZ
         0//80zXnRFqRpABxGNCMI3/1o144AVqB81I9FK354a1zhHQOKFcLm8xFF1+mPahg/drG
         rVu0PvirtNgWMQn2lhHDl/DZKsLvW6TGBx/YnFLxHvEb2bsuhH5eAu0KORfnXoAp8aIg
         4s6MA3w+GXPWjuDKeSmxQhHbq7a0qXkiN5QqKLQ7cDQCfrRwz9n9KxSNdY3OkM+sOloH
         YJTA==
X-Forwarded-Encrypted: i=1; AJvYcCUfT3Og9v6OdV390SiN/HlDWyV470cTltXH6jYl9Ee9zYqmDpdzzGMdupxxT8EvoGPMVl1iS9o25iU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ZzHGIBsT3nWNUBkIbF/gv0eebglLJpL3X/mzVuB9imSHsL7X
	9GfD43DY0uPel9vQYcsfiVcIvyRH9BzAa9b1xHBWx3r71qccyPsbWsQp
X-Gm-Gg: AeBDiev7X4NuBkrZ7cGhc32WTaOKsDUNOoZB6X42XNoR0i6sxG1NhZdvJ7yX0/9OB5c
	QrJRNfgbZsRCVFAz4BmFoIuf4R+Vw5H5P5sytrS4awHZa2SKxbvYN5Meh+ONmWKlXU6rusR+PPg
	iZm4VHx8EHtgjxfiLmShUiKZZ/9ERqPoD7oDWYdnzmcyFMN/UuqOSok9tZEGFoqN+jfyAOeiMvA
	XE4Jr9OZzvhtMwAvZori1LU0P+BQgapUJ2FJu7ldD0eQZBL6BMr1hGFeR1AFoGw5ctYALuDnrom
	S6nIUpo6qSow+n1DjN1+OklH4xH8r5dLgTZ7mCnnydaHY4gEKTh6UgPTcHjv16WBzc50ZZ+aBOE
	WqL8B9w9lfbMozxcTy/z3FPyg7KU7/bqms+5I9jXhTqeJpVJARxbE2Mqr3Ddbqxp0aonwweyKOZ
	4WEFVojzhdxS6qPWVjJXy1DATSQTsOsfK8HYGgJCuXHjGQoqRmisrbXXCMnCu3O6kQrEL0o12aZ
	JcVzWg8bIkHKw68MbbD
X-Received: by 2002:a05:6a20:3d05:b0:39b:fad0:6edc with SMTP id adf61e73a8af0-39f2edaab1emr12537381637.6.1775469211105;
        Mon, 06 Apr 2026 02:53:31 -0700 (PDT)
Received: from localhost.localdomain ([103.129.135.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca1f28sm14214369b3a.57.2026.04.06.02.53.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Apr 2026 02:53:30 -0700 (PDT)
From: Shuvam Pandey <shuvampandey1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuvam Pandey <shuvampandey1@gmail.com>
Subject: [PATCH] iio: adc: nxp-sar-adc: zero-initialize dma_slave_config
Date: Mon,  6 Apr 2026 15:38:24 +0545
Message-ID: <20260406095324.99671-1-shuvampandey1@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nxp_sar_adc_start_cyclic_dma() only fills the RX-side members of
dma_slave_config before passing it to dmaengine_slave_config().

Zero-initialize the structure so unused members do not contain stack
garbage. Some DMA engines consult optional dma_slave_config fields, so
leaving them uninitialized can cause DMA setup failures.

Fixes: 4434072a893e ("iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms")
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
---
 drivers/iio/adc/nxp-sar-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
index 9efa883c277d..7d7b5a580167 100644
--- a/drivers/iio/adc/nxp-sar-adc.c
+++ b/drivers/iio/adc/nxp-sar-adc.c
@@ -659,7 +659,7 @@ static void nxp_sar_adc_dma_cb(void *data)
 static int nxp_sar_adc_start_cyclic_dma(struct iio_dev *indio_dev)
 {
 	struct nxp_sar_adc *info = iio_priv(indio_dev);
-	struct dma_slave_config config;
+	struct dma_slave_config config = {};
 	struct dma_async_tx_descriptor *desc;
 	int ret;
 
-- 
2.50.0

