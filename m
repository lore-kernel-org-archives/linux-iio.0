Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778371;
	b=40wgWlH7D1yNNmATtajQ2wPbUmIqOBRxVQCdRsstzG+dglNSKyYQ7YtHO4OE6MY5Yu8v
	 3kpRk8VlX6LBTak3F3I9ypbxFPP+SBKV429YaVuu40bjKhBPqt/mxucfehTRfHVVvbsDo
	 YUDyvJRajoKVx+cL17bEktqZm3aCdS3lpQ4/uWxjhtWOPoCmp3Y1MI42Plga2BQue4O/2
	 xpUJKa/ujVZE7BWYaq00jZoAidTu0doUlNeG7J6Hsy0X36D+yhUKGmDEHIvhzDPBIzH8T
	 iyOf4nXHbDbGbqoWTsfOTWeqQs3xQok33G4vjYA8ddHuOiEman4QMKZrzHgLwStUnqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778371;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WkiQu/yXLk7Gnv6kxACf+5k/KFRhbQ3OUKruqKRLWhw=;
	b=MgnBYkYSNAdGNKmQY2hMYrf9NEpIrU4L0KWAphF1hJVw2F3RBJryd+tzw/8MLGnE4qij
	 AHAX8vVVxhQgXv/jtebX1RYMBELLUCY2eFq4cCuHde62HxsHH8fJm7VujQj+lUteR2MGs
	 kh+4wfCk+BflTAQgzGLRpjvFbT56/9SugRJPZzzpJvu3kIr6zaaxmiFnBXmuyhnYzTSAr
	 u6KwRfupCwEbU/8lDUEZg9i7SvkAqK17gPkgkGNS/ORa8I4k+kPLWMj8DfxhA2A2KWi9x
	 bPDob8T5xPEBhbHFGaUByrcyIRLR2EkEZL+EKyZp3NRiCjCl4Qu2kWWH7yBCiBIaJeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y4HT7nWn;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C9060A2610
	for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 17:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75C9060A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y4HT7nWn
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-487049569b6so691111f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 10:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792778370; x=1793383170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WkiQu/yXLk7Gnv6kxACf+5k/KFRhbQ3OUKruqKRLWhw=;
        b=Y4HT7nWnZbyR81TXpjXltfD7lHrSeNfFoRs6oIMDkoU4872MTfW4z8CXPzoH/6Wnx3
         Cy/XG5stD7ons84pjJSAPPws5Ak0bo2o3ghh0KGs19aHFVG/WO7fDp5bwU47i3vFPcwl
         1oWDRo/18WCVd3FldUmOovqOmzT9cmDCBvwgOnF/Eczah/DWKerEyCU7MLbQH9Rka0mw
         EhLqr/d2VINXQZ8L8HxSeNIiRsknq12oth4uQC+bFTTEIZsD/Z2qWHCZnql9r8bgFaGB
         IhCDxnIuccKGg4MuNlfJtGuNZ7z1nJWBCphU5TWIeKLFETPnc1GiveSif8a1ZbqOpNKM
         MTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792778370; x=1793383170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WkiQu/yXLk7Gnv6kxACf+5k/KFRhbQ3OUKruqKRLWhw=;
        b=kDHTCrUFRlDBi7t8URL+YfWwgl+SAchBWcuAZSPO1GiAlmhaCInOZ5nH9Yklvibm73
         jfojcQDSMEDO8qvw/kb7f+cEhGuGMb/2SV/swEM/NNzy7zYNrIzePQt1WcZTF6JNA87H
         kGm3rwU/zVRz8AwS65X4MWU2BftAy6M60EA6M0JH2e4TWViJK0edAsQ/KKvwMfeL3m7g
         xgjJduM0pZEKq76Wm3tn8OzZUbPduQ/8BIERsfuucljIrnJjLDGLiCz35ZQhG1qj0GFd
         kVztTMDpdXK4onJez1RdfnuV7yEpVaEe9K9lcdY+lps83o0lv+1+d2p7qTmhqEvKqInN
         C/qA==
X-Gm-Message-State: AFq9FYIqM38oM9Lb3xwrAapsBo3Lx6CcBIi+TSTPQDkvJSkL13ZS4fu9
	KivhtkYm9kWlsqC/87NlhY3DjSHM2g2MeIKLsllnl6qK8m0JYCbPxgnC
X-Gm-Gg: AYBFou0d5yB1rUsrjwLFs2C81mNsQLY2oNdC7jIbigu39jnISlVdcoMedMS8eNI9MTg
	oU3MbIfZaMpkMjdQCbcIwX5S/8PrK4DqWvFqKpDQYDIIY3tM1aLIfBLiNaT6vwplM6k9JxzMC+Y
	TdGCREWmfW6NBN1VPG0XMyQlIQ8qCmumcwKyHJJE0I8snhOj3UW7MD06OwBTh2CfKI7iyMMZ7ff
	hTKgin0AaGwoasUYOhDucOEs/WDJYPz712TFuHukGGJl62jVv43UmchHBrfQS+qXd/+9JOFiiOq
	GluYcRqQvRnrXjn1i+N3mHa+Q2QUbvXxsNAVYE0d6Qz8CsfdFM9ZzYHJ2vOd52LV+VfXs4xylSF
	EeNTf4tee9H3/Bp5zd4BPhJrMhBZgP19Znh+hTcsTv7+MZdae0T1PJWgZGSc9mG1OeQOxbqhGk0
	fZMIG56fZmeRByoTaz2XVHMjs7R2sBhAZrcM37ED072Fr+hChMS2I08QnMCo8cYeSzc6zgQW8R4
	lclbUwd7On74jq5Vzk8ph0YYN8mBlJrO+wT5fFAvinn3BpVctg6dLXhfa6BT1F4jzaNGukPi73G
	TBLC7Vw3bCFfA+eZLdy5Hjr43n3YZXjlar/cYbH1E2l9GvmZcOw6427+YWMuTLIA6cgCvssdFtg
	b2xLRv84n/n0DNZy94Q08CIHYAOyusa3OCNJGoYuhvSHS
X-Received: by 2002:a5d:6f07:0:b0:48d:f0e4:27a4 with SMTP id ffacd0b85a97d-48e385a6073mr5116724f8f.24.1792778369969;
        Fri, 23 Oct 2026 10:59:29 -0700 (PDT)
Received: from iku.example.org (host86-133-9-17.range86-133.btcentralplus.com. [86.133.9.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d37ca2asm1342800f8f.8.2026.10.23.10.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 10:59:29 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
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
Subject: [PATCH v3 5/8] iio: adc: rzt2h: Prepare for SoCs without sample state registers
Date: Fri, 23 Oct 2026 18:59:16 +0100
Message-ID: <20261023175919.160103-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023175919.160103-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261023175919.160103-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
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
v2->v3:
- No change

v1->v2:
- No change
---
 drivers/iio/adc/rzt2h_adc.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
index 51a976f85ae7..94dad479abff 100644
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
@@ -149,6 +153,9 @@ static void rzt2h_adc_stop(struct rzt2h_adc *adc)
 
 static void rzt2h_adc_set_sst(struct rzt2h_adc *adc, unsigned int ch, u8 sst)
 {
+	if (!(adc->chip_info->features & RZT2H_ADC_FEATURE_SAMPLE_STATE))
+		return;
+
 	writeb(sst, adc->base + RZT2H_ADSSTRn(ch));
 }
 
@@ -529,7 +536,7 @@ static int rzt2h_adc_read_raw(struct iio_dev *indio_dev,
 		*val2 = 12;
 		return IIO_VAL_FRACTIONAL_LOG2;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		*val = rzt2h_adc_sst_to_freq(adc, adc->sst[chan->channel]);
+		*val = adc->chip_info->sst_to_freq(adc, adc->sst[chan->channel]);
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
@@ -544,6 +551,8 @@ static int rzt2h_adc_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ: {
+		if (!(adc->chip_info->features & RZT2H_ADC_FEATURE_SAMPLE_STATE))
+			return -EINVAL;
 		if (val <= 0)
 			return -EINVAL;
 
@@ -733,9 +742,11 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
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
@@ -766,8 +777,9 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
 
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

