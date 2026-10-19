Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1011B49B1F9
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 08:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792398991; cv=none; b=in03GChUY/VDSSk/YzgJhM/3vyKWNHhxt/dBvk1OeuiNQov6SNLyXQDSPGvJop6L/FEwQcSm0hF8MaZ5WgbuoSfx7jXXkOO8MoeFeg3yzP8GqW3aadMLxagkCd3lOKlufFMLJw1VJIl1WWvEIfeN3XDBD/6vcLDFk8NzRMp6N9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792398991; c=relaxed/simple;
	bh=2Ji49t7ARZ6jzQAymJs/pkUgy+LEcb7V8EUPUd19NkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HekZxnmRF80PAExZjCkPN92EWchPI1tJffKbJ+ExurvO/LvbGCpg3hF6qEj10XZMEdrjlUdcDeVlLY+JXA1nRtNoUAXQkLqL8KYeR/79NwMyUKDS3qY6zLFkeLRdDl50K52t2NcSyuqofz7ZBGmIpm4Ff8DypNGxTTSRRppBfO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEwMahEH; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEwMahEH"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c45551fa84eso11199266b.3
        for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 01:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792398988; x=1793003788; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MXcmFjHKnpZDcdqGcaeH3mTRlcIZHS1YKYiWsK+xOBI=;
        b=mEwMahEHl6FzVNrK3Mlks1mu5MFnNlWB0dt2ClxOZj7WIgovXN9a1n4APDQUgcavVl
         eoNwVQvjtLlFS2Hs35DYVt3NQAVT6K4gxknNPUAB8F2oFtJqaCmkVHUhS27pLuxSOYFj
         hJklugurUcGs2caF2GyHOtTzi1ci/zLMw5YYYQT8zSSJn7XzzgI66KvbjyAWBS/HTweh
         AE8O9CBfaFv6x64+oZH7zRR2paBoltutty0Ji9agKSuchsV/On98Rbs5FT4maIAc7eDC
         Qx0nnrGFmqYj0mpo6lppCpXWEBxLru5/AKeprC2jwOyz1PzPissjHpYcr/PAuBohFB1u
         zMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792398988; x=1793003788;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MXcmFjHKnpZDcdqGcaeH3mTRlcIZHS1YKYiWsK+xOBI=;
        b=ebx3DzHP2ZY5AgzoHFzTjJTCTcUoiMGYykIP/bJwg8z5LNLZ62vPoQ/lFLXrwqPH6/
         E/zEGv+Ii8h9xLb9/tTLdXoHbmy2gekB7PHM5TtPCUrkUP6jOJGBmVzSA3KxDWpGmzj9
         N3KgEI1y4aUm6VBY69r+x3HvdFIiAiqs02Ndc96lkL1zK/IxLU93B48ged+/XCH/tfza
         F2Hh9aVxf+H8Z0VvdLwqOid68DKu55MHqEBMBKtJj8UbmMNaS9frxhZPEFXYKB08hdOq
         ybJqAzptCt/yyQVA/IpaveNK0zF6cbBq4IliNCVJZGSgQGbO+KlVJWPfPD8+gRNgb8Dx
         2T9g==
X-Forwarded-Encrypted: i=1; AKwUvBzimZqnOeiveQhYbwMJRtjxHyr4Hor2FYtP2ccWpyfByG9V7SA9A0tRhOvaXcz0SySXLPQClirr3lI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYDt8DzQg/Lx8xpV+llzjUJAckRU7clY8urwdcN/oiKTUb6tvC
	yVkeQrCDtIOm9jRf+oSbuuftW021f18xNeIwVO++Ecc3vxgciDBWNWJ/
X-Gm-Gg: AYBFou12m/X7nbDnLxC0H2Us0JwVCODNSoJSgrq3XFcsTfHttIjyAXcxReJ+WlyvDFj
	9jevx72yKYk4vmeZptgu7Kvpqp3/R+OvYrc46gq4zFhMSJH5Ixss9hdXOguunG2FTwSREpgToQn
	pnf/aEt4VtQZEizU36UQwWxoWBr4QZhygmPKC6bAESqx5alOZVhI96EvpVHdVB9QMU+iv0eerYL
	4p2B6QBnJ5Nrjt1RvK5JhSAOJj+8uto64zcGoqPxk0aRtD+dqg1A3ksUQgpPujS8fjfj+m3t5CH
	7DKjbeeHZxw/+1XeAbormj1t+4/FeQTg5eazHz9vckdHf/ICWPs3b061EqFIdi+pxmnQAA7bpSn
	oCh7xOoKxWuHurVMTukm5SouTUJXx4cnfRak5g404CeBCBbTsuTliSg6z6TScMFFCfHuvLytpGV
	h37gjinEd1jK2trskNkXEG+WC5EaMYNqvtGn7M9zaATztru7cGCJJa4/t/1DuKq4ZCQAU1f6BqT
	azB4lodnkbV6l8r469O1W7uVjJLe/ogVjg/RNBp9eE6AGmJ1TPfEsrQPFkBry+02yT7SFcGrOXR
	U/Z7oxN/8yMoHIUtOViDOFqmUzxLzRxbbpeSQvQ=
X-Received: by 2002:a17:907:fd8b:b0:c40:dead:7466 with SMTP id a640c23a62f3a-c419e538580mr445435866b.20.1792398988089;
        Mon, 19 Oct 2026 01:36:28 -0700 (PDT)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4090dcf98fsm323106966b.13.2026.10.19.01.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 01:36:27 -0700 (PDT)
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
Subject: [PATCH v5 3/5] iio: pressure: dps310: add per-chip data
Date: Mon, 19 Oct 2026 11:36:18 +0300
Message-ID: <20261019083620.1285782-4-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019083620.1285782-1-paulius.zaleckas@gmail.com>
References: <20261019083620.1285782-1-paulius.zaleckas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move the coefficient count, the IIO device name and whether the
temperature coefficients are for the external sensor into a per-chip
structure, passed through the I2C and ACPI match data, and build the
TMP_CFG startup value from its fields. This prepares for the Zilltek
ZTS8032, which has two more coefficients and temperature coefficients
for the internal sensor.

No functional change.

Assisted-by: LLM
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
---
 drivers/iio/pressure/dps310.c | 43 +++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 00f6be126326..bfd76f2deed9 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -9,6 +9,7 @@
  *   c0 * 0.5 + c1 * T_raw / kT °C
  */
 
+#include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/devm-helpers.h>
 #include <linux/i2c.h>
@@ -42,7 +43,9 @@
 #define  DPS310_PRS_PRC_BITS	GENMASK(3, 0)
 #define DPS310_TMP_CFG		0x07
 #define  DPS310_TMP_RATE_BITS	GENMASK(6, 4)
+#define   DPS310_TMP_RATE_1SPS	0
 #define  DPS310_TMP_PRC_BITS	GENMASK(3, 0)
+#define   DPS310_TMP_PRC_1	0
 #define  DPS310_TMP_EXT		BIT(7)
 #define DPS310_MEAS_CFG		0x08
 #define  DPS310_MEAS_CTRL_BITS	GENMASK(2, 0)
@@ -63,6 +66,9 @@
 #define  DPS310_FIFO_FLUSH	BIT(7)
 #define  DPS310_RESET_MAGIC	0x09
 #define DPS310_COEF_BASE	0x10
+#define DPS310_COEF_LEN		18
+
+#define MAX_COEF_LEN		18
 
 /* Section 4.8: 32 shared entries. Stops when full, so late drains lose data */
 #define DPS310_FIFO_DEPTH	32
@@ -99,10 +105,23 @@ static const int scale_factors[] = {
 	2088960,
 };
 
+struct dps310_chip_info {
+	const char *name;
+	bool coef_for_ext_sensor;
+	u8 coef_len;
+};
+
+static const struct dps310_chip_info dps310_chip_info = {
+	.name = "dps310",
+	.coef_for_ext_sensor = true,
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
@@ -179,13 +198,13 @@ static const struct iio_chan_spec dps310_channels[] = {
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
 
@@ -281,11 +300,11 @@ static int dps310_startup(struct dps310_data *data)
 	if (rc)
 		return rc;
 
-	/*
-	 * Set up external (MEMS) temperature sensor in single sample, one
-	 * measurement per second mode
-	 */
-	rc = regmap_write(data->regmap, DPS310_TMP_CFG, DPS310_TMP_EXT);
+	rc = regmap_write(data->regmap, DPS310_TMP_CFG,
+			  FIELD_PREP(DPS310_TMP_PRC_BITS, DPS310_TMP_PRC_1) |
+			  FIELD_PREP(DPS310_TMP_RATE_BITS, DPS310_TMP_RATE_1SPS) |
+			  FIELD_PREP(DPS310_TMP_EXT,
+				     data->info->coef_for_ext_sensor));
 	if (rc)
 		return rc;
 
@@ -1347,7 +1366,11 @@ static int dps310_probe(struct i2c_client *client)
 	if (rc)
 		return rc;
 
-	iio->name = DPS310_DEV_NAME;
+	data->info = i2c_get_match_data(client);
+	if (!data->info)
+		return -ENODATA;
+
+	iio->name = data->info->name;
 	iio->channels = dps310_channels;
 	iio->num_channels = ARRAY_SIZE(dps310_channels);
 	iio->info = &dps310_info;
@@ -1394,13 +1417,13 @@ static int dps310_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id dps310_id[] = {
-	{ .name = DPS310_DEV_NAME },
+	{ .name = "dps310", .driver_data = (kernel_ulong_t)&dps310_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, dps310_id);
 
 static const struct acpi_device_id dps310_acpi_match[] = {
-	{ .id = "IFX3100" },
+	{ .id = "IFX3100", .driver_data = (kernel_ulong_t)&dps310_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, dps310_acpi_match);
-- 
2.55.0

