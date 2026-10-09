Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B27151AFF9
	for <linux-iio@vger.kernel.org>; Fri,  9 Oct 2026 18:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791571302; cv=none; b=jNunxZC4x6AI0FUp1B1dK7PFfoqfIn/dVIaHDJciDTTiWles/LRDHIbGM6IWHP4TOj8mT7f51fgKhkfl5Au3XOh8db0nozYNP3lAR7PuDXPb0JJzFL+LqIKadJ/3s+wTbhhoqY3zr1OAkswnJPA1voVETx3KB/kh/Z6nigJyiZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791571302; c=relaxed/simple;
	bh=cWdSr/HCAYpw9N2hmIHYWZwHbcHbL62T+g3jRZ9hgjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cz7YZeFGJEqwCo1HGicjT8wTg9YHipoh1pi0H5CbPckIaX4b9CgNBxmJIj3nVYby6LaWDit0tQlhMlyLFrM5mUmKFkZKVmjl6GbIsLxfEKSEGePNd3WuYuvXnKqZrv9TsksOcBFMug3YXptn/GpQkYnxS3CFHKj1FInDp0kp1t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icIvWqas; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icIvWqas"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a018dc1f98so1143345e9.3
        for <linux-iio@vger.kernel.org>; Fri, 09 Oct 2026 11:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791571293; x=1792176093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o4hysl45OVBhRRFcK6ukjKkbAyi3VQ7mXgaShYNjelk=;
        b=icIvWqaswIL0xvdbmVeMnaLo3PZoqiV76okaZoItyVcMGyDo80rMvGYyZNAxj53rVi
         /mFuG4CsGkRCO6nnvE0ea1u1tFdHMYOvpOuQeALLpbVMYcfuusRLQNAM/c46ItCtKe9X
         esxCsx2DcWJJaaySQkBSGV618kJkcz+OCXfoO4M7eExn529liW8TlJTnNxg1aXE38xUs
         1qONi1/ZqkPorZYHkV8z2WjDFXIfZCLGMXpv5NSjkJmk2NdLpAjX6UiPTnVmZbDjmx+t
         5SuMbEIbAGIyhGU/b1boCSwFyLLcTXjygNL0Ktr3HjatwKtVmTMICurSQYtLUdX042Ts
         fpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791571293; x=1792176093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o4hysl45OVBhRRFcK6ukjKkbAyi3VQ7mXgaShYNjelk=;
        b=1+ZUlFatt/hHFq07nsTujaPVTDMPc21HLU3XdnfohNnZXJ6bdurIoN3sLJbQJFmxq4
         6TJqft49FMaPS+kpecEI8dWqRyHBGpM2+tEGGDoVUFGEIgDy5uWg3xTGw9Mq0uNNEfHL
         KXxybBQBKiL1dbTmPfAJ83kvSQWuBWrx/7FY7hsuFbn/FeMyTKPCOlc3DrjbHM4bNBRl
         qf16DmZirKWTUoNA05TXKBcDI4emw1bSxOriBlisVBMP45kt7pzGmA8wWUd1c9RA8B4I
         o25SVgF+riL/HG9IOSi0vGlg50Hrk2ppD0ScQzVh/E/TmDjYU+Iht3n6ismCWhIkJykv
         Fa8A==
X-Gm-Message-State: AFuF++niPmGWMX9ct8sWnPlh+T/3Td2RHPl//ZLQ1xl3GPfcLcEsCgnA
	QTUM8KvYIjb8AY4RUbI5jfvIADbjJr992ExjdKhaoP8KAA/xSI9BYJPu
X-Gm-Gg: AYBFou3liKUAeqI7zUMlV2d8EhSw9pPbl1RuUqU9ZPXKuwfiSBE2Yw+/Kk5n8Pg5sUM
	e2F2vT5RC2ZclbCFfJywYQ1OmFVDnpxg+Gik2ACtSRoenie7xYV0nztfx1SKp/eLnEurKMXlcjK
	wuD34Fi3MI1PAqkSBsGgov+/AH2w6KBJe9yKud+MQzHrcxyd6+NT9zmPN001RCvEKZogpCVGnq4
	AUxMHLiBgC501vVsG4ZNmPx473qHEfBrduytY2hMYhLt1oJti+hUox5FFrlb4u1ewE1OBfBNw9l
	OxYHVqRUkI2J6RKYgnSRFL8OeotiJo10IG+w3gvzgce4bQbtekM5isBXR8MIvPBi3BlR2dmnrxT
	F3gXIcawIiGkxDzHtX3sUGC045WH/CBQ1EhCFXCxQHabqUOudOCleuhfQMbfbdrHQW6S1ux9Te6
	/94TSbmlQcxLUhsB4xDgRbGY6m0weVFD1y5ncKe4uXbhkRK/LkXGNrY2mbm3Ps3IXHvNU9Ki0wo
	vrgQ0QkBnWF3IV3QcehMI4lrTGSkOlklxc2+LMNRFDn4lGTKlcewAlVf6YZpRjI9XiScS4cJRPr
	YhD2/kvFiTYG2RFWfA==
X-Received: by 2002:a05:600c:5249:b0:4a0:1b14:e846 with SMTP id 5b1f17b1804b1-4a18e446905mr53912465e9.4.1791571293221;
        Fri, 09 Oct 2026 11:41:33 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:e93d:161b:5ff8:cb57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18e4225f4sm91761705e9.0.2026.10.09.11.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 11:41:32 -0700 (PDT)
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
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 5/8] iio: adc: rzt2h: Prepare for SoCs without sample state registers
Date: Fri,  9 Oct 2026 19:41:19 +0100
Message-ID: <20261009184122.1378797-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009184122.1378797-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261009184122.1378797-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v1->v2:
- No change
---
 drivers/iio/adc/rzt2h_adc.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
index 62120d218515..9f027d524997 100644
--- a/drivers/iio/adc/rzt2h_adc.c
+++ b/drivers/iio/adc/rzt2h_adc.c
@@ -61,9 +61,13 @@
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
@@ -150,6 +154,9 @@ static void rzt2h_adc_stop(struct rzt2h_adc *adc)
 
 static void rzt2h_adc_set_sst(struct rzt2h_adc *adc, unsigned int ch, u8 sst)
 {
+	if (!(adc->chip_info->features & RZT2H_ADC_FEATURE_SAMPLE_STATE))
+		return;
+
 	writeb(sst, adc->base + RZT2H_ADSSTRn(ch));
 }
 
@@ -530,7 +537,7 @@ static int rzt2h_adc_read_raw(struct iio_dev *indio_dev,
 		*val2 = 12;
 		return IIO_VAL_FRACTIONAL_LOG2;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		*val = rzt2h_adc_sst_to_freq(adc, adc->sst[chan->channel]);
+		*val = adc->chip_info->sst_to_freq(adc, adc->sst[chan->channel]);
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
@@ -545,6 +552,8 @@ static int rzt2h_adc_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ: {
+		if (!(adc->chip_info->features & RZT2H_ADC_FEATURE_SAMPLE_STATE))
+			return -EINVAL;
 		if (val <= 0)
 			return -EINVAL;
 
@@ -734,9 +743,11 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
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
@@ -767,8 +778,9 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
 
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

