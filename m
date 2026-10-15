Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A584D90D7
	for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061397; cv=none; b=OtfAVn3y3sFsmvoFyTIJb5qxzHXh7k0DKkg1y/ytZcysChK+7G+qA5I5W6iifC/ItenFLLO4ias/9GU8e17sX2/FjhQFsHiOHUxJhnWa5IZYSQJSHeyETENIBwjwaoukcOF0PlxdCy3aF8djGavVdDKP9/TECk9hgVcu8vUsj2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061397; c=relaxed/simple;
	bh=xA3JBQH35qcvdCZAGAV76S+DLk1lnpZgBfuvhwHS6Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfh+XuiZZwzl1D2pVJHDbMrPMNyRgmMnghTiVtOfbAik38dUOhcji6aZLIK07CfgkWVVN1s2TfjKSrVZJ1FsiTFGSExM3WVEEAxAjNaW9JEO/FwEfwzP/Cd8IAasEcjfp8T7lVpK+FmVj3AHZgS2NvqWTy4jj5GEGLlH3HrEWBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUqXnlMB; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUqXnlMB"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b1ab2ad719so421047a12.3
        for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 03:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792061394; x=1792666194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rwtZXk2YJ9fodoj0VOFBAN64pVLRB29dfNhKqWxOQQI=;
        b=bUqXnlMBJ0CsSdcSe18wW55UKZdWbNNOtZeRzhapQ2s7oNVj6cTXzAy/jljycJVWUc
         aCA3QPDWTrWyqxRgp9doouie48OREtXJWUeR3/K+OZfGcMM+7vMt5vBoZz/ptdncirHr
         slA+FlxWXgvS3vNGLbFq4AwxGIoIgzWBd13setCiLuDS6oZRKTOaxyheqsuqr3ayC5Zw
         4xqASaN9bbTz9xHNmeMfSvXxRchljfPUsijsOn+eO6Q+gauAsUQh9W98wxt5lHzexYSH
         GwLY8LiwXsKlw2+cyCWWSYJeg7XWc0RdQEECpjZut0YebvbCLplMY4vprEBppH/foEPk
         BRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792061394; x=1792666194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rwtZXk2YJ9fodoj0VOFBAN64pVLRB29dfNhKqWxOQQI=;
        b=wnEcJJ4dkQ7Wa5FcP105TBjZCUeqiHjsVyJbxMKCLl/98fycqacQdZOgG1MgqqO60Z
         /w0DynB3j5pFN/sGaV4xHo811wPYXUkMsE3IsM+lU4/OOtN+ZdmD3nBhYs7q3haA95JX
         uAopnkY8rm5K7mp6pwH8e3RDGdYY+t+oZNe9/Mr5iqMVK0m9roLj7qwBfMIzV6e/AL7a
         tehvHv5lKqUczTmwL/gO9ixk6WmQ+c8nzQjnFL42MiFXlmyhOlYObyaz097Pnbm0Fe/5
         zm/X3sGGPP/273FND3i0B5aXMbsWMFyuT281+3mUQdreO8D53cL8LLuFm0YHeIPFhh1v
         6xVQ==
X-Forwarded-Encrypted: i=1; AKwUvBzIqZOliwbedb+8AOcIQ9G7NgUqM3ukxReDhy8pDXZH73e6bltHKbftbueFe0a4Sc5qVNeC1yaxV+0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJomfkzzfj2Qz0PKeq7VzTDr7yt3c5sFTjdX8A/ZZTQKdHCzXL8
	DCTBTugfkwiFga17owHg5PXMu5/arDu/fAo0L6PDDtb3eJ24CTptxr+S
X-Gm-Gg: AYBFou3OZ++KDWSF+g1wXsBtGWvHcu7WvWSVO4GhvOA/BwcQRTP0+6lEsluPhnfIgFZ
	+lr9YhasFNv+jrERTWueALx6dZxXk5xQGNPhDNaVQ5MM+nUJeA4yXIHM4CwL+gWutiVV6Avc9a4
	EzIdjvj1GDtNhgh9cWqEUh2e9NY9CmIaMAyFYivlh+Lj9PM1G+amN6Y3yzI2OMOswT0ulxifAV7
	QktGWVX5ttfX9UlGEGcpI+BIzZxcxW2XC9pCjunzzSMq51Wk/zv08dhiGngpZTTnWNceAll5rAy
	eVlLYlv0u7DgXM+W1j57Q9TVfF5VnfDfsdOULSUIsGUXQlTroYJA0fJumcOM7RTCBbLl0X4RnwY
	aX72b6kOI180ERloUQN4KgzDFrqTgWZPDAxZooEqLMDtXvXPdUk4P4SB5i/DY5w6fGE3baThy4z
	gAXxcTQgC7dq2ktbpOvPlwGIXdETigLnw/CBOJHGFhzKmCHIndLjD4xqWEi9a9dA1ZNkbp15iI+
	Pml9f28GkktmZCPweSEXda+or6IcYQvXaehclnGQNfyei333rL46kxkJEPKo9k+vetBH4E2u0Cb
	Zi1/RD1R7TitO8A79h+rJdXQQ5c=
X-Received: by 2002:a17:907:c0c:b0:c2d:bae5:27d9 with SMTP id a640c23a62f3a-c31aa0f4b65mr1766182866b.46.1792061393704;
        Thu, 15 Oct 2026 03:49:53 -0700 (PDT)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed9b3af45sm107890066b.33.2026.10.15.03.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 03:49:53 -0700 (PDT)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [PATCH v3 3/5] iio: pressure: dps310: add per-chip data
Date: Thu, 15 Oct 2026 13:49:43 +0300
Message-ID: <20261015104945.2687162-4-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015104945.2687162-1-paulius.zaleckas@gmail.com>
References: <20261015104945.2687162-1-paulius.zaleckas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the coefficient count, the TMP_CFG startup value and the IIO device
name into a per-chip structure, passed through the I2C and ACPI match
data. This prepares for the Zilltek ZTS8032, which has two more
coefficients and a different TMP_CFG layout.

No functional change.

Assisted-by: LLM
Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
---
 drivers/iio/pressure/dps310.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 1d0b3232db9e..aa80d106ac44 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -62,6 +62,8 @@
 #define DPS310_RESET		0x0c
 #define  DPS310_RESET_MAGIC	0x09
 #define DPS310_COEF_BASE	0x10
+#define DPS310_COEF_LEN		18
+#define DPS310_MAX_COEF_LEN	18
 
 /* Make sure sleep time is <= 30ms for usleep_range */
 #define DPS310_POLL_SLEEP_US(t)		min(30000, (t) / 8)
@@ -86,10 +88,23 @@ static const int scale_factors[] = {
 	2088960,
 };
 
+struct dps310_chip_info {
+	const char *name;
+	u8 tmp_cfg;	/* TMP_CFG at startup: sensor the coefficients are for */
+	u8 coef_len;
+};
+
+static const struct dps310_chip_info dps310_chip_info = {
+	.name = "dps310",
+	.tmp_cfg = DPS310_TMP_EXT,
+	.coef_len = DPS310_COEF_LEN,
+};
+
 struct dps310_data {
 	struct i2c_client *client;
 	struct regmap *regmap;
 	struct mutex lock;	/* Lock for sequential HW access functions */
+	const struct dps310_chip_info *info;
 
 	s32 c0, c1;
 	s32 c00, c10, c20, c30, c01, c11, c21;
@@ -149,13 +164,13 @@ static const struct iio_chan_spec dps310_channels[] = {
 static int dps310_get_coefs(struct dps310_data *data)
 {
 	int rc;
-	u8 coef[18];
+	u8 coef[DPS310_MAX_COEF_LEN];
 	u32 c0, c1;
 	u32 c00, c10, c20, c30, c01, c11, c21;
 
 	/* Read all sensor calibration coefficients from the COEF registers. */
 	rc = regmap_bulk_read(data->regmap, DPS310_COEF_BASE, coef,
-			      sizeof(coef));
+			      data->info->coef_len);
 	if (rc < 0)
 		return rc;
 
@@ -252,10 +267,10 @@ static int dps310_startup(struct dps310_data *data)
 		return rc;
 
 	/*
-	 * Set up external (MEMS) temperature sensor in single sample, one
-	 * measurement per second mode
+	 * Set up the temperature sensor the coefficients are for in single
+	 * sample, one measurement per second mode
 	 */
-	rc = regmap_write(data->regmap, DPS310_TMP_CFG, DPS310_TMP_EXT);
+	rc = regmap_write(data->regmap, DPS310_TMP_CFG, data->info->tmp_cfg);
 	if (rc)
 		return rc;
 
@@ -979,7 +994,11 @@ static int dps310_probe(struct i2c_client *client)
 	data->client = client;
 	mutex_init(&data->lock);
 
-	iio->name = DPS310_DEV_NAME;
+	data->info = i2c_get_match_data(client);
+	if (!data->info)
+		return -ENODATA;
+
+	iio->name = data->info->name;
 	iio->channels = dps310_channels;
 	iio->num_channels = ARRAY_SIZE(dps310_channels);
 	iio->info = &dps310_info;
@@ -1018,13 +1037,13 @@ static int dps310_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id dps310_id[] = {
-	{ .name = DPS310_DEV_NAME },
+	{ .name = "dps310", .driver_data = (kernel_ulong_t)&dps310_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, dps310_id);
 
 static const struct acpi_device_id dps310_acpi_match[] = {
-	{ "IFX3100" },
+	{ .id = "IFX3100", .driver_data = (kernel_ulong_t)&dps310_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, dps310_acpi_match);
-- 
2.55.0

