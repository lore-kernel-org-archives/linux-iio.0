Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778374;
	b=OBbDB/Q+eMDr6Om7++vOtQwTMOsQQWNM4BWG63oyciyhTXWfg5Gu1EktE6CcTnxtzc5l
	 rJJDnM1O8F7tthcdFzT8X8WTqJ8SJMgqI8+ijIEEXOGxwMa5qTs4qF5B2kyHG3BpzJMlu
	 1JUKIrl3W/Pwv5WmSFchzUG2LidrYR7ODlpDy4ZNxs2acz1ZQJy+sAo3+J1jnZIZTXhlr
	 Uj8Qd5DRWaYLmAdYAjgM2aJGp3oUQbx+OrbofPJrJhR5kN610EvhYnPdrsuoqxL6gpCdC
	 fAENw7suGJzOf1waLx+HDrUAqn8oqnSWC/eI9PXtTQOICYDSvmavxFrk0vNfquCAmSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2YMg5NPi7NvaRXzD5WHLcrPWeRT8sqhBxohUakTspaw=;
	b=KRpG/ARB9ep/42bkUrME6rBZ5ssit47G6hsU/qTk12HjMwHFCsf39OvF7upsOJemmgK4
	 B1vtRg2YbBdJ8v4oM1LUIefE/Hw69uYIDsRzzS5rrGXE/4Ap7gyi8Vh4znxC2n/dlO9xU
	 3myp0XhkSd1WUvz+v+hVAPLV+ysfn0Y8ubQLE7qdqvaOqHnSiXlocKnENbZMc/ZFvxjpK
	 0PB+b3kyOPuwOI3Cp5GRwb9SLdn4sLYE1N6F7Do2J77MnWmUqwIzYc4kc+NV5AZ6OhdDo
	 a2M2tJcmp1eggVgFyb/IhpQrmFpwRzFfQ4BmjyfPESkIJ53TW0isWMeuQqLNfKBXF8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="jH/5CyJx";
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82B360A263F
	for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 17:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B82B360A263F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jH/5CyJx
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a215e64962so6349855e9.1
        for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 10:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792778372; x=1793383172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2YMg5NPi7NvaRXzD5WHLcrPWeRT8sqhBxohUakTspaw=;
        b=jH/5CyJxasgvY+0HhkFIIm2P0gmCd6I7Z8tSrHqM2RBWOyvZtww24dtS7KOA51Ut4N
         KaMcTeRuN5SCws1rkHUNAR38QfSLU95B5dSwlw0gxbtXVyW9brsPeEgitDa1uCzyRdsh
         cKX/O8m+QaDZt5xDYBrSJIk3kbOFB9+mVQBJYabTGfvEEb0k7QoKTdXhm1LLC1TOb0SF
         +CvNSLxZxDI2WbqiERTyVu0iPklbrkUApbFf+h93/ynY9z4Ee7J4hTFgmlCnwcA8wNjV
         KZVbRaKp56L9klE+sl0egFwENzL1scaYTKFtwumDEqh+aAIsAUU5p0a7gftDDSuX3B0s
         TpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792778372; x=1793383172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2YMg5NPi7NvaRXzD5WHLcrPWeRT8sqhBxohUakTspaw=;
        b=X8mUgomsa3Md5YYPm8saRQnORmRUhMWU/Vg+fAUw9GIIOd1i4bQxg5N8E8T8OjyJpZ
         zpbUe5+jzJ5H3nKfVx5jRTWP2fJus6T+V4s7vP23nS6qEqjGzSHnt4UvWTEYPF298YC7
         xqRpW2B+tm/XxPDhgnZHsSIGvFdmt6TlPGldJGVS4Oed/R42gTBehmeKFw33Ii7orzN9
         tZ2fJ/bIvsiC7sWHO/ZkKR6nffMkVzJ/yKQoVahX/+KamapMT7sXqBofAu5yEhhaJyIz
         n+9mLYycsBBEwyInNPhubZcTLEY3qUebG6jctWkHVBCCySkTPuNnoQgNXGBNUnNsOg9z
         CWjA==
X-Gm-Message-State: AFq9FYL6zPOyJ59iwVcX3+W7D8EtFxyMq8Pc1/CTUsKdCmC6QbeOGAPp
	YVZnhMCgSYIRt3FJ3ogfBkpzMH3M+wPVvIlPoykicQPH4RCw+KqDribw
X-Gm-Gg: AYBFou2HFHdsoIsDFCyIFvE6JLLOh1nQHVWqHcvu4Ng4wsTg/Blj7KvzSnkWD13s1RN
	RwfmqLPDTLYRWXYjzzrhF2UW0IwNG4J92coN4aNpv1KHVmyZJzGzFGJYBiZYrZrTBXvzIOXylF+
	KFTR3PYnHz2oKSKA+imgupBCxQ1idJE/7jB9Tqj+yFJisM8dR9Phghy9qDlS8FToSlvdcw4PkcX
	ZweBtEI9YZZj5iCemt9pgBwxDnChMCIhtRARS0H8I7UasXk+mftlFiUEEcUjo4ofs4tfQ4JWGoy
	dDUwoc2pr6i858LDghvMcShU9puGx6z5/9Q6WMmsWX4F+88k1HPs3g6essFGQYzom2PpRZOYzI+
	Ex2jBxkvr9aKU8jsfncHcXZ7s7nv6pQNXb2TMj6bBMn6T41HLgkto79mwyIWKeWCs91/POHQev9
	CPBLvJbHUp4S2ptXX8yLEN3LqilTQbTF9L+ssyju3KLqbzEixYGC/kjlQzttz7yUXZL6eUY6Pri
	RmH/Sv5v8tUgFAY/VshApVv3oCPCQYZjgXbI01mMWv7Y8NDH6RG0Bc9cgo7u9QjsP8xcMkDYJCi
	p65fiLtSpDwnxeWSnV9jhmNzeMApQhhyZc2I+AhWoqAke77SOpFE3rbDV4kmoVjIw9xfXlyDGqK
	H7ApshX7wAHpptCH0s2nCZZKr4H0kUcK+zur8U8JzA3Xc
X-Received: by 2002:a05:600c:4715:b0:4a1:9661:14b5 with SMTP id 5b1f17b1804b1-4a211eff69dmr54002725e9.29.1792778371771;
        Fri, 23 Oct 2026 10:59:31 -0700 (PDT)
Received: from iku.example.org (host86-133-9-17.range86-133.btcentralplus.com. [86.133.9.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d37ca2asm1342800f8f.8.2026.10.23.10.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 10:59:31 -0700 (PDT)
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
Subject: [PATCH v3 7/8] iio: adc: rzt2h: Use scan type for ADC scale
Date: Fri, 23 Oct 2026 18:59:18 +0100
Message-ID: <20261023175919.160103-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Prepare the driver for RZ/V2H(P) support, where the ADC supports both
12-bit and 8-bit conversion resolutions.

Use the current IIO scan type to determine the ADC resolution when
reporting the scale instead of assuming a fixed 12-bit resolution.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2->v3:
- No change

v1->v2:
- Renamed RZT2H_ADC_VREF_MV to RZT2H_ADC_VREF_mV
---
 drivers/iio/adc/rzt2h_adc.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
index dbe82939acc2..debd5873ed2a 100644
--- a/drivers/iio/adc/rzt2h_adc.c
+++ b/drivers/iio/adc/rzt2h_adc.c
@@ -60,6 +60,8 @@
 					 RZT2H_ADC_DMA_PERIOD_SAMPLES)
 #define RZT2H_ADC_STOP_CYCLES		2
 
+#define RZT2H_ADC_VREF_mV		1800
+
 #define RZT2H_ADC_FEATURE_CALIBRATION	BIT(0)
 #define RZT2H_ADC_FEATURE_SAMPLE_STATE	BIT(1)
 
@@ -532,10 +534,18 @@ static int rzt2h_adc_read_raw(struct iio_dev *indio_dev,
 
 		return rzt2h_adc_read_single(adc, chan->channel, val);
 	}
-	case IIO_CHAN_INFO_SCALE:
-		*val = 1800;
-		*val2 = 12;
+	case IIO_CHAN_INFO_SCALE: {
+		const struct iio_scan_type *scan_type;
+
+		scan_type = iio_get_current_scan_type(indio_dev, chan);
+		if (IS_ERR(scan_type))
+			return PTR_ERR(scan_type);
+
+		*val = RZT2H_ADC_VREF_mV;
+		*val2 = scan_type->realbits;
+
 		return IIO_VAL_FRACTIONAL_LOG2;
+	}
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*val = adc->chip_info->sst_to_freq(adc, adc->sst[chan->channel]);
 		return IIO_VAL_INT;
-- 
2.55.0

