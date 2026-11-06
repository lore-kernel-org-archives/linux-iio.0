Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956817;
	b=VGKdxyomRX5H753zdzFOOtbCSZPfbJ9lq3WhH8f34+CsPleMBGKC5g1KF2OTZkSJwP6W
	 ujKux5lbfJtqoULIpkBk8qw4hMpd47Vv2h5fFq5P3nGpMCrGBfysjqKFQbOKIBSRE+/Am
	 6fjPio0mfUVpze7joxO/E84b4Jg8KEe7XJ9bPQQMelswWb4dJUOSUAsj9lqP+JillTRzA
	 4O1BukSxjOeTCWqdXJX3ujO+gxdhIcLkHYPV+2OuASPLC0iUVVHBxxuLx9wBUIxocSv08
	 2VYJAkl3qsGWAoO1H557opseSoFz8gqdKwn5YC9C3VDOQ7kjTka5TsNBWjA+0g9Y45w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956817;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dZugLSOdu0FLGpp/MgQnmUnwUibKQyTiyxJla4Bqexo=;
	b=eQUQ9lGk0hvB7HDnx6Ut6z95HvacnlKaPfZQxDubtkA7vSujXiwglkGvAPPQ7qNsIKBQ
	 lr9Uszap9PfH0rwFauBwzBvZ8eNF1g9PRxYPZX+0e8mM6W/Ph959vxrM887smQfm9Tl5O
	 yZeF5mUK/s8cVBGBcajMGwLciDrfJWoEm+H9bXrMsdSaw3X1KeJ7XELrBYNKYcuvgfldM
	 A0JQWgoYE2uca87Waa2EbnRtxLYBSuGeCbexdUH2QWmS9UQbNhFt2iy4DjkJZZrCxZdy+
	 ZbZRMY1MH/yEjkd2SkHIQjL0JWRflZR5jHmIA4BCXKMPuA0C1dvlj6X3u9Zdn6On8sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sjn4V8kt;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD356082BC6
	for <linux-iio@vger.kernel.org>; Fri,  6 Nov 2026 09:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DD356082BC6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sjn4V8kt
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so2185045e9.3
        for <linux-iio@vger.kernel.org>; Fri, 06 Nov 2026 01:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793956814; x=1794561614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dZugLSOdu0FLGpp/MgQnmUnwUibKQyTiyxJla4Bqexo=;
        b=sjn4V8kty+ukrgxiKO05KJH0jk88LQaMbKl7/81iWghp9XfU8iZCmjAYrCWuGWms03
         k8PGWNlR3m9CYE/rcvfYZUAEiGP9GGfdq7t1xSlgZLXfoGzIiPOFmduFXNVjmVYQupKN
         ULTS6hJsS/el4aR+SPyu+7mVxu6PUkLO+8Ga5opDDEJYtUz78cKWEXe0yGOSk1YZnpaw
         EqDj4qRDO979FF6l/y8v4Lu09aza7mFEHrVn+QDOlQvn4JRDa8BcnQwrK7WXa1JlI1ne
         OJzUO6fYgCCW3mXs7tfEQ7FXTjJXRJ0pqBvpTAKgKlTd97PuVDSyf3502wUnjSch0l3i
         ZUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793956814; x=1794561614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dZugLSOdu0FLGpp/MgQnmUnwUibKQyTiyxJla4Bqexo=;
        b=ROeb6N35YXBWQqUYN3hYD4ohvVc405Oq7FawejzuO/uXAESRK/W23KbZDp8X1eg+lz
         t903zaxNhOtliDHanPTDQESoCh099QUlv9Gx01Thl7WoK3QwqtE4w0VZRTYd6yHi/8He
         QOM2Zzilw89WbM8F4sb+Uwl+1NgrZBWZ6yR9r8GPyMbPm3jP+Nu1xxpXjJLljSw7jrRy
         CouWLZi2RTomJVq56tXTpvN3agKcFhZS7AophgPKo6ZH6RGxDmfgMv9HNf3GcfaKsomA
         RYgfzPz0mbf6ATMyOkTG5vHRKYhhgSAcqcT+iFrdIXTBT81iLQGeb/oyjxMKkb0WkD2V
         bsxQ==
X-Gm-Message-State: APuU4Z+evHummCshu4ZeSldjwg5KBKrVmqI3VklqWINMZW7lPkPYOKVA
	/rFGYYBIWQEs3V6vtcLive7YWJWfGI01d3R7HNnDFx/A+UJOQQEgI6Mu2FG6Ww==
X-Gm-Gg: AYBFou0HcTTJw4qbunKfVUd45+U5abzkkyPrk4h3D00f8J1NwwoDAsAC71yWPSFD0ds
	D3u2xbsZSXfoKFCog0G1BLyrtLIUg1hIWog2Vml43xLC11NLOEmMQCs15gbR0XdZj3yXIN/dWZ8
	25Y1Q7fnQACV7RNgO359it/E0DKkJfiVRSyYil4+oYy+W/fX9VDbF0U5xrPu1+KtkOPeHAIvRpI
	Bnt3jGfM80uoq7psnoW0oz3OOpzmg4fqN73NPj0Rp++bRQPs7Df2lMpr+8hTcR/Xu9JE8LWm0Zd
	O6CIoP6hIh1ZeF2UsMoaPSef4tOq5kz9Uavi5IeVKIEBd7AFJ6neXdEPTY+GXyKVajNy1oH4vkl
	FcNBOWiuGsYPLJpyJEspN/OjM7oxeRKR1lr3j8X7UsQkqpV6K5QDLrX6Dh5b0Aps2tqBKMqnHKX
	7yjfazNmXy4qnAhwPtYxA6V7w1DqFWEDOfROY+WZHMglNfpVVersea5niTY69rgpF+hEWzJRF7v
	THu4I/l3Eqy59eydnGKaIppIvlEkmfjeLxmUmOxN3qzQkcWX5u0f57XGChc1jxR4qlJ+Jw0mP58
	VCXHUPjAvPGR5GCiFd/6rt2L6VtSBlDHkyQPv3UVBzA1tI+ANi0HcGn6hYgLrb9fIb9k0eYAbvW
	sR7p7FHFGbQ==
X-Received: by 2002:a05:600c:3d05:b0:4a2:883:4adb with SMTP id 5b1f17b1804b1-4b6dfba86fbmr30238265e9.22.1793956814129;
        Fri, 06 Nov 2026 01:20:14 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b57203a98fsm108358935e9.4.2026.11.06.01.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 01:20:13 -0800 (PST)
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
Subject: [PATCH v2 2/4] iio: light: ltr501: Switch to modern match mechanism
Date: Fri,  6 Nov 2026 11:19:41 +0200
Message-ID: <20261106091943.35783-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106091943.35783-1-clamor95@gmail.com>
References: <20261106091943.35783-1-clamor95@gmail.com>
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

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/iio/light/ltr501.c | 165 +++++++++++++++++--------------------
 1 file changed, 74 insertions(+), 91 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index cc5d7af44d77c..d5ce6468a229b 100644
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
@@ -1178,62 +1170,64 @@ static const struct iio_info ltr501_info = {
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
@@ -1393,14 +1387,11 @@ static int ltr501_powerdown(struct ltr501_data *data)
 
 static int ltr501_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	static const char * const regulator_names[] = { "vdd", "vddio" };
 	struct ltr501_data *data;
 	struct iio_dev *indio_dev;
 	struct regmap *regmap;
-	const void *ddata = NULL;
-	int partid, chip_idx;
-	const char *name;
+	int partid;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
@@ -1480,18 +1471,10 @@ static int ltr501_probe(struct i2c_client *client)
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
 
@@ -1502,7 +1485,7 @@ static int ltr501_probe(struct i2c_client *client)
 	indio_dev->info = &ltr501_info;
 	indio_dev->channels = data->chip_info->channels;
 	indio_dev->num_channels = data->chip_info->no_channels;
-	indio_dev->name = name;
+	indio_dev->name = client->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = ltr501_init(data);
@@ -1573,29 +1556,29 @@ static int ltr501_resume(struct device *dev)
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

