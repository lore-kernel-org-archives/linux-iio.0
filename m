Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC4335DA68
	for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787236360; cv=none; b=XldKm/pVYXUPdwM+AGoePFdE7kwWfNVA7Hirnn3tfWhpVvLU2cm9FPLKKXAsGkEUQF7RqYNXlMey1rv+TA8sPj3Hk6HDrNnbnhrU/DPtkW5ThExv4SNn1fAku22DVHrhCzw6j8erXl657rYtwAavxOufyD+OwgnrhSARUY2SnY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787236360; c=relaxed/simple;
	bh=UYAG8scIKHog05RozGPXp8+bn3honIbHODh1cjp75xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GWzyfPeprH8Zri6/GH2lO86Ekosf6Cj+lracWbfhS8q+J3MyRkXCuhvRaZ0oFx8tEyecG0kcPy3DxSbtEDpJqMFE98jV1rp0eLCEfqkfwxaKakODz/PUYhZR8vfOsjqqykGf9gpoirTSuiebGxidkdGkyclHR1ph8V2Au6d6LSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RB+ZEdfq; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RB+ZEdfq"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5c27e38ee18so1385408e0c.1
        for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 07:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787236357; x=1787841157; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dMAMky95vhwY2GpQOZwt4ADrs1Y3YEhuvL0J2CFisxE=;
        b=RB+ZEdfqQp/jMqNjx2X2d9nV1ritf1f8U+oT5acVEqTYA1w7nOOzik0DznI/eqC41g
         XqBPQ5deafAJQaiiAaWibVnzUcrehGiClT65dWCn7vfCYDIT9Y5zYee4PzMW7U4EJHe1
         6iOMzsKnrJd9R+nRQsHzPvB9ClwkTkEObVdSLNiBGDch6VWZtgjOdh1DJYME7u8RnRPh
         w5BBXeNA3uV/4um8Ov2a+l2wzYNHfcy1+5zAYJMNf4NAC8XarZBWv6fLxqfxT3DZzh3Q
         3B/VnemDFyhzgdQGlAoQzJgd7Q2hriidFQxb0AdSd321RScnteiWoeDdMN5YyiIKJSoO
         WGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787236357; x=1787841157;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dMAMky95vhwY2GpQOZwt4ADrs1Y3YEhuvL0J2CFisxE=;
        b=FFxZykqu0LMVMbGodPTcDI8ez/exXvXCJfkiSwZ/yA6ju3jytWjkHebXmw0D6rC4bx
         Ct2gsv7Y0l0ivC4A0p95SKADSZSsQG55S7ldTtQoqF/Qq+SGMsWa0ElnS343gjGj5ozZ
         Pv7nG9SxmGYyAc7YfXBRdP2MfUCyqbhWpmadV92uv3OWHbcDmfz6fV0v9nC1OF9cPKSQ
         S5FVAukFzpqbFlCGLmmOYc5sDE+yhCSfE+NdlB2PKK57iPOOZGVD7d5N8ZJXV4Q05iTR
         dtxmy0krvxRJ9y4z0vbQPmaNHV8I4epAK3rKcGx8at++uZ4NJHdM4PxPnZWOTjceFOAU
         shZA==
X-Forwarded-Encrypted: i=1; AHgh+RpkEy2EI/Ntspo173GuW+Eqs6H/c26rkKiKMwqhfslS+butXAAGsUHpvH0beMPqa87QUMm9mM0XhyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlRRTU5H4i4jwS+4/qM22tp6r8xOA6Wcjd0QauK7iJb1h2NKdj
	uUD6fFQ19eO5Mr2j0N7k8PQLye7TkvVLj8lCunh1pEg194R2Og2V/xU=
X-Gm-Gg: AR+sD100+r33Y2olnB0lnE1WRPCoBc/gZ9Nj6SFw8Ga4SuJX2RRINyvotK9t6eDjiG1
	26JxOA59MgXBeXBK46KDaiFikaBESbdO1EmTxlH39zkVT8lPRgW8qBtxcc+l+JBfrYi3HV3P6t6
	Ed45e/ZHdbh67E+kL217ZT8aCZw73tkABkwkY0ZcEMKVerVf5kGjG0DcL/7jwG3yi/XcbJFni4A
	RUu28pqyAY4RdkenZr2HTzIxIuPj6b7mrEhklmxsE/hDv8GVib/byN1VevfZE4WvyRm9PTfn+4Z
	8eOgbK8mih3mmpARiCyzGgiTmS7DUmeY3ib11dQB+amhD6J1qAX7oqb0VXdWal5WqW0NaI3332a
	JsFvChAUOgJtvKicvFT8T2eOtAtzq7ad6DTTJIRfb/ueyoLf9q2u4vWxxeLLM9C7A62A3T5yJJZ
	5AZbGt+wKCdbFpONiJQ7KYAqz0FPXRYm2SkRbZNjylL/LFHU4OwkYe/3RwxgkFv4JOAJ3ybyrAl
	WWwItcnAq61dx3INm3tj+oSgO0Dfa6l2PU7gUPT
X-Received: by 2002:a05:6122:4f99:b0:5bf:9bfa:53a0 with SMTP id 71dfb90a1353d-5c5e3b676admr6134085e0c.1.1787236357265;
        Thu, 20 Aug 2026 07:32:37 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5e25e3459sm6393922e0c.4.2026.08.20.07.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 07:32:36 -0700 (PDT)
From: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v4 2/2] iio: humidity: am2315: add support for am2320
Date: Thu, 20 Aug 2026 11:31:10 -0300
Message-ID: <e831d50c53b4c4c0fc0f201c6ef6bf90c0a15629.1786973355.git.nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1786973355.git.nico.antinori.7@gmail.com>
References: <cover.1786973355.git.nico.antinori.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The AM2320 design is fully compatible with AM2315 in terms of I2C
communication protocol and measurement conversions.

Add the "am2320" entry to the i2c_device_id table and register a
of_device_id table to match against devices declared in device tree.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>
---
 drivers/iio/humidity/Kconfig  |  8 +++++---
 drivers/iio/humidity/am2315.c | 34 +++++++++++++++++++++++++++++-----
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
index 54f11f000b6f..13e267943f67 100644
--- a/drivers/iio/humidity/Kconfig
+++ b/drivers/iio/humidity/Kconfig
@@ -5,13 +5,15 @@
 menu "Humidity sensors"

 config AM2315
-	tristate "Aosong AM2315 relative humidity and temperature sensor"
+	tristate "Aosong AM2315 and similar relative humidity and temperature sensor"
 	depends on I2C
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-	  If you say yes here you get support for the Aosong AM2315
-	  relative humidity and ambient temperature sensor.
+	  If you say yes here you get support for the Aosong relative
+	  humidity and ambient temperature sensors:
+	  - AM2315
+	  - AM2320

 	  This driver can also be built as a module. If so, the module will
 	  be called am2315.
diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
index f29baa251f9f..5c7582f3a4f9 100644
--- a/drivers/iio/humidity/am2315.c
+++ b/drivers/iio/humidity/am2315.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Aosong AM2315 relative humidity and temperature
+ * Aosong AM2315 and similar relative humidity and temperature
  *
  * Copyright (c) 2016, Intel Corporation.
  *
@@ -27,7 +27,17 @@
 #define AM2315_TEMP_OFFSET			4
 #define AM2315_ALL_CHANNEL_MASK			GENMASK(1, 0)

-#define AM2315_DRIVER_NAME			"am2315"
+struct am2315_chip_info {
+	const char *name;
+};
+
+static const struct am2315_chip_info am2315_chip_info = {
+	.name = "am2315",
+};
+
+static const struct am2315_chip_info am2320_chip_info = {
+	.name = "am2320",
+};

 struct am2315_data {
 	struct i2c_client *client;
@@ -220,9 +230,14 @@ static const struct iio_info am2315_info = {
 static int am2315_probe(struct i2c_client *client)
 {
 	int ret;
+	const struct am2315_chip_info *chip_info;
 	struct iio_dev *indio_dev;
 	struct am2315_data *data;

+	chip_info = i2c_get_match_data(client);
+	if (!chip_info)
+		return -ENODATA;
+
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -233,7 +248,7 @@ static int am2315_probe(struct i2c_client *client)
 	mutex_init(&data->lock);

 	indio_dev->info = &am2315_info;
-	indio_dev->name = AM2315_DRIVER_NAME;
+	indio_dev->name = chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = am2315_channels;
 	indio_dev->num_channels = ARRAY_SIZE(am2315_channels);
@@ -249,8 +264,16 @@ static int am2315_probe(struct i2c_client *client)
 	return devm_iio_device_register(&client->dev, indio_dev);
 }

+static const struct of_device_id am2315_of_match[] = {
+	{ .compatible = "aosong,am2315", .data = &am2315_chip_info },
+	{ .compatible = "aosong,am2320", .data = &am2320_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, am2315_of_match);
+
 static const struct i2c_device_id am2315_i2c_id[] = {
-	{ .name = "am2315" },
+	{ .name = "am2315", .driver_data = (kernel_ulong_t)&am2315_chip_info },
+	{ .name = "am2320", .driver_data = (kernel_ulong_t)&am2320_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, am2315_i2c_id);
@@ -258,6 +281,7 @@ MODULE_DEVICE_TABLE(i2c, am2315_i2c_id);
 static struct i2c_driver am2315_driver = {
 	.driver = {
 		.name = "am2315",
+		.of_match_table = am2315_of_match,
 	},
 	.probe =        am2315_probe,
 	.id_table =         am2315_i2c_id,
@@ -266,5 +290,5 @@ static struct i2c_driver am2315_driver = {
 module_i2c_driver(am2315_driver);

 MODULE_AUTHOR("Tiberiu Breana <tiberiu.a.breana@intel.com>");
-MODULE_DESCRIPTION("Aosong AM2315 relative humidity and temperature");
+MODULE_DESCRIPTION("Aosong AM2315 and similar relative humidity and temperature");
 MODULE_LICENSE("GPL v2");
--
2.47.3

