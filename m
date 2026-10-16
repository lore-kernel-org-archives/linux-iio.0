Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701464E13E8
	for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 15:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164950; cv=none; b=Gv1LAWgRJnG+1+qsS/h/fbY4E1f9PcSjh25wYcUS6M7pMNbz6++0LEGZIaar5zfdm0uVhmtDfBDjh8BFSmdPawNR6kbw52nvU0nzxXRD5AiKIqNhFEhRqIPgvQGTIB8w7sRwO7dFsH5u3cpxi23VopIDFpb4X0dPvvAV3o0y7HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164950; c=relaxed/simple;
	bh=q0rCLQwLWANoCwZTuKOTQdJ3Sjom9RaYYQjpvH2j/B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDAqbdpWq+bZoFAcXSEzrLGpdVMdUc+NxTc+0fSvIil63FYk92Aop6eZt/gl2WURsF0XgmQ3Zs1F2SMVntC/hK174+fk1+pw05+6KoSorhccgcgqzodohkdBGjRBA3fBPwwKl4xt/04lFMDIFf3PhP9hZj87VlLSfhP1YVR7Uu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZJPVjxU; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZJPVjxU"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso5406927a12.3
        for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 08:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792164942; x=1792769742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xgx0usfEr7KgB7QOLLHWV6JVGMcwvoEn5+G9c42TBac=;
        b=fZJPVjxUBYRRHK6Wov9jPa2V9voLbX9n7ClKUnN7LysmIdgC6uLKcI+u7yHHhuaaSY
         Ansjs4SWhj3UB7UPWayJ49upmDdLUkiDFVy6p8qGjy4Ne1ealc/WVOX5h0kFYHytP++5
         ipF8NNghaBFW+Y7xf5z8MGcRY7jMorz+zgdKbI5f+1G1UzhstCXw/OC70t5EH0yW6G7h
         9w6pWFs44EYY+hO1YitTjn7HHt3qpqRhvFDbd3U8r2dWIfVkhnRmQVI7mesmsY/hPyRL
         u6BO17cu6/gMaeodPllnKD2MLwt3cgDFuHFvfe8ctwuyWJtCPEw9goon0Qg7jqWCQPe7
         m35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792164942; x=1792769742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xgx0usfEr7KgB7QOLLHWV6JVGMcwvoEn5+G9c42TBac=;
        b=L2ziAJnhkJ6Mr8xph+A62o5ugsMGNub+Ujy5fB96ufLDEa/5t4/SLp6PA1F+mBERPL
         Pqv7n/KoSETnf8AJv9Gi7xH1NbnM6Zup3ez/QC2Xnfq2UIiH5p59F7SmeBBXe9hi6ZUa
         bDP2hq4PhPaa64nbC8+8iJlF+vf4DDgHlzNf6NtIz5wP9cxWJzmRGmVO0wmkpORH8sfo
         RuIHyBpuFpL/01s8cQlTjcApZ9L9RZZVFXhw+2opFE8Tbhmqp+zw0UrT/1X4JtOezsW3
         WZXfp49/FTcUZdq4JHz7Sd1NGz/1g8UlDeKWT34TszvKqqntmN6yFCWuvVmt6h5RxU7U
         hnpA==
X-Forwarded-Encrypted: i=1; AKwUvBw53Fhljbs51eZmRW/xMEy11GClovDya9l5OTVNi+7iBv425gKg+DWluXC+oSTOmOmANLv3hOmtdTU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLfrgpKDJ+e0VqdyxyKUwSzjtqsAhDzIZaEgTkRlMxzC2v40HFZ
	Zrj5bIDMzFdVCttdWh41zIp6o1UUllf5BvLf1OkCWBcuTrLbqJ2etA4y
X-Gm-Gg: AYBFou3kOVWyKGVFNKgRGQugdI2V/sgMycvqh4lOp5dYAmSFCqmrwhffQCzN6tRNBoK
	0EFLac/ID5OLUjgj2Z/6lGJIOcZRG+HMOQZkEdUE6s5pzsqWEmwIfeANMgqtQ27ECcof1iSMSE6
	yRnPG0ir/NygPBV3wsP5GC+9sbNnlrxN5uM0b154sMzpG4JuV/d8yfCY3rs+7J7IQYWXDRu8Z4d
	skAva0Rlbc74QlkyPkfUtLrhpJN7rH5Nsqwc3klKh6GN8FTfaAP/t02e7QuvsV2kD64Ob+vhDfD
	IraEY8ShO9b9QpKWkzr83M5r5R7xYfIjdv68BE78pGENdtJ04g/SuyEVGWtHdcx2UbPyTECEqfE
	RDKTrbAUYXq34wK6fLUzNcZhx16P1rHGupVQfAa5RPcbZP4YHx05/1eN+WCeqyAzeEPbmBt/cbw
	u6nNggNtytpdBbGt4potL23IZROYSjLrXBmHBVihICKAAGj9xx8u2H8CYNOHgV/megPg09e+9e0
	9GoLwa/G6CE6kkkGDwp9Evd7iIFmJzGKetDvOSd9Z3i11fzxLYkk0a9iEd9+VPc9+70BzITq5we
	BQgXPxl0UqWe8NckAqHI3CAzkWyh
X-Received: by 2002:a05:6402:2354:b0:6b1:bcde:9f32 with SMTP id 4fb4d7f45d1cf-6b1bcdea1d6mr13224245a12.7.1792164942131;
        Fri, 16 Oct 2026 08:35:42 -0700 (PDT)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b38a1b113dsm999067a12.10.2026.10.16.08.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 08:35:41 -0700 (PDT)
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
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [PATCH v4 3/5] iio: pressure: dps310: add per-chip data
Date: Fri, 16 Oct 2026 18:35:31 +0300
Message-ID: <20261016153533.3701000-4-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016153533.3701000-1-paulius.zaleckas@gmail.com>
References: <20261016153533.3701000-1-paulius.zaleckas@gmail.com>
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
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
---
 drivers/iio/pressure/dps310.c | 36 +++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 1d0b3232db9e..f2a8698e1e30 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -62,6 +62,9 @@
 #define DPS310_RESET		0x0c
 #define  DPS310_RESET_MAGIC	0x09
 #define DPS310_COEF_BASE	0x10
+#define DPS310_COEF_LEN		18
+
+#define MAX_COEF_LEN		18
 
 /* Make sure sleep time is <= 30ms for usleep_range */
 #define DPS310_POLL_SLEEP_US(t)		min(30000, (t) / 8)
@@ -86,10 +89,23 @@ static const int scale_factors[] = {
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
@@ -149,13 +165,13 @@ static const struct iio_chan_spec dps310_channels[] = {
 static int dps310_get_coefs(struct dps310_data *data)
 {
 	int rc;
-	u8 coef[18];
+	u8 coef[MAX_COEF_LEN];
 	u32 c0, c1;
 	u32 c00, c10, c20, c30, c01, c11, c21;
 
 	/* Read all sensor calibration coefficients from the COEF registers. */
 	rc = regmap_bulk_read(data->regmap, DPS310_COEF_BASE, coef,
-			      sizeof(coef));
+			      data->info->coef_len);
 	if (rc < 0)
 		return rc;
 
@@ -252,10 +268,10 @@ static int dps310_startup(struct dps310_data *data)
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
 
@@ -979,7 +995,11 @@ static int dps310_probe(struct i2c_client *client)
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
@@ -1018,13 +1038,13 @@ static int dps310_probe(struct i2c_client *client)
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

