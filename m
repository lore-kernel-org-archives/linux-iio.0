Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794131006;
	b=Uw0sY+GJmZCs1Hrb7TLv4rzXqyWHOGeB71v+6efS2KEp/vMlHjgPBMNSzQbAmWQVu9E0
	 Mw3wL+nyHUOx8fd0zYmG85jc09qo5uiRRad8u2ELBogTP+yEBLLun+6ux2awjd/dUxFOE
	 kw2G6MUub3gVb8TEPPJkJpnxZWCwYsb7SRUPAxj7tj0vtteM887rvcGRIUsBZGVmQpbY6
	 I3s4a64b1uy75n0YxisJaOm/tze2yvSkrPHxWMjoLJGuFlSb8EttpZ+rJiT2P7PI76wnA
	 o1pAbAeeWPXF1EJpceBmaE0YyTY3C+ff/72mQDE3uX3YECChEh6S6j24g22X+q2YVEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794131006;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ry/KcASImX2Qro/RekC3tlYb6nFcctVtkMKgMd6UWg8=;
	b=lmB/egQULTocn5lJ/lKdqgCZ+n4hXCC5zUPTz2BSy0U9xMVEXrOklskxbqGLK2bXoKIY
	 16Soc58ur2TBGilkbq7qfZ/qciLiTMEVnQXv9iEm7uAIdfh5iRMKhzwoL1qzSx01Wxi3Q
	 OwoMixnx/6NjJGZeKFKckLLPEbnmH8Wk+LtI+5vGaQ2ZBQYq8OJHLW4yHup1/GkdGGwrw
	 kQeYb1jqmVDQQ8Z0YuMlxOJ9O9kdCpYOpFyhTPSh4QeED4EDyT384a0SzFLmZzKtRjKvN
	 u66jTxDXEU/wcRPpsg3LL/spn2q/UAFenBeadnUDhwuwT9BUPgUh5mSHJOxeR4oCNNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nQagUJ4p;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0984F606A321
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 09:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0984F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nQagUJ4p
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4d5cb1b181so1047366b.3
        for <linux-iio@vger.kernel.org>; Sun, 08 Nov 2026 01:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794131004; x=1794735804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ry/KcASImX2Qro/RekC3tlYb6nFcctVtkMKgMd6UWg8=;
        b=nQagUJ4pighTFDBSrqBc8msJxMU3ubpraesPMva19OsUN2TxmBsNKaZDlVAvtY/w7a
         lF4gyODLF6EfOZqFsi7kuzkiweqFxSOFXEcAYy/D8FBm4AP3wsBLF2mpBsUCSXe9eKLE
         pjaOCXIYmvpF7gmMqHRhMcGEh3ChC0wzZcZg10JuGECYcFcIlf9lyLPAeytmsYIrJ5Tu
         zzfHSD6ulS3/Ktj2UVFbzIBQ4qFdcKQIzL3nwpCEcxAGAf8DvnkyzPdv+IhwEiVVVfCW
         mRMaF4kXQ4F84vRvJY0GBep6QF8ayOgFs9Jr/U/7gihEaDeW8cwpKs34JsccY6XvwlqC
         4BEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794131004; x=1794735804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ry/KcASImX2Qro/RekC3tlYb6nFcctVtkMKgMd6UWg8=;
        b=rNuRGlimlpP9lsubb+nIfv/Kkh4MzLl+02OYl9eNxesaKnZxmG39WtTWhai09HJPAp
         Bminb4AfK/7+sa4sFooKjJt3BWIF2e+mzgYWiEqQFsSAhHdSAa1ZOPIg1s4eI8VqkEA4
         j5dKQW4J38Bvel13ZSCG64au6cbTzJJZfrm/OBn5dRDPECJLnAOEcTSA6aM45NaCKJzR
         36Ohl0Gf2fKtH8VOw6qhcZvsR2wrnXLYa+J3elHugeVPCeqB9r2z4KsZ53me25pvtq6N
         jhBlF/RbXT1CaY8gYvnwOU1Zeo7ExKYOtQtEETKVr2eTrN6aIkuvbLn0vuCpRZDSlGsb
         vt5w==
X-Gm-Message-State: APuU4Z8nGrg0VWDP3f/ozeGEAeg88Tp3ibKBU1MCR9Chmt5HbvnhF0zy
	jg75kVzWn4qAkOcyF6yVb2Z18r1gODWnCesY19++Co5B9cdn+22s3YfN
X-Gm-Gg: AYBFou3ArmQpquZMyhhszMUbBxPHXOPk3apF3h9MbyKljXEGpbNREOAP0/8BEZDJuIh
	R4+H1HYO4NZnEbj/KersiimxyIqJUZnP8jKyekT81o8vQR0zXO85fqNqslKlh3Mjzcf0Dj3DgHI
	5/pIBF/rsVjlbfLSMcu9KlRYUVKv8yMoFizLiOvFU5cZ5vRVEaPZn6WCEPM7SZLGQ4vhxkJ0+dp
	EnC0ZCdkVhV4cqE0kHtArfYAsK4O/r5JGNkZZItyt4MD/s5FC9uKyTr53Fj4tRlXacPF1xnvMGQ
	13YxYmAE+WiAQn6Onp00mruoxsxslneuroGLplHwX9169hOqUae9Np4FQO1BuH7NxbdWck7Vb4x
	PRIsHCnsmKf/pyhCMJon1oh586Ri4wUO4aeBVyIpiZkDlsxy7IOPB+L8HC4o//y7JX+Ho9IuwQ/
	P20nLv+EB4MiTNNj5X0D702/QUZaWVO7+KReeZN7XJpFLipOSD7ebL4kb33xVUYJE71xrPsPTNi
	0NJcAJXZE9IfgSH7Wq2nC1cJTmHSnIAhRzu87ChvmJPiIYRjIUlkFDlKhKqbd0rub9fKX6YFazH
	q68GiNFgoYJkMXR6+XXLZ5SHIfBiohm5u4gRo6lTrJXP8cblWjTvGcZWhODQ/KFmGDdySI9Wu4y
	t9bxxs9HosQ==
X-Received: by 2002:a05:6402:4486:b0:6af:a64f:bd44 with SMTP id 4fb4d7f45d1cf-6b722486333mr630783a12.45.1794131004175;
        Sun, 08 Nov 2026 01:43:24 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b721ea56f2sm436321a12.8.2026.11.08.01.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 01:43:21 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Esben Haabendal <esben@geanix.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pan Chuang <panchuang@vivo.com>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Nikita Travkin <nikita@trvn.ru>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] iio: light: ltr501: Switch to modern match mechanism
Date: Sun,  8 Nov 2026 11:42:51 +0200
Message-ID: <20261108094253.83899-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108094253.83899-1-clamor95@gmail.com>
References: <20261108094253.83899-1-clamor95@gmail.com>
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

Remove the chip enum, break the chip list structure into individual
elements, and pass each element using i2c_get_match_data().

Preserve the iio_dev name configuration and replace the
iio_get_acpi_device_name_and_data() call with a simple dev_name(), since
the former is just a wrapper for the latter in this use case.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/iio/light/ltr501.c | 164 +++++++++++++++++--------------------
 1 file changed, 74 insertions(+), 90 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 1ddd0dfd55ea2..ca6c8cffb4001 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -90,14 +90,6 @@ struct ltr501_samp_table {
 
 #define LTR501_RESERVED_GAIN -1
 
-enum {
-	ltr301,
-	ltr303,
-	ltr329,
-	ltr501,
-	ltr559,
-};
-
 struct ltr501_gain {
 	int scale;
 	int uscale;
@@ -1187,62 +1179,64 @@ static const struct iio_info ltr501_info = {
 	.write_event_config = &ltr501_write_event_config,
 };
 
-static const struct ltr501_chip_info ltr501_chip_info_tbl[] = {
-	[ltr301] = {
-		.partid = 0x08,
-		.als_gain = ltr501_als_gain_tbl,
-		.als_gain_tbl_size = ARRAY_SIZE(ltr501_als_gain_tbl),
-		.als_mode_active = BIT(0) | BIT(1),
-		.als_gain_mask = BIT(3),
-		.als_gain_shift = 3,
-		.channels = ltr301_channels,
-		.no_channels = ARRAY_SIZE(ltr301_channels),
-	},
-	[ltr303] = {
-		.partid = 0x0A,
-		.als_gain = ltr559_als_gain_tbl,
-		.als_gain_tbl_size = ARRAY_SIZE(ltr559_als_gain_tbl),
-		.als_mode_active = BIT(0),
-		.als_gain_mask = BIT(2) | BIT(3) | BIT(4),
-		.als_gain_shift = 2,
-		.channels = ltr301_channels,
-		.no_channels = ARRAY_SIZE(ltr301_channels),
-	},
-	[ltr329] = {
-		.partid = 0x0A,
-		.als_gain = ltr559_als_gain_tbl,
-		.als_gain_tbl_size = ARRAY_SIZE(ltr559_als_gain_tbl),
-		.als_mode_active = BIT(0),
-		.als_gain_mask = BIT(2) | BIT(3) | BIT(4),
-		.als_gain_shift = 2,
-		.no_irq_support = true,
-		.channels = ltr301_channels,
-		.no_channels = ARRAY_SIZE(ltr301_channels),
-	},
-	[ltr501] = {
-		.partid = 0x08,
-		.als_gain = ltr501_als_gain_tbl,
-		.als_gain_tbl_size = ARRAY_SIZE(ltr501_als_gain_tbl),
-		.ps_gain = ltr501_ps_gain_tbl,
-		.ps_gain_tbl_size = ARRAY_SIZE(ltr501_ps_gain_tbl),
-		.als_mode_active = BIT(0) | BIT(1),
-		.als_gain_mask = BIT(3),
-		.als_gain_shift = 3,
-		.channels = ltr501_channels,
-		.no_channels = ARRAY_SIZE(ltr501_channels),
-	},
-	[ltr559] = {
-		.partid = 0x09,
-		.als_gain = ltr559_als_gain_tbl,
-		.als_gain_tbl_size = ARRAY_SIZE(ltr559_als_gain_tbl),
-		.ps_gain = ltr559_ps_gain_tbl,
-		.ps_gain_tbl_size = ARRAY_SIZE(ltr559_ps_gain_tbl),
-		.als_mode_active = BIT(0),
-		.als_gain_mask = BIT(2) | BIT(3) | BIT(4),
-		.als_gain_shift = 2,
-		.channels = ltr501_channels,
-		.no_channels = ARRAY_SIZE(ltr501_channels),
-	},
+static const struct ltr501_chip_info ltr301_chip_info_tbl = {
+	.partid = 0x08,
+	.als_gain = ltr501_als_gain_tbl,
+	.als_gain_tbl_size = ARRAY_SIZE(ltr501_als_gain_tbl),
+	.als_mode_active = BIT(0) | BIT(1),
+	.als_gain_mask = BIT(3),
+	.als_gain_shift = 3,
+	.channels = ltr301_channels,
+	.no_channels = ARRAY_SIZE(ltr301_channels),
+};
+
+static const struct ltr501_chip_info ltr303_chip_info_tbl = {
+	.partid = 0x0A,
+	.als_gain = ltr559_als_gain_tbl,
+	.als_gain_tbl_size = ARRAY_SIZE(ltr559_als_gain_tbl),
+	.als_mode_active = BIT(0),
+	.als_gain_mask = BIT(2) | BIT(3) | BIT(4),
+	.als_gain_shift = 2,
+	.channels = ltr301_channels,
+	.no_channels = ARRAY_SIZE(ltr301_channels),
+};
+
+static const struct ltr501_chip_info ltr329_chip_info_tbl = {
+	.partid = 0x0A,
+	.als_gain = ltr559_als_gain_tbl,
+	.als_gain_tbl_size = ARRAY_SIZE(ltr559_als_gain_tbl),
+	.als_mode_active = BIT(0),
+	.als_gain_mask = BIT(2) | BIT(3) | BIT(4),
+	.als_gain_shift = 2,
+	.no_irq_support = true,
+	.channels = ltr301_channels,
+	.no_channels = ARRAY_SIZE(ltr301_channels),
+};
+
+static const struct ltr501_chip_info ltr501_chip_info_tbl = {
+	.partid = 0x08,
+	.als_gain = ltr501_als_gain_tbl,
+	.als_gain_tbl_size = ARRAY_SIZE(ltr501_als_gain_tbl),
+	.ps_gain = ltr501_ps_gain_tbl,
+	.ps_gain_tbl_size = ARRAY_SIZE(ltr501_ps_gain_tbl),
+	.als_mode_active = BIT(0) | BIT(1),
+	.als_gain_mask = BIT(3),
+	.als_gain_shift = 3,
+	.channels = ltr501_channels,
+	.no_channels = ARRAY_SIZE(ltr501_channels),
+};
+
+static const struct ltr501_chip_info ltr559_chip_info_tbl = {
+	.partid = 0x09,
+	.als_gain = ltr559_als_gain_tbl,
+	.als_gain_tbl_size = ARRAY_SIZE(ltr559_als_gain_tbl),
+	.ps_gain = ltr559_ps_gain_tbl,
+	.ps_gain_tbl_size = ARRAY_SIZE(ltr559_ps_gain_tbl),
+	.als_mode_active = BIT(0),
+	.als_gain_mask = BIT(2) | BIT(3) | BIT(4),
+	.als_gain_shift = 2,
+	.channels = ltr501_channels,
+	.no_channels = ARRAY_SIZE(ltr501_channels),
 };
 
 static int ltr501_write_contr(struct ltr501_data *data, u8 als_val, u8 ps_val)
@@ -1407,9 +1401,7 @@ static int ltr501_probe(struct i2c_client *client)
 	struct ltr501_data *data;
 	struct iio_dev *indio_dev;
 	struct regmap *regmap;
-	const void *ddata = NULL;
-	int partid, chip_idx;
-	const char *name;
+	int partid;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
@@ -1489,18 +1481,10 @@ static int ltr501_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	if (id) {
-		name = id->name;
-		chip_idx = id->driver_data;
-	} else {
-		name = iio_get_acpi_device_name_and_data(&client->dev, &ddata);
-		chip_idx = (intptr_t)ddata;
-	}
-	if (!name)
+	data->chip_info = i2c_get_match_data(client);
+	if (!data->chip_info)
 		return -ENODEV;
 
-	data->chip_info = &ltr501_chip_info_tbl[chip_idx];
-
 	if ((partid >> 4) != data->chip_info->partid)
 		return -ENODEV;
 
@@ -1511,7 +1495,7 @@ static int ltr501_probe(struct i2c_client *client)
 	indio_dev->info = &ltr501_info;
 	indio_dev->channels = data->chip_info->channels;
 	indio_dev->num_channels = data->chip_info->no_channels;
-	indio_dev->name = name;
+	indio_dev->name = id ? id->name : dev_name(&client->dev);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = ltr501_init(data);
@@ -1582,29 +1566,29 @@ static int ltr501_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(ltr501_pm_ops, ltr501_suspend, ltr501_resume);
 
 static const struct acpi_device_id ltr_acpi_match[] = {
-	{ "LTER0301", ltr301 },
+	{ "LTER0301", .driver_data = (kernel_ulong_t)&ltr301_chip_info_tbl },
 	/* https://www.catalog.update.microsoft.com/Search.aspx?q=lter0303 */
-	{ "LTER0303", ltr303 },
+	{ "LTER0303", .driver_data = (kernel_ulong_t)&ltr303_chip_info_tbl },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, ltr_acpi_match);
 
 static const struct i2c_device_id ltr501_id[] = {
-	{ .name = "ltr301", .driver_data = ltr301 },
-	{ .name = "ltr303", .driver_data = ltr303 },
-	{ .name = "ltr329", .driver_data = ltr329 },
-	{ .name = "ltr501", .driver_data = ltr501 },
-	{ .name = "ltr559", .driver_data = ltr559 },
+	{ .name = "ltr301", .driver_data = (kernel_ulong_t)&ltr301_chip_info_tbl },
+	{ .name = "ltr303", .driver_data = (kernel_ulong_t)&ltr303_chip_info_tbl },
+	{ .name = "ltr329", .driver_data = (kernel_ulong_t)&ltr329_chip_info_tbl },
+	{ .name = "ltr501", .driver_data = (kernel_ulong_t)&ltr501_chip_info_tbl },
+	{ .name = "ltr559", .driver_data = (kernel_ulong_t)&ltr559_chip_info_tbl },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltr501_id);
 
 static const struct of_device_id ltr501_of_match[] = {
-	{ .compatible = "liteon,ltr301", },
-	{ .compatible = "liteon,ltr303", },
-	{ .compatible = "liteon,ltr329", },
-	{ .compatible = "liteon,ltr501", },
-	{ .compatible = "liteon,ltr559", },
+	{ .compatible = "liteon,ltr301", .data = &ltr301_chip_info_tbl },
+	{ .compatible = "liteon,ltr303", .data = &ltr303_chip_info_tbl },
+	{ .compatible = "liteon,ltr329", .data = &ltr329_chip_info_tbl },
+	{ .compatible = "liteon,ltr501", .data = &ltr501_chip_info_tbl },
+	{ .compatible = "liteon,ltr559", .data = &ltr559_chip_info_tbl },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ltr501_of_match);
-- 
2.53.0

