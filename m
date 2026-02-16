Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB2B2DC798;
	Mon, 16 Feb 2026 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771261854; cv=none; b=i9znnFD1guJKEkHqDvB3V7WYxdxTridFq3LErgYaBKOuOiYw1yd9PvyI/9t4SIPMM3Rbr2e9sorORxTQgEC7vB4TWEdod4cPJkdg3B3WHnVuk43oPnfc1zGDC4L1E5ObdBx+CzIe5N4eehtSAc45XMD0s3h+PU/qnY92SyN5W9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771261854; c=relaxed/simple;
	bh=SGpZmjmJreZtSGcW6F1763DwBbMeVUBQ3LZkIAH4J+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HrTLPuEAdyg6NzDVTeZCFOn8hzYX3m96VjyCcK8iLhfwzmE/AJn6vXpIeRxul1bIAIvjXV1wVvVsyg+/dO3cNxte4LJMs62L4ZtSIzVDcc0K9Y1MZqvz/Y32C5D02GGL7qri7Lz2OQr+PwZF8txtSF4zvRCmnPAi6q77V5QE6k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e20q32fW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e20q32fW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0756FC2BCB1;
	Mon, 16 Feb 2026 17:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771261854;
	bh=SGpZmjmJreZtSGcW6F1763DwBbMeVUBQ3LZkIAH4J+A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=e20q32fWVQ2oWgAZWHtVo4g6coWOAyhiQC+6IRasezKd3xCuOqBBRtHBr6nMMPpPA
	 HrIb9ZgvMykT0dvkZGDIDNF/ZSd41z0NH4Pc7W/K7T6zpEAOAjvaBhI2+UwEl70yhX
	 nI609ejTYyqk6VdrNIqJl2QmL/tPYFo8TyiouEbnY9A5SF42CPFqi1YI+ekhyWkKGH
	 grVTvlwlcVp02xsTAVfoRfRhlD0hpat4hbVKcx3vsLPF2DIklkyA4JrnHijftlwns9
	 OWDIEmyn+WUgdrNWpwEWUNz/r1nNBLMDfPqwZRuN8cyxJ+QMoib4kxSlruS91Cpcrb
	 4qvlbWE8XBAGg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED64FE81A5B;
	Mon, 16 Feb 2026 17:10:53 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 16 Feb 2026 17:10:53 +0000
Subject: [PATCH v5 09/11] iio: amplifiers: ad8366: add device tree support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-iio-ad8366-update-v5-9-7e6091357d02@analog.com>
References: <20260216-iio-ad8366-update-v5-0-7e6091357d02@analog.com>
In-Reply-To: <20260216-iio-ad8366-update-v5-0-7e6091357d02@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771261851; l=4519;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=Jiz8Tdwp3Da0KKuGbUooBkSljzJvf+Nn5FFdakciPZM=;
 b=ZCW/rmjtdHo/Xp/QwaxkHqOSlGmQG9Ddy7TFrLlwD1d2VcBdM1rJjoxWPFd04OF0cGpGFlmRp
 U/ZE8B0q4lgAPT0ei+KCV0K1qmyYmukdaac2N0ruW0qQpfN9QGXdJoQ
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Drop the enum ID, split chip info table into per-device structs and add
of_match_table. Additionally, add 'name' field into the chip info struct,
dropping the usage of spi_get_device_id().

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/amplifiers/ad8366.c | 107 ++++++++++++++++++++++------------------
 1 file changed, 59 insertions(+), 48 deletions(-)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index 22eb6c9bb0f6..fb787a512bff 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -29,15 +29,8 @@
 
 #include <linux/iio/iio.h>
 
-enum ad8366_type {
-	ID_AD8366,
-	ID_ADA4961,
-	ID_ADL5240,
-	ID_HMC792,
-	ID_HMC1119,
-};
-
 struct ad8366_info {
+	const char *name;
 	int gain_min;
 	int gain_max;
 	int gain_step;
@@ -68,38 +61,45 @@ static size_t ad8366_pack_code(const unsigned char *code, size_t num_channels,
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
+	.name = "ad8366",
+	.gain_min = 4500,
+	.gain_max = 20500,
+	.gain_step = 253,
+	.num_channels = 2,
+	.pack_code = ad8366_pack_code,
+};
+
+static const struct ad8366_info ada4961_chip_info = {
+	.name = "ada4961",
+	.gain_min = -6000,
+	.gain_max = 15000,
+	.gain_step = -1000,
+	.num_channels = 1,
+};
+
+static const struct ad8366_info adl5240_chip_info = {
+	.name = "adl5240",
+	.gain_min = -11500,
+	.gain_max = 20000,
+	.gain_step = 500,
+	.num_channels = 1,
+};
+
+static const struct ad8366_info hmc792_chip_info = {
+	.name = "hmc792a",
+	.gain_min = -15750,
+	.gain_max = 0,
+	.gain_step = 250,
+	.num_channels = 1,
+};
+
+static const struct ad8366_info hmc1119_chip_info = {
+	.name = "hmc1119",
+	.gain_min = -31750,
+	.gain_max = 0,
+	.gain_step = -250,
+	.num_channels = 1,
 };
 
 static int ad8366_write_code(struct ad8366_state *st)
@@ -237,14 +237,14 @@ static int ad8366_probe(struct spi_device *spi)
 		return dev_err_probe(dev, ret, "Failed to get regulator\n");
 
 	st->spi = spi;
-	st->info = &ad8366_infos[spi_get_device_id(spi)->driver_data];
+	st->info = spi_get_device_match_data(spi);
 
 	rstc = devm_reset_control_get_optional_exclusive_deasserted(dev, NULL);
 	if (IS_ERR(rstc))
 		return dev_err_probe(dev, PTR_ERR(rstc),
 				     "Failed to get reset controller\n");
 
-	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->name = st->info->name;
 	indio_dev->info = &ad8366_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ad8366_channels;
@@ -258,18 +258,29 @@ static int ad8366_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad8366_id[] = {
-	{"ad8366",  ID_AD8366},
-	{"ada4961", ID_ADA4961},
-	{"adl5240", ID_ADL5240},
-	{"hmc792a", ID_HMC792},
-	{"hmc1119", ID_HMC1119},
+	{ "ad8366", (kernel_ulong_t)&ad8366_chip_info },
+	{ "ada4961", (kernel_ulong_t)&ada4961_chip_info },
+	{ "adl5240", (kernel_ulong_t)&adl5240_chip_info },
+	{ "hmc792a", (kernel_ulong_t)&hmc792_chip_info },
+	{ "hmc1119", (kernel_ulong_t)&hmc1119_chip_info },
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


