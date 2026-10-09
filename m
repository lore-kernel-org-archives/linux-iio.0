Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3EF5013DC
	for <linux-iio@vger.kernel.org>; Fri,  9 Oct 2026 18:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791571299; cv=none; b=sCQPI2nLtw+iRhc+ONEl0vX5YHx2M3V0eWVLYlb2MWkVVC4td11VtdQ5u+fNOeYdbvHhLsiArsB6mbU1i2XF9ioZJGbavJSLHOhKpNZmY/ApvlRzm3sKMZWoDDiTqzvPF35wbbL7adhaZxlwm61op5pT/1zZmvupHVu8mrx7vEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791571299; c=relaxed/simple;
	bh=X7VpOgMu1Y5jKPx40+Ypu2wTVKETwc5U/eJ7C7lnxyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNp7YKQ63dcb0EMlv4Vw7/t/DONX4s9gCG9UWvL1P2gL/aOBhzKrSo6aX7hdXLrOuvMTSnh8z3egsrNNKXRPyo2yX4dusV7sKwT00GtLaInpVl+vNY4Fx7ADFrVw5lhT8F32/3OjlEopqW7NqOzAd/ziSnYi5yatib2J3TZSazw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjFH+ozE; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjFH+ozE"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a018dc1f98so1143145e9.3
        for <linux-iio@vger.kernel.org>; Fri, 09 Oct 2026 11:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791571291; x=1792176091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IxWSpxCZJ1iKjLEhOrBy/GRrfeHUzPGW6dWhrGGOwL0=;
        b=ZjFH+ozE8HftfFTOn6YzzaTRqB9Yv9xLyCDpLdfy3xHfkZlTjbIa7IRro8v6ec7Xzt
         lnl4lL7LDWbloSAoKZgurN5zUawYdxj9eQEMGnEOlXQEQk8VnnLPlFZi+NzkRO2ro3CB
         lhoUqG2iYDMMT6MG+K8FpEZDYYI7dV+tm2RFStPrpzuPLtUtJfVXMWIwVrvwaguAoD7N
         wnB/pInjV6Y2intMMvC5vHaJ5cJgz/BS+pBVR1hgVpICPjAFR/ny4V9sxo4+G3v3sMOq
         eS46rGcMYL8E863RqLJdTg08aKd6GuDWo/pN1jtkhZNkqg4ialrJOHw4Mmg1QV4z2qwi
         unbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791571291; x=1792176091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IxWSpxCZJ1iKjLEhOrBy/GRrfeHUzPGW6dWhrGGOwL0=;
        b=uZeScazf94j6XkDOD4hnFlqTqZlUVhUZEf4qGo0Dr4uywT7LWOhJB3LQDJDjsku6w1
         EraTwHOAL8E6hetii46bn744QUjufNjs9sZj3wZbwGU+jCiblwdS8KvYplNGnFJtgx88
         epY463w0pPa9X2+LZihQqaB80RVnbtTPzz18wTIsjUnV6XosDixI/LmD7tKzE134Q0ZQ
         Dl6JKmK9jr5Wx1VqSvsYkvPcuhhbozMGr9KDkNN5L3PdqVyIlj+bGdJ2Yc1grf4+yNRY
         +OmJz/53VHkQoxaDW9dsbcr7zVZsCBsxMDXPHKTfkjVPSqm5WwZkUalIxQao84AnulkF
         6smA==
X-Gm-Message-State: AFuF++m6y41YBxHKLFagXs4kXMWY71dU+a6bf2CnKKpJ52koVhAT8KvR
	vJnMstRBnI1BYG5dFTnCJ9t3JN/OVYHxIQDIdgY2g8glbGDtG+We6BD8
X-Gm-Gg: AYBFou3sZUbusYH2Hq7OvOP8wWosY+6kknResz7VW53oXNk9CDqbjk+1j/JlLM3I8dA
	+rwWVo4oTigVoG27cq5N8PTdYpDvPMbLKfT6Why+n5utYf01YaYfJnlnmitmdjAqsnwZwWGwTHD
	iEmOjmiItPV+1Jf8D5pSM/iw6CTzEHte4DjzHfZbJr4VrDHtOUkogmUqswTA2xVjLz6qQ05ikM0
	uX7r0ti9ei/aCvdTBz7iwwxGdvd0v805tZKbKAwF0u/cI2xZsASXVaRLwVXJQaG63Wd0pWhapG8
	rmA3guUmVWuZyN8C8S8W5+85L2UJfe0pelvB75EuI0gjUWKsocQ6Kww0xeh4IrKqj+VfYUdilBO
	+fpcfRQ9YzBz/IskAr5ShfFGFPGL0UCjWU+aPn6LaKdB4xNiakvJWZQYlM7jcSOX3ADGgPGgXqm
	+CuO8XYHEDiSZbsvvLL1pFtVuWmzmRex3Fc1h4y9hExxzi8cC266d/+yuYOIpRb9gqyUrqp6K+0
	xxTeTriAswxeiCNPGhI3hGovm/R54EkbUaOo8CPszB8ygS/lJvTnzyHTPPUhISS3biD57GSCBUV
	sE3GTe9VCm/T4aZcdQ==
X-Received: by 2002:a05:600c:19cf:b0:4a0:1c43:3c04 with SMTP id 5b1f17b1804b1-4a18e4a988dmr50455645e9.13.1791571291106;
        Fri, 09 Oct 2026 11:41:31 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:e93d:161b:5ff8:cb57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18e4225f4sm91761705e9.0.2026.10.09.11.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 11:41:30 -0700 (PDT)
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
Subject: [PATCH v2 2/8] iio: adc: rzt2h: Wait for the analog part to stop after a forced stop
Date: Fri,  9 Oct 2026 19:41:16 +0100
Message-ID: <20261009184122.1378797-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

When ADCSR.ADST is cleared to forcibly stop a conversion, the analog part
of the A/D converter can take up to 2 ADCLK cycles to stop operating.

Wait for the write to ADCSR to complete and allow the analog part to stop
before reconfiguring or restarting the converter.

Fixes: fc3b97dd71ab ("iio: adc: add RZ/T2H / RZ/N2H ADC driver")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- Dropped using DIV_ROUND_UP_ULL to DIV_ROUND_UP
- Included time64.h
---
 drivers/iio/adc/rzt2h_adc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
index 8ba7b0fde8a1..a46726b054b3 100644
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
@@ -124,6 +127,16 @@ static void rzt2h_adc_stop(struct rzt2h_adc *adc)
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
+	ndelay(DIV_ROUND_UP(RZT2H_ADC_STOP_CYCLES * NSEC_PER_SEC,
+			    adc->adclk_rate));
 }
 
 static void rzt2h_adc_set_sst(struct rzt2h_adc *adc, unsigned int ch, u8 sst)
-- 
2.55.0

