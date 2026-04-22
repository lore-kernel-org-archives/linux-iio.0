Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1047F352F88;
	Wed, 22 Apr 2026 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869185; cv=none; b=IUQkiYhVF5c/WpFNvWdAp30ukdiujlAZM3/c3r6zB3rCM4PYBJDyutkyw6jaxuKb7+VfwJ3jWgFZfCw5V+oJPq82S8GCYc38Fna5xmNBNFjUbtAemMC8xxprJ8Y3ZxoeuGgbacWO3QqUMthDV1WxJ9ByVdNIlEmR9iV6O9fbEA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869185; c=relaxed/simple;
	bh=f8VcwkTRlYpjFKy1P9T3fyn8hxX6zRLwXAQcqJzAAn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=paJX+cr5VBS3zkwLAyuzgwXVIxM7IlaQX09uJhLPm8B2lfpUPH5o/1EgtSobKM4HHAzgPYQ34YWrqBnGj4mvmRAcYDoAPPHbTkSsqvv7nmx58Z9uFDfkFS+96Aa5gfKweohrilZkZdE00bGfhdh6xpKtZ7FQjAwdzgxr1ZNvsjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgXgygeR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgXgygeR"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFFCAC19425;
	Wed, 22 Apr 2026 14:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776869184;
	bh=f8VcwkTRlYpjFKy1P9T3fyn8hxX6zRLwXAQcqJzAAn8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JgXgygeRlEruOHRGEuYl1oLDIKsAIWoTF4AkTB4fRj2cRTIn+Ymfe0ZtrqPfIouAb
	 QkRBLcjsGlIgUfNvmn9iXLRnHCfGAjOeQUjjPrV8pFqyo/H8af6ft7RyX7/v7e3YZ4
	 oMDfbPFtWDpTqa7b0O/0hfRV19KDWLZ7dyIQKRGLHhTNxOCz1UqYu7SCHdDM1ELswD
	 pOyzOsXkZGBNgr+SWY3dfOWkZRvHct2rl0d0Dfq2T2ue5IhG970aqT+BhORPDzu+BR
	 slwZexcFXsq6oZnzq1CNEYSkJUCQGhenzyFB4T14MsG1wRhaLVxXyELuohE5a5dCqI
	 0b0z/C1i0xVBg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D822DF9EDF4;
	Wed, 22 Apr 2026 14:46:24 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 22 Apr 2026 15:45:50 +0100
Subject: [PATCH 16/22] iio: dac: ad5686: extend device support with new
 parts
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-ad5313r-iio-support-v1-16-ed7dca001d1b@analog.com>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
In-Reply-To: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Auchter <michael.auchter@ni.com>, linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776869181; l=10073;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=ZOoAgr93kAfD2sJxGQv6hN2qubBX9RO2hW6A/Wbys+I=;
 b=mm8eqFL3aj9kOMry+45BTtlgSfv3slwm9xkvid8FQAuu6+EzNTPoRyuwT5Eysh18Ni/jPYpvk
 7geHzON7rIqCOHNCE+buuZUvbGQsg5iJ9V/ycxiuhEnMMrvQZx9L1So
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add support for AD5313R, AD5317R, AD5674, AD5679, AD5687, AD5687R, AD5689,
AD5689R to the AD5686 SPI driver. Also adding support for AD5316R, AD5675,
AD5697R to the AD5696 I2C driver. This includes the creation of seven chip
info struct instances and reuse of existing ones.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686-spi.c | 16 +++++++++++++
 drivers/iio/dac/ad5686.c     | 55 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/iio/dac/ad5686.h     |  7 ++++++
 drivers/iio/dac/ad5696-i2c.c |  6 +++++
 4 files changed, 84 insertions(+)

diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
index 9c00e016e67c..b57dc88eb953 100644
--- a/drivers/iio/dac/ad5686-spi.c
+++ b/drivers/iio/dac/ad5686-spi.c
@@ -104,10 +104,14 @@ static int ad5686_spi_probe(struct spi_device *spi)
 
 static const struct spi_device_id ad5686_spi_id[] = {
 	{ "ad5310r",  (kernel_ulong_t)&ad5310r_chip_info },
+	{ "ad5313r",  (kernel_ulong_t)&ad5338r_chip_info },
+	{ "ad5317r",  (kernel_ulong_t)&ad5317r_chip_info },
 	{ "ad5672r",  (kernel_ulong_t)&ad5672r_chip_info },
+	{ "ad5674",   (kernel_ulong_t)&ad5674_chip_info },
 	{ "ad5674r",  (kernel_ulong_t)&ad5674r_chip_info },
 	{ "ad5676",   (kernel_ulong_t)&ad5676_chip_info },
 	{ "ad5676r",  (kernel_ulong_t)&ad5676r_chip_info },
+	{ "ad5679",   (kernel_ulong_t)&ad5679_chip_info },
 	{ "ad5679r",  (kernel_ulong_t)&ad5679r_chip_info },
 	{ "ad5681r",  (kernel_ulong_t)&ad5681r_chip_info },
 	{ "ad5682r",  (kernel_ulong_t)&ad5682r_chip_info },
@@ -119,16 +123,24 @@ static const struct spi_device_id ad5686_spi_id[] = {
 	{ "ad5685r",  (kernel_ulong_t)&ad5685r_chip_info },
 	{ "ad5686",   (kernel_ulong_t)&ad5686_chip_info },
 	{ "ad5686r",  (kernel_ulong_t)&ad5686r_chip_info },
+	{ "ad5687",   (kernel_ulong_t)&ad5687_chip_info },
+	{ "ad5687r",  (kernel_ulong_t)&ad5687r_chip_info },
+	{ "ad5689",   (kernel_ulong_t)&ad5689_chip_info },
+	{ "ad5689r",  (kernel_ulong_t)&ad5689r_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad5686_spi_id);
 
 static const struct of_device_id ad5686_of_match[] = {
 	{ .compatible = "adi,ad5310r", .data = &ad5310r_chip_info },
+	{ .compatible = "adi,ad5313r", .data = &ad5338r_chip_info },
+	{ .compatible = "adi,ad5317r", .data = &ad5317r_chip_info },
 	{ .compatible = "adi,ad5672r", .data = &ad5672r_chip_info },
+	{ .compatible = "adi,ad5674",  .data = &ad5674_chip_info },
 	{ .compatible = "adi,ad5674r", .data = &ad5674r_chip_info },
 	{ .compatible = "adi,ad5676",  .data = &ad5676_chip_info },
 	{ .compatible = "adi,ad5676r", .data = &ad5676r_chip_info },
+	{ .compatible = "adi,ad5679",  .data = &ad5679_chip_info },
 	{ .compatible = "adi,ad5679r", .data = &ad5679r_chip_info },
 	{ .compatible = "adi,ad5681r", .data = &ad5681r_chip_info },
 	{ .compatible = "adi,ad5682r", .data = &ad5682r_chip_info },
@@ -139,6 +151,10 @@ static const struct of_device_id ad5686_of_match[] = {
 	{ .compatible = "adi,ad5685r", .data = &ad5685r_chip_info },
 	{ .compatible = "adi,ad5686",  .data = &ad5686_chip_info },
 	{ .compatible = "adi,ad5686r", .data = &ad5686r_chip_info },
+	{ .compatible = "adi,ad5687",  .data = &ad5687_chip_info },
+	{ .compatible = "adi,ad5687r", .data = &ad5687r_chip_info },
+	{ .compatible = "adi,ad5689",  .data = &ad5689_chip_info },
+	{ .compatible = "adi,ad5689r", .data = &ad5689r_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad5686_of_match);
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index fddcc77ab794..bb661d985626 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -296,8 +296,11 @@ DECLARE_AD5683_CHANNELS(ad5683r_channels, 16, 0);
 /* dual-channel */
 DECLARE_AD5338_CHANNELS(ad5337r_channels, 8, 8);
 DECLARE_AD5338_CHANNELS(ad5338r_channels, 10, 6);
+DECLARE_AD5338_CHANNELS(ad5687r_channels, 12, 4);
+DECLARE_AD5338_CHANNELS(ad5689r_channels, 16, 0);
 
 /* quad-channel */
+DECLARE_AD5686_CHANNELS(ad5317r_channels, 10, 6);
 DECLARE_AD5686_CHANNELS(ad5684r_channels, 12, 4);
 DECLARE_AD5686_CHANNELS(ad5685r_channels, 14, 2);
 DECLARE_AD5686_CHANNELS(ad5686r_channels, 16, 0);
@@ -373,6 +376,44 @@ const struct ad5686_chip_info ad5338r_chip_info = {
 };
 EXPORT_SYMBOL_NS_GPL(ad5338r_chip_info, "IIO_AD5686");
 
+const struct ad5686_chip_info ad5687_chip_info = {
+	.channels = ad5687r_channels,
+	.num_channels = 2,
+	.regmap_type = AD5686_REGMAP,
+};
+EXPORT_SYMBOL_NS_GPL(ad5687_chip_info, "IIO_AD5686");
+
+const struct ad5686_chip_info ad5687r_chip_info = {
+	.channels = ad5687r_channels,
+	.int_vref_mv = 2500,
+	.num_channels = 2,
+	.regmap_type = AD5686_REGMAP,
+};
+EXPORT_SYMBOL_NS_GPL(ad5687r_chip_info, "IIO_AD5686");
+
+const struct ad5686_chip_info ad5689_chip_info = {
+	.channels = ad5689r_channels,
+	.num_channels = 2,
+	.regmap_type = AD5686_REGMAP,
+};
+EXPORT_SYMBOL_NS_GPL(ad5689_chip_info, "IIO_AD5686");
+
+const struct ad5686_chip_info ad5689r_chip_info = {
+	.channels = ad5689r_channels,
+	.int_vref_mv = 2500,
+	.num_channels = 2,
+	.regmap_type = AD5686_REGMAP,
+};
+EXPORT_SYMBOL_NS_GPL(ad5689r_chip_info, "IIO_AD5686");
+
+const struct ad5686_chip_info ad5317r_chip_info = {
+	.channels = ad5317r_channels,
+	.int_vref_mv = 2500,
+	.num_channels = 4,
+	.regmap_type = AD5686_REGMAP,
+};
+EXPORT_SYMBOL_NS_GPL(ad5317r_chip_info, "IIO_AD5686");
+
 const struct ad5686_chip_info ad5684_chip_info = {
 	.channels = ad5684r_channels,
 	.num_channels = 4,
@@ -434,6 +475,13 @@ const struct ad5686_chip_info ad5676r_chip_info = {
 };
 EXPORT_SYMBOL_NS_GPL(ad5676r_chip_info, "IIO_AD5686");
 
+const struct ad5686_chip_info ad5674_chip_info = {
+	.channels = ad5674r_channels,
+	.num_channels = 16,
+	.regmap_type = AD5686_REGMAP,
+};
+EXPORT_SYMBOL_NS_GPL(ad5674_chip_info, "IIO_AD5686");
+
 const struct ad5686_chip_info ad5674r_chip_info = {
 	.channels = ad5674r_channels,
 	.int_vref_mv = 2500,
@@ -442,6 +490,13 @@ const struct ad5686_chip_info ad5674r_chip_info = {
 };
 EXPORT_SYMBOL_NS_GPL(ad5674r_chip_info, "IIO_AD5686");
 
+const struct ad5686_chip_info ad5679_chip_info = {
+	.channels = ad5679r_channels,
+	.num_channels = 16,
+	.regmap_type = AD5686_REGMAP,
+};
+EXPORT_SYMBOL_NS_GPL(ad5679_chip_info, "IIO_AD5686");
+
 const struct ad5686_chip_info ad5679r_chip_info = {
 	.channels = ad5679r_channels,
 	.int_vref_mv = 2500,
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index 55f49dbbbd39..e2ed0a2a8ac9 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -94,8 +94,13 @@ extern const struct ad5686_chip_info ad5683r_chip_info;
 /* dual-channel instances */
 extern const struct ad5686_chip_info ad5337r_chip_info;
 extern const struct ad5686_chip_info ad5338r_chip_info;
+extern const struct ad5686_chip_info ad5687_chip_info;
+extern const struct ad5686_chip_info ad5687r_chip_info;
+extern const struct ad5686_chip_info ad5689_chip_info;
+extern const struct ad5686_chip_info ad5689r_chip_info;
 
 /* quad-channel instances */
+extern const struct ad5686_chip_info ad5317r_chip_info;
 extern const struct ad5686_chip_info ad5684_chip_info;
 extern const struct ad5686_chip_info ad5684r_chip_info;
 extern const struct ad5686_chip_info ad5685r_chip_info;
@@ -108,7 +113,9 @@ extern const struct ad5686_chip_info ad5676_chip_info;
 extern const struct ad5686_chip_info ad5676r_chip_info;
 
 /* 16-channel instances */
+extern const struct ad5686_chip_info ad5674_chip_info;
 extern const struct ad5686_chip_info ad5674r_chip_info;
+extern const struct ad5686_chip_info ad5679_chip_info;
 extern const struct ad5686_chip_info ad5679r_chip_info;
 
 /**
diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
index 51cd765d80f3..8fb9da7fde1f 100644
--- a/drivers/iio/dac/ad5696-i2c.c
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -74,10 +74,12 @@ static int ad5686_i2c_probe(struct i2c_client *i2c)
 
 static const struct i2c_device_id ad5686_i2c_id[] = {
 	{ "ad5311r",  (kernel_ulong_t)&ad5311r_chip_info },
+	{ "ad5316r",  (kernel_ulong_t)&ad5317r_chip_info },
 	{ "ad5337r",  (kernel_ulong_t)&ad5337r_chip_info },
 	{ "ad5338r",  (kernel_ulong_t)&ad5338r_chip_info },
 	{ "ad5671r",  (kernel_ulong_t)&ad5672r_chip_info },
 	{ "ad5673r",  (kernel_ulong_t)&ad5674r_chip_info },
+	{ "ad5675",   (kernel_ulong_t)&ad5676_chip_info },
 	{ "ad5675r",  (kernel_ulong_t)&ad5676r_chip_info },
 	{ "ad5677r",  (kernel_ulong_t)&ad5679r_chip_info },
 	{ "ad5691r",  (kernel_ulong_t)&ad5681r_chip_info },
@@ -89,16 +91,19 @@ static const struct i2c_device_id ad5686_i2c_id[] = {
 	{ "ad5695r",  (kernel_ulong_t)&ad5685r_chip_info },
 	{ "ad5696",   (kernel_ulong_t)&ad5686_chip_info },
 	{ "ad5696r",  (kernel_ulong_t)&ad5686r_chip_info },
+	{ "ad5697r",  (kernel_ulong_t)&ad5687r_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ad5686_i2c_id);
 
 static const struct of_device_id ad5686_of_match[] = {
 	{ .compatible = "adi,ad5311r", .data = &ad5311r_chip_info },
+	{ .compatible = "adi,ad5316r", .data = &ad5317r_chip_info },
 	{ .compatible = "adi,ad5337r", .data = &ad5337r_chip_info },
 	{ .compatible = "adi,ad5338r", .data = &ad5338r_chip_info },
 	{ .compatible = "adi,ad5671r", .data = &ad5672r_chip_info },
 	{ .compatible = "adi,ad5673r", .data = &ad5674r_chip_info },
+	{ .compatible = "adi,ad5675",  .data = &ad5676_chip_info },
 	{ .compatible = "adi,ad5675r", .data = &ad5676r_chip_info },
 	{ .compatible = "adi,ad5677r", .data = &ad5679r_chip_info },
 	{ .compatible = "adi,ad5691r", .data = &ad5681r_chip_info },
@@ -110,6 +115,7 @@ static const struct of_device_id ad5686_of_match[] = {
 	{ .compatible = "adi,ad5695r", .data = &ad5685r_chip_info },
 	{ .compatible = "adi,ad5696",  .data = &ad5686_chip_info },
 	{ .compatible = "adi,ad5696r", .data = &ad5686r_chip_info },
+	{ .compatible = "adi,ad5697r", .data = &ad5687r_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad5686_of_match);

-- 
2.43.0


