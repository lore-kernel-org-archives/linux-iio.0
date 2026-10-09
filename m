Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E81E51B168
	for <linux-iio@vger.kernel.org>; Fri,  9 Oct 2026 18:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791571308; cv=none; b=Ui7/ZaPSHzXQfgHaEhgP8WAgc8PLfyNxdqWuR1Qqw2WVIwr5r2axi5q9xzSTq53ccU8LKAbdGEjs14TkLKnIzLYfSJuPSB06424eGcC/fnyTEHHIqNYMd4LnpYSSl1+U/dRsPuCrjjtGh66vtfKDTVdir5ASxTNEodOWi+hxoVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791571308; c=relaxed/simple;
	bh=zWXMbUVBcviqxThu0500QfWeDzEk9IakSPzJWVquazU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gYhQoQR4g9/0MvegKXrL+e1P6TjmmG9CYKhoPaAxIG7t/SD1ifZ3Fv7grPlI/L5AJL3Y0Lk7o7XWpP55Zt64ZegU1iuo3PKr3o/gT/MEUs+bxvw2Wuoc2rgEhch62yJlhLubxtormE04qFchGr9647ilxHUpzrtc+ZMd92X4KCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sFwiRwzk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFwiRwzk"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a166199820so973555e9.1
        for <linux-iio@vger.kernel.org>; Fri, 09 Oct 2026 11:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791571295; x=1792176095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fc2TG1DWHDcQDJr8eEX9rjGsX23Y6ernBWy7IME0Who=;
        b=sFwiRwzkHn/tGbf+4cq9c/jWSzQlNOdB+X7Or4RtzvGWX8R/gBwyasJFF7ZRiyfwGS
         1hlStSKxYNP2AnwKR/+wTo4B6+LgAfwXydegopnCgz2LvNUz0ON+71Mzg2K5A0gO2bfu
         tfKDyq8Wh+R/SSndaZSAFBUQEUZnA6xuB4wWZJDGAv14m5Mu3h9YKza3pIpL5XvLR16s
         uHZl6zYeHRTfimFHQV6wQf7XRvGFAB2VKhpheGsEnbzv3MC73+qqdIUWKYvjmn21AK9D
         twgQsveHitrllGmodd/NHHJtYVwFpFmIo8GTyyo5Nq3AymVVQHczVACu4O5D5xyfIDOn
         VQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791571295; x=1792176095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fc2TG1DWHDcQDJr8eEX9rjGsX23Y6ernBWy7IME0Who=;
        b=WdPdFaci4I5KtwDKE8/WCY8ZS0FdAA+72a4mX4ln9q4coCB2mUyTnWvUQ4WrVsggjp
         qP8JxziqoApVGIoDGN2bKSS0F8cN5TyrY9j3ef/KaO+cOJVJoVLTVsI0YD9WxKTe9Cwe
         bSij8Kz/PZkEK1sNNTnO+5DK/vAeVGPWuqMDqXSqCgPI58ywjIKdfO9327a4ttpumSdF
         V6DKErJC9EOR12NqwF8b6zShMj6+BOMcn4ZNnZnx/tQcCRksq2t2RIkLWsioTqBJE1UA
         iwKdkJdj4f1TqXJ2rCeohIWUuzCKzpZqedhxTm0m2ph9AuztwZf8I/WnfJD/tyqqEKzN
         hw5w==
X-Gm-Message-State: AFuF++kYzC5Sd7a3IxU5QTpmnO5rO4jIpx4m0grdr+fAzap0WXtqQ6rR
	ZjgUogZ6/PXbKocz12duzLUVo933048xt51mRI8x3gA3dv7kFLsaPcPX
X-Gm-Gg: AYBFou2Cu90UJop3OF2HAwEo6DO+iPbDcIk8QmDhMxa42sF/qpDWWu5LNvuMyNd5FVG
	I/1omgmVdg7GatPyVAJGi4ztNs0hMEhwIrVH6JYN2VHWWHcBGqhiAurtnuGKdajCbz/w9/mn6Wm
	/XDnxnNYCj/cnnfR+EWtaHqc7C+lTTAaWWWV+uAxs/MFMaTkzfXOTJg9BInMnGPzomcjbBTgsfs
	E9mflbQSS2VHcaT4BtiJR0M+uSQMT/XVKtceYqiJzMFXRooYf+PqNDkj0Bjk0UEHErCw/cmIPG0
	JAohPphfyplwTuGiC+OcL9odDmm7J59DTXqfN0RNzuJUwHe+FT4l7h17DNHNLxgIDlzYlzMsKlV
	w/AzxC7MMQwtR+SXWN+NqWcy4mKhcPwuxNV1RipqviZuPImw6Wi9bFOPd8gW+lmk4W3iJKQ/q9J
	Nre7NOoGJ4tj3/dHlKKDvxAAk9fQMrmanHBY5QiVy2r0Kcm5DUMjDTf32P5J1l5QiTsOSbgzLdH
	4NiGqqHxlS218carRvuj1tE8ULYBWFzVwQr4vb8p8bQf6vLNCKjYcOvWdb5pyrabRmCa9Cn57SB
	N19Az+QT0xJ05tGQdQ==
X-Received: by 2002:a05:600c:3c89:b0:49f:fc4f:9efb with SMTP id 5b1f17b1804b1-4a18e49105cmr44372635e9.7.1791571294838;
        Fri, 09 Oct 2026 11:41:34 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:e93d:161b:5ff8:cb57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18e4225f4sm91761705e9.0.2026.10.09.11.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 11:41:34 -0700 (PDT)
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
Subject: [PATCH v2 7/8] iio: adc: rzt2h: Use scan type for ADC scale
Date: Fri,  9 Oct 2026 19:41:21 +0100
Message-ID: <20261009184122.1378797-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Prepare the driver for RZ/V2H(P) support, where the ADC supports both
12-bit and 8-bit conversion resolutions.

Use the current IIO scan type to determine the ADC resolution when
reporting the scale instead of assuming a fixed 12-bit resolution.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- Renamed RZT2H_ADC_VREF_MV to RZT2H_ADC_VREF_mV
---
 drivers/iio/adc/rzt2h_adc.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
index 041566f3059d..0703c2025e3f 100644
--- a/drivers/iio/adc/rzt2h_adc.c
+++ b/drivers/iio/adc/rzt2h_adc.c
@@ -60,6 +60,8 @@
 					 RZT2H_ADC_DMA_PERIOD_SAMPLES)
 #define RZT2H_ADC_STOP_CYCLES		2
 
+#define RZT2H_ADC_VREF_mV		1800
+
 #define RZT2H_ADC_FEATURE_CALIBRATION	BIT(0)
 #define RZT2H_ADC_FEATURE_SAMPLE_STATE	BIT(1)
 
@@ -533,10 +535,18 @@ static int rzt2h_adc_read_raw(struct iio_dev *indio_dev,
 
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

