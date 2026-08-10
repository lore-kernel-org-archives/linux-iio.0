Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34B339F17F;
	Mon, 10 Aug 2026 07:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786345920; cv=none; b=BmGXE0JVfpuqm+VGAu+fvYQOCBpyqhSBN1aVqlvECIcQcmS+X2CSM46Ulw0aoyjKkP6UKGZqK85IYebXk/T9XpyntTyRpmmNYsD9u3Y/VWObWKVbpx0gTQQtzF9IsNTKSaxkwEqIsV9q4xvPLNA9wxzqEAHDdbw3nuWJZlTDI10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786345920; c=relaxed/simple;
	bh=MuvRVbfdouj/OLcKJ8O7DVf7YAf5gC37nokJjZenhls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JFmwarOGRtDZecy4b1UkmG9ma/0uOrdIixNns0LhoGByuywn0QBbbwbmew1njU6x1XTsO25JV4XGhNi9czg5bruf5EGh3pAUMzwct+WF1YnHYW3H1PFT9LGnk/WIVzorKWfJIgoNUZmrb/4MSYT0qsPjPUB8vlkNYQRME74tziQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=aWc1L3Yc; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="aWc1L3Yc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786345899; x=1786605099;
	bh=atzdeTNbTU4rvpHaH57Rc13kdaFLRtEPbsFyYjUrPbE=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=aWc1L3Yc1Oq2/527RTSElOJ/zCt4e/Uxc4JMbSvodsaMLMbknGBmtG+hBPbYQYTkG
	 /k7HqcPg5BrvlFFaxmvOISYd6ODibrKOpTECIcefI6pednPGG7/AUH2PsUhpyoupyy
	 EHpSwH0l+T25Cf718hUwFi3VcZsDfMz7W65RBDRqKbWc+qD/kbYkelXiY1JRXyaV9v
	 4uajJJ/pOgFDqx7e3/lixexOD5cdMBV88eJe+KBJb61oWZERFxufp34gZ6IIPK83u9
	 scnLFVs62JxJlZ2K7SptWhRi09xzyKU5S5pTJQXpsv+0YXTHYF10vZDA68QtDCc97J
	 FTttysCiAnMPg==
X-Pm-Submission-Id: 4hJQsk5tP8z2Scpf
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 10 Aug 2026 09:11:17 +0200
Subject: [PATCH v4 7/7] iio: light: ltr501: Fix sorting order of device
 arrays
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-liteon-ltr329-v4-7-8bd3dfd15280@geanix.com>
References: <20260810-liteon-ltr329-v4-0-8bd3dfd15280@geanix.com>
In-Reply-To: <20260810-liteon-ltr329-v4-0-8bd3dfd15280@geanix.com>
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
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786345884; l=4275;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=MuvRVbfdouj/OLcKJ8O7DVf7YAf5gC37nokJjZenhls=;
 b=ksA+rp3cN10NwiSeTxemH8qfQQabjpVuM7a0iEaIUl5c7H9USQs6CXPv9ubwMUQ7UawWtWJts
 Ij43H6UoPvcA5AlGkRR/221YR6VyqbzmF/QUk3W+s3oT3mFMuAPccWa
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Using alphanumerical sort order for these should help reduce merge
conflicts.

The 0 assignment to the first entry is not needed, as the first entry will
always be 0. The main thing is to keep the values here in sync with the
elements in ltr501_chip_info_tbl[].

Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/light/ltr501.c | 68 +++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index cd5ff00ef5e2..c438b5818160 100644
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
@@ -1631,21 +1631,21 @@ static const struct acpi_device_id ltr_acpi_match[] = {
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

