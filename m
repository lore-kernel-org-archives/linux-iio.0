Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73363494804
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 17:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786730102; cv=none; b=V8VyJtAwebq0Osu7tJYEmCPPA25o0+BB8MqjDWs/hnv9anE4Qz5g7DMNS3o0iocrmsD1BoD5kMT0SYqupHO+CtdMgmLcaiGWG6xIEmXHVpiqmImFVsM9lApHoJUi9MZSKAhtTvu245+gip5ewSK2ZXxW4EIfZ6RZsEQ86TUXKC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786730102; c=relaxed/simple;
	bh=ZGfx0g19f1BGXUFsCvd5dkL3s6zDjSbj2Y36nSNQydU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GAm/m40Q7dZKJhLymUAOK3xXMOO53IEZatoY9edXyu+P6wjM9DaBkiLZvQIkG5RJ+M4G/SSTTfGT4qu/MKyfQJg5VEVbfogHocF+qg8o94+4HEkyXPPs7eD/vxecmCbc/X4WuroCk0VNAQXN3veJGjRCOvhuTS5tK3nZXv74fvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWgZY1nU; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWgZY1nU"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so974028a91.1
        for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 10:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786730100; x=1787334900; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MmM5BWELeV/soQlGFaiWyzZSNjOOXNNBMJCjP4mlS0A=;
        b=PWgZY1nUm87s8XkJCWokLV6+PCAiq+yFO3mX9V16HR90voAPypelHWhQLtPMJE+rsD
         onWrW+wp7EGf2iEpNxBIUuhKQzmNKmcCiHURgSrGoq+jnLdJyR+c9cyRvhBNWkBeut1x
         JSknsZL5RQy1jveVCEd7VtOiWxs1zzP+no51MLp7LhzrIeIxxH2XxlRYb8VXAWf1BRTp
         ywrPNJ6Ih+3cnJKgwfifSLNrPRQmim4MKZoOTRhvsolpWuq2qztHMiyiYp28JJlWOCsH
         jW8NmIuk3E3aWvL7HfwPLTMUq/l5NrrGm3Pw7yGwKkTCZPFCfipZr3ngQZoKQ6kIb1pw
         aN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786730100; x=1787334900;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MmM5BWELeV/soQlGFaiWyzZSNjOOXNNBMJCjP4mlS0A=;
        b=kvdzMeujrLBvPJUBRMRcyuid5KnWr7VEXMqPm3j3i37sWGvYGgSbkA+a9cAWz348wG
         uGfiPTQ9URetVbnjsiO7aRSqBzSM12ToxNNZahtNvjqj15oFeyG5oxXIA2tP3nBo44Zw
         xkT8uiLIwhfuK45nIdtBeBLG0Rooq+5xFAkm/3C28ltFUJMS5X9Q9KKSsnnEhFMNdWgV
         uSdLbgDoH9D3T4GD7RvAwxYNNB4n9uZuB1YBwro9S++1ekojaYCmpTQRY074N7w4jJCf
         XJCLWa7rvrmGPPJflRKOyM26ZhqHxGa1+ZIotDCW6yKBeLw1hXZHz8wxM2+40moiA9uQ
         VQdQ==
X-Forwarded-Encrypted: i=1; AHgh+RrRjcVdcm36rBlIHeCbxvKOFGOJp93UKV4aBY5oJCLghUvt2c/YfGkMPCoEjBGtUsREZSa95MY9/zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhlAJt380d8oba59mwJmA8OFYdVBVmvkIzLVe3WkTJBdHYH/0g
	KtUh3sVVeDfxTEiTNcwq9mXf6YKvvyHRcV/3Pspj4JDqxe6iRDvxDgo=
X-Gm-Gg: AR+sD124oRc1DGvEki/ky5FZ1omWZur/vpy4i14N5FR5uiIjWmWR7prvTDCraXGEUBH
	QcrW1Az1+M2UFWGfvCvVXYInPAGLHuh4UmzenYpIz82kYlKo2nEdrkHmD9POOMo85DWlaKQBhr4
	Vz6TWxHTD3WVZHtr/0CyeazWksvDXuZethhP8O1Pr7I50/6hDLkkI2vy11MQ/doNL9UDDczY5yd
	zCICU77zqci9wWwhRkGg+iCwQDzwzSrJKv4XfW5lmmzn/hfIKl8tN63Zp519/GfDKu7diw8nbwF
	YIi8PSVzrg6k8rQunH8R2rcQo4XrDVSLwJ5/hPqRndNkC6mmrpWePxAv7qu06NSL7ptypq66Kc8
	k8uzWV2MDPmqeNYCVnkWzzQqc5jC1ft4AiaYztFYlQvwSPNZIuI2veX5Kfz3BsxaQX2Gxt50V+k
	wA7bsJitoBqHIcInclYSryOh6bFmH7w2zvZU8lJRs1WpL165oego13iBnJHLuyXwVan7DX5DNBQ
	sKy+NhnO7fGOpFNC5hDuwKFkkTncYHI2FjvTLjhzv5nww==
X-Received: by 2002:a17:90b:3c02:b0:380:f389:447b with SMTP id 98e67ed59e1d1-3933b8938f9mr9133156a91.11.1786730099789;
        Fri, 14 Aug 2026 10:54:59 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1413887ee70sm11128710c88.11.2026.08.14.10.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 10:54:59 -0700 (PDT)
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
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v3 2/2] iio: humidity: am2315: add support for am2320
Date: Fri, 14 Aug 2026 14:50:20 -0300
Message-ID: <83c8a41607ed07285a84dba8ed10a954226076b4.1786725567.git.nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1786725567.git.nico.antinori.7@gmail.com>
References: <cover.1786725567.git.nico.antinori.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The AM2320 is fully compatible with the AM2315 sensor in terms of I2C
communication protocol and measurement conversions.

Add the "am2320" entry to the i2c_device_id table and create
of_device_id table.

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
index f29baa251f9f..37491416076c 100644
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
+		return -EINVAL;
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
+	{}
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

