Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A763524AEF
	for <linux-iio@vger.kernel.org>; Tue, 29 Sep 2026 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685778; cv=none; b=XksX401DBIfGV8rgYQ2xAH8TI015sWuJx6ndgU0ycmrTt3mF6IA5xGCsmoWtQ9DDmKIVSU1xJpzXBQfkVDQxzw9Fc9XnU7qWP1xeO3yVPwn0VoGbAbeOoBwYFnTJzr93cIbsXT6BbTRSohLkcied46x5LOGaUP+1SlymzsDXcL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685778; c=relaxed/simple;
	bh=N/Fg0ckEM7Ej/EFsFzrgFeUexMpnCOX5K4Eclxi3jsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bVnj/BPxNJIfWQWcVS5VTkcWPCA4bRieuId6RST9TnCLEXa301b7DshYgBBCCGoIaYHmS5/tinwfoGRJh2F1hO0DNGNW3mrn6pqKxItRuMUYl75BCke6Ob9+xoSxwWgyIHIdE+vVBZxsMSJBAQedrUOw/imOVHarMXAdPu8+cGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKG+/2AP; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKG+/2AP"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48af5ae31d8so423353f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 29 Sep 2026 05:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790685774; x=1791290574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CklJvYA4bHZqCaFDmRqhZRi0YHZtTPoVpEjj+VZ/lJo=;
        b=dKG+/2APWwKALQYX/7+jVAtEalR02YF9k4bbYEiPRcEQBrCpPW33q2qDEyi9wpKRWz
         b2CRdW7kqUMpV11zZY1rrKmN0gU3YWHG1irgvES0xD2KlgYAcBZnmIdoVbUl+H5fr7aJ
         Yh0HyTWIIKh4ytrO88wfukb3KMl8gGp2e0pBfts+2yDCbv7VVVKOutmOcy2Sv+s8wfys
         m67mf92UvFgcHwlMT07TtvrdQDq1NYAf2uzpXOqGJ9Fhoe+sng67UAuY4GzSrEsCYLIX
         zUSqTBD5jlzAN2fCcbCoi3MRs1SjpKok66O/oUEdXSrbvkxGOLcrSJxojUToahmU6psB
         A5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790685774; x=1791290574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CklJvYA4bHZqCaFDmRqhZRi0YHZtTPoVpEjj+VZ/lJo=;
        b=TDLFKk5I4fPg1NwQw8ftJEGRmTHG5uqwgqz/62UK1aK6Rq4BdV+LliHZF0izlva2b3
         qHZh+6Bb7LJUtJswojarqndvKdpiK3DTMO8U+BUpbHbwlHEGOifZMgidmVTqymTpB+34
         VS9kJVQBPNPDCBKjhnl+PTQhyVbxi5y0tH3ToxQr0Hs6vBp0qoz6ULuWOGhMw9HbH9/Q
         3aGdluXxstE/qjibJU2ym8vZK++jBks3bu+HhDbamilvvDTgrsvKQ0wS3/Kb6czIQsv9
         K09BvHZBMnvljNKmjZAnu7qUSJmvyM09XsWRDacjoigvQXb7q1hLrxMKakzGXmqoChJQ
         a4KA==
X-Forwarded-Encrypted: i=1; AKwUvByZsCsQ98qahv3Z5F9h/BHjlKOCmxSt6Wsx5orZzSzAcaJF/rG1pqxJQJCZmOJ0tj6dPwAeDS2uZ9A=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCODzwjTVfoMVSrN9SK7Vzm0Brc1jbrVkE3uBWIm6GM5PiOA7e
	tdQcPZWXYDQGtV831YcR4eIAVk/OsOz0yQKCJfrRRkbicfC6rrzsc4ts
X-Gm-Gg: AYBFou0Tn38hOW107rtT3X5BgSdH1mLe3WWB9xekVO8szcFUUOJ+5faqEXx/4TCnDY/
	3WuQ0ovtRMbJH1naX3nKmbg2ugeR2RQFQ2GcgIxkhhGaxxfUdFsjGKZ09o/BmL9d0jXz9EGCbB9
	+vAEFNxVRX2IEZ4QDm+F2jj1jBtfx495b6qWK2XR2TPWKzrnHvwxgfFDYXX+VnfJMyuWDwB75B4
	cd0rFthXojwfGci5YwgOtA+yBOiAa83q1YYWXscrNDapXoTenyXEmlFXw1B7Fp28IstmSBeT83O
	FtT+77qDV8Suk0cQsWt+YKaowX3ITWFQSn7nKmTiJPCpqZBUEyw+9ylCczmYIym5CQOBstAP9CP
	R3Ym8h9kai7ymjX4jqH3pyzjK5er/iH1v6K3q/QkFvtZ1ve9r6Hx1p9V9bFpOeDGCGOWn34lwnA
	65Mv/4eWhYfaGjsvutz555PTqx1jrTraPQKmH2GHr9xiu00pOOxHMQ6+HD2d43PCxrg69+AKlYa
	MTfXipmDgpQyTiVxe7rMe2nGJ0QoimGvJagYgwHw46YtuFjnNLDLLqql1WS0qS7IjLrwtblmN5S
	d009GTLPGXlXW4MkbQ==
X-Received: by 2002:a05:6000:2f83:b0:487:27f9:843 with SMTP id ffacd0b85a97d-4887172a612mr29919339f8f.56.1790685773839;
        Tue, 29 Sep 2026 05:42:53 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:be4b:8730:c872:1736])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af502da06sm4436630f8f.11.2026.09.29.05.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 05:42:53 -0700 (PDT)
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
Subject: [PATCH 2/8] iio: adc: rzt2h: Wait for the analog part to stop after a forced stop
Date: Tue, 29 Sep 2026 13:42:42 +0100
Message-ID: <20260929124248.237032-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

When ADCSR.ADST is cleared to forcibly stop a conversion, the analog part
of the A/D converter can take up to 2 ADCLK cycles to stop operating.

Wait for the write to ADCSR to complete and allow the analog part to stop
before reconfiguring or restarting the converter.

Fixes: fc3b97dd71ab ("iio: adc: add RZ/T2H / RZ/N2H ADC driver")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/iio/adc/rzt2h_adc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
index 8ba7b0fde8a1..d53888730f00 100644
--- a/drivers/iio/adc/rzt2h_adc.c
+++ b/drivers/iio/adc/rzt2h_adc.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/kthread.h>
+#include <linux/math.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -58,6 +59,7 @@
 #define RZT2H_ADC_DMA_BUFFER_SIZE	(RZT2H_ADC_DMA_BUFFER_SAMPLES * \
 					 RZT2H_ADC_MAX_CHANNELS * \
 					 RZT2H_ADC_CHANNEL_BYTES)
+#define RZT2H_ADC_STOP_CYCLES		2
 
 struct rzt2h_adc_dma {
 	struct dma_chan *chan;
@@ -124,6 +126,13 @@ static void rzt2h_adc_stop(struct rzt2h_adc *adc)
 	reg &= ~(RZT2H_ADCSR_ADIE_MASK | RZT2H_ADCSR_ADST_MASK);
 
 	writew(reg, adc->base + RZT2H_ADCSR_REG);
+
+	/*
+	 * When a conversion is forcibly stopped, the analog part of the A/D
+	 * converter takes up to 2 ADCLK cycles to stop operating.
+	 */
+	ndelay(DIV_ROUND_UP_ULL((u64)RZT2H_ADC_STOP_CYCLES * NSEC_PER_SEC,
+				adc->adclk_rate));
 }
 
 static void rzt2h_adc_set_sst(struct rzt2h_adc *adc, unsigned int ch, u8 sst)
-- 
2.55.0

