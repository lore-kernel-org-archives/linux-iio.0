Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778369;
	b=WdGBsBgoM1Rl+VoswLfIqlmeaO72KhnJQF/tPVsO7G8JjIRp4P/cn76HwiuhhYKERVb5
	 kMbbADrsA43iGpTUN+GhIz1FQoZp8QoYEPoxKMBFUCUqq/Go46ztAPlH1M5XBzdYQZ5rH
	 3s7o1+ftiUEwOKEgkEAIadSwR7tH32zR+m3RwA95ZtWJ9zKj9p4fp/rwyWmbNPcD0guG/
	 cGlR/NkYnUfkuao5tIOJ74u1l+N861swq87KvjaLVeiO/E4TuIZnxWr7+EkI5vHFFxBME
	 WrCvGdUU8eg8rh+FjxSgZ6sGTa+xyl5KzNW4QLeHRwyipNhbFRLgdbu1Le0wplKbKeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778369;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LpC4gMXlTugYajA/SMa/iR8ejQmmRNh7RBHmbQp4ruc=;
	b=F3Q7DiTQB9PjzWxUkdat+zHp1X2VbTRsnAZb0ChSmiegb0ngH+knfFe1QQgucwuiufMm
	 xu8IRj4IL/8UtmNi9OcRmXoYLi/WskT0fCM0LWI2YDsZ8IHMA8eeYyNFaKeaXreD+544+
	 1fLthrz17yn96UjSxPFKZ5HtiFXtUSwyMK/Jxx5KV6cyPpQVvRv5a0tuKK1sxHIEKAGDU
	 v6sum0VBf8ST6nsRG9kaAKdQJj5Nn9TrDjm9R2AlfvdRa1fYOWcw5Aes5WWYIsVWsxnpB
	 OuwaXArGrLE81ASn+sd5okdyPz+8B5yFLRItdnTI8NHQtj4uOUU+X2RGjF118rUSyMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TdotHO0L;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDAB606A330
	for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 17:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FDAB606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TdotHO0L
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso9399465e9.3
        for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 10:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792778368; x=1793383168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LpC4gMXlTugYajA/SMa/iR8ejQmmRNh7RBHmbQp4ruc=;
        b=TdotHO0LUw1mirdK8D1NBjojrI2VmIEU5egfzcux8YEvAuWfygCij3RiEUjE5TnLr+
         WpXsbdXZSHieqpN7o626WlDMX4LW+UwO1k1r7FK28CQpRKVsGCTkmdhAnsfVn1XawLdH
         VrL7GsQe+wE4DJmKu+yInnG+mXRyisWGjIJx3SDTe6Srbq58prtysyLwOoZjJfXUuBP+
         OE9A5kxovZsuX4jgkwq3urr0da7Xwfneug/sNNpWfc6kfkPcRWjeIVYFVmOiw2XlU3yB
         5uKXlSyKeJIS9LiGRwWSITgeo5jsJQ4ZP+ohwWxLHGN72YiKdOPgI+6WgJjycdoRAgh5
         K6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792778368; x=1793383168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LpC4gMXlTugYajA/SMa/iR8ejQmmRNh7RBHmbQp4ruc=;
        b=aXhn4cNv2+xaKPWjBtmrryit5xXkgglMuRdOVuSKDCbtR6zp8CIqaIBfOeOJkOQBC7
         2CURdoO8z5leH1StBZ627pyKF7hsxGcMzkpCVGmJ/0q3c+InSQpVofTHk1HfJCx4jzsa
         fe5MBLiOhkMyJMsSGoBD5c9ixmfj0ETpbf+iCQvf2p11bPGafgccj+p3f/IiflPPpsLr
         cF0zBx+qCeHPJ0D91QHLtFBAiEvaW22YxMOK8LJSaK1kV1lWdL1oukju2KmN9skmDPLc
         M+B7Rhnh2xz3LclaFGAiAAE1U+ndglHZIIE0GnEbeTImdSBUFVC4x3BdBrEb2SSjpSNL
         RIaw==
X-Gm-Message-State: AFq9FYI5bHHjwgrqCPU/Hz7Z3uyGvZmF8Mr2cQoJUI5nxSw2j4x0LW/b
	90kuU8wnySsMk9hJaXGSSbThvh+5WeH2VQqTcpJRsOtvmRZanhAZ9ES9
X-Gm-Gg: AYBFou3pxeix2udptCEoAWEUAIi02bbt+3GFkBy73Ute+RXBs5QLMu8C9mUt0KRz13K
	kko2wOHLiM1Xtsl5NVg1yLSO9b+Sf6soitlH0wmdhKUnNotKA/Rj2P2JePPsyivH5nwhUyl+X4n
	KpCFng1M7Zyl7dkSpPOT5U/46YLj4J7KSQdDqZZP2sdnxdSU6EgKXb0TiuiydrbotyveV+lSCQc
	H2Py06ULCRjRHMgEUpALWyathGVCYDnxOn4xZIrrP6b7SuQphuD9A/1H34tsp9MvRbbXwkk8t7Z
	2FKZuLpniJussnmDfjkzsLkYii4BSinzq7gyDmIbZjflcGOwMF71EdSn2KkP15rdK/RO/P6b2Vx
	NdQPq7UsiIDJvFs1TvSGQGvv3mmq6PzFRyfzSPLvcZfLDemORrOI0sOm/HIcMZzRau62t94i7Qq
	ME3ALMsa2KrfPGT+jnXcBi77dbSK0jLUrJi7/7s2e7YpUYE27vg8PY78fZfVOF0Ori9tQCj4H8z
	bVUPSitc6NnTiOXUBghzFqPVJzPQPcm+7tAczKU4rPkQ/ZJuCJdzhcIlwr1jkvtrCkpfHt8FTPA
	+BNoPvBjG54z64f9nUVpJXfnTXI1Zu5P5VbSpWuCVUJR199NVN6d+GqyptnYL9JztsQO11HQdGj
	Lh2FdF5IFC6dUCoBMnkNJ08gmomii9PRnv5eFO9FURU9l
X-Received: by 2002:a05:600c:4e8a:b0:4a1:e7ce:10a4 with SMTP id 5b1f17b1804b1-4a211eebdc3mr52878955e9.29.1792778367523;
        Fri, 23 Oct 2026 10:59:27 -0700 (PDT)
Received: from iku.example.org (host86-133-9-17.range86-133.btcentralplus.com. [86.133.9.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d37ca2asm1342800f8f.8.2026.10.23.10.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 10:59:27 -0700 (PDT)
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
Subject: [PATCH v3 2/8] iio: adc: rzt2h: Wait for the analog part to stop after a forced stop
Date: Fri, 23 Oct 2026 18:59:13 +0100
Message-ID: <20261023175919.160103-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

When ADCSR.ADST is cleared to forcibly stop a conversion, the analog part
of the A/D converter can take up to 2 ADCLK cycles to stop operating.

Wait for the write to ADCSR to complete and allow the analog part to stop
before reconfiguring or restarting the converter.

Fixes: fc3b97dd71ab ("iio: adc: add RZ/T2H / RZ/N2H ADC driver")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2->v3:
- Avoided splitting up the ndelay calculation into multiple lines

v1->v2:
- Dropped using DIV_ROUND_UP_ULL to DIV_ROUND_UP
- Included time64.h
---
 drivers/iio/adc/rzt2h_adc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
index 8ba7b0fde8a1..131904d97b8c 100644
--- a/drivers/iio/adc/rzt2h_adc.c
+++ b/drivers/iio/adc/rzt2h_adc.c
@@ -15,10 +15,12 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/kthread.h>
+#include <linux/math.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
+#include <linux/time64.h>
 
 #define RZT2H_ADCSR_REG			0x00
 #define RZT2H_ADCSR_ADIE_MASK		BIT(12)
@@ -58,6 +60,7 @@
 #define RZT2H_ADC_DMA_BUFFER_SIZE	(RZT2H_ADC_DMA_BUFFER_SAMPLES * \
 					 RZT2H_ADC_MAX_CHANNELS * \
 					 RZT2H_ADC_CHANNEL_BYTES)
+#define RZT2H_ADC_STOP_CYCLES		2
 
 struct rzt2h_adc_dma {
 	struct dma_chan *chan;
@@ -124,6 +127,15 @@ static void rzt2h_adc_stop(struct rzt2h_adc *adc)
 	reg &= ~(RZT2H_ADCSR_ADIE_MASK | RZT2H_ADCSR_ADST_MASK);
 
 	writew(reg, adc->base + RZT2H_ADCSR_REG);
+
+	/*
+	 * When a conversion is forcibly stopped, the analog part of the A/D
+	 * converter takes up to 2 ADCLK cycles to stop operating. Read back
+	 * ADCSR to make sure the write has reached the hardware before
+	 * starting the delay.
+	 */
+	readw(adc->base + RZT2H_ADCSR_REG);
+	ndelay(DIV_ROUND_UP(RZT2H_ADC_STOP_CYCLES * NSEC_PER_SEC, adc->adclk_rate));
 }
 
 static void rzt2h_adc_set_sst(struct rzt2h_adc *adc, unsigned int ch, u8 sst)
-- 
2.55.0

