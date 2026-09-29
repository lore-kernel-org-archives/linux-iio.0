Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408E1522EF6
	for <linux-iio@vger.kernel.org>; Tue, 29 Sep 2026 12:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685784; cv=none; b=eYcrkCOg6Pb618GmtDdvdr44EqDtG9CQWg6/Oz6VKMx94YCmHBFDbUbRvpMEmrhlQsOjfgFkn0HLXIpwv26t/DT8jNJLu9E8K9aeOJGeAOuMxnR4BVGPMk0/jA/ma90ZmEgiT5NlrU1bufNXRuFdcB69kJN8uS/cSGzluvd1JBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685784; c=relaxed/simple;
	bh=NZNnRBF6zESuKi1IlBtxNb7kgajEGtZphJOytvzHAIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGpAVJBvSREX3lI0QfEbItKDrXv1hUoi7+woGrUALvQZ9rUTNltGu+j289e5HoajzDnN78+7j03cxIxbnHHmzcH6hc/eHkXbxkpYbWrfBSe+tuMH13g1xCuO+xKnFfX9D/jPWisnlnqi5t//A3KjZUapLH9hMeLLPJhxjUo6F/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/1d+8/T; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/1d+8/T"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843f22dcb8so3128375f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 29 Sep 2026 05:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790685777; x=1791290577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QCDGOTeMy2nbmq0YPx9vtyO1CedQPPjJbom9ZFTKnWk=;
        b=S/1d+8/TDIzOYI0Bpkk662fBxthBpp+ikE0hsXfA5x79uT/O8qIk0I5MEkuysgQLc4
         tkj4I1IeiIBI+483AMUVn3o14FVisoQe/nBe0BCl/07l0QuJlD++pYUmUBJ6zVrsPFGS
         iv53eejsGJ3OkO/4/cF08IHTWxBzFB9Dyj+dz4+Ae8jw6UpJMn2cHM6Z859uxKdHVssq
         6ysmSHsBbV2E1h2koyVAG1xtpeEJT++/nSmmBlH04RqAHXv/5M0wmBowyKWQHMiF9ObS
         /rkX1ml+0A/PL3QQuhvfm1e5lnRCATKWeKVIDtH82U7CNiR/GqKWTKczAGWcgcUEAxIS
         GJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790685777; x=1791290577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QCDGOTeMy2nbmq0YPx9vtyO1CedQPPjJbom9ZFTKnWk=;
        b=RWew2xHAUrGEfoMVk6g612SifX0ViOQmDFQDQ00zPiGvQJBxQEE5TbEZ+wHd2j+ozH
         B+08u0jjcAY5fJvEmUTSL/lBQGPInbDIlKveugvTAfNwYExYv1IGc3raBuHBnV47t+aL
         1qTK78hLDycNq4NzVnFarw+sbrXRxvYSSOJ0EHrmNWIbvCdMAMlVsOZ6NXjdgAQtEAEI
         r0SlNMxq26fiIW6PbDGsx5aW8JSpZmomPOcKlpVQPsVH/YEmKV4nhbhXs+fBziorxCy3
         OS8SeI+z2T9H90UDBN2Fy3cjSwK5B1XD5hqhRBWEZgNJWbjI23irmIhyUFqpid3dtIWL
         Q7Vw==
X-Forwarded-Encrypted: i=1; AKwUvBxrSLcFWUyKGvawW4XwxxADR5vdTAQr5yBpJ64w0/m3hLj9nXziW1Kp06nxtcxwKuvCXIjgRoqfHmc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLY2NOdxwp9GjM/jvCNM+MQFf4AUvfFFVy+A0rFfggTatpmfM6j
	SDn2sWSGOZf5apXOZ8fzaixQdK/1mY3IBzgRnlEmAYSR1DmjI3rx3/pA
X-Gm-Gg: AYBFou3m4n6ybhQyW5AAEfFvZo0GutpnXChoczksaXMJuJxnNHHiXIUtHfB3ddVC1Sd
	DXKNYw5tVOZfekuo+7g+gglyvYjff71heZVUjgQiQDyXvqF1HsktG04tGXld50qjW3rrbHSk+zK
	OEJqavs4tZbasKserD7pBQWhlMKVFI8ZbVIyoTljeVn7w/ZVqlNO/pB+Ssx4bcDu0TgKxqvXlck
	ZZgTqCGQL7cM/i+3Ivahuw9HRdAnZZWCeBXhSjg913+Oxeo9n/2G1aaaJoLReLzrrEr6a1WvczS
	JIZ7WSvNQ9qgNg7RGU/uO1JRfbPl9TrjwA5gLx5WzMaalRXQOKXEevkHV0x/kI1Y7wSL/w0Ueck
	ySpEaWJz/sSXy79d2znu2K5SeBCjvojR010Tp0s35YwdxN/mY0Lr3Su8A2i0ZZ9srFfWXgTVzp9
	spNOid2qyYvPk8EbxN0ZDLP+BQa/wJemDKhIlsjG1+WvPC+Gqi74npdfFTihWX+xykVKQYY4P6p
	3JEp+3xFdHrIVe53q6cqTwJd4QWNT69FC67R1UW5/MwYzYfEIjxSiHLSJDGku5n4YEZ6ZAkEeyx
	z7xBIwQy5EgPTcDzAuOXd5PGfGZq
X-Received: by 2002:a05:6000:2a0d:b0:488:7df9:3898 with SMTP id ffacd0b85a97d-4887df93afbmr17135807f8f.56.1790685776127;
        Tue, 29 Sep 2026 05:42:56 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:be4b:8730:c872:1736])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af502da06sm4436630f8f.11.2026.09.29.05.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 05:42:55 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-iio@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5/8] iio: adc: rzt2h: Prepare for SoCs without sample state registers
Date: Tue, 29 Sep 2026 13:42:45 +0100
Message-ID: <20260929124248.237032-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929124248.237032-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260929124248.237032-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Prepare the driver for SoCs that use the same ADC IP without the
per-channel sample state registers present on RZ/T2H.

Add a feature flag for the sample state registers and make the sampling
frequency handling conditional on their presence. Allow each SoC to
provide its own sampling frequency calculation and configure the existing
RZ/T2H support to use the sample state registers and corresponding
calculation.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/iio/adc/rzt2h_adc.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
index 4726f892da23..cf34895928f1 100644
--- a/drivers/iio/adc/rzt2h_adc.c
+++ b/drivers/iio/adc/rzt2h_adc.c
@@ -60,9 +60,13 @@
 #define RZT2H_ADC_STOP_CYCLES		2
 
 #define RZT2H_ADC_FEATURE_CALIBRATION	BIT(0)
+#define RZT2H_ADC_FEATURE_SAMPLE_STATE	BIT(1)
+
+struct rzt2h_adc;
 
 struct rzt2h_adc_chip_info {
 	const struct iio_chan_spec *chan_template;
+	int (*sst_to_freq)(struct rzt2h_adc *adc, u8 sst);
 	unsigned int num_channels;
 	u8 features;
 };
@@ -146,6 +150,9 @@ static void rzt2h_adc_stop(struct rzt2h_adc *adc)
 
 static void rzt2h_adc_set_sst(struct rzt2h_adc *adc, unsigned int ch, u8 sst)
 {
+	if (!(adc->chip_info->features & RZT2H_ADC_FEATURE_SAMPLE_STATE))
+		return;
+
 	writeb(sst, adc->base + RZT2H_ADSSTRn(ch));
 }
 
@@ -526,7 +533,7 @@ static int rzt2h_adc_read_raw(struct iio_dev *indio_dev,
 		*val2 = 12;
 		return IIO_VAL_FRACTIONAL_LOG2;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		*val = rzt2h_adc_sst_to_freq(adc, adc->sst[chan->channel]);
+		*val = adc->chip_info->sst_to_freq(adc, adc->sst[chan->channel]);
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
@@ -541,6 +548,8 @@ static int rzt2h_adc_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ: {
+		if (!(adc->chip_info->features & RZT2H_ADC_FEATURE_SAMPLE_STATE))
+			return -EINVAL;
 		if (val <= 0)
 			return -EINVAL;
 
@@ -730,9 +739,11 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
 	if (!adc->adclk_rate)
 		return dev_err_probe(dev, -EINVAL, "invalid adclk rate\n");
 
-	adc->samp_freq_avail[0] = rzt2h_adc_sst_to_freq(adc, RZT2H_ADC_SST_MAX);
-	adc->samp_freq_avail[1] = 1;
-	adc->samp_freq_avail[2] = rzt2h_adc_sst_to_freq(adc, RZT2H_ADC_SST_MIN);
+	if (chip_info->features & RZT2H_ADC_FEATURE_SAMPLE_STATE) {
+		adc->samp_freq_avail[0] = chip_info->sst_to_freq(adc, RZT2H_ADC_SST_MAX);
+		adc->samp_freq_avail[1] = 1;
+		adc->samp_freq_avail[2] = chip_info->sst_to_freq(adc, RZT2H_ADC_SST_MIN);
+	}
 
 	pm_runtime_set_autosuspend_delay(dev, 300);
 	pm_runtime_use_autosuspend(dev);
@@ -763,8 +774,9 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
 
 static const struct rzt2h_adc_chip_info rzt2h_adc_info = {
 	.chan_template = &rzt2h_adc_chan_template,
+	.sst_to_freq = rzt2h_adc_sst_to_freq,
 	.num_channels = 16,
-	.features = RZT2H_ADC_FEATURE_CALIBRATION,
+	.features = RZT2H_ADC_FEATURE_CALIBRATION | RZT2H_ADC_FEATURE_SAMPLE_STATE,
 };
 
 static const struct of_device_id rzt2h_adc_match[] = {
-- 
2.55.0

