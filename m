Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADA237702A
	for <linux-iio@vger.kernel.org>; Wed,  4 Mar 2026 04:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772597860; cv=none; b=immlmuqyj/4zD7bviKZ4ulU6uV12Mn7r4AgefvKFu/RHq2JErFxhW8MJtvJY32zgOKcYiJ8KKkHNBZ/50UftnBRKry2gAStrvWaci3XlN9fi5yYaCwM2u1osWo4EnPzv9p0cnK3UUliWxwtD/VFIx5X9skWcRkapzxbtHlhKv4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772597860; c=relaxed/simple;
	bh=ikTBZYdMphQUTYs7O5y++Y7AZTPNX+0kvonaTugzInk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aQ1yJWuvN+k/nJc7gGpi5cHUhCnVKn9eNPlf65JcbeQfRLpYR55hY7SJrvhfb119VF3Dm3GpvtdPU24fJHgdp/yBx+XiGaGHrd48N8hIgIvMyGJKQZci2uZm3lQgQyPx1obK5T0vEHFbZYd6iL50MyCwBzbIXkbADinfyjV2RWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hA8SHzz2; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hA8SHzz2"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79868eae536so65197947b3.0
        for <linux-iio@vger.kernel.org>; Tue, 03 Mar 2026 20:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772597857; x=1773202657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cj2evDlwnNkzABttd4YNchw6wVbpncuY/X8XS90rCSg=;
        b=hA8SHzz26d5W802FUdjWsWmPZqVA2daaoLeFGmcRxQqAEx0vC7WvnaNmUwgllKlkIa
         Uq2M4OIsI8n+5RQiK26Uq9N787A2acGWH21vE8hT8evy1MvteZGRARdV9KEZcCo5Bmkv
         crA2zkUWI5/64Rvol1H/QelH3pNXCN8dC+ZjvTcz8pSmgMkiWq/bPZseBgYYWzdHy225
         azY9TXal/yyJZiEpm+NsGPKpeOOFts769ITZKLyE6e+cVV0kHBIanF7Gl/25gBotnP8B
         GxALPgKndHMTgOdI5c/F1hJK5HoYHWXbfmhEfWTZVJeOxwkRNcaS/nD5hf6Ian+3jNHr
         krQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772597857; x=1773202657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cj2evDlwnNkzABttd4YNchw6wVbpncuY/X8XS90rCSg=;
        b=nboCNaaXwS7IqvCStVGuVFRVrvGNzbwOII75+5f6lSbPk0irrm9FrS0n3pCeLIpzzJ
         w8pkgRx6VZlwCpGulVjKZiQLj6KCZ/U/H2m6FEAISxMWjJyAePkBz/wqHdX1bxayJSVf
         1z5tYcDVn3RKHL1aOg1oV0BNsmgswi0exgDEpSOSduO/18Po4Ddk6p3vBzhY3ftfcOD7
         BmdbMhuiVH9zMGUZcdSCPIiJtT0vje6zzO609I64FUCva21y9DjeRFKMKo/qMojFUWB2
         Hp6JZ3euOkbG+n0CoeDowmfWpbV8EYXS9AE87ujLLhwfVA0bIitusuugP0omxmDTT3gO
         rSgA==
X-Gm-Message-State: AOJu0YxoNZBcpGLBUUiGMq+zcfB3mDZ6Y5UzRJzuzu4OlX+EDkpGdxrR
	ZXLO30lxSyANZH+8NhubjtO74Odbi13S+sbIRwvhA3I5jH9w3Kyx9IyXEH1hb+HUeS8=
X-Gm-Gg: ATEYQzxyb9kaLeDQj9LXKtivJ7iy/dguFLJNN/i9dv1puw7bSPD++M1vIrdPkwExxH8
	Z4jgLMMvOds1X3v4blrt4Idcj0l9wJdARVZTb3X9g9OKkFdWo2xjdVRPn2lQIsXE521lv+bu7CR
	517oOmirqCLenkN0DJUP1zrrEMVKMlh0L71l3ZCgbhT7HNHdqXL6WoysQoxVy2Apef8jEvf4enR
	aFs5HXye7ku5O5cuzmKSztULJvyMa6fa9KXraTIUynmv3mN+PiyR8Fvz2SsnRJyTBhcDG57uird
	UBLVAaW+1a1OZEMZykmT32Qix40wcnVdAEd28LeugX743AMNomszcmAd/N9ZBhNIgjniybNKoA2
	03wXgclt6PO3us+0x8xl43Ks42R+GcOlqZdizPUm0f0hr+zQQO/lckLPBAd4bIpWHygbKRjOcn4
	QfLOqN+mYN+24hLEabUNdWt3ck149LT3vvypcnE0dYpphWOU9Da7RLhIF0/li/+wCw
X-Received: by 2002:a05:690c:6983:b0:796:371c:7afd with SMTP id 00721157ae682-798c6b8a015mr5803047b3.13.1772597857322;
        Tue, 03 Mar 2026 20:17:37 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876ad9045sm69989297b3.16.2026.03.03.20.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 20:17:35 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Rosen Penev <rosenp@gmail.com>,
	Xichao Zhao <zhao.xichao@vivo.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson SoC support),
	linux-amlogic@lists.infradead.org (open list:ARM/Amlogic Meson SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iio: adc: meson: no devm for nvmem_cell_get
Date: Tue,  3 Mar 2026 20:17:16 -0800
Message-ID: <20260304041716.7631-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no reason to extend the lifetime of this post removal of the
driver when it's only needed in one spot.

Moved tsc_regmap assignment to avoid two nvmem_cell_put calls.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/iio/adc/meson_saradc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 47cd350498a0..ed91edf0e391 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -792,7 +792,7 @@ static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
 	size_t read_len;
 	int ret;
 
-	temperature_calib = devm_nvmem_cell_get(dev, "temperature_calib");
+	temperature_calib = nvmem_cell_get(dev, "temperature_calib");
 	if (IS_ERR(temperature_calib)) {
 		ret = PTR_ERR(temperature_calib);
 
@@ -806,13 +806,9 @@ static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
 		return dev_err_probe(dev, ret, "failed to get temperature_calib cell\n");
 	}
 
-	priv->tsc_regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "amlogic,hhi-sysctrl");
-	if (IS_ERR(priv->tsc_regmap))
-		return dev_err_probe(dev, PTR_ERR(priv->tsc_regmap),
-				     "failed to get amlogic,hhi-sysctrl regmap\n");
-
 	read_len = MESON_SAR_ADC_EFUSE_BYTES;
 	buf = nvmem_cell_read(temperature_calib, &read_len);
+	nvmem_cell_put(temperature_calib);
 	if (IS_ERR(buf))
 		return dev_err_probe(dev, PTR_ERR(buf), "failed to read temperature_calib cell\n");
 	if (read_len != MESON_SAR_ADC_EFUSE_BYTES) {
@@ -820,6 +816,11 @@ static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
 		return dev_err_probe(dev, -EINVAL, "invalid read size of temperature_calib cell\n");
 	}
 
+	priv->tsc_regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "amlogic,hhi-sysctrl");
+	if (IS_ERR(priv->tsc_regmap))
+		return dev_err_probe(dev, PTR_ERR(priv->tsc_regmap),
+				     "failed to get amlogic,hhi-sysctrl regmap\n");
+
 	trimming_bits = priv->param->temperature_trimming_bits;
 	trimming_mask = BIT(trimming_bits) - 1;
 
-- 
2.53.0

