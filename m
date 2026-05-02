Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639092C235E
	for <linux-iio@vger.kernel.org>; Sat,  2 May 2026 23:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777765462; cv=none; b=WWZtaALGcmI/BJyHeB+GTuXIPUJYGiCRbj2o1I/8ysv8fEh0ixbJirrouqrk7Tu1IPv1E9F42B4jTyBLM8MgmanmraoJtFeANanUbboklLbAZ/IiSEDQnlyHRVAZb3oUtKiB1HMEJcmyyXOIdIAPc1owBTH1ZYHkQTCZeZEStds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777765462; c=relaxed/simple;
	bh=iSqxajviyOHivAo9q6qyk/yzGKRNKuhZoxhBaif23IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgvOoyD7esqrWXw4guIeKpYjhkSdyIxJrHHty6fs/9ZPSfI/hOPRcaH6WVu5i8gqTHe7pLt5T3qa9B2cOXdEoSWP1UHjDHZEq28VmqfooF6ioG/mCEODuuZBn+/7Bmd84WCSZqR3SHLj+JikJJrpPaMffQBvXGhlBxLPmln5YYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=XbfOCX5x; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="XbfOCX5x"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-57516e08474so384996e0c.3
        for <linux-iio@vger.kernel.org>; Sat, 02 May 2026 16:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1777765460; x=1778370260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12/Ur8XfYDN0z5IvQ4rDGWszCgGylBbOL6+PCj2xXe8=;
        b=XbfOCX5xn7k9moC7e3Nywl93bN0KqQLPkbSUQrq0wVCKFlcevO2erxMOkNFjbd0Oge
         1FGCPboSLsNuFKWTtYLzlKZ4ge9BtBMo2VzAuGnrhmK4EE5dPz7zqR8cQF9hXQ0oipTU
         wItcPJUUMG1f5AdH2/3UxU2yzW8K/mMpWf6cf/8KWlJ97W2ZmhJ1ugIm8H5r6n1zSbGm
         QPgsUII82I/+mU6SZ/60xb8ba/iRByYQEvAbmpEPgPDdHBDQZbb9kNERiQpaP2NVYZdW
         izBqnZMPc4DcAcNFBrTqFg4QPhqpLrd+47CypBT40WgdnzS6lXRHl3jznskpBW7z4R/z
         7I4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777765460; x=1778370260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=12/Ur8XfYDN0z5IvQ4rDGWszCgGylBbOL6+PCj2xXe8=;
        b=CAoMXt0SA/NoCO5gygJwzM89PaRgt9eou2pXtTkhL+oiY9P1hk7eLkMKt0rYb3z+9O
         cySyq5dejmUy1/6vM0mi/o4V7qbChnPg7rvQujVyX/U3CcKZfU4k4FuyW5ib6fzIgdYF
         XTL2nNo8G3wEnXDA4bdrHIMJawrCiJpk4X0Oq48uGgosBCIcWi82ohN/5jPOK2vIoQ7Y
         6LZMeS0GsJyvjr6ui3squBighZiSkr3uUfS3pRUHiKD87EFKKJ5fTTepaCs71se99SHJ
         Yl9DvjKK4jQy8nvSyv817wOUGcoZY223YrzdSpesu+4dXfgz9guo5Wjm3v4Q6EbwYYXe
         /UCw==
X-Forwarded-Encrypted: i=1; AFNElJ+iyr5Ouchr88Ft4KnXIvnoUyCPnaPwxYRsWgB7j+YB3Z0OJt+PJqBaatNK8ZE9xzwVm2ooHmf+xIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9l87d3CHKvFjUDkCb3yWVLixOMJsvcL8AEtun4DcDhOXYEIN6
	Ay0bSsXAAP1TYKWNqLKQ1f49CQISNqBd+unfhA+OWsq8Vr2OC4osy7mgOgIwkbeiQew=
X-Gm-Gg: AeBDievFZgfc3T8uUmpzszON6C2xWBiG7d1zlDMZribEaONOixrYuFmvD+rtESV3ppu
	LxIyQwY9Trd1M6S9BZ+O8sM5FeVhOE22YANo4auOTlX7ocHTjTNajuHwdcRjo2AmqQxI0jX5SpU
	1Cm0G+vq1qNUmetIlgw5pDaLLo5+g2xOdKVFyW9f3XSdjVHd2liDQUZdhAi1UUuqWLQDhizWgm7
	i6XdGtoeTDTe9SQQQuRyu45q3hqbuHJ2xvca6i9oF5yLWvagizm81Jvn7N7VwDYujGfCtmyBq+j
	NpB/PvxYQFCXH6tlu67F7mQCYZd251PhE2QJT1dZRQ6pgUXQjBNATrKmd74EjmEcqq3X/d3locZ
	LleCYw/Xy1gjwC6//8KyXdCn+74OUHHrzWQNLmB6HkLI5cuwJ4+d/kt6c9+gvGvHSYjI0AOK+wT
	4pGzcDjjMKnaCH4MsdC6JlmuR49evf2V5DmTlK
X-Received: by 2002:a05:6122:8889:b0:575:19a7:ae16 with SMTP id 71dfb90a1353d-57519a7c4edmr548972e0c.11.1777765460339;
        Sat, 02 May 2026 16:44:20 -0700 (PDT)
Received: from gigagabriel-PC ([177.33.85.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5749f7e9f72sm3752167e0c.3.2026.05.02.16.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 16:44:19 -0700 (PDT)
From: Gabriel Braga Lagrotaria <gabrielblo@ime.usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	javier.carrasco.cruz@gmail.com,
	jic23@kernel.org,
	nuno.sa@analog.com
Cc: ricardo.kojo@ime.usp.br,
	elliancarlos@gmail.com,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 2/2] iio: light: veml6030: Generalize hw_init for veml6030 and veml6035
Date: Sat,  2 May 2026 20:41:04 -0300
Message-ID: <20260502234348.131563-3-gabrielblo@ime.usp.br>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260502234348.131563-1-gabrielblo@ime.usp.br>
References: <20260502234348.131563-1-gabrielblo@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify veml6030_hw_init() function to deduplicate the setup logic
for veml6030_hw_init() and veml6035_hw_init(), and remove
veml6035_hw_init().

Additionally, introduce struct veml6030_hw_init_config_desc to store and
pass the custom configuration values specific to each device variation.

Signed-off-by: Gabriel Braga Lagrotaria <gabrielblo@ime.usp.br>
Co-developed-by: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>
Signed-off-by: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>
Co-developed-by: Ellian Carlos <elliancarlos@gmail.com>
Signed-off-by: Ellian Carlos <elliancarlos@gmail.com>
---
 drivers/iio/light/veml6030.c | 92 +++++++++++++++---------------------
 1 file changed, 37 insertions(+), 55 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 3d11e4736330..132ef6136da8 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -82,6 +82,14 @@ struct veml6030_rf {
 	struct regmap_field *gain;
 };
 
+struct veml6030_hw_init_config_desc {
+	const struct iio_gain_sel_pair *gain_sel;
+	int gain_sel_size;
+	int gain_max_scale_int;
+	int gain_max_scale_nano;
+	unsigned int reg_als_conf_value;
+};
+
 struct veml6030_chip_desc {
 	const char *name;
 	const struct iio_chan_spec *channels;
@@ -89,6 +97,7 @@ struct veml6030_chip_desc {
 	const struct reg_field gain_rf;
 	const struct reg_field it_rf;
 	const int max_scale;
+	const struct veml6030_hw_init_config_desc *hw_init_cfg;
 	int (*hw_init)(struct iio_dev *indio_dev, struct device *dev);
 	int (*set_info)(struct iio_dev *indio_dev);
 };
@@ -963,61 +972,21 @@ static int veml6030_regfield_init(struct iio_dev *indio_dev)
 	return 0;
 }
 
+
 /*
  * Set ALS gain to 1/8, integration time to 100 ms, PSM to mode 2,
  * persistence to 1 x integration time and the threshold
  * interrupt disabled by default. First shutdown the sensor,
  * update registers and then power on the sensor.
  */
-static int veml6030_hw_init(struct iio_dev *indio_dev, struct device *dev)
-{
-	int ret, val;
-	struct veml6030_data *data = iio_priv(indio_dev);
-
-	ret = devm_iio_init_iio_gts(dev, 2, 150400000,
-				    veml6030_gain_sel, ARRAY_SIZE(veml6030_gain_sel),
-				    veml6030_it_sel, ARRAY_SIZE(veml6030_it_sel),
-				    &data->gts);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to init iio gts\n");
-
-	ret = veml6030_als_shut_down(data);
-	if (ret)
-		return dev_err_probe(dev, ret, "can't shutdown als\n");
-
-	ret = regmap_write(data->regmap, VEML6030_REG_ALS_CONF, 0x1001);
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
+static const struct veml6030_hw_init_config_desc veml6030_hw_init_config = {
+	.gain_sel = veml6030_gain_sel,
+	.gain_sel_size = ARRAY_SIZE(veml6030_gain_sel),
+	.gain_max_scale_int = 2,
+	.gain_max_scale_nano = 150400000,
+	.reg_als_conf_value = 0x1001,
+};
 
-	return ret;
-}
 
 /*
  * Set ALS gain to 1/8, integration time to 100 ms, ALS and WHITE
@@ -1026,13 +995,22 @@ static int veml6030_hw_init(struct iio_dev *indio_dev, struct device *dev)
  * threshold interrupt disabled by default. First shutdown the sensor,
  * update registers and then power on the sensor.
  */
-static int veml6035_hw_init(struct iio_dev *indio_dev, struct device *dev)
+static const struct veml6030_hw_init_config_desc veml6035_hw_init_config = {
+	.gain_sel = veml6035_gain_sel,
+	.gain_sel_size = ARRAY_SIZE(veml6035_gain_sel),
+	.gain_max_scale_int = 0,
+	.gain_max_scale_nano = 409600000,
+	.reg_als_conf_value = VEML6035_SENS | VEML6035_CHAN_EN | VEML6030_ALS_SD,
+};
+
+static int veml6030_hw_init(struct iio_dev *indio_dev, struct device *dev)
 {
 	int ret, val;
 	struct veml6030_data *data = iio_priv(indio_dev);
+	const struct veml6030_hw_init_config_desc *cfg = data->chip->hw_init_cfg;
 
-	ret = devm_iio_init_iio_gts(dev, 0, 409600000,
-				    veml6035_gain_sel, ARRAY_SIZE(veml6035_gain_sel),
+	ret = devm_iio_init_iio_gts(dev, cfg->gain_max_scale_int, cfg->gain_max_scale_nano,
+				    cfg->gain_sel, cfg->gain_sel_size,
 				    veml6030_it_sel, ARRAY_SIZE(veml6030_it_sel),
 				    &data->gts);
 	if (ret)
@@ -1042,8 +1020,7 @@ static int veml6035_hw_init(struct iio_dev *indio_dev, struct device *dev)
 	if (ret)
 		return dev_err_probe(dev, ret, "can't shutdown als\n");
 
-	ret = regmap_write(data->regmap, VEML6030_REG_ALS_CONF,
-			   VEML6035_SENS | VEML6035_CHAN_EN | VEML6030_ALS_SD);
+	ret = regmap_write(data->regmap, VEML6030_REG_ALS_CONF, cfg->reg_als_conf_value);
 	if (ret)
 		return dev_err_probe(dev, ret, "can't setup als configs\n");
 
@@ -1074,9 +1051,11 @@ static int veml6035_hw_init(struct iio_dev *indio_dev, struct device *dev)
 		return dev_err_probe(dev, ret,
 				     "can't clear als interrupt status\n");
 
-	return 0;
+	return ret;
 }
 
+
+
 static int veml6030_probe(struct i2c_client *client)
 {
 	int ret;
@@ -1167,6 +1146,7 @@ static int veml6030_runtime_resume(struct device *dev)
 static DEFINE_RUNTIME_DEV_PM_OPS(veml6030_pm_ops, veml6030_runtime_suspend,
 				 veml6030_runtime_resume, NULL);
 
+
 static const struct veml6030_chip_desc veml6030_chip = {
 	.name = "veml6030",
 	.channels = veml6030_channels,
@@ -1174,6 +1154,7 @@ static const struct veml6030_chip_desc veml6030_chip = {
 	.gain_rf = VEML6030_GAIN_RF,
 	.it_rf = VEML6030_IT_RF,
 	.max_scale = VEML6030_MAX_SCALE,
+	.hw_init_cfg = &veml6030_hw_init_config,
 	.hw_init = veml6030_hw_init,
 	.set_info = veml6030_set_info,
 };
@@ -1185,7 +1166,8 @@ static const struct veml6030_chip_desc veml6035_chip = {
 	.gain_rf = VEML6035_GAIN_RF,
 	.it_rf = VEML6030_IT_RF,
 	.max_scale = VEML6035_MAX_SCALE,
-	.hw_init = veml6035_hw_init,
+	.hw_init_cfg = &veml6035_hw_init_config,
+	.hw_init = veml6030_hw_init,
 	.set_info = veml6030_set_info,
 };
 
-- 
2.54.0

