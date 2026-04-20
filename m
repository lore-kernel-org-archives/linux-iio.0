Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3A93CF681
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 20:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776716119; cv=none; b=INc0ZLbyot2luXM4o4ZgUQ4TKLYqvpqvSxyLCJAwfOWoMdgf4PocoKfyq7fY0kdN7WcmPgwiULZJFhMFd5ogi47gkqbZVIslJIzD3fVMXIbvLAICu0xgU7EvD7XQVdr2LzxlUxWFRrzSqEaNXFj8ihrW6mt6LA625AMmhHvDg0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776716119; c=relaxed/simple;
	bh=+JfPhyebBLdljRTZn0hn+uOoylx5HD58+vg0YhqyWKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZEVPfQYIzW8eO0xrZaSpNvLbeVL+cnjUF/XlB+b2bz7mzYQt9WG1403EbZlr4ibcocFBafw9DtMuAaNzs78mmT1Lc7JyoNIgNSdkTEWPGFOvuPGkXsYmaTpJVYPUSd/nSdkP/NX5evoON3BI0W8eCYSnXJFWbyNCfJOZ6klli7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=O8M7Y/WA; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="O8M7Y/WA"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12c565476d7so7347584c88.1
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 13:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776716115; x=1777320915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9t/6aFcfs98Ybyu515rlXPhB/kM1VW1g5nmRV1baBEk=;
        b=O8M7Y/WAjXwtTalFxRQ4v/cPbnSIFMoWPwnkVeb78euycCbswGIVhHR7x7AjjIKsvc
         Qcc/GlCd2Fj74FicP5ADFC2sYNzAz04TfipTgpmc7ExksOfMMkzQp4iJ5lBBVNI2mRh1
         VCiCUi3lmdmqs2okxpDmOme9MpTzaVlNdr5dI6GOuNn/mH2rw1NOGBGIiPU2/rF02b5J
         RF/eQmTgfVsVssIQtm+nfLE85HfaI4SMS0qoilOmiazW4M9XGXYW52UdtqshH24FKoUh
         cOJmMsifAsPxm1GR/cHeIrMYN5xpHzcg6MdJsMwtH0WYxV3bylZWiHH2ZUGQ1rrwRcDb
         EI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776716115; x=1777320915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9t/6aFcfs98Ybyu515rlXPhB/kM1VW1g5nmRV1baBEk=;
        b=tB7Xmka48o8TLv049tf397dNSANXABYxCgKQx1MTt0GRKhkiVgMzrrfLoyw05iEZbo
         +8Gowb2A1uQ5DUZypZ4Fi7rXQ7AIjpFjG0jDRSGP9S0NYlk6t0Nrbupbp0NyCrjxf8Jl
         zgohyDL60axPfvct4hvsk7jePgG+A5MHWjWfr4lD2mbjsNCoPmd5l8R5oCHjKvi8HUKN
         XLtrRW5RZpDWmIdh2cYiQvMlhRyV5bzDK+p5kplxFCHbo/2pi3lzzMFsYE4LFWQdPu+t
         lTxCgqDpAy8/AsAFCPfPWrMxDI7UBDzhTPJj0moHntZVrzix3C3Or5UqGk6H4YwbKZ6q
         Noyg==
X-Forwarded-Encrypted: i=1; AFNElJ9jS711pI2DtfLPuPJ+rdPlGWuB/YTChmca8GXHKGxcDLMKvHC8yGzZMdpfMzlDs7C62VyUQrIXWlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdBDvDqX3cpF91G6WaDNBMt8Ocw/akLe/T+AVdE5D39KS3cPp8
	wvGro/FakzOErjoV/W07HwkFkazimeTCFN34PxUWErforyZEY5Q/JanevvcvvoKYHPQ=
X-Gm-Gg: AeBDiesjvf5djKaA7QdmoFm4kI77dqlEMxCNPJBrv8fYW8qdyj7cAK5jIHHIP+1t5Ww
	iPkpOegnR5dNOm5es25/ofPSasJwSmk8KlYuzkQPkdUbaTcBtFnnS26nkr4tCD8OaVwUzOAXw1j
	PVJPwwG5yVXg2k7yd1rNC64bchqqSb8HFlVyfcyyggzqB9TZNax8OjqyqRtxe59rvcxV5Emnwe+
	ePCIK0sUhrGnPv2p0/zd9tsqTeNhJHfxXaO+wNDX80j2z8/nd8gBEKtHvZ+/Khkm7c4m/pZaFkN
	zOuzlBa+R3jFenjip7o7QS+LuIXHsgQ3i3SbnJ7NHSOFh6EdCd0alcKHCCq38Az4hDmOFb7lYfL
	XWN2fu0lFvdbl2NYrkGnw7zfUCjvRLdCRECJXfbSBQhO2KeKFzMws2Cyfp4sXeiabIDX6R73KIG
	8vWlt9KbruuG8DsewCUoSsIBBg9HnKTzUpie28
X-Received: by 2002:a05:7022:f9c:b0:11b:88a7:e1b0 with SMTP id a92af1059eb24-12c73fa3ebbmr8973101c88.26.1776716110565;
        Mon, 20 Apr 2026 13:15:10 -0700 (PDT)
Received: from gigagabriel-PC ([177.33.85.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c749c422csm16415009c88.3.2026.04.20.13.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 13:15:10 -0700 (PDT)
From: Gabriel Braga Lagrotaria <gabrielblo@ime.usp.br>
To: javier.carrasco.cruz@gmail.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>,
	Ellian Carlos <elliancarlos@gmail.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: light: veml6030: Generalize hw_init for veml6030 and veml6035
Date: Mon, 20 Apr 2026 17:14:23 -0300
Message-ID: <20260420201441.18055-1-gabrielblo@ime.usp.br>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new veml603x_hw_init() function to deduplicate the setup logic
for veml6030_hw_init() and veml6035_hw_init().

Additionally, introduce struct veml603x_hw_init_config to store and
pass the custom configuration values specific to each device variation.

Signed-off-by: Gabriel Braga Lagrotaria <gabrielblo@ime.usp.br>
Co-developed-by: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>
Signed-off-by: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>
Co-developed-by: Ellian Carlos <elliancarlos@gmail.com>
Signed-off-by: Ellian Carlos <elliancarlos@gmail.com>
---
 drivers/iio/light/veml6030.c | 98 +++++++++++++++---------------------
 1 file changed, 41 insertions(+), 57 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 6bcacae38..84a551683 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -963,19 +963,38 @@ static int veml6030_regfield_init(struct iio_dev *indio_dev)
 	return 0;
 }
 
-/*
- * Set ALS gain to 1/8, integration time to 100 ms, PSM to mode 2,
- * persistence to 1 x integration time and the threshold
- * interrupt disabled by default. First shutdown the sensor,
- * update registers and then power on the sensor.
- */
-static int veml6030_hw_init(struct iio_dev *indio_dev, struct device *dev)
+struct veml603x_hw_init_config {
+	const struct iio_gain_sel_pair *gain_sel;
+	int gain_sel_size;
+	int gain_max_scale_int;
+	int gain_max_scale_nano;
+	unsigned int reg_als_conf_value;
+};
+
+static const struct veml603x_hw_init_config veml6030_hw_init_config = {
+	.gain_sel = veml6030_gain_sel,
+	.gain_sel_size = ARRAY_SIZE(veml6030_gain_sel),
+	.gain_max_scale_int = 2,
+	.gain_max_scale_nano = 150400000,
+	.reg_als_conf_value = 0x1001,
+};
+
+static const struct veml603x_hw_init_config veml6035_hw_init_config = {
+	.gain_sel = veml6035_gain_sel,
+	.gain_sel_size = ARRAY_SIZE(veml6035_gain_sel),
+	.gain_max_scale_int = 0,
+	.gain_max_scale_nano = 409600000,
+	.reg_als_conf_value = VEML6035_SENS | VEML6035_CHAN_EN | VEML6030_ALS_SD,
+};
+
+static int veml603x_hw_init(struct iio_dev *indio_dev, struct device *dev,
+			    const struct veml603x_hw_init_config *cfg)
 {
 	int ret, val;
 	struct veml6030_data *data = iio_priv(indio_dev);
 
-	ret = devm_iio_init_iio_gts(dev, 2, 150400000,
-				    veml6030_gain_sel, ARRAY_SIZE(veml6030_gain_sel),
+	ret = devm_iio_init_iio_gts(dev, cfg->gain_max_scale_int, cfg->gain_max_scale_nano,
+				    cfg->gain_sel, cfg->gain_sel_size,
 				    veml6030_it_sel, ARRAY_SIZE(veml6030_it_sel),
 				    &data->gts);
 	if (ret)
@@ -985,7 +1004,7 @@ static int veml6030_hw_init(struct iio_dev *indio_dev, struct device *dev)
 	if (ret)
 		return dev_err_probe(dev, ret, "can't shutdown als\n");
 
-	ret = regmap_write(data->regmap, VEML6030_REG_ALS_CONF, 0x1001);
+	ret = regmap_write(data->regmap, VEML6030_REG_ALS_CONF, cfg->reg_als_conf_value);
 	if (ret)
 		return dev_err_probe(dev, ret, "can't setup als configs\n");
 
@@ -1019,6 +1038,17 @@ static int veml6030_hw_init(struct iio_dev *indio_dev, struct device *dev)
 	return ret;
 }
 
+/*
+ * Set ALS gain to 1/8, integration time to 100 ms, PSM to mode 2,
+ * persistence to 1 x integration time and the threshold
+ * interrupt disabled by default. First shutdown the sensor,
+ * update registers and then power on the sensor.
+ */
+static int veml6030_hw_init(struct iio_dev *indio_dev, struct device *dev)
+{
+	return veml603x_hw_init(indio_dev, dev, &veml6030_hw_init_config);
+}
+
 /*
  * Set ALS gain to 1/8, integration time to 100 ms, ALS and WHITE
  * channel enabled, ALS channel interrupt, PSM enabled,
@@ -1028,53 +1058,7 @@ static int veml6030_hw_init(struct iio_dev *indio_dev, struct device *dev)
  */
 static int veml6035_hw_init(struct iio_dev *indio_dev, struct device *dev)
 {
-	int ret, val;
-	struct veml6030_data *data = iio_priv(indio_dev);
-
-	ret = devm_iio_init_iio_gts(dev, 0, 409600000,
-				    veml6035_gain_sel, ARRAY_SIZE(veml6035_gain_sel),
-				    veml6030_it_sel, ARRAY_SIZE(veml6030_it_sel),
-				    &data->gts);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to init iio gts\n");
-
-	ret = veml6030_als_shut_down(data);
-	if (ret)
-		return dev_err_probe(dev, ret, "can't shutdown als\n");
-
-	ret = regmap_write(data->regmap, VEML6030_REG_ALS_CONF,
-			   VEML6035_SENS | VEML6035_CHAN_EN | VEML6030_ALS_SD);
-	if (ret)
-		return dev_err_probe(dev, ret, "can't setup als configs\n");
-
-	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_PSM,
-				 VEML6030_PSM | VEML6030_PSM_EN, 0x03);
-	if (ret)
-		return dev_err_probe(dev, ret, "can't setup default PSM\n");
-
-	ret = regmap_write(data->regmap, VEML6030_REG_ALS_WH, 0xFFFF);
-	if (ret)
-		return dev_err_probe(dev, ret, "can't setup high threshold\n");
-
-	ret = regmap_write(data->regmap, VEML6030_REG_ALS_WL, 0x0000);
-	if (ret)
-		return dev_err_probe(dev, ret, "can't setup low threshold\n");
-
-	ret = veml6030_als_pwr_on(data);
-	if (ret)
-		return dev_err_probe(dev, ret, "can't poweron als\n");
-
-	ret = devm_add_action_or_reset(dev, veml6030_als_shut_down_action, data);
-	if (ret < 0)
-		return ret;
-
-	/* Clear stale interrupt status bits if any during start */
-	ret = regmap_read(data->regmap, VEML6030_REG_ALS_INT, &val);
-	if (ret < 0)
-		return dev_err_probe(dev, ret,
-				     "can't clear als interrupt status\n");
-
-	return 0;
+	return veml603x_hw_init(indio_dev, dev, &veml6035_hw_init_config);
 }
 
 static int veml6030_probe(struct i2c_client *client)
-- 
2.53.0

