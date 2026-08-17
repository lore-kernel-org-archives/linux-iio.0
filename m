Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D880E463B8D;
	Mon, 17 Aug 2026 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786986582; cv=none; b=c4/ytblybNEj0uvFRwKTcn42FTyg8HyDsNyT8Er90oIxX6Iie7+vr+QP3JNpQMdIIOxZlR6Ml6p+bxZe9b7kmfnt8InUpt7C9bKlTwv7nahE8wkQJ9pihxcCWoTl4pLBuaOX8MtAkHRCMz41kTCZZEm82BI/BiLExZnzoP7+jJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786986582; c=relaxed/simple;
	bh=2vfBl9nHbr0SfKm0Xo3cnhWVmJNB9UljX67gOqtqHsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Trtsv0CqLhXKzs/HOhjlh3RM19euqaEx/pDc7JeVNWPPSjsbAnB+NVugtE/fN+zcuUjJzQ6dC7/RlR48Ej14bFg2hCcF1wNBLf2VLwQ8E8kAN1bN+VHc5mckUWwVFSVDuXP7xmlpFUATVEYNW5WA62CE17es7We8ItrjJWTBOfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=wiDnXDhb; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="wiDnXDhb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786986567; x=1787245767;
	bh=bavJViIYJIFOUAUUuYm14SbniokRCHshi2k7tcZDAqw=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=wiDnXDhbcG82fQSfhxA5hP4Dx/7RBI3dzFJ6lId1ByJZLotmTWPKFyhGUB2BczpWk
	 KvJUtVaMJ1n65q5HyeXIpS6lGgLqe+FgwxNAb7FbplpsGP8lDhD7qSEAOkhESqXyih
	 CYYk8Q9htfxmOEjz9J+qdbuNiAahaTtDNZLE2g9CBrRtSKj3yVoC//SXcBYW9uVPou
	 Q6QouBvTFnuaRyfHaPcrmau4JyZsZKBaogszM80eJACxjQdiMgoj4B8yW8P/YoqYxg
	 zxSKMuYuPxGyKy79ySZXXBbBNXzINAPYejvCvxz2utGL9FudgzUBRGFx7bRQ+QZ/rZ
	 sIdDCgRmSuIPw==
X-Pm-Submission-Id: 4hNzpD2v8Xz2SchF
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 17 Aug 2026 19:08:56 +0200
Subject: [PATCH v5 7/8] iio: light: ltr501: Fix sorting order of device
 arrays
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-liteon-ltr329-v5-7-6f71ab2b0588@geanix.com>
References: <20260817-liteon-ltr329-v5-0-6f71ab2b0588@geanix.com>
In-Reply-To: <20260817-liteon-ltr329-v5-0-6f71ab2b0588@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>, 
 Maslov Dmitry <maslovdmitry@seeed.cc>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
 Thomas Gleixner <tglx@kernel.org>, Pan Chuang <panchuang@vivo.com>, 
 Yangtao Li <frank.li@vivo.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786986543; l=4335;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=2vfBl9nHbr0SfKm0Xo3cnhWVmJNB9UljX67gOqtqHsE=;
 b=WT0iYBsMyx3R/c/BKYaqXN3HEYEXqsfv0vYh49QUrwkQFWNeAkTQzzL2rHoAvL7eNVmUhrWKO
 4Vf7d6ZhrQRCXa59PFfTaF4oMMtyS8ylMdKsJaQZiJKt5/W+mtwQJ0C
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Using alphanumerical sort order for these should help reduce merge
conflicts.

The 0 assignment to the first entry is not needed, as the first entry will
always be 0. The main thing is to keep the values here in sync with the
elements in ltr501_chip_info_tbl[].

Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/light/ltr501.c | 68 +++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 51ab387f24a3..d9b68da2452b 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -91,11 +91,11 @@ struct ltr501_samp_table {
 #define LTR501_RESERVED_GAIN -1
 
 enum {
-	ltr501 = 0,
-	ltr559,
 	ltr301,
 	ltr303,
 	ltr329,
+	ltr501,
+	ltr559,
 };
 
 struct ltr501_gain {
@@ -1219,34 +1219,6 @@ static const struct iio_info ltr301_info = {
 };
 
 static const struct ltr501_chip_info ltr501_chip_info_tbl[] = {
-	[ltr501] = {
-		.partid = 0x08,
-		.als_gain = ltr501_als_gain_tbl,
-		.als_gain_tbl_size = ARRAY_SIZE(ltr501_als_gain_tbl),
-		.ps_gain = ltr501_ps_gain_tbl,
-		.ps_gain_tbl_size = ARRAY_SIZE(ltr501_ps_gain_tbl),
-		.als_mode_active = BIT(0) | BIT(1),
-		.als_gain_mask = BIT(3),
-		.als_gain_shift = 3,
-		.info = &ltr501_info,
-		.info_no_irq = &ltr501_info_no_irq,
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
-		.info = &ltr501_info,
-		.info_no_irq = &ltr501_info_no_irq,
-		.channels = ltr501_channels,
-		.no_channels = ARRAY_SIZE(ltr501_channels),
-	},
 	[ltr301] = {
 		.partid = 0x08,
 		.als_gain = ltr501_als_gain_tbl,
@@ -1283,6 +1255,34 @@ static const struct ltr501_chip_info ltr501_chip_info_tbl[] = {
 		.channels = ltr301_channels,
 		.no_channels = ARRAY_SIZE(ltr301_channels),
 	},
+	[ltr501] = {
+		.partid = 0x08,
+		.als_gain = ltr501_als_gain_tbl,
+		.als_gain_tbl_size = ARRAY_SIZE(ltr501_als_gain_tbl),
+		.ps_gain = ltr501_ps_gain_tbl,
+		.ps_gain_tbl_size = ARRAY_SIZE(ltr501_ps_gain_tbl),
+		.als_mode_active = BIT(0) | BIT(1),
+		.als_gain_mask = BIT(3),
+		.als_gain_shift = 3,
+		.info = &ltr501_info,
+		.info_no_irq = &ltr501_info_no_irq,
+		.channels = ltr501_channels,
+		.no_channels = ARRAY_SIZE(ltr501_channels),
+	},
+	[ltr559] = {
+		.partid = 0x09,
+		.als_gain = ltr559_als_gain_tbl,
+		.als_gain_tbl_size = ARRAY_SIZE(ltr559_als_gain_tbl),
+		.ps_gain = ltr559_ps_gain_tbl,
+		.ps_gain_tbl_size = ARRAY_SIZE(ltr559_ps_gain_tbl),
+		.als_mode_active = BIT(0),
+		.als_gain_mask = BIT(2) | BIT(3) | BIT(4),
+		.als_gain_shift = 2,
+		.info = &ltr501_info,
+		.info_no_irq = &ltr501_info_no_irq,
+		.channels = ltr501_channels,
+		.no_channels = ARRAY_SIZE(ltr501_channels),
+	},
 };
 
 static int ltr501_write_contr(struct ltr501_data *data, u8 als_val, u8 ps_val)
@@ -1630,21 +1630,21 @@ static const struct acpi_device_id ltr_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, ltr_acpi_match);
 
 static const struct i2c_device_id ltr501_id[] = {
-	{ .name = "ltr501", .driver_data = ltr501 },
-	{ .name = "ltr559", .driver_data = ltr559 },
 	{ .name = "ltr301", .driver_data = ltr301 },
 	{ .name = "ltr303", .driver_data = ltr303 },
 	{ .name = "ltr329", .driver_data = ltr329 },
+	{ .name = "ltr501", .driver_data = ltr501 },
+	{ .name = "ltr559", .driver_data = ltr559 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltr501_id);
 
 static const struct of_device_id ltr501_of_match[] = {
-	{ .compatible = "liteon,ltr501", },
-	{ .compatible = "liteon,ltr559", },
 	{ .compatible = "liteon,ltr301", },
 	{ .compatible = "liteon,ltr303", },
 	{ .compatible = "liteon,ltr329", },
+	{ .compatible = "liteon,ltr501", },
+	{ .compatible = "liteon,ltr559", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ltr501_of_match);

-- 
2.55.0

