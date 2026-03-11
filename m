Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC50A36E495
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 01:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773193401; cv=none; b=UfwEoUyiZ0aWm8F8jRC38+FQZOdSKwA5eaxYmObpZ2ElIOD6eLpy2DSDI5c8alCrTH8+TUODJUui/VZ09NOPFoAqCFfNbXiD0lMthu9pwHmGd0qX73cnegBg9c7vNakYAKGS/Kw5+CbKiNz89m5v/iy/yX9DT+MBBbHJ6HFemHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773193401; c=relaxed/simple;
	bh=c3ncRHjPqbbuQR44bPeTenysNBy03mAl4TMqYH6c8IU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sQvecqtThvUdJOA0162CwmKpAisCJ8fMuj3+vY6kvQJ7Q1jiGSrNn5tPH6Jd4SJF2PUQW9Ur1zdrMxlI0jBUy60DMGWqcScPWU7LYNoh9vUtOtlqIM8MysAHwqF3FaJPsOvrGNE5bWp468kYY+DsSkE0xCYP99Zy/plnJUTAk3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaSUAi13; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaSUAi13"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ab39b111b9so60595205ad.1
        for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 18:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773193399; x=1773798199; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=arSk3MF5METJD7gfvRWOJg5AEgnTHp4VPQuj7yMzr6Q=;
        b=eaSUAi1396oHhjNK1ewfMcl7Sc4fmVug9hSla+MKPaF1eypwvV9f1+YR3eVrYHCFYH
         FHfPcS+/EjHAt2yrB0ZDDZ0k3aEZzjXbHlLBOUyxkZes6qt+F169DakTwPuaDz1GLv3E
         j5d3DpLlS+EKsMxoIpmwmJ3raxdtpbEBQ3CVbSkHGUX+c4ynAefUEHztEBtAgqZVS/14
         dBph1EYqIIXHKNig/9696MvGws4K2QJRl8HzzrhvI/o4YcdgAzZ4x3fEu22ktsW4OJQC
         yCuKLSBjffPXJvZvkG4604hS3vi9J3x6SN8ZzldY+UIJLTopYOZb2QiHe9MMG2CkYm87
         LiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773193399; x=1773798199;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=arSk3MF5METJD7gfvRWOJg5AEgnTHp4VPQuj7yMzr6Q=;
        b=ZplL21Lar2E+zXXJvRjA1GEyMmiQ4dzJfkX8B492btE2TFR3sptaLwesjnH2KJ7M/w
         i34GzqnFSqDyW5R77HIrUuXaC7l6gLycabW+3RpVnZaGtp0DBjsUkmLghwjAaj8CG3rr
         WPc+id8coiToeMqmkEIOksWspTYab2aKJfit1r/OKTgas5aF1BuK2cOC8iaYh7UGA26k
         xEX/qWEM7yqKg8rZCykPfshDxdGxGoB1JwZUh0mtiBC7p6vqfesbu5YRd2MbUg8IJeVp
         gJXMNOby1XWw6gBbpTI2G2dFIJGb6uxHE+HluYkPhuZct8TarH5NmKmsGaXM6ZqA4dpI
         EPPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsXOVM6zBqAFxT1quizT70/vhumrsamz4lazCfbFDezU6PZzPDZTB+fhGH7a7oov2eBWLcTxc+15g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp5d9OLhG5pBSU2nNMhhWMntWHsee7D8fL3+uDYkn7kTiAUkxG
	LtG37SFEEbRCPo9u3cDJvUZhkhQqqn/Zl0YYhFz+TLrGmRbZy4GBE2KY
X-Gm-Gg: ATEYQzxasyqrbiMFdt9RpravTDDevQK3eP7NORO7PfjklADr2dUTj6C/SFd039exKh0
	XJE8RRkPcvN0T3M56QtKldNTkdUtLUO0dtMPw0oD0IAR3z0i1Q0j34rJY0K/OUhpuBeWNnABfqr
	7YmMXX7L4ZCgbiYXBqvlcwtJFtMfgG8AiroZkkSBexhA3H2AZbT7zq/X77UjIB03J8WhrpqfUDO
	dfG2ULSTz2WmfkmBY2/GSbBbSeyuiof7QJCiG9V9rTUepkZetRzFsQuE2ltzDjKBXK2qhJ+zEnF
	xe5nk04SBKktKf/SruE8qfvlUeMqyBMapRCLEG9pWfO8ajiRqlwzHSRfD2XYNYrcAMXp0bNnEqm
	jcJj8u6wuXtzHUHRt0j7dvoLn4mtXeoc6dtspIYNdc3ZnPKApecDBN+sJ3RmNapnJmxYbhOhbM/
	ws/xFh+Jcbu7UfjSztwXARG7781sCtx1DVQyN9vGkU8TJDy7qRzKIsiLef+p/ihIs=
X-Received: by 2002:a17:902:ccc9:b0:2ae:62c8:773a with SMTP id d9443c01a7336-2aeae78c1e7mr8633195ad.1.1773193399104;
        Tue, 10 Mar 2026 18:43:19 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae378980sm5219545ad.84.2026.03.10.18.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 18:43:18 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Wed, 11 Mar 2026 09:43:02 +0800
Subject: [PATCH v4 2/2] iio: adc: ltc2309: add support for ltc2305
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-add_ltc2305_driver-v4-2-bc350d347f33@gmail.com>
References: <20260311-add_ltc2305_driver-v4-0-bc350d347f33@gmail.com>
In-Reply-To: <20260311-add_ltc2305_driver-v4-0-bc350d347f33@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hsieh <kylehsieh1995@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4143;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=c3ncRHjPqbbuQR44bPeTenysNBy03mAl4TMqYH6c8IU=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBpsMiucJTCedK6v9d8iBhz2QW7eD94LMW/1+XGf
 nJ4ga0u1fGJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCabDIrgAKCRClg0K3CVbE
 gZBrB/9kqqgUSzcPiCFtTGdERj/8aw/p+ePJpK0rl1f9B6zcNDT0YdMjTCC5zhefQ2RAttVoxR9
 dY33PkHonTzhkvj9+UJXgDkI5vlxn/OyKZvzrxXBvLGJyzQo1V4MgSVe90pib2oPh3uAOQa4jtZ
 qtjC4qjgMFP19jOKeeR05lVNc1QfRt4JrfOrU1x36+YTG5kdN/ZfC+Xr5YB7TsqH2f3eG5WxngE
 fESgrO1yBoPx4gJjL9VhSKAzcUyWKlPfBqpzq5msH67yWxUdn0UCHFLMeluxV43LoHwqlB1THAY
 a8pe9iYVueup2T1HhGa2dNenWufc6hMGv0aHrq9xSQtrZlmd
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Add support for the 2-channel LTC2305 ADC in the existing LTC2309 driver.
The LTC2305 and LTC2309 share similar features: both are 12-bit,
low-noise, low-power SAR ADCs with an I2C interface.
The main difference is the number of channels: LTC2305 has 2 channels,
while LTC2309 has 8 channels.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
 drivers/iio/adc/ltc2309.c | 49 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ltc2309.c b/drivers/iio/adc/ltc2309.c
index 5f0d947d0615..e6c15200a134 100644
--- a/drivers/iio/adc/ltc2309.c
+++ b/drivers/iio/adc/ltc2309.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * The LTC2305 is a  2-Channel, 12-Bit SAR ADC with an I2C Interface.
  * The LTC2309 is an 8-Channel, 12-Bit SAR ADC with an I2C Interface.
  *
  * Datasheet:
+ * https://www.analog.com/media/en/technical-documentation/data-sheets/23015fb.pdf
  * https://www.analog.com/media/en/technical-documentation/data-sheets/2309fd.pdf
  *
  * Copyright (c) 2023, Liam Beguin <liambeguin@gmail.com>
@@ -41,6 +43,13 @@ struct ltc2309 {
 };
 
 /* Order matches expected channel address, See datasheet Table 1. */
+enum ltc2305_channels {
+	LTC2305_CH0_CH1 = 0x0,
+	LTC2305_CH1_CH0 = 0x4,
+	LTC2305_CH0     = 0x8,
+	LTC2305_CH1     = 0xc,
+};
+
 enum ltc2309_channels {
 	LTC2309_CH0_CH1 = 0,
 	LTC2309_CH2_CH3,
@@ -80,6 +89,13 @@ enum ltc2309_channels {
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
 }
 
+static const struct iio_chan_spec ltc2305_channels[] = {
+	LTC2309_CHAN(0, LTC2305_CH0),
+	LTC2309_CHAN(1, LTC2305_CH1),
+	LTC2309_DIFF_CHAN(0, 1, LTC2305_CH0_CH1),
+	LTC2309_DIFF_CHAN(1, 0, LTC2305_CH1_CH0),
+};
+
 static const struct iio_chan_spec ltc2309_channels[] = {
 	LTC2309_CHAN(0, LTC2309_CH0),
 	LTC2309_CHAN(1, LTC2309_CH1),
@@ -99,6 +115,24 @@ static const struct iio_chan_spec ltc2309_channels[] = {
 	LTC2309_DIFF_CHAN(7, 6, LTC2309_CH7_CH6),
 };
 
+struct ltc2309_chip_info {
+	const char *name;
+	const struct iio_chan_spec *channels;
+	int num_channels;
+};
+
+static const struct ltc2309_chip_info ltc2305_chip_info = {
+	.name = "ltc2305",
+	.channels = ltc2305_channels,
+	.num_channels = ARRAY_SIZE(ltc2305_channels),
+};
+
+static const struct ltc2309_chip_info ltc2309_chip_info = {
+	.name = "ltc2309",
+	.channels = ltc2309_channels,
+	.num_channels = ARRAY_SIZE(ltc2309_channels),
+};
+
 static int ltc2309_read_raw_channel(struct ltc2309 *ltc2309,
 				    unsigned long address, int *val)
 {
@@ -158,6 +192,7 @@ static const struct iio_info ltc2309_info = {
 
 static int ltc2309_probe(struct i2c_client *client)
 {
+	const struct ltc2309_chip_info *chip_info;
 	struct iio_dev *indio_dev;
 	struct ltc2309 *ltc2309;
 	int ret;
@@ -167,13 +202,15 @@ static int ltc2309_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	ltc2309 = iio_priv(indio_dev);
+	chip_info = i2c_get_match_data(client);
+
 	ltc2309->dev = &indio_dev->dev;
 	ltc2309->client = client;
 
-	indio_dev->name = "ltc2309";
+	indio_dev->name = chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = ltc2309_channels;
-	indio_dev->num_channels = ARRAY_SIZE(ltc2309_channels);
+	indio_dev->channels = chip_info->channels;
+	indio_dev->num_channels = chip_info->num_channels;
 	indio_dev->info = &ltc2309_info;
 
 	ret = devm_regulator_get_enable_read_voltage(&client->dev, "vref");
@@ -189,13 +226,15 @@ static int ltc2309_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id ltc2309_of_match[] = {
-	{ .compatible = "lltc,ltc2309" },
+	{ .compatible = "lltc,ltc2305", .data = &ltc2305_chip_info },
+	{ .compatible = "lltc,ltc2309", .data = &ltc2309_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ltc2309_of_match);
 
 static const struct i2c_device_id ltc2309_id[] = {
-	{ "ltc2309" },
+	{ "ltc2305", (kernel_ulong_t)&ltc2305_chip_info },
+	{ "ltc2309", (kernel_ulong_t)&ltc2309_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltc2309_id);

-- 
2.34.1

