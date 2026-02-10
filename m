Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433F6331226;
	Tue, 10 Feb 2026 19:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770752538; cv=none; b=jg/vnu5LZV0ouzMqcJHnqskjCZqFBeBKmwgGAcGswHa+zPGl8slCla29M/QnK/QWtF/Sh1nL5vTm9He7rfDNmCziTzGYlPDM+Bp8hDnr84TCTL7/wWZgg0tM8QLLjYzBk7jyZBRxXJGp/2f9SIGUZVoOsHZ870Ishtdr0XShaio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770752538; c=relaxed/simple;
	bh=dBAEJKtc96dEneGGru/3QqhRhpSnPrGxCr2yV8h6zZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aLUbCVMGnDxFP+W+Gr42qe7mhiroH5tke8QwxOnQ4wMuMiqI4coA1v4m+PSMvXpyvUm2SQEvV/EcqAtQTuP7WSgqk08gIfpM8p/hryyMOlWxqBDq1Zn3+Fslcbly/M8B3/3K1r85rRhxQr0gm3WozNGK2OsVJhdkX45G4pYx+OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eof9XVRo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eof9XVRo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04310C19421;
	Tue, 10 Feb 2026 19:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770752538;
	bh=dBAEJKtc96dEneGGru/3QqhRhpSnPrGxCr2yV8h6zZY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Eof9XVRoHwuuW8HmMPYXo+AkWQDdGhMLqqYlC3dJAll+Gy1OWXjsm4eevLEsvh+Kb
	 U3+78eUBLadoIaCmUQ55+N9QXbBuzEHd6XYjjcp+giBiLPsWiJq+L16yuj9PLNnobN
	 ejh6l2BxDEpunTVXylGPzP5Q3ondn+Y6+wExaKR5n78+kSKUEx/DrKK09EGYAOrq78
	 Irq7WrJb835sIKDwMB3aTAR+TUhBg8yc8FtCsKOeR2cyM9tu0rhmyu00fWeDRmAlN3
	 tXqjY6h10IlYsyroSK+UM8EUJDoOql3gb9B3bddI448kUoxC9AIn8o/e1bJAHzrHfe
	 5guI9XL74uq2A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB69EB2700;
	Tue, 10 Feb 2026 19:42:17 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 10 Feb 2026 19:42:09 +0000
Subject: [PATCH v4 09/11] iio: amplifiers: ad8366: add device tree support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-iio-ad8366-update-v4-9-15505f7b15b4@analog.com>
References: <20260210-iio-ad8366-update-v4-0-15505f7b15b4@analog.com>
In-Reply-To: <20260210-iio-ad8366-update-v4-0-15505f7b15b4@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770752535; l=4163;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=Q1eL1soBzt5LHgD1qOKJM+53k4PYKZ8/z9tudKqluIA=;
 b=eQQfhs+zD2dD7LvlR2kiKOJhcwb2MjmslXaewcKN79vRzr8nzAplH+G9TLC97gT1X/JtJSTuS
 Wa3bZtwwPeoAhiMWpRNdHW9xZOdolbXPvnHVKgQ6d3CVbmRp4k5S1i3
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Drop the enum ID, split chip info table into per-device structs
and add of_match_table.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/amplifiers/ad8366.c | 100 +++++++++++++++++++++-------------------
 1 file changed, 53 insertions(+), 47 deletions(-)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index 1ae75643e89b..79fb3119d794 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -14,6 +14,7 @@
 #include <linux/bitrev.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/regulator/consumer.h>
@@ -23,14 +24,6 @@
 
 #include <linux/iio/iio.h>
 
-enum ad8366_type {
-	ID_AD8366,
-	ID_ADA4961,
-	ID_ADL5240,
-	ID_HMC792,
-	ID_HMC1119,
-};
-
 struct ad8366_state;
 
 struct ad8366_info {
@@ -62,38 +55,40 @@ static size_t ad8366_pack_code(struct ad8366_state *st)
 	return sizeof(__be16);
 }
 
-static const struct ad8366_info ad8366_infos[] = {
-	[ID_AD8366] = {
-		.gain_min = 4500,
-		.gain_max = 20500,
-		.gain_step = 253,
-		.num_channels = 2,
-		.pack_code = ad8366_pack_code,
-	},
-	[ID_ADA4961] = {
-		.gain_min = -6000,
-		.gain_max = 15000,
-		.gain_step = -1000,
-		.num_channels = 1,
-	},
-	[ID_ADL5240] = {
-		.gain_min = -11500,
-		.gain_max = 20000,
-		.gain_step = 500,
-		.num_channels = 1,
-	},
-	[ID_HMC792] = {
-		.gain_min = -15750,
-		.gain_max = 0,
-		.gain_step = 250,
-		.num_channels = 1,
-	},
-	[ID_HMC1119] = {
-		.gain_min = -31750,
-		.gain_max = 0,
-		.gain_step = -250,
-		.num_channels = 1,
-	},
+static const struct ad8366_info ad8366_chip_info = {
+	.gain_min = 4500,
+	.gain_max = 20500,
+	.gain_step = 253,
+	.num_channels = 2,
+	.pack_code = ad8366_pack_code,
+};
+
+static const struct ad8366_info ada4961_chip_info = {
+	.gain_min = -6000,
+	.gain_max = 15000,
+	.gain_step = -1000,
+	.num_channels = 1,
+};
+
+static const struct ad8366_info adl5240_chip_info = {
+	.gain_min = -11500,
+	.gain_max = 20000,
+	.gain_step = 500,
+	.num_channels = 1,
+};
+
+static const struct ad8366_info hmc792_chip_info = {
+	.gain_min = -15750,
+	.gain_max = 0,
+	.gain_step = 250,
+	.num_channels = 1,
+};
+
+static const struct ad8366_info hmc1119_chip_info = {
+	.gain_min = -31750,
+	.gain_max = 0,
+	.gain_step = -250,
+	.num_channels = 1,
 };
 
 static int ad8366_write_code(struct ad8366_state *st)
@@ -229,7 +224,7 @@ static int ad8366_probe(struct spi_device *spi)
 		return dev_err_probe(dev, ret, "Failed to get regulator\n");
 
 	st->spi = spi;
-	st->info = &ad8366_infos[spi_get_device_id(spi)->driver_data];
+	st->info = spi_get_device_match_data(spi);
 
 	rstc = devm_reset_control_get_optional_exclusive_deasserted(dev, NULL);
 	if (IS_ERR(rstc))
@@ -250,18 +245,29 @@ static int ad8366_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad8366_id[] = {
-	{"ad8366",  ID_AD8366},
-	{"ada4961", ID_ADA4961},
-	{"adl5240", ID_ADL5240},
-	{"hmc792a", ID_HMC792},
-	{"hmc1119", ID_HMC1119},
+	{"ad8366", (kernel_ulong_t)&ad8366_chip_info},
+	{"ada4961", (kernel_ulong_t)&ada4961_chip_info},
+	{"adl5240", (kernel_ulong_t)&adl5240_chip_info},
+	{"hmc792a", (kernel_ulong_t)&hmc792_chip_info},
+	{"hmc1119", (kernel_ulong_t)&hmc1119_chip_info},
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad8366_id);
 
+static const struct of_device_id ad8366_of_match[] = {
+	{ .compatible = "adi,ad8366", .data = &ad8366_chip_info },
+	{ .compatible = "adi,ada4961", .data = &ada4961_chip_info },
+	{ .compatible = "adi,adl5240", .data = &adl5240_chip_info },
+	{ .compatible = "adi,hmc792a", .data = &hmc792_chip_info },
+	{ .compatible = "adi,hmc1119", .data = &hmc1119_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad8366_of_match);
+
 static struct spi_driver ad8366_driver = {
 	.driver = {
-		.name	= KBUILD_MODNAME,
+		.name		= KBUILD_MODNAME,
+		.of_match_table	= ad8366_of_match,
 	},
 	.probe		= ad8366_probe,
 	.id_table	= ad8366_id,

-- 
2.43.0


