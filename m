Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F1C1DE3AD
	for <linux-iio@vger.kernel.org>; Mon, 26 Jan 2026 01:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769391003; cv=none; b=DrEksy4HGNDR1ThrbqtkDC/ff70He2quhTGzQA7+zn3w8XhfIHdZwFJbA1Ne8ME1OvPRgLM+J5iSBE5s1SZ3DpB/OSqQRx0VHfssV0BoIP20JVnUn1bt0RGImjYat2coTE6qTcwfS6BbCD7F7wd/aOw44/05vM3n1x0hJafzX6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769391003; c=relaxed/simple;
	bh=qjqG/4Tak5dcEPBHNEyOcH6tCeLxc2+lSgf0SX/Zx7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DJjdynNGMe1mxMS+NuR8RA3UgwuVYTLUUMnHxrgSllGW0udSn0w+sLXi28b2ZiWblXqns5qFIWZ8J4unN/LZs1SiC7EW8TM786pIicyhdIgqHGBE1Fx8KjZjvZ4NLD2MUWdtH7yi8HSB2x8Ee44bnPF4qgYpU96OCgFvHDFqNk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFGJg/hc; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFGJg/hc"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8230f2140beso1286235b3a.1
        for <linux-iio@vger.kernel.org>; Sun, 25 Jan 2026 17:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769391002; x=1769995802; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oeZfIkWxarijPCx3ki4a4A1AcDxm8HJqYE5e3TeBzjM=;
        b=CFGJg/hctBTDAYj6PwFXi0HR7urLdHoBL2KFJa/zcbuFKtxpvZo9BSRsvUkRL5rw/O
         bQWk1cTB52XErY4EAGy2eFtp95fhsbh8l59fed+0K96oIOXICpvacvgVUXKu8qddWYr0
         DmOhqHWx8VghpIIdt1lf95FKov4XkzuI71T/2SJFR6lt5f5fWxhpEv2AEw4ttSXSCcRd
         t8mFtcXvTv3H9IUAJ7wQV6GlJmchxkyiJLpINkGmAATdCQfGu4ms5K3yAUtPP1dzwU8X
         3GF4CrTCjLrEM5hB7U705YgbYzPLyJTTFQJbYYvOui7V/se9x3Z885ueFieMz42F+d21
         Ntgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769391002; x=1769995802;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oeZfIkWxarijPCx3ki4a4A1AcDxm8HJqYE5e3TeBzjM=;
        b=S06zuG8w0eladALwS1W+QR/b+VOO0g1iLnl5iDxTrWdzhgsGtVBvtKIO6oQVm2pthW
         RngrGdVOpSTvF5NfVjFN9oy736bjd5E87XtjfSljroqLy0KzHCGgblY2Gk24xCuqdiPa
         gMqv3rHnRClQLTUCNgwAyels4MD1LjzVp0PXf2oxYeFoUnnTw2b+X1e7Eei1f2KZQyuX
         ET/qzuRYsXWmZs0VFqrxSipKvdODjc9CTCNBVgabOzPpf2ywL9gTfBg+yI/WvS9mDtey
         X+yLcfB/1mXs8bmrSjFW2A+jEEbkrTq/FMwascrLwjoLl/4ZbnoK6p2RJKnM+cV5l0KI
         +MIg==
X-Forwarded-Encrypted: i=1; AJvYcCXES7vDydYHQYBVOK9hZBLSl4Ey9mbpgFs5ybGhQ3D5GyCmVEYdkPUbQdfEY4ttd6u2sSZSbnYpubU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5rIPq5KrrlW3IdPZC3I2K7g5yzGm7x19NIX58xBLlSqEW1aX1
	v7TJJHNdik416X4sEplubRa+JzpjGlL4vgEcMQT5gHJNB2GANq70JD3/
X-Gm-Gg: AZuq6aLdPNFoOpJppB/sCH9Eh4qxXj37a7kHzhe/wh9zQWkHGKOesBwDMn2wuEbGV0V
	u1WytAI9Gr+X85hMSQbeWXt/GdvNP/kFCLM3sxzBzhfeuIMPcaHTMAmmIODRX20obt/a4I/VaSX
	2RPLlh56+FffHPJEcsUE73nBGt/GjuC3PnKlO9nJBsuTDOuEUGWoMj0wzTK5RyqdC53HXReqLFf
	R11T0c2sieFU4RRDWWBX7sin1rL5QAuE1IC0f6u7tZ3/2rg4uJP0J6CrjHOxd7wEO3b9V+KDFcP
	nGsLwQVidoLVScnaZZrvZ/2WjqfyOjNQvj1xhqFer6LaB5+ZaXJqCF9Yst4gMXjN45+Y+1ve7Gl
	6fHcT1sA50tyAfjrSB0KQALhatBTenl1hgxf/GiV6ouUI4RZQdDqaPBJcs2zgzT6o1fm5n48dkG
	NHhZd9ZR8ytmy9vjQVhLIP+SW24a/hmDc6QAx5t64xbrR1olHdN9CeBljdOHXfGw==
X-Received: by 2002:a05:6a20:c5a7:b0:2ab:a456:9b09 with SMTP id adf61e73a8af0-38e9e528736mr2529581637.15.1769391001759;
        Sun, 25 Jan 2026 17:30:01 -0800 (PST)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c635a1309dfsm7010359a12.6.2026.01.25.17.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 17:30:01 -0800 (PST)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Mon, 26 Jan 2026 09:29:42 +0800
Subject: [PATCH v3 2/2] iio: adc: ltc2309: add support for ltc2305
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-add_ltc2305_driver-v3-2-951349a87f97@gmail.com>
References: <20260126-add_ltc2305_driver-v3-0-951349a87f97@gmail.com>
In-Reply-To: <20260126-add_ltc2305_driver-v3-0-951349a87f97@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4100;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=qjqG/4Tak5dcEPBHNEyOcH6tCeLxc2+lSgf0SX/Zx7w=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBpdsOQCaip7zE/WdM3kQ3WWIUgNU7dYH65hWN8I
 HdLO7QhhACJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCaXbDkAAKCRClg0K3CVbE
 gbiQB/458twWSGoVgfHr7oQIGVWS/4QkrfjL5nO8l+jBP9IX7n8dsKiiHyImU/Z6RyE+BDFV97N
 Ypo1of9SEL61gVzY0kMeYfzuh7wPy+WHDAPEAiB8mFvkvhJaRewI0ktpwLVgKA3WPNU0NzNEhih
 vDHD/a5jZy+5jxW682u/ePnYToZcmPsxZRVOHb6V2e0nbWjEzk9G36hGWDFfG3WkZCyJRq0DHgp
 0ZYJ2MA8umzx2GkwqMeSijHQBwAltQJXmJCrpx6kdkgsTeCV5Uc5cpregJBh5HqYWKmYuy+bonx
 W1oPM6iiu43JA9ayGEAYXkCrUMo6zMMlLKMpUS244EG+aOSb
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Add support for the 2-channel LTC2305 ADC in the existing LTC2309 driver.
The LTC2305 and LTC2309 share similar features: both are 12-bit,
low-noise, low-power SAR ADCs with an I2C interface.
The main difference is the number of channels: LTC2305 has 2 channels,
while LTC2309 has 8 channels.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
 drivers/iio/adc/ltc2309.c | 48 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ltc2309.c b/drivers/iio/adc/ltc2309.c
index 5f0d947d0615..25acf7f5331a 100644
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
@@ -167,13 +202,14 @@ static int ltc2309_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	ltc2309 = iio_priv(indio_dev);
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
@@ -189,13 +225,15 @@ static int ltc2309_probe(struct i2c_client *client)
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

