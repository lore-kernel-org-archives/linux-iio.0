Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F487303C87
	for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2026 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777133262; cv=none; b=NfvYBc93jTFuz+ukNIm/shwAqzWe0RhuDED3rac8lO6bPJ6Chj6mnEcKNJhlTufWy0TsOtoyoGhCI8Hv7OKNPaYXwcEmiiP0D8+i/hI/kKw4y1q05NIFvyZACpeulJDkzqTzurcQNuw74LXDiTSqSwVDDDSbw2DGOpSOknB6jbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777133262; c=relaxed/simple;
	bh=KjIIBYWTn6p4BuyO0upgqtz3U+Oi6OBq7Ml4SOzFSuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YJpJ1J//CGuFX0pVMEFQGTBTomGdBBXG22yz6VCLfsiacCOZAnIfON/7sD+8uQum4nPrW4AYtb/zGdd14hjtFpUgFgWkI65ygsNtFxJtazCOhpNexYWcPLBbRk5GOp6/nUC8GJrlhFrMkbT4yaO6Y4gUISeAP0+GuQp/9mILMbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwnx4Kg4; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwnx4Kg4"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso6933520a91.1
        for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2026 09:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777133261; x=1777738061; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iD/M1fyNXTAwfQKzUaSJw2dnydcQ7vF9bXiqIToJulA=;
        b=dwnx4Kg4oL3qsm8cQOj/jwHWPOd81knQl7YAhSXlCG/YsH//95lkIC5TV+mFDgeTM6
         Cmre13h0OkpQTc80DBDNVeSFxGF0dP8PXSkXsdTjWPku8MT30n+KB2U594aXCIfngtq9
         wPEnin3f6hFf7uN8Hs01x0lQptUEY07FjNTvjmXGu0ZAyXeWgEXwq7rpGEsdqsZ5lcAE
         aIQZk4UkHmGG8FAvX1As6tFHvZCQYz3ROG7r9v1voQWChNgTpJAvi64r9khNpqKZHGlI
         //vBKtdBc79EDGwaHpIEOVg34zWSbVJvKY06CCM1rXDmq5+EMFIlxt0FAk1f9Il1eBpK
         H9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777133261; x=1777738061;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iD/M1fyNXTAwfQKzUaSJw2dnydcQ7vF9bXiqIToJulA=;
        b=pqDUkMz//I51ftMu3cXbwimM5RBQl9Q6pfDV083OqIiWlm9xFcSBhNZ0gmacO7XSxp
         MbQtYHkR0qgMB9ZcUymsMmzLfpxLMUy8APhqrMgf6lJV7Nw27pEo+Gf+M4I7EA2SplxA
         n7CHoQikw+EVF/Z+llA56jICDJ30pX9xqbdqK0HIESKz9nnGXqmobEBUaPptZIBLEgvB
         sk5/j1ZA77q8FN2E81uoTIVGjYYtvaPL62B0UY/fm62rqN0whNp1nh+wfHUCp1AhDCgl
         TLcgHNnKeA8HnGZfxHnQcCjbRSoJKpsJGzfaiqAYc3qQWMvpCxESvlz+7K+3s+mVi7bX
         0usw==
X-Gm-Message-State: AOJu0YyTrHLjSOKcodnlb6r/h/oYS++Nm2pXX5G5VNwURoDZieRNQsla
	l7HaChtkY2BacMO4HD9JZDyFe0tY8FlOz9RtDGHsR9uZ2tRnlSz4i+IA
X-Gm-Gg: AeBDiesB8ggkIDYhhUGWOhALphwgcR92S2ZNWXS8U/LqRz1pKms+o0MMpcTp8DVnN0j
	rbuH7iQXPX4MO6lXTuDblkYrwI+qp4T1XH36/6nULYWbHsTlIVmKdaTjpqJ97pexn0g4jXl0bcW
	TIroud0MrVluDbAl1NAUQS+UJMChXes6Mr/j1zNrNIcYvGwY/q7q0tRMBZhnvubw/y6N3SfU9r9
	Nf95Zfjr+zN52y+wQ/lWqU28Z5dHR+ACVUUVJtxxZleHEFeTXWP3dpmMyGxnbf9a9Wsh+4ifyfk
	cHnA/ysYoEq13xGLWAGfrMW/dpslV7PGTSjJzRRQG6q84uDwCZpRzlhmSV0SEDaOG0TRIXRAvg1
	SCLTp4u2T/EeQi4WLjzDLQekptghOszQaJvhIhbnjqL0wWemMTxG6jmdxpNkrr7E1XozQ9LjDnM
	Gf29XovweUSOAILpxWLvErwyQYyYRli72YPplFc42bC27TyiADkzZ0QiWQ/JpIoKX8O6BwPn7Hc
	3FQnlHIRjBuCI5auqguVHYl7wPADEUvMaYg5GvkcQ==
X-Received: by 2002:a17:90b:35d2:b0:35f:bbc0:e570 with SMTP id 98e67ed59e1d1-36140228e16mr38201383a91.0.1777133260516;
        Sat, 25 Apr 2026 09:07:40 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.125])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f8f3e5sm21431182a12.5.2026.04.25.09.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 09:07:40 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sun, 26 Apr 2026 00:07:24 +0800
Subject: [PATCH] iio: adc: meson-saradc: fix calibration buffer leak on
 error
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260426-meson_saradc-v1-1-6e96b2982c43@gmail.com>
X-B4-Tracking: v=1; b=H4sIALvm7GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyNT3dzU4vy8+OLEosSUZF1Tk8SkZFOjFMskY0MloJaCotS0zAqwcdG
 xtbUA8wWlq14AAAA=
X-Change-ID: 20260425-meson_saradc-54abc52d9b31
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rosen Penev <rosenp@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777133256; l=2229;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=KjIIBYWTn6p4BuyO0upgqtz3U+Oi6OBq7Ml4SOzFSuc=;
 b=Vjn5Dax+7/hZTXWQgOoS9q3jBjBGAaFI0EgVquwXjkkRPefUzhwtIOndDXMCrGBT4d0Tqueia
 Q0c34yJMIvXARu6F1W6/gneXeBQgC3XHQ9lvOdScnQGncIwqotb2Oua
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

meson_sar_adc_temp_sensor_init() allocates a buffer with
nvmem_cell_read(), but the old code leaked it if
syscon_regmap_lookup_by_phandle() failed.

Switch buf to __free(kfree) so all return paths release it.

Fixes: d6f2eac64403 ("iio: adc: meson: no devm for nvmem_cell_get")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/iio/adc/meson_saradc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 23991a3612bd..9708ddcc4919 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -786,7 +786,7 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
 static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
-	u8 *buf, trimming_bits, trimming_mask, upper_adc_val;
+	u8 trimming_bits, trimming_mask, upper_adc_val;
 	struct device *dev = indio_dev->dev.parent;
 	struct nvmem_cell *temperature_calib;
 	size_t read_len;
@@ -807,14 +807,12 @@ static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
 	}
 
 	read_len = MESON_SAR_ADC_EFUSE_BYTES;
-	buf = nvmem_cell_read(temperature_calib, &read_len);
+	u8 *buf __free(kfree) = nvmem_cell_read(temperature_calib, &read_len);
 	nvmem_cell_put(temperature_calib);
 	if (IS_ERR(buf))
 		return dev_err_probe(dev, PTR_ERR(buf), "failed to read temperature_calib cell\n");
-	if (read_len != MESON_SAR_ADC_EFUSE_BYTES) {
-		kfree(buf);
+	if (read_len != MESON_SAR_ADC_EFUSE_BYTES)
 		return dev_err_probe(dev, -EINVAL, "invalid read size of temperature_calib cell\n");
-	}
 
 	priv->tsc_regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "amlogic,hhi-sysctrl");
 	if (IS_ERR(priv->tsc_regmap))
@@ -835,8 +833,6 @@ static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
 	priv->temperature_sensor_adc_val |= upper_adc_val << BITS_PER_BYTE;
 	priv->temperature_sensor_adc_val >>= trimming_bits;
 
-	kfree(buf);
-
 	return 0;
 }
 

---
base-commit: 7080e32d3f09d8688c4a87d81bdcc71f7f606b16
change-id: 20260425-meson_saradc-54abc52d9b31

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

